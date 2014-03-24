<?php
/* 
 * Classe TBiblioteca
 * Autor: Joao Felix.
 * Data: 2010-04-15
*/
class TBiblioteca {
    public function __construct() {
        // Checa usuario logado e retona o mesmo
        $this->obTDbo = new TDbo();
        $this->obLivro = new TLivro();
        $this->obPessoa = new TPessoa();
        $this->obUnidade = new TUnidade();
        $this->obData = new TSetData();


    }

    /*
         * Retorna ou estipula produto para multa da biblioteca
         * param <type> null
         * Autor: Joao Felix. Data: 2010-04-15
    */
    public function getProdutoBiblioteca() {
        try {
            $obTDbo = new TDbo(TConstantes::DBPRODUTO);
            $unidade = $this->obUnidade->getUnidade();

            $criterio = new TCriteria();
            $criterio->add(new TFilter("tabela","=",TConstantes::DBLIVRO));
            $criterio->add(new TFilter("unidseq","=",$unidade->seq));
            $ret = $obTDbo->select("seq",$criterio);

            if($obProduto = $ret->fetchObject()) {
                return $obProduto->seq;
            }else {
                $insert["label"] = "Multa Biblioteca";
                $insert["descricao"] = "Multa por atraso na devolução de livros.";
                $insert["tabela"] = TConstantes::DBLIVRO;
                $insert["valoralteravel"] = true;
                $obTDbo = new TDbo(TConstantes::DBPRODUTO);
                $ret = $obTDbo->insert($insert);
                $obTDbo->commit();
                return $ret["seq"];
            }
        }catch (Exception $e) {
            new setException($e);
        }
    }

    /*
         * Estipula valor total para a multa a ser cobrada
         * param <type> $codigopessoa
         * param <type> $dataPrevisao
         * param <type> $dataConfirmacao
         * Autor: Joao Felix. Data: 2010-04-15
    */
    public function getMulta($codigopessoa,$dataPrevisao,$dataConfirmacao) {
        try {
            if($codigopessoa) {
                $historico = $this->getHistoricoPessoa($codigopessoa);
                $parametros = $this->obUnidade->getParametro();

                $valor_dia = 0;

                if($historico->pessoa->cliente) {
                    $valor_dia = $parametros->biblioteca_valormultaatraso_aluno;
                }
                if($historico->pessoa->funcionario) {
                    $valor_dia = $parametros->biblioteca_valormultaatraso_professor;
                }

                $multa = $valor_dia * count($this->obData->setIntervalo($this->obData->dataPadraoPT($dataPrevisao),$this->obData->dataPadraoPT($dataConfirmacao)));
                return $multa;
            }else {
                throw new ErrorException("É necessário um código válido para consulta.");
            }
        }catch (Exception $e) {
            new setException($e);
            $this->obTDbo->rollback();
        }
    }

    /*
         * Retorna o valor em dias para o prazo de devolucao
         * param <type> $codigopessoa
         * Autor: Joao Felix. Data: 2010-04-15
    */
    public function getPrazoDevolucao($codigopessoa) {
        try {
            if($codigopessoa) {
                $historico = $this->getHistoricoPessoa($codigopessoa);
                $parametros = $this->obUnidade->getParametro();
                $limite = 0;
                if($historico->pessoa->cliente) {
                    $limite = $parametros->biblioteca_prazodevolucaolivro_aluno;
                }
                if($historico->pessoa->funcionario) {
                    $limite = $parametros->biblioteca_prazodevolucaolivro_professor;
                }
                return $limite;

            }else {
                throw new ErrorException("É necessário um código válido para consulta.");
            }
        }catch (Exception $e) {
            new setException($e);
            $this->obTDbo->rollback();
        }
    }

    /*
         * Retorna o valor para o numero de livros que uma pessoa pode locar
         * param <type> $codigopessoa
         * Autor: Joao Felix. Data: 2010-04-15
    */
    public function getMaximoLocacoes($codigopessoa) {
        try {
            if($codigopessoa) {
                $historico = $this->getHistoricoPessoa($codigopessoa);
                $parametros = $this->obUnidade->getParametro();

                $limite = 0;
                if($historico->pessoa->cliente) {
                    $limite = $parametros->biblioteca_limitelocacao_aluno;
                }
                if($historico->pessoa->funcionario) {
                    $limite = $parametros->biblioteca_limitelocacao_professor;
                }
                return $limite;
            }else {
                throw new ErrorException("É necessário um código válido para consulta.");
            }
        }catch (Exception $e) {
            new setException($e);
            $this->obTDbo->rollback();
        }
    }

    /*
         * Retorna valor booleano para a situacao da pessoa em relacao a Biblioteca
         * param <type> $codigopessoa
         * Autor: Joao Felix. Data: 2010-04-15
    */
    public function getSituacaoPessoa($codigopessoa) {
        try {

            if($codigopessoa) {
                $historico = $this->getHistoricoPessoa($codigopessoa);
                $parametros = $this->obUnidade->getParametro();

                $locacoes = count($historico->biblioteca->locacoes);
                $multas = count($historico->biblioteca->multas);
                $limite = $this->getMaximoLocacoes($codigopessoa);
                $saldodevedor = false;

                if($parametros->biblioteca_autorizalocacaosaldodevedor == 0) {
                    if($multas > 0) {
                        $saldodevedor = true;
                    }
                }
                if($locacoes >= $limite) {
                    return false;
                }else if($saldodevedor) {
                    return false;
                }else {
                    return true;
                }

            }else {
                throw new ErrorException("É necessário um código válido para consulta. - ".$codigopessoa);
            }
        }catch (Exception $e) {
            new setException($e);
            $this->obTDbo->rollback();
        }
    }

    /*
         * Retorna objeto com o Historico do Locador em relacao a Biblioteca
         * param <type> $codigopessoa
         * Autor: Joao Felix. Data: 2010-04-15
    */
    public function getHistoricoPessoa($codigopessoa) {
        try {
            if($codigopessoa) {
                $this->obTDbo->setEntidade(TConstantes::VIEW_LOCACAO_LIVRO);
                $criterio = new TCriteria();
                $criterio->add(new TFilter("pessseq","=",$codigopessoa));
                $retHist = $this->obTDbo->select("*",$criterio);

                $obHistorico->pessoa = $this->obPessoa->getPessoa($codigopessoa);
                $obHistorico->multas = 0;

                while($obReg = $retHist->fetchObject()) {
                    if($obReg->situacao == "1") {
                        $obHistorico->biblioteca->locacoes[$obReg->codigo] = $obReg;
                    }else if($obReg->situacao == "2") {
                        $obHistorico->biblioteca->reservas[$obReg->codigo] = $obReg;
                    }else if($obReg->situacao == "3") {
                        $obHistorico->biblioteca->devolucoes[$obReg->codigo] = $obReg;
                    }
                }

                return $obHistorico;
            }else {
                throw new ErrorException("É necessário um código válido para consulta. -".$codigopessoa);
            }
        }catch (Exception $e) {
            new setException($e);
            $this->obTDbo->rollback();
        }
    }

    /*
         * Retorna objeto com o Historico de locacoes do Livro
         * param <type> $codigolivro
         * Autor: Joao Felix. Data: 2010-04-15
    */
    public function getHistoricoLivro($codigolivro) {
        try {
            if($codigolivro) {
                $this->obTDbo->setEntidade(TConstantes::DBLOCACAO_LIVRO);
                $criterio = new TCriteria();
                $criterio->add(new TFilter("livrseq","=",$codigolivro));
                $retHist = $this->obTDbo->select("*",$criterio);

                $obHistorico->livro = $this->obLivro->getLivro($codigolivro);

                while($obReg = $retHist->fetchObject()) {
                    switch ($obReg->situacao) {
                        case "1": $obHistorico->biblioteca->locacoes[$obReg->codigo] = $obReg;
                            break;
                        case "2": $obHistorico->biblioteca->reservas[$obReg->codigo] = $obReg;
                            break;
                        case "3": $obHistorico->biblioteca->devolucoes[$obReg->codigo] = $obReg;
                            break;
                    }
                }

                return $obHistorico;
            }else {
                throw new ErrorException("É necessário um código válido para consulta. - ".$codigolivro);
            }
        }catch (Exception $e) {
            new setException($e);
            $this->obTDbo->rollback();
        }
    }

    /*
         * Define e armazena informacoes da Locacao
         * param <type> $codigolivro
         * param <type> $codigopessoa
         * Autor: Joao Felix. Data: 2010-04-15
    */
    public function setLocacao($codigolivro,$codigopessoa) {
        try {
            if($codigolivro) {
                $obLivro = $this->obLivro->getLivro($codigolivro);
                if($obLivro->pessseq == "") {
                    if($this->getSituacaoPessoa($codigopessoa)) {

                        $vet["livrseq"] = $codigolivro;
                        $vet["pessseq"] = $codigopessoa;
                        $vet["situacao"] = "1";
                        $vet["ativo"] = "1";
                        $vet["confirmacaosaida"] = $this->obData->getData();
                        $vet["previsaosaida"] = $this->obData->getData();
                        $previsaoentrada = $this->obData->calcData($this->obData->getData(),$this->getPrazoDevolucao($codigopessoa),"-");

                        if($this->obData->getDiaSemana($previsaoentrada) == 0) {
                            $previsaoentrada = $this->obData->calcData($previsaoentrada,1,"-");
                        }
                        $vet["previsaoentrada"] = $previsaoentrada;

                        $obTDbo = new TDbo(TConstantes::DBLOCACAO_LIVRO);
                        $criterio = new TCriteria();
                        $criterio->add(new TFilter("livrseq","=",$codigolivro));
                        $criterio->add(new TFilter("pessseq","=",$codigopessoa));
                        $criterio->add(new TFilter("stlvseq","=","2"));
                        $retReserva = $obTDbo->select("seq,stlvseq",$criterio);

                        while($obRetorno = $retReserva->fetchObject()) {
                            $retDados = $obTDbo->delete($obRetorno->codigo,"codigo");
                        }
                        $retDados = $obTDbo->insert($vet);
                        $vet["seq"] = $retDados["seq"];

                        return $vet;
                    }else {
                        throw new ErrorException("Locador não autorizado a adiquirir emprestimo de livros.");
                    }
                }else {
                    throw new ErrorException("O livro não está disponivel para locação.");
                }
            }else {
                throw new ErrorException("É necessário um código válido para consulta. - ".$codigolivro);
            }
        }catch (Exception $e) {
            new setException($e);
            $this->obTDbo->rollback();
        }
    }

    /*
         * Define e armazena informacoes da Devolucao
         * param <type> $codigolivro
         * param <type> $codigopessoa
         * Autor: Joao Felix. Data: 2010-04-15
    */
    public function setDevolucao($codigolivro,$codigopessoa) {
        try {
            if($codigolivro) {
                $obLivro = $this->obLivro->getLivro($codigolivro);
                if($obLivro->codigolocador != "") {
                    if($codigopessoa) {

                        $vet["livrseq"] = $codigolivro;
                        $vet["pessseq"] = $codigopessoa;
                        $vet["stlvseq"] = 3;
                        $vet["confirmacaoentrada"] = $this->obData->getData();



                        $this->obTDbo->setEntidade(TConstantes::DBLOCACAO_LIVRO);
                        $criterio = new TCriteria();
                        $criterio->add(new TFilter("livrseq","=",$codigolivro));
                        $criterio->add(new TFilter("pessseq","=",$codigopessoa));
                        $criterio->add(new TFilter("stlvseq","=","1"));
                        $retDevolucao = $this->obTDbo->select("*",$criterio);
                        $obDevolucao = $retDevolucao->fetchObject();

                        $TParametros = $this->obUnidade->getParametro();

                        if($obDevolucao) {
                            if($vet["confirmacaoentrada"] > $obDevolucao->previsaoentrada) {

                                $valortotal = $this->getMulta($codigopessoa,$obDevolucao->previsaoentrada,$vet["confirmacaoentrada"]);

                                $TTransacao = new TTransacao();

                                $TTransacao->setPessoa($codigopessoa);
                                $TTransacao->setValorNominal($valortotal);
                                //$TTransacao->setTipoMovimento('C');
                                $TTransacao->setPlanoConta($TParametros->biblioteca_planocontas);
                                $TTransacao->setAcrescimo('0.00');
                                $TTransacao->setParcelas('1');
                                $TTransacao->setVencimento(date("Y-m-d", mktime(0, 0, 0,date("m"),date("d") + $TParametros->biblioteca_vencimentomulta, date("Y"))));

                                //retorna produto taxa de inscrição=========
                                $prodBiblioteca = new TProduto();
                                $codigoProduto =  $this->getProdutoBiblioteca();
                                $obprodBiblioteca = $prodBiblioteca->getProduto('seq', $codigoProduto);
                                //==========================================

                                $TTransacao->addProduto($obprodBiblioteca);
                                $TTransacao->setObs("Multa por atraso na entrega do livro ".$obLivro->titulo."(".$codigolivro.")");
                                $TTransacao->setNumContas(1);

                                $codigotransacao = $TTransacao->run();
                                if($codigotransacao) {
                                    $codigoContaM = $TTransacao->getCodigoContas();
                                    $codigoContaM = $codigoContaM[0];

                                }

                            }
                            $tobTDbo = new TDbo(TConstantes::DBLOCACAO_LIVRO);
                            $criterio2 = new TCriteria();
                            $criterio2->add(new TFilter("seq","=",$obDevolucao->seq));
                            $retDados = $tobTDbo->update($vet,$criterio2);

                            $vet['transeq'] = $codigotransacao;
                            $vet['parcseq']    = $codigoContaM;
                            $vet['multa']          = $valortotal;
                            $vet["seq"] = $obDevolucao->codigo;
                            $vet["previsaoentrada"] = $obDevolucao->previsaoentrada;
                            $vet["confirmacaosaida"] = $obDevolucao->confirmacaosaida;

                        }else {
                            throw new ErrorException("emprestimo não encontrado.");
                        }

                        return $vet;
                    }else {
                        throw new ErrorException("Locador não autorizado a adiquirir emprestimo de livros.");
                    }
                }else {
                    throw new ErrorException("O livro não está disponivel para locação.");
                }
            }else {
                throw new ErrorException("É necessário um código válido para consulta.");
            }
        }catch (Exception $e) {
            new setException($e);
            $this->obTDbo->rollback();
        }
    }

   public function setReserva($codigopessoa,$codigolivro) {

        $dbo = new TDbo(TConstantes::DBLOCACAO_LIVRO);
        $data['pessseq'] = $codigopessoa;
        $data['livrseq'] = $codigolivro;
        $data['stlv'] = '2';

        if($dbo->insert($data)){
            echo "Reserva concluída com sucesso.";
        }else{
            echo "Não foi possível concluir a reserva.<br/> Tente mais tarde.";
        }

   }

    /*
         * Retorna TElement para a visualizacao da Devolucao
         * param <type> $codigoRegistro
         * Autor: Joao Felix. Data: 2010-04-15
    */

    public function viewSetDevolucao($codigoRegistro) {

        $this->obTDbo->setEntidade(TConstantes::DBLOCACAO_LIVRO);
        $criterio = new TCriteria();
        $criterio->add(new TFilter("seq","=",$codigoRegistro));
        $retDevolucao = $this->obTDbo->select("*",$criterio);
        $obDevolucao = $retDevolucao->fetchObject();

        $obPessoa = $this->getHistoricoPessoa($obDevolucao->pessseq);

        $tabHead = new TElement("fieldset");
        $tabHead->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
        $tabHeadLegenda = new TElement("legend");
        $tabHeadLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
        $tabHeadLegenda->add("Informações do Locador");
        $tabHead->add($tabHeadLegenda);

        $obFieds = new TSetfields();
        $obFieds->geraCampo("Cod.:", 'seq', "TEntry", '');
        $obFieds->setProperty('seq', 'disabled', 'disabled');
        $obFieds->setValue("seq", $obPessoa->pessoa->seq);

        $obFieds->geraCampo("Nome:", 'pessoa', "TEntry", '');
        $obFieds->setProperty('pessoa', 'disabled', 'disabled');
        $obFieds->setProperty('pessoa', 'size', '100');
        $obFieds->setValue("pessoa", $obPessoa->pessoa->pessnmrz);

        $content = new TElement('div');
        $content->class = "ui_bloco_conteudo";
        $content->add($obFieds->getConteiner());
        $tabHead->add($content);

        $obLivro = $this->getHistoricoLivro($obDevolucao->livrseq);

        $tablivro = new TElement("fieldset");
        $tablivro->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
        $tablivroLegenda = new TElement("legend");
        $tablivroLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
        $tablivroLegenda->add("Informações do livro");
        $tablivro->add($tablivroLegenda);

        $obFieds = new TSetfields();
        $obFieds->geraCampo("Cod.:", 'seq', "TEntry", '');
        $obFieds->setProperty('seq', 'disabled', 'disabled');
        $obFieds->setValue("seq", $obLivro->livro->seq);

        $obFieds->geraCampo("Titulo:", 'titulo', "TEntry", '');
        $obFieds->setProperty('titulo', 'disabled', 'disabled');
        $obFieds->setProperty('titulo', 'size', '100');
        $obFieds->setValue("titulo", $obLivro->livro->titulo);

        $obFieds->geraCampo("Autor:", 'autor', "TEntry", '');
        $obFieds->setProperty('autor', 'disabled', 'disabled');
        $obFieds->setProperty('autor', 'size', '60');
        $obFieds->setValue("autor", $obLivro->livro->autor);

        $obFieds->geraCampo("Editora:", 'editora', "TEntry", '');
        $obFieds->setProperty('editora', 'disabled', 'disabled');
        $obFieds->setProperty('editora', 'size', '60');
        $obFieds->setValue("editora", $obLivro->livro->editora);

        $obFieds->geraCampo("ISBN:", 'isbn', "TEntry", '');
        $obFieds->setProperty('isbn', 'disabled', 'disabled');
        $obFieds->setProperty('isbn', 'size', '40');
        $obFieds->setValue("isbn", $obLivro->livro->isbn);

        $content = new TElement('div');
        $content->class = "ui_bloco_conteudo";
        $content->add($obFieds->getConteiner());
        $tablivro->add($content);


        $retDevolucao = $this->setDevolucao($obDevolucao->livrseq,$obDevolucao->pessseq);
        $TSetModel = new TSetModel();

        $tabDevolucao = new TElement("fieldset");
        $tabDevolucao->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
        $tabDevolucaoLegenda = new TElement("legend");
        $tabDevolucaoLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
        $tabDevolucaoLegenda->add("Devolução");
        $tabDevolucao->add($tabDevolucaoLegenda);

        $obFieds = new TSetfields();
        $obFieds->geraCampo("Cod.:", 'seq', "TEntry", '');
        $obFieds->setProperty('seq', 'disabled', 'disabled');
        $obFieds->setValue("seq", $retDevolucao["seq"]);

        $obFieds->geraCampo("Data do Emprestimo:", 'confirmacaosaida', "TEntry", '');
        $obFieds->setProperty('confirmacaosaida', 'disabled', 'disabled');
        $obFieds->setProperty('confirmacaosaida', 'size', '10');
        $obFieds->setValue("confirmacaosaida", $TSetModel->setDataPT($retDevolucao["confirmacaosaida"]));

        $obFieds->geraCampo("Data agendada para a entrega:", 'previsaoentrada', "TEntry", '');
        $obFieds->setProperty('previsaoentrada', 'disabled', 'disabled');
        $obFieds->setProperty('previsaoentrada', 'size', '10');
        $obFieds->setValue("previsaoentrada", $TSetModel->setDataPT($retDevolucao["previsaoentrada"]));

        $obFieds->geraCampo("Data do retorno:", 'confirmacaoentrada', "TEntry", '');
        $obFieds->setProperty('confirmacaoentrada', 'disabled', 'disabled');
        $obFieds->setProperty('confirmacaoentrada', 'size', '10');
        $obFieds->setValue("confirmacaoentrada", $TSetModel->setDataPT($retDevolucao["confirmacaoentrada"]));

        if( $retDevolucao["multa"] != 0) {

            $obFieds->geraCampo("Valor da Multa:", 'multa', "TEntry", '');
            $obFieds->setProperty('multa', 'disabled', 'disabled');
            $obFieds->setProperty('multa', 'size', '10');
            $obFieds->setValue("multa", "R$ " . $TSetModel->setMoney($retDevolucao["multa"]));

            $botaoEdit = new TButton('editar');
            $botaoEdit->id = "boleto";
            $botaoEdit->value = "Imprimir boleto";
            $botaoEdit->setProperty("onclick", "showBoleto('".$retDevolucao["parcseq"]."')");
            $botaoEdit->setAction(new TAction(""), "Imprimir boleto");
            $obFieds->addObjeto($botaoEdit);
        }

        $sucesso = new TElement("div");
        $sucesso->align   = 'center';
        $sucesso->class = "ui-state-highlight sucesso";
        $sucesso->style = "font-size: 1.8em";
        $sucesso->add("Devolução efetivada com sucesso.");

        $content = new TElement('div');
        $content->class = "ui_bloco_conteudo";
        $content->add($obFieds->getConteiner());
        $content->add($botaoEdit);
        $tabDevolucao->add($content);
        $tabDevolucao->add($sucesso);

        $retorno = new TElement("div");
        $retorno->add($tabHead);
        $retorno->add($tablivro);
        $retorno->add($tabDevolucao);
        return $retorno;
    }

    /*
         * Retorna TElement para visualizacao da Locacao
         * param <type> $codigolivro
         * param <type> $codigopessoa
         * Autor: Joao Felix. Data: 2010-04-15
    */
    public function viewSetLocacao($codigolivro = "null",$codigopessoa = "null") {
        $lista = null;
        if($codigopessoa == "null") {
            $mensagem = new TElement("div");
            $mensagem->class = "sucesso";
            $mensagem->style = "font-size: 20px;";
            $mensagem->add("É necessario escolher um locador primeiro.");
        }else {

            if($codigolivro == "null") {
                $mensagem = new TElement("div");
                $mensagem->class = "sucesso";
                $mensagem->style = "font-size: 20px;";
                $mensagem->add("É necessario escolher um livro valido.");
            }else {
                if($this->getSituacaoPessoa($codigopessoa)) {
                    if($locacao = $this->setLocacao($codigolivro,$codigopessoa)) {
                        $mensagem = new TElement("div");
                        $mensagem->class = "sucesso ui-state-highlight";
                        $mensagem->style = "font-size: 20px;";
                        $mensagem->add("Locação confirmada com sucesso.");
                    }else {
                        $mensagem = new TElement("div");
                        $mensagem->class = "sucesso ui-state-error";
                        $mensagem->style = "font-size: 20px;";
                        $mensagem->add("O locador não está autorizado a retirar livros.");
                    }

                }else {
                    $mensagem = new TElement("div");
                    $mensagem->class = "sucesso ui-state-error";
                    $mensagem->style = "font-size: 20px;";
                    $mensagem->add("O locador não está autorizado a retirar livros.");
                }
            }
        }
        $obPessoa = $this->getHistoricoPessoa($codigopessoa);

        $lista = new TDataGrid();

        $lista->addColumn(new TDataGridColumn('seq', 'Cod. Locação', 'center', '20%'));
        $lista->addColumn(new TDataGridColumn('titulolivro', 'Titulo', 'center', '25%'));
        $lista->addColumn(new TDataGridColumn('autorlivro', 'Autor', 'center', '25%'));
        $lista->addColumn(new TDataGridColumn('codigolivro', 'Cod. Livro', 'center', '20%'));
        $lista->addColumn(new TDataGridColumn('confirmacaosaida', 'Locação', 'center', '5%'));
        $lista->addColumn(new TDataGridColumn('previsaoentrada', 'Devolução', 'center', '5%'));
        $lista->createModel('100%');
        
        $TSetModel = new TSetModel();
        if($obPessoa->biblioteca->locacoes){
            foreach ($obPessoa->biblioteca->locacoes as $ch=>$loc) {
                $tempDisc['seq'] = $ch;
                $tempDisc['titulolivro'] = $loc->titulolivro;
                $tempDisc['autorlivro'] = $loc->autorlivro;
                $tempDisc['codigolivro'] = $loc->codigolivro;
                $tempDisc['confirmacaosaida'] = $TSetModel->setDataPT($loc->confirmacaosaida);
                $tempDisc['previsaoentrada'] = $TSetModel->setDataPT($loc->previsaoentrada);

                $lista->addItem($tempDisc);
            }
        }
        $retorno = new TElement("div");
        $retorno->add($mensagem);
        $retorno->add($lista);
        return $retorno;
    }


    public function viewReserva($codigo){

        $infoLivro = new TDbo(TConstantes::VIEW_LIVRO);
        $crit = new TCriteria();
        $crit->add(new TFilter('patrseq','=',$codigo));
        $retLivro = $infoLivro->select('*',$crit);

        if($obLivro = $retLivro->fetchObject()){
            
            $login = new TCheckLogin();
            $login = $login->getUser();
            $codigoUsuario = $login->pessseq;

        $sinopse = new TElement("fieldset");
        $sinopse->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
        $sinopse->style = "height: 100%; text-align: left;";
        $sinopseLegenda = new TElement("legend");
        $sinopseLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
        $sinopseLegenda->add("Sinópse");
        $sinopse->add($sinopseLegenda);

        $divSinopse = new TElement('div');
        $divSinopse->style = "text-align: justify; text-ident: 10px; font-size: 12px; margin-top: 20px;";
        $divSinopse->add(str_replace("\r\n",'<br/>', $obLivro->sinopse));
        $sinopse->add($divSinopse);


        $foto = new TElement("fieldset");
        $foto->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
        $foto->style = "height: 100%;";
        $fotoLegenda = new TElement("legend");
        $fotoLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
        $fotoLegenda->add("Foto");
        $foto->add($fotoLegenda);

        $divFoto = new TElement('div');
        $divFoto->style = "text-align: center; font-size: 12px; margin-top: 5px";
        $divFoto->add('<img src="'.$obLivro->foto.'" height="140px" border="0"/><br/>');
        $divFoto->add('<b>ISBN: </b>'.$obLivro->isbn);
        $foto->add($divFoto);

        $informacoes = new TElement("fieldset");
        $informacoes->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
        $informacoes->style = "height: 100%;";
        $informacoesLegenda = new TElement("legend");
        $informacoesLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
        $informacoesLegenda->add("Informações");
        $informacoes->add($informacoesLegenda);
        $informacoesDiv = new TElement('div');
        $informacoesDiv->style = "text-align: left; font-size: 12px; padding: 5px;";
        $informacoesDiv->add('<b>Titulo: </b>'.$obLivro->titulo.'<br/>');
        $informacoesDiv->add('<b>Autor: </b>'.$obLivro->autor.'<br/>');
        if($obLivro->outrosautores != null){
            $informacoesDiv->add('<b>Outros autores: </b>'.$obLivro->outrosautores.'<br/>');
        }
        $informacoesDiv->add('<b>Editora: </b>'.$obLivro->editora.'<br/>');
        $informacoesDiv->add('<b>Volume: </b>'.$obLivro->volume.'<br/>');
        $informacoesDiv->add('<b>Edição: </b>'.$obLivro->edicao.'<br/>');
        $informacoesDiv->add('<b>Idioma: </b>'.$obLivro->idioma.'<br/>');
        $informacoesDiv->add('<b>Nº de Paginas: </b>'.$obLivro->paginas.'<br/>');
        $informacoesDiv->add('<b>Ano: </b>'.$obLivro->ano.'<br/>');

        $informacoes->add($informacoesDiv);


        $table = new TTable();
        $table->width = "100%";
        $table->height = "400px";

        $row = $table->addRow();
        $cell = $row->addCell($sinopse,'th');
        $cell->rowspan = "3";
        $cell->width = "70%";
        $cell->style = "vertical-align: top;";

        $cell2 = $row->addCell($foto);
        $cell2->style = "vertical-align: top;";

        $row->height = '150px';

        $row2 = $table->addRow();
        $cell1 = $row2->addCell($informacoes);
        $cell1->style = "vertical-align: top;";


        $reserva = new TElement("fieldset");
        $reserva->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
        $reserva->style = "height: 100%; text-align: left;";
        $reservaLegenda = new TElement("legend");
        $reservaLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
        $reservaLegenda->add("Situação");
        $reserva->add($reservaLegenda);

        $divReserva = new TElement('div');
        $divReserva->id = 'retornoReservaLivroAluno';
        $divReserva->style = "text-align: center; text-ident: 10px; font-size: 12px; margin: 10px;";

        $situacao = $obLivro->pessseq != '' ? 'Locado' : 'Disponível';

        $butReservar = '<input id="reservar" style="padding-left: 10px; padding-right: 10px; padding-top: 2px; padding-bottom: 2px; margin-top: 2px; margin-right: 2px; margin-bottom: 2px; margin-left: 4px; font-size: 12px; " name="reservar" type="button" value="Reservar" class="ui-state-default ui-corner-all" onclick="setReservaLivroAluno(\''.$codigoUsuario.'\',\''.$obLivro->codigolivro.'\')">';

        $divReserva->add($situacao);
        $divReserva->add($butReservar);

        $reserva->add($divReserva);

        $row = $table->addRow();
        $cell = $row->addCell($reserva,'th');
        $cell->width = "50px";
        $cell->style = "vertical-align: top;";


        $div = new TElement('div');
        $div->add($table);
        }else{
            $div = new TElement('div');
            $div->add('Não há informações sobre o livro.');
        }

        return $div;
    }
}