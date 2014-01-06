<?php

class TPrivilegios {
	
	/**
	 * 
	 * @param unknown_type $seq
	 */
    public function getModulos($seq = null) {

        $TDbo_modulos = new TKrs('modulo');
        $crit = new TCriteria();
        $crit->add(new TFilter('statseq','=','1', 'numeric'));
        $crit->getProperty("order by labelmodulo");
        if($seq) {
            $crit->add(new TFilter("seq","=",$seq));
        }

        $retModulos = $TDbo_modulos->select("*",$crit);
        while($obModulos = $retModulos->fetchObject()) {
            $ob[$obModulos->seq] = $obModulos;
        }
        return $ob;
    }
	
    /**
     * 
     * @param $usuaseq
     */
    public function viewGetModulos($usuaseq) {
    	
        if($usuaseq) {
        	
            $TUsuario = new TUsuario();
            $obUsuario = $TUsuario->getPrivilegios($usuaseq);
            $obModulos = $this->getModulos();

            $this->ob = new TElement("div");
            foreach ($obModulos as $ch=>$vl) {
                $fieldSet = new TElement("fieldset");
                $fieldSet->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                $fieldSetLegenda = new TElement("legend");
                $fieldSetLegenda->class = "ui-widget-content ui-corner-all";

                $campoReq = new TCheckButton("modulo-".$ch);
                $campoReq->setValue("1");
                $campoReq->setId('00'.$ch);
                $campoReq->setProperty('onclick','setPrivilegio(this, \''.$usuaseq.'\',\'0\',\'0\',\''.$ch.'\')');

                $div = new TElement("div");
                $div->id = '0-0'.$ch;
                $div->style="padding-left: 15px; padding-top: 5px; padding-bottom: 5px;";
                $div->class="ui_bloco_conteudo";

                if($obUsuario["0"]["0"][$ch]["1"]) {
                    //$retMenuChecked = $this->viewGetMenu($usuaseq, $ch);
                    //$div->add($retMenuChecked);
                    $campoReq->checked = "checked";
                    $campoReqSituacao = "1";
                }else {
                    $campoReqSituacao = "0";
                    $div->add("");
                }
                $fieldSetLegenda->add($campoReq);
                $fieldSetLegenda->add(" <span class='ui_bloco_legendas' onclick=\"getOpcoesPrivilegios('".$usuaseq."','0','0','".$ch."','".$campoReqSituacao."')\">".$vl->labelmodulo."</span>");
                $fieldSet->add($fieldSetLegenda);
                $fieldSet->add($div);

                $this->ob->add($fieldSet);
            }
                $ch = '0';
                $fieldSet = new TElement("fieldset");
                $fieldSet->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                $fieldSetLegenda = new TElement("legend");
                $fieldSetLegenda->class = "ui-widget-content ui-corner-all";

                $campoReq = new TCheckButton("modulo-".$ch);
                $campoReq->setValue("1");
                $campoReq->setId('00'.$ch);
                $campoReq->setProperty('onclick','setPrivilegio(this, \''.$usuaseq.'\',\'0\',\'0\',\''.$ch.'\')');

                $div = new TElement("div");
                $div->id = '0-0'.$ch;
                $div->style="padding-left: 15px; padding-top: 5px; padding-bottom: 5px;";
                $div->class="ui_bloco_conteudo";

                    $campoReqSituacao = "0";
                    $div->add("");
                $fieldSetLegenda->add($campoReq);
                $fieldSetLegenda->add(" <span class='ui_bloco_legendas' onclick=\"getOpcoesPrivilegios('".$usuaseq."','0','0','".$ch."','".$campoReqSituacao."')\">Outros</span>");
                $fieldSet->add($fieldSetLegenda);
                $fieldSet->add($div);

                $this->ob->add($fieldSet);


            return $this->ob;

        }
    }
	
    /**
     * 
     * @param $modulo
     */
    public function getMenu($modulo = null) {
        $TDbo_menus = new TKrs('menu');

        $crit = new TCriteria();
        //$crit->add(new TFilter("modulo","=",$modulo));
        $crit->add(new TFilter("labelmodulo","!=",""));
        $crit->add(new TFilter("statseq","=",1, 'numeric'));
        if($modulo) {
            $crit->add(new TFilter("modseq","=",$modulo));
        }

        $retMenus = $TDbo_menus->select("*",$crit);

        while($obMenus = $retMenus->fetchObject()) {
            $ob[$obMenus->seq] = $obMenus;
        }
        return $ob;
    }
	
    /**
     * 
     * @param $usuaseq
     * @param $funcionalidade
     */
    public function viewGetMenu($usuaseq,$funcionalidade) {

            $TUsuario = new TUsuario();
            $obUsuario = $TUsuario->getPrivilegios($usuaseq);
        if($funcionalidade != '0') {

            $obMenus = $this->getMenu($funcionalidade);
            $obMenu = new TElement("div");
            foreach ($obMenus as $ch=>$vl) {
                $fieldSetMenu = new TElement("div");

                $campoReqMenu = new TCheckButton("menus-".$ch);
                $campoReqMenu->setValue("1");
                $campoReqMenu->setId('1'.$funcionalidade.$ch);
                $campoReqMenu->setProperty('onclick','setPrivilegio(this, \''.$usuaseq.'\',\'1\',\''.$funcionalidade.'\',\''.$ch.'\')');

                $divMenu = new TElement("div");
                $divMenu->id = '1-'.$funcionalidade.$ch;
                $divMenu->style="padding-left: 15px; padding-top: 5px; padding-bottom: 5px;";

                if($obUsuario["1"][$funcionalidade][$ch]["1"]) {
                    $retOpcoesListaChecked = $this->viewGetOpcoesLista($usuaseq, $ch);
                    $divMenu->add($retOpcoesListaChecked);
                    $campoReqMenu->checked = "checked";
                }else {
                    $divMenu->add("");
                }

                $divMenu2 = new TElement("div");
                $divMenu2->id = '4-'.$funcionalidade.$ch;
                $divMenu2->style="padding-left: 15px; padding-top: 5px; padding-bottom: 5px;";
                $abas = $this->viewGetFormAbas($usuaseq,$vl->formseq);
                $divMenu2->add($abas);
                

                $fieldSetMenu->add($campoReqMenu);
                $fieldSetMenu->add($vl->labelmodulo);

                $fieldSetMenu->add($divMenu);
                $fieldSetMenu->add($divMenu2);
                $obMenu->add($fieldSetMenu);
            }
        }else{

            $dbo = new TKrs('forms');
            $crit = new TCriteria();
            $crit->add(new TFilter(TConstantes::LISTA,'=','0'),'AND');
           // $crit->setProperty('not exists','(select form from menu where menu.form = forms.seq)');
            $retDbo = $dbo->select('*',$crit);

            $obMenu = new TElement("div");
            while($obDbo = $retDbo->fetchObject()) {
                $fieldSetMenu = new TElement("div");

                $divMenu = new TElement("div");
                $divMenu->id = '4-'.$funcionalidade.$ch;
                $divMenu->style="padding-left: 15px; padding-top: 5px; padding-bottom: 5px;";
                $abas = $this->viewGetFormAbas($usuaseq,$obDbo->seq);
                $divMenu->add($abas);

                $fieldSetMenu->add("<b>Formulário:</b> {$obDbo->nomeform}");

                $fieldSetMenu->add($divMenu);
                $obMenu->add($fieldSetMenu);
            }
        }

            return $obMenu;

    }
	
    /**
     * 
     * @param unknown_type $lista_id
     */
    public function getOpcoesLista($lista_id) {

        $TDbo_Lista = new TKrs('lista');
        $crit = new TCriteria();
        	$crit->add(new TFilter("seq","=",$lista_id, 'numeric'));
        $retLista = $TDbo_Lista->select("*",$crit);

        $obLista = $retLista->fetchObject();

        return $obLista;
    }
	
    /**
     * 
     * @param unknown_type $usuaseq
     * @param unknown_type $funcionalidade
     */
    public function viewGetOpcoesLista($usuaseq,$funcionalidade) {
        if($funcionalidade) {
            
        $TDbo_menus = new TKrs('menu');
        $crit = new TCriteria();
       	 $crit->add(new TFilter("seq","=",$funcionalidade, 'numeric'));
        $retMenus = $TDbo_menus->select("*",$crit);
        $obMenu = $retMenus->fetchObject();
            $obOpcoesLista = $this->getOpcoesLista($obMenu->argumento);
            $TUsuario = new TUsuario();
            $obUsuario = $TUsuario->getPrivilegios($usuaseq);

            $obLista = new TElement("fieldset");
            $obLista->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
            $obLista->style="padding-left: 15px; padding-top: 5px; padding-bottom: 5px;";

                $fieldSetLegenda = new TElement("legend");
                $fieldSetLegenda->class = "ui-widget-content ui-corner-all";
                $fieldSetLegenda->add('<strong>Lista:</strong> '.$obOpcoesLista->label);
            $obLista->add($fieldSetLegenda);
            $checklistoptions = false;

            if($obOpcoesLista->acincluir != false) {

                $fieldSetOpcoesLista = new TElement("div");

                $campoReqMenu = new TCheckButton("opcoesLista-1");
                $campoReqMenu->setValue("1");
                $campoReqMenu->setId("2".$obOpcoesLista->formseq."1");
                $campoReqMenu->setProperty('onclick','setPrivilegio(this, \''.$usuaseq.'\',\'2\',\''.$obOpcoesLista->formseq.'\',\'1\')');

                if($obUsuario["2"][$obOpcoesLista->formseq]['1']["1"]) {
                    $checklistoptions = true;
                    $campoReqMenu->checked = "checked";
                }
                $fieldSetOpcoesLista->add($campoReqMenu);
                $fieldSetOpcoesLista->add("Incluir registros");

                $obLista->add($fieldSetOpcoesLista);

            }
            if($obOpcoesLista->aceditar != false) {

                $fieldSetOpcoesLista = new TElement("div");

                $campoReqMenu = new TCheckButton("opcoesLista-2");
                $campoReqMenu->setValue("1");
                $campoReqMenu->setId("2".$obOpcoesLista->formseq."2");
                $campoReqMenu->setProperty('onclick','setPrivilegio(this, \''.$usuaseq.'\',\'2\',\''.$obOpcoesLista->formseq.'\',\'2\')');

                if($obUsuario["2"][$obOpcoesLista->formseq]['2']["1"]) {
                    $checklistoptions = true;
                    $campoReqMenu->checked = "checked";
                }
                $fieldSetOpcoesLista->add($campoReqMenu);
                $fieldSetOpcoesLista->add("Editar registros");

                $obLista->add($fieldSetOpcoesLista);

            }
            if($obOpcoesLista->acdeletar != false) {

                $fieldSetOpcoesLista = new TElement("div");

                $campoReqMenu = new TCheckButton("opcoesLista-3");
                $campoReqMenu->setValue("1");
                $campoReqMenu->setId("2".$obOpcoesLista->formseq."3");
                $campoReqMenu->setProperty('onclick','setPrivilegio(this, \''.$usuaseq.'\',\'2\',\''.$obOpcoesLista->formseq.'\',\'3\')');

                if($obUsuario["2"][$obOpcoesLista->formseq]["3"]["1"]) {
                    $checklistoptions = true;
                    $campoReqMenu->checked = "checked";
                }
                $fieldSetOpcoesLista->add($campoReqMenu);
                $fieldSetOpcoesLista->add("Apagar registros");

                $obLista->add($fieldSetOpcoesLista);

            }

            if($obOpcoesLista->acreplicar != false) {

                $fieldSetOpcoesLista = new TElement("div");

                $campoReqMenu = new TCheckButton("opcoesLista-4");
                $campoReqMenu->setValue("1");
                $campoReqMenu->setId("2".$obOpcoesLista->formseq."4");
                $campoReqMenu->setProperty('onclick','setPrivilegio(this, \''.$usuaseq.'\',\'2\',\''.$obOpcoesLista->formseq.'\',\'4\')');

                if($obUsuario["2"][$obOpcoesLista->formseq]["4"]["1"]) {
                    $checklistoptions = true;
                    $campoReqMenu->checked = "checked";
                }
                $fieldSetOpcoesLista->add($campoReqMenu);
                $fieldSetOpcoesLista->add("Replicar registros");

                $obLista->add($fieldSetOpcoesLista);

            }

            if($obOpcoesLista->acselecao != false) {

                $fieldSetOpcoesLista = new TElement("div");

                $campoReqMenu = new TCheckButton("opcoesLista-5");
                $campoReqMenu->setValue("1");
                $campoReqMenu->setId("2".$obOpcoesLista->formseq."5");
                $campoReqMenu->setProperty('onclick','setPrivilegio(this, \''.$usuaseq.'\',\'2\',\''.$obOpcoesLista->formseq.'\',\'5\')');

                if($obUsuario["2"][$obOpcoesLista->formseq]["5"]["1"]) {
                    $checklistoptions = true;
                    $campoReqMenu->checked = "checked";
                }
                $fieldSetOpcoesLista->add($campoReqMenu);
                $fieldSetOpcoesLista->add("Multipla Seleção de registros");

                $obLista->add($fieldSetOpcoesLista);

            }

            $divMenu = new TElement("div");
            $divMenu->id = '2-123';
            $divMenu->style="padding-left: 15px; padding-top: 5px; padding-bottom: 5px;";

            $colunas = $this->viewGetColunasLista($usuaseq,$obOpcoesLista->seq);
            //$abas    = $this->viewGetFormAbas($usuaseq,$obOpcoesLista->formseq);
            $divMenu->add($colunas);
            //$divMenu->add($abas);
            $obLista->add($divMenu);

            return $obLista;

        }
    }
    
	/**
	 * 
	 * @param unknown_type $id_lista
	 */
    public function getColunasLista($id_lista) {
        $TDbo_menus = new TKrs('lista');
        $crit = new TCriteria();
        $crit->add(new TFilter("seq","=",$id_lista));
        $retMenus = $TDbo_menus->select("*",$crit);

        while($obMenus = $retMenus->fetchObject()) {
            $ob[$obMenus->seq] = $obMenus;

            $TDbo_colunas = new TKrs('coluna');
            $critCols = new TCriteria();
            $critCols->add(new TFilter("listseq","=",$obMenus->seq));
            $retColunas = $TDbo_colunas->select("*",$critCols);
            while($obCols = $retColunas->fetchObject()) {
                $ob[$obMenus->seq]->colunas[$obCols->seq] = $obCols;
            }
        }
        return $ob;
    }
	
    /**
     * 
     * @param $usuaseq
     * @param $funcionalidade
     */
    public function viewGetColunasLista($usuaseq,$funcionalidade) {

        if($funcionalidade) {
            $obColunas = $this->getColunasLista($funcionalidade);
            $TUsuario = new TUsuario();
            $obUsuario = $TUsuario->getPrivilegios($usuaseq);

            $obMenu = new TElement("div");
            $obMenu->style = "padding-top: 5px; padding-bottom: 5px;";
            $obMenu->add("<b>Visualizar Colunas:</b> <br/><br/>");
            foreach ($obColunas as $ch=>$vl) {
                foreach ($vl->colunas as $ch2=>$col) {
                    $fieldSetMenu = new TElement("div");

                    $campoReqMenu = new TCheckButton("colunas-".$ch);
                    $campoReqMenu->setValue("1");
                    $campoReqMenu->setId('3'.$funcionalidade.$ch2);
                    $campoReqMenu->setProperty('onclick','setPrivilegio(this, \''.$usuaseq.'\',\'3\',\''.$funcionalidade.'\',\''.$ch2.'\')');

                    $divMenu = new TElement("div");
                    $divMenu->id = '3-'.$funcionalidade.$ch;
                    $divMenu->style="padding-left: 15px; padding-top: 5px; padding-bottom: 5px;";

                    if($obUsuario["3"][$funcionalidade][$ch2]["1"]) {
                        $divMenu->add("");
                        $campoReqMenu->checked = "checked";
                    }else {
                        $divMenu->add("");
                    }

                    $fieldSetMenu->add($campoReqMenu);
                    $fieldSetMenu->add($col->label);

                    $fieldSetMenu->add($divMenu);

                    $obMenu->add($fieldSetMenu);
                }
            }
            return null;//return $obMenu;

        }
    }

    /**
     * 
     * @param unknown_type $formseq
     */
    public function getFormAbas($formseq){
    	
        $TDbo_menus = new TKrs('form_x_abas');
	        $crit = new TCriteria();
	        $crit->add(new TFilter("formseq","=",$formseq));
	        $crit->add(new TFilter("statseq","=",'1'));
	        $crit->setProperty('order', 'ordem');
        $retMenus = $TDbo_menus->select("abaseq",$crit);

        while($obMenus = $retMenus->fetchObject()) {
            $TDbo_colunas = new TKrs('abas');
            $critCols = new TCriteria();
            $critCols->add(new TFilter("seq","=",$obMenus->abaseq));
            $retColunas = $TDbo_colunas->select("*",$critCols);
            while($obCols = $retColunas->fetchObject()) {
                $ob[$obMenus->abaseq] = $obCols;
            }
        }
        return $ob;
    }

    /**
     * 
     * @param unknown_type $aba_id
     */
    public function getAbaBlocos($abaseq){
    	
        $TDbo_menus = new TKrs('blocos_x_abas');
	        $crit = new TCriteria();
	        $crit->add(new TFilter("abaseq","=",$abaseq));
	        $crit->setProperty('order', 'ordem');
        $retMenus = $TDbo_menus->select("blocseq",$crit);

        while($obMenus = $retMenus->fetchObject()) {
            $TDbo_colunas = new TKrs('blocos');
            $critCols = new TCriteria();
            $critCols->add(new TFilter("seq","=",$obMenus->blocseq));
            $retColunas = $TDbo_colunas->select("*",$critCols);
            while($obCols = $retColunas->fetchObject()) {
                $ob[$obMenus->blocseq] = $obCols;
            }
        }                                                                                    
        return $ob;
    }

    /**
     * 
     * @param $bloco_id
     */
     public function getBlocosCampos($blocseq){
     	
        $TDbo_menus = new TKrs('campos_x_blocos');
	        $crit = new TCriteria();
	        $crit->add(new TFilter("blocseq","=",$blocseq));
	        $crit->add(new TFilter("mostrarcampo","=","S"));
	        $crit->setProperty('order', 'ordem');
        $retMenus = $TDbo_menus->select("campseq",$crit);

        while($obMenus = $retMenus->fetchObject()) {
            $TDbo_colunas = new TKrs('campos');
            $critCols = new TCriteria();
            $critCols->add(new TFilter("seq","=",$obMenus->campseq));
            $retColunas = $TDbo_colunas->select("*",$critCols);
            while($obCols = $retColunas->fetchObject()) {
                $ob[$obMenus->campseq] = $obCols;
            }
        }
        return $ob;
    }

    /**
     * 
     * @param $campo_id
     */
    public function getCampoEdicao($campo_id){
            $TDbo_colunas = new TKrs('campos');
            $critCols = new TCriteria();
            $critCols->add(new TFilter("seq","=",$campo_id));
            $retColunas = $TDbo_colunas->select("*",$critCols);
            $ob = $retColunas->fetchObject();

        return $ob;
    }
	
    /**
     * 
     * @param $usuaseq
     * @param $funcionalidade
     */
    public function viewGetFormAbas($usuaseq,$funcionalidade){
        if($funcionalidade) {
            $obAbas = $this->getFormAbas($funcionalidade);
            $TUsuario = new TUsuario();
            $obUsuario = $TUsuario->getPrivilegios($usuaseq);

           // $obMenu = new TElement("div");
           // $obMenu->style = "padding-top: 5px; padding-bottom: 5px;";
           // $obMenu->add();
            
            
            $obMenu = new TElement("fieldset");
            $obMenu->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
            $obMenu->style="padding-left: 15px; padding-top: 5px; padding-bottom: 5px;";

                $fieldSetLegenda = new TElement("legend");
                $fieldSetLegenda->class = "ui-widget-content ui-corner-all";
                $fieldSetLegenda->add("<b>Abas:</b>");
            $obMenu->add($fieldSetLegenda);

            if($obAbas){
            foreach ($obAbas as $ch=>$vl) {
                    $fieldSetMenu = new TElement("div");

                    $campoReqMenu = new TCheckButton("abas-".$ch);
                    $campoReqMenu->setValue("1");
                    $campoReqMenu->setId('5'.$funcionalidade.$ch);
                    $campoReqMenu->setProperty('onclick','setPrivilegio(this, \''.$usuaseq.'\',\'5\',\''.$funcionalidade.'\',\''.$ch.'\')');

                    $divMenu = new TElement("div");
                    $divMenu->id = '5-'.$funcionalidade.$ch;
                    $divMenu->style="padding-left: 15px; padding-top: 5px; padding-bottom: 5px;";

                    if($obUsuario["5"][$funcionalidade][$ch]["1"]) {
                        $blocos = $this->viewGetAbasBlocos($usuaseq,$ch);
                        $divMenu->add($blocos);
                        $campoReqMenu->checked = "checked";
                    }else {
                        $divMenu->add("");
                    }

                    $fieldSetMenu->add($campoReqMenu);
                    $fieldSetMenu->add($vl->nomeaba . '(seq: '.$ch.')');

                    $fieldSetMenu->add($divMenu);

                    $obMenu->add($fieldSetMenu);
            }
            }
            return $obMenu;

        }
    }
	
    /**
     * 
     * @param $usuaseq
     * @param $funcionalidade
     */
    public function viewGetAbasBlocos($usuaseq,$funcionalidade){
        if($funcionalidade) {
            $obBlocos= $this->getAbaBlocos($funcionalidade);
            $TUsuario = new TUsuario();
            $obUsuario = $TUsuario->getPrivilegios($usuaseq);

            $obMenu = new TElement("div");
            $obMenu->style = "padding-top: 5px; padding-bottom: 5px;";
            $obMenu->add("<b>Blocos:</b><br/><br/>");
            if($obBlocos){
            foreach ($obBlocos as $ch=>$vl) {
                    $fieldSetMenu = new TElement("div");

                    $campoReqMenu = new TCheckButton("blocos-".$ch);
                    $campoReqMenu->setValue("1");
                    $campoReqMenu->setId('6'.$funcionalidade.$ch);
                    $campoReqMenu->setProperty('onclick','setPrivilegio(this, \''.$usuaseq.'\',\'6\',\''.$funcionalidade.'\',\''.$ch.'\')');

                    $divMenu = new TElement("div");
                    $divMenu->id = '6-'.$funcionalidade.$ch;
                    $divMenu->style="padding-left: 15px; padding-top: 5px; padding-bottom: 5px;";

                    if($obUsuario["6"][$funcionalidade][$ch]["1"]) {
                        $campos = $this->viewGetBlocosCampos($usuaseq,$ch);
                        $divMenu->add($campos);
                        $campoReqMenu->checked = "checked";
                    }else {
                        $divMenu->add("");
                    }

                    $fieldSetMenu->add($campoReqMenu);
                    $fieldSetMenu->add($vl->nomebloco . " (seq: {$ch})");

                    $fieldSetMenu->add($divMenu);

                    $obMenu->add($fieldSetMenu);
            }
            }
            return $obMenu;

        }
    }
	
    /**
     * 
     * @param unknown_type $usuaseq
     * @param unknown_type $funcionalidade
     */
    public function viewGetBlocosCampos($usuaseq,$funcionalidade){
        if($funcionalidade) {
            $TDbo_colunas = new TKrs('blocos');
            $critCols = new TCriteria();
            $critCols->add(new TFilter("seq","=",$funcionalidade));
            $retColunas = $TDbo_colunas->select("*",$critCols);
            $obBloco = $retColunas->fetchObject();
            
            $TUsuario = new TUsuario();
            $obUsuario = $TUsuario->getPrivilegios($usuaseq);


            $obMenu = new TElement("div");
            $obMenu->style = "padding-top: 5px; padding-bottom: 5px;";
            if($obBloco->formato == 'frm'){
                
            $obMenu->add("<b>Campos:</b> <br/><br/>");
            
            //$obCampos= $this->getBlocosCampos($funcionalidade);
            
            $obCampos = false;
            
            if($obCampos){
            foreach ($obCampos as $ch=>$vl) {
                    $fieldSetMenu = new TElement("div");

                    $campoReqMenu = new TCheckButton("campos-".$ch);
                    $campoReqMenu->setValue("1");
                    $campoReqMenu->setId('7'.$funcionalidade.$ch);
                    $campoReqMenu->setProperty('onclick','setPrivilegio(this, \''.$usuaseq.'\',\'7\',\''.$funcionalidade.'\',\''.$ch.'\')');

                    $divMenu = new TElement("div");
                    $divMenu->id = '7-'.$funcionalidade.$ch;
                    $divMenu->style="padding-left: 0px; padding-top: 5px; padding-bottom: 5px;";

                    if($obUsuario["7"][$funcionalidade][$ch]["1"]) {
                        $campos = $this->viewGetCampoEdicao($usuaseq,$ch);
                        $divMenu->add($campos);
                        $campoReqMenu->checked = "checked";
                    }else {
                        $divMenu->add("");
                    }

                    $fieldSetMenu->add($campoReqMenu);
                    $fieldSetMenu->add("Visualizar \"".$vl->label."\"");

                    $fieldSetMenu->add($divMenu);

                    $obMenu->add($fieldSetMenu);
            }
            }
            }elseif($obBloco->formato == 'lst'){

            $TDbo_sublista = new TKrs('lista');
	            $critsublista = new TCriteria();
	            $critsublista->add(new TFilter("formseq","=",$obBloco->formseq));
	            $critsublista->add(new TFilter("tipo","=",'form'));
            $retsublista = $TDbo_sublista->select("*",$critsublista);
            $obSublista = $retsublista->fetchObject();
            $obOpcoesLista = $this->getOpcoesLista($obSublista->seq);

            $obMenu = new TElement("fieldset");
            $obMenu->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
            $obMenu->style="padding-left: 15px; padding-top: 5px; padding-bottom: 5px;";

                $fieldSetLegenda = new TElement("legend");
                $fieldSetLegenda->class = "ui-widget-content ui-corner-all";
                $fieldSetLegenda->add($obSublista->label);
            $obMenu->add($fieldSetLegenda);
            $checklistoptions = false;

            if($obOpcoesLista->acincluir != '0') {

                $fieldSetOpcoesLista = new TElement("div");

                $campoReqMenu = new TCheckButton("opcoesLista-1");
                $campoReqMenu->setValue("1");
                $campoReqMenu->setId("2".$obOpcoesLista->formseq."1");
                $campoReqMenu->setProperty('onclick','setPrivilegio(this, \''.$usuaseq.'\',\'2\',\''.$obOpcoesLista->formseq.'\',\'1\')');

                if($obUsuario["2"][$obOpcoesLista->formseq]['1']["1"]) {
                    $checklistoptions = true;
                    $campoReqMenu->checked = "checked";
                }
                $fieldSetOpcoesLista->add($campoReqMenu);
                $fieldSetOpcoesLista->add("Incluir registros");

                $obMenu->add($fieldSetOpcoesLista);

            }
            if($obOpcoesLista->aceditar != '0') {

                $fieldSetOpcoesLista = new TElement("div");

                $campoReqMenu = new TCheckButton("opcoesLista-2");
                $campoReqMenu->setValue("1");
                $campoReqMenu->setId("2".$obOpcoesLista->formseq."2");
                $campoReqMenu->setProperty('onclick','setPrivilegio(this, \''.$usuaseq.'\',\'2\',\''.$obOpcoesLista->formseq.'\',\'2\')');

                if($obUsuario["2"][$obOpcoesLista->formseq]['2']["1"]) {
                    $checklistoptions = true;
                    $campoReqMenu->checked = "checked";
                }
                $fieldSetOpcoesLista->add($campoReqMenu);
                $fieldSetOpcoesLista->add("Editar registros");

                $obMenu->add($fieldSetOpcoesLista);

            }
            if($obOpcoesLista->acdeletar != '0') {

                $fieldSetOpcoesLista = new TElement("div");

                $campoReqMenu = new TCheckButton("opcoesLista-3");
                $campoReqMenu->setValue("1");
                $campoReqMenu->setId("2".$obOpcoesLista->formseq."3");
                $campoReqMenu->setProperty('onclick','setPrivilegio(this, \''.$usuaseq.'\',\'2\',\''.$obOpcoesLista->formseq.'\',\'3\')');

                if($obUsuario["2"][$obOpcoesLista->formseq]["3"]["1"]) {
                    $checklistoptions = true;
                    $campoReqMenu->checked = "checked";
                }
                $fieldSetOpcoesLista->add($campoReqMenu);
                $fieldSetOpcoesLista->add("Apagar registros");

                $obMenu->add($fieldSetOpcoesLista);

            }

            if($obOpcoesLista->acreplicar != '0') {

                $fieldSetOpcoesLista = new TElement("div");

                $campoReqMenu = new TCheckButton("opcoesLista-4");
                $campoReqMenu->setValue("1");
                $campoReqMenu->setId("2".$obOpcoesLista->formseq."4");
                $campoReqMenu->setProperty('onclick','setPrivilegio(this, \''.$usuaseq.'\',\'2\',\''.$obOpcoesLista->formseq.'\',\'4\')');

                if($obUsuario["2"][$obOpcoesLista->formseq]["4"]["1"]) {
                    $checklistoptions = true;
                    $campoReqMenu->checked = "checked";
                }
                $fieldSetOpcoesLista->add($campoReqMenu);
                $fieldSetOpcoesLista->add("Replicar registros");

                $obMenu->add($fieldSetOpcoesLista);

            }

            if($obOpcoesLista->acselecao != '0') {

                $fieldSetOpcoesLista = new TElement("div");

                $campoReqMenu = new TCheckButton("opcoesLista-5");
                $campoReqMenu->setValue("1");
                $campoReqMenu->setId("2".$obOpcoesLista->formseq."5");
                $campoReqMenu->setProperty('onclick','setPrivilegio(this, \''.$usuaseq.'\',\'2\',\''.$obOpcoesLista->formseq.'\',\'5\')');

                if($obUsuario["2"][$obOpcoesLista->formseq]["5"]["1"]) {
                    $checklistoptions = true;
                    $campoReqMenu->checked = "checked";
                }
                $fieldSetOpcoesLista->add($campoReqMenu);
                $fieldSetOpcoesLista->add("Multipla Seleção de registros");

                $obMenu->add($fieldSetOpcoesLista);

            }

            $divMenu = new TElement("div");
            $divMenu->id = '2-3123';
            $divMenu->style="padding-left: 15px; padding-top: 5px; padding-bottom: 5px;";

            $colunas = $this->viewGetColunasLista($usuaseq,$obSublista->seq);
            $abas    = $this->viewGetFormAbas($usuaseq,$obBloco->formseq);
            $divMenu->add($colunas);
            $divMenu->add($abas);
            $obMenu->add($divMenu);
            }

            return $obMenu;

        }
    }
    
    /**
     * 
     * @param $usuaseq
     * @param $funcionalidade
     */
    public function viewGetCampoEdicao($usuaseq,$funcionalidade){
        if($funcionalidade) {
            $obCampos= $this->getCampoEdicao($funcionalidade);
            $TUsuario = new TUsuario();
            $obUsuario = $TUsuario->getPrivilegios($usuaseq);

            $obMenu = new TElement("div");
            $obMenu->style = "padding-top: 2px; padding-bottom: 2px;";
            if($obCampos){
                    $fieldSetMenu = new TElement("div");

                    $campoReqMenu = new TCheckButton("campos-".$ch);
                    $campoReqMenu->setValue("1");
                    $campoReqMenu->setId('8'.$funcionalidade.$ch);
                    $campoReqMenu->setProperty('onclick','setPrivilegio(this, \''.$usuaseq.'\',\'8\',\''.$funcionalidade.'\',\''.$obCampos->seq.'\')');

                    if($obUsuario["8"][$funcionalidade][$ch]["1"]) {
                        $campoReqMenu->checked = "checked";
                    }

                    $fieldSetMenu->add($campoReqMenu);
                    $fieldSetMenu->add("Editar \"".$obCampos->label."\"");

                    $obMenu->add($fieldSetMenu);
            }
            return $obMenu;

        }
    }
}