<?php
/* 
 * Classe responsavel pela formação da barra inferior da Interface
 */
class TRodape {

    function __construct($nome,$unidade){
        $this->unidade = $unidade;
        $this->nome = $nome;
    }

    function show(){
        $obTempo = new TElement('span');
        $obTempo->style = "color: #fff; text-shadow: #333 0px 1px 1px; padding-top: 7px; height: 27px;margin-right: 20px; display: inline; float: right; position: relative; font-family:verdana; font-size:11px; font-weight:bold; cursor:default; text-align: left; vertical-align: middle;";
        $obTempo->id    = "obTempoConteiner";
        $obTempo->add($timePrincipal);
        
        $obLabelModulo = new TElement('span');
        $obLabelModulo->style = "color: #fff; text-shadow: #333 0px 1px 1px; padding-top: 7px; height: 27px; margin-left: 20px; display: inline; float: left; font-family:verdana; font-size:11px; font-weight:bold; cursor:default; text-align: left; vertical-align: middle;";
        $obLabelModulo->id    = "obLabelModulo";
        $obLabelModulo->add('Início');

        $sep = new TElement('span');
        //$sep->style = "margin-left: 2px; display: inline; float: left; font-family:verdana; font-size:5px; font-weight:bolder; cursor:default; text-align: center; vertical-align: middle; background-color: none;";
        //$sep->add('<img src="app.images/arrow.png" border="0" style="margin-top: -1px;" title="Usuário"/>');
        $sep->style = "color: #fff; text-shadow: #333 0px 1px 1px; padding-top: 8px; height: 27px; margin-left: 6px; margin-right: 6px; display: inline; float: left; font-family:verdana; font-size:10px; font-weight:bold; cursor:default; text-align: left; vertical-align: middle;";
        $sep->add('»');

        $obLabelSec = new TElement('span');
        $obLabelSec->style = "color: #fff; text-shadow: #333 0px 1px 1px; padding-top: 7px; height: 27px; margin-left: 0px; display: inline; float: left; font-family:verdana; font-size:11px; font-weight:bold; cursor:default; text-align: left; vertical-align: middle;";
        $obLabelSec->id    = "obLabelSec";
        $obLabelSec->add('--');

        $infoUser = new TElement('span');
        $infoUser->style = "color: #fff; text-shadow: #333 0px 1px 1px; margin-right: 20px; display: inline; float: right; position: relative; font-family:verdana; font-size:10px; font-weight:normal; cursor:default; text-align: left; vertical-align: middle;";
        $infoUser->id    = "obUser";
        $infoUser->add('<img src="app.images/new_user.png" border="0" style="margin-top: 2px;" title="Usuário"/>'.$this->nome.'<br/><img src="app.images/new_home.png" border="0" title="Unidade"/>'. $this->unidade);
        $infoUser->add("<span id='retLoad'></span>");

        $logout = new TElement('span');
        $logout->id    = "obSair";
        $logout->style = "display: inline; float: right; position: relative; padding-top: 5px; right: 10px";
        $logout->add('<img src="app.images/sair.png" border="0" alt="SAIR" id="logout" onclick="onLogout(\''.TOccupant::getOccupant().'\')" style="height: 18px; cursor:pointer;" />');

        $loading = new TElement('div');
        $loading->id = 'loading-status';
        $loading->class = '';
        $loading->add('');

        $DRodaPe = new TElement('div');
        $DRodaPe->id = "infoRodape";
        $DRodaPe->class = "ui-widget-content ui-widget-header";
        $DRodaPe->style = "width: 100%; cursor:default; height: 28px; vertical-align: middle; position: fixed; top: 100%; margin-top: -30px; padding-right:5px; padding-left:5px; z-index: 9999999999999;";
        $DRodaPe->add($loading);
        $DRodaPe->add($obLabelModulo);
        $DRodaPe->add($sep);
        $DRodaPe->add($obLabelSec);
        $DRodaPe->add($logout);
        //$DRodaPe->add($obTempo);
        $DRodaPe->add($infoUser);
        $DRodaPe->add("<div id='box_dialog' class='dialog'></div>");

        return $DRodaPe;
    }
}
?>
