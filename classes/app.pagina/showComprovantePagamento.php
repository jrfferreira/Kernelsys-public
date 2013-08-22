
<?php

//==========================================================
//
//
//==========================================================
session_start();

$seq= $_GET['cod'];

function __autoload($classe) {

    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../', $classe);
}
$TSetModel = new TSetModel();

$obTDbo = new TDbo(TConstantes::VIEW_CAIXA);
$criteriaCaixa = new TCriteria();
$criteriaCaixa->add(new TFilter(TConstantes::SEQUENCIAL, '=', $seq));
$retCaixa = $obTDbo->select('*', $criteriaCaixa);

$obMovimentoCaixa = $retCaixa->fetchObject();

$nomepessoa = $obMovimentoCaixa->nomepessoa;
$data = $obMovimentoCaixa->datacad;
$valor = $TSetModel->setValorMonetario($obMovimentoCaixa->valorpago);
$formapag = $obMovimentoCaixa->formapag;
$movimentacao = $obMovimentoCaixa->seq;

$obTDbo = new TDbo(TConstantes::VIEW_PARCELA);
$criteriaConta = new TCriteria();
$criteriaConta->add(new TFilter('seq', '=', $obMovimentoCaixa->parcseq));
$retConta = $obTDbo->select('*', $criteriaConta);

$obConta = $retConta->fetchObject();

$obTDbo = new TDbo(TConstantes::VIEW_PARCELA);
$criteriaTransacao = new TCriteria();
$criteriaTransacao->add(new TFilter('transeq', '=', $obConta->transeq));
$retTransacao = $obTDbo->select('count(1) as total', $criteriaTransacao);

$obTransacao = $retTransacao->fetchObject();

$obTDbo = new TDbo(TConstantes::VIEW_ALUNO);
$criteriaTransacaoAluno = new TCriteria();
$criteriaTransacaoAluno->add(new TFilter('codigotransacao', '=', $obConta->codigotransacao));
$retTransacaoAluno = $obTDbo->select('codigo,nometurma,nomecurso', $criteriaTransacaoAluno);

$obTransacaoAluno = $retTransacaoAluno->fetchObject();
if($obTransacaoAluno && $obTransacaoAluno->codigo){
    $textoAluno = "<br/>Matrícula do Aluno: ".$obTransacaoAluno->codigo."<br/>Turma: ".$obTransacaoAluno->nometurma." - ".$obTransacaoAluno->nomecurso;
}else{
    $textoAluno = "";
}

$num = $obConta->numparcela;
$tot = $obTransacao->total;
$codconta = $obConta->codigo;
$codtransacao = $obConta->codigotransacao;

$obTDbo = new TDbo(TConstantes::VIEW_UNIDADES);
$criteriaUnidade = new TCriteria();
$criteriaUnidade->add(new TFilter(TConstantes::SEQUENCIAL, '=', $obMovimentoCaixa->unidade));
$retUnidade = $obTDbo->select('*', $criteriaUnidade);
$obUnidade = $retUnidade->fetchObject();

$unidade = "{$obUnidade->nomeunidade} ({$obUnidade->razaosocial})";
$dia = date('d');
switch(date('m')){
    case '01': $mes = 'janeiro';break;
    case '02': $mes = 'fevereiro';break;
    case '03': $mes = 'março';break;
    case '04': $mes = 'abril';break;
    case '05': $mes = 'maio';break;
    case '06': $mes = 'junho';break;
    case '07': $mes = 'julho';break;
    case '08': $mes = 'agosto';break;
    case '09': $mes = 'setembro';break;
    case '10': $mes = 'outubro';break;
    case '11': $mes = 'novembro';break;
    case '12': $mes = 'dezembro';break;
}
$ano = date('Y');

$rodape = "<i>{$obUnidade->cidade},{$obUnidade->estado}: {$dia} de {$mes} de {$ano}.</i>";

$logomarca = '<IMG SRC="../'.TOccupant::getPath().'app.config/logo.jpg" style="width: 100px;">';

$assinatura_digital = $TSetModel->setCertificacaoDigitial($obMovimentoCaixa->seq);
$assinatura = "Ass.: __________________________";

$titulo = "Comprovante de Pagamento";

$texto = "A <b>{$unidade}</b> confirma que <b>{$nomepessoa}</b> efetivou o pagamento da quantia de <b>{$valor}</b> em {$formapag} na data de <b>{$data}</b> referente à movimentação de caixa Cod. <b>{$movimentacao}</b>.<br/><br/>Parcela: <b>{$num}/{$tot}</b><br/>Conta: {$codconta}<br/>Transação: {$codtransacao}{$textoAluno}";


$tabela = new TTable();
$tabela->border = 0;
$tabela->cellspacing = 0;

$linha1 = $tabela->addRow();
$celula1 = $linha1->addCell($titulo);
$celula1->id = 'titulo';
$celula1->colspan = 1;
$celula2 = $linha1->addCell($logomarca);
$celula2->colspan = 1;
$celula2->id = 'logomarca';

$linha2 = $tabela->addRow();
$celula1 = $linha2->addCell($texto);
$celula1->colspan = 2;
$celula1->id = 'text';

$linha3 = $tabela->addRow();
$celula1 = $linha3->addCell($rodape);
$celula1->colspan = 2;
$celula1->id = 'footer';

$linha4 = $tabela->addRow();
$celula1 = $linha4->addCell($assinatura);
$celula1->colspan = 2;
$celula1->id = 'ass';

$linha5 = $tabela->addRow();
$celula1 = $linha5->addCell($assinatura_digital);
$celula1->colspan = 2;
$celula1->id = 'digital_ass';
//-----------------

$doc = new TElement("html");

$docTitle = new TElement("title");
$docTitle->add($titulo);

$docStyle = new TElement("style");

$docStyle->add("table {border:4px solid #666; width: 17cm;-moz-border-radius: 8px; -webkit-border-radius: 8px; border-radius: 8px; vertical-align: middle; position:relative;}");
$docStyle->add("#titulo {border-bottom:1px solid #666; background-color: #f9f9f9; text-align: center; font-weight: bolder; font-size: 22px; padding: 5px;}");
$docStyle->add("#logomarca {border-bottom:1px solid #666; background-color: #f9f9f9; text-align: center; font-weight: bolder; padding: 5px;}");
$docStyle->add("td {border:0px solid #999;text-align: left; padding: 2px;}");
$docStyle->add("body {font-family:Arial, Helvetica, sans-serif;font-size: 14px; text-align: center;}");
$docStyle->add("#digital_ass {border-top: #666 solid 1px; color: #c9c9c9; text-align: center; font-size: 11px; font-weight: bolder;}");
$docStyle->add("#text {text-indent: 25px; padding:20px; text-align: justify;}");
$docStyle->add("#ass {padding: 10px; padding-left:25px; padding-bottom: 25px; text-align: left;}");
$docStyle->add("#footer {padding: 10px; padding-left:25px;  text-align: left;}");

$docBody = new TElement("body");

$docBody->add($tabela);

$docHead = new TElement('head');
$docHead->add('<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />');
$docHead->add($docTitle);
$docHead->add($docStyle);

$doc->add($docHead);
$doc->add($docBody);


$doc->show();
?>