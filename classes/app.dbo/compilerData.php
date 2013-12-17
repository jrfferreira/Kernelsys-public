<?php
/**
 *
 */

function __autoload($classe) {
    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}
//Retorna Usuario logado===================================
$obUser = new TCheckLogin();
$obUser = $obUser->getUser();
$unidade = $obUser->unidade->seq;
//=========================================================

$getDados = NULL;
$getDados = $_POST;

print_r($getDados);
exit;

$formseq        = $getDados[TConstantes::FORM];
$valor         = $getDados['valor'];
$campo         = $getDados['campo'];

    //retorna o cabeçalho do formulário
    $obHeaderForm = new TSetHeader();
    $headerForm = $obHeaderForm->getHead($formseq);

    $camposSession = $headerForm[TConstantes::CAMPOS_FORMULARIO];
    if($camposSession){
        $campoAtual = $camposSession[$campo];
        $campoAtual['valor']  = $valor;
        $campoAtual[TConstantes::FIELD_STATUS] = 0;

        //atualiza a auteração na sessão
        $camposSession[$campo] = $campoAtual;
        $obHeaderForm->addHeader($formseq, TConstantes::CAMPOS_FORMULARIO,  $camposSession);
    }

