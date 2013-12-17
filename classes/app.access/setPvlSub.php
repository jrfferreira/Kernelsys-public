<?php

function __autoload($classe){

    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}

	//Retorna Usuario logado===================================
	$obUser = new TCheckLogin();
	$obUser = $obUser->getUser();
	//=========================================================	

$param = $_POST;

		TTransaction::open('../'.TOccupant::getPath().'app.config/krs');
		
if($conn = TTransaction::get()){
		
	$sqlSubMenu = "select * from menu where statseq='1' and moduloPrincipal='".$param['rid']."'";
	$runSubMenu = $conn->Query($sqlSubMenu);
	
	$divM = new TElement('div');
			
	while($retSubMenu = $runSubMenu->fetchObject()){
		
		$obCheck = new TCheckButton('submenuOp'.$retSubMenu->seq);
		$obCheck->setValue($retSubMenu->seq);
		$obCheck->onclick = "setPvlShow(this, nivel, '".$param['cd']."')";
	
			$obLabel = new TElement('div');
			$obLabel->style = "margin:5px;";
			
			$obLabel->add($obCheck);
			$obLabel->add($retSubMenu->labelmodulo);
			
			$divM->add($obLabel);
	}
	TTransaction::close();
	
	//===========================================================================================
	//grava privilegio do menu principal no db de priviliegios
		//Instancia manipulador de sessão
		$obsession = new TSession();
		$patchDB   = $obsession->getValue('pathDB');
		TTransaction::open($patchDB);
		
	if($conn = TTransaction::get()){
	
		$sqlCkPriv = "select seq from dbusuario_privilegio where statseq='1' and seq='".$param['cd']."' and nivel='0' and modulo='".$param['rid']."'";
		$runCkPriv = $conn->Query($sqlCkPriv);
		$retCkPriv = $runCkPriv->fetchObject();
		
		if($retCkPriv->seq){
			
			$upPriv = "UPDATE dbusuario_privilegio set statseq='".$param['sit']."' where seq='".$param['cd']."' and nivel='0' and modulo='".$param['rid']."'";
			$runUp  = $conn->Query($upPriv);
		}
		else{
		
			$inPriv = "insert into dbusuario_privilegio set seq='".$param['cd']."', unidade='".$obUser->unidade->seq."', nivel='0', modulo='".$param['rid']."',datacad='".date("Y-m-d")."', statseq='1'";
			$runIn  = $conn->Query($inPriv);
			
			if(!$runIn){
				exit("Privilegio não pode ser gravado.");
			}
		}
	//=============================================================================================================	
	
	//exibe privilegios secund�rios
	$divM->show();
	}
}	