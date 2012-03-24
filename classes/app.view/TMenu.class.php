<?php
/***********************************************************************
Interface do usuario
***********************************************************************/


function __autoload($classe) {

    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}

class TMenu {

    public function __construct($id) {

        // Retorna privilegios do usuario
        $inPriv = new TGetPrivilegio($id, "1");
        $obPriv = $inPriv->get();

        // Monta botões dos menu secundário \\

        $conteiner = new TTable();
        $conteiner->id          = 'conteiner';
        $conteiner->border      = "0";
        $conteiner->cellpadding = "0";
        $conteiner->cellspacing = "0";
        $conteiner->bordercolor = "#0000cc";
        $conteiner->width       = "100%";
        $conteiner->height      = "100%";

        //inicia uma transação com a camada de dados do form
        $this->obKDbo = new TKrs();

        $criteriaModulosPriv = new TCriteria();

        //===== monta criterios de acesso do uruario ======\\
        if(is_array($obPriv)) {
            foreach($obPriv as $mp) {
                $filtro = new TFilter('id','=',$mp);
                $criteriaModulosPriv->add($filtro,'OR');
            }
            $filtro = new TFilter('ativo','=','1','2');
            $criteriaModulosPriv->add($filtro);
        }
        else {
            exit('Usuario sem privilégios.');
        }
            $filtro = new TFilter('moduloprincipal','=',$id,'2');
            $criteriaModulosPriv->add($filtro,'AND');
            $criteriaModulosPriv->setProperty('order', 'ordem');
        //=================================================\\

        // Percorre menus===========================================================
        $this->obKDbo->setEntidade("menu_modulos");
        $execSql = $this->obKDbo->select("*", $criteriaModulosPriv);

        $this->obKDbo->close();

        $boxMenu = new TElement('div');
        $boxMenu->id = 'boxMenuSec';
        while($retMenus = $execSql->fetchObject()) {

            if($retMenus->modulo == '<separador>') {
                $bot = new TElement('div');
                $bot->class = "botSeparador";
                $bot->style = "margin-bottom: 0px dotted #c0c0c0; width: 5px; height: 2px";
                $bot->add('');
            }
            else {

                //prepara path do botão
                $path  = "TExecs.class.php?method=".$retMenus->metodo;
                $path .= "&idForm=".$retMenus->argumento;
                $path .= '&nivel=1';

                $bot = new TElement('div');

                //$iconSpan = new TElement("span");
                //$iconSpan->class = "ui-icon ui-icon-triangle-1-e";
                //$iconSpan->add("");

                $labelSpan = new TElement("span");
                $labelSpan->style="padding: 3px";
                $labelSpan->add($retMenus->labelmodulo);

                //$bot->add($iconSpan);
                $bot->add($labelSpan);
                
                $bot->onclick      = "prossInterSec('".$retMenus->labelmodulo."', '".$path."')";
                $bot->class        = "botActionOff ui-state-default ui-corner-all";
                $bot->alt          = $retMenus->labelmodulo;
                $bot->title        = $retMenus->labelmodulo;
            }


            $boxMenu->add($bot);
        }
        //==========================================================================

        $display = new TElement('div');
        $display->id      = 'displaySys';
        $display->style   = "width:100%; height:99%; display: block; vertical-align: top;";
        $display->add("");

        $row = $conteiner->addRow();

        $cellMenu    = $row->addCell($boxMenu);
        $cellMenu->valign = "top";
        $cellMenu->width  = "170px";
        $cellMenu->id = "menuLateral";
        $cellMenu->style = "";

        $cellMenu->add('<div id="obRet"></div>');
        $cellMenu->add('<div id="obReposit"></div>');
        $cellMenu->add('<div id="winRet"></div>');

        $cellDisplay = $row->addCell($display);
        $cellDisplay->height = "100%";
        $cellDisplay->style = "vertical-align: top;";

        $conteiner->show();
        //======================================\\
        
        $this->obKDbo->close();
    }

}

$obMenu = new TMenu($_GET['id']);
?>