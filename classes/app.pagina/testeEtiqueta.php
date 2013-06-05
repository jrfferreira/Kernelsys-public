<?php
session_start();

function __autoload($classe) {

    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}
//Retorna Usuario logado===================================

include_once('../app.lib/fpdf/code128.php');

$obUser = new TCheckLogin();
$obUser = $obUser->getUser();
//=========================================================

// $espHorizontal, $espVertical, $largura, $altura, $margemEsq, $margemSup, $colunas, $linhas
$espHorizontal = '10,68';
$espVertical = '2,54';
$largura = '10,16';
$altura = '2,54';
$margemEsq = '0,40';
$margemSup = '1,27';
$colunas = '2';
$linhas = '10';

$TEtiquetas = new TEtiquetas($espHorizontal, $espVertical, $largura, $altura, $margemEsq, $margemSup, $colunas, $linhas);

$array[] = array('2942222q','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('1294','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('2294','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('3294','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('4294','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('5294','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('6294','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('7294','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('8294','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('9294','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('2942222q','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('1294','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('2294','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('3294','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('4294','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('5294','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('6294','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('7294','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('8294','3597.5','2','3','1','BarCode/1000458-258');
$array[] = array('9294','3597.5','2','3','1','BarCode/1000458-258');

$TEtiquetas->addDados($array);
$TEtiquetas->geraPDF();

?>