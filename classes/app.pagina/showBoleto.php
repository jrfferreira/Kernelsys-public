<?php
//==========================================================
// Gera boleto de inscrição
//
//==========================================================
session_start();
error_reporting(0);

function __autoload($classe) {

    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}
//Retorna Usuario logado===================================

     $obUser = new TCheckLogin();
     $obUser = $obUser->getUser();
//=========================================================	

$codigoconta   = $_GET['cod'];
$origem     = $_GET['or'];
$tipoBoleto = $_GET['tipo'];

include_once('../app.model/TSetBoleto.class.php');

if(!$codigoconta) {
    exit('conta crédito não definido para o boleto');
}

//===========================================================================================


$TSetModel = new TSetModel();

$criteriaConta = new TCriteria();
$criteriaConta->add(new TFilter('codigo','=',$codigoconta));
$criteriaConta->add(new TFilter('tipomovimentacao','=','C'));
$dboConta = new TDbo(TConstantes::DBTRANSACOES_CONTAS);
$retConta = $dboConta->select("*", $criteriaConta);
$obConta = $retConta->fetchObject();

$dboTransacao = new TDbo(TConstantes::DBTRANSACOES);
$criteriaTransacao = new TCriteria();
$criteriaTransacao->add(new TFilter('codigo','=',$obConta->codigotransacao));
$retTransacao = $dboTransacao->select("numparcelas", $criteriaTransacao);
$obTransacao = $retTransacao->fetchObject();

$dboTransacaoContas = new TDbo(TConstantes::DBTRANSACOES_CONTAS);
$criteriaTransacaoContas = new TCriteria();
$criteriaTransacaoContas->add(new TFilter('codigotransacao','=',$obConta->codigotransacao));
$criteriaTransacaoContas->add(new TFilter('statusconta','<','4'),'OR');
$criteriaTransacaoContas->setProperty('order','vencimento desc');
$retTransacaoContas = $dboTransacaoContas->select("*", $criteriaTransacaoContas);

while($obContas = $retTransacaoContas->fetch()){
        switch($obContas['statusconta']){
            case '1': $situacao = 'Vencida';break;
            case '2': $situacao = 'Paga';break;
            case '3': $situacao = 'Parcialmente Paga';break;
        
        }

        if(($obContas['statusconta'] == '3' ) || ($obContas['statusconta'] == '2' ) || ($obContas['statusconta'] == '1' && $obContas['vencimento'] < date('Y-m-d'))){

            $arrayContas[$obContas['codigo']]['codigo'] = $obContas['codigo'];
             $arrayContas[$obContas['codigo']]['situacao'] = $situacao;
              $arrayContas[$obContas['codigo']]['valornominal'] = $TSetModel->setValorMonetario($obContas['valornominal']);
               $arrayContas[$obContas['codigo']]['vencimento'] = $TSetModel->setDataPT($obContas['vencimento']);
                $arrayContas[$obContas['codigo']]['valorpago'] = $TSetModel->setValorMonetario($obContas['valornominal'] - $obContas['valorreal']);

        }

    }

$pessoa =  new TDbo(TConstantes::DBPESSOAS);
$criteriapessoa = new TCriteria();
$criteriapessoa->add(new TFilter('codigo','=',$obConta->codigopessoa));
$retPessoa = $pessoa->select("*", $criteriapessoa);
$obCliente = $retPessoa->fetchObject();

//valida se o boleto já foi emitido
$criteriaCkBoleto = new TCriteria();
$criteriaCkBoleto->add(new TFilter('codigoconta','=',$obConta->codigo));
$dboCkBoleto = new TDbo(TConstantes::DBTRANSACOES_CONTAS_DUPLICATAS);
$retCkBoleto = $dboCkBoleto->select(array("codigo"=>"codigo", "bkp"=>"bkp"), $criteriaCkBoleto);
$obCkBoleto= $retCkBoleto->fetchObject();

/**
if($obCkBoleto->codigo != "") {
    echo "<div style='font-size: 9px; text-align: center; font-family: sans-serif; border-bottom: 1px dotted #666; COLOR: #666; width: 666px'>REIMPRESSÃO</div>";
    echo $obCkBoleto->bkp;
    exit();
}
*/

    $criteriaTransacAluno = new TCriteria();
    $criteriaTransacAluno->add(new TFilter('codigopessoa','=',$obCliente->codigo));
    $dboTransacAluno = new TDbo(TConstantes::VIEW_PESSOAS_ALUNOS);
    $criteriaTransacAluno->setProperty('limit','1'); 
    $retTransacAluno = $dboTransacAluno->select("codigo,nometurma", $criteriaTransacAluno);
    $obTransacAluno = $retTransacAluno->fetchObject();

if($obCliente->opcobranca == '1') {

    $dadosSacado[0] = $obCliente->nome_razaosocial . " (Turma: {$obTransacAluno->nometurma} / Matricula : {$obTransacAluno->codigo}) CPF:";
    $dadosSacado['codigopessoa'] = $obCliente->codigo;
    $dadosSacado['codigoconta'] = $codigoconta;
    $dadosSacado[1] = $obCliente->logradouro.", ".$obCliente->bairro."; " .$obCliente->cidade."-".$obCliente->estado." Cep:".$obCliente->cep;
    $dadosSacado[2] = "";
    $dadosSacado[3] = $obCliente->cpf_cnpj;
}
else {
    
    // Retorna informações da opção de cobrança
        $criteriaCob = new TCriteria();
        $criteriaCob->add(new TFilter('codigo','=',$obCliente->opcobranca));
    $dboCob = new TDbo(TConstantes::DBPESSOAS_ENDERECOSCOBRANCAS);
    $retCob = $dboCob->select("*", $criteriaCob);
    $obCob= $retCob->fetchObject();

    $dadosSacado[0] = $obCob->nomecobranca . " (Turma: {$obTransacAluno->nometurma} / Matricula : {$obTransacAluno->codigo})";
    $dadosSacado['codigopessoa'] = $obCliente->codigo;
    $dadosSacado[1] = $obCob->logradourocobranca." ".$obCob->cidadecobranca."-".$obCob->estadocobranca ." Cep:".$obCliente->cep;
    $dadosSacado[2] = "";
    $dadosSacado[3] = $obCob->cpf_cnpjcobranca;

}


//objeto Boleto
$obBl = new TSetBoleto();
$obBl->setSacado($dadosSacado);
$obBl->setValor($obConta->valornominal);

$mora = "Após o Vencimento, multa de 2% + Mora dia de ". $TSetModel->setValorMonetario((($obConta->valornominal * (1/100)) / 30));
$obBl->setInstrucoes($mora,2);

$TTransacao = new TTransacao();
$obBl->setInstrucoes($TTransacao->getTextoConvenios($obConta->codigo),1);
if(count($arrayContas) > 1) $obBl->setDetalhamento($arrayContas);

$parc .= "Parcela: {$obConta->numparcela}/{$obTransacao->numparcelas}";


$obBl->setInformacaoFatura("Fatura resferente à transação nº {$obConta->codigotransacao}. <br/> Conta nº {$obConta->codigo}");
$obBl->setInstrucoesParcelamento ($parc);
$obBl->setVencimento($obConta->vencimento);


//============================================================================================	

if($dadosSacado) {
/*
include ('html2pdf.php');
$pdf = new createPDF($obBl->showBoleto(),'Boleto');
$pdf->http = '../';
$pdf->directory= "../".TOccupant::getPath()."app.tmp/";
$pdf->delete=10;
$pdf->useiconv=false;
$pdf->run();
*/
    $obBl->showBoleto();
    $obBl->load('Inscricao');

}else {
    echo 'ERRO - O Sacado não fui encontrado.';
    exit();
}
?>