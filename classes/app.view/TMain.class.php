<?php
/*******************************************************************************
Classe conteiner de ações da estrutura de dados
Versão: 1.1.2
Data: 06/03/2010
Programador: Wagner Borba 
*******************************************************************************/

/*
* run()
* Executa determinado método de acordo com
* os parámetros recebidos
*/
if(!function_exists("__autoload") && !is_callable("__autoload")) {
    function __autoload($classe) {

        include_once('../app.util/autoload.class.php');
        $autoload = new autoload('',$classe);
    }
}


/**
 * Recepta as ações enviadas por get
 * instancia o objeto execs e executa o
 * metodo em questão
 */
if ($_GET['method']) {
				
    $method = $_GET['method'];
    $ObExec = new TMain($method, $_GET);
}

#########################################################################################################################

class TMain {

    public function __construct($metodo, $param) {

        $this->param = $param;
        $this->tipoRetorno = $this->param['tipoRetorno'];
        $this->idObject = $this->param[TConstantes::FORM];
                
        //define de a execução vai ser recursiva
        if($this->param['typeRun']){
        	$this->typeRun = $this->param['typeRun'];
        }else{
        	$this->typeRun = 'one';
        }
                
        //Retorna Usuario logado===================================
        $obUser = new TCheckLogin();
        $this->obUser = $obUser->getUser();

        //=========================================================
        
        //Instancia manipulador de sessão
        $this->obsession = new TSession();
        
        //Instancia objeto head
        $this->obHeader = new TSetHeader();
        
                
        if($this->param['method'] == 'getList' or $this->param['method'] == 'onPesquisa'){
        	
	        	if($this->param['method'] == 'getList'){
        			$this->obHeader->clearHeader();
	        	}
        		$this->header = $this->obHeader->listHeader($this->idObject);
        	
        }else{
        	// verifica se o cabeçalho para formulario já foi inicializado
        	if($this->obHeader->testHeader($this->idObject)){
        		$this->header = $this->obHeader->getHead($this->idObject);
        	}else{
        		$this->header = $this->obHeader->formHeader($this->idObject);
        	}
        }
                        
        $this->nivelExec = $this->header[TConstantes::HEAD_NIVEL];
                        
      // $xxx = $this->obHeader->getHead($this->header['frmpseq']);
                        
        //configura conteiner de retorno das a��es
		//$this->conteinerRetorno = $this->header[TConstantes::HEAD_CONTEINERRETORNO];
		
		$this->entidadeForm = $this->header[TConstantes::ENTIDADE];

            // chaves de acesso a listabBox
            $this->idObjectBoxAtual = 'obListaBox_'.$this->header[TConstantes::LISTA];//$this->idObject;
            $this->listaBox = "listaBox";
            
            
            $xx = $this->obsession->getValue('boxFiltro_'.$this->header[TConstantes::LISTA]);
            
            //Limpa sessão do listaBox
           /* if($this->param['nivel'] == 1){
                $this->obsession->setValue($this->idObjectBoxAtual, null, $this->listaBox);
            }*/

            /**
            * Limpa campo de status de Visualização do formulário
            * atribuido quando executado o botão de visualizar
            */
//$this->obsession->setValue(TConstantes::STATUS_VIEWFORM, NULL);
        
        
        //testa existencia do metodo e executa
        if(method_exists($this, $metodo)) {
        	
        	array_shift($param);//retira a primeira posição [metodo] dos paramentros
            call_user_func(array($this, $metodo), $param);
        }
        
    }
    #############################################################################################
    #############################################################################################

    /*
    * método getList()
    * Instancia objeto lista diretamente do TCompLista
    */
    public function getList() {

    	$this->obsession->setValue($this->idObjectBoxAtual, null, $this->listaBox);

        //lista de dados
        $setLista = new TCompLista($this->idObject);

        $this->obLista = $setLista->get();

        // dados do autor direto do objeto lista
        // $listDados = $setLista->getListDados();

        $this->showlist();
    }

    /**
    * Instancia objeto (lista) armazenado em sessão
    * e disponibilida o mesmo na classe de execução
    */
    private function getObLista(){
        if($this->idObject) {
        	        	
            $this->obLista = $this->obsession->getValue($this->idObjectBoxAtual, $this->listaBox);   	    	

            $this->obLista->setLoad(true);    //com erro...  
        }
    }

    
    
    /**
     * método getform()
     * instancia objeto form
     */
    public function getform($dados = NULL) {
    		
        /**
         * armazena seq do objeto(registro) em sessão para associações (chave estrangeira) dos objetos filhos
         */
        if($dados[$this->entidadeForm][TConstantes::SEQUENCIAL]){
        	$this->obHeader->addHeader($this->idObject,TConstantes::SEQUENCIAL, $dados[$this->entidadeForm][TConstantes::SEQUENCIAL]);
        	$this->header = $this->obHeader->getHead($this->idObject);
        	//$this->obsession->setValue('seqatual'.$this->idObject, $dados['seq']);
        }
                
        /**
        * Instancia objeto lista principal
        * usando DForm que monta o fomulário pai
        * completo (form, aba, blocos e botões)
        */
        $OBform = new TForms($this->idObject);
        
        if($dados){
            $OBform->setDados($dados);
        }
           
        $forms = $OBform->getForm(is_numeric($this->param['key']));
        $forms->show();

        //define o formulário em aberto
        $this->obsession->setValue('checkFormPrimario',$this->header[TConstantes::LISTA]);
    }

     /**
     * Abre o formulário para criar um novo registro
     */
    public function onNew() {
    	
            //==============================================
            //aplica regras de negocio na inclusão da lista
            $retorno = $this->setInControl();

        $this->obsession->setValue(TConstantes::STATUS_EDITIONFORM, NULL);
        //grava status do formulário no cabeçalho
        $this->obHeader->addHeader($this->idObject, "status", 'new');

        $forms = $this->getform();
    }


    /**
     * método onEdit
     * carrega os dados do registro no formulário
     * param  $param = parámetros passados via URL ($_GET) instanciado no contrutor
     */
    public function onEdit() {

        try {
        	        	
        	//Identifica se o campo está em banco em em sessão
			if(is_numeric($this->param['key'])){//$this->nivelExec != 1){
	  	
				//fluxo normal
				
				//==============================================
				//aplica regras de negocio na inclusão da lista
				$retorno = $this->setInControl();
				
				// obtém o objeto pelo ID
				$ObDados = new TDados($this->idObject, $this->param['key'], $this->header['tipo'], $this->entidadeForm);
				$dados = $ObDados->get();
			    	
			}else if(strpos($this->param['key'],'TMP') !== false){
	  	
	  	   		//Agrega objeto na lista de objetos em memoria
				$headList = $this->obHeader->getHead($this->header[TConstantes::LISTA]);
   					  	
				$results_session = $this->obHeader->getHead($headList[TConstantes::LISTA], TConstantes::LIST_OBJECT);

              		foreach($results_session[$this->param['key']] as $campo){   
              			$objResult['seq']  = $this->param['key'];		
            			$objResult[$campo['colunadb']] = $campo['valor'];
            			
            		}     		
            		$objResult['statseq'] = 1;
	  			
				$dados[$this->entidadeForm] = $objResult;
			    	
			}
        
            /**
             * armazena ID do registro em questão para registro de histórico
             * de movimento do sistema
             */
            $this->obsession->setValue(TConstantes::STATUS_EDITIONFORM, 'editando');
            //grava status do formulário no cabeçalho
            $this->obHeader->addHeader($this->idObject, "status", 'edit');    

            // Executa o editor do formulário se o mesmo for solicitado
            $this->getform($dados);

        }
        catch (Exception $e) { // em caso de exceção
        	
        	// desfaz todas alterações no banco de dados
            TTransaction::rollback();
            // exibe a mensagem gerada pela exceção
            new setException($e->getMessage());
        }
    }
    
    /**
     * Executa ação de salvar do formulario armazenado em sessão
     * return <type>
     */
    private function getColumnName($camposSession,$colunaDb){
    	if($camposSession[$colunaDb]){
    		return $colunaDb;
    	}
    	foreach($camposSession as $id => $campo){
    		if($campo['colunadb'] == $colunaDb){
    			return $id;
    		}
    	}
    }
    
    public function onSave(){
    	
     	 
    	$this->idObject = $this->header[TConstantes::LISTA];
    	
    	//retorna lista de campos do cabeçalho do formulário
    	$camposSession = $this->header[TConstantes::CAMPOS_FORMULARIO];
    	//retorna valores da tela
    	$dadosForm = $_POST;
    	    	    	    	    	
   		//Agrega objeto na lista de objetos em memoria
   		$headList = $this->obHeader->getHead($this->header[TConstantes::LISTA]); 
   		
   		$obControl = new TSetControl();
   		$seqRetorno = TConstantes::ERRO_0;
   		
   		
   		
    	// percorre o retorno da tela e injeta o valor no bean
    	if($camposSession){
    		foreach($dadosForm as $colunaDb=>$valorCampo){
    			
    			$nomeCampo = $this->getColumnName($camposSession,$colunaDb);
    				    			
    			if(!$valorCampo){
    				$valorCampo = null;
    			}
    			    			
    			//carrega sequencial no campo se existir  - [Verifica necessidade]
    			if($this->header[TConstantes::SEQUENCIAL] and is_numeric($this->header[TConstantes::SEQUENCIAL])){
    				    				
    				if($this->header[TConstantes::ENTIDADE] == $camposSession[$nomeCampo][TConstantes::ENTIDADE]){
    					$camposSession[$nomeCampo][TConstantes::SEQUENCIAL] = $this->header[TConstantes::SEQUENCIAL];
    				}else{
    					$dados[$camposSession[$nomeCampo][TConstantes::ENTIDADE]][$this->header[TConstantes::HEAD_COLUNAFK]] = $this->header[TConstantes::SEQUENCIAL];
    				}
    			}
    			else if($this->nivelExec > 1){
    				    				    				
    				//se for sequencial temporario    				
    				if(is_numeric($camposSession[$nomeCampo]['seq'])){
    					$seq_tmp = $camposSession[$nomeCampo]['seq'];
    				}else{    				
    					$seq_tmp = 'TMP'.time();
    					$camposSession[$nomeCampo]['seq'] = $seq_tmp;
    				}
    				
    			}
    			
    			//valida regras incontrol
    			
    			//=====================================================================
    			//valida campos obrigatórios
    			if($camposSession[$nomeCampo][TConstantes::FIELD_NOTNULL] == '1'){
    				 
    				$retornoValidaNulos = $obControl->setNulos($camposSession[$nomeCampo][TConstantes::FIELD_LABEL], $valorCampo);
    			
    				if($retornoValidaNulos !== false){
    					$seqErro = TConstantes::ERRO_OBRIGATORIEDADE;
    					echo $seqErro.'#'.$retornoValidaNulos;
    					exit();
    				}
    			}
    			//======================================================================
    			
    			/***************************************************************************
    			 * Aplica regra de negócios do campo se ouver
    			*/
    			if($camposSession[$nomeCampo][TConstantes::FIELD_INCONTROL] != "0" and $camposSession[$nomeCampo][TConstantes::FIELD_INCONTROL] != "") {
    				$obControl = new TSetControl();
    				$returVal = $obControl->main($camposSession[$nomeCampo][TConstantes::FORM], $camposSession[$nomeCampo][TConstantes::ENTIDADE], $camposSession[$nomeCampo][TConstantes::FIELD_INCONTROL], $valorCampo, $colunaDb);
    			
    				//se a validação não for verdadeira retorna uma msg
    				if($returVal['valor'] === false) {
    					$seqRetorno = $returVal['seqRetorno'];
    					echo $seqRetorno.'#'.$returVal['msg'];
    					exit();
    				}else{
    					$valorCampo = $returVal['valor'];
    				}
    					
    			}    			
    			
    			$campoAtual = $camposSession[$nomeCampo];
    			$campoAtual['valor'] = $valorCampo;
    			$campoAtual[TConstantes::FIELD_STATUS] = 0;
    			 
    			$camposSession[$nomeCampo] = $campoAtual;
    			
    			//popula objeto de dados para persistencia agrupando por entidade
    			$dados[$camposSession[$nomeCampo][TConstantes::ENTIDADE]][$colunaDb] = $valorCampo;
    			 
    			//Seta o sequêncial do registro caso exista
    			if(!$dados[$camposSession[$nomeCampo][TConstantes::ENTIDADE]][TConstantes::SEQUENCIAL] and $camposSession[$nomeCampo][TConstantes::SEQUENCIAL]){
    				$dados[$camposSession[$nomeCampo][TConstantes::ENTIDADE]][TConstantes::SEQUENCIAL] = $camposSession[$nomeCampo][TConstantes::SEQUENCIAL];
    			}
    		}
    	}
    	
    	//atualiza a alteração na sessão
    	$this->obHeader->addHeader($this->header[TConstantes::FORM], TConstantes::CAMPOS_FORMULARIO,  $camposSession);
    
    		
    		//recupera seq da unidade
    		//$unidseq = $this->obUser->unidseq->seq;
    		    		
    		    		
    		//Identifica o nivel do formulário
		    if($this->nivelExec > 1 and strpos($seq_tmp, 'TMP') !== false){
		    			    			    			    			    	
		    		$results_session = $this->obHeader->getHead($this->header[TConstantes::LISTA], TConstantes::LIST_OBJECT);
		    				    		
		    			//destroi registro caso já exista um item na sessão da lista com o seq temporario
		    			unset($results_session[$this->header[TConstantes::SEQUENCIAL]]);
		    					    			    		
		    		$results_session[$seq_tmp] = $camposSession;		    		
		    		$this->obHeader->addHeader($this->header[TConstantes::LISTA], TConstantes::LIST_OBJECT, $results_session);
		    				    		
		    		$seq = null;
    					
		    }else{    			    		
		    	
		    		//navega nas listas de registros filhos
		    		$childs = $this->header[TConstantes::HEAD_HEADCHILDS];
		    		if(is_array($childs) && count($childs)>0){
		    			$dadosChilds = null;		    			    			
			    			
			    		foreach($childs as $listChild){
			    						    			
			    			$listCount = $this->obHeader->getHead($listChild[TConstantes::LISTA], TConstantes::LIST_COUNT);
			    						    						    					    			
			    			//Valinda obrigatoriedade da ista interna em questão
			    			if($listChild[TConstantes::LIST_REQUIRED]){
			    							    							    				
			    				if($listCount == 0){
		    							$seqErro = TConstantes::ERRO_OBRIGATORIEDADE;
		    							echo $seqErro.'#'.TMensagem::ERRO_OBRIGATORIEDADELISTA;
		    							exit();
			    				}
			    			}			    			
			    			
			    			$regChilds = $this->obHeader->getHead($listChild[TConstantes::LISTA], TConstantes::LIST_OBJECT);
							$dadosChilds = null;
			    			foreach($regChilds as $regChd){
			    				
			    				foreach($regChd as $idcampo=>$reg){
			    								    								    							    				
			    					//agrupa campos por entidade para manter no banco
    								$dadosChilds[$reg[TConstantes::ENTIDADE]][$idcampo] = $reg['valor'];
    								
			    				}
			    				
			    				//agrega registro aos demais para ser mantido
			    				$dados[TConstantes::HEAD_HEADCHILDS][] = $dadosChilds;
			    			}
			    		}

		    		}
		    		

		    	$critKrsTables = new TCriteria();
		    	
		    	$obKrsFormTables = new TKrs('form_x_tabelas');
		    	$critKrsFormTables = new TCriteria();
		    	$critKrsFormTables->add(new TFilter(TConstantes::FORM,'=',$this->header[TConstantes::FORM]));
		    	$retKrsFormTables = $obKrsFormTables->select("tabseq",$critKrsFormTables);
		    	while($tabKey = $retKrsFormTables->fetchObject()){
		    		$critKrsTables->add(new TFilter("seq", '=', $tabKey->tabseq),'OR');
		    	}
		    		
		    	$obKrs = new TKrs('tabelas');
		    	$retKrs = $obKrs->select("seq,tabela,tabseq,colunafilho",$critKrsTables);
		    	
		    	$tables = array();
		    	$seqs = array();
		    	while($entidade = $retKrs->fetchObject()){
		    		if(!$entidade->tabseq){
		    			$tables = array_merge(array($entidade->seq=>$entidade),$tables); //coloca no inicio
		    		}else{
		    			$tables = array_merge($tables,array($entidade->seq=>$entidade)); //coloca no final
		    		}
		    	}
		    	
		    	//percorre os campos agrupados por entidade e mantem os dados em banco 
		   		foreach($tables as $entData){
		   			$entidade = $entData->tabela;
		   			$dado = $dados[$entidade];
		   			if(count($dado) > 0){
		   				if($entData->tabseq && $seqs[$entData->tabseq]){
		   					$dado[$this->header[TConstantes::HEAD_COLUNAFK]] = $seqs[$entData->tabseq];
		   				}	   				
		   				$seqs[$entData->seq] = $this->loadSave($entidade, $dado);	
			    		if($entidade == $this->entidadeForm){
			    			$seqAtual = $seqs[$entData->seq];
			    		}
		   			}
		    	}
		    	
		    	if(count($dados)){
			    	foreach($dados as $entidade=>$dado){
			    		if($entidade == TConstantes::HEAD_HEADCHILDS){
				    		foreach($dado as $filho){
				    			foreach($filho as $entidadeFilho=>$dadoFilho){
				    				//atribui FK do pai ao filho
				    				$dadoFilho[$this->header[TConstantes::HEAD_COLUNAFK]] =  $seqAtual;
				    				$seqAtualFilho = $this->loadSave($entidadeFilho, $dadoFilho);
				    			}
				    		}
			    		}
			    	}
		    	}
    		
		   		//seta nivel de execução para limpar a head da lista
		   		$this->nivelExec = 1;
		    }
    		
    		//seta o id da lista no idObject
    		//$this->idObject = $this->header[TConstantes::LISTA];
    		
		    //Atribui SEQ atual do registro salvo ao cabeçalho em questão.
		    $this->header[TConstantes::SEQUENCIAL] =  $seqAtual;
		    

		    //executa a função de controle do formulário se existir
		    if($this->header[TConstantes::HEAD_OUTCONTROL]){
		    	$formOutControl = explode('/', $this->header[TConstantes::HEAD_OUTCONTROL]);
		    	$retornoOutcontrol = $this->onMain($formOutControl);
		    }
    		
    	//Fecha o formulário
    	if($this->typeRun == 'one'){
    	$this->onClose();
    	}
    	return $seqAtual;
    
    }
    
    /**
     * Carrega os dados a serem salvos no banco de dados
     * @param unknown_type $dados = vetor com todos os campos que dever ser salvos indexados por entidade
     */
    private function loadSave($entidade, $dados){
    	
    		// Declara objeto de persistencia	
    		$obDbo = new TDbo();	
    				    		    
    			//se o registro existir executa update
    			if($dados[TConstantes::SEQUENCIAL]) {
    				    				
    				$obDbo->setEntidade($entidade);
    				$criteriaUpCampo = new TCriteria();
    				$criteriaUpCampo->add(new TFilter(TConstantes::SEQUENCIAL, '=', $dados[TConstantes::SEQUENCIAL]));
    				$retorno = $obDbo->update($dados, $criteriaUpCampo);	

    				$seq = $dados[TConstantes::SEQUENCIAL];
    				
    			}
    			//Se não executa insert
    			else{
    					
    				$obDbo->setEntidade($entidade);
    				$retorno = $obDbo->insert($dados);
    				
    				$seq = $retorno[TConstantes::SEQUENCIAL];
    				 
    			}		    					
	    
	    $obDbo->close();
	    
	    return $seq;
    	
    }
  

    /*
    * Gera um formulário independente
    * onSet precisa ser reavaliado
    */
    public function onFormOpen() {

        $OBform = new TForms($this->idObject);

        //Adicina botões na barra de navegação
        // Botão padrão [Fechar]
        $action1 = new TAction('onClose');
        $action1->setParameter('tipoRetorno', 'form');
        $action1->setParameter(TConstantes::FORM, $this->idObject);
        $action1->setParameter('alvo', '');
        $action1->setParameter('confirme', '');
        $OBform->setButton('fechar_botform'.$this->idObject, 'Fechar', $action1);

        $forms = $OBform->getForm();
        $forms->show();
    }

   
    /*
    * Exibe todas as informações do objeto(registro) via o seq do mesmo
    */
    public function onView() {
        try {

            //grava status do formulário no cabeçalho
            $this->obHeader->addHeader($this->idObject, "status", 'view');

            // obtém o objeto pelo ID
            $ObDados = new TDados($this->idObject, $this->param['key'], $this->header['tipo'], $this->entidadeForm);
            $dados = $ObDados->get();

/*             if($this->obsession->getValue(TConstantes::STATUS_VIEWFORM) != "form") {
                $this->obsession->setValue(TConstantes::STATUS_VIEWFORM, $this->header['tipo']);
            } */

            // Executa o editor do formulario se o mesmo for solicitado
            $forms = $this->getform($dados);

        }
        catch (Exception $e) { // em caso de exceção

            TTransaction::rollback();
            // exibe a mensagem gerada pela exceção
            new TMessage('error', '<b>Erro</b>' . $e->getMessage());
            // desfaz todas alterações no banco de dados

        }
    }

    /*
    *Recarrega a lista alvo
    */
    public function onRefresh(){

    	$this->obHeader->clearHeader($this->idObject);

        //recarrega a lista
        $this->getList();
        //limpa [seq] do formulario secundario em sessão ref.:(compilerData.php)
        $this->obsession->setValue('tempBloco',NULL);
    }

   
    /*
    * Fecha o formulario atualizando a listagem.
    */
    public function onClose() {

    	//destroi cabeçalho do form
    	if($this->header[TConstantes::HEAD_NIVEL] == 1){
    		$this->obHeader->clearHeader();
    	}else{
        	$this->obHeader->clearHeader($this->header[TConstantes::FORM]);
    	}
    	
    	//recarrega a lista
    	$this->getList();
    }

    /*
    *Fecha o formulário sem atualizar a listagem
    */
    public function onCancel() {
    	
    	//$this->getObLista();
    	    	    	
    	if($this->header[TConstantes::LISTA]){
        $this->showlist(); 
    	}
        $this->obHeader->clearHeader($this->header[TConstantes::FORM]);
        
    }

    
    #############################################
    # ações da lista
    #############################################

    /**
     * transfere para lista em sessão a ação deletar executa na camada visual
     * pelo botão responsavel pela ação (excluir)
     */
    public function onDelete() {
    	
    	if($this->param['key'] and $this->entidadeForm) {
            
	          //Identifica o nivel do formulário
			  if($this->nivelExec > 1 and strpos($this->param['key'], 'TMP') !== false){
			  	
			  	   		//Agrega objeto na lista de objetos em memoria
	   					$headList = $this->obHeader->getHead($this->header[TConstantes::LISTA]); 
			  	
			  			$results_session = $this->obHeader->getHead($headList[TConstantes::LISTA], TConstantes::LIST_OBJECT);
			  			
						unset($results_session[$this->param['key']]);
			    		$this->obHeader->addHeader($headList[TConstantes::LISTA], TConstantes::LIST_OBJECT, $results_session);
			    	
			  }else{
			    	
			    //==============================================
	            //aplica regras de negocio na inclusão da lista
	            $retorno = $this->setInControl();

	            	$this->getObLista();

	            	//onDelente TSetlista();
		            $this->obLista->onDelete($this->param['key'], $this->entidadeForm);
	
					
			 }
			 
			 //$this->getList();//Substituir por backbone.js 
			 $this->getObLista();
			 $this->showlist();
    	
    	}else{
	        // Lança exeção de erro na execução da sql
	        new setException("Os parametros não foram definidos corretamente (TMain.onDelete) - Linha - 579");
		}
    }

    /*
    *filtra dados
    */
    public function onFilter() {

/*     	//retorna lista de campos do cabeçalho do formul�rio
    	$camposSession = $this->header[TConstantes::CAMPOS_FORMULARIO];
    	
    	$filtro = $_POST;
    	
    	foreach ($filtro){
    		
    	} */

        $this->getObLista();//Substituir por backbone.js
        $filtro = $_POST;

        $this->obLista->setFiltro($filtro);
        $this->obLista->clearSelecao();
        $this->showlist();
    }
    
    /*
    *fAltera limite
    */
    /**
     * 
     */
    public function onChangeLimit() {
        $this->getObLista();//Substituir por backbone.js
        
       	$limite = $this->obsession->getValue("comboLimite" . $this->idObject);
       	
        $this->obLista->setLimite($limite);
        $this->obLista->clearSelecao();
        $this->showlist();
    }
    
    /*
    *limpa sessões de filtro
    */
    public function onClearFilter() {
        $this->getObLista();//Substituir por backbone.js
        
        $this->obLista->clear();
        $this->obLista->clearSelecao();
//  $this->obsession->setValue("dadosFiltroListaAtual",NULL);
        $this->showlist();
    }

    /*
    *Exibe janela de filtro
    */
    public function onViewFilter() {

        $this->getObLista();//Substituir por backbone.js
        $filtro = $_POST;

        $this->obLista->setFiltro($filtro);

    }

    /**
     * método onOrder()
     * metodo para ordenar lista de dados
     */
    public function onOrder($param) {
        try{
            if($param['key']!="") {
                
                $this->getObLista();//Substituir por backbone.js

                if($this->obLista){
                    $this->obLista->setOrdem($param['key']);
                    $this->showlist();
                }
                else{
                    throw new ErrorException("A lista não foi instânciada na memoria de execução.");
                }
            }else{
                throw new ErrorException("A coluna passada é inválida.");
            }
        }catch(Exception $e){
            new setException($e);
        }
    }


     /**
     * método onReply
     * gatilho para replicação de formularios
     * param  $param = parâmetros passados via URL ($_GET) instanciado no contrutor
     */
    public function onReply() {

        try {
            $this->getObLista();//Substituir por backbone.js
            $cloneForm = new TCloneForm();
            $cloneForm->confirm($this->idObject, $this->param['key'],$this->idObject);

        }
        catch (Exception $e) { // em caso de exceção
            TTransaction::rollback();
            // exibe a mensagem gerada pela exceção
            new setException($e->getMessage());
            // desfaz todas alterações no banco de dados
        }
    }

    /*
    *Retrocede os registros listados
    */
    public function onBack() {

        $this->getObLista();//Substituir por backbone.js

        if($this->obLista->posicao>0) {
            $posicao = $this->obLista->posicao - $this->obLista->limite;
        }
        $this->obLista->setPosition($posicao);
        $this->showlist();
    }

    /*
    *Avança os registros listados
    */
    public function onNext() {

        $this->getObLista();//Substituir por backbone.js
        
        $posicao = $this->obLista->posicao + $this->obLista->limite;
       
        $this->obLista->setPosition($posicao);
        $this->showlist();
    }

    /*
    * Executa a janalea de pesquisa
    */
    public function onPesquisa() {

        $obPesq = new TSetPesquisa($this->param['key']);        
        $obPesq->show();
    }

        /**
     * método onPrint()
     * metodo para imprimir uma lista de dados
     */
    public function onPrint($param) {
        try{            
            $this->getObLista();//Substituir por backbone.js
            $this->obLista->setPrint();

        }catch(Exception $e){
            new setException($e);
        }
    }

    /**
    * executa ação de multeseleção na lista
    */
    public function onSelecao(){
        try{
            if($this->param['dados'] and $this->param['acselecao']){
            	
            	//$dados = json_decode($this->param['dados']);
            	
               $this->getObLista();//Substituir por backbone.js
               $this->obLista->setSelecao($this->param[TConstantes::FORM], $this->param['dados'], $this->param['acselecao']);

               if($this->param['dados'] == 'all'){
                   $this->showlist();
               }
            }else{
                throw new Exception('Os dados passados para a seleção são inválidos.');
            }
        }catch(Exception $e){
            new setException($e);
        }
    }

    /*método showlist()
    /Armazena novo objeto lista em sessão e imprime o novo objeto
    */
    public function showlist() {
    	
        if(!$this->obLista){
            $this->getObLista();
            
            if(!$this->obLista){
            	throw new Exception('Lista não encontrada');
            	exit;
            }
        }
        
        if($this->header[TConstantes::HEAD_NIVEL] == 1) {
        	//Limpa o histórico do objeto lista em cach
            $this->obsession->delValue($this->listaBox);

           //isntancia um formulario
           $panel = new TPanel('');
           $panel->id = $this->header[TConstantes::HEAD_CONTEINERRETORNO];
           $panel->add($this->obLista->getLista());
            //$panel = new TWindow('Lista '.$this->header['tituloLista'],$this->conteinerRetorno);            
            //$panel->add($this->obLista->getLista());
        }else if($this->header[TConstantes::HEAD_NIVEL] == 2) {
        	$panel = $this->obLista->getLista();
        }

        // Subustitui objeto lista da sessão pelo novo objeto lista \\
        $this->obsession->setValue($this->idObjectBoxAtual, $this->obLista, $this->listaBox);
      
        $panel->show();

    }

    /**
     *
     * param <type> $chave
     * return <type>
     */
    private function getHeader($chave){
        if($chave){
            /**
            * instancia o cabeçalho do formulário
            * em execução e armazena em sessão
            */
                $obHeader = new TSetHeader();
                $obHeader->formHeader($chave);

                //retorna o cabeçalho do formulário
                $header = $obHeader->getHead($chave);
            /***********************************************************/
            return $header;

        }
    }

    /**
    *
    */
    private function setInControl(){
        if($this->header[TConstantes::FIELD_INCONTROL]){

            $obInControl = new TSetControl();
            $retorno = $obInControl->main($this->header[TConstantes::FORM], $this->entidadeForm, $this->header[TConstantes::FIELD_INCONTROL], $this->header['seqPai'], $this->conteinerRetorno);
            
            if($retorno){
               echo $retorno;
               exit;
            }
        }
    }
    
    
    /**
     * Executa uma classe/metodo setado como argumento na chamada
     * da TMain para execução de regras de negocio
     * 
     */
    public function onMain($control = null){

    	$classe = $control[0];
    	$method = $control[1];
    	
    	if(!method_exists($classe, $method)){
    		$classe = $_POST['class'];
    		$method = $_POST['method'];
    		unset($_POST['class']);
    		unset($_POST['method']);
    	}
    	
    	$dados = $_POST;
    	
    	if($this->header[TConstantes::LISTA]){
    	$this->getObLista();
    	}
    	
    	$ObExec = new $classe();
    	if(method_exists($ObExec, $method)){
    		//$retorno = $ObExec->$method($parametros);
    		$retorno = call_user_func_array(array($ObExec, $method), array($this->header,$dados));
    			if(is_object($retorno)){
    				return $retorno->show();
    			}else{
    				echo $retorno;
    			}
    		//se for um retorno de erro interrompe a execução
    		if(strpos($retorno,'erro#') !== false){
    			exit();
    		}
    		
    		if($this->typeRun == 'one'){
    			//$this->obHeader->clearHeader($this->header[TConstantes::FORM]);
    	}
    	}
    	else{
    		// lança exeção de erro na execução da sql
    		new setException("O método ".$method." não existe na classe ".$classe."().");
    	}
    	
    }
}