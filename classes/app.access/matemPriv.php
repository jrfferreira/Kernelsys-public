<?php

function __autoload($classe){

    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}

	//Retorna Usuario logado===================================
	$obUser = new TCheckLogin();
	$obUser = $obUser->getUser();
	//=========================================================	

	//Instancia manipulador de sessão
	$obsession = new TSession();
		
	$tKrs = new TKrs('menu_modulos');
	$criterio = new TCriteria();
	$criterio->add(new TFilter('ativo','=',1));
	$criterio->add(new TFilter('moduloprincial','=',$param['rid']));
	$runSubMenu = $tKrs->select('*',$criterio);
	
	$divM = new TElement('div');
			
	while($retSubMenu = $runSubMenu->fetchObject()){
		
		$obCheck = new TCheckButton('submenuOp'.$retSubMenu->id);
		$obCheck->setValue($retSubMenu->id);
		$obCheck->onclick = "setPvlShow(this)";
	
			$obLabel = new TElement('div');
			$obLabel->style = "margin:5px;";
			
			$obLabel->add($obCheck);
			$obLabel->add($retSubMenu->labelmodulo);
			
			$divM->add($obLabel);
	}
	
	$divM->show();

?>