<?php
/*
Classe que representa o objeto(tabela) form do banco de daddos
Versão: v001
Data: 02/04/2008
Data de altualização: 24/01/2012/--/----
Programador: Wagner Borba
*/

class TForms{

		private $form;      //objeto formulário
		public  $Nform;     //nome do objeto
		private $ativo;     //propriedade de controle de ativação
        private $labelForm;
        private $codigo;
        private $dados;
        private $dboKs;

	/*método construtor
	*instancia o objeto forms
	*param		id = identificador do objeto na base de dados
	*/
	public function __construct($id, $codigo = NULL){
            try{
                 $this->codigo = $codigo;
                 $this->idForm = $id;

                //Objeto DBO
                $this->dboKs = new TKrs();

	            /**
	            * instancia o cabeçalho do formulário
	            * em execução e armazena em sessão
	            */
                $this->obHeader = new TSetHeader();
                if(!$this->obHeader->testHeader($this->idForm)){
                    $this->obHeader->onHeader($this->idForm);
                }

                //add codigo ao cabeçalho
                if($this->codigo){
                    //echo $this->idForm . " - " . $this->codigo;
                    $this->obHeader->addHeader($this->idForm, "codigo", $this->codigo);
                }

                //retorna o cabeçalho do formulário
                $this->headerForm = $this->obHeader->getHead($this->idForm);

        
            /***********************************************************/

                //configura conteiner de retorno das ações
                $this->paneRet = 'contLista'.$this->headerForm['idLista'];

            }catch (Exception $e){
                new setException($e);
            }
    }

    /**
    * instancia o cabeçalho da lista
    * em execução e armazena em sessão
    * param <type> $idForm
    */
    private function setHeaderForm($idForm){

        $obHeader = new TSetHeader();
        $obHeader->onHeader($idForm);

    }

    /**
     * Retorna os dados do furmulários
     * param <type> $idForm
     * return <type>
     */
    private function getDadosForm($idForm){

        // Dados Formulário
        $this->dboKs->setEntidade('forms');
            $criteriaForm = new TCriteria();
            $criteriaForm->add(new TFilter('id','=',$this->idForm));
        $retForm = $this->dboKs->select("*", $criteriaForm);
        $obForm = $retForm->fetchObject();

        return $obForm;
    }

    /**
     *
     */
    public function setForm(){
    	
    	// Dados Formulário
        $obForm = $this->getDadosForm($this->idForm);

        // configura as propriedade de acesso ao objeto form
        $this->form         = $obForm->form;
        $this->labelForm    = $obForm->nomeform;
        $this->ativo        = $obForm->ativo;
        //$this->autoSave     = $obForm->autosave;
                 

        //Limpa codigo do formulário para acesso posteriores
        //$this->obsession->setValue('codigoatual'.$id, NULL);

        if($this->idForm!=""){

            //isntancia um sistema de abas do formulario
            $obAbas = new TSetAbas($this->idForm, $this->headerForm['titulo'], $obForm->dimensao, $this->autoSave);     

            /// Verifica abas do formulario
            $this->dboKs->setEntidade('form_x_abas');
                $criteriaFormAbas = new TCriteria();
                $criteriaFormAbas->add(new TFilter('formid', '=', $this->idForm));
                $criteriaFormAbas->add(new TFilter('ativo', '=', '1'));
                $criteriaFormAbas->setProperty('order', 'ordem');
            $RetIdAbas =  $this->dboKs->select('*', $criteriaFormAbas); 

            //echo($criteriaFormAbas->dump());
            //print_r($criteriaFormAbas);
            //exit();
 
            //executa loop das abas
            while($abasId = $RetIdAbas->fetchObject()){

                //paga nome das abas
                $this->dboKs->setEntidade('abas');
                    $criteriaAbas = new TCriteria();
                    $criteriaAbas->add(new TFilter('id', '=', $abasId->abaid));
                $RetNomeAba = $this->dboKs->select('*', $criteriaAbas);
                $NAbas = $RetNomeAba->fetchObject();
                //Instacia objeto [apendice] das abas caso aja.

                if($NAbas->obapendice != "-"){

                    $obApendice = new TApendices();
                    $obElement = $obApendice->main($NAbas->obapendice, $this->idForm);

                    $this->Abas[$NAbas->idaba] = $obElement;
                }
                else{

                    # instancia objetos blocos das abas
                    $this->dboKs->setEntidade('blocos_x_abas');
                        $criteriaAbas = new TCriteria();
                        $criteriaAbas->add(new TFilter('abaid', '=', $abasId->abaid));
                        $criteriaAbas->setProperty('order', 'ordem');
                    $RetIdBlocos = $this->dboKs->select('*', $criteriaAbas);
                    while($obIdBlocos = $RetIdBlocos->fetchObject()){
                        $formBloco = new TBloco($this->idForm, $obIdBlocos->blocoid, $this->codigo, true);
                        $blocos[$formBloco->getIdbloco()] = $formBloco;
                        $formBloco = NULL;
                    }
                    $this->Abas[$NAbas->idaba] = $blocos;
                    $blocos = NULL;
                }
                $this->AbasNome[$NAbas->idaba] = $NAbas->nomeaba;
                $this->AbasImpressao[$NAbas->idaba] = $NAbas->impressao;

            }//temina loop das abas
             
               
        }

            //======================================================================================================
            //monta bot�es extras na aba
            $this->dboKs->setEntidade('form_button');
                $criteriaFormBot = new TCriteria();
                $criteriaFormBot->add(new TFilter('form', '=', $this->idForm));
                $criteriaFormBot->add(new TFilter('ativo', '=', '1'));
                $criteriaFormBot->setProperty('order', 'ordem');
            $runBots = $this->dboKs->select('*', $criteriaFormBot);
            while($retBots = $runBots->fetchObject()){

                $action = new TAction($retBots->actionjs);
                $action->setParameter('tipoRetorno', 'lista');
                $action->setParameter('idForm', $this->idForm);
                $action->setParameter('alvo', $this->paneRet);
                $action->setParameter('confirme', $retBots->confirmacao);

                $this->setButton($retBots->botao, $retBots->labelbotao, $action);//.$this->idForm
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
        if($obForm->formainclude == 'one') {


                    //botão padrão [IMPRIMIR]\\
                    $actionPrint = new TAction('printScreen');
                    $actionPrint->setParameter('impressao','impressao');
                    $actionPrint->setParameter('titulo','impLabel');
                    //$this->setButton('imprimir_botform'.$this->idForm, 'Imprimir', $actionPrint);//Cancelada a Ação de Imprimir 


                    if($obForm->botconcluir != '0'){
                        // Botão padrão [Salvar] \\
                        $action1 = new TAction('onSave');
                        $action1->setParameter('idForm', $this->idForm);
                        $action1->setParameter('nomeform', $this->idForm.'-window');
                        $action1->setParameter('tipoRetorno', 'form');
                        $action1->setParameter('alvo', $this->paneRet);
                        //$action1->setParameter('key', $key);
                        //$action1->setParameter('confirme', '');

                        if($obForm->botconcluir == '2' or strpos($obForm->botconcluir, '/2') !== false){
                            $action1->disabled = 1;
                            $obForm->botconcluir = str_replace('/2', '', $obForm->botconcluir);
                        }

                        if($obForm->botconcluir == '1' or $obForm->botconcluir == '2'){
                            $labelBotSalvar = 'Salvar';
                        }else{
                            $labelBotSalvar = $obForm->botconcluir;
                        }

                        $this->setButton('salvar_botform'.$this->idForm, $labelBotSalvar, $action1, 'botaosalvar');//.$this->idForm
                    }

                    //verifica se a exibição atual foi disparada a partir de um botão editar
                    //if(!$this->obsession->getValue('statusFormEdition') and !$this->obsession->getValue('statusViewForm')) {
                    //if($this->headerForm['status'] == "new" and $obForm->botcancelar != '0'){

                        //botão cancelar padrão [Cancelar]
                            $action2 = new TAction('onCancel');
                            $action2->setParameter('tipoRetorno', 'form');
                            $action2->setParameter('idForm', $this->idForm);
                            $action2->setParameter('key', $this->codigo);
                            $action2->setParameter('alvo', $this->paneRet);
                            $action2->setParameter('confirme', 'Deseja realmente cancelar?');

                            if($obForm->botcancelar == '2'){
                                $action2->disabled = 1;
                            }

                        $this->setButton('cancelar_botform'.$this->idForm, 'Cancelar', $action2);
                    //}else{

                        // botão padrão [Fechar] \\
//                            $action2 = new TAction('onCancel');
//                            $action2->setParameter('tipoRetorno', 'form');
//                            $action2->setParameter('idForm', $this->idForm);
//                            $action2->setParameter('key', $this->codigo);
//                            $action2->setParameter('alvo', $this->paneRet);
//                            $action2->setParameter('confirme', 'Você deseja realmente descatar este registro?');
//
//                        $this->setButton('fechar_botform'.$this->idForm, 'Cancelar', $action2);
                    //}

        }
        else {// executado se o formulário não for associado uma lista

                // botão padrão [FECHAR] \\
                $action1 = new TAction('onClose');
                $action1->setParameter('tipoRetorno', 'form');
                $action1->setParameter('idForm', $this->idForm);
                $action1->setParameter('alvo', $this->paneRet);
                $action1->setParameter('confirme', '');
                
                $this->setButton('fechar_botform'.$this->idForm, 'Fechar', $action1);
        }

       return $obAbas;
    }

    /**
    *
    * return <TSetAbas> = retorna um objeto aba
    */
    public function setBloco($idBloco){

        // Dados formulário
        $dboFormBloco = new TKrs('blocos');
            $criteriaFormBloco = new TCriteria();
            $criteriaFormBloco->add(new TFilter('id','=',$idBloco));
        $retFormBloco = $dboFormBloco->select("*", $criteriaFormBloco);
        $obFormBloco = $retFormBloco->fetchObject();

        //instancia o objeto Aba
        $obAbas = new TSetAbas($idBloco, $this->headerForm['titulo']);

           if($obFormBloco->obapendice and $obFormBloco->obapendice != "-" ){

                $obApendice = new TApendices();
                $obElement = $obApendice->main($obFormBloco->obapendice, $this->idForm);

                $form = $obElement;
           }else{

                // configura as propriedade de acesso ao objeto form
                $this->labelForm    = $obFormBloco->nomebloco;
                $this->idNameBloco  = $obFormBloco->blocoid;
                $this->ativo        = $obFormBloco->ativo;

                $this->formBloco = new TCompForm($idBloco, $idBloco, $this->headerForm['tipo'], $this->codigo);
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
    * argumentos de configuração dos bot�es do formulário
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
    	
         $form = $this->setForm($this->idForm);
   
         if($this->bots){
             foreach($this->bots as $idNome=>$act){
                $form->addBotao($idNome, $this->botsLabel[$idNome], $act, $this->botsClass[$idNome]);
             }
         } 

         if($this->dados){

                    // percorre e preenche vetor de campos na sessão ====================================
                    $obHeader = new TSetHeader();
                    $headerForm = $obHeader->getHead($this->idForm);
                    $listaCamposSession = $headerForm['camposSession'];
                    if($listaCamposSession and is_array($listaCamposSession)){
                        foreach($listaCamposSession as $campo=>$infoCampo){
                             $infoCampo['valor']  = $this->dados[$campo];
                             $infoCampo['status'] = 1;
                             $listaCamposSession[$campo] = $infoCampo;
                        }
                        $obHeader->addHeader($this->idForm, 'camposSession', $listaCamposSession);
                    }
                    //===================================================================================

            $form->setData($this->dados);
         }
        $form->setAbas();

        $this->dboKs->close();
        return $form;
    }

}

?>