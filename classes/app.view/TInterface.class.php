<?php
/*
* Classe que monta a interface principal da index do sistema
* Autor: Wagner Borba
* Data: 22/10/2008
* Data de altualizção: --/--/----
*/

function __autoload($classe) {
    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}

$obCheckLogin = new TCheckLogin();

// Retorna privilegios do usuario
$inPriv = new TGetPrivilegio("0", "0");
$obPriv = $inPriv->get();
$obUser = $inPriv->getUser();

// Monta botões dos módulos principais \\
//inicia uma transação com a camada de dados do form

    $THeader = new TSetHeader();
    $THeader->add('zIndex',0);
    $THeader->setHeader('interface');


    //===== monta criterios de acesso do uruario ======\\
    if(is_array($obPriv)) {
    	
    $criterio = new TCriteria();
    	$criterio->add(new TFilter('ativo','=','1'),'AND');
    
        foreach($obPriv as $mp) {
        	$filter = new TFilter('id','=',$mp);
        	$filter->setTipoFiltro('idSelecao');        	
    		$criterio->add($filter,"OR");
        }
    }
    else {
        new setException(TMensagem::ERRO_PRIVILEGIOS);
    }
    //=================================================\\
    $tKrs = new TKrs('modulos_principais');
    $execSql = $tKrs->select('*',$criterio);

    $obLogo = new TElement('div');
    $obLogo->id = "logoBitup";
    $obLogo->class = "moduloTopLeft";
    $obLogo->onclick = "$('.modulobot:not(.modulobotClick)').toggle();";
    $obLogo->add('<img src="app.images/bitup.png" alt="BitUP"/>');

    $BarraPrincipal = new TElement('div');
    $BarraPrincipal->id =  "barraPrincipal";
    $BarraPrincipal->align = 'center';
    $BarraPrincipal->class = "barraPrincipal ui-widget-header";
    $BarraPrincipal->add($obLogo);

    $BarraMenu = new TElement('div');
    $BarraMenu->id =  "barraMenu";
    //percorre modulos liberados e monta menu
    if($execSql){
    while($retMods = $execSql->fetchObject()) {

        $botPrincipal = new TElement('span');
        $botPrincipal->add($retMods->labelmodulo);
        $botPrincipal->class = "inmodulobot";

        $mbotCont = new TElement('div');
        $mbotCont->class = "modulobot";
        //$mbotCont->onMouseOver = "this.className='modulobotoff'";
        $mbotCont->title  = $retMods->labelmodulo;
        $mbotCont->alt    = $retMods->labelmodulo;
        $mbotCont->add($botPrincipal);

        $mbotCont->onclick = "prossInter(this,'".$retMods->id."');";

       // $BarraMenu->add($mbotCont);
        $BarraPrincipal->add($mbotCont);
    }
    }else{
        $botPrincipal = new TElement('span');
        $botPrincipal->add("Usuário sem privilégios.");
        $botPrincipal->class = "inmodulobot";

        $mbotCont = new TElement('div');
        $mbotCont->class = "modulobot";
        //$mbotCont->onMouseOver = "this.className='modulobotoff'";
        $mbotCont->title  = $retMods->labelmodulo;
        $mbotCont->alt    = $retMods->labelmodulo;
        $mbotCont->add($botPrincipal);

       // $BarraMenu->add($mbotCont);
        $BarraPrincipal->add($mbotCont);
    }

    //$BarraPrincipal->add($BarraMenu);

  /*  $timePrincipal = new TElement('span');
    $timePrincipal->id = 'obTempo';
    $timePrincipal->add(date("H:i:s"));
    $timePrincipal->class = "inmodulobot"; */

    $pesq = new TElement('input');
    $pesq->type = 'text';
    $pesq->maxlength = '17';
    $pesq->style = 'width: 120px; margin-top: 2px; margin-right: 2px; margin-bottom: 2px; margin-left: 4px; font-size: 11px; border-top-left-radius: 3px 3px; border-top-right-radius: 3px 3px; border-bottom-right-radius: 3px 3px; border-bottom-left-radius: 3px 3px; ';
    $pesq->class = "ui-state-default ui-state-hover pesqModulo";
    $obTopR = new TElement('div');
    $obTopR->id = "topRight";
    $obTopR->class = "moduloTopRight";
    //$obTopR->add($timePrincipal);
    $obTopR->add($pesq);
    $obTopR->add('<img src="app.images/petrus/new_ico_search.png" alt="Buscar"  titulo="Buscar" id="pesqModuloImg" onclick="pesqModulo()"/>');
    $BarraPrincipal->add($obTopR);

    //cria botão de ajuda
    $help = new TElement('img');
    $help->src = "app.images/help.png";
    $help->onclick = "setPopUp('windowHelp', '../app.manual/manual/index.html', '20', '200', '800', '600')";
    $help->style = "cursor:pointer;";
    $help->alt="Ajuda";
    $help->border="0";
    $help->align = "right";


    //$BarraPrincipal->add($help);

    //bot�o de customização
    //$obBotCuston = new TSetCuston();
    //$botCuston = $obBotCuston->getBot();
    //$BarraPrincipal->add($botCuston);

//======================================\\


// Area de visualização
$DCorpo = new TElement('div');

$DCorpo->id = 'bodyDisplay';
$conteiner = new TTable();
        $conteiner->id          = 'conteiner';
        $conteiner->border      = "0";
        $conteiner->cellpadding = "0";
        $conteiner->cellspacing = "0";
        $conteiner->bordercolor = "#0000cc";
        $conteiner->width       = "100%";
        $conteiner->height      = "100%";

        $row = $conteiner->addRow();

        $cellMenu    = $row->addCell('<div id="obRet"></div>');
        $cellMenu->valign = "top";
        $cellMenu->width  = "170px";
        $cellMenu->id = "menuLateral";
        $cellMenu->style = "";
        $cellMenu->add('<div id="obReposit"></div>');
        $cellMenu->add('<div id="winRet"></div>');

        $cellDisplay = $row->addCell('');
        $cellDisplay->height = "100%";

$DCorpo->add($conteiner);


//Instancia barra inferior
$DRodaPe = new TRodape($obUser);


//Instancia a pagina
$pageSys = new TPage('untitled',"");
$pageSys->setJqueryUi();

$content = new TElement("div");
$content->class = "ui-widget-header";
$content->style = "width: 100%; height:100%;background-image:url(app.images/bg.png);background-repeat: repeat-x;background-position:bottom;";


$content->add($BarraPrincipal);
$content->add($DCorpo);
$content->add($DRodaPe->show());

$pageSys->add($content);
//$pageSys->add($BarraPrincipal);
//$pageSys->add($DCorpo);
//$pageSys->add($DRodaPe);

$pageSys->show();

?>