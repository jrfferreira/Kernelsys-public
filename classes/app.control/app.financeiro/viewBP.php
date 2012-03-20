<?php
/**
* Exibe o método get($dataBP) da classe viewBPatrimonial.class
* @author : Jo�o Felix
* @version: 29/04/2009 - 15:40
*/
function __autoload($classe){

    include_once('../../app.util/autoload.class.php');
    $autoload = new autoload('../../',$classe);
}

// codifica a forma de saidad dos dados no header (tratando caracteres especiais) \\
			//@header("Content-Type: text/html; charset=UTF-8",true);
			
	//Retorna Usuario logado===================================
	$obUser = new TCheckLogin();
	$obUser = $obUser->getUser();
	//=========================================================	

	$objeto = new viewBPatrimonial();
    return $objeto->get($_POST["id"]);
	