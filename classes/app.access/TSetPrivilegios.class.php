<?php
/* 
*Classe de manipulação de privilegios do usuario
*Autor: Wagner Borba;
*/

class TSetPrivilegios {

    /*
    * método padr�o do sietma de apendices das abas
    * passa os paramentos para a class
    */
    public function setParam($param) {

        //Retorna Usuario logado===================================
        $obUser = new TCheckLogin();
        $obUser = $obUser->getUser();
        //=========================================================

        $this->param = $param;
    }

    /*
     * Retorna um vetor com todos os modulos
    */
    private function getModulos() {
            $tKrs = new TKrs('modulos_principais');
            $crit = new TCriteria();
            $crit->add(new TFilter('ativo','=','1'));
            $runMod = $tKrs->select('*',$crit);
            
            //monta vetor com modulos
            while($mod = $runMod->fetchObject()) {
                $modulos[$mod->id] = $mod->labelmodulo;
            }

            return $modulos;
    }

    /*
    * Retorna vetor com os menus
    */
    public function getMenus($modulo) {         
            
            $tKrs = new TKrs('menu_modulos');
            $crit = new TCriteria();
            $crit->add(new TFilter('moduloprincipal','=',$modulo));
            $crit->setProperty('order', 'ordem');
            $runMenu = $tKrs->select('*',$crit);

            while($menu = $runMenu->fetchObject()) {
                $menus[$mod->id] = $menu->labelmodulo;
            }
        return $menus;
    }

    /*
     * Retorna estrutura de formulários aninhadas em vetor
    */
    private function getForms($form) {


            
            $tKrs = new TKrs('forms');
            $crit = new TCriteria();
            $crit->add(new TFilter('id','=',$form));
            $runForm = $tKrs->select('*',$crit);
            
            $form = $runForm->fetchObject();

            $vetForm[$form->id]['label'] = $form->nomeForm;

            //retorna o relacionamento form_x_abas
            
            $tKrs->setEntidade('form_x_abas');
            $crit = new TCriteria();
            $crit->add(new TFilter('formid','=',$form->id));
            $crit->setProperty('order', 'ordem');
            $runFormAbas = $tKrs->select('*',$crit);
            

            while($formAbas = $runFormAbas->fetchObject()) {               
                $tKrs->setEntidade('abas');
                $crit = new TCriteria();
                $crit->add(new TFilter('id','=',$formAbas->abaid));
                $crit->setProperty('order', 'ordem');
                $runAbas = $tKrs->select('*',$crit);
                $aba = $runAbas->fetchObject();

                $vetAbas[$aba->id]['label'] = $aba->nomeaba;

                //retorna relacionamento de abas_x_blocos
                $tKrs->setEntidade('blocos_x_abas');
                $crit = new TCriteria();
                $crit->add(new TFilter('abaid','=',$aba->id));
                $crit->setProperty('order', 'ordem');
                $runBlocosAbas = $tKrs->select('*',$crit);

                while($blocosAbas = $runBlocosAbas->fetchObject()) {                    
                    $tKrs->setEntidade('blocos');
                    $crit = new TCriteria();
                    $crit->add(new TFilter('id','=',$blocosAbas->blocoid));
                    $runBloco = $tKrs->select('*',$crit);
                                        
                    $bloco = $runBloco->fetchObject();

                    $vetBlocos[$bloco->id]['label'] = $bloco->nomebloco;

                    //Retorna relacionamento do campos_x_blocos
                    
                    $tKrs->setEntidade('campos_x_blocos');
                    $crit = new TCriteria();
                    $crit->add(new TFilter('blocoid','=',$bloco->id));
                    $runCamposBlocos = $tKrs->select('*',$crit);
                    

                    while($camposBlocos = $runCamposBlocos->fetchObjct()) {                    
                    	$tKrs->setEntidade('campos');
                    	$crit = new TCriteria();
                    	$crit->add(new TFilter('id','=',$camposBlocos->campoids));
                    	$runCampo = $tKrs->select('*',$crit);
                    
                        $campo = $runCampo->fetchObject();

                        $vetCampos[$campo->id] = $campo->campo;
                    }
                    $vetBlocos[$bloco->id]['campos'] =  $vetCampos;
                }
                $vetAbas[$aba->id]['blocos'] = $vetBlocos;
            }
            $vetForm[$form->id]['abas'] = $vetAbas;
        return $vetForm;
    }

    /*
    * Monta forma de exibição dos modulos
    */
    public function showModulos() {

        $divModulos = new TElement('div');
        $modulos = $this->getModulos();

        foreach($modulos as $modId=>$label) {

            $obCheck = new TCheckButton('moduloOp'.$modId);
            $obCheck->setValue($modId);
            if($retCkPriv->ativo == "1") {
                $obCheck->checked = '1';
            }
            $obCheck->onclick = "showPrivilegios(this, '".$this->param."', '0')";

            //Div conteiner para sub elementos
            $divSub = new TElement('div');
            $divSub->id = "boxMenu".$modId;
            //$divSub->style = "border:1px solid;";
            $divSub->add(" ");

            $obLabel = new TElement('div');
            $obLabel->style = "margin:5px; border:1px solid #ccccee;";
            $obLabel->add($obCheck);
            $obLabel->add($label);
            $obLabel->add($divSub);

            $divModulos->add($obLabel);
        }

        //Cria elemento fieldset Modulos
        $BlocoM = new TElement('fieldset');
        $BlocoM->id = 'bloc_Menu';
        $BlocoM->style = "width:400px; height:96%;";
        $legBlocoM = new TElement('legend');
        $legBlocoM->add('Menu Principal');
        $BlocoM->add($legBlocoM);
        $BlocoM->add($divModulos);

        return $BlocoM;

    }

    /*
    * Menta forma de exibição dos menus
    */
    public function showMenus($modulo) {

        $divMenus = new TElement('div');
        $menus = $this->getMenus($modulo);

        foreach($menus as $menuId=>$label) {

            $obCheck = new TCheckButton('menuOp'.$menuId);
            $obCheck->setValue($menuId);
            if($retCkPriv->ativo == "1") {
                $obCheck->checked = '1';
            }
            $obCheck->onclick = "setPvlShow(this, '".$this->param."')";

            //Div conteiner para sub elementos
            $divSub = new TElement('div');
            $divSub->id = "boxForm".$modId;
            //$divSub->style = "border:1px solid;";
            $divSub->add(" ");

            $obLabel = new TElement('div');
            $obLabel->style = "margin:5px; border:1px solid #ccccee;";
            $obLabel->add($obCheck);
            $obLabel->add($label);
            $obLabel->add($divSub);

            $divMenus->add($obLabel);
            
        }
        return $divMenus;
    }

    /*
     * Metodo executor do apendice
    */
    public function get() {
        return $this->showModulos();
    }

}