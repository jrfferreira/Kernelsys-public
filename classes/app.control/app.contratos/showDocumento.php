<?php
//==========================================================
// Gera boleto de inscrição
//
//==========================================================
session_start();

$codigo = $_GET['documento'];

function __autoload($classe){

    include_once('../../app.util/autoload.class.php');
    $autoload = new autoload('../../',$classe);
}

$documento = new setDocumento($codigo);



$doc = new TElement("html");

$docTitle = new TElement("title");
$docTitle->add('Documento');

$docStyle = new TElement("style");
$docStyle->add("table{border:1px solid #000;} th {border:1px solid #999;text-align: left;} td {border:1px solid #999;text-align: center;} td.titulo {border:1px solid #000;text-align: center;background-color: #E8E8E8;} body{font-family:Arial, Helvetica, sans-serif;font-size: 14px;}");

$docBody = new TElement("body");

$docBody->add($documento->html());

$doc->add($docTitle);
$doc->add($docStyle);
$doc->add($docBody);


$doc->show();