<?php
/*
Classe que representa o objeto(tabela) form do banco de daddos
Versão: v001
Data: 02/04/2008
Data de altualização: 14/06/2012
Programador: Wagner Borba
*/

class TForms{

	private $form;      //objeto formulário
	public  $Nform;     //nome do objeto
	private $statseq;     //propriedade de controle de ativação
    private $labelForm;
    private $seq;
    private $dados;
    private $dboKs;

	/*método construtor
	*instancia o objeto forms
	*param		id = identificador do objeto na base de dados
	*/
	public function __construct($seq = NULL){
            try{
                 $this->seq = $this->formseq = $seq;

                //Objeto DBO
                $this->dboKs = new TKrs();                

	            /**
	            * instancia o cabeçalho do formulário
	            * em execução e armazena em sessão
	            */
                $this->obHeader = new TSetHeader();          
                if(!$this->obHeader->testHeader($this->formseq)){
                	$this->obHeader->formHeader($this->formseq);
                }          
                
                //add seqao cabeçalho
                if($this->seq){
                    //echo $this->formseq . " - " . $this->seq;
                    $this->obHeader->addHeader($this->formseq, TConstantes::FORM, $this->seq);
                }

                //retorna o cabeçalho do formulário
                $this->headerForm = $this->obHeader->getHead($this->formseq);

        
            /***********************************************************/

                //configura conteiner de retorno das ações
                if($this->headerForm[TConstantes::LISTA]){
                	$this->paneRet = TConstantes::CONTEINER_LISTA.$this->headerForm[TConstantes::LISTA];
                }else{
                	$this->paneRet = TConstantes::VIEW_DISPLAYSYS;
                }

            }catch (Exception $e){
                new setException($e);
            }
    }

    /**
    * instancia o cabe�alho da lista
    * em execu�ão e armazena em sessão
    * param <type> $formseq
    */
    private function setHeaderForm($formseq){

        $obHeader = new TSetHeader();
        $obHeader->onHeader($formseq);

    }

    /**
     * Retorna os dados do furmulários
     * param <type> $formseq
     * return <type>
     */
    private function getDadosForm($formseq){

        // Dados Formulário
        $this->dboKs->setEntidade('forms');
            $criteriaForm = new TCriteria();
            $criteriaForm->add(new TFilter('seq','=',$this->formseq));
        $retForm = $this->dboKs->select("*", $criteriaForm);
        $obForm = $retForm->fetchObject();

        return $obForm;
    }

    /**
     *
     */
    public function setForm(){
    	
    	// Dados Formulário
        $obsession = new TSession();
        $developer = $obsession->getValue('developer');
        $obForm = $this->getDadosForm($this->formseq);

        // configura as propriedade de acesso ao objeto form
        $this->form         = $obForm->form;
        $this->labelForm    = $obForm->nomeform;
        $this->statseq        = $obForm->statseq;
        $this->dimensao     = $obForm->dimensao;
        //$this->autoSave     = $obForm->autosave;
                 

        //Limpa seqdo formulario para acesso posteriores
        //$this->obsession->setValue('seqatual'.$seq, NULL);

        if($this->formseq!=""){

            //isntancia um sistema de abas do formulario
            $obAbas = new TSetAbas($this->formseq, $this->headerForm['titulo'], $this->dimensao);     

            /// Verifica abas do formulario
            $this->dboKs->setEntidade('form_x_abas');
                $criteriaFormAbas = new TCriteria();
                $criteriaFormAbas->add(new TFilter('formseq', '=', $this->formseq));
                $criteriaFormAbas->add(new TFilter('statseq', '=', '1'));
                $criteriaFormAbas->setProperty('order', 'ordem');
           	$RetIdAbas =  $this->dboKs->select('*', $criteriaFormAbas);         
 
            //executa loop das abas
            while($abasId = $RetIdAbas->fetchObject()){

                //paga nome das abas
                $this->dboKs->setEntidade('abas');
                    $criteriaAbas = new TCriteria();
                    $criteriaAbas->add(new TFilter('seq', '=', $abasId->abaseq));
                $RetNomeAba = $this->dboKs->select('*', $criteriaAbas);
                $NAbas = $RetNomeAba->fetchObject();
                //Instacia objeto [apendice] das abas caso aja.

                if($NAbas->obapendice != "-"){

                    $obApendice = new TApendices();
                    $obElement = $obApendice->main($NAbas->obapendice, $this->formseq);

                    $this->Abas[$NAbas->abaid] = $obElement;
                }
                else{

                    # instancia objetos blocos das abas
                    $this->dboKs->setEntidade('blocos_x_abas');
                        $criteriaAbas = new TCriteria();
                        $criteriaAbas->add(new TFilter('abaseq', '=', $abasId->abaseq));
                        $criteriaAbas->setProperty('order', 'ordem');
                    $RetIdBlocos = $this->dboKs->select('*', $criteriaAbas);
                    
                    while($obBloco = $RetIdBlocos->fetchObject()){
                        $formBloco = new TBloco($this->formseq, $obBloco->blocseq, $this->seq, true);
                        $blocos[$formBloco->getBlocoSeq()] = $formBloco;
                        $formBloco = NULL;
                    }
                    $this->Abas[$NAbas->abaid] = $blocos;
                    $blocos = NULL;
                }
                
                $this->AbasNome[$NAbas->abaid] = ($developer? $NAbas->seq.' - ' : '' ) . $NAbas->nomeaba;
                $this->AbasImpressao[$NAbas->abaid] = $NAbas->impressao;

            }//temina loop das abas
             
               
        }

            //======================================================================================================
            //monta botões extras na aba
            $this->dboKs->setEntidade('form_button');
                $criteriaFormBot = new TCriteria();
                $criteriaFormBot->add(new TFilter('form', '=', $this->formseq));
                $criteriaFormBot->add(new TFilter('statseq', '=', '1'));
                $criteriaFormBot->setProperty('order', 'ordem');
            $runBots = $this->dboKs->select('*', $criteriaFormBot);
            while($retBots = $runBots->fetchObject()){

            	//verifica algum argumento estatico no bontão
            	$dataAction = explode(';', $retBots->actionjs);

                $action = new TAction($dataAction[0]);
                $action->setParameter('tipoRetorno', 'lista');
                $action->setParameter(TConstantes::FORM, $this->formseq);
                $action->setParameter('alvo', $this->paneRet);
                $action->setParameter('confirme', $retBots->confirmacao);
                if($dataAction[1]){
                	$action->setParameter('argEstatico', $dataAction[1]);
                }

                $this->setButton($retBots->botao, $retBots->labelbotao, $action);//.$this->formseq
            }
            //=======================================================================================================

            //executa loop das abas
            foreach($this->Abas as $chAba=>$vlBloco){

                    if(is_array($vlBloco)){//valida se o conte�do das abas não est� vazio
                        foreach($vlBloco as $cch=>$cblocos){

                            $ElBloco[$cch] = $cblocos->getBloco();

                            if($cblocos->formato == "frm"){
                                    $obAbas->setCampos($cblocos->getCamp());
                            }
                        }
                    }
                    else{
                         $ElBloco = $vlBloco;
                    }

                    $obAbas->addAba($this->AbasNome[$chAba], $ElBloco, $this->AbasImpressao[$chAba]);
                    $ElBloco=NULL;
            }//temina loop das abas

         /**
         * executado o objeto formulário
         */
        if($obForm->formainclude == 'one') { // #Verifica a necessidade dessa condição


                    //botão padrão [IMPRIMIR]\\
                    $actionPrint = new TAction('printScreen');
                    $actionPrint->setParameter('impressao','impressao');
                    $actionPrint->setParameter('titulo','impLabel');
                    // Cancelada a A�ão de Imprimir 
                    //$this->setButton('imprimir_botform'.$this->formseq, 'Imprimir', $actionPrint);


                    if($obForm->botconcluir != '0'){
                        // Botão padrão [Salvar] \\
                        $action1 = new TAction('onSave');
                        $action1->setParameter(TConstantes::FORM, $this->formseq);
                        $action1->setParameter('nomeform', $this->formseq.'-window');
                        $action1->setParameter('tipoRetorno', 'form');
                        $action1->setParameter('alvo', $this->paneRet);

                        if($obForm->botconcluir == '2' or strpos($obForm->botconcluir, '/2') !== false){
                            $action1->disabled = 1;
                            $obForm->botconcluir = str_replace('/2', '', $obForm->botconcluir);
                        }

                        if($obForm->botconcluir == '1' or $obForm->botconcluir == '2'){
                            $labelBotSalvar = 'Salvar';
                        }else{
                            $labelBotSalvar = $obForm->botconcluir;
                        }

                        $this->setButton('salvar_botform'.$this->formseq, $labelBotSalvar, $action1, 'botaosalvar');//.$this->formseq
                    }

                    //verifica se a exibi�ão atual foi disparada a partir de um botão editar
                    //if(!$this->obsession->getValue(TConstantes::STATUS_EDITIONFORM) and !$this->obsession->getValue(TConstantes::STATUS_VIEWFORM)) {
                    //botão cancelar padrão [Cancelar]
                    if($obForm->botcancelar != 0){
                    	
                            $action2 = new TAction('onCancel');
                            $action2->setParameter('tipoRetorno', 'form');
                            $action2->setParameter(TConstantes::FORM, $this->formseq);
                            $action2->setParameter('key', $this->seq);
                            $action2->setParameter('alvo', $this->paneRet);
                            $action2->setParameter('confirme', 'Você deseja cancelar?');

                            if($obForm->botcancelar == '2'){
                                $action2->disabled = 1;
                            }

                        $this->setButton('cancelar_botform'.$this->formseq, 'Cancelar', $action2);
                    }else{
                    
                // Botão padrão [FECHAR] \\
		                $action1 = new TAction('onCancel');
                $action1->setParameter('tipoRetorno', 'form');
                $action1->setParameter(TConstantes::FORM, $this->formseq);
		                $action1->setParameter('key', $this->seq);
                $action1->setParameter('alvo', $this->paneRet);
		                $action1->setParameter('confirme', 'Deseja realmente fechar?');
                
                $this->setButton('fechar_botform'.$this->formseq, 'Fechar', $action1);
        }


        }

       return $obAbas;
    }

    /**
    *
    * return <TSetAbas> = retorna um objeto aba
    */
    public function setBloco($blocseq){

        // Dados Formulário
        $dboFormBloco = new TKrs('blocos');
            $criteriaFormBloco = new TCriteria();
            $criteriaFormBloco->add(new TFilter('seq','=',$blocseq));
        $retFormBloco = $dboFormBloco->select("*", $criteriaFormBloco);
        $obFormBloco = $retFormBloco->fetchObject();

        //instancia o objeto Aba
        $obAbas = new TSetAbas($blocseq, $this->headerForm['titulo'], $this->dimensao);

           if($obFormBloco->obapendice and $obFormBloco->obapendice != "-" ){

                $obApendice = new TApendices();
                $obElement = $obApendice->main($obFormBloco->obapendice, $this->formseq);

                $form = $obElement;
           }else{

                // configura as propriedade de acesso ao objeto form
                $this->labelForm    = $obFormBloco->nomebloco;
                $this->idNameBloco  = $obFormBloco->blocseq;
                $this->statseq        = $obFormBloco->statseq;

                $this->formBloco = new TCompForm($blocseq, $blocseq, $this->headerForm['tipo'], $this->seq);
                $this->formBloco->addValor($this->dados);
                $form = $this->formBloco->setFields();

                 $obAbas->setCampos($this->formBloco->getCamp());
           }

           //injeta objeto na aba
        $obAbas->addAba($this->labelForm, $form);

        return $obAbas;
    }

    /**
     *
     * param <type> $dados
     */
    public function setDados($dados){
        $this->dados = $dados;
    }
	
	
    /*setBotton()
    * argumentos de configura�ão dos botões do formulário
    */
    public function setButton($idNome, $label, TAction $action, $classecss = null){
        try{
            if($action){
                $this->bots[$idNome] = $action;
                $this->botsLabel[$idNome] = $label;
                $this->botsClass[$idNome] = $classecss;
            }
            else{
                throw new ErrorException("A ação é inválida.");
            }
        }catch (Exception $e){
            new setException($e);
        }
    }


    /*método getForm
    *Retorna o formulario montado com suas respequitivas abas
    */
    public function getForm(){
         if($this->dados){

                    // percorre e preenche vetor de campos na sessão ====================================
                    $obHeader = new TSetHeader();
                    $headerForm = $obHeader->getHead($this->formseq);
                    $listaCamposSession = $headerForm[TConstantes::CAMPOS_FORMULARIO];
                    
                    if($listaCamposSession and is_array($listaCamposSession)){
                    	
                        foreach($listaCamposSession as $campo=>$infoCampo){
                        	
                        	 $infoCampo[TConstantes::SEQUENCIAL]  = $this->dados[$infoCampo[TConstantes::ENTIDADE]][TConstantes::SEQUENCIAL];
                        	 
                             $infoCampo[TConstantes::FIELD_VALOR]  = $this->dados[$infoCampo[TConstantes::ENTIDADE]][$infoCampo['colunadb']];
                             $infoCampo[TConstantes::FIELD_STATUS] = 1;
                             $listaCamposSession[$campo] = $infoCampo;
                        }
                        
                        $obHeader->addHeader($this->formseq, TConstantes::CAMPOS_FORMULARIO, $listaCamposSession);
                    }
                    //===================================================================================

         }
    	
         $form = $this->setForm();
         if($this->dados){
            $form->setData($this->dados);
         }
   
         if($this->bots){
             foreach($this->bots as $idNome=>$act){
                $form->addBotao($idNome, $this->botsLabel[$idNome], $act, $this->botsClass[$idNome]);
             }
         } 
         
        $form->setAbas();
        
        
       // janela objeto formulário
      //$window = new TWindow($this->labelForm, $this->formseq.'-window');
     //  $window->setAutoOpen();
      //  if($this->dimensao){
       //     $dimensao = explode(';', $this->dimensao);
       //     $window->setSize($dimensao[0],$dimensao[1]);
       // }
      //  $window->add($form);

        $this->dboKs->close();
        return $form;
    }

}