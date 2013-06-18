<?php

/*
 * Metodos de aplicação de regras de negocios do caixa
 */

class TCaixa {

    private $obTDbo = NULL;
    private $obsession = NULL;
    private $mascara = NULL;

    public function __construct() {
        //Retorna Usuario logado===================================
        $this->obUser = new TCheckLogin();
        $this->obUser = $this->obUser->getUser();
        //=========================================================

        $this->obTDbo = new TDbo();


        $this->obsession = new TSession();
        $this->mascara = new TSetMascaras();
    }
    
    public function apendiceMovimentosEstorno($codigo, $idForm) {
    
    	$divq = new TElement('div');
    	$divq->id = 'ret_setMovimentosEstorno';
    	$button = new TElement('input');
    	$button->id = "setMovimentosEstorno";
    	$button->type = "button";
    	$button->onclick = "setMovimentosEstorno('ret_setMovimentosEstorno','$idForm')";
    	$button->class = "ui-state-default ui-corner-all";
    	$button->style = "font-weight: bolder;";
    	$button->title = 'Estornar Movimentos selecionados';
    	$button->value = "Estornar Movimentos selecionados";
    
    	$div = new TElement('div');
    	$div->style = "text-align: center; padding: 5px;";
    	$div->class = "ui-widget-content";
    	$div->add($divq);
    	$div->add($button);
    	return $div;
    }
    /**
     * Efetivação do estorno
     * @param $idForm = ID do formulário em questão.
     */
    public function setMovimentosEstorno($idForm) {
    	try {
    		$transaction = new TDbo();
    		
    		$obHeader = new TSetHeader();
    		$headerForm = $obHeader->getHead('481');
    		$listaSelecao = $headerForm['listaSelecao'];
    		
    		$transaction->setEntidade(TConstantes::DBTRANSACOES_CONTAS);
    		$critConta = new TCriteria();
    		$critConta->add(new TFilter('codigo','=',$headerForm['codigoPai']));
    		$conta = $transaction->select('*',$critConta)->fetchObject();
    		
    		$valorTotal = 0;
    		$obs = "Estorno do(s) Movimento(s):";
    		if (count($listaSelecao)) {
    			 $criterioUpdateMov = new TCriteria();
    			foreach ($listaSelecao as $ch => $vl) {
    				$filtro = new Tfilter('codigo', '=', $vl);
    				$filtro->setTipoFiltro('codigos');
    				$criterioUpdateMov->add($filtro, 'OR');
    			}
    			
    			$transaction->setEntidade(TConstantes::DBCAIXA);
    			$movimentos = $transaction->select('*',$criterioUpdateMov);
    			
    			while($mov = $movimentos->fetchObject()){
    				if($mov->tipomovimentacao == 'C'){
    					$valorTotal = $valorTotal - $mov->valorpago;
    				}else{
    					$valorTotal = $valorTotal + $mov->valorpago;
    				}
    				
    				$obs .= " \r\n\t - {$mov->codigo};";
    			}  			
    			    
    			if(!$transaction->update(array('statusmovimento' => '4'), $criterioUpdateMov)){
    				throw new ErrorException("Impossivel concluir.", 1);
    			}
    			
    			$novoMovimento['unidade'] = $conta->unidade;
    			$novoMovimento['codigoconta'] = $conta->codigo;
    			$novoMovimento['codigoplanoconta'] = $conta->codigoplanoconta;
    			$novoMovimento['codigopessoa'] = $conta->codigopessoa;
    			$novoMovimento['codigotransacao'] = $conta->codigotransacao;
    			$novoMovimento['codigofuncionario'] = $this->obUser->codigofuncionario;
    			$novoMovimento['tipomovimentacao'] = ($valorTotal < 0) ? 'D' : 'C';
    			$novoMovimento['valorreal'] = $conta->valorreal - $valorTotal;
    			$novoMovimento['valorpago'] = abs($valorTotal);
    			$novoMovimento['valorentrada'] = abs($valorTotal);
    			$novoMovimento['datapag'] = date('Y-m-d');
    			$novoMovimento['statusmovimento'] = 1;
    			$novoMovimento['statusconta'] =  abs($valorTotal) == $conta->valorreal ? 1 : 3;
    			$novoMovimento['ativo'] = 1;
    			$novoMovimento['obs'] = $obs;
    			    			
    			$retTransacao = $transaction->insert($novoMovimento);
    			
    			/* 
	    			$dadosUpdateConta["statusconta"] = $novoMovimento['statusconta'];
	    			$dadosUpdateConta["valorreal"] = $novoMovimento['valorreal'];
	    			$transaction->setEntidade(TConstantes::DBTRANSACOES_CONTAS);
	    			$criteriaUpContas = new TCriteria();
	    			$criteriaUpContas->add(new TFilter('codigo', '=', $conta->codigo));
	    			$exeUpConta = $transaction->update($dadosUpdateConta, $criteriaUpContas);
    			 */
    			if($retTransacao){
    				$transaction->commit();
    				return $retTransacao['codigo'];
    			}else{
    				throw new ErrorException("Não foi possivel inserir o movimento de caixa para o estorno.", 1);
    			}
    			
    		} else {
    			throw new ErrorException("É necessário escolher ao menos uma movimentação para estorno.", 1);
    		}
    	} catch (Exception $e) {
    		$transaction->rollback();
    		new setException($e, 2);
    	}
    }
    /**
     * Retorna o movimento de caixa solicitado com todas as colunuas por padrão
     * param <codigo> $codigoCaixa
     * param <String> $colunas
     * return <Object>
     */
    public function getMovimentoCaixa($codigocaixa = null, $colunas = '*'){
        try{

            $this->obTDbo->setEntidade(TConstantes::DBCAIXA);

                if(!$codigocaixa){
                    //gera um registro de movimento de caixa
                    $retorno = $this->obTDbo->insert();
                    $codigocaixa = $retorno['codigo'];
                }

            $criteriaCaixa = new TCriteria();
            $criteriaCaixa->add(new TFilter('codigo', '=', $codigocaixa));
            $retCaixa = $this->obTDbo->select($colunas, $criteriaCaixa);
            $obMovimentoCaixa = $retCaixa->fetchObject();


            return $obMovimentoCaixa;
            
        } catch (Exception $e) {
            new setException($e);
        }
    }

    /**
    * Executa baixa da conta no caixa
    * param $tipo = Tipo de movimento da conta - C/D
    * param $codigoconta = Coodigo da conta a ser faturada
    */
    public function baixaCaixa($idform) {

        try {

            if($idform) {

                //retorna dados do cabeçalho
                $obHeader = new TSetHeader();
                $obHeader = $obHeader->getHead($idform);
                $codigocaixa = $obHeader['codigo'];
                
                $this->obTDbo->commit();

                $obMovimentoCaixa = $this->getMovimentoCaixa($codigocaixa);

                //executa baixa no caixa
                $this->baixaContaCaixa($obMovimentoCaixa->codigoconta, $obMovimentoCaixa->valorpago, $obMovimentoCaixa->desconto, $obMovimentoCaixa->numdoc, $obMovimentoCaixa->multaacrecimo, $obMovimentoCaixa->formapag, $obMovimentoCaixa->codigocontacaixa, $obMovimentoCaixa->codigo);
				
                $this->obTDbo->commit();
                $this->obTDbo->close();
            }

        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
    }

    /**
     *
     * param <type> $codigoconta = codigo da conta a ser baixada
     * param <type> $valorpago   = valor do credito/debito
     * param <type> $desconto    = valor do desconto ( 0.00 se não houver)
     * param <type> $acrescimo   = valor do acrescimo ( 0.00 se não houver)
     * param <type> $numDocumento = Número do documento
     * param <type> $formapagamento = Forma de pagamento ( dinheiro/ cartão/ cheque/ boleto )
     * param <type> $origemdestino = Código da conta caixa de origem/destino do valor
     * param <type> $codigocaixa = Código do movimento de caixa se já existir
     */
    public function baixaContaCaixa($codigoconta, $valorpago, $desconto, $acrescimo, $numDocumento, $formapagamento, $contacaixa, $codigocaixa = null){
        
        try {

            $this->obTDbo->setEntidade(TConstantes::DBTRANSACOES_CONTAS);
            $critBase = new TCriteria();
            $critBase->add(new TFilter("codigo", "=", $codigoconta));
            $obBase = $this->obTDbo->select("*", $critBase);
            $dados = $obBase->fetchObject();

            if(!$dados) {
                throw new ErrorException(TMensagem::ERRO_SEM_REGISTRO);
            }

            //Retorna informações da transação
            $this->obTDbo->setEntidade(TConstantes::DBTRANSACOES);
            $criteriaTransac = new TCriteria();
            $criteriaTransac->add(new TFilter('codigo', '=', $dados->codigotransacao));
            $retTransac = $this->obTDbo->select('codigoplanoconta', $criteriaTransac);
            $obTransac = $retTransac->fetchObject();

                //retorna dados do movimento de caixa
                $obMovimentoCaixa = $this->getMovimentoCaixa($codigocaixa);
                $codigocaixa = $obMovimentoCaixa->codigo;

                // Valida disponibilidade no saldo de caixa ====================
                $saldoCaixa = $this->getTotalCaixa($this->obUser->codigofuncionario);

                if($dados->tipomovimentacao == 'C'){
                     $validavalor = true;
                }else{
                    $valorNecessario = $valorpago;
                    switch($formapagamento){
                        case 'Dinheiro': $valorDisponivel = $saldoCaixa['saldoReceitaDinheiro'] - $saldoCaixa['saldoDespesaDinheiro']; break;
                        case 'Cheque': $valorDisponivel = $saldoCaixa['saldoReceitaCheque'] - $saldoCaixa['saldoDespesaCheque']; break;
                        case 'Cart�o': $valorDisponivel = $saldoCaixa['saldoReceitaCartao'] - $saldoCaixa['saldoDespesaCartao']; break;
                    }
                        if($valorNecessario <= $valorDisponivel){
                            $validavalor = true;
                        }else{
                            $validavalor = false;
                        }
                }
                //==============================================================

                if($validavalor){

                        //configura argumentos do movimento de caixa
                        $args["codigoconta"]        = $codigoconta;
                        $args["codigoplanoconta"]   = $obTransac->codigoplanoconta;
                        $args["codigopessoa"]       = $dados->codigopessoa;
                        $args["codigofuncionario"]  = $this->obUser->codigofuncionario;
                        $args["codigotransacao"]    = $dados->codigotransacao;
                        $args["codigocontacaixa"]   = $contacaixa;
                        $args["numdoc"]             = $numDocumento;
                        $args["tipomovimentacao"]   = $dados->tipomovimentacao;
                        $args["valorreal"]          = $dados->valorreal;
                        $args["valorpago"]          = $valorpago;
                        $args["vencimento"]         = $dados->vencimento;
                        $args["formapag"]           = $formapagamento;
                        $args["ativo"]              = $dados->ativo;
                    
                        $this->obTDbo->setEntidade(TConstantes::DBCAIXA);
                        $criteriaUpdate = new TCriteria();
                        $criteriaUpdate->add(new TFilter("codigo", "=", $codigocaixa));
                        $retCaixa = $this->obTDbo->update($args, $criteriaUpdate);

                    if($retCaixa) {

                        $obMovimentoCaixa = $this->getMovimentoCaixa($codigocaixa);

                        //identifica o status da conta =============================
                        $valorBase = ($valorpago + $desconto) - $acrescimo;
                        $novoValorReal = $dados->valorreal - $valorpago;

                        if ($obMovimentoCaixa->statusmovimento == "3") {
                            $statusConta = "5";
                        } else {
                            if ($valorBase < $obMovimentoCaixa->valorreal) {
                                $statusConta = "3"; // status conta parcialmente paga
                            } else {
                                $statusConta = "2"; // status conta paga
                            }
                            //==========================================================
                        }

                        //Altera status da conta
                         
                        $dadosUpdateConta["statusconta"] = $statusConta;
                        $dadosUpdateConta["valorreal"] = $novoValorReal < 0 ? 0 : $novoValorReal;
                        $this->obTDbo->setEntidade(TConstantes::DBTRANSACOES_CONTAS);
                        $criteriaUpContas = new TCriteria();
                        $criteriaUpContas->add(new TFilter('codigo', '=', $obMovimentoCaixa->codigoconta));
                        $exeUpConta = $this->obTDbo->update($dadosUpdateConta, $criteriaUpContas);
 						
                        if (!$exeUpConta) {
                            throw new ErrorException("O estado da conta não pode ser alterado.");
                        }
                        else{
                            return true;
                        }

                    } else {
                        throw new ErrorException("não foi possivel atualizar os dados do movimento de caixa.");
                    }

                }else{
                    throw new ErrorException("Não há saldo disponível em caixa para a movimentação. <br/><br/> Valor Necessário: <b>R$ $valorNecessario</b><br/> Valor Disponível: R$ <b>$valorDisponivel</b>");
                }

        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
    }

    /*
     * Retorna saldo de caixa inicial
     */

    private function getSaldoInicial($codigoContaCaixa) {

        //gera linha de caixa inicial da conta ================================
        //====== Retorna saldo em caixa do dia anterior para essa conta =======
        $dboRetornaSI = new TDbo(TConstantes::DBCONTAS_CAIXA_HISTORICO);
        $critSaldoCantasSI = new TCriteria();
        $critSaldoCantasSI->add(new TFilter('codigocontacaixa', '=', $codigoContaCaixa));
        $critSaldoCantasSI->add(new TFilter('ativo', '=', '1'));
        //$critSaldoCantasSI->add(new TFilter('datacad','=', TSetData::subData($dataBase,'1', '-')));
        $obSaldoContasSI = $dboRetornaSI->select('saldo', $critSaldoCantasSI);
        $saldoContaCxSI = $obSaldoContasSI->fetchObject();

        //injeta valor inicial no subtotal da conta
        //valida a existencia de um saldo anterior para saldo inicial
        if ($saldoContaCxSI) {
            $saldoInicial = $saldoContaCxSI->saldo;
        } else {
            // Retorna contas caixa
            $dboContaSI = new TDbo(TConstantes::DBCONTAS_CAIXA);
            $creteriaSI = new TCriteria();
            $creteriaSI->add(new TFilter('codigo', '=', $codigoContaCaixa));
            $creteriaSI->add(new TFilter('ativo', '=', '1'));
            $contaSI = $dboContaSI->select('saldoinicial', $creteriaSI);
            $obContaSI = $contaSI->fetchObject();

            $saldoInicial = $obContaSI->saldoinicial;
        }

        return $saldoInicial;
        //=====================================================================
    }

    /*
     * Calcula subtotal das contas caixa
     * Retorna um ventor de contas com os subtotais
     */

    private function calcContasCaixa($filtroUser = NULL) {

        if ($dataBase == NULL or !$dataBase) {
            $dataBase = date("Y-m-d");
        }
        $mascara = new TSetMascaras();

        $filtro = $this->obsession->getValue('boxFiltro_144');

        // Rertona movimento do caixa
        $dboCaixa = new TDbo(TConstantes::DBCAIXA);
        $creteriaCaixa = new TCriteria();
        $creteriaCaixa->add(new TFilter('ativo', '=', '1'));
        //$creteriaCaixa->add(new TFilter('datacad','=',$dataBase));
        if ($filtroUser) {
            $creteriaCaixa->add(new TFilter('codigofuncionario', '=', $this->obUser->codigofuncionario));
            $creteriaCaixa->add(new TFilter('statusmovimento', '=', "1"));
        } else {
            $creteriaCaixa->add(new TFilter('statusmovimento', '=', "1"), 'OR');
            $creteriaCaixa->add(new TFilter('statusmovimento', '=', "2"), 'OR');
        }
        $MCaixa = $dboCaixa->select('*', $creteriaCaixa);

        while ($resMCaixa = $MCaixa->fetchObject()) {

            if ($resMCaixa->tipomovimentacao == 'C') {
                $totalContasCaixa[$resMCaixa->codigocontacaixa] = ($totalContasCaixa[$resMCaixa->codigocontacaixa] + $resMCaixa->valorpago);
                $totalReceitas[$resMCaixa->codigocontacaixa] = $totalReceitas[$resMCaixa->codigocontacaixa] + $resMCaixa->valorpago;

                if ($resMCaixa->formapag == 'Cheque') {
                    $totalReceitasCheque[$resMCaixa->codigocontacaixa] = $totalReceitasCheque[$resMCaixa->codigocontacaixa] + $resMCaixa->valorpago;
                } elseif ($resMCaixa->formapag == 'Dinheiro') {
                    $totalReceitasDinheiro[$resMCaixa->codigocontacaixa] = $totalReceitasDinheiro[$resMCaixa->codigocontacaixa] + $resMCaixa->valorpago;
                } elseif ($resMCaixa->formapag == 'Cartão') {
                    $totalReceitasCartao[$resMCaixa->codigocontacaixa] = $totalReceitasCartao[$resMCaixa->codigocontacaixa] + $resMCaixa->valorpago;
                }
            } elseif ($resMCaixa->tipomovimentacao == 'D') {
                $totalContasCaixa[$resMCaixa->codigocontacaixa] = ($totalContasCaixa[$resMCaixa->codigocontacaixa] - $resMCaixa->valorpago);
                $totalDespesas[$resMCaixa->codigocontacaixa] = $totalDespesas[$resMCaixa->codigocontacaixa] + $resMCaixa->valorpago;

                if ($resMCaixa->formapag == 'Cheque') {
                    $totalDespesasCheque[$resMCaixa->codigocontacaixa] = $totalDespesasCheque[$resMCaixa->codigocontacaixa] + $resMCaixa->valorpago;
                } elseif ($resMCaixa->formapag == 'Dinheiro') {
                    $totalDespesasDinheiro[$resMCaixa->codigocontacaixa] = $totalDespesasDinheiro[$resMCaixa->codigocontacaixa] + $resMCaixa->valorpago;
                } elseif ($resMCaixa->formapag == 'Cartão') {
                    $totalDespesasCartao[$resMCaixa->codigocontacaixa] = $totalDespesasCartao[$resMCaixa->codigocontacaixa] + $resMCaixa->valorpago;
                }
            }
        }

        // Retorna um vertor contas caixa com as totalizações das contas
        $dboContasCaixa = new TDbo(TConstantes::DBCONTAS_CAIXA);
        $creteriaContaCx = new TCriteria();
        $creteriaContaCx->add(new TFilter('ativo', '=', '1'));
        $Contas = $dboContasCaixa->select('*', $criteriaContaCx);

        while ($obContas = $Contas->fetchObject()) {

            //saldo inicial da conta caixa
            $saldoInicial = 0; //$this->getSaldoInicial($obContas->codigo, $dataBase);

            $obContas->saldo = $totalContasCaixa[$obContas->codigo] + $saldoInicial;
            $obContas->totalreceita = $totalReceitas[$obContas->codigo];
            $obContas->totalreceitacheque = $totalReceitasCheque[$obContas->codigo];
            $obContas->totalreceitadinheiro = $totalReceitasDinheiro[$obContas->codigo];
            $obContas->totalreceitacartao = $totalReceitasCartao[$obContas->codigo];
            $obContas->totaldespesa = $totalDespesas[$obContas->codigo];
            $obContas->totaldespesacheque = $totalDespesasCheque[$obContas->codigo];
            $obContas->totaldespesadinheiro = $totalDespesasDinheiro[$obContas->codigo];
            $obContas->totaldespesacartao = $totalDespesasCartao[$obContas->codigo];
            $obContas->saldoinicialatual = $saldoInicial;

            $contasCaixa[$obContas->codigo] = $obContas;
        }

        return $contasCaixa;
    }

    /*
     * Retorna saldo em caixa agrupado
     */

    public function getTotalCaixa($filtroUser = NULL) {

        if ($dataBase == NULL or !$dataBase) {
            $dataBase = date("Y-m-d");
        }

        $cx = $this->calcContasCaixa($filtroUser);

        if (is_array($cx)) {
            foreach ($cx as $ccConta => $obTContas) {

                $saldoReceitaTotal = $saldoReceitaTotal + $obTContas->totalreceita;
                $saldoReceitaCheque = $saldoReceitaCheque + $obTContas->totalreceitacheque;
                $saldoReceitaDinheiro = $saldoReceitaDinheiro + $obTContas->totalreceitadinheiro;
                $saldoReceitaCartao = $saldoReceitaCartao + $obTContas->totalreceitacartao;

                $saldoDespesaTotal = $saldoDespesaTotal + $obTContas->totaldespesa;
                $saldoDespesaCheque = $saldoDespesaCheque + $obTContas->totaldespesacheque;
                $saldoDespesaDinheiro = $saldoDespesaDinheiro + $obTContas->totaldespesadinheiro;
                $saldoDespesaCartao = $saldoDespesaCartao + $obTContas->totaldespesacartao;

                $saldoTotalCx = $saldoTotalCx + $obTContas->saldo;
                $saldoInicialAtualTotal = $saldoInicialAtualTotal + $obTContas->saldoinicialatual;
            }
        }

        $vals['saldoInicialAtualTotal'] = $saldoInicialAtualTotal;
        $vals['saldoReceitaDinheiro'] = $saldoReceitaDinheiro;
        $vals['saldoReceitaCheque'] = $saldoReceitaCheque;
        $vals['saldoReceitaTotal'] = $saldoReceitaTotal;
        $vals['saldoReceitaCartao'] = $saldoReceitaCartao;
        $vals['saldoDespesaDinheiro'] = $saldoDespesaDinheiro;
        $vals['saldoDespesaCartao'] = $saldoDespesaCartao;
        $vals['saldoDespesaCheque'] = $saldoDespesaCheque;
        $vals['saldoDespesaTotal'] = $saldoDespesaTotal;
        $vals['saldoTotalCx'] = $saldoTotalCx;

        return $vals;
    }

    /*
     * Monta visualização de totalizações do caixa
     */

    public function viewCalcCaixaConsolidacao() {
        $dboCaixa = new TDbo(TConstantes::DBCAIXA);
        $creteriaCaixa = new TCriteria();
        $creteriaCaixa->add(new TFilter('ativo', '=', '1'), 'AND');
        $creteriaCaixa->add(new TFilter('statusmovimento', '=', "1"), 'AND');
        $MCaixa = $dboCaixa->select('id', $creteriaCaixa);
        $checkCaixa = $MCaixa->fetchAll();
        if (count($checkCaixa) > 0) {
            $obFechaCaixa = new TElement('div');
            $obFechaCaixa->class = 'ui-state-error';
            $obFechaCaixa->add('<h3>Não é possível consolidar as contas caixas por existirem <br/>Movimentações não verificadas pelo funcionario responsavel.</h3>');
        } else {
            //// MONTA VISUALIZAção DA TOTALIZAÇÃO DO CAIXA
            $obFechaCaixa = new TElement('input');
            $obFechaCaixa->type = "button";
            $obFechaCaixa->onclick = "prossExe('onView','form','403','','contLista391','')";
            $obFechaCaixa->name = "detalharCaixa";
            $obFechaCaixa->id = "detalharfecharCaixa";
            $obFechaCaixa->class = "ui-corner-all ui-widget ui-state-default";
            $obFechaCaixa->value = "Consolidação de Caixas";
        }
        $contBot = new TElement('div');
        $contBot->style = "border-top:1px solid #cecece; text-align:center;";
        $contBot->add($obResumoCaixa);
        $contBot->add($obFechaCaixa);

        //valida fechamento de caixa =================
        $dboValCaixaFx = new TDbo(TConstantes::DBCAIXA);
        $critFxCaixa = new TCriteria();
        $critFxCaixa->add(new TFilter('statusmovimento', '=', '1'));
        $critFxCaixa->add(new TFilter('statusmovimento', '=', '2'));
        $critFxCaixa->setProperty('order', 'id');
        $critFxCaixa->setProperty('limit', '1');
        $obValCaixa = $dboValCaixaFx->select('datacad', $critFxCaixa);
        $obValCaixa = $obValCaixa->fetchObject();

        if ($obValCaixa->datacad != "") {
            $this->obsession->setValue("statusCaixaAtual", '0');
            $dataBase = $obValCaixa->datacad;
        } else {
            $this->obsession->setValue("statusCaixaAtual", '1');
        }
        //=======================

        $valoresCX = $this->getTotalCaixa(false);

        $totalCr = 'R$ ' . number_format($valoresCX['saldoReceitaTotal'], 2, ',', '.');
        $totalCrDinheiro = 'R$ ' . number_format($valoresCX['saldoReceitaDinheiro'], 2, ',', '.');
        $totalCrCheque = 'R$ ' . number_format($valoresCX['saldoReceitaCheque'], 2, ',', '.');

        $totalDb = 'R$ ' . number_format($valoresCX['saldoDespesaTotal'], 2, ',', '.');
        $totalDbDinheiro = 'R$ ' . number_format($valoresCX['saldoDespesaDinheiro'], 2, ',', '.');
        $totalDbCheque = 'R$ ' . number_format($valoresCX['saldoDespesaCheque'], 2, ',', '.');

        $cTotal = 'R$ ' . number_format($valoresCX['saldoTotalCx'], 2, ',', '.');
        $siCx = 'R$ ' . number_format($valoresCX['saldoInicialAtualTotal'], 2, ',', '.');

        $obTotalInicio = new TElement('div');
        $obTotalInicio->style = "font-family:verdana; font-size:16px; border:0px solid #0000FF; padding:5px;  color:#009933;";
        $obTotalInicio->add("Saldo Inicial(&#43): ");
        $obTotalInicio->add('<b>' . $siCx . '</b>');

        $obTotalCr = new TElement('div');
        $obTotalCr->style = "font-family:verdana; font-size:16px; border:0px solid #0000FF; padding:5px; color:#0000cc;";
        $obTotalCr->add("Total Recebido(&#43): ");
        $obTotalCr->add('<b>' . $totalCr . '</b>');

        $obTotalDb = new TElement('div');
        $obTotalDb->style = "font-family:verdana; font-size:16px; border:0px solid #0000FF; padding:5px; color:#CC0033;";
        $obTotalDb->add("Total pago(-): ");
        $obTotalDb->add('<b>' . $totalDb . '</b>');

        $obTotal = new TElement('div');
        $obTotal->style = "font-family:verdana; font-size:16px; border:0px solid #0000FF; padding:5px;  color:#009933;";
        $obTotal->add("Total em caixa(=): ");
        $obTotal->add('<b>' . $cTotal . '</b>');

        $ob = new TElement('div');
        $ob->align = "right";
        $ob->style = "background-color:#FFFF99;";
        $ob->class = "ui-state-highlight";

        if ($divValCaixa) {
            $ob->add($divValCaixa);
        }

        $ob->add($obTotalInicio);
        $ob->add($obTotalCr);
        $ob->add($obTotalDb);
        $ob->add($obTotal);
        $ob->add($contBot);

        return $ob;
    }

    public function viewCalcCaixa($checkFunc = true) {

        $alocaDados = new TAlocaDados();
        $alocaDados->setValue('codigofuncionario', $this->obUser->codigofuncionario);


        if ($checkFunc) {
            $contasCaixa = $this->getContasCaixaFuncionario();
            if (count($contasCaixa) == 0) {
                $divValCaixa = new TElement('div');
                $divValCaixa->class = "validaFxCaixa ui-state-error";
                $divValCaixa->add('Não existem caixas disponíveis para movimentação financeira.<br/>É necessário aguardar a liberação.');
            } else {
                // MONTA VISUALIZAção DA TOTALIZAÇÃO DO CAIXA
                $obFechaCaixa = new TElement('input');
                $obFechaCaixa->type = "button";
                $obFechaCaixa->onclick = "prossExe('onView','form','379','','contLista144','')";
                $obFechaCaixa->name = "detalharCaixa";
                $obFechaCaixa->id = "detalharfecharCaixa";
                $obFechaCaixa->class = "ui-corner-all ui-widget ui-state-default";
                $obFechaCaixa->value = "Consolidação de Caixa";

                $contBot = new TElement('div');
                $contBot->style = "border-top:1px solid #cecece; text-align:center;";
                $contBot->add($obFechaCaixa);
            }
        }
        //valida fechamento de caixa =================
        $dboValCaixaFx = new TDbo(TConstantes::DBCAIXA);
        $critFxCaixa = new TCriteria();
        $critFxCaixa->add(new TFilter('statusmovimento', '=', '1'));
        $critFxCaixa->add(new TFilter('datacad', '!=', date("Y-m-d")));
        $critFxCaixa->setProperty('order', 'id');
        $critFxCaixa->setProperty('limit', '1');
        $obValCaixa = $dboValCaixaFx->select('datacad', $critFxCaixa);
        $obValCaixa = $obValCaixa->fetchObject();

        if ($obValCaixa->datacad != "") {
            $this->obsession->setValue("statusCaixaAtual", '0');
            $dataBase = $obValCaixa->datacad;
        } else {
            $this->obsession->setValue("statusCaixaAtual", '1');
        }
        //=======================

        $valoresCX = $this->getTotalCaixa(true);

        $totalCr = 'R$ ' . number_format($valoresCX['saldoReceitaTotal'], 2, ',', '.');
        $totalCrDinheiro = 'R$ ' . number_format($valoresCX['saldoReceitaDinheiro'], 2, ',', '.');
        $totalCrCheque = 'R$ ' . number_format($valoresCX['saldoReceitaCheque'], 2, ',', '.');

        $totalDb = 'R$ ' . number_format($valoresCX['saldoDespesaTotal'], 2, ',', '.');
        $totalDbDinheiro = 'R$ ' . number_format($valoresCX['saldoDespesaDinheiro'], 2, ',', '.');
        $totalDbCheque = 'R$ ' . number_format($valoresCX['saldoDespesaCheque'], 2, ',', '.');

        $cTotal = 'R$ ' . number_format($valoresCX['saldoTotalCx'], 2, ',', '.');
        $siCx = 'R$ ' . number_format($valoresCX['saldoInicialAtualTotal'], 2, ',', '.');

        $obTotalInicio = new TElement('div');
        $obTotalInicio->style = "font-family:verdana; font-size:16px; border:0px solid #0000FF; padding:5px;  color:#009933;";
        $obTotalInicio->add("Saldo Inicial(&#43): ");
        $obTotalInicio->add('<b>' . $siCx . '</b>');

        $obTotalCr = new TElement('div');
        $obTotalCr->style = "font-family:verdana; font-size:16px; border:0px solid #0000FF; padding:5px; color:#0000cc;";
        $obTotalCr->add("Total Recebido(&#43): ");
        $obTotalCr->add('<b>' . $totalCr . '</b>');

        $obTotalDb = new TElement('div');
        $obTotalDb->style = "font-family:verdana; font-size:16px; border:0px solid #0000FF; padding:5px; color:#CC0033;";
        $obTotalDb->add("Total pago(-): ");
        $obTotalDb->add('<b>' . $totalDb . '</b>');

        $obTotal = new TElement('div');
        $obTotal->style = "font-family:verdana; font-size:16px; border:0px solid #0000FF; padding:5px;  color:#009933;";
        $obTotal->add("Total em caixa(=): ");
        $obTotal->add('<b>' . $cTotal . '</b>');

        $ob = new TElement('div');
        $ob->align = "right";
        $ob->style = "background-color:#FFFF99;";
        $ob->class = "ui-state-highlight";

        if ($divValCaixa) {
            $ob->add($divValCaixa);
        }

        $ob->add($obTotalInicio);
        $ob->add($obTotalCr);
        $ob->add($obTotalDb);
        $ob->add($obTotal);
        $ob->add($contBot);

        return $ob;
    }

    /*
     * Visualização do relatorio de caixa para fechamento
     */

    public function viewsCaixa() {

        if ($dataBase == NULL or !$dataBase) {
            $dataBase = date("Y-m-d");
        }
        $mascara = new TSetMascaras();

        // Retorna contas caixa
        $contasCaixa = $this->calcContasCaixa();

        // Retorna contas receita/despesa
        $creteriaConta = new TCriteria();
        $creteriaConta->add(new TFilter('ativo', '=', '1'));
        $dboContas = new TDbo(TConstantes::DBPLANO_CONTAS);
        $ContasRD = $dboContas->select('*', $creteriaConta);

        while ($resContasRD = $ContasRD->fetch()) {
            $labelContasRD[$resContasRD['codigo']] = $resContasRD['nomeconta'];
        }

        // Rertona movimento do caixa
        $dboCaixa = new TDbo(TConstantes::VIEW_CAIXA);
        $creteriaCaixa = new TCriteria();
        $creteriaCaixa->add(new TFilter('ativo', '=', '1'));
        //$creteriaCaixa->add(new TFilter('datacad','=',$dataBase));
        $creteriaCaixa->add(new TFilter('statusmovimento', '=', "2"));
        $MCaixa = $dboCaixa->select('*', $creteriaCaixa);

        while ($resMCaixa = $MCaixa->fetchObject()) {
            $movCaixa[$resMCaixa->codigocontacaixa][$resMCaixa->codigo] = $resMCaixa;
        }
        //Conteiner Absoluto (Tabela)
        $conteiner = new TTable();
        $conteiner->width = "100%";
        //$conteiner->class = "tdatagrid_table";
        $rowBox = $conteiner->addRow();

        $cellBoxL = $rowBox->addCell("");
        //	$cellBoxL->width = "100%";
        //	$cellBoxL->valign = "top";
        //	$cellBoxL->align = "center";
        // VISUALIZAção DAS CONTAS ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        //percorre contas caixa
        $contCredito = new TElement('fieldset');
        $contCredito->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
        $leg = new TElement("legend");
        $leg->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
        $leg->add('Movimento do dia ' . $mascara->setData($dataBase));
        $contCredito->add($leg);

        if (count($contasCaixa) != 0) {

            //percorre contas caixa e lista os movimentos de cada conta
            foreach ($contasCaixa as $codCCX => $obConta) {
                $contaLab = new TElement('div');
                $contaLab->class = "topFechaCaixa ui-state-default ui-widget-content ui-corner-top";
                $contaLab->align = 'left';
                $contaLab->add("<span style='margin: 5px 5px 5px 10px; display: block'> <b>Conta: </b> {$obConta->nomeconta} </span>");

                $retTable[$codCCX] = new TTable();
                $retTable[$codCCX]->width = "100%";
                $retTable[$codCCX]->class = "tdatagrid_table";
                $retTable[$codCCX]->cellspacing = "0";

                $rowTop = $retTable[$codCCX]->addRow();
                //$rowTop->class = "tdatagrid_row1";
                $cellTop1 = $rowTop->addCell(' Fonte');
                $cellTop1->width = "40%";
                $cellTop1->class = "tdatagrid_col";

                $cellTop2 = $rowTop->addCell('Plano de Conta');
                $cellTop2->width = "20%";
                $cellTop2->class = "tdatagrid_col";

                $cellTop3 = $rowTop->addCell('Entrada');
                $cellTop3->width = "10%";
                $cellTop3->class = "tdatagrid_col";

                $cellTop4 = $rowTop->addCell('Saida');
                $cellTop4->width = "10%";
                $cellTop4->class = "tdatagrid_col";

                $cellTop5 = $rowTop->addCell('Data do Movimento');
                $cellTop5->width = "20%";
                $cellTop5->class = "tdatagrid_col";


                $subtotalReceita[$codCCX] = 0;
                //percorre linhas das contas e monta tabela de visualização
                if (is_array($movCaixa[$obConta->codigo])) {
                    foreach ($movCaixa[$obConta->codigo] as $codMov => $mov) {

                        $row[$mov->codigo] = $retTable[$codCCX]->addRow();
                        $row[$mov->codigo]->class = "tdatagrid_row";
                        $cell1 = $row[$mov->codigo]->addCell($mov->nomepessoa);
                        $cell1->class = "rows";

                        $cell2 = $row[$mov->codigo]->addCell($mov->nomeplanoconta);
                        $cell2->class = "rows";

                        if ($mov->tipomovimentacao == "C") {

                            $cell3 = $row[$mov->codigo]->addCell('R$ ' . number_format($mov->valorpago, 2, ',', '.'));
                            $cell3->align = "right";
                            $cell3->class = "rows";

                            $cell4 = $row[$mov->codigo]->addCell(' - ');
                            $cell4->align = "center";
                            $cell4->class = "rows";

                            $totReceita = $totReceita + $mov->valorpago;
                            $subtotalReceita[$mov->codigoconta] = $subtotalReceita[$mov->codigoconta] + $mov->valorpago;
                        } else {

                            $cell3 = $row[$mov->codigo]->addCell(' - ');
                            $cell3->align = "center";
                            $cell3->class = "rows";

                            $cell4 = $row[$mov->codigo]->addCell('R$ ' . number_format($mov->valorpago, 2, ',', '.'));
                            $cell4->align = "right";
                            $cell4->class = "rows";

                            $totDespesa = $totDespesa + $mov->valorpago;
                            $subtotalReceita[$mov->codigoconta] = $subtotalReceita[$mov->codigoconta] - $mov->valorpago;
                        }

                        $dt = new TSetData();

                        $cell5 = $row[$mov->codigo]->addCell($mov->datacad);
                        $cell5->align = "center";
                        $cell5->class = "rows";
                    }
                }
                $rowTotal = $retTable[$codCCX]->addRow();
                $rowTotal->class = "ui-state-default";

                $cellSpace = $rowTotal->addCell(' ');
                $cellSpace->colspan = '2';
                $cellSpace->class = "rowTotal";

                $cellReceita = $rowTotal->addCell('R$ ' . number_format($obConta->totalreceita, 2, ',', '.'));
                $cellReceita->class = "rowTotal";

                $totReceita = 0;

                $cellDespesa = $rowTotal->addCell('R$ ' . number_format($obConta->totaldespesa, 2, ',', '.'));
                $cellDespesa->class = "rowTotal";

                $totDespesa = 0;

                $cellTotal = $rowTotal->addCell('Subtotal: ');
                $cellTotal->add('R$ ' . number_format($obConta->saldo, 2, ',', '.'));
                $cellTotal->class = "rowTotal";

                $totalCaixa = $totalCaixa + $obConta->saldo;

                $contaLab->add($retTable[$codCCX]);
                $contCredito->add($contaLab);
                //$contCredito->add($retTable[$codCCX]);
                $contCredito->add('<br/>');
            }


            $cellBoxL->add($contCredito);
        } else {
            $cellBoxL->add("Nenhuma entrada registrada hoje.");
        }

        $rowRodape = $conteiner->addRow();

        $cellBoxRp = $rowRodape->addCell('<b>Total em caixa: R$ ' . number_format($totalCaixa, 2, ',', '.') . '</b>');
        $cellBoxRp->colspan = "2";
        $cellBoxRp->class = "ui-state-highlight";
        $cellBoxRp->valign = "top";
        $cellBoxRp->align = "center";

        $boxAll = new TElement('div');
        $boxAll->id = 'allCaixaRetorno';
        $boxAll->add($conteiner);
        $boxAll->add('<br>');

        $boxFechaContas = new TElement('div');
        $boxFechaContas->id = 'fechaCaixaRetorno';
        $boxFechaContas->style = 'text-align: center;';
        $obFechaCaixa = new TElement('input');
        $obFechaCaixa->type = "button";
        $obFechaCaixa->onclick = "fechaCaixa()";
        $obFechaCaixa->name = "detalharCaixa";
        $obFechaCaixa->id = "detalharfecharCaixa";
        $obFechaCaixa->class = "ui-corner-all ui-widget ui-state-default";
        $obFechaCaixa->value = "Consolidar Contas Caixa";
        $boxFechaContas->add($obFechaCaixa);
        $boxAll->add($boxFechaContas);
        return $boxAll;
        //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    }

    /*
     * Executa fechamento de caixa
     */

    public function fechaCaixa() {

        try {
            $this->obTDbo->setEntidade(TConstantes::DBCONTAS_CAIXA);
            $retContas = $this->obTDbo->select('*');

            while ($obContas_ = $retContas->fetchObject()) {
                $obContas[$obContas_->codigo] = $obContas_;
            }           //atualiza estatus do hist�rico de caixa
            $this->obTDbo->setEntidade(TConstantes::DBCONTAS_CAIXA_HISTORICO);
            $criteriaUpHistCaixa = new TCriteria();
            $criteriaUpHistCaixa->add(new TFilter('ativo', '=', '8'), 'AND');
            $criteriaUpHistCaixa->add(new TFilter('datafim', 'is', 'null'), 'AND');
            $retUpHistCaixa = $this->obTDbo->select('*', $criteriaUpHistCaixa);

            if ($retUpHistCaixa) {
                $divSucesso = new TElement('div');
                $divSucesso->class = "ui-state-highlight";
                while ($historico = $retUpHistCaixa->fetchObject()) {
                    $update = null;
                    $update['codigohistorico'] = $historico->codigo;
                    $update['statusmovimento'] = '5';

                    $crit = null;
                    $crit = new TCriteria();
                    $crit->add(new TFilter('codigocontacaixa', '=', $historico->codigocontacaixa));
                    $crit->add(new TFilter('statusmovimento', '=', '2'));

                    $this->obTDbo->setEntidade(TConstantes::DBCAIXA);
                    $checkUp = $this->obTDbo->update($update, $crit);

                    if ($checkUp) {
                        $crit = null;
                        $crit = new TCriteria();
                        $crit->add(new TFilter('codigocontacaixa', '=', $historico->codigocontacaixa));

                        $update = null;
                        $update['situacao'] = '1';
                        $this->obTDbo->setEntidade(TConstantes::DBCAIXA_FUNCIONARIOS);
                        $checkUp = $this->obTDbo->update($update, $crit);

                        if ($checkUp) {
                            $crit = null;
                            $crit = new TCriteria();
                            $crit->add(new TFilter('codigo', '=', $historico->codigo));

                            $update = null;
                            $update['ativo'] = '1';
                            $update['datafim'] = date('Y-m-d');

                            $insert = null;
                            $insert['ativo'] = '8';
                            $insert['datainicio'] = date('Y-m-d');
                            $insert['codigocontacaixa'] = $historico->codigocontacaixa;

                            $this->obTDbo->setEntidade(TConstantes::DBCONTAS_CAIXA_HISTORICO);
                            $checkUp = $this->obTDbo->update($update, $crit);
                            $insert = $this->obTDbo->insert($insert);
                            if ($checkUp && $insert) {
                                $divSucesso->add("Conta \"{$obContas[$historico->codigocontacaixa]->nomeconta}\" consolidada com sucesso.<br/>");
                                unset($obContas[$historico->codigocontacaixa]);
                            } else {
                                throw new ErrorException(TMensagem::ERRO_FECHAR_CAIXA);
                            }
                        } else {
                            throw new ErrorException(TMensagem::ERRO_FECHAR_CAIXA);
                        }
                    } else {
                        throw new ErrorException(TMensagem::ERRO_FECHAR_CAIXA);
                    }
                }

                foreach ($obContas as $historico) {
                    $insert = null;
                    $insert['ativo'] = '1';
                    $insert['datainicio'] = date('Y-m-d');
                    $insert['datafim'] = date('Y-m-d');
                    $insert['codigocontacaixa'] = $historico->codigo;
                    $this->obTDbo->setEntidade(TConstantes::DBCONTAS_CAIXA_HISTORICO);
                    $retNewHist = $this->obTDbo->insert($insert);

                    $update = null;
                    $update['codigohistorico'] = $retNewHist['codigo'];
                    $update['statusmovimento'] = '5';

                    $crit = null;
                    $crit = new TCriteria();
                    $crit->add(new TFilter('codigocontacaixa', '=', $historico->codigocontacaixa));
                    $crit->add(new TFilter('statusmovimento', '=', '2'));

                    $this->obTDbo->setEntidade(TConstantes::DBCAIXA);
                    $checkUp = $this->obTDbo->update($update, $crit);

                    if ($checkUp) {
                        $crit = null;
                        $crit = new TCriteria();
                        $crit->add(new TFilter('codigocontacaixa', '=', $historico->codigocontacaixa));

                        $update = null;
                        $update['situacao'] = '1';
                        $this->obTDbo->setEntidade(TConstantes::DBCAIXA_FUNCIONARIOS);
                        $checkUp = $this->obTDbo->update($update, $crit);

                        if ($checkUp) {
                            $crit = null;
                            $crit = new TCriteria();
                            $crit->add(new TFilter('codigo', '=', $historico->codigo));

                            $update = null;
                            $update['ativo'] = '1';
                            $update['datafim'] = date('Y-m-d');

                            $insert = null;
                            $insert['ativo'] = '8';
                            $insert['datainicio'] = date('Y-m-d');
                            $insert['codigocontacaixa'] = $historico->codigo;

                            $this->obTDbo->setEntidade(TConstantes::DBCONTAS_CAIXA_HISTORICO);
                            $insert = $this->obTDbo->insert($insert);
                            if ($insert) {
                                $divSucesso->add("Conta \"{$historico->nomeconta}\" consolidada com sucesso.<br/>");
                                unset($obContas[$historico->codigocontacaixa]);
                            } else {
                                throw new ErrorException(TMensagem::ERRO_FECHAR_CAIXA);
                            }
                        } else {
                            throw new ErrorException(TMensagem::ERRO_FECHAR_CAIXA);
                        }
                    } else {
                        throw new ErrorException(TMensagem::ERRO_FECHAR_CAIXA);
                    }
                }
                $this->obTDbo->commit();
                return $divSucesso;
            }


            //=========================================================================================
        } catch (Exception $e) {
            $this->obTDbo->rollBack();
            new setException($e);
        }
        $this->obTDbo->close();
    }

    /*
     * Executa fechamento de caixa_funcionario
     */

    public function fechaCaixaFuncionario($codigocontacaixa = null) {
        try {
            //Altera status dos movimentos de caixa
            $this->obTDbo->setEntidade(TConstantes::DBCAIXA);
            $criteriaUPCaixa = new TCriteria();
            //$criteriaUPCaixa->add(new TFilter('datacad','=',$dataBase));
            $criteriaUPCaixa->add(new TFilter('ativo', '=', '1'));
            $criteriaUPCaixa->add(new TFilter('statusmovimento', '=', '1'));
            $criteriaUPCaixa->add(new TFilter('codigofuncionario', '=', $this->obUser->codigofuncionario));
            if ($codigocontacaixa) {
                $criteriaUPCaixa->add(new TFilter('codigocontacaixa', '=', $codigocontacaixa));
            }
            $dboUpMCaixa = $this->obTDbo->update(array('statusmovimento' => '2'), $criteriaUPCaixa);

            $this->obTDbo->setEntidade(TConstantes::DBCAIXA_FUNCIONARIOS);
            $criteriaUPCaixaFuncionario = new TCriteria();
            if ($codigocontacaixa) {
                $criteriaUPCaixaFuncionario->add(new TFilter('codigocontacaixa', '=', $codigocontacaixa));
            }
            $criteriaUPCaixaFuncionario->add(new TFilter('codigofuncionario', '=', $this->obUser->codigofuncionario));
            $dboUpCaixaFuncionario = $this->obTDbo->update(array('situacao' => '2'), $criteriaUPCaixaFuncionario);

            if ($this->obTDbo->commit()) {
                $divValCaixa = new TElement('div');
                $divValCaixa->class = "ui-state-highlight";
                $divValCaixa->add('<h3>Contas conferidas com sucesso.</h3>');

                return $divValCaixa;
            } else {
                throw new ErrorException('Não foi possivel completar a ação, tente mais tarde');
            }
        } catch (Exception $e) {
            $this->obTDbo->rollBack();
            new setException($e);
        }
    }

    /*
     * Monta visualização de totalizações do caixa
     */

    public function viewDetalhamentoCaixa() {

        if ($dataBase == NULL or !$dataBase) {
            $dataBase = date("Y-m-d");
        }


        $caixa = $this->getTotalCaixa();
        $datagrid = new TDataGrid();

        $datagrid->addColumn(new TDataGridColumn('tipomovimentacao', 'Tipo de Movimentaçao', 'left', '70%'));
        $datagrid->addColumn(new TDataGridColumn('credito', 'Crédito', 'center', '10%'));
        $datagrid->addColumn(new TDataGridColumn('debito', 'Débito', 'center', '10%'));
        $datagrid->addColumn(new TDataGridColumn('saldo', 'Saldo', 'center', '10%'));
        $datagrid->createModel('100%');

        $TSetModel = new TSetModel();

        $vet1['tipomovimentacao'] = "Dinheiro";
        $vet1['credito'] = $TSetModel->setValorMonetario($caixa['saldoReceitaDinheiro']);
        $vet1['debito'] = $TSetModel->setValorMonetario($caixa['saldoDespesaDinheiro']);
        $vet1['saldo'] = $TSetModel->setValorMonetario($caixa['saldoReceitaDinheiro'] - $caixa['saldoDespesaDinheiro']);

        $datagrid->addItem($vet1);

        $vet2['tipomovimentacao'] = "Cheques";
        $vet2['credito'] = $TSetModel->setValorMonetario($caixa['saldoReceitaCheque']);
        $vet2['debito'] = $TSetModel->setValorMonetario($caixa['saldoDespesaCheque']);
        $vet2['saldo'] = $TSetModel->setValorMonetario($caixa['saldoReceitaCheque'] - $caixa['saldoDespesaCheque']);

        $datagrid->addItem($vet2);

        $vet3['tipomovimentacao'] = "Cartão";
        $vet3['credito'] = $TSetModel->setValorMonetario($caixa['saldoReceitaCartao']);
        $vet3['debito'] = $TSetModel->setValorMonetario($caixa['saldoDespesaCartao']);
        $vet3['saldo'] = $TSetModel->setValorMonetario($caixa['saldoReceitaCartao'] - $caixa['saldoDespesaCartao']);

        $datagrid->addItem($vet3);

        $chartEntrada = new TChart('Gráfico de Movimentações ('.date('d/m/Y').')', 600, 300);
        $chartEntrada->addLabel(array('Dinheiro','Cartão','Cheque'));
        $chartEntrada->addPoint(array($caixa['saldoReceitaDinheiro'],$caixa['saldoReceitaCartao'],$caixa['saldoReceitaCheque']),'Crédito');
        $chartEntrada->addPoint(array($caixa['saldoDespesaDinheiro'],$caixa['saldoDespesaCartao'],$caixa['saldoDespesaCheque']),'Débito');
        $chartEntrada->setAxisName('Valores (R$)');

        $imgChart = $chartEntrada->show('bar');
        $imgChart->style = 'display: inline;';
        $fieldSet = new TElement("fieldset");
        $fieldSet->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
        $fieldSet_legenda = new TElement("legend");
        $fieldSet_legenda->add('Resumo de Movimentações');
        $fieldSet_legenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
        $fieldSet->style = "text-align: center;";
        $fieldSet->add($fieldSet_legenda);
        $fieldSet->add($imgChart);
        $fieldSet->add($datagrid);

        $datagrid2 = new TDataGrid();
        $datagrid2->addColumn(new TDataGridColumn('label', 'Total em caixa', 'left', '70%'));
        $datagrid2->addColumn(new TDataGridColumn('inicial', 'Saldo Inicial', 'center', '15%'));
        $datagrid2->addColumn(new TDataGridColumn('atual', 'Saldo Atual', 'center', '15%'));
        $datagrid2->createModel('100%');

        $vet2['label'] = 'Saldo em Caixa para ' . $TSetModel->setDataPT($dataBase);
        $vet2['inicial'] = '<b>' . $TSetModel->setValorMonetario($caixa['saldoInicialAtualTotal']) . '</b>';
        $vet2['atual'] = '<b>' . $TSetModel->setValorMonetario($caixa['saldoTotalCx']) . '</b>';

        $datagrid2->addItem($vet2);

        $fieldSet2 = new TElement("fieldset");
        $fieldSet2->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
        $fieldSet_legenda2 = new TElement("legend");
        $fieldSet_legenda2->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
        $fieldSet_legenda2->add('Totalização');
        $fieldSet2->add($fieldSet_legenda2);
        $fieldSet2->add($datagrid2);

        // MONTA VISUALIZAção DA TOTALIZAÇÃO DO CAIXA
        $buttonFechamento = new TElement('input');
        $buttonFechamento->type = "button";
        $buttonFechamento->onclick = "fechaCaixaFuncionario()";
        $buttonFechamento->name = "fecharCaixa";
        $buttonFechamento->id = "fecharCaixa";
        $buttonFechamento->class = "ui-corner-all ui-widget ui-state-default";
        $buttonFechamento->style = "font-weight:bold; font-size: 30px;";
        $buttonFechamento->value = "Fechar Caixa";

        $div = new TElement('div');
        $div->id = "retfecharCaixa";
        $div->style = "text-align: center;";

        $div->add($buttonFechamento);
        $fieldSet3 = new TElement("fieldset");
        $fieldSet3->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
        $fieldSet3->add($div);

        $div = new TElement('div');
        $div->add($fieldSet);
        $div->add('<br/>');
        $div->add($fieldSet2);
        $div->add('<br/>');
        $div->add($fieldSet3);

        return $div;
    }

    /*
     * Função para seleção das Contas caixa referentes a Permissão de caixas do Funcionário
     */

    public function getContasCaixaFuncionario() {
        $TUsuario = new TUsuario();
        $codigoFuncionario = $TUsuario->getCodigoFuncionario();
        $dbo = new TDbo();
        $crit = new TCriteria();
        $ret = null;
        $array = array();

        try {
            if ($codigoFuncionario) {
                $dbo->setEntidade('view_caixa_funcionarios');
                $crit->add(new TFilter('codigofuncionario', '=', $codigoFuncionario));
                $crit->add(new TFilter('situacao', '=', '1'));

                $ret = $dbo->select('codigocontacaixa,nomecontacaixa', $crit);

                while ($ob = $ret->fetchObject()) {
                    $array[$ob->codigocontacaixa] = $ob->nomecontacaixa;
                }

                return $array;
            } else {
                throw new Exception('O Usuário não é um funcionário válido');
            }
        } catch (Exception $e) {
            $this->obTDbo->rollBack();
            new setException($e);
        }
    }

    /*
     * Apendice responsavel pela movimentaçao interna
     */

    public function gerarMovimentacaoInterna($contaorigem, $contadestino, $valor, $formapag = 'Dinheiro') {
        try {
            if ($contaorigem && $contadestino && $valor && $formapag) {
                $TControl = new TSetControl();
                $valor = $TControl->setFloat($valor);

                $transacDeb['ativo'] = 1;
                $transacDeb['codigocontacaixa'] = $contaorigem;
                $transacDeb['valorreal'] = $valor;
                $transacDeb['valorpago'] = $valor;
                $transacDeb['valorentrada'] = $valor;
                $transacDeb['formapag'] = $formapag;
                $transacDeb['tipomovimentacao'] = 'D';
                $transacDeb['statusmovimento'] = '1';
                $transacDeb['statusconta'] = '2';
                $transacDeb['codigofuncionario'] = $this->obUser->codigofuncionario;

                $transacCre['ativo'] = 1;
                $transacCre['codigocontacaixa'] = $contadestino;
                $transacCre['valorreal'] = $valor;
                $transacCre['valorpago'] = $valor;
                $transacCre['valorentrada'] = $valor;
                $transacCre['formapag'] = $formapag;
                $transacCre['tipomovimentacao'] = 'C';
                $transacCre['statusmovimento'] = '1';
                $transacCre['statusconta'] = '2';
                $transacCre['codigofuncionario'] = $this->obUser->codigofuncionario;

                $this->obTDbo->setEntidade(TConstantes::DBCAIXA);

                if ($this->obTDbo->insert($transacDeb)) {
                    if ($this->obTDbo->insert($transacCre)) {
                        $this->obTDbo->commit();
                        $fieldSet = new TElement("div");
                        $fieldSet->style = "text-align:center;";
                        $fieldSet->class = " ui_bloco_fieldset ui-corner-all ui-state-highlight";
                        $fieldSet->add('<h3>Movimentação efetuada.</h3>');

                        return $fieldSet;
                    } else {
                        throw new Exception('Erro ao gerar movimentação.');
                    }
                } else {
                    throw new Exception('Erro ao gerar movimentação.');
                }
            } else {
                throw new Exception('Há dados inválidos ou inexistentes na movimentação.');
            }
        } catch (Exception $e) {
            $this->obTDbo->rollBack();
            new setException($e);
        }
    }


    /*
     * Função para obtenção de movimentações referentes a histórico
     */

    public function getHistorico($codigoHistorico){
        try{
            if($codigoHistorico){
                $this->obTDbo->setEntidade(TConstantes::VIEW_CONTAS_CAIXA_HISTORICO);
                $criterio = new TCriteria();
                $criterio->add(new TFilter('codigo','=',$codigoHistorico));
                $criterio->add(new TFilter('ativo','=','1'));
                $ret = $this->obTDbo->select('*',$criterio);
                $obHistorico = $ret->fetchObject();

                if($obHistorico->codigo){
                    $this->obTDbo->setEntidade(TConstantes::VIEW_CAIXA);
                    $criterio = new TCriteria();
                    $criterio->add(new TFilter('codigohistorico','=',$obHistorico->codigo));
                    $ret = $this->obTDbo->select('*',$criterio);

                    while($obConta = $ret->fetchObject()){
                        $obHistorico->movimentacoes[$obConta->codigo] = $obConta;
                    }

                    return $obHistorico;
                }else{
                    throw new Exception('Código invalido para seleção de históricos de caixa.');
                }
            }else{
                throw new Exception('Código invalido para seleção de históricos de caixa.');
            }
        } catch (Exception $e) {
            $this->obTDbo->rollBack();
            new setException($e);
        }
    }
    /*
     * Exibe gráfico com histórico de caixa
     */

    public function viewGraficoHistorico($codigoHistorico){
        try{
            $obHistorico = $this->getHistorico($codigoHistorico);
            $divContent = new TElement('div');
            $divContent->style = "padding: 10px; padding-top: 30px; text-align: center; min-height: 200px; vertical-align: middle;";
            if($obHistorico->movimentacoes){
                foreach($obHistorico->movimentacoes as $mov){
                        $data1[$mov->datacad][$mov->tipomovimentacao][$mov->formapag] += $mov->valorpago;
                        $data2[$mov->formapag] = ($mov->tipomovimentacao == 'D') ? $data2[$mov->formapag] - $mov->valorpago : $data2[$mov->formapag] + $mov->valorpago;
                        $data3[$mov->formapag]++;
                }
                ksort($data1);
                $chartEntrada = new TChart('Histórico Conta '.$obHistorico->nomeconta.'  ('.substr($obHistorico->datainicio,0,-5).' a '.substr($obHistorico->datafim,0,-5).')', 700, 400);

                foreach($data1 as $ch=>$vl){
                    $labels[] = $ch;
                    $dinheiro[] =($vl['C']['Dinheiro'] - $vl['D']['Dinheiro']);
                    $cartao[] = ($vl['C']['Cartão'] - $vl['D']['Cartão']);
                    $cheque[] = ($vl['C']['Cheque'] - $vl['D']['Cheque']);
                }
                $chartEntrada->addLabel($labels);
                $chartEntrada->addPoint($dinheiro,'Dinheiro');
                $chartEntrada->addPoint($cartao,'Cartão');
                $chartEntrada->addPoint($cheque,'Cheque');
                $chartEntrada->setAxisName('Valores (R$)');

                $imgChart = $chartEntrada->show('bar');
                $imgChart->style = 'display: inline;';
                $divContent->add($imgChart);

            }else{
                $span = new TElement('span');
                $span->style = 'font-size: 18px; text-align: center; padding:20px; margin: 10px;';
                $span->class = "ui-corner-all ui-state-highlight";
                $span->add('Não há históricos de movimentações. Não é possível gerar um gráfico para visualização.');
                $divContent->add($span);
            }

            $divRet = new TElement('div');
            $field = new TElement("fieldset");
            $field->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
            $fieldLegenda = new TElement("legend");
            $fieldLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
            $fieldLegenda->add("Gráficos de Movimentações");
            $field->add($fieldLegenda);

            $field->add($divContent);

            $divRet->add($field);

            return $divRet;

        } catch (Exception $e) {
            $this->obTDbo->rollBack();
            new setException($e);
        }
    }
    
    /**
     * Gera apendice da lista de Baixa Multiplas
     * @param INT $idForm = Id do formulario.
     */
    public function apendiceBaixaMultipla($codigo,$idForm){
    
    	$div = new TElement('div');
    	$div->id = 'divBaixaMultipla';
    	$button = new TElement('input');
    	$button->id = "runBaixaMultipla";
    	$button->type = "button";
    	$button->onclick = "setBaixaMultipla('ret_BaixaMultipla','$idForm')";
    	$button->class = "ui-state-default ui-corner-all";
    	$button->title = 'Baixar Contas Selecionadas';
    	$button->value = "Baixar Contas Selecionadas";
    
    	$div->style = "text-align: center; padding: 5px;";
    	$div->class = "ui-widget-content";
    	$div->add($button);

    	$div2 = new TElement('div');
    	$div2->id = 'ret_BaixaMultipla';
    	$div->add($div2);
    	
    	return $div;
    }
    
    public function setBaixaMultipla($idForm){
    	$obHeader = new TSetHeader();
    	$headerForm = $obHeader->getHead($idForm);
    	
    	try {
    		$listaObjetoContas = array();
	    	$listaContas = $obHeader->getHead(485,'listaSelecao');
	    	$codigocontacaixa = $headerForm['camposSession']['codigocontacaixa']['valor'];
	    	$formapag = $headerForm['camposSession']['formapag']['valor'];
	    	$acrescimo = $headerForm['camposSession']['multaacrecimo']['valor'];
	    	$desconto = $headerForm['camposSession']['desconto']['valor'];
	    	$obs = $headerForm['camposSession']['obs']['valor'];
    		if(!$listaContas || count($listaContas) < 2)
    			throw new Exception('Informe ao menos duas contas para o pagamento.');
    		if(!$codigocontacaixa || !$formapag)
    			throw new Exception('Informe uma forma de pagamento.');
    			
    		$this->obTDbo->setEntidade(TConstantes::DBTRANSACOES_CONTAS);
    		$crit = new TCriteria();
    		$crit->add(new TFilter('statusconta','in','(1,3)'),'AND');
    		foreach($listaContas as $conta)
    			$crit->add(new TFilter('codigo','=',$conta, 9),'OR');
    		$retContas = $this->obTDbo->select('*',$crit);
    		
    		while($conta = $retContas->fetchObject()){
    			$novoMovimento = array();
    			$novoMovimento['unidade'] = $conta->unidade;
    			$novoMovimento['codigoconta'] = $conta->codigo;
    			$novoMovimento['codigoplanoconta'] = $conta->codigoplanoconta;
    			$novoMovimento['codigopessoa'] = $conta->codigopessoa;
    			$novoMovimento['codigotransacao'] = $conta->codigotransacao;
    			$novoMovimento['codigofuncionario'] = $this->obUser->codigofuncionario;
    			$novoMovimento['tipomovimentacao'] = 'C';
    			$novoMovimento['valorreal'] = $conta->valorreal;
    			$novoMovimento['valorpago'] = $conta->valorreal-$desconto+$acrescimo;
    			$novoMovimento['valorentrada'] = $conta->valorreal-$desconto+$acrescimo;
    			$novoMovimento['datapag'] = date('Y-m-d');
    			$novoMovimento['statusmovimento'] = 1;
    			$novoMovimento['statusconta'] =  1;
    			$novoMovimento['ativo'] = 1;
    			$novoMovimento['obs'] = $obs;

    			$this->obTDbo->setEntidade(TConstantes::DBCAIXA);
    			$retTransacao = $this->obTDbo->insert($novoMovimento);
    			
    			$this->obTDbo->commit();

    			if($retTransacao){
    				if($this->baixaContaCaixa($novoMovimento['codigoconta'], $novoMovimento['valorpago'], $desconto, $acrescimo, null, $formapag, $codigocontacaixa, $retTransacao['codigo']))
						$this->obTDbo->commit();
    			
    			}else{
    				throw new ErrorException("N�o foi possivel inserir o movimento de caixa.", 1);
    			}
    			
    		}
    			
	if($conta){
    		$this->obTDbo->commit();
    		$this->obTDbo->close();
		
	}
    		
    	}catch (Exception $e){
    		$this->obTDbo->rollBack();
    		new setException($e);
    	}
    	
    }
}