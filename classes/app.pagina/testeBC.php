<?php
//==========================================================
// Gera boleto de inscrição
//
//==========================================================
session_start();

function __autoload($classe) {

    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}
//Retorna Usuario logado===================================

$obUser = new TCheckLogin();
$obUser = $obUser->getUser();
//=========================================================

include('../app.widgets/TBarCode.class.php');


$barcode = new TBarCode('10005368-358', 100);
$barcode->setEanStyle(false);
$barcode->setShowText(false);
$barcode->setBorderWidth(1);
$barcode->saveBarcode('../'.TOccupant::getPath().'app.files/5.png');

echo '<img src="../'.TOccupant::getPath().'app.files/5.png" />'

?>