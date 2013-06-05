<?php

/**
 * Obejto de manipulação de transação
 * autor: Wagner Borba
 */
class TTransacao {

    private $cols = array();
    private $obUser = NULL;
    private $produtos = NULL;
    private $padraovencimento = false;

    /*
     *
     */

    public function __construct() {
        // Checa usuario logado e retona o mesmo
        $this->obUser = new TCheckLogin();
        $this->obUser = $this->obUser->getUser();
    }

    /**
     *
     * param <type> $codigotransacao
     */
    public function getTransacao($codigotransacao, $colunas = "*", $contas = true, $produtos = false) {
        try {

            if (!$codigotransacao) {
                throw new Exception(TMensagem::ERRO_VALOR_INVALIDO);
            }

            $obTDbo = new TDbo(TConstantes::DBTRANSACOES);
            $criteriaTransacao = new TCriteria();
            $criteriaTransacao->add(new TFilter('codigo', '=', $codigotransacao));
            $retTransacao = $obTDbo->select($colunas, $criteriaTransacao);
            $obTransacao = $retTransacao->fetchObject();

            //injeta contas da transação no objeto transação atual
            if ($contas) {
                $obTransacao->contas = $this->getContas($codigotransacao);
            }

            //injeta duplicatas da transação no objeto transação atual
            if ($produtos) {

            }
            return $obTransacao;
        } catch (Exception $e) {
            new setException($e, 2);
        }
    }

	/**
	 * 
	 */
    public function getUnidadeSession(){
            $obHeader = new TSetHeader();
            $headerForm = $obHeader->getHead('79');

            $codigoitem = $headerForm['camposSession']['codigounidade']['valor'];

            return $codigoitem;
    }
	
    /**
     * 
     * @param $codigotransacao
     * @param $update
     */
     public function getTransacaoDG($codigotransacao,$update = false) {
        try {

            if (!$codigotransacao) {
                throw new Exception(TMensagem::ERRO_VALOR_INVALIDO,0);
            }

            $TSetModel = new TSetModel();
            $valorTotal = null;

            $dboTransacao = new TDbo('view_transacoes');
            $critTransacao = new TCriteria();
            $critTransacao->add(new TFilter('codigo', '=', $codigotransacao));
            $retTransacao = $dboTransacao->select('*', $critTransacao);
            $obTransacao = $retTransacao->fetchObject();

            $dboItens = new TDbo('view_transacoes_itens');
            $critItens = new TCriteria();
            $critItens->add(new TFilter('codigotransacao', '=', $codigotransacao));
            $critItens->setProperty('order', 'valortotal');
            $retItens = $dboItens->select('*', $critItens);


            $valorTransacao = NULL;

            if ($obTransacao->indice) {
                $juros = $obTransacao->indice;
            } else {
                $juros = 1;
            }

            while ($obItem = $retItens->fetch()) {
                $obItens[$obItem['codigo']] = $obItem;

                $valorTotal = $valorTotal + $obItens[$obItem['codigo']]['valorunitario'] * $obItem['quantidade'];
                $obItens[$obItem['codigo']]['valortotal'] = $obItens[$obItem['codigo']]['valorunitario'] * $obItem['quantidade'];

                $ultimoCodigo = $obItem['codigo'];

                $valorTransacao = $valorTransacao + $obItens[$obItem['codigo']]['valortotal'] ;
            }

            $valorProdutos = $valorTransacao;

            $transacao = ($valorProdutos + $obTransacao->valorfrete + $obTransacao->valordespesas);
            $excedente =(( $transacao * $juros) - $transacao)+ $obTransacao->valordespesas;



            if($excedente || $juros > 1){
                $valorTransacao = NULL;

                $porcentagem = 100;
                foreach($obItens as $ch => $item){
                    if($ch != $ultimoCodigo){
                        $indice = number_format(($item['valortotal']/($valorProdutos)*100),2,'.','');
                        $porcentagem = $porcentagem - $indice;
                    }else{
                        $indice = $porcentagem;
                    }
                    $rateio = (($obItens[$ch]['valortotal'] + (($indice/100) * $excedente))/ $obItens[$ch]['quantidade'] );


                    $obItens[$ch]['indice'] = $indice . "%";
                    $obItens[$ch]['valorunitario'] = $rateio;
                    $obItens[$ch]['valortotal'] = $obItens[$ch]['valorunitario'] * $obItens[$ch]['quantidade'];

                    $valorTransacao = $valorTransacao + $obItens[$ch]['valortotal'] ;
                }

            }
            $obTransacao->valortotal = $valorTransacao - $obTransacao->valordesconto;


            $nItens = count($obItens);

            if($update){
                $upDbo = new TDbo('dbtransacoes_itens');
                foreach($obItens as $ch => $item){
                    $crit = new TCriteria();
                    $crit->add(new TFilter('codigo','=',$ch));

                    $newArray = array();
                    $newArray['valorunitario'] = $item['valorunitario'];
                    $newArray['valortotal'] = $item['valortotal'];

                    $upDbo->update($newArray, $crit);
                    unset($newArray);
                }
            }

            $dboFormaPag = new TDbo('dbcondicoes_pagamento');
            $critFormaPag = new TCriteria();
            $critFormaPag->add(new TFilter('codigo','=',$obTransacao->codigoformapagamento));

            $retFormaPag = $dboFormaPag->select('*',$critFormaPag);


            $obFormaPag = $retFormaPag->fetchObject();


            $dataCad = explode('/',$obTransacao->datacad);

            $d = $dataCad[0];
            $m = $dataCad[1];
            $Y = $dataCad[2];

            $parcela = number_format(($valorTransacao + $obTransacao->valorfrete - $obTransacao->valordesconto) / $obFormaPag->parcelas , 2 , ',' , '');
            $count = 1;

            $intervalo = $obFormaPag->intervalo;
            while($count <= $obFormaPag->parcelas){
                if($obFormaPag->entrada && $count == 1){
                    $texto .= $count."º Venc.: R$ {$parcela} em " . date('d/m/Y', mktime(0, 0, 0, $m , $d, $Y)) . "; ";
                }else{
                    if($obFormaPag->entrada) {
                        $ct = $count - 1;
                    }else{
                        $ct = $count;
                    }
                    $texto .= $count."º Venc.: R$ {$parcela} em " . date('d/m/Y', mktime(0, 0, 0, $m  , $d + $ct * $intervalo, $Y)) . "; ";
                }
                $count++;
            }

            $texto = preg_replace('/; $/i','.',$texto);

            $obTransacao->itens = $obItens;
            $obTransacao->textocondicaopagamento = $texto;

            return $obTransacao;


        } catch (Exception $e) {
            new setException($e, 2);
        }
    }

    /**
     * Retorna um vetor de objetos contas
     * param <type> $codigotransacao
     */
    public function getContas($codigotransacao, $codigoconta = NULL) {

        try {

            if (!$codigotransacao and !$codigoconta) {
                throw new Exception(TMensagem::ERRO_VALOR_INVALIDO);
            }

            $obTDbo = new TDbo(TConstantes::VIEW_TRANSACOES_CONTAS);
            $criteriaTransacaoContas = new TCriteria();
            
	            if($codigotransacao){
	            	$criteriaTransacaoContas->add(new TFilter('codigotransacao', '=', $codigotransacao));
	            }
	            if($codigoconta){
	            	$criteriaTransacaoContas->add(new TFilter('codigo', '=', $codigoconta));
	            }
            
            $criteriaTransacaoContas->setProperty('order', 'numparcela::integer');
            $retTransacaoContas = $obTDbo->select("*", $criteriaTransacaoContas);

            if(!$codigoconta){  
	            while ($obTransacaoContas = $retTransacaoContas->fetchObject()) {
	                $contas[$obTransacaoContas->codigo] = $obTransacaoContas;
                    $contas[$obTransacaoContas->codigo]->valorpago = $obTransacaoContas->valorpago_credito - $obTransacaoContas->valorpago_debito;
	            }
            }else{
            	$contas = $retTransacaoContas->fetchObject();
                $contas[$contas->codigo]->valorpago = $contas->valorpago_credito - $contas->valorpago_debito;
            }

            return $contas;
            
        } catch (Exception $e) {
            new setException($e, 2);
        }
    }


    /**
     * Retorna um vetor de objetos produtos relacionados a trasação
     * param <type> $codigotransacao
     */
    public function getProdutos($codigotransacao) {

        try {

            if (!$codigotransacao) {
                throw new Exception(TMensagem::ERRO_VALOR_INVALIDO);
            }

            $obTDbo = new TDbo(TConstantes::VIEW_TRANSACOES_PRODUTOS);
            $criteriaTransacaoProdutos = new TCriteria();
            $criteriaTransacaoProdutos->add(new TFilter('codigotransacao', '=', $codigotransacao));
            $retTransacaoProdutos = $obTDbo->select("*", $criteriaTransacaoProdutos);

            while ($obTransacaoProdutos = $retTransacaoProdutos->fetchObject()) {

                $obTDbo = new TDbo(TConstantes::DBPRODUTOS);
                $criteriaProduto = new TCriteria();
                $criteriaProduto->add(new TFilter('codigo', '=', $obTransacaoProdutos->codigoproduto));
                $retProduto = $obTDbo->select('*', $criteriaProduto);
                $obProduto = $retProduto->fetchObject();

                $obProduto->valornominal = $obTransacaoProdutos->valornominal;
                $obProduto->valortotal = $obTransacaoProdutos->valortotal;

                $produtos[$obProduto->codigo] = $obProduto;
            }

            $obTDbo->close();
            return $produtos;
        } catch (Exception $e) {
            new setException($e, 2);
        }
    }
	
    /**
     * 
     * @param unknown_type $codigotransacao
     */
    public function getProdutos_com($codigotransacao) {

        try {

            if (!$codigotransacao) {
                throw new Exception(TMensagem::ERRO_VALOR_INVALIDO);
            }

            $obTDbo = new TDbo('view_transacoes_itens');
            $criteriaTransacaoProdutos = new TCriteria();
            $criteriaTransacaoProdutos->add(new TFilter('codigotransacao', '=', $codigotransacao));
            $retTransacaoProdutos = $obTDbo->select("*", $criteriaTransacaoProdutos);

            while ($obTransacaoProdutos = $retTransacaoProdutos->fetchObject()) {

                $obProduto = null;

                $obProduto->valordescontototal = $obTransacaoProdutos->valordescontototal;
                $obProduto->valortotal = $obTransacaoProdutos->valortotal;

                $produtos[$obTransacaoProdutos->codigo] = $obProduto;
            }

            $obTDbo->close();

            return $produtos;
        } catch (Exception $e) {
            new setException($e, 2);
        }
    }

    /**
     * Calcula a soma total dos produtos na transação
     * param <type> $codigotransacao
     */
    public function getValorTotal($codigotransacao) {
        try {

            //retorna lista de produtos relacionados a transação
            $produtos = $this->getProdutos($codigotransacao);
            $valorTotal = 0;
            if (is_array($produtos)) {
                foreach ($produtos as $codigoproduto => $obProduto) {
                    $valorTotal = ($valorTotal + $obProduto->valortotal);
                }
            }

            //atualiza campo valor total na transação
            $dadosValorTransac['valortotal'] = $valorTotal;
            $obDbo = new TDbo(TConstantes::DBTRANSACOES);
            $criteriaValorTransac = new TCriteria();
            $criteriaValorTransac->add(new TFilter('codigo', '=', $codigotransacao));
            $obDbo->update($dadosValorTransac, $criteriaValorTransac);

            return $valorTotal;
        } catch (Exception $e) {
            new setException($e, 2);
        }
    }
	
    /**
     * 
     * @param $codigotransacao
     */
    public function getValorTotal_com($codigotransacao) {
        try {

            //retorna lista de produtos relacionados a transação
            $produtos = $this->getProdutos_com($codigotransacao);
            $valorTotal = 0;

            if (is_array($produtos)) {
                foreach ($produtos as $codigoproduto => $obProduto) {
                    $valorTotal = ($valorTotal + $obProduto->valortotal);
                    $valorDesconto = ($valorDesconto + $obProduto->valordescontototal);
                }
            }

            //atualiza campo valor total na transação
            $dadosValorTransac['valortotal'] = $valorTotal;
            $dadosValorTransac['valordesconto'] = $valorDesconto;
            $obDbo = new TDbo(TConstantes::DBTRANSACOES);
            $criteriaValorTransac = new TCriteria();
            $criteriaValorTransac->add(new TFilter('codigo', '=', $codigotransacao));
            $obDbo->update($dadosValorTransac, $criteriaValorTransac);

            return $valorTotal;
        } catch (Exception $e) {
            new setException($e, 2);
        }
    }

    /**
     * Instancia a pessoa relacionada a transação
     * param <type> $valor
     */
    public function setPessoa($valor) {
        if (!$valor) {
            new setException('A pessoa relacionada a transação é inválido codigopessoa[' . $valor . '] - TTransacao.class.php');
        }
        $this->cols['codigopessoa'] = $valor;
    }

    /**
     * Instancia o valor nominal da transação
     * param <type> $valor
     */
    public function setValorNominal($valor) {
        if (!$valor) {
            new setException('O valor nominal é inválido - TTransacao.class.php');
        }
        $this->cols['valortotal'] = $valor;
    }

    /**
     * Instancia o valor do desconto total na transação
     * param <type> $valor
     */
    public function setDesconto($valor, $tipoDesconto = "1") {
        if ($valor == "") {
            new setException('O valor do desconto é inválido - TTransacao.class.php');
        }

        if ($tipoDesconto == "2") {
            $this->descontoParcela = $valor;
        } else {
            $this->cols['desconto'] = $valor;
        }
        // $this->cols['valorcorrigido'] = $this->cols['desconto'];
    }

    /**
     * Instancia o valor do acréscimo total na transação
     * param <type> $valor
     */
    public function setAcrescimo($valor) {
        if ($valor == "") {
            new setException('O valor do acrescimo é inválido - TTransacao.class.php');
        }
        $this->cols['acrescimo'] = $valor;
    }

    /**
     * Instancia o codigo do plano de contas da transação
     * param <type> $valor
     */
    public function setPlanoConta($valor) {
        if (!$valor) {
            new setException('O Plano de conta da transação não foi definido.');
        }
        $this->cols['codigoPlanoConta'] = $valor;
    }

    /**
     *
     */
    public function addProduto($produto) {
        if (!is_object($produto)) {
            new setException('O produto passado não é um objeto válido - TTransacao.class.php - [80]');
        }
        $this->produtos[$produto->codigo] = $produto;
    }

    /**
     * Instancia numero de parcelas da transação
     * param  $valor = numero de parcelas
     * param  $formaInternvalo = forma do intervalo - mensal / intervalo
     * param  $intervalo = intervalo caso o tipo seja intervalo
     */
    public function setParcelas($valor, $intervalo = NULL) {
        if (!$valor) {
            new setException('<div >O número de parcelas é inválido - TTransacao.class.php - [93]</div>');
        }
        $this->cols['numparcelas'] = $valor;
        $this->cols['intervaloparcelas'] = $intervalo;
    }

    /**
     * param1 = data base de partida ex: 2005-05-20
     * param2 = dias de intervalo a partir da data base
     */
    public function setVencimento($database, $dias = null) {
        if (!$database) {
            new setException('<div >Os argumentos do vencimento são inválidos - TTransacao.class.php</div>');
        }

        if ($dias) {
            //configura data de venciemento
            $obSetData = new TSetData();
            $venc = $obSetData->calcData($database, $dias, '-');
        } else {
            $venc = $database;
        }
        $this->cols['vencimento'] = $venc;
    }

    /*
     * Instancia padrão de vencimento para as datas
     */

    public function setPadraoVencimento() {
        //$this->cols['padraovencimento'] = true;
        $this->padraovencimento = true;
    }

    /*
     * Instancia data fixa de vencimento
     */

    public function setDataFixa($dataFixa) {
        $this->cols['dataFixaVencimento'] = $dataFixa;
    }

    /**
     * Instancia o tipo de movimento da transação
     * param $valor = Tipo do movimento relacionado a transação C = crédito D = débito
     */
    public function setTipoMovimento($valor) {
        if ($valor != 'D' and $valor != 'C') {
            new setException('<div >O tipo da movimentação é inválida - TTransacao.class.php</div>');
        }
        $this->cols['tipomovimentacao'] = $valor;
    }

    /**
     * Instancia a observação das contas
     * param $valor = texto da observação
     */
    public function setObs($valor) {
        $this->contaObs = $valor;
    }

    /*
     * Calcula o valor corrigido da transacao
     */

    public function setValorCorrigido($valortotal, $desconto, $acrescimo) {

        if ($valortotal) {
            if ($desconto == "") {
                $desconto = 0.00;
            }
            if ($acrescimo == "") {
                $acrescimo = 0.00;
            }
            $this->cols['valorcorrigido'] = ($valortotal - $desconto) + $acrescimo;
        } else {
            new setException(TMensagem::ERRO_VALOR_INVALIDO);
        }
        return $this->cols['valorcorrigido'];
    }

    /*
     * Define o numero de contas a ser gerando na criação da transação
     * independente do número de parcelas
     */

    public function setNumContas($numContas, $setPrimeiraParcela = false) {
        $this->numContas = $numContas;
        $this->setPrimeiraParcela = $setPrimeiraParcela;
    }

    /**
     * Cofingura instroções de pagamento para as contas
     * da transação
     * param <type> $instrucoes
     */
    public function setInstrincoesPagamento($instrucoes) {
        $this->instrucoesPagamento = $instrucoes;
    }

    /**
     * Gera transacao
     * return <type>
     */
    public function run($numContas = NULL) {

        try {

            //define o tipo da transação como transação financeira
            $this->cols['efetivada'] = '1';
            $this->cols['ativo'] = '1';

            $obTDbo = new TDbo(TConstantes::DBTRANSACOES);
            $runTransacao = $obTDbo->insert($this->cols);

            //define as contas a serem geradas pela transação ======================
            $this->addContas($runTransacao['codigo']);
            //======================================================================
            //Adiciona produtos na lista de transações produtos ====================
            if ($this->produtos) {
                foreach ($this->produtos as $codP => $prod) {

                    $colsProd['codigotransacao'] = $runTransacao['codigo'];
                    $colsProd['codigoproduto'] = $prod->codigo;
                    $colsProd['tabelaProduto'] = $prod->tabela;
                    $colsProd['valornominal'] = $prod->valor;
                    $colsProd['ativo'] = '1';

                    $obTDboProduto = new TDbo(TConstantes::DBTRANSACOES_PRODUTOS);
                    $obTProd = $obTDboProduto->insert($colsProd);
                    $colsProd = array();
                }
            }
            //======================================================================
            //gera codigo
            $this->codRegistro = $runTransacao["codigo"];
        } catch (Exception $e) {
            $obTDbo->rollback();
            $obTDboProduto->rollback();
        }
        return $this->codRegistro;
    }

    /*
    * Executa e gerencia criacao de contas da transacao
    */
    public function addContas($codigotransacao, $setAtributos = true) {

        try {
            //Seta os atributos da transação se for solicitado
            if ($setAtributos) {
                $this->setAtributos($codigotransacao);
            }

            if ($codigotransacao and $this->cols['numparcelas'] and $this->cols['codigopessoa'] and $this->cols['tipomovimentacao']) {

                $obTDbo = new TDbo(TConstantes::DBTRANSACOES_CONTAS);
                $crit_check = new TCriteria();
                $crit_check->add(new TFilter('codigotransacao', '=', $codigotransacao));
                $ret_check = $obTDbo->select('codigo', $crit_check);

                //if ($codigo_check = $ret_check->fetchObject()) {
                //    if ($codigo_check->codigo) {
                //        throw new Exception(TMensagem::ERRO_TRANSACAO_CONTAS);
                //    }
                //} else {
                $valorcorrigido = $this->setValorCorrigido($this->cols['valortotal'], $this->cols['desconto'], $this->cols['acrescimo']);
                $valorNominalConta = $valorcorrigido / $this->cols['numparcelas'];

                if ($this->numContas == NULL) {
                    $this->numContas = $this->cols['numparcelas'];
                }

                if (!$this->setPrimeiraParcela) {
                    $this->setPrimeiraParcela = 1;
                }

                $dadosConta['codigopessoa'] = $this->cols['codigopessoa'];
                $dadosConta['tipomovimentacao'] = $this->cols['tipomovimentacao'];
                $dadosConta['codigoplanoconta'] = $this->cols['codigoPlanoConta'];
                $dadosConta['vencimento'] = $this->cols['vencimento'];
                $dadosConta['codigotransacao'] = $codigotransacao;
                $dadosConta['valornominal'] = $valorNominalConta;
                $dadosConta['valorreal'] = $valorNominalConta;
                $dadosConta['instrucoespagamento'] = $this->instrucoesPagamento;
                $dadosConta['ativo'] = '1';

                for ($np = $this->setPrimeiraParcela; $np <= $this->numContas; $np++) {

                    $dadosConta['numparcela'] = $np;
                    $dadosConta['obs'] = $this->contaObs . ' - Parcela número:' . $np;

                    //aplica desconto sobre a parcela se definido
                    if ($this->descontoParcela) {
                        $dadosConta['desconto'] = $this->descontoParcela;
                    }
                    //configura data de venciemento da conta =======================
                    if ($np > 1) {

                        $obSetData = new TSetData();
                        //verifica se o intervalo das parcelas é vazio e atribui uma data fixa para o vencimento
                        if ($this->cols['intervaloparcelas']) {
                            $dadosConta['vencimento'] = $obSetData->calcData($dadosConta['vencimento'], $this->cols['intervaloparcelas'], '-');
                        } elseif ($this->cols['dataFixaVencimento']) {
                            $dadosConta['vencimento'] = $obSetData->calcData($dadosConta['vencimento'], 1, '-', $this->cols['dataFixaVencimento']);
                        } elseif ($this->padraovencimento) {
                            $dt = explode('-', $dadosConta['vencimento']);
                            $mes = date('m', mktime(0, 0, 0, $dt[1] + 1, 1, $dt[0]));
                            $ano = date('Y', mktime(0, 0, 0, $dt[1] + 1, 1, $dt[0]));
                            $dia = cal_days_in_month(CAL_GREGORIAN, $mes, $ano);
                            $dadosConta['vencimento'] = date("Y-m-d", mktime(0, 0, 0, $mes, $dia, $ano));
                        } else {
                            $vencimentoDatafixa = substr($dadosConta['vencimento'], -2);
                            $dadosConta['vencimento'] = $obSetData->calcData($dadosConta['vencimento'], 1, '-', $vencimentoDatafixa);
                        }
                    }
                    //fim Configuração de datas=====================================

                    $obTDbo = new TDbo(TConstantes::DBTRANSACOES_CONTAS);
                    $runConta = $obTDbo->insert($dadosConta);
                    $this->codigoContas[] = $runConta['codigo'];

                    if ($runConta['codigo']) {
                        $retorno = 'Sucesso';
                    }
                }
                //return  $this->codigoContas;
                return $retorno;
                //}
            } else {
                throw new Exception(TMensagem::ERRO_VALOR_NULL);
            }
        } catch (Exception $e) {
            //$obTDbo->rollback();
            new setException($e);
        }
    }

    /**
     * 
     * reconfigura contas
     */
    public function setContas($codigotransacao, $desconto, $acrescimo, $dataBase, $numparcelas, $intervalo = NULL) {

        $obTDbo = new TDbo();

        //seta os atributos da transação
        $this->setAtributos($codigotransacao);

        $obMasc = new TSetMascaras();

        //seta atributos modificados
        $this->setDesconto($desconto);
        $this->setAcrescimo($acrescimo);
        $this->setParcelas($numparcelas, $intervalo);
        $this->setVencimento($obMasc->setDataDb($dataBase));

        //deleta contas antigas
        $obTDbo->setEntidade(TConstantes::DBTRANSACOES_CONTAS);
        if ($obTDbo->delete($codigotransacao, "codigotransacao")) {
            //gera contas
            if ($this->addContas($codigotransacao)) {
                //atualiza informacoes da transacao
                $obTDbo->setEntidade(TConstantes::DBTRANSACOES);
                $criteriaTransacaoUp = new TCriteria();
                $criteriaTransacaoUp->add(new TFilter('codigo', '=', $codigotransacao));
                $retTransacaoUp = $obTDbo->update($this->cols, $criteriaTransacaoUp);

                if ($retTransacaoUp) {
                    $obTDbo->close();
                    echo 'Sucesso';
                }
            }
        }
    }

    /*
    * Seta atributos da transação baseada no codigo da transação
    */
    private function setAtributos($codigotransacao) {

        try {

            //pega informacoes da transacao
            $obTransacao = $this->getTransacao($codigotransacao);

            if ($obTransacao->codigo) {
                //seta atributos
                $this->setPessoa($obTransacao->codigopessoa);
                $this->setDesconto($obTransacao->desconto);
                $this->setAcrescimo($obTransacao->acrescimo);
                $this->setParcelas($obTransacao->numparcelas, $obTransacao->intervaloparcelas);
                $this->setPlanoConta($obTransacao->codigoplanoconta);

                $this->setTipoMovimento($obTransacao->tipomovimentacao);
                $this->setValorNominal($obTransacao->valortotal);

                $obMasc = new TSetMascaras();
                $this->setVencimento($obMasc->setDataDb($obTransacao->vencimento));
                if ($obTransacao->datafixavencimento) {
                    $this->setDataFixa($obTransacao->datafixavencimento);
                }
            } else {
                throw new Exception(TMensagem::ERRO_CODIGO_TRANSACAO_FINAN);
            }
        } catch (Exception $e) {
            new setException($e, 2);
        }
    }

    /**
    * Retorna um vetor com todos os codigos das contas geradas na transação
    * return <type> vetor de codigos das contas geradas
    */
    public function getCodigoContas() {
        return $this->codigoContas;
    }

    /**
    * retorna objeto conta
    * return <type>
    */
    public function getCCredito($cod) {

        $obTDbo = new TDbo(TConstantes::DBTRANSACOES_CONTAS);
        $critCred = new TCriteria();
        $critCred->add(new TFilter("codigo", "=", $cod));
        $runCred = $obTDbo->select("*", $critCred);

        $obCredito = $runCred->fetchObject();

        if ($obCredito) {
            return $obCredito;
        }
    }

    /**
     * Monta elemento div com a visualização da totalização
     * dos produtos da transação
     * param <type> $codigotransacao
     */
    public function viewValorTotal($codigotransacao) {
        try {

            $valorTotal = $this->getValorTotal($codigotransacao);

            $divValorTotal = new TElement('div');
            $divValorTotal->class = "ui-state-highlight";
            $divValorTotal->style = "padding:5px;";
            $divValorTotal->align = "right";
            $divValorTotal->add("Valor Total: R$ " . number_format($valorTotal, 2, ',', '.'));

            //gere campo hiddem para setar a soma do valor
            $campoSoma = new THidden('somaTotalProdutos');
            $campoSoma->setId('somaTotalProdutos');
            $campoSoma->setValue($valorTotal);

            $divValorTotal->add($campoSoma);

            return $divValorTotal;
        } catch (Exception $e) {
            new setException($e, 2);
        }
    }

    /* Visualização do valor total da transação PetrusCOM */

    public function viewValorTotalCom($codigotransacao) {
        try {

            $valorTotal = $this->getValorTotal_com($codigotransacao);

            $divValorTotal = new TElement('div');
            $divValorTotal->class = "ui-state-highlight";
            $divValorTotal->style = "padding:5px;";
            $divValorTotal->align = "right";
            $divValorTotal->add("Valor Total: R$ " . number_format($valorTotal, 2, ',', '.'));

            //gere campo hiddem para setar a soma do valor
            $campoSoma = new THidden('somaTotalProdutos');
            $campoSoma->setId('somaTotalProdutos');
            $campoSoma->setValue($valorTotal);

            $divValorTotal->add($campoSoma);

            return $divValorTotal;
        } catch (Exception $e) {
            new setException($e, 2);
        }
    }

    /**
     * Retorna historico de movimetnacao relativo a conta
     * param <type> $codigoconta
     */
    public function getMovimentacaoConta($codigoconta) {
        $obTDbo = new TDbo(TConstantes::VIEW_TRANSACOES_CONTAS);
        $critConta = new TCriteria();
        $critConta->add(new TFilter("codigo", "=", $codigoconta));
        $runConta = $obTDbo->select("*", $critConta);

        $obConta = $runConta->fetchObject();

        if ($obConta) {
            $obTDbo_contas = new TDbo(TConstantes::VIEW_CAIXA);
            $crit_contas = new TCriteria();
            $crit_contas->add(new TFilter("codigoconta", "=", $obConta->codigo));
            $crit_contas->add(new TFilter("ativo", "=", '1'));
            $run_contas = $obTDbo_contas->select("*", $crit_contas);

            while ($movimentacaoConta = $run_contas->fetchObject()) {
                $obConta->movimentacoes[] = $movimentacaoConta;
            }

            return $obConta;
        } else {
            return null;
        }
    }

    /**
     * Retorna objeto html com historico de movimentacao relativo a conta
     * param <type> $codigoconta
     */
    public function viewMovimentacaoConta($codigoconta) {
        $obConta = $this->getMovimentacaoConta($codigoconta);
        if ($obConta) {
            $lista = new TDataGrid();

            $lista->addColumn(new TDataGridColumn('codigomovimentacao', 'Movimentação', 'center', '35%'));
            $lista->addColumn(new TDataGridColumn('formapag', 'Forma de Pagamento', 'center', '35%'));
            $lista->addColumn(new TDataGridColumn('tipomovimentacao', 'Tipo', 'center', '10%'));
            $lista->addColumn(new TDataGridColumn('valorentrada', 'Valor', 'center', '10%'));
            $lista->addColumn(new TDataGridColumn('datapag', 'Data', 'center', '10%'));
            $lista->createModel('100%');

            $TSetModel = new TSetModel();

            if ($obConta->movimentacoes) {
                foreach ($obConta->movimentacoes as $ch => $vl) {
                    $tempDisc['codigomovimentacao'] = $vl->codigo;
                    $tempDisc['formapag'] = $vl->formapag;
                    $tempDisc['tipomovimentacao'] = $vl->tipomovimentacao;
                    $tempDisc['valorentrada'] = $TSetModel->setValorMonetario($vl->valorentrada);
                    $tempDisc['datapag'] = $vl->datacad;


                    $lista->addItem($tempDisc);
                }
            }
            $retorno = new TElement("div");
            $retorno->add($lista);
            return $retorno;
        }
    }
    
    /*
    * botão da lista 447 responsavel pela baixa multipla de parcelas
    */
    public function botaoBaixarConta($codigo, $idForm) {

        $divq = new TElement('div');
        $divq->id = 'ret_setBaixaContas';
        $button = new TElement('input');
        $button->id = "setBaixaContas";
        $button->type = "button";
        $button->onclick = "setBaixaContasMultiplas('ret_setBaixaContas','$idForm')";
        $button->class = "ui-state-default ui-corner-all";
        $button->style = "font-weight: bolder;";
        $button->title = 'Baixar as Contas selecionadas';
        $button->value = "Baixar as Contas selecionadas";

        $div = new TElement('div');
        $div->style = "text-align: center; padding: 5px;";
        $div->class = "ui-widget-content";
        $div->add($divq);
        $div->add($button);
        return $div;
    }
    
    /**
     * 
     * @param unknown_type $idForm
     */
    public function baixaContasMultiplas($idForm){
    
        try {
        	
            //$TProduto = new TProduto();

            $obHeader = new TSetHeader();
            $headerForm = $obHeader->getHead('477');
            $listaSelecao = $headerForm['listaSelecao'];
            
	        if($listaSelecao){
	        	
	        	//objeto caixa
	        	$obCaixa = new TCaixa();
	        	$nBaixas = 0;
	        	foreach($listaSelecao as $registro){
	        		
	        		$registro = json_decode($registro);
	        		$conta = $this->getContas("", $registro[0]);
	        		
	        		//valida valor pago
	        		if($registro[1] == ""){
	        			throw new ErrorException("O campo [Valor Pago] deve ser preenchido.", 2);
	        		}
	        		
	        		if($conta){
	        			
	        			$fatorpg = ($conta->valorreal - $registro[1]);
	        			if($fatorpg >= 0){
	        				$conta->desconto = $fatorpg;
	        			}elseif($fatorpg < 0){
	        				$conta->multaacrecimo = abs($fatorpg);
	        			}
	        			$formapagamento = 'Dinheiro';
	        			$contacaixa = '10003185-585'; //Códico da conta caixa - Conta bancaria

	        			$obCaixa->baixaContaCaixa($conta->codigo, $registro[1], $conta->desconto, $conta->multaacrecimo, $conta->codigo, $formapagamento, $contacaixa);
	        			$nBaixas++;
	        		}

	        	}
	        	
	        	echo $nBaixas;
	            
	        }else {
	           throw new ErrorException("É necessário escolher ao menos uma conta para baixar.", 2);
	        }
	        
        } catch (Exception $e) {
            new setException($e, 2);
        }	
    }
    
  	/**
     * Gera o campo de desconto para a lista de contas a receber/pagar
     * @param unknown_type $codigoconta
     */
/*    public function campoDescontoConta($valorCampo){
    	
    	$obCampo = new TEntry('desconto');
    	$obCampo->setId('desconto'.$valorCampo);
    	$obCampo->setValue($valorCampo);
    	//$obCampo->setProperty('disabled','disabled');
    	$obCampo->setSize('80');
    	
    	return $obCampo;
    }
    */
    /**
     * Gera o campo do valor pago para a lista de contas a receber/pagar
     * @param unknown_type $codigoconta
     */
    public function campoValorPagoConta($valorCampo){
    	
    	$obCampo = new TEntry('valorpago');
    	$obCampo->setId('valorpago');
    	$obCampo->setValue($valorCampo);
    	//$obCampo->setProperty('disabled','disabled');
    	$obCampo->setSize('80');
    	
    	return $obCampo;
    }

    /*
    * Apendice da lista 352 responsavel pela negociação de parcelas
    */
    public function apendiceContasNegociacao($codigo, $idForm) {

        $divq = new TElement('div');
        $divq->id = 'ret_setContasNegociacao';
        $button = new TElement('input');
        $button->id = "setContasNegociaca";
        $button->type = "button";
        $button->onclick = "setContasNegociacao('ret_setContasNegociacao','$idForm')";
        $button->class = "ui-state-default ui-corner-all";
        $button->style = "font-weight: bolder;";
        $button->title = 'Negociar as Contas selecionadas';
        $button->value = "Negociar as Contas selecionadas";

        $div = new TElement('div');
        $div->style = "text-align: center; padding: 5px;";
        $div->class = "ui-widget-content";
        $div->add($divq);
        $div->add($button);
        return $div;
    }

    /**
     * Efetivação da negociação
     * @param $idForm = ID do formulário em questão.
     */
    public function setContasNegociacao($idForm) {
        try {
            $TProduto = new TProduto();

            $obHeader = new TSetHeader();
            $headerForm = $obHeader->getHead('210');
            $listaSelecao = $headerForm['listaSelecao'];
            
            if (count($listaSelecao)) {
            	
                foreach ($listaSelecao as $ch => $vl) {
                    $listaSelecao[$ch] = $TProduto->createProduto($ch, 'dbtransacoes_contas');
                    $valorTotal = $valorTotal + $listaSelecao[$ch]['valor'];
                }

                $crit = new TCriteria();
                $crit->add(new TFilter('codigo', '=', $headerForm['codigoPai']));

                $dbotransacao = new TDbo(TConstantes::DBTRANSACOES);
                $retTransacao = $dbotransacao->select('codigo,codigopessoa,codigoplanoconta,tipomovimentacao', $crit);

                $obTransacao = $retTransacao->fetchObject();
                
                $transacao = array();
                $transacao['codigopessoa'] = $obTransacao->codigopessoa;
                $transacao['codigoplanoconta'] = $obTransacao->codigoplanoconta;
                $transacao['tipomovimentacao'] = $obTransacao->tipomovimentacao;
                $transacao['valortotal'] = $valorTotal;
                $transacao['ativo'] = '1';

                $transaction = new TDbo();
                $transaction->setEntidade(TConstantes::DBTRANSACOES);

                $retTransacao = $transaction->insert($transacao);

                if ($retTransacao['codigo']) {

                    $transaction->setEntidade("dbalunos_transacoes");
                    if ($transaction->checkEntidade("dbalunos_transacoes")) {
                        $retTransacaoAluno = $transaction->select('codigoaluno', $crit);

                        if ($transacaoAluno = $retTransacaoAluno->fetchObject()) {
                            if ($transacaoAluno->codigoaluno != null) {
                                $insertTransacAluno['ativo'] = 1;
                                $insertTransacAluno['codigotransacao'] = $retTransacao['codigo'];
                                $insertTransacAluno['codigoaluno'] = $transacaoAluno->codigoaluno;

                                $transaction->setEntidade("dbalunos_transacoes");
                                $transaction->insert($insertTransacAluno);
                            }
                        }
                    }

                    $transaction->setEntidade(TConstantes::DBTRANSACOES_PRODUTOS);

                    $critUpdate = new TCriteria();
                    foreach ($listaSelecao as $chP => $prod) {
                        $toInsert['codigotransacao'] = $retTransacao['codigo'];
                        $toInsert['codigoproduto'] = $prod['codigo'];
                        $toInsert['tabelaproduto'] = $prod['tabela'];
                        $toInsert['valornominal'] = $prod['valor'];
                        $toInsert['ativo'] = '1';

                        $retInsert = $transaction->insert($toInsert);
                        $filtro = new Tfilter('codigo', '=', $chP);
                        $filtro->tipoFiltro = 2;
                        $critUpdate->add($filtro, 'OR');
                        if (!$retInsert) {
                            throw new ErrorException("Não foi possível concluir. A ação foi cancelada.", 1);
                        }
                    }
                    
                    $transaction->setEntidade(TConstantes::DBTRANSACOES_CONTAS);
                    $up = $transaction->update(array('statusconta' => '6'), $critUpdate);
                    if ($up) {
                        $transaction->commit();
                        return $retTransacao['codigo'];
                    } else {
                        throw new ErrorException("Impossivel concluir.", 1);
                    }
                }
            } else {
                throw new ErrorException("É necessário escolher ao menos uma conta para negociação.", 1);
            }
        } catch (Exception $e) {
            new setException($e, 2);
        }
    }

    /*
     * Função para interrupção de transações abertas
     *
     * condição:
     *      1 - Apenas anulando as parcelas abertas não vencidas
     *      2 - Mantem a próxima parcela em aberto e anula o restante
     *      3 - Gera conta com calculo proporcional referente ao mês atual
     *
     */
    public function fechaTransacao($codigoTransacao, $condicao = '1') {
        try {
            if ($codigoTransacao) {
                $transacao = $this->getTransacao($codigoTransacao);
                if (count($transacao->contas)) {
                    if ($condicao == '1') {
                        $dbo = new TDbo();
                        $dbo->setEntidade(TConstantes::DBTRANSACOES_CONTAS);

                        $crit = new TCriteria();
                        $filtro0 = new TFilter('codigotransacao', '=', $transacao->codigo);
                        $filtro0->tipoFiltro = 1;
                        $filtro1 = new TFilter('vencimento', '>', date('Y-m-d'));
                        $filtro1->tipoFiltro = 1;
                        $crit->add($filtro0, 'AND');
                        $crit->add($filtro1, 'AND');
                        $filtro2 = new TFilter('statusconta', '=', '1');
                        $filtro2->tipoFiltro = 2;
                        $filtro3 = new TFilter('statusconta', '=', '5');
                        $filtro3->tipoFiltro = 2;
                        $crit->add($filtro2, 'OR');
                        $crit->add($filtro3, 'OR');


                        $ret = $dbo->update(array('statusconta' => '7'), $crit);

                        if ($dbo->commit()) {
                            $crit_select = new TCriteria();
                            $crit_select->add(new TFilter('statusconta', '=', '7'), 'AND');
                            $crit_select->add(new TFilter('codigotransacao', '=', $transacao->codigo), 'AND');
                            $ret_sum = $dbo->select('sum(valorreal) saldo', $crit_select);
                            $obSaldo = $ret_sum->fetchObject();

                            $TSetModel = new TSetModel();
                            $saldo = $TSetModel->setValorMonetario($obSaldo->saldo);
                            $div = new TElement('div');
                            $div->class = 'ui-corner-all ui-state-highlight';
                            $div->add('<b>Transação finalizada.</b><br/>Saldo anulado: <b>' . $saldo . '</b>');
                        } else {
                            throw new ErrorException("Não foi possivel concluir a operação, tente novamente.");
                        }
                    } elseif ($condicao == '2') {
                        $dbo = new TDbo();
                        $dbo->setEntidade(TConstantes::DBTRANSACOES_CONTAS);

                        $crit = new TCriteria();
                        $filtro0 = new TFilter('codigotransacao', '=', $transacao->codigo);
                        $filtro0->tipoFiltro = 1;
                        $filtro1 = new TFilter('vencimento', '>', date('Y-m-d'));
                        $filtro1->tipoFiltro = 1;
                        $crit->add($filtro0, 'AND');
                        $crit->add($filtro1, 'AND');
                        $filtro2 = new TFilter('statusconta', '=', '1');
                        $filtro2->tipoFiltro = 2;
                        $filtro3 = new TFilter('statusconta', '=', '5');
                        $filtro3->tipoFiltro = 2;
                        $crit->add($filtro2, 'OR');
                        $crit->add($filtro3, 'OR');
                        $filtro4 = new TFilter('numparcela', '!=', '(select min(numparcela) from dbtransacoes_contas t2 where t2.codigotransacao = \'' . $transacao->codigo . '\' and (statusconta = \'1\' or statusconta = \'5\') and vencimento > \'' . date('Y-m-d') . '\')');
                        $filtro4->tipoFiltro = 1;
                        $crit->add($filtro4, 'AND');

                        $ret = $dbo->update(array('statusconta' => '7'), $crit);

                        if ($dbo->commit()) {
                            $crit_select = new TCriteria();
                            $crit_select->add(new TFilter('statusconta', '=', '7'), 'AND');
                            $crit_select->add(new TFilter('codigotransacao', '=', $transacao->codigo), 'AND');
                            $ret_sum = $dbo->select('sum(valorreal) saldo', $crit_select);
                            $obSaldo = $ret_sum->fetchObject();

                            $TSetModel = new TSetModel();
                            $saldo = $TSetModel->setValorMonetario($obSaldo->saldo);
                            $div = new TElement('div');
                            $div->class = 'ui-corner-all ui-state-highlight';
                            $div->add('<b>Transação finalizada.</b><br/>Saldo anulado: <b>' . $saldo . '</b>.<br/> ');
                        } else {
                            throw new ErrorException("Não foi possivel concluir a operação, tente novamente.");
                        }
                    } elseif ($condicao == '3') {
                        //Falta processo com relação às sequencias de parcelas

                        $dbo = new TDbo();
                        $dbo->setEntidade(TConstantes::DBTRANSACOES_CONTAS);

                        $crit = new TCriteria();
                        $filtro0 = new TFilter('codigotransacao', '=', $transacao->codigo);
                        $filtro0->tipoFiltro = 1;
                        $filtro1 = new TFilter('vencimento', '>', date('Y-m-d'));
                        $filtro1->tipoFiltro = 1;
                        $crit->add($filtro0, 'AND');
                        $crit->add($filtro1, 'AND');
                        $filtro2 = new TFilter('statusconta', '=', '1');
                        $filtro2->tipoFiltro = 2;
                        $filtro3 = new TFilter('statusconta', '=', '5');
                        $filtro3->tipoFiltro = 2;
                        $crit->add($filtro2, 'OR');
                        $crit->add($filtro3, 'OR');
                        $filtro4 = new TFilter('numparcela', '!=', '(select min(numparcela) from dbtransacoes_contas t2 where t2.codigotransacao = \'' . $transacao->codigo . '\' and (statusconta = \'1\' or statusconta = \'5\') and vencimento > \'' . date('Y-m-d') . '\')');
                        $filtro4->tipoFiltro = 1;
                        $crit->add($filtro4, 'AND');

                        $ret = $dbo->update(array('statusconta' => '7'), $crit);

                        if ($dbo->commit()) {
                            $crit_select = new TCriteria();
                            $crit_select->add(new TFilter('statusconta', '=', '7'), 'AND');
                            $crit_select->add(new TFilter('codigotransacao', '=', $transacao->codigo), 'AND');
                            $ret_sum = $dbo->select('sum(valorreal) saldo', $crit_select);
                            $obSaldo = $ret_sum->fetchObject();

                            $TSetModel = new TSetModel();
                            $saldo = $TSetModel->setValorMonetario($obSaldo->saldo);
                            $div = new TElement('div');
                            $div->class = 'ui-corner-all ui-state-highlight';
                            $div->add('<b>Transação finalizada.</b><br/>Saldo anulado: <b>' . $saldo . '</b>.<br/> ');
                        } else {
                            throw new ErrorException("Não foi possivel concluir a operação, tente novamente.");
                        }
                    } else {
                        throw new ErrorException("A condição escolhida para encerrar a transação não é válida.");
                    }
                } else {
                    $div = new TElement('div');
                    $div->class = 'ui-corner-all ui-state-highlight';
                    $div->add('<b>Transação finalizada.</b><br/> Nenhuma conta restante ou alterada.');
                }

                return $div;
            }
        } catch (Exception $e) {
            new setException($e);
        }
    }
	
    /**
     * 
     * @param unknown_type $idForm
     */
    public function reservaProduto($idForm) {
        try {
            $obHeader = new TSetHeader();
            $headerForm = $obHeader->getHead($idForm);

            $codigoitem = $headerForm['codigo'];

            $tdbo = new TDbo('dbtransacoes_itens');
            $crit = new TCriteria();
            $crit->add(new TFilter('codigo', '=', $codigoitem));
            $ret = $tdbo->select('codigoproduto,quantidade,valorunitario,valordesconto,codigotransacao', $crit);

            $obitem = $ret->fetchObject();

            if ($obitem) {
                $qtdeDbo = new TDbo('view_produtos');
                $qtdeCrit = new TCriteria();
                $qtdeCrit->add(new TFilter('codigo', '=', $obitem->codigoproduto));
                $qtdeRet = $qtdeDbo->select('quantidadedisponivel', $qtdeCrit);
                $obQtde = $qtdeRet->fetchObject();

                if ($obQtde->quantidadedisponivel > $obitem->quantidade) {
                    $insert['codigoproduto'] = $obitem->codigoproduto;
                    $insert['quantidade'] = $obitem->quantidade;
                    $insert['valorunitario'] = ($obitem->valorunitario - $obitem->valordesconto);
                    $insert['codigotipomovimentacao'] = '10000160-260';
                    $insert['codigotransacaoitem'] = $codigoitem;
                    $insert['ativo'] = 1;

                    $dbo_insert = new TDbo('dbprodutos_movimentacao');
                    $dbo_insert->insert($insert);
                    return true;
                } else {
                    $tdbo = new TDbo('dbtransacoes_itens');
                    $tdbo->delete($codigoitem);
                    throw new ErrorException("A quantidade desejada é maior que a quantidade em estoque.");
                }
            } else {
                throw new ErrorException("Falha na reserva do item, tente novamente.");
            }
        } catch (Exception $e) {
            new setException($e);
        }
    }
	
    /**
     * 
     * @param $idForm
     */
    public function reservaProdutoDG($idForm) {
        try {
            $obHeader = new TSetHeader();
            $headerForm = $obHeader->getHead($idForm);

            $codigoitem = $headerForm['codigo'];

            $tdbo = new TDbo('dbtransacoes_itens');
            $crit = new TCriteria();
            $crit->add(new TFilter('codigo', '=', $codigoitem));
            $ret = $tdbo->select('codigoprodutounidade,quantidade,valorunitario,valordesconto,codigotransacao', $crit);

            $obitem = $ret->fetchObject();

            if ($obitem) {
                $tdboCheck = new TDbo('dbtransacoes_itens');
                $critCheck = new TCriteria();
                $critCheck->add(new TFilter('codigoprodutounidade', '=', $obitem->codigoprodutounidade));
                $critCheck->add(new TFilter('codigotransacao', '=', $obitem->codigotransacao));
                $critCheck->add(new TFilter('codigo', '!=', $codigoitem));
                $retCheck = $tdboCheck->select('codigo', $critCheck);
                $obCheck = $retCheck->fetchObject();

                if (!$obCheck->codigo) {
                    $qtdeDbo = new TDbo('view_tab_produto');
                    $qtdeCrit = new TCriteria();
                    $qtdeCrit->add(new TFilter('codigoprodutounidade', '=', $obitem->codigoprodutounidade));
                    $qtdeRet = $qtdeDbo->select('quantidadedisponivel,quantidadereservada,unidademedida', $qtdeCrit);
                    $obQtde = $qtdeRet->fetchObject();

                    if (($obQtde->quantidadedisponivel) >= $obitem->quantidade) {
                        $insert['codigoprodutounidade'] = $obitem->codigoprodutounidade;
                        $insert['quantidade'] = $obitem->quantidade;
                        $insert['valorunitario'] = ($obitem->valorunitario - $obitem->valordesconto);
                        $insert['codigotipomovimentacao'] = '10000160-260';
                        $insert['codigotransacaoitem'] = $codigoitem;
                        $insert['ativo'] = '1';

                        $check = new TDbo('dbprodutos_movimentacao');
                        $checkCrit = new TCriteria();
                        $checkCrit->add(new TFilter('codigotransacaoitem','=',$codigoitem));
                        $retCheck = $check->select('codigo',$checkCrit);
                        $obCheck = $retCheck->fetchObject();

                        if($obCheck->codigo){
                            $dbo_update = new TDbo('dbprodutos_movimentacao');
                            $checkUpdate = new TCriteria();
                            $checkUpdate->add(new TFilter('codigo','=',$obCheck->codigo));
                            $dbo_update->update($insert, $checkUpdate);
                        }else{
                            $dbo_insert = new TDbo('dbprodutos_movimentacao');
                            $dbo_insert->insert($insert);
                        }
                        //$novaQtde['quantidadereservada'] = $obQtde->quantidadereservada + $obitem->quantidade;

                        //$qtdeDbo = new TDbo('tab_produto');
                        //$qtdeCrit = new TCriteria();
                        //$qtdeCrit->add(new TFilter('codigo', '=', $obitem->codigoproduto));
                        //$qtdeDbo->update($novaQtde, $qtdeCrit);
                        return true;
                    } else {
                        $tdbo = new TDbo('dbtransacoes_itens');
                        $tdbo->delete($codigoitem);
                        throw new ErrorException("A quantidade desejada está indisponivel.<br/>Há atualmente {$obQtde->quantidadedisponivel} {$obQtde->unidademedida}(s) em estoque.");
                    }
                } else {
                    $tdbo = new TDbo('dbtransacoes_itens');
                    $tdbo->delete($codigoitem);
                    throw new ErrorException("O produto escolhido já foi relacionado ao pedido.");
                }
            } else {
                throw new ErrorException("Falha na reserva do item, tente novamente.");
            }
        } catch (Exception $e) {
            new setException($e, 0);
        }
    }
	/**
	 * 
	 * @param unknown_type $idForm
	 */
    public function getTotalProdutosDG($idForm) {

        $lucro = null;
        $valorTotalProdutos = null;

        $obHeader = new TSetHeader();
        $headerForm = $obHeader->getHead($idForm);
        $codigotransacao = $headerForm['codigo'];

        $codigopessoa = $this->obUser->codigopessoa;

        $dbo = new TDbo('dbtransacoes_itens');
        $crit = new TCriteria();
        $crit->add(new TFilter('codigotransacao', '=', $codigotransacao));
        $ret = $dbo->select('codigoprodutounidade,valortotal,quantidade', $crit);

        while ($obItem = $ret->fetchObject()) {
            $valorTotalProdutos = $valorTotalProdutos + $obItem->valortotal;
            $array[$obItem->codigoprodutounidade] = $array[$obItem->codigoprodutounidade] + $obItem->quantidade;
        }

        $dboProd = new TDbo('view_tab_produto');
        $critProd = new TCriteria();
        foreach ($array as $ch => $vl) {
            $critProd->add(new TFilter('codigoprodutounidade', '=', $ch),'OR');
        }

        $retProd = $dboProd->select('codigoprodutounidade,lucro', $critProd);

        while ($obProd = $retProd->fetchObject()) {
            $lucro = $lucro + $obProd->lucro * $array[$obProd->codigoprodutounidade];
        }

        $dboPessoa = new TDbo('dbpessoas_funcionarios');
        $critPessoa = new TCriteria();
        $critPessoa->add(new TFilter('codigopessoa', '=', $codigopessoa));
        $retPessoa = $dboPessoa->select('limitedesconto', $critPessoa);
        $obPessoa = $retPessoa->fetchObject();

        return $valorTotalProdutos . "@@" . number_format(($lucro * $obPessoa->limitedesconto) / 100, 4, '.', '');

    }
	
    /**
     * 
     * @param $idForm2
     * @param $idForm
     */
    public function viewOrcamento($idForm2, $idForm) {

        $obHeader = new TSetHeader();
        $headerForm = $obHeader->getHead($idForm);
        $codigoOrcamento = $headerForm['codigo'];

        $div = new TElement('div');
        $div->add('<span class="tlabel"> Porcentagem de Acrescimo:</span><input id="jurosOrcamento" class="ui-state-default ui_mascara_valor ui-state-hover" alteravel="1" name="jurosOrcamento" value="0" type="text" style="margin-top: 2px; margin-right: 2px; margin-bottom: 2px; margin-left: 4px; font-size: 11px; border-top-left-radius: 3px 3px; border-top-right-radius: 3px 3px; border-bottom-right-radius: 3px 3px; border-bottom-left-radius: 3px 3px; " masked="masked">');
        $div->add('<input id="imprimirOrcamento" name="imprimirOrcamento" onclick="imprimiOrcamento(\'' . $codigoOrcamento . '\')" type="button" value="Imprimir" class="ui-state-default ui-corner-all botaosalvar" style="margin-top: 2px; padding-left: 10px; padding-right: 10px; padding-top: 2px; padding-bottom: 2px; margin-right: 2px; margin-bottom: 2px; margin-left: 4px; font-size: 11px; border-top-left-radius: 3px 3px; border-top-right-radius: 3px 3px; border-bottom-right-radius: 3px 3px; border-bottom-left-radius: 3px 3px; cursor: pointer; ">');

        return $div;
    }
	
    /**
     * 
     * @param $idForm
     */
    public function efetivaPedido($idForm) {

        try {
            $obHeader = new TSetHeader();
            $headerForm = $obHeader->getHead($idForm);
            $codigoTransacao = $headerForm['codigo'];

            $transacao['codigotipotransacao'] = "10000543-643";
            $transacao['datacad'] = date('Y-m-d');

            $itens['codigotipomovimentacao'] = '10000159-259';

            $dboTransacoes = new TDbo('dbtransacoes');

            $critTransacoes = new TCriteria();
            $critTransacoes->add(new TFilter('codigo', '=', $codigoTransacao));

            $dboTransacoes->update($transacao, $critTransacoes);

            $dboItens = new TDbo('dbtransacoes_itens');

            $critItens = new TCriteria();
            $critItens->add(new TFilter('codigotransacao', '=', $codigoTransacao));

            $retItens = $dboItens->select('codigo', $critItens);

            $critMovimentacoes = new TCriteria();
            while ($obItem = $retItens->fetchObject()) {
                $critMovimentacoes->add(new TFilter('codigotransacaoitem', '=', $obItem->codigo));
            }

            $dboMovimentacoes = new TDbo('dbprodutos_movimentacao');

            $dboMovimentacoes->update($itens, $critMovimentacoes);

            $TTransacao = new TTransacao();
            $TTransacao->getTransacaoDG($codigoTransacao, false);
        } catch (Exception $e) {

        }
    }
    
    public function getDescontoEspecial(){
    	
    }
    
    /**
     * 
     * @param $codigoConta
     */
    public function getTextoConvenios($codigoConta) {
    	
        $dboConta = new TDbo(TConstantes::DBTRANSACOES_CONTAS);
        $criteriaConta = new TCriteria();
        $criteriaConta->add(new TFilter('codigo','=',$codigoConta));
        $retConta = $dboConta->select("*", $criteriaConta);
        $obConta = $retConta->fetchObject();
	
        $valorConta = $obConta->valorreal;
        
        $dt = explode("-", $obConta->vencimento);
        $mesVencimento = $dt[1] . "/" . $dt[0];
        $diaVencimento = $dt[2];

        $transacs = new TDbo('dbtransacoes_convenios');
    	$crit = new TCriteria();
        $crit->add(new TFilter('codigotransacao', '=', $obConta->codigotransacao));
        $retTransacs = $transacs->select('codigoconvenio', $crit);

        $TConvenios = new TConvenios();
        $descontos = null;

        while ($obTransacoes = $retTransacs->fetchObject()) {
            $arrayConvenios[] = $obTransacoes->codigoconvenio;
        }
        $texto = $TConvenios->getTextoConvenios($arrayConvenios,$obConta);
        return $texto;
    }

    public function getValorDescontoConvenio($codigoConta, $data){
        try  {
            if(!$data)
                $data = time();
            $dboConta = new TDbo(TConstantes::DBTRANSACOES_CONTAS);
            $criteriaConta = new TCriteria();
            $criteriaConta->add(new TFilter('codigo','=',$codigoConta));
            $retConta = $dboConta->select("*", $criteriaConta);
            $obConta = $retConta->fetchObject();
        
            $valorConta = $obConta->valorreal;
            
            $dt = Date("-", $obConta->vencimento);
            $dataVencimento = mktime(23,59,59,$dt[1],$dt[2],$dt[0]);

            $transacs = new TDbo('dbtransacoes_convenios');
            $crit = new TCriteria();
            $crit->add(new TFilter('codigotransacao', '=', $obConta->codigotransacao));
            $retTransacs = $transacs->select('codigoconvenio', $crit);

            $TConvenios = new TConvenios();

            $listaConvenios = array();
            while ($obTransacoes = $retTransacs->fetchObject()) {
                $listaConvenios[] = $obTransacoes->codigoconvenio;
            }

            if($dataVencimento >= time()){
                return $TConvenios->calculaDesconto($listaConvenios,$valorreal,$data);
            } else {
                return 0;                
            }

        } catch (Exception $e) {
            new setException($e);
        }
    }

}