<?php

//==========================================================
//
//
//==========================================================
session_start();

$codigoTransacao = $_GET['cod'];
if ($_GET['juros'] != 0 && $_GET['juros'] != null) {
    $juros = $_GET['juros'];
} else {
    $juros = null;
}

function __autoload($classe) {
    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../', $classe);
}

$TSetModel = new TSetModel();

//$dboTransacao = new TDbo('view_transacoes');
//$critTransacao = new TCriteria();
//$critTransacao->add(new TFilter('codigo', '=', $codigoTransacao));
//$retTransacao = $dboTransacao->select('*', $critTransacao);

$TTransacao = new TTransacao();

$obTransacao = $TTransacao->getTransacaoDG($codigoTransacao);

$dboCliente = new TDbo('view_pessoas');
$critCliente = new TCriteria();
$critCliente->add(new TFilter('codigo', '=', $obTransacao->codigocliente));
$retCliente = $dboCliente->select('*', $critCliente);
$obCliente = $retCliente->fetchObject();

$dboItens = new TDbo('view_transacoes_itens');
$critItens = new TCriteria();
$critItens->add(new TFilter('codigotransacao', '=', $obTransacao->codigo));
$retItens = $dboItens->select('*', $critItens);

$obItens = $obTransacao->itens;


$tabela = new TTable();
$tabela->style = "font-family: verdana; font-size: 12px;";
$tabela->border = 0;
$tabela->width = "100%";
$tabela->height = "100%";

$cabecalho = $tabela->addRow();
$col1 = $cabecalho->addCell("PEDIDO: {$codigoTransacao}");
$col1->colspan = 2;
$col1->height = '40px';
$col1->style = "font-size: 22px; font-weight: bolder; text-align: center;";

$infoCabecalho = $tabela->addRow();
$col1 = $infoCabecalho->addCell("Cliente: {$obCliente->nome_razaosocial}");
$col1->height = '20px';
$col2 = $infoCabecalho->addCell(date("d/m/Y h:i:s"));
$col2->height = '20px';
$col2->style = "text-align: right;";

$infoCabecalho = $tabela->addRow();
$col1 = $infoCabecalho->addCell("Endereço: {$obCliente->logradouro} - {$obCliente->bairro} - Cidade: {$obCliente->cidade}/{$obCliente->estado}");
$col1->height = '20px';
$col2 = $infoCabecalho->addCell("CEP: {$obCliente->cep}");
$col2->height = '20px';
$col2->style = "text-align: right;";

$infoCabecalho = $tabela->addRow();
$col1 = $infoCabecalho->addCell("CPF/CNPJ: {$TSetModel->setCpfcnpj($obCliente->cpf_cnpj)} - IE/RG: {$obCliente->rg_inscest}");
$col1->height = '20px';

$fone = ($TSetModel->setTelefone($obCliente->tel1) != null) ?
        $TSetModel->setTelefone($obCliente->tel1) :
                ($TSetModel->setTelefone($obCliente->tel2) != null) ?
                        $TSetModel->setTelefone($obCliente->tel2) :
                                ($TSetModel->setTelefone($obCliente->cel1) != null) ?
                                        $TSetModel->setTelefone($obCliente->cel1) :
                                                $TSetModel->setTelefone($obCliente->cel2);

$col2 = $infoCabecalho->addCell("Fone: {$TSetModel->setTelefone($fone)}");
$col2->height = '20px';
$col2->style = "text-align: right;";

$infoEspaco = $tabela->addRow();
$col1 = $infoEspaco->addCell("");
$col1->height = '20px';
$col1->colspan = "2";

$infoObs = $tabela->addRow();
$obs = $infoObs->addCell("Obs.:{$obTransacao->obs}");
$obs->colspan = "2";
$obs->height = '40px';

$itensPedido = new TTable();
$itensPedido->width = "100%";
$itensPedido->style = 'font-size: 12px;';
$itensCabec = $itensPedido->addRow();

$col = $itensCabec->addCell('CODIGO');
$col->style = "border-bottom: 1px solid #000; font-weight: bolder; font-size: 13px; text-align: center;";

$col = $itensCabec->addCell('MERCADORIA');
$col->style = "border-bottom: 1px solid #000; font-weight: bolder; font-size: 13px; text-align: center;";

$col = $itensCabec->addCell('UN');
$col->style = "border-bottom: 1px solid #000; font-weight: bolder; font-size: 13px; text-align: center;";

$col = $itensCabec->addCell('QUANT');
$col->style = "border-bottom: 1px solid #000; font-weight: bolder; font-size: 13px; text-align: center;";

$col = $itensCabec->addCell('UNITARIO');
$col->style = "border-bottom: 1px solid #000; font-weight: bolder; font-size: 13px; text-align: center;";

$col = $itensCabec->addCell('TOTAL');
$col->style = "border-bottom: 1px solid #000; font-weight: bolder; font-size: 13px; text-align: center;";

if ($juros) {
    $juros = $juros / 100 + 1;
} else {
    $juros = 1;
}

foreach ($obItens as $item) {

    $itensCabec = $itensPedido->addRow();

    $valorunitario = ($item['valorunitario']) * $juros;
    $valortotal = $item['valortotal'];


    $col = $itensCabec->addCell($item['codigoproduto']);
    $col->style = "text-align: center";
    $col = $itensCabec->addCell($item['produto']);
    $col->style = "text-align: left";
    $col = $itensCabec->addCell($item['unidademedida']);
    $col->style = "text-align: center";
    $col = $itensCabec->addCell($item['quantidade']);
    $col->style = "text-align: center";
    $col = $itensCabec->addCell(number_format($valorunitario, 4, ',', ''));
    $col->style = "text-align: right";
    $col = $itensCabec->addCell(number_format($valortotal, 4, ',', ''));
    $col->style = "text-align: right";

    $valorNota = $valorNota + $valortotal;
}

$infoItens = $tabela->addRow();
$col1 = $infoItens->addCell($itensPedido);
$col1->style = "border-bottom: 1px dotted #000; vertical-align: top;";
$col1->colspan = "2";

$infoCabecalho = $tabela->addRow();
$texto = "Total: " . number_format($valorNota, 2, ',', '') . " - Desconto: " . number_format($obTransacao->valordesconto, 2, ',', '');

if ($obTransacao->valorfrete) {
    $texto .= " - Frete:" . number_format($obTransacao->valorfrete, 2, ',', '');
}

$col1 = $infoCabecalho->addCell($texto);
$col1->height = '20px';
$col1->style = "font-weight: bolder; font-size: 12px; text-align: left;";

$col2 = $infoCabecalho->addCell("Final.: " . number_format(($valorNota - $obTransacao->valordesconto + $obTransacao->valorfrete), 2, ',', ''));
$col2->height = '20px';
$col2->width = '30%';
$col2->style = "font-weight: bolder; font-size: 12px; text-align: right;";

$infoItens = $tabela->addRow();
$col1 = $infoItens->addCell("");
$col1->style = "border-bottom: 1px dotted #000;";
$col1->height = '20px';
$col1->colspan = "2";

$infoItens = $tabela->addRow();
$col1 = $infoItens->addCell("Condição: {$obTransacao->codigoformapagamento} - {$obTransacao->condicaopagamento}: {$obTransacao->textocondicaopagamento} ");
$col1->style = "border-bottom: 1px solid #000;";
$col1->height = '20px';
$col1->colspan = "2";

$infoItens = $tabela->addRow();
$col1 = $infoItens->addCell("NÃO É VÁLIDO COMO DOCUMENTO FISCAL<BR/>NÃO É VÁLIDO COMO GARANTIA DE MERCADORIA");
$col1->style = "font-size: 20px; text-align: center";
$col1->height = '50px';
$col1->colspan = "2";

$TPage = new TPage('Pedido');
$TPage->add($tabela);
$TPage->show();
?>