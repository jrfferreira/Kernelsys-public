<?php
/*
 * classe TSetlista
 * prove metodos para exibição de uma lista com funcionalidades pre-definidas
*/

class TSetlista {

    public  $datagrid;			// Objeto datagrid
    private $entity;			// Armazena a entidade/tabela que sera acessada
    public  $topCols        = array();
    public  $obCols         = array();
    public  $actions        = array();
    private $listCols       = array();
    public  $posicao        = "0";// armazena o posicionamento da listagem
    private $limitePadrao   = "20"; // delimita o número de registro da listagem
    private $visibilidade   = NULL;
    private $criteria       = NULL;
    private $trigger;
    private $itens          = array();
    private $listaSelecao   = null;
    public  $limite 		= 20;

    public function __construct($idLista, $entidade, $label, $retGlobal = NULL) {
    	

        $this->idLista = $idLista;

        //Retorna Usuario logado===================================
        $obUser = new TCheckLogin();
        $this->obUser = $obUser->getUser();
        //=========================================================

//        $this->obHeader = new TSetHeader();
//        $this->headerLista = $this->obHeader->getHead($this->idLista);

        $this->obsession = new TSession();
        $this->pathDB = $this->obsession->getValue('pathDB');
        $this->ordem  = $this->obsession->getValue('orderFilter');

        $this->datagrid = new TDataGrid;
        $this->entity 	  = $entidade;
        $this->label 	  = $label;
        $this->campoChave = $campoChave; //configura coluna que representa o campo chave da lista
        $this->listCols['id'] = "id";
        $this->listCols['codigo'] = "codigo";

        //Objeto criteria
        $this->criteria = new TCriteria();

        $limite = $this->obsession->getValue("comboLimite" . $idLista);
        if(!empty($limite)){
        	$this->limite = $limite;
        }
        if(!$this->limite) {
            $this->setLimite($this->limitePadrao);
        }

        $this->paneRet = $retGlobal;
        $this->idForm = $idForm;

        $this->itens['*'] = "Todos as colunas";
    }

    /**
     * Configura id da lista
     *param id lista = ?
     */
    public function setCampoChave($campoChave) {
        $this->campoChave = $campoChave;
    }

    /**
     * Configura ivisibilidade das colunas da listagem
     *param coluna = coluna a ser aplicada a visibilidade
     *param visibilidade = tipo da visibilidade (true / false)
     */
    public function setVisibilidade($col, $visibilidade) {
        $this->visibilidade[$col] = $visibilidade;
    }

    /*Método addTop
	* adiciona colunas
    */
    public function addTop($obCol) {
        
        //Valida duplicação de colunas
        if(array_key_exists($obCol->coluna, $this->obCols) === false) {


            //largura total da lista
            $this->totalWidth = $this->totalWidth+$obCol->largura;

            //configura os itens do combo de colunas
            $this->itens[$obCol->coluna] = $obCol->label;

            //aloca objetos coluna
            $this->obCols[$obCol->coluna] = $obCol;

            // monta lista de colunas para o Reload
            $this->listCols[$obCol->coluna] = $obCol->label;

            //instacia objeto coluna para a datagrid
             $this->topCols[$obCol->coluna] = new TDataGridColumn($obCol->coluna, $obCol->label, $obCol->alinhadados, $obCol->largura);

            //compilia visibilidade da coluna
            if($this->visibilidade[$obCol->coluna] == NULL or $this->visibilidade[$obCol->coluna] == true) {
                $this->topCols[$obCol->coluna]->setVisibilidade(true);
            }
            else {
                $this->topCols[$obCol->coluna]->setVisibilidade(false);
            }

            //instancia fun��es para a coluna
            if($obCol->colfunction != "-") {
                $this->topCols[$obCol->coluna]->setTransformer($obCol->colfunction);
            }

            if($metodo == NULL) {
                $metodo = 'onOrder';
            }
            //gera ação de ordenação
            $ActionOrdem = new TSetAction('prossExe');
            $ActionOrdem->setMetodo($metodo);
            $ActionOrdem->setTipoRetorno('lista');
            $ActionOrdem->setIdForm($this->idLista);
            $ActionOrdem->setKey($obCol->coluna);
            $ActionOrdem->setAlvo($this->paneRet);
            $this->topCols[$obCol->coluna]->setAction($ActionOrdem->getAction());

            $this->datagrid->addColumn($this->topCols[$obCol->coluna]);
        }
    }

    /**
     * intancia IDs reais p/ ações relacionadas a listas setadas.
     * param $idReal = lista de ids reais da lista principal
     */
    public function setId(array $idReal) {
        $this->idReal = $idReal;
    }

    /**
     * Seta o atributo trigger no contexo do objeto
     * param <type> $trigger
     */
    public function setTrigger($trigger){
        $this->trigger = $trigger;
    }

    /**
    * Adiciona criterio de retorno da listagem
    * param <type> $col = coluna
    * param <type> $dado = argumento do criterio
    * param <type> $comp = operador lógico ex: =, <, !=
    * param <type> $operador = operador ex: AND, OR
    * param <type> $tipoFiltro = tipo do criterio ( 1 = filtro padrão 2 = criterio de pesquisa )
    */
    public function addCriterio($col, $dado, $comp, $operador = NULL, $tipoFiltro = "1") {

        if($col) {
            if($comp == 'ILIKE') {
                $dado =  '%'.$dado.'%';
            }
            $obFiltro = new TFilter($col, $comp, $dado);
            $obFiltro->tipoFiltro = $tipoFiltro;
            $obFiltro->operador = $operador;

            $this->listaCriterios[] = $obFiltro;
        }
    }

    /**
     *Método clear()
     *limpa fitros da lista de dados
     */
    public function clear($codCriteria = NULL) {

        if(count($this->listaCriterios) >0) {
            foreach($this->listaCriterios as $pos=>$flt) {

                if($flt->tipoFiltro == "2") {
                    unset($this->listaCriterios[$pos]);
                }
            }
        }

        $this->criteria = new TCriteria();
        $this->obsession->setValue('boxFiltro_'.$this->idLista, NULL);
        $this->loaded = false;
        unset($_SESSION['boxFiltro_'.$this->idLista]);
    }


    /**
     * Método setFiltro Padrão
     * configura um filtro padrão para lista
     * param dados = Dados do filtro expressão / coluna / manter filtro
     */
    public function setFiltro($dados) {

        if($dados['expre'.$this->idLista] != "") {

            // Verifica o campo data a ser aplicada na expressão do filtro padrão ======
            $obMasc = new TSetMascaras();
            $dados['expre'.$this->idLista] = $obMasc->setDataDb($dados['expre'.$this->idLista]);
            //==========================================================================

            // Se manter filtro for ativado
            if($dados['Manterfilt'.$this->idLista] == 'true') {

                //garda argumetos do filtro
                $argFiltro = $this->obsession->getValue('boxFiltro_'.$this->idLista);
                $argFiltro['Manterfilt'.$this->idLista] = $dados['Manterfilt'.$this->idLista];

                if(!is_array($dados['expre'.$this->idLista])) {

                    if(!is_array($argFiltro['expre'.$this->idLista])) {
                        $vetArgs[0] = $argFiltro['expre'.$this->idLista];
                    }else {
                        $vetArgs = $argFiltro['expre'.$this->idLista];
                    }
                    $vetArgs[] = $dados['expre'.$this->idLista];
                }else {
                    $vetArgs = $dados['expre'.$this->idLista];
                }
                $argFiltro['expre'.$this->idLista] = $vetArgs;

                if(!is_array($dados['cols'.$this->idLista])) {

                    if(!is_array($argFiltro['cols'.$this->idLista])) {
                        $vetcols[0] = $argFiltro['cols'.$this->idLista];
                    }else {
                        $vetcols = $argFiltro['cols'.$this->idLista];
                    }
                    $vetcols[] = $dados['cols'.$this->idLista];
                }else {
                    $vetcols = $dados['cols'.$this->idLista];
                }
                $argFiltro['cols'.$this->idLista] = $vetcols;
                $this->obsession->setValue('boxFiltro_'.$this->idLista, $argFiltro);

                //----------------------------------------------------------------------
                //monta critério de pesquisa em todas as colunas da tabela em questão.
                if($dados['cols'.$this->idLista] === "*") {

                    //while($getcols = $runCols->fetchObject()){
                    foreach($this->listCols as $colId=>$colLabel) {
                        foreach($argFiltro['expre'.$this->idLista] as $mArgs) {
                            if($colId != "id" and $colId != "codigo" and $colId != "unidade" and $colId != "ativo") {
                                $this->addCriterio($colId, $mArgs, 'ILIKE', $operadorFiltro, $tipoFiltro = "2");
                                $operadorFiltro = "OR";
                            }
                        }
                        $operadorFiltro = "AND";
                    }

                    //}

                }else {
                    foreach($argFiltro['expre'.$this->idLista] as $ct=>$mArgs) {
                        $operadorFiltro = "AND";
                        $this->addCriterio($argFiltro['cols'.$this->idLista][$ct], $mArgs, 'ILIKE', $operadorFiltro, $tipoFiltro = "2");
                    }
                }

            }
            else {

                //limpa filtro
                $this->clear();
                $this->obsession->setValue('boxFiltro_'.$this->idLista, NULL);
                $argFiltro = array();

                //garda argumetos do filtro
                $this->obsession->delValue('boxFiltro_'.$this->idLista);
                $argFiltro['cols'.$this->idLista] = $dados['cols'.$this->idLista];
                $argFiltro['Manterfilt'.$this->idLista] = $dados['Manterfilt'.$this->idLista];
                $argFiltro['expre'.$this->idLista] = $dados['expre'.$this->idLista];
                $this->obsession->setValue('boxFiltro_'.$this->idLista, $argFiltro);

                //----------------------------------------------------------------------
                //monta criterio de pesquisa em todas as colunas da tabela em questão.
                if($dados['cols'.$this->idLista] === "*") {

                    foreach($this->listCols as $colId=>$colLabel) {
                        if($colId != "id" and $colId != "codigo" and $colId != "unidade" and $colId != "ativo") {
                            $this->addCriterio($colId, $dados['expre'.$this->idLista], 'ILIKE', 'OR', "2");
                        }
                    }

                }else {
                    $this->addCriterio($dados['cols'.$this->idLista], $dados['expre'.$this->idLista], 'ILIKE', NULL, "2");
                }
            }
            $this->loaded = false;
        }
    }

    /**
     * Adiciona criterio de ordenação ao
     * objeto criteria
     * param coluna = creterio de ordenação
     */
    public function setOrdem($ordem) {
        if($this->listaOrder == $ordem) {
            $ordem .= ' desc';
        }
        $this->listaOrder = $ordem;
        $this->loaded = false;
    }

    /**
     * Adiciona limite de listagem ao
     * ao objeto criteria
     * param limite = número de linhas limite para a listagem
     */
    public function setLimite($lim = null) {
    	if(!empty($lim)){
        $this->limite = $lim;
    	}else{
        $this->limite = $this->limitePadrao;    		
    	}
    	
    	$this->loaded = false;
    }


    /**
     * Método setPosition()
     * Gerencia os criterios da posição da lista.
     * param  posição = posição da paginação da listagem
     */
    public function setPosition($posicao) {
        $this->posicao = $posicao;
        //paginação
        if($this->posicao == "") {
            $this->posicao = '0';
        }
        if($this->limite && is_numeric($this->limite)){
            $limite = $this->limite.' OFFSET '.$this->posicao;
        }
        $this->limiteParam = $limite;
        $this->loaded = false;
    }

    /**
     * Deleta registro da lista
     * param codigo = codigo do registro a ser deletado
     * param endidade = entidade(tabela) alvo da ação
     */
    public function onDelete($codigo, $entidade) {

        //deleta o registro baseado no campoChave passado na definição da lista pelo construtor
        $dbo = new TDbo($entidade);
        $result = $dbo->delete($codigo, $this->campoChave);

        $this->loaded = false;
    }

    /**
     * addBot()
     * param  $botNav = objeto botão da bara de navegação
     */
    public function addBot($botNav) {
        $this->botsNav[] = $botNav;
    }

    /*Método setNav()
	* configura a barra navegadora do browser
	* param    idFiltro = id para configuração do botão filtrar( Id da janela)
    */
    private function setNav($idFiltro){

        // configura botões de navegação =======================================
        $ActionBack = new TSetAction('prossExe');
        $ActionBack->setMetodo('onBack');
        $ActionBack->setTipoRetorno('lista');
        $ActionBack->setIdForm($this->idLista);
        $ActionBack->setAlvo($this->paneRet);
        $this->bt['btBack'] = new TIcon("ui-icon-seek-prev", "icons_btBack");
        $this->bt['btBack']->setAction($ActionBack);
        $this->bt['btBack']->setTitle("Voltar");
        if($this->posicao<=1) {
            $this->bt['btBack']->setEditable(false);
        }
        //$this->bt['btBack'] = new TButton('btBack');
        //$this->bt['btBack']->setAction($ActionBack, '<<');
        //$this->bt['btBack']->style = "width:40px;";

        $ActionNext = new TSetAction('prossExe');
        $ActionNext->setMetodo('onNext');
        $ActionNext->setTipoRetorno('lista');
        $ActionNext->setIdForm($this->idLista);
        $ActionNext->setAlvo($this->paneRet);
        $this->bt['btNext'] = new TIcon("ui-icon-seek-next", "icons_btNext");
        $this->bt['btNext']->setAction($ActionNext);
        $this->bt['btNext']->setTitle("Avançar");
        if($this->NumRows<=$this->limite or ($this->posicao+$this->limite)>=$this->NumRows) {
            $this->bt['btNext']->setEditable(false);
        }
        //$this->bt['btNext'] = new TButton('btNext');
        //$this->bt['btNext']->setAction($ActionNext, '>>');
        //$this->bt['btNext']->style = "width:40px;";
        //======================================================================

        // botão configurar visibilidade das colunas ===========================
        if($this->botColunas) {
            $this->bt['btColunas'] = new TButton('btColunas');
            $ActionSetCols = new TSetAction('prossExe');
            $ActionSetCols->setMetodo('onVisibilidade');
            $ActionSetCols->setTipoRetorno('lista');
            $ActionSetCols->setIdForm($this->idLista);
            $ActionSetCols->setAlvo($this->paneRet);
            $this->bt['btColunas']->setAction($ActionSetCols->getAction(), 'Colunas');
            $this->bt['btColunas']->style = "width:60px;";
        }
        //======================================================================

        // configura botões de navegação =======================================
        $this->bt['btPrint'] = new TIcon("ui-icon-print", "icons_btPrint");
        $this->bt['btPrint']->setAction('printDataGrid('.$this->idLista.','.$this->paneRet.')');
        $this->bt['btPrint']->setTitle("Imprimir");

        $NavLista = new TElement('div');
        $NavLista->id = "barraNav";
        $NavLista->class = "ui-bar-navegation ui-state-hover";

        //posição de visualização=======================================
        $VisFim = $this->posicao+$this->limite;
        if($VisFim>$this->NumRows) {
            $VisFim = $this->NumRows;
        }
        //==============================================================

        $BtNavs = new TElement('span');
        $BtNavs->class = "button ui-box";
        //$BtNavs->style = 'border:1px solid #0000cc; ';
        $BtNavs->add($this->bt['filtro']);
        $BtNavs->add($this->bt['lpfiltro']);

        $BtNavs->add($this->bt['btColunas']);

        if(count($this->botsNav)>0) {
            foreach($this->botsNav as $bots) {
                $NavLista->add($bots);
            }
        }

        //$BtNavs->add($this->bt['btBack']);
        //$BtNavs->add($this->posicao.' / '.$VisFim);
        //$BtNavs->add($this->bt['btNext']);
        //$NavLista->add($BtNavs);

        
        $NTotal = new TElement('span');
        $NTotal->class = "button ui-box ui-widget-content ui-corner-all";
        $NTotal->add('Total: '.number_format($this->NumRows,0,'','.'));
        $NavLista->add($NTotal);

        $dispNav = new TElement('span');
        $dispNav->class = "button ui-box ui-widget-content ui-corner-all";
        $dispNav->add($this->posicao.' / '.$VisFim);
        $NavLista->add($this->bt['btBack']);
        $NavLista->add($dispNav);
        $NavLista->add($this->bt['btNext']);

        $LabelLista = new TElement('span');
        $LabelLista->class = 'button ui-box ui-widget-content ui-corner-all';
        $LabelLista->add('Lista: '.$this->label);
        $NavLista->add($LabelLista);

        $NavLista->add($this->bt['btPrint']);
        
    	$this->onLimite();
        if($this->comboLimite){
        	$LabelLimite = new TElement('span');
	        $LabelLimite->add($this->comboLimite);
	        $NavLista->add($LabelLimite);
        }

        return $NavLista;
    }

    /**
     * Método setColunas
     * monta formulario de configuração da visibilidade das colunas
     */
    public function setColunas() {

    }

    /**
     * Método setFiltro
     * monta formulário de filtro da lista de dados
     */
    public function onFiltro() {

        //Instacia campos do formulário de filtro de dados
        $this->Campos['expre'.$this->idLista] = new TEntry('expre'.$this->idLista);
        $this->Campos['expre'.$this->idLista]->setSize('220');
        $this->Campos['expre'.$this->idLista]->onkeyup = "runEnter('icons_Pesq".$this->idLista."', event)";

        // manter o ultimo argumento no campo de expressão =============
//        $argumentoFiltro = $this->obsession->getValue('boxFiltro_'.$this->idLista);
//
//        if(is_array($argumentoFiltro['expre'.$this->idLista])) {
//            $numArg = count($argumentoFiltro['expre'.$this->idLista])-1;
//
//            $this->Campos['expre'.$this->idLista]->setValue($argumentoFiltro['expre'.$this->idLista][$numArg]);
//        }else {
//            $this->Campos['expre'.$this->idLista]->setValue($argumentoFiltro['expre'.$this->idLista]);
//        }
        //==============================================================


        $this->Campos['cols'.$this->idLista] = new TCombo('cols'.$this->idLista, false);
        $this->Campos['cols'.$this->idLista]->setSize('150');
            if(is_array($argumentoFiltro['cols'.$this->idLista]) and $numArg) {
                $this->Campos['cols'.$this->idLista]->setValue($argumentoFiltro['cols'.$this->idLista][$numArg]);
            }
//            if(is_array($this->itens)) {
//                array_unshift($this->itens, "todas as colunas");
//            }
        $this->Campos['cols'.$this->idLista]->addItems($this->itens);

        $this->Campos['Manterfilt'.$this->idLista] = new TCheckButton('Manterfilt'.$this->idLista);
        $this->Campos['Manterfilt'.$this->idLista]->setValue(1);

        //$this->Campos['filtrar'] = new TButton('filtrar');
        $ActionFilter = new TSetAction('prossExe');
        $ActionFilter->setMetodo('onFilter');
        $ActionFilter->setTipoRetorno('lista');
        $ActionFilter->setIdForm($this->idLista);
        $ActionFilter->setAlvo($this->paneRet);
        //$this->Campos['filtrar']->setAction($ActionFilter, 'Filtrar');
        //$this->Campos['filtrar']->style = "width:80px;";

        //$this->Campos['lpfiltro'] = new TButton('lpfiltro');
        $ActionClearFilter = new TSetAction('prossExe');
        $ActionClearFilter->setMetodo('onClearFilter');
        $ActionClearFilter->setTipoRetorno('lista');
        $ActionClearFilter->setIdForm($this->idLista);
        $ActionClearFilter->setAlvo($this->paneRet);
        //$this->Campos['lpfiltro']->setAction($ActionClearFilter, 'Limpar Filtro');
        //$this->Campos['lpfiltro']->style = "width:80px;";

        //bontão de pesquisa
        $botPesq = new TIcon("ui-icon-search", "icons_Pesq".$this->idLista);
        $botPesq->setAction($ActionFilter);
        $botPesq->setTitle("Filtrar");

        //bontão limpa pesquisa
        $botLimpa = new TIcon("ui-icon-refresh", "icons_Limpar".$this->idLista);
        $botLimpa->setAction($ActionClearFilter);
        $botLimpa->setTitle("Limpar Filtro");

        //bontão de informação da pesquisa
        $botInfo = new TIcon("ui-icon-info", "icons_Pesq".$this->idLista);
        //$botInfo->setAction($ActionClearFilter);
        $botInfo->setTitle("Informações do Filtro");

        //instancia e cofigura conteiner do filtro
        $this->Filtro = new TTable();
        $this->Filtro->bgcolor 		= '#F4F4F4';
        $this->Filtro->width 		= '100%';
        $this->Filtro->cellpadding	= "1";
        $this->Filtro->cellspacing 	= "2";
        $this->Filtro->border = "0";
        $this->Filtro->style  = 'font-family:Arial; font-size:12px;  border-bottom:2px solid #cccccc; BACKGROUND-IMAGE: url(app.images/box_barra.png); background-repeat: repeat-x; background-color:#FDFDFC;';

        $RowExp = $this->Filtro->addRow();

        $cellExp = $RowExp->addCell('Expressão: ');
        $cellExp->style = 'width:300px; text-align:left;';
        $cellExp->add($this->Campos['expre'.$this->idLista]);

        $cellColsB = $RowExp->addCell('Buscar em: ');
        $cellColsB->style = 'width:230px; text-align:left;';
        $cellColsB->add($this->Campos['cols'.$this->idLista]);

        $cellAc = $RowExp->addCell('Acumular filtro?');
        $cellAc->style = 'width:120px; text-align:left;';
        $cellAc->add($this->Campos['Manterfilt'.$this->idLista]);

        $CellPesq = $RowExp->addCell(" ");
        $CellPesq->add($botPesq);
        $CellPesq->add($botLimpa);
        $CellPesq->add($botInfo);

        //formulário
        $formFiltro = new TForm('filtro'.$this->idLista);
        $formFiltro->setSubmit("false");

        $formFiltro->setFields($this->Campos);

        $formFiltro->add($this->Filtro);

        //executa filtro caso tenha dados em sessão
        if(count($argumentoFiltro) > 0) {
            $this->setFiltro($argumentoFiltro);
        }

        $this->botFiltro = true;
        $this->obFiltro = $formFiltro;
    }

    
        /**
     * Método setFiltro
     * monta formulário de limite da Lista
     */
    public function onLimite() {

    	$itens = array( 10=>10,
    					20=>20,
    					30=>30,
    					40=>40,
    					50=>50,
    					60=>60,
    					80=>80,
    					100=>100,
    					120=>120,
    					'all'=>'Todos');
    					
    	$ActionLimite = new TSetAction('prossExe');
        $ActionLimite->setMetodo('onChangeLimit');
        $ActionLimite->setTipoRetorno('lista');
        $ActionLimite->setIdForm($this->idLista);
        $ActionLimite->setAlvo($this->paneRet);
        
        $this->comboLimite = new TCombo('comboLimite'.$this->idLista, false);
	    $this->comboLimite->class = 'button icons ui-corner-all ui-state-default';
        $this->comboLimite->setSize('80');
        $this->comboLimite->onchange = 'alocaDado(this); '.$ActionLimite->getAction()->serialize();
        $this->comboLimite->addItems($itens);
        $this->comboLimite->value = $this->limite;

        
    }
    
    
    
    /**
     * instancia ações da DataGrid
     * param $action = objeto ação do tipo TAction
     * param $infoPesquisa = informação de pesquisa passado pela ação enviar
     */
    public function addAction(TAction $action, $infoPesquisa = NULL) {

        // monitora acao de enviar dados do sistema de pesquisa
        if($action->nome === "acenviar") {
            $this->argPesq = $infoPesquisa;
            $this->acenviar = $action->nome;
        }
        $this->actions[$action->nome] = $action;
        $this->datagrid->addAction($this->actions[$action->nome]);
    }

    /**
     * configura objeto apendice da lista
     */
    public function setApendice($apendice, $chaveApendice = NULL){
        
        //verifica e compila objeto APÊNDICE
        if($apendice) {
            $obApendice = new TApendices();
            $obElement = $obApendice->main($apendice, $chaveApendice);

            return $obElement;
        }
    }

    /**
    * Adiciona objetos no vetor para serem inseridos no contexto da lista
    * param $ob = objeto apendice a ser add no contexto da lista
    */
    public function addApendice($dadosApendice, $chaveApendice = NULL) {
        $apendice[] = $chaveApendice;
        $apendice[] = $dadosApendice;
        $this->dadosApendice[] = $apendice;
    }

    /**
     * Metodo de seleção multipla de registros na lista
     * param <type> $action
     */
    public function setSelecao($idLista, $registro, $action){

        $obHeaderSelecao = new TSetHeader();
        $headerLista     = $obHeaderSelecao->getHead($idLista);
        $listaSelecao    = $headerLista['listaSelecao'];

        if($registro == 'all'){
            if($action == '1'){

                $dboSel = new TDbo($headerLista['entidade']);
                        //monta filtro para a seleção
                        $criteriaSel = new TCriteria();
                        if(count($this->listaCriterios) >0){
                            $this->listaCriterios = array_reverse($this->listaCriterios);
                            foreach($this->listaCriterios as $fitro) {
                                if($fitro->operador) {
                                    $criteriaSel->add($fitro, $fitro->operador);
                                }else {
                                    $criteriaSel->add($fitro);
                                }
                            }
                        }
                $retSel = $dboSel->select('codigo', $criteriaSel);
                while($obSel = $retSel->fetchObject()){
                   $listaSelecao[$obSel->codigo] = $obSel->codigo;
                }
                $obHeaderSelecao->addHeader($idLista, 'allSelecao', '1');
            }
            elseif($action == '2'){
              $obHeaderSelecao->addHeader($idLista, 'allSelecao', '2');
              $listaSelecao = '-';
            }
            
        }else{
        	
        	$vetorRegistro = json_decode($registro);
        	
            if($action == '1'){
                $listaSelecao[$vetorRegistro[0]] = $vetorRegistro[0];
            }elseif($action == '2'){
                unset($listaSelecao[$vetorRegistro[0]]);
            }
        }

        if($listaSelecao){
           $obHeaderSelecao->addHeader($idLista, 'listaSelecao', $listaSelecao);
        }
        $this->listaSelecao = $listaSelecao;
        $this->headerLista = $obHeaderSelecao->getHead($idLista);
    }

    /**
    * Limpa lista de seleção
    */
    public function clearSelecao(){

        if($this->idLista){
            $obHeaderSelecao = new TSetHeader();
            $obHeaderSelecao->addHeader($this->idLista, 'listaSelecao', array());
        }
    }

    /**
    * Método onReload()
    * Carrega a DataGrid com os objetos do banco de dados
    */
    private function onReload($setPrint = false) {

        // inicia transação com o banco
        TTransaction::open($this->pathDB);

        // instancia um repositório
        $this->repository = new TRepository($this->entity);

        //configura colunas padrões (codigoautor e ativo)
        if($this->listCols) {
            if(!array_key_exists("codigoautor", $this->listCols)) {
                //  $this->listCols["codigoautor"] = "codigoautor";
            }
            if(!array_key_exists("ativo", $this->listCols)) {
                $this->listCols["ativo"] = "ativo";
            }
        }
        //==============================================

        // configura colunas de retorno do repositorio
        $this->repository->setCols($this->listCols);

        //Seta posição inicial da listagem
        if($this->posicao == 0) {
            $this->setPosition('');
        }


        //========= CRITERIOS ==================================================
        //percorre e define os criterios da lista

        if(count($this->listaCriterios) >0) {
            $this->listaCriterios = array_reverse($this->listaCriterios);
            foreach($this->listaCriterios as $fitro) {
                if($fitro->operador) {
                    $this->criteria->add($fitro, $fitro->operador);
                }else {
                    $this->criteria->add($fitro);
                }
            }
        }
        // Retorna a quantidade total de registros =============================
        $this->NumRows = $this->repository->count($this->criteria);
        // Quantidade ==========================================================

         //ordenação padrão das listas
        //$this->criteria->setProperty('order', 'id DESC');

        //aplica ordenação
        if($this->listaOrder) {
            $this->criteria->setProperty('order', $this->listaOrder);
        }


        //Aplica limitador a lista
        if($this->limiteParam != 0 and $setPrint === false){
            $this->criteria->setProperty('limit', $this->limiteParam);
        }else{
            $this->criteria->setProperty('limit', null);
        }
        //configura criteio de acesso a unidade fabril==========================
        //$this->criteria->add(new TFilter('unidade', '=', $this->obUser->unidade->codigo));
        //$this->criteria->add(new TFilter('unidade', '=', 'x'),'OR');

        //configura criterio de registros não comcluidos
        //$this->criteria->add(new TFilter('ativo', '!=', '9'));
        //=======================================================================
        // carrega os objetos da entidade e armazena em um repositório de objetos
        $objRegistros = $this->repository->load($this->criteria);
        $this->datagrid->clear();

        // finaliza a transação
        TTransaction::close();

        if($objRegistros) {

            foreach ($objRegistros as $keyCol=>$ObjEntity) {

                //==============================================================
                //configura ação enviar da PESQUISA se habilitada
                if($this->acenviar) {

                        //separa grupos
                        $infoPsq = explode(",", $this->argPesq);
                        foreach($infoPsq as $psqCols){
                            $psqColunas = explode("=", $psqCols);

                                //verifica se o valor de retorno contem uma coluna label associada
                                if(strpos($psqColunas[1], '>') !== false){
                                    $psqValor = explode('>', $psqColunas[1]);
                                    $psqColunas[1] = $psqValor[0].','.$psqValor[1];
                                    $grupoCampos[$psqColunas[0]] = $psqValor;
                                }
                                else{
                                    $grupoCampos[$psqColunas[0]] = $psqColunas[1];//campo do formulário
                                }
                            
                            $grupoCols[$psqColunas[1]] = $psqColunas[1]; //coluna da entidade
                        }

                            $psqDbo = new TDbo($this->entity);
                                $criteriaPsq = new TCriteria();
                                $criteriaPsq->add(new TFilter('codigo', '=', $ObjEntity->codigo));
                            $retDadosPsq = $psqDbo->select(implode(',',$grupoCols), $criteriaPsq);
                            
                            $dadosPsq = $retDadosPsq->fetch(PDO::FETCH_ASSOC);

                            
                            foreach($grupoCampos as $campoPsq=>$psqCol){
                                if(is_array($psqCol)){
                                    $setValue[] = $campoPsq.'=>'.$dadosPsq[$psqCol[0]].'/'.$dadosPsq[$psqCol[1]];
                                }else{
                                     $setValue[] = $campoPsq.'=>'.$dadosPsq[$psqCol];
                                }
                            }


                    $this->vetDados[$keyCol] = htmlspecialchars(implode("(sp)",$setValue));
                    $setValue = NULL;
                }
                //==============================================================

                // adiciona o objeto no conteiner de objetos
                $this->objetosLista[] = $ObjEntity;
            }
        }
        $this->loaded = true;

    }


    /**
     * Retorna lista formatada para impressão
     */
    public function setPrint() {

            $this->onReload(true);
            $this->datagrid->createModel($this->totalWidth, false);

        /**
         * Adiciona objetos na lista
         */
        if(count($this->objetosLista) > 0) {

            foreach($this->objetosLista as $colKey=>$obs) {

                $mkup = NULL;
                $this->datagrid->addItem($obs, $mkup);
            }
            $this->objetosLista = array();
        }

        $conteiner = new TTable();
        $conteiner->align       = "center";
        $conteiner->cellpadding = "0";
        $conteiner->cellspacing = "0";
        $conteiner->border = "0";
        $conteiner->class  = "ui-widget";

        $row1 = $conteiner->addRow();
        $cell11 = $row1->addCell("");
        
        $cell11->valign = "top";
        $cell11->height = "inherit";

        $contLista = new TElement('div');
        $contLista->class = 'listaBodyPrint';
        $contLista->add($this->datagrid);

       // $cell11->add($contLista);

        $contLista->show();
    }
    

    /**
    * Retorna lista configurada
    */
    public function getLista() {

        // carrega ou recarrega dados na lista
        // caso alguam ação tenha alterado o status do loaded
        if($this->loaded == false) {
            $this->onReload();
            $this->datagrid->createModel($this->totalWidth);
        }
        /**
         * Adiciona objetos na lista
         */
        if(count($this->objetosLista) > 0) {

            foreach($this->objetosLista as $colKey=>$obs) {

                //injeta actions da pesquisa na grid usando o vetor produzido na linha 584
                if($this->acenviar) {
                    $this->actions[$this->acenviar]->setParameter('regDados', $this->vetDados[$colKey]);
                }

                    //marca ação checkbutton caso o valor exista na listaSelecao
                    if($this->actions['acselecao']){
                        if(is_array($this->listaSelecao)){
                            if($this->headerLista['allSelecao'] == '1'){
                                 $this->actions['acselecao']->checked = true;
                                 $this->actions['acselecao']->label->checked = true;
                                 $this->actions['acselecao']->class   = 'ui-widget-header';
                            }elseif($this->headerLista['allSelecao'] == '2'){
                                 $this->actions['acselecao']->label->checked = false;
                                 $this->actions['acselecao']->checked = false;
                            }else{
                                $regSelecionado = array_search($obs->codigo, $this->listaSelecao);
                                if($regSelecionado){
                                    $this->actions['acselecao']->checked = true;
                                    $this->actions['acselecao']->class   = 'ui-widget-header';
                                }else{
                                    $this->actions['acselecao']->checked = false;
                                }
                           }
                     }
                }

                //marca linha da tabela de acordo com o status
                if($obs->ativo == "9") {
                    $mkup = $this->setMarc($obs->codigoautor, '1');
                }
                elseif($obs->ativo == "8") {
                    $msg = 'Este registro pode apresentar inconsistências. O Modo de edição não foi adequadamente concluido.';
                    $mkup = $this->setMarc($obs->codigoautor, '2', $msg);
                }else {
                    $mkup = NULL;
                }
                $obs->align = $obs->alinhadados;
                $this->datagrid->addItem($obs, $mkup);
            }
            $this->objetosLista = array();
        }


        $conteiner = new TElement('div');
        $conteiner->class = "ui-widget ui-widget-content listaDisplay";

        $tab = new TTable();
        $tab->cellpadding = '0';
        $tab->cellspacing = '0';
        $tab->border = 0;
        $tab->class = "listaTab";
        $row1 = $tab->addRow();

        $head = new TElement("div");
        $head->class = "ui-widget headerLista";
        if($this->botFiltro) {
            $head->add($this->obFiltro);
        }
        $head->add($this->setNav($this->obFiltro->winid));


        $row1->class = "tr1";
        $cell1 = $row1->addCell($head);
        $cell1->class = "row1";

        /* Elemento para esconder cabeçalho

        $row2 = $tab->addRow();
        $row2->class = "tr2";
        $cell2 = $row2->addCell('<span class="ui-icon ui-icon-triangle-1-n" style="position: relative; height: 10px; top: -3px; left: 48%"></span>');
        $cell2->class = "row2 ui-widget-content ui-state-default hideHeader";
         */

        $contLista = new TElement('div');
        $contLista->class = "listaBody";
        $contLista->add($this->datagrid);
        if($this->trigger){
            $contLista->trigger = $this->trigger;
        }

        $row3 = $tab->addRow();
        $row3->class = "tr3";
        $cell3 = $row3->addCell($contLista);
        $cell3->class = "row3";


        if($this->dadosApendice) {
         
            /* Elemento para esconder apendice

            $row4 = $tab->addRow();
            $row4->class = "tr4";
            $cell4 = $row4->addCell('<span class="ui-icon ui-icon-triangle-1-s" style="position: relative; height: 10px; top: -3px; left: 48%"></span>');

            $cell4->class = "row4 ui-widget-content ui-state-default hideApendice";

            */
            foreach($this->dadosApendice as $apendice) {

                $elementoApendice = $this->setApendice($apendice[1], $apendice[0]);

                $apendice = new TElement('div');
                $apendice->class = "apendiceLista";
                $apendice->add($elementoApendice);
            }


        $row5 = $tab->addRow();
        $row5->class = "tr5";
        $cell5 = $row5->addCell($apendice);
        $cell5->class = "ui-widget row5";
        }
    /*

        $conteiner = new TElement('div');
        $conteiner->class = "ui-widget areaDataGrid";
        
        //$row1 = $conteiner->addRow();
        $cell11 = new TElement("div");

        if($this->botFiltro) {
            $cell11->add($this->obFiltro);
        }
        $cell11->add($this->setNav($this->obFiltro->winid));

        $conteiner->add($cell11);

        $contLista = new TElement('div');
        $contLista->class = 'conteinerList';
        $contLista->add($this->datagrid);

            //aplica a propriedade trigger no conteiner da tabela
            if($this->trigger){
                $contLista->trigger = $this->trigger;
            }

        $conteiner->add($contLista);

        //Compila apendices
        if($this->dadosApendice) {
            foreach($this->dadosApendice as $apendice) {

                $elementoApendice = $this->setApendice($apendice[1], $apendice[0]);
                
                //$row2 = $conteiner->addRow();
                //$cell21 = $row2->addCell($elementoApendice);
                //$cell21->class="ui-box ui-widget-content ui-state-default obApendice";
                //$cell21->height = "10";

                

                $cell21 = new TElement('div');
                $cell21->class="ui-box ui-widget-content ui-state-default obApendice";
                $conteiner->add($elementoApendice);
            }
        }
        $conteiner->add($cell21);

        */

        $conteiner->add($tab);
        return $conteiner;
    }

    /**
     * Retorna lista fora do conteiner
     */
    public function getDatagrid() {

        if($this->loaded == false) {
            $this->onReload();
        }
        $this->datagrid->createModel();
        return $this->datagrid;
    }

    /**
     * Configura vetor com a marcação dos registro não concluidos
     * param <codigo> $user  = Codigo do usuario autro do registro
     */
    private function setMarc($user, $tipo, $msg = NULL) {
        $markup[0] = $tipo;
        if($user) {
            $getUser = new TUsuario();
            $dadosUser = $getUser->getUser($user);
            $msg2 = " Usuario responsavel: {$dadosUser->nome}";
        }if(!$msg) {
            $msg = "Este registro está em aberto no sistema.";
        }
        $markup[1] = $msg.$msg2;
        return $markup;
    }

    /*
    */
    public function getBtNav() {
        return $this->bt;
    }

}