<?php
/*
* Classe que representa o objeto formulário(form) em blocos de um conjunto de dados
* Versão: v001
* Autor: Wagner Borba
* Data: 22/10/2008
* Data de altualização: --/--/----
*/


class TCompForm {

    /**
     * método __construct()
     * Gera um formulário
     * Autor : Wagner Borba
     * param $formseq = id do formulário em questão
     * param $idPai = id do objeto pai
     * param $tipo = tipo do formulário (form / bloco)
     * param seq = código sequência do registro
     * param mostraid = Modo de desenvolvimento, mostrar id do campo
     */
    public function __construct($formseq, $blocseq, $tipo, $seq) {

        //inicia objeto sesseion
        $this->obsession = new TSession();
        $mostraid = $this->obsession->getValue('developer');
        $this->editable = $this->obsession->getValue(TConstantes::STATUS_VIEWFORM);

        //seqdo formulario em execução
        $this->formseq = $formseq;
        $this->blocseq = $blocseq;
        $this->seq = $seq;
        
            //==================================================================
            //retorna o cabeçalho do formulário
            $this->obHeaderForm = new TSetHeader();
            $this->headerForm   = $this->obHeaderForm->getHead($this->formseq);
            $seqPai             = $this->headerForm['seqPai'];
            $camposFormulario   = $this->headerForm[TConstantes::CAMPOS_FORMULARIO];
            //==================================================================

        //inicia uma transação com a camada de dados do form
        $this->obKDbo = new TKrs();

        $this->obKDbo->setEntidade('campos_x_blocos');
            $criteriaCamposBlocos = new TCriteria();
            $criteriaCamposBlocos->add(new TFilter('blocseq','=',$this->blocseq),'AND');
            $criteriaCamposBlocos->add(new TFilter('mostrarcampo','=','S'), 'AND');
            $criteriaCamposBlocos->setProperty('order', 'ordem');
        $RetIdCampos = $this->obKDbo->select("*", $criteriaCamposBlocos);
   
        $listaTipoCampo = array();
        
        $this->obKDbo->setEntidade('tipo_campo');
        $criteriaTipoCampo = new TCriteria();
        $criteriaTipoCampo->add(new TFilter('statseq','=',1));
        $retTipoCampo = $this->obKDbo->select('tpcadesc,tipodado,seq',$criteriaTipoCampo);
        while($obTipoCampo = $retTipoCampo->fetchObject()){
        	$listaTipoCampo[$obTipoCampo->seq] = $obTipoCampo;
        }

        while($camposId = $RetIdCampos->fetchObject()) {
            $this->obKDbo->setEntidade('campos');
                $criteriaCampos = new TCriteria();
                $criteriaCampos->add(new TFilter('seq','=',$camposId->campseq),'AND');
                $criteriaCampos->add(new TFilter('statseq','=','1'),'AND');
            $RetCampo = $this->obKDbo->select("*", $criteriaCampos);
            $cmp = $RetCampo->fetchObject();
            
            $cmp->tipo = $listaTipoCampo[$cmp->tpcaseq]->tpcadesc;
            
            //retorna tabela de destino do bloco
            $this->obKDbo->setEntidade('tabelas');
                $criteriaTabela = new TCriteria();
                $criteriaTabela->add(new TFilter('seq','=',$cmp->tabseq));
                $criteriaTabela->setProperty('order', 'seq');
            $retTab = $this->obKDbo->select("*", $criteriaTabela);
            $obTabela = $retTab->fetchObject();

            $cmp->label =  $mostraid ? $cmp->label.'-'.$cmp->seq : $cmp->label;
            
            //coloca campo de pesquisa como hiddem
            if($cmp->ativapesquisa){
            	$cmp->tipo = 'THidden';
            	$cmp->tpcaseq = '7';
            }

                //==================================================================
                //compila valor padrão
            if($cmp->valorpadrao != '-'){

                    $valorDefalt = $cmp->valorpadrao;
                    
                    if(strpos($cmp->valorpadrao, "function/") !== false) {
                        $getfunc = explode("/", $cmp->valorpadrao);
                        $obValPadrao = new $getfunc[1]();
                       $valorDefalt = call_user_func(array($obValPadrao,$getfunc[2]));
                    }

                    //converte datas para o padrão internacional
                    $obMascara = new TSetMascaras();
                    $valorDefalt = $obMascara->setData($valorDefalt);
                    
                    $cmp->valorpadrao = $valorDefalt;
                }else{
                	$valorDefalt = null;
                	$cmp->valorpadrao = '';
                }
                //==================================================================

            //verifica se o campo esta ativado
            if($cmp->ativafunction and $obTabela->tabela && $cmp->tipo != 'TButton') {

                //==============================================================
                //testa a existencia de função na permanecia do campo em DB
                if($cmp->incontrol) {
                    $inControl = $cmp->incontrol;
                }

                //==============================================================
                // monta estrutura de campos na sessão
                if($cmp->colunadb && $cmp->colunadb != TConstantes::SEQUENCIAL){
                	
                	$infoCampos[TConstantes::FIELD_SEQUENCIAL]  =$this->seq;
                    $infoCampos[TConstantes::FORM]      		=$this->formseq;
                    $infoCampos[TConstantes::FIELD_COLUMN]     	=$cmp->colunadb;
                    $infoCampos[TConstantes::FIELD_ID]	     	=$cmp->campo;
                    $infoCampos[TConstantes::FIELD_TIPO]		=$listaTipoCampo[$cmp->tpcaseq]->tipodado;
                    $infoCampos[TConstantes::FIELD_LABEL]      	=$cmp->label;
                    $infoCampos[TConstantes::ENTIDADE]    		=$obTabela->tabela;
                    $infoCampos[TConstantes::FIELD_INCONTROL]   =$inControl;
                    $infoCampos[TConstantes::FIELD_NOTNULL] 	=$cmp->required;
                    $infoCampos[TConstantes::FIELD_VALOR]       =$valorDefalt;
                    $infoCampos[TConstantes::FIELD_STATUS]      =0; //0 = não salvo / 1 = salvo
                    
                    $camposFormulario[strtolower($cmp->campo)] 	= $infoCampos;
                }


                //==============================================================
                // monta lista de campos obrigatorios
                if($cmp->required){               
                    if($cmp->label != ""){
                        $cmp->label ='*'.$cmp->label;
                    }
                }

                //identifica o tipo do formulário
                if($tipo == "frm") {
                   $tipoForm = "form";
                }else {
                   $tipoForm = "lista";
                }
                //Define se o campo sera gravando no banco de dados
				if($cmp->colunadb!=TConstantes::SEQUENCIAL){
					$cmp->manter = true;
                }

                $agregFunc = NULL;
                $inControl = NULL;

            }

            //aplica classes do JQuery nos campos ======================
            if($cmp->seletor) {

                $seletores = explode(',', $cmp->seletor);

                foreach($seletores as $seletor) {

                    $idContante = strtoupper($seletor);
                    $sel = constant("TClassJQuery::".$idContante);
                    $cmp->seletorJQ = $cmp->seletorJQ." ".$sel;
                    $cmp->seletorJQ = rtrim($cmp->seletorJQ);
                    $cmp->seletorJQ = ltrim($cmp->seletorJQ);
                }
            }
            //==========================================================

            if($cmp->tipo != 'TBloco' ) {
                $campos[$cmp->campo]  = $cmp;
                $campos[$cmp->campo]->entidade = $obTabela->tabela;
                $campos[$cmp->campo]->props    = $this->getPropriedade($cmp->seq);
            }
            else {
                $blocos[$cmp->campo] =  $cmp;
            }

        }//fim do while
        
        //======================================================================
        //Acrescenta a lista de de campos no cabeçalo do formulário
        if($camposFormulario){
            $this->obHeaderForm->addHeader($this->formseq, TConstantes::CAMPOS_FORMULARIO, $camposFormulario);
        }

        $this->obBloco->campos = $campos;
        $this->obBloco->blocos = $blocos;
        $campos = NULL;
        $blocos = NULL;

    }


    /**
     * Metodo getPropriedade()
     * Retorna todas as propriedades do campo representado no [seq]
     * Autor: Wagner Borba
     * param ID = ID do campo gerando no registro kernelsys
     */
    private function getPropriedade($seq) {

        // instancia a instrução de SELECT
        $this->obKDbo->setEntidade('campos_x_propriedades');
            $criteriaCampoProps = new TCriteria();
            $criteriaCampoProps->add(new TFilter('campseq','=',$seq));
            $criteriaCampoProps->add(new TFilter('statseq','=','1'));
        $Result = $this->obKDbo->select("*", $criteriaCampoProps);

        //Zera vetor de objetos propriedades
        $this->props = null;

        // retorna consulta no banco de propriedades
        while($props = $Result->fetchObject()) {

            // verifica se a propriedade é uma addItems
            if($props->metodo == "addItems") {

                if(strpos($props->valor,"getItens/") !== false) {
                    $obSetModel = new TSetModel();
                    $Itens = $obSetModel->getItensSel($props->valor);
                }
                elseif(strpos($props->valor,"select") !== false or strpos($props->valor,"SELECT") !== false or strpos($props->valor,"show ") !== false or strpos($props->valor,"SHOW ") !== false) {

                        //=====================================================
                        //apresentação do menu dropdown via chave estrageira
                        $dboItens = new TDbo();
                        $QueryItens = $dboItens->sqlExec($props->valor);
                        if($QueryItens){
                            while($ObItens = $QueryItens->fetch()) {

                                if($ObItens[0] != "") {
                                    $Itens[$ObItens[0]] = $ObItens[1];
                                }
                            }
                        }

                }else {
                    
                    $vls = explode(';',$props->valor);

                    foreach($vls as $v) {
                        $pts = explode('=>',$v);
                        $Itens[$pts[0]] = $pts[1];
                    }
                }

                //atribui items ao campo seletor
                $props->valor = $Itens;
                $Itens = NULL;
            }

            $this->props[$props->metodo] = $props;
        }
        return $this->props;
    }

    /**
     * Metodo addValor()
     * Configura atributos de edição dos campos no formulário
     * Autor: Wagner Borba
     * param Array de dados = Vetor com dados de edição do formulário
     */
    public function addValor($dados) {
        $this->dados = $dados;
    }

    /**
     * Metodo addObjetos()
     * Adiciona objetos anexo fora do escopo do bloco
     * Autor: Wagner Borba
     * param Object = Objeto a ser injetado no bloco
     */
    public function addObjetos($obj) {
        if(is_array($obj)) {
            foreach($obj as $c=>$ob) {
                $this->obAnexo[] = $ob;
            }
        }else {

            $this->obAnexo[] = $obj;
        }
    }



    /**
     * Metodo setFields()
     * Retorna o bloco do tipo TSetFields() devidamente configurado
     * Autor: Wagner Borba
     */
    public function setFields() {

        //instancia campos do formulário
        $this->blocoCampos = new TSetfields();

        if(count($this->obBloco->campos) > 0){
            foreach($this->obBloco->campos as $seq=>$dadosCampo){

                //instancia objetos campos
                $setCampo = new TSetCampo();
                $setCampo->setOutControl($dadosCampo->outcontrol);
                $setCampo->setNome($dadosCampo->colunadb);
                $setCampo->setId($dadosCampo->campo);
                $setCampo->setLabel($dadosCampo->label);
                
                $tipoCampo = $setCampo->getTipoCampo($dadosCampo->tpcaseq);
                $setCampo->setTipoDado($tipoCampo->tipodado);
                
                $setCampo->setCampo($seq, $tipoCampo->tpcadesc, $dadosCampo->seletorJQ);
                $setCampo->setPropriedade('alteravel', $dadosCampo->alteravel);
                $setCampo->setValue($dadosCampo->valorpadrao);
                
                 if($dadosCampo->manter == true){
                	$setCampo->setPropriedade('manter', 'true');
                }else{
                	if($dadosCampo->tipo != 'TButton'){
                		$setCampo->setPropriedade('view', 'true');
                	}
                }
                
                // atribui atributo para gravação do objeto [se abilitado]
                 if($this->headerForm[TConstantes::FIELD_STATUS] == 'edit'){
                 	
                 	if($dadosCampo->alteravel == '0'){
                 		
                 		$dadosCampo->ativapesquisa = null;
                 		$setCampo->setPropriedade('manter', 'false');
                 	
                 	
		                if($dadosCampo->tipo === 'TRadio' or $dadosCampo->tipo === 'TRadioGroup'){
		                 	$setCampo->setPropriedade('onClick', 'this.blur(); return false;');
		                }else{
		                 	$setCampo->setPropriedade('readonly', '');
		                 	$setCampo->setPropriedade('onfocus', 'this.blur(); return false;');
		                }  
                 	}
                 }


                    //Aplica mascara nos campos
                    if(!empty($dadosCampo->mascara) and $dadosCampo->mascara != "" and $dadosCampo->tipo != 'TButton') {
                        $setCampo->setPropriedade('onkeypress',"livemask(this,".$dadosCampo->mascara.",this)");
                        $setCampo->setPropriedade('onkeyup',"livemask(this,".$dadosCampo->mascara.",this)");
                    }

                    //atribui uma propriedade seqao botão para ações associadas
                    if($dadosCampo->tipo == 'TButton') {
                        $setCampo->setPropriedade(TConstantes::SEQUENCIAL,$this->seq);
                    }
                    if($dadosCampo->tipo == 'TFrameFile' or $dadosCampo->tipo == 'TVoiceFrameFile' or $dadosCampo->tipo == 'TCsvFrameFile') {
                        $setCampo->setPropriedade(TConstantes::SEQUENCIAL,$this->seq);
                        $setCampo->setPropriedade('form',$this->formseq);
                    }

                    //atribui PROPRIEDADE DOS CAMPOS
                    if(is_array($dadosCampo->props)) {
                        foreach($dadosCampo->props as $nProp=>$ObProps) {
                            //--- Adiciona propriedades aos campos usando a classe TSetFields
                           $setCampo->setPropriedade($ObProps->metodo, $ObProps->valor);
                        }
                    }

                // Injeta campo no conteiner TSetFields
                $obCampo = $setCampo->getCampo();
                $this->blocoCampos->addCampo($dadosCampo->label, $obCampo, $dadosCampo->ativapesquisa);

                //borbulha mensagem [help] para o metodo responsavel
                if($dadosCampo->help) {
                    $this->blocoCampos->setHelp($seq, $dadosCampo->help);
                }

                //configura trigger onload no campo
                if($dadosCampo->trigger) {
                    $this->blocoCampos->addTrigger($seq, $dadosCampo->trigger);
                }

            }//foreach principal
        }

        //compila objtos anexos
        if($this->obAnexo) {
            foreach($this->obAnexo as $obAn) {
                $this->blocoCampos->addObjeto($obAn);
            }
        }

        $panel = new TElement('div');
        $panel->id = 'contFields'.$this->blocseq;
        $panel->add($this->blocoCampos->getConteiner());

        //============================================================================================
        // compila campo tipo TBloco (listagem aninhada)
        //============================================================================================
        if($this->obBloco->blocos) {
            foreach($this->obBloco->blocos as $bl) {

                $panelLista = new TElement('div');
                $panelLista->id = TConstantes::CONTEINER_LISTA.$bl->campo;
                $panelLista->style = 'border:1px solid #999999; padding:4px;';

                $nbloco = new TCompLista($bl->campo, TConstantes::CONTEINER_LISTA.$bl->campo);
                $lb = $nbloco->get();

                //$listDados = $listObj->getListDados();
                $panelLista->add($lb->getLista());

                $panel->add($panelLista);
            }
        }

        $this->obKDbo->close();

        return $panel;    
    }
    
    /**
     * Metodo getCamp()
     * Retorna um vetor com todos os campos (servirá de paramentro para TForm)
     * Autor: Wagner Borba
     */
    public function getCamp() {

        $campos = $this->blocoCampos->getCampos();
        return $campos;
    }


}