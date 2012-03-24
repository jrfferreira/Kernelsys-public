<?php
//--------------------------------------------------
// Aquivo para alocar dados de controle necessarios em sessção
// via ajax.
//--------------------------------------------------
// Pega dados

function __autoload($classe){

    include_once('autoload.class.php');
    $autoload = new autoload('../',$classe);
}

$valor     = $_GET['alValor'];
$idContent = $_GET['idc']; 

$obsession = new TAlocaDados($idContent, $valor);
