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

		TTransaction::open($patchDB);
		
if($conn = TTransaction::get()){
		
	$sqlSubMenu = "select * from menu_modulos where ativo='1' and moduloPrincipal='".$param['rid']."'";
	$runSubMenu = $conn->Query($sqlSubMenu);
	
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
}	


?>