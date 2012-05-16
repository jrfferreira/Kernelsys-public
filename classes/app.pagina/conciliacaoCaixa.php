<?php

function __autoload($classe) {

    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}

//Retorna Usuario logado===================================
$obUser = new TCheckLogin();
$obUser = $obUser->getUser();
//=========================================================

//monta interface do formulário
$obTable = new TTable();
$obTable->width = "100%";
$obTable->border = "0";
$obTable->align = "left";
$obTable->cellpadding = "4";
$obTable->cellspacing = "4";
$obTable->style = "color:#FFFFFF; font-family:'Arial Black'; font-size:12px; border-buttom:1px solid; border-color:#3366FF;";

$rowCampo = $obTable->addRow(" ");
$cellCampo = $rowCampo->addCell(" ");

//campo file
$campoFile = new TFile("ArqRet");
$campoFile->id = "ArqRet";
$campoFile->setValue('Selecione um arquivo de retorno');
$campoFile->setSize('100');

$cellCampo->add($campoFile);

$rowBot = $obTable->addRow("");
$cellBot = $rowBot->addCell("");

$bot = new TElement('input');
$bot->type = "submit";
$bot->name = "executar";
$bot->value = "Executar conciliação";

$cellBot->add($bot);

//Cria elemento fieldset
$BlocoExe = new TElement('fieldset');
$BlocoExe->id = 'bloc_Menu';
$BlocoExe->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
$legBlocoExe = new TElement('legend');
$legBlocoExe->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
$legBlocoExe->add('Leitor de Arquivo Retorno Caixa');
$BlocoExe->add($legBlocoExe);
$BlocoExe->add($obTable);

//formulário
$obForm = new TElement('form');
$obForm->method = "POST";
$obForm->name = "upFile";
$obForm->enctype = "multipart/form-data";
$obForm->action = "";

$obForm->add($BlocoExe);

$css = new TElement('link');
$css->type = "text/css";
$css->href = "../app.ui/css/default_style.css";
$css->rel = "Stylesheet";

$obhtml = new TPage("Conciliação Bancária - CEF");
//$obhtml->setJqueryUi();
$obhtml->addHead($css);
$obhtml->add($obForm);
$obhtml->show();

//executa
if(isset($_POST['executar'])) {

    //== Armazena arquivo de rentorno no servidor ==\\
    //**** arquivo ****\\
    $Arq_nome=$_FILES['ArqRet']['name'];
    $Arq_tipo=$_FILES['ArqRet']['type'];
    $Arq_local=$_FILES['ArqRet']['tmp_name'];
    $Arq_tamanho=$_FILES['ArqRet']['size'];
    $Arq_erro=$_FILES['ArqRet']['error'];

    $local = '../app.tmp/retornoCaixa/'.$Arq_nome;

    if(is_uploaded_file($Arq_local)) {//upload de arquivo
        if(!move_uploaded_file($Arq_local,$local)) {//move arquivo

            new setException(TMensagem::ERRO_MOVER_ARQUIVO);
        }
        else {
            $obConcilia = new TConciliacaoCaixa();
            $obConcilia->runConciliacao($local);
        }
    }else {
        new setException(TMensagem::ERRO_ARQUIVO_NULL);
    }


}
?>