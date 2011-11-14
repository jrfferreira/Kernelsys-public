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

        TTransaction::close();
        TTransaction::open('../'.TOccupant::getPath().'app.config/krs');

        if($conn = TTransaction::get()) {

            $sqlMod = "select * from modulos_principais where ativo='1'";
            $runMod = $conn->Query($sqlMod);

            //monta vetor com modulos
            while($mod = $runMod->fetchObject()) {
                $modulos[$mod->id] = $mod->labelmodulo;
            }

            TTransaction::close();
            return $modulos;
        }
    }

    /*
    * Retorna vetor com os menus
    */
    public function getMenus($modulo) {

        TTransaction::close();
        TTransaction::open('../'.TOccupant::getPath().'app.config/krs');

        if($conn = TTransaction::get()) {
            $sqlMenu = "select * from menu_modulos where moduloprincipal='$modulo' order by ordem";
            $runMenu = $conn->Query($sqlMenu);

            while($menu = $runMenu->fetchObject()) {
                $menus[$mod->id] = $menu->labelmodulo;
            }
        }
        TTransaction::close();
        return $menus;
    }

    /*
     * Retorna estrutura de formulários aninhadas em vetor
    */
    private function getForms($form) {

        TTransaction::close();
        TTransaction::open('../'.TOccupant::getPath().'app.config/krs');

        if($conn = TTransaction::get()) {

            $sqlForm = "select * from forms where id='$form'";
            $runForm = $conn->Query($sqlForm);
            $form = $runForm->fetchObject();

            $vetForm[$form->id]['label'] = $form->nomeForm;

            //retorna o relacionamento form_x_abas
            $sqlFormAbas = "select * from form_x_abas where formid='$form->id' order by ordem";
            $runFormAbas = $conn->Query($sqlFormAbas);

            while($formAbas = $runFormAbas->fetchObject()) {

                $sqlAbas = "select * from abas where id='$formAbas->abaid' order by ordem";
                $runAbas = $conn->Query($sqlAbas);
                $aba = $runAbas->fetchObject();

                $vetAbas[$aba->id]['label'] = $aba->nomeaba;

                //retorna relacionamento de abas_x_blocos
                $sqlBlocosAbas = "select * from blocos_x_abas where abaid='$aba->id' order by ordem";
                $runBlocosAbas = $conn->Query($sqlBlocosAbas);

                while($blocosAbas = $runBlocosAbas->fetchObject()) {

                    $sqlBloco = "select * from blocos where id='$blocosAbas->blocoid'";
                    $runBloco = $conn->Query($sqlBloco);
                    $bloco->fetchObject();

                    $vetBlocos[$bloco->id]['label'] = $bloco->nomebloco;

                    //Retorna relacionamento do campos_x_blocos
                    $sqlCamposBlocos = "select * from campos_x_blocos where blocoid='$bloco->id'";
                    $runCamposBlocos = $conn->Query($sqlCamposBlocos);

                    while($camposBlocos = $runCamposBlocos->fetchObjct()) {

                        $sqlCampo = "select * from campos where id='$camposBlocos->campoid'";
                        $runCampo = $conn->Query($sqlCampo);
                        $campo = $runCampo->fetchObject();

                        $vetCampos[$campo->id] = $campo->campo;
                    }
                    $vetBlocos[$bloco->id]['campos'] =  $vetCampos;
                }
                $vetAbas[$aba->id]['blocos'] = $vetBlocos;
            }
            $vetForm[$form->id]['abas'] = $vetAbas;
        }
        TTransaction::close();
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
?>
