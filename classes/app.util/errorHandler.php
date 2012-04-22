<?php
function errorHandler($errNum, $errString, $errFile, $errLine) {
	$resposta = '';
	
	if (! (error_reporting () && $errNum)) {
		return;
	}
	
	switch ($errNum) {
		case E_USER_ERROR :
			$resposta  = "<b>Erro:</b> [$errNum] $errString<br />\n";
			$resposta .= "  Aconteceu um erro fatal na linha $errLine do arquivo $errFile";
			$resposta .= ", PHP " . PHP_VERSION . " (" . PHP_OS . ")<br />\n";
			$resposta .= "Abortando...<br />\n";
			exit ( 1 );
			break;
		
		case E_USER_WARNING :
			$resposta = "<b>Cuidado:</b> [$errNum] $errString<br />\n";
			break;
		
		case E_USER_NOTICE :
			$resposta = "<b>Aviso:</b> [$errNum] $errString<br />\n";
			break;
		
		default :
			$resposta = "Aconteceu um erro desconhecido: [$errNum] $errString<br />\n";
			break;
	}
	
	$corpoMsg = new TElement ( 'span' );
	$corpoMsg->style = "font-size:11px; margin:5px;";
	$corpoMsg->add ( $resposta );
	
	$showMsg = new TMessage ( 'Informação do sistema!', $corpoMsg );
	
	return true;
}