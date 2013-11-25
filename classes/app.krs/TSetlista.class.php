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
    public  $posicao        = 0;// armazena o posicionamento da listagem
    public  $limite 		= 20;
    private $limitePadrao   = 20; // delimita o número de registro da listagem
    private $visibilidade   = NULL;
    private $criteria       = NULL;
    private $trigger;
    private $itens          = array();
    private $listaSelecao   = null;
    protected $obHeader		= NULL;
    protected  $objHeader   = NULL;

    public function __construct($listseq, $entidade, $label, $conteinerRetorno = NULL) {
    	
        $this->listseq = $listseq;
        
        $this->objHeader = new TSetHeader();
        $this->obHeader = $this->objHeader->getHead($this->listseq);

        //Retorna Usuario logado===================================
        $obUser = new TCheckLogin();
        $this->obUser = $obUser->getUser();
        //=========================================================

//        $this->obHeader = new TSetHeader();
//        $this->headerLista = $this->obHeader->getHead($this->listseq);

        $this->obsession = new TSession();
        $this->pathDB = $this->obsession->getValue('pathDB');
        $this->ordem  = $this->obsession->getValue('orderFilter');

        $this->datagrid = new TDataGrid;
        $this->entity 	  = $entidade;
        $this->label 	  = $label;
//        $this->campoChave = $campoChave; //configura coluna que representa o campo chave da lista
//        $this->listCols['id'] = "id";
        $this->listCols[TConstantes::SEQUENCIAL] = "seq";

        //Objeto criteria
        $this->criteria = new TCriteria();

        $limite = $this->obsession->getValue("comboLimite" . $listseq);
        if(!empty($limite)){
        	$this->limite = $limite;
        }
        if(!$this->limite) {
            $this->setLimite($this->limitePadrao);
        }

        $this->conteinerRetorno = $conteinerRetorno;
        $this->formseq = $this->obHeader[TConstantes::FORM];

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
     * Seta o load da lista caso seje necessario recarregar de forma deliberada
     */
    public function setLoad($load){
    	$this->load = $load;
    }

    /**
     * Configura ivisibilidade das colunas da listagem
     *param col = coluna a ser aplicada a visibilidade
     *param visibilidade = tipo da visibilidade (TRUE / FALSE)
     */
    public function setVisibilidade($col, $visibilidade) {
        $this->visibilidade[$col] = $visibilidade;
    }

    /*m�todo addTop
	* adiciona colunas
    */
    public function addTop($obCol) {
        
        //Valida duplicação de colunas
        if(array_key_exists($obCol->coluna, $this->obCols) === FALSE) {


            //largura total da lista
            $this->totalWidth = $this->totalWidth+$obCol->largura;

            //configura os itens do combo de colunas
            $this->itens[$obCol->coluna.'__'.$obCol->tipodado] = $obCol->label;

            //aloca objetos coluna
            $this->obCols[$obCol->coluna] = $obCol;

            // monta lista de colunas para o Reload
            $this->listCols[$obCol->coluna] = $obCol->label;

            //instacia objeto coluna para a datagrid
             $this->topCols[$obCol->coluna] = new TDataGridColumn($obCol->coluna, $obCol->label, $obCol->alinhadados, $obCol->largura);

            //compila visibilidade da coluna
            if($this->visibilidade[$obCol->coluna] == NULL or $this->visibilidade[$obCol->coluna] == TRUE) {
                $this->topCols[$obCol->coluna]->setVisibilidade(TRUE);
            }
            else {
                $this->topCols[$obCol->coluna]->setVisibilidade(FALSE);
            }

            //instancia funções para a coluna
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
            $ActionOrdem->setIdForm($this->listseq);
            $ActionOrdem->setKey($obCol->coluna);
            $ActionOrdem->setAlvo($this->conteinerRetorno);
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
    * param <type> $tipoFiltro = tipo do criterio ( 1 = filtro Padrão 2 = criterio de pesquisa 3 = filtro pai )
    */
    public function addCriterio($col, $dado, $comp, $operador = NULL, $tipodado = 'numeric',$tipoFiltro = 1) {

        if($col and $dado) {
        	
        	$control = new TSetControl();

        	if($tipodado == 'string' and is_string($dado)){
        		   
        		$incluir = true; 		
        	}else if($tipodado == 'numeric' and (is_numeric($dado) || strtolower($comp) == 'in')){ 
        				
        		$incluir = true;
        	}else if($tipodado == 'date' and $control->is_date($dado)){
        		
        		$incluir = true;
        	}else if(count($dado) == 2 and $comp = 'BETWEEN'){
        		
        		$incluir = true;
        	}else if($tipodado == 'filtroLista'){
        		$incluir = true;
        	}else{
        		$incluir = false;
        	}
        	
        	if($incluir){
	        	$obFiltro = new TFilter($col, $comp, $dado, $tipodado);
	            $obFiltro->tipoFiltro = $tipoFiltro;
	            $obFiltro->operador = $operador;
	
	            $this->listaCriterios[] = $obFiltro;
        	}
        }
    }

    /**
     *método clear()
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
        $this->obsession->setValue('boxFiltro_'.$this->listseq, NULL);
        $this->load = TRUE;
        unset($_SESSION['boxFiltro_'.$this->listseq]);
        
        $this->NumRows = null;
        
        $this->load = true;
    }


    /**
     * método setFiltro Padrão
     * configura um filtro Padrão para lista
     * param dados = Dados do filtro expressão / coluna / manter filtro
     */
    public function setFiltro($dados) {
    	
        if($dados['expre'.$this->listseq] != "") {

            // Verifica o campo data a ser aplicada na expressão do filtro Padrão ======
            $obMasc = new TSetMascaras();
            $dados['expre'.$this->listseq] = $obMasc->setDataDb($dados['expre'.$this->listseq]);
            //==========================================================================

            // Se manter filtro for ativado
            if($dados['Manterfilt'.$this->listseq] == 'TRUE') {

                //garda argumetos do filtro
                $argFiltro = $this->obsession->getValue('boxFiltro_'.$this->listseq);
                $argFiltro['Manterfilt'.$this->listseq] = $dados['Manterfilt'.$this->listseq];
                if(!is_array($dados['expre'.$this->listseq])) {
                    if(!is_array($argFiltro['expre'.$this->listseq])) {
                        $vetArgs[0] = str_replace("*", "%", $argFiltro['expre'.$this->listseq]);
                    }else {
                        $vetArgs = str_replace("*", "%", $argFiltro['expre'.$this->listseq]);
                    }
                    $vetArgs[] = str_replace("*", "%", $dados['expre'.$this->listseq]);
                }else {
                    $vetArgs = str_replace("*", "%", $dados['expre'.$this->listseq]);
                }
                $argFiltro['expre'.$this->listseq] = $vetArgs;

                if(!is_array($dados['cols'.$this->listseq])) {
                    if(!is_array($argFiltro['cols'.$this->listseq])) {
                        $vetcols[0] = $argFiltro['cols'.$this->listseq];
                    }else {
                        $vetcols = $argFiltro['cols'.$this->listseq];
                    }
                    $vetcols[] = $dados['cols'.$this->listseq];
                }else {
                    $vetcols = $dados['cols'.$this->listseq];
                }
                $argFiltro['cols'.$this->listseq] = $vetcols;
                $this->obsession->setValue('boxFiltro_'.$this->listseq, $argFiltro);

                //----------------------------------------------------------------------
                //monta crit�rio de pesquisa em todas as colunas da tabela em questão.
                if($dados['cols'.$this->listseq] === "*") {

                    //while($getcols = $runCols->fetchObject()){
                    foreach($this->itens as $colId=>$colLabel) {
                    	$operadorFiltro = '';
                        foreach($argFiltro['expre'.$this->listseq] as $mArgs) {
                            if($colId != "id" and $colId != "seq" and $colId != "unidseq" and $colId != "statseq") {
                            	
                            	$dadosCol = explode('__', $colId);
                                $this->addCriterio($dadosCol[0],$mArgs,'ILIKE',$operadorFiltro,$dadosCol[1],$tipoFiltro = "2");
                                $operadorFiltro = "OR";
                            }
                        }
                        $operadorFiltro = "AND";
                    }

                    //}

                }else {
                    foreach($argFiltro['expre'.$this->listseq] as $ct=>$mArgs) {
                        $operadorFiltro = "AND";
                        
                        $dadosCol = explode('__', $argFiltro['cols'.$this->listseq][$ct]);
                        $this->addCriterio($dadosCol[0], $mArgs, 'ILIKE', $operadorFiltro,$dadosCol[1],$tipoFiltro = "2");
                    }
                }

            }
            else {

                //limpa filtro
                $this->clear();
                $this->obsession->setValue('boxFiltro_'.$this->listseq, NULL);
                $argFiltro = array();

                //garda argumetos do filtro
                $this->obsession->delValue('boxFiltro_'.$this->listseq);
                $argFiltro['cols'.$this->listseq] = $dados['cols'.$this->listseq];
                $argFiltro['Manterfilt'.$this->listseq] = $dados['Manterfilt'.$this->listseq];
                $argFiltro['expre'.$this->listseq] = str_replace("*", "%", $dados['expre'.$this->listseq]);
                $this->obsession->setValue('boxFiltro_'.$this->listseq, $argFiltro);

                //----------------------------------------------------------------------
                //monta criterio de pesquisa em todas as colunas da tabela em questão.
                if($dados['cols'.$this->listseq] === "*") {
                	$expression = $argFiltro['expre'.$this->listseq];
                	if(preg_match('@^([^ %*]+)$@i', $expression)){
                		$expression = '%'.$expression.'%';
                	}
                	
                    foreach($this->itens as $colId=>$colLabel) {
                        if($colId != '*'){// and $colId != "seq" and $colId != "unidseq" and $colId != "statseq") {
                        	$dadosCol = explode('__', $colId);
                            $this->addCriterio($dadosCol[0], $expression, 'ILIKE','OR',$dadosCol[1], "2");
                        }
                    }

                }else {
                	
                	$dadosCol = explode('__', $dados['cols'.$this->listseq]);
                    $this->addCriterio($dadosCol[0], $argFiltro['expre'.$this->listseq], 'ILIKE',NULL,$dadosCol[1], "2");
                }
            }
             
            $this->NumRows = null;
            $this->setPosition(0);
        }
        
        if(count($dados) > 0 and !array_key_exists ('expre'.$this->listseq,$dados)){//filtro normal
        	
        	//limpa filtro
        	$this->clear();
        	$this->obsession->setValue('boxFiltro_'.$this->listseq, NULL);
        	$argFiltro = array();
        	
        	$obControl = new TSetControl();
        	
        	foreach ($dados as $col=>$valor){
        		
        		$arg = explode(';', $valor);        		
        		if($obControl->is_date($arg[0], 'dd/mm/yyyy') and $obControl->is_date($arg[1],'dd/mm/yyyy')){
        			
        			$arg[0] = $obControl->setDataDB($arg[0]);
        			$arg[1] = $obControl->setDataDB($arg[1]);
        			
        			$dadosCol = explode('__', $col);
        			$this->addCriterio($dadosCol[0], $arg, 'BETWEEN', NULL,$dadosCol[1], "2");
        		}else{
        			
        			$dadosCol = explode('__', $col);
        			
        			$this->addCriterio($dadosCol[0], $valor, 'ILIKE', NULL,$dadosCol[1],"2");
        		}
        	}        	
        	
        }
        $this->load = TRUE;
    }

    /**
     * Adiciona criterio de ordenação ao
     * objeto criteria
     * param coluna = criterio de ordenação
     */
    public function setOrdem($ordem) {
    	    	
        if($this->listaOrder == $ordem) {
            $ordem .= ' desc';
        }
        $this->listaOrder = $ordem;
        $this->load = TRUE;
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
    	
    	$this->load = TRUE;
    }


    /**
     * metodo setPosition()
     * Gerencia os criterios da posição da lista.
     * param  posição = posição da paginação da listagem
     */
    public function setPosition($posicao) {
        $this->posicao = $posicao;
        //paginação
        if(!$this->posicao) {
            $this->posicao = 0;
        }
        if($this->limite && is_numeric($this->limite)){
            $limite = $this->limite.' OFFSET '.$this->posicao;
        }
        $this->limiteParam = $limite;
        
        $this->load = TRUE;
    }
    
/**
     * m�todo setLimite
     * monta formul�rio de limite da Lista
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
    					120=>120);
    					//'all'=>'Todos');
    					
    	$ActionLimite = new TSetAction('prossExe');
        $ActionLimite->setMetodo('onChangeLimit');
        $ActionLimite->setTipoRetorno('lista');
        $ActionLimite->setIdForm($this->listseq);
        $ActionLimite->setAlvo($this->conteinerRetorno);
        
        $this->comboLimite = new TCombo('comboLimite'.$this->listseq, FALSE);
	    $this->comboLimite->class = 'button icons ui-corner-all ui-state-default';
        $this->comboLimite->setSize('80');
        $this->comboLimite->onchange = 'alocaDado(this); '.$ActionLimite->getAction()->serialize();
        $this->comboLimite->addItems($itens);
        $this->comboLimite->value = $this->limite;

        
    }
    

    /**
     * Deleta registro da lista
     * param seq= seqdo registro a ser deletado
     * param endidade = entidade(tabela) alvo da ação
     */
    public function onDelete($seq, $entidade) {

        //deleta o registro baseado no campoChave passado na definição da lista pelo construtor
        $dbo = new TDbo($entidade);
        $result = $dbo->delete($seq, $this->campoChave);
        $dbo->close();

        $this->load = TRUE;
    }

    /**
     * addBot()
     * param  $botNav = objeto botão da bara de navegação
     */
    public function addBot($botNav) {
        $this->botsNav[] = $botNav;
    }

    /*m�todo setNav()
	* configura a barra navegadora do browser
	* param    idFiltro = id para configuração do botão filtrar( Id da janela)
    */
    private function setNav($idFiltro){

        // configura bot�es de navegação =======================================
        $ActionBack = new TSetAction('prossExe');
        $ActionBack->setMetodo('onBack');
        $ActionBack->setTipoRetorno('lista');
        $ActionBack->setIdForm($this->listseq);
        $ActionBack->setAlvo($this->conteinerRetorno);
        $this->bt['btBack'] = new TIcon("ui-icon-seek-prev", "icons_btBack");
        $this->bt['btBack']->setAction($ActionBack);
        $this->bt['btBack']->setTitle("Voltar");
        if($this->posicao<=1) {
            $this->bt['btBack']->setEditable(FALSE);
        }
        //$this->bt['btBack'] = new TButton('btBack');
        //$this->bt['btBack']->setAction($ActionBack, '<<');
        //$this->bt['btBack']->style = "width:40px;";

        $ActionNext = new TSetAction('prossExe');
        $ActionNext->setMetodo('onNext');
        $ActionNext->setTipoRetorno('lista');
        $ActionNext->setIdForm($this->listseq);
        $ActionNext->setAlvo($this->conteinerRetorno);
        $this->bt['btNext'] = new TIcon("ui-icon-seek-next", "icons_btNext");
        $this->bt['btNext']->setAction($ActionNext);
        $this->bt['btNext']->setTitle("Avançar");
        if($this->NumRows<=$this->limite or ($this->posicao+$this->limite)>=$this->NumRows) {
            $this->bt['btNext']->setEditable(FALSE);
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
            $ActionSetCols->setIdForm($this->listseq);
            $ActionSetCols->setAlvo($this->conteinerRetorno);
            $this->bt['btColunas']->setAction($ActionSetCols->getAction(), 'Colunas');
            $this->bt['btColunas']->style = "width:60px;";
        }
        //======================================================================

        // configura bot�es de navegação =======================================
        $this->bt['btPrint'] = new TIcon("ui-icon-print", "icons_btPrint");
        $this->bt['btPrint']->setAction('printDataGrid('.$this->listseq.','.$this->conteinerRetorno.')');
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
        
    	//$this->onLimite();
        if($this->comboLimite){
        	$LabelLimite = new TElement('span');
	        $LabelLimite->add($this->comboLimite);
	        $NavLista->add($LabelLimite);
        }

        return $NavLista;
    }

    /**
     * m�todo setColunas
     * monta formulario de configuração da visibilidade das colunas
     */
    public function setColunas() {

    }

    /**
     * m�todo setFiltro
     * monta formul�rio de filtro da lista de dados
     */
    public function onFiltro() {

        //Instacia campos do formul�rio de filtro de dados
        $this->Campos['expre'.$this->listseq] = new TEntry('expre'.$this->listseq);
        $this->Campos['expre'.$this->listseq]->view = true;
        $this->Campos['expre'.$this->listseq]->setSize('220');
        $this->Campos['expre'.$this->listseq]->setProperty('autocomplete','on');
        
        $this->Campos['expre'.$this->listseq]->onkeyup = "runEnter('icons_Pesq".$this->listseq."', event)";

        // manter o ultimo argumento no campo de expressão =============
//        $argumentoFiltro = $this->obsession->getValue('boxFiltro_'.$this->listseq);
//
//        if(is_array($argumentoFiltro['expre'.$this->listseq])) {
//            $numArg = count($argumentoFiltro['expre'.$this->listseq])-1;
//
//            $this->Campos['expre'.$this->listseq]->setValue($argumentoFiltro['expre'.$this->listseq][$numArg]);
//        }else {
//            $this->Campos['expre'.$this->listseq]->setValue($argumentoFiltro['expre'.$this->listseq]);
//        }
        //==============================================================


        $this->Campos['cols'.$this->listseq] = new TCombo('cols'.$this->listseq, FALSE);
        $this->Campos['cols'.$this->listseq]->view = true;
        $this->Campos['cols'.$this->listseq]->setSize('150');        
            if(is_array($argumentoFiltro['cols'.$this->listseq]) and $numArg) {
                $this->Campos['cols'.$this->listseq]->setValue($argumentoFiltro['cols'.$this->listseq][$numArg]);
            }
//            if(is_array($this->itens)) {
//                array_unshift($this->itens, "todas as colunas");
//            }
        $this->Campos['cols'.$this->listseq]->addItems($this->itens);

        $this->Campos['Manterfilt'.$this->listseq] = new TCheckButton('Manterfilt'.$this->listseq);
        $this->Campos['Manterfilt'.$this->listseq]->view = true;
        $this->Campos['Manterfilt'.$this->listseq]->setValue(1);

	        $ActionFilter = new TSetAction('onFilter');
	        $ActionFilter->setIdForm($this->listseq);
	        $ActionFilter->setTipoRetorno('lista');
	        $ActionFilter->setAlvo($this->conteinerRetorno);

        //bontão de pesquisa
        $botPesq = new TIcon("ui-icon-search", "icons_Pesq".$this->listseq);
        $botPesq->setAction($ActionFilter);
        $botPesq->setTitle("Filtrar");

        
	        $ActionClearFilter = new TSetAction('prossExe');
	        $ActionClearFilter->setMetodo('onClearFilter');
	        $ActionClearFilter->setTipoRetorno('lista');
	        $ActionClearFilter->setIdForm($this->listseq);
	        $ActionClearFilter->setAlvo($this->conteinerRetorno);
        
        //bontão limpa pesquisa
        $botLimpa = new TIcon("ui-icon-refresh", "icons_Limpar".$this->listseq);
        $botLimpa->setAction($ActionClearFilter);
        $botLimpa->setTitle("Limpar Filtro");

        //bontão de informação da pesquisa
        $botInfo = new TIcon("ui-icon-info", "icons_Pesq".$this->listseq);
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
        $cellExp->add($this->Campos['expre'.$this->listseq]);

        $cellColsB = $RowExp->addCell('Buscar em: ');
        $cellColsB->style = 'width:230px; text-align:left;';
        $cellColsB->add($this->Campos['cols'.$this->listseq]);

        $cellAc = $RowExp->addCell('Acumular filtro?');
        $cellAc->style = 'width:120px; text-align:left;';
        $cellAc->add($this->Campos['Manterfilt'.$this->listseq]);

        $CellPesq = $RowExp->addCell(" ");
        $CellPesq->add($botPesq);
        $CellPesq->add($botLimpa);
        $CellPesq->add($botInfo);

        //formul�rio
        $formFiltro = new TForm('filtro'.$this->listseq);
        $formFiltro->setSubmit("FALSE");

        $formFiltro->setFields($this->Campos);

        $formFiltro->add($this->Filtro);

        //executa filtro caso tenha dados em sessão
        if(count($argumentoFiltro) > 0) {
            $this->setFiltro($argumentoFiltro);
        }

        $this->botFiltro = TRUE;
        $this->obFiltro = $formFiltro;
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
    public function setSelecao($listseq, $registro, $action){

        $obHeaderSelecao = new TSetHeader();
        $headerLista     = $obHeaderSelecao->getHead($listseq);
        $listaSelecao    = $headerLista[TConstantes::LIST_SELECAO];

        if($registro == 'all'){
            if($action == '1'){

                $dboSel = new TDbo($headerLista[TConstantes::ENTIDADE]);
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
                $retSel = $dboSel->select(TConstantes::SEQUENCIAL, $criteriaSel);
                while($obSel = $retSel->fetchObject()){
                   $listaSelecao[$obSel->seq] = $obSel->seq;
                }
                $obHeaderSelecao->addHeader($listseq, 'allSelecao', '1');
            }
            elseif($action == '2'){
              $obHeaderSelecao->addHeader($listseq, 'allSelecao', '2');
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

        
        $obHeaderSelecao->addHeader($listseq, 'listaSelecao', $listaSelecao);
        $this->listaSelecao = $listaSelecao;
        $this->headerLista = $obHeaderSelecao->getHead($listseq);
    }

    /**
    * Limpa lista de seleção
    */
    public function clearSelecao(){

        if($this->listseq){
            $obHeaderSelecao = new TSetHeader();
            $obHeaderSelecao->addHeader($this->listseq, TConstantes::LIST_SELECAO, array());
        }
    }

       
    /*
     * Carrega dos objetos em uma tabela HTML para exibição
     * Param <array> $dados = vetor de objetos a serem carregados na tela
     */
    private function loadData($dados){   
        
            if($dados){

            foreach ($dados as $seqCol=>$ObjEntity) {

                //==============================================================
                //configura ação enviar da PESQUISA se habilitada
                if($this->acenviar) {

                        //separa grupos
                        $infoPsq = explode(",", $this->argPesq);
                        foreach($infoPsq as $psqCols){
                            $psqColunas = explode("=", $psqCols);

                                //verifica se o valor de retorno contem uma coluna label associada
                                if(strpos($psqColunas[1], '>') !== FALSE){
                                    $psqValor = explode('>', $psqColunas[1]);
                                    $psqColunas[1] = $psqValor[0].','.$psqValor[1];
                                    $grupoCampos[$psqColunas[0]] = $psqValor;
                                }
                                else{
                                    $grupoCampos[$psqColunas[0]] = $psqColunas[1];//campo do formul�rio
                                }
                            
                            $grupoCols[$psqColunas[1]] = $psqColunas[1]; //coluna da entidade
                        }

                            $psqDbo = new TDbo($this->entity);
                                $criteriaPsq = new TCriteria();
                                $criteriaPsq->add(new TFilter(TConstantes::SEQUENCIAL, '=', $ObjEntity->seq));
                            $retDadosPsq = $psqDbo->select(implode(',',$grupoCols), $criteriaPsq);
                            
                            $dadosPsq = $retDadosPsq->fetch(PDO::FETCH_ASSOC);

                            
                            foreach($grupoCampos as $campoPsq=>$psqCol){
                                if(is_array($psqCol)){
                                    $setValue[] = $campoPsq.'=>'.$dadosPsq[$psqCol[0]].'/'.$dadosPsq[$psqCol[1]];
                                }else{
                                     $setValue[] = $campoPsq.'=>'.$dadosPsq[$psqCol];
                                }
                            }


                    $this->vetDados[$seqCol] = htmlspecialchars(implode("(sp)",$setValue));
                    $setValue = NULL;
                }
                //==============================================================

                // adiciona o objeto no conteiner de objetos
                $this->objetosLista[] = $ObjEntity;
            }
        }
    	
    }
    
    /**
    * m�todo onReload()
    * Carrega a DataGrid com os objetos do banco de dados
    */
    private function onReload($setPrint = FALSE) {
    	
    	//$results = $this->objHeader->getHead($this->listseq, TConstantes::LIST_OBJECT);
    	
    	    	
    	//Se a lista de objetos ainda não estiver sido carregada do banco ------ count($results) == 0 or 
        if($this->load === TRUE){
        	        	
	        //configura colunas padrões (seqautor e statseq)
	        if($this->listCols) {
	            if(!array_key_exists("usuaseq", $this->listCols)) {
	                //  $this->listCols["seqautor"] = "seqautor";
	            }
	            if(!array_key_exists("statseq", $this->listCols)) {
	                $this->listCols["statseq"] = "statseq";
	            }
	        }
	        //==============================================
	    
	
	        //Seta posição inicial da listagem
	        if($this->posicao == 0) {
	            $this->setPosition($this->posicao);
	        }
	
	
	        //========= CRITERIOS ==================================================
	        //percorre e define os criterios da lista
	
	        if(count($this->listaCriterios)>0) {
	            $this->listaCriterios = array_reverse($this->listaCriterios);
	            foreach($this->listaCriterios as $fitro) {
	                if($fitro->operador) {
	                    $this->criteria->add($fitro, $fitro->operador);
	                }else {
	                    $this->criteria->add($fitro);
	                }
	            }
	        }
	
	         //ordenação Padrão das listas
	     	 //$this->criteria->setProperty('order', 'seq DESC');
	
	        //aplica ordenação
	        if($this->listaOrder) {
	            $this->criteria->setProperty('order', $this->listaOrder);
	        }
	
	        //Aplica limitador a lista
	        if($this->limiteParam){       	
	            $this->criteria->setProperty('limit', $this->limiteParam);
	        }else{
	            $this->criteria->setProperty('limit', null);
	        }
	        
        	$results = $this->loadObject($this->entity, $this->criteria);
        }
        
        $this->datagrid->clear();
        
        $this->loadData($results);
        
        $this->load = FALSE;
    }


    /*
     * Carrega a lista de Objetos do banco de dados em memoria
     */
    private function loadObject($entity, $criteria){
    	
    	$listCount = $this->objHeader->getHead($this->obHeader[TConstantes::LISTA], TConstantes::LIST_COUNT);
    	
    	// inicia transação com o banco
        TTransaction::open($this->pathDB);
                
            //Seta filtro Padrão para o contexto do registro pai
            if($this->obHeader > 1 and $this->obHeader['frmpseq']){
            	
            	$obHeadPai = $this->objHeader->getHead($this->obHeader['frmpseq']);
            	
            	if($obHeadPai[TConstantes::SEQUENCIAL] or $obHeadPai[TConstantes::STATUS_FORM] == 'new'){
            		$criteria->add(new TFilter($obHeadPai[TConstantes::HEAD_COLUNAFK], '=',$obHeadPai[TConstantes::SEQUENCIAL]));  
            	}          	
            }
   
            $colunas = '*';
            $dbo = new TDbo($entity);
            $result = $dbo->select($colunas, $criteria);
            if($result){
            	
                // percorre os resultados da consulta, retornando um objeto
                while ($row = $result->fetchObject()) {

                    //converte data Padrão internacional para Padrão brasileiro ====================
                    foreach($row as $kDado=>$dado) {
                        if (preg_match("/([0-9]{4})-([0-9]{1,2})-([0-9]{1,2})/", $dado, $newData)) {
                            $row->$kDado = "$newData[3]/$newData[2]/$newData[1]";
                        }
                    }
                    //==============================================================================

					//if($this->obHeader[TConstantes::HEAD_NIVEL] == 1){
						// armazena no array $results;
                    	$results[] = $row;
					//}else{

						//$campoSession = $this->objHeader->formHeader($this->obHeader[TConstantes::FORM]);
						
						//foreach($campoSession as $cmp){

						//}
						
					//}
                    //incrementa n�mero de registro da base na quatidade de registros
                    $listCount++;
                }
            }

            //recupera campos armazenado em senssão que ainda não foram salvos e injeta na lista de objetos
            $results_session = $this->objHeader->getHead($this->listseq, TConstantes::LIST_OBJECT);
                        
            //verifica existencia de itens na lista em sessão
            if($results_session){
            		
            	foreach($results_session as $record){
            		            		
            		$objResult = new stdClass();
            		            		
              		foreach($record as $campo){      		
              			$objResult->seq = $campo['seq'];	
            			$objResult->$campo['campo'] = $campo['valor'];
            		}
			            		
            		$objResult->statseq = 1;

            		$results[] = $objResult;
            		
            		//incrementa registros ainda em sessão
            		$listCount++;
            	}
            }

        //atualiza na memoria quantidade de registro da lista
        $this->objHeader->addHeader($this->obHeader[TConstantes::LISTA], TConstantes::LIST_COUNT, $listCount);
            
        //Retorna número de registros na lista de acordo com a criteria
        if(!$this->NumRows){
        $this->NumRows = $dbo->count($criteria);
        }
            
        // finaliza a transação
        TTransaction::close();
        
        return $results;
    }   
    
    /**
     * Retorna lista formatada para impressão
     */
    public function setPrint() {

            $this->onReload(TRUE);
            $this->datagrid->createModel($this->totalWidth, FALSE);

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
        // caso alguam ação tenha sido executada
        if($this->load) {
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
                                 $this->actions['acselecao']->checked = TRUE;
                                 $this->actions['acselecao']->label->checked = TRUE;
                                 $this->actions['acselecao']->class   = 'ui-widget-header';
                            }elseif($this->headerLista['allSelecao'] == '2'){
                                 $this->actions['acselecao']->label->checked = FALSE;
                                 $this->actions['acselecao']->checked = FALSE;
                            }else{
                                $regSelecionado = array_search($obs->seq, $this->listaSelecao);
                                if($regSelecionado){
                                    $this->actions['acselecao']->checked = TRUE;
                                    $this->actions['acselecao']->class   = 'ui-widget-header';
                                }else{
                                    $this->actions['acselecao']->checked = FALSE;
                                }
                           }
                     }
                }

                //marca linha da tabela de acordo com o status
                /* if($obs->statseq == "9") {
                    $mkup = $this->setMarc($obs->seqautor, '1');
                }
                elseif($obs->statseq == "8") {
                    $msg = 'Este registro pode apresentar inconsistências. O Modo de edição não foi adequadamente concluido.';
                    $mkup = $this->setMarc($obs->seqautor, '2', $msg);
                }else {
                    $mkup = NULL;
                } */
                $obs->align = $obs->alinhadados;
                $this->datagrid->addItem($obs);
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

        if($this->load == TRUE) {
            $this->onReload();
        }
        $this->datagrid->createModel();
        return $this->datagrid;
    }

    /**
     * Configura vetor com a marcação dos registro não concluidos
     * param <seq> $user  = seqdo usuario autro do registro
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