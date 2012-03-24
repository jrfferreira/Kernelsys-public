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
     * param $idForm = id do formulário em questão
     * param $idPai = id do objeto pai
     * param $tipo = tipo do formulário (form / bloco)
     * param Codigo = código id do registro caso o formulário seja secundário
     * param mostraid = Modo de desenvolvimento, mostrar id do campo
     */
    public function __construct($idForm, $idBloco, $tipo, $codigo) {

        //inicia objeto sesseion
        $this->obsession = new TSession();
        $mostraid = $this->obsession->getValue('developer');
        $this->editable = $this->obsession->getValue('statusViewForm');

        //codigo do formulario em execução
        $this->idForm = $idForm;
        $this->idBloco = $idBloco;
        $this->codigo = $codigo;
        
            //==================================================================
            //retorna o cabeçalho do formulário
            $this->obHeaderForm = new TSetHeader();
            $this->headerForm = $this->obHeaderForm->getHead($this->idForm);
            $codigoPai          = $this->headerForm['codigoPai'];
            $camposSession      = $this->headerForm['camposSession'];
            //==================================================================

        //inicia uma transação com a camada de dados do form
        $this->obKDbo = new TKrs();

        $this->obKDbo->setEntidade('campos_x_blocos');
            $criteriaCamposBlocos = new TCriteria();
            $criteriaCamposBlocos->add(new TFilter('blocoid','=',$this->idBloco),'AND');
            $criteriaCamposBlocos->add(new TFilter('mostrarcampo','=','S'), 'AND');
            $criteriaCamposBlocos->setProperty('order', 'ordem');
        $RetIdCampos = $this->obKDbo->select("*", $criteriaCamposBlocos);

        while($camposId = $RetIdCampos->fetchObject()) {
            $this->obKDbo->setEntidade('campos');
                $criteriaCampos = new TCriteria();
                $criteriaCampos->add(new TFilter('id','=',$camposId->campoid),'AND');
                $criteriaCampos->add(new TFilter('ativo','=','1'),'AND');
            $RetCampo = $this->obKDbo->select("*", $criteriaCampos);
            $cmp = $RetCampo->fetchObject();

            //Verifica tabela de destino do bloco
            $this->obKDbo->setEntidade('tabelas');
                $criteriaTabela = new TCriteria();
                $criteriaTabela->add(new TFilter('id','=',$cmp->entidade));
                $criteriaTabela->setProperty('order', 'id');
            $retTab = $this->obKDbo->select("*", $criteriaTabela);
            $obTabela = $retTab->fetchObject();

            $cmp->label =  $mostraid ? $cmp->label.'-'.$cmp->id : $cmp->label;

            //verifica se o campo esta ativado
            if($cmp->ativafunction and $obTabela->tabela != "" and $cmp->tipo != 'TButton' and !$this->editable) {

                //==============================================================
                //testa a existencia de função na permanecia do campo em DB
                if($cmp->incontrol) {
                    $inControl = $cmp->incontrol;
                }

                //==============================================================
                // monta estrutura de campos na sessão
                if($cmp->colunadb and $cmp->entidade != "0"){
                    $infoCampos['idForm']      = $this->idForm;
                    $infoCampos['label']       = $cmp->label;
                    $infoCampos['entidade']    = $obTabela->tabela;
                    $infoCampos['codigo']      = $this->codigo;
                    $infoCampos['incontrol']   = $inControl;
                    $infoCampos['tipoform']    = $tipoForm;
                    $infoCampos['obrigatorio'] = $cmp->valornull;
                    $infoCampos['valor']       = '';
                    $infoCampos['status']      = 0; //0 = não salvo / 1 = salvo
                    $camposSession[strtolower($cmp->colunadb)] = $infoCampos;
                }


                //==============================================================
                // monta lista de campos obrigatorios
                if($cmp->valornull){               
                    if($cmp->label != ""){
                        $cmp->label ='*'.$cmp->label;
                    }
                }

                $cmp->codigoregistro = $this->codigo;
                if($tipo == "frm") {
                   $tipoForm = "form";
                }else {
                   $tipoForm = "lista";
                }
                $cmp->funct = "pross(this,'".$this->idForm."','".$this->codigo."')";

                if($cmp->autosave){
                    $cmp->funct .= "; onSave('".$this->idForm."', false)";
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
                $campos[$cmp->campo]           = $cmp;
                $campos[$cmp->campo]->entidade = $obTabela->tabela;
                $campos[$cmp->campo]->props    = $this->getPropriedade($cmp->id);
            }
            else {
                $blocos[$cmp->campo] =  $cmp;
            }

        }//fim do while

        //======================================================================
        //Acrescenta a lista de de campos no cabeçalo do formulário
        if($camposSession){
            $this->obHeaderForm->addHeader($this->idForm, 'camposSession', $camposSession);
        }

        $this->obBloco->campos = $campos;
        $this->obBloco->blocos = $blocos;
        $campos = NULL;
        $blocos = NULL;

    }


    /**
     * Metodo getPropriedade()
     * Retorna todas as propriedades do campo representado no [id]
     * Autor: recebe codigo do objeto pai
     * param ID = ID do campo gerando no registro kernelsys
     */
    private function getPropriedade($id) {

        // instancia a instrução de SELECT
        $this->obKDbo->setEntidade('campos_x_propriedades');
            $criteriaCampoProps = new TCriteria();
            $criteriaCampoProps->add(new TFilter('campoid','=',$id));
            $criteriaCampoProps->add(new TFilter('ativo','=','1'));
        $Result = $this->obKDbo->select("*", $criteriaCampoProps);

        //Zera vetor de objetos propriedades
        $this->props = array();

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
            foreach($this->obBloco->campos as $key=>$dadosCampo){

                //valida campos alteraveis
                if($this->headerForm['status'] == 'edit'){
                    if($dadosCampo->alteravel == '2'){
                        $dadosCampo->funct = null;
                        $dadosCampo->ativapesquisa = null;
                    }
                }

                //instancia objetos campos
                $setCampo = new TSetCampo();
                $setCampo->setOutControl($dadosCampo->outcontrol);
                $setCampo->setNome($dadosCampo->colunadb);
                $setCampo->setLabel($dadosCampo->label);
                    // atribui function de gravação do objeto [se abilitado]
                    //if(empty($dadosCampo->funct)){
                        $setCampo->setAction('onblur', $dadosCampo->funct);
                        //$setCampo->setAction('onchange','$(this).blur()');
                    //}
                $setCampo->setCampo($key, $dadosCampo->tipo, $dadosCampo->seletorJQ);
                $setCampo->setPropriedade('alteravel', $dadosCampo->alteravel);

                    // verifica se o campo pode ser editado e atribui a propriedade somente leitura
                    if($this->editable){
                       $setCampo->setPropriedade('readonly','true');
                    }

                    //Aplica mascara nos campos
                    if(!empty($dadosCampo->mascara) and $dadosCampo->mascara != "" and $dadosCampo->tipo != 'TButton') {
                        $setCampo->setPropriedade('onkeypress',"livemask(this,".$dadosCampo->mascara.",this)");
                        $setCampo->setPropriedade('onkeyup',"livemask(this,".$dadosCampo->mascara.",this)");
                    }

                    //atribui uma propriedade codigo ao botão para ações associadas
                    if($dadosCampo->tipo == 'TButton') {
                        $setCampo->setPropriedade('codigo',$this->codigo);
                    }
                    if($dadosCampo->tipo == 'TFrameFile' or $dadosCampo->tipo == 'TVoiceFrameFile' or $dadosCampo->tipo == 'TCsvFrameFile') {
                        $setCampo->setPropriedade('codigo',$this->codigo);
                        $setCampo->setPropriedade('form',$this->idForm);
                    }

                    //atribui PROPRIEDADE DOS CAMPOS
                    if(is_array($dadosCampo->props)) {
                        foreach($dadosCampo->props as $nProp=>$ObProps) {
                            //--- Adiciona propriedades aos campos usando a classe TSetFields
                           $setCampo->setPropriedade($ObProps->metodo, $ObProps->valor);
                        }
                    }

                // Injeta campo no conteinar TSetFields
                $obCampo = $setCampo->getCampo();
                $this->blocoCampos->addCampo($dadosCampo->label, $obCampo, $dadosCampo->ativapesquisa);

                //borbulha mensagem [help] para o metodo responsavel
                if($dadosCampo->help) {
                    $this->blocoCampos->setHelp($key, $dadosCampo->help);
                }

                //configura trigger onload no campo
                if($dadosCampo->trigger) {
                    $this->blocoCampos->addTrigger($key, $dadosCampo->trigger);
                }

                //==================================================================
                //compila valor padrão
                if($dadosCampo->valorpadrao != "-"){

                    $vDefalt = $dadosCampo->valorpadrao;
                    if(strpos($dadosCampo->valorpadrao, "function/") !== false) {
                        $getfunc = explode("/", $dadosCampo->valorpadrao);
                        $obValPadrao = new $getfunc[1]();
                        $vDefalt = call_user_func(array($obValPadrao,$getfunc[2]));
                    }

                    //armazena valor padrão em base de dados atravez dos paramentos do campo
                    if(!empty($dadosCampo->entidade)){
	                    $dboVPad = new TDbo($dadosCampo->entidade);
	                    $cretiriaVpad = new TCriteria();
	                    $cretiriaVpad->add(new TFilter('codigo','=',$dadosCampo->codigoregistro));
	                    $cretiriaVpad->add(new TFilter($dadosCampo->colunadb,'is','null'));
	                    $dboVPad->update(array($dadosCampo->colunadb=>$vDefalt), $cretiriaVpad);
                    }

                    //converte datas para o padrão internacional
                    $obMascara = new TSetMascaras();
                    $vDefalt = $obMascara->setData($vDefalt);
                }
                //==================================================================

            }//foreach principal
        }

        //compila objtos anexos
        if($this->obAnexo) {
            foreach($this->obAnexo as $obAn) {
                $this->blocoCampos->addObjeto($obAn);
            }
        }

        $panel = new TElement('div');
        $panel->id = 'contFields'.$this->idBloco;
        $panel->add($this->blocoCampos->getConteiner());

        //============================================================================================
        // compila campo tipo TBloco (listagem aninhada)
        //============================================================================================
        if($this->obBloco->blocos) {
            foreach($this->obBloco->blocos as $bl) {

                $panelLista = new TElement('div');
                $panelLista->id = 'contLista'.$bl->campo;
                $panelLista->style = 'border:1px solid #999999; padding:4px;';

                $nbloco = new TCompLista($bl->campo, 'contLista'.$bl->campo);
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