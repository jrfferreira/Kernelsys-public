<?php
/**
 *
 *
 *
 */

session_start();
function __autoload($classe) {
    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../', $classe);
}


$produto = new TProduto();
$relatorioProduto = $produto->viewEstoqueProduto();

$page = new TPage($_GET['titulo']);
//$page->setJqueryUi();
    $divCorpo = new TElement('div');
    $divCorpo->add($relatorioProduto);
$page->add($divCorpo);

$page->show();

?>