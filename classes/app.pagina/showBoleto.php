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

$seqconta   = $_GET['cod'];
$origem     = $_GET['or'];
$tipoBoleto = $_GET['tipo'];

include_once('../app.model/TSetBoleto.class.php');

if(!$seqconta) {
    exit('conta crédito não definido para o boleto');
}

//===========================================================================================


$TSetModel = new TSetModel();

$criteriaConta = new TCriteria();
$criteriaConta->add(new TFilter(TConstantes::SEQUENCIAL,'=',$seqconta));
$criteriaConta->add(new TFilter('tipo','=','C'));
$dboConta = new TDbo(TConstantes::DBPARCELA);
$retConta = $dboConta->select("*", $criteriaConta);
$obConta = $retConta->fetchObject();

$dboTransacao = new TDbo(TConstantes::DBTRANSACAO);
$criteriaTransacao = new TCriteria();
$criteriaTransacao->add(new TFilter(TConstantes::SEQUENCIAL,'=',$obConta->transeq));
$retTransacao = $dboTransacao->select("numparcelas,pessseq", $criteriaTransacao);
$obTransacao = $retTransacao->fetchObject();

$dboTransacaoContas = new TDbo(TConstantes::DBPARCELA);
$criteriaTransacaoContas = new TCriteria();
$criteriaTransacaoContas->add(new TFilter('transeq','=',$obConta->transeq));
$criteriaTransacaoContas->setProperty('order','vencimento desc');
$retTransacaoContas = $dboTransacaoContas->select("*", $criteriaTransacaoContas);

while($obContas = $retTransacaoContas->fetch()){
        switch($obContas['stpaseq']){
            case '1': $situacao = 'Vencida';break;
            case '2': $situacao = 'Paga';break;
            case '3': $situacao = 'Parcialmente Paga';break;
        
        }

        if(($obContas['stpaseq'] == '3' ) || ($obContas['stpaseq'] == '2' ) || ($obContas['stpaseq'] == '1' && $obContas['vencimento'] < date('Y-m-d'))){

            $arrayContas[$obContas[TConstantes::SEQUENCIAL]][TConstantes::SEQUENCIAL] = $obContas[TConstantes::SEQUENCIAL];
             $arrayContas[$obContas[TConstantes::SEQUENCIAL]]['situacao'] = $situacao;
              $arrayContas[$obContas[TConstantes::SEQUENCIAL]]['valornominal'] = $TSetModel->setValorMonetario($obContas['valorinicial']);
               $arrayContas[$obContas[TConstantes::SEQUENCIAL]]['vencimento'] = $TSetModel->setDataPT($obContas['vencimento']);
                $arrayContas[$obContas[TConstantes::SEQUENCIAL]]['valorpago'] = $TSetModel->setValorMonetario($obContas['valorinicial'] - $obContas['valoratual']);

        }

    }

$pessoa =  new TDbo(TConstantes::VIEW_PESSOA);
$criteriapessoa = new TCriteria();
$criteriapessoa->add(new TFilter(TConstantes::SEQUENCIAL,'=',$obTransacao->pessseq));
$retPessoa = $pessoa->select("*", $criteriapessoa);
$obCliente = $retPessoa->fetchObject();

//valida se o boleto já foi emitido
$criteriaCkBoleto = new TCriteria();
$criteriaCkBoleto->add(new TFilter('parcseq','=',$obConta->seq));
$criteriaCkBoleto->add(new TFilter('stboseq','!=',9));
$dboCkBoleto = new TDbo(TConstantes::DBBOLETO);
$retCkBoleto = $dboCkBoleto->select(array("seq","bkp"), $criteriaCkBoleto);
$obCkBoleto= $retCkBoleto->fetchObject();


if($obCkBoleto->seq != "" && $obCkBoleto->bkp != "") {
    echo "<div style='font-size: 9px; text-align: center; font-family: sans-serif; border-bottom: 1px dotted #666; COLOR: #666; width: 666px'>REIMPRESSÃO</div>";
    echo $obCkBoleto->bkp;
    exit();
}

    $criteriaTransacAluno = new TCriteria();
    $criteriaTransacAluno->add(new TFilter('pessseq','=',$obCliente->seq));
    $dboTransacAluno = new TDbo(TConstantes::VIEW_ALUNO);
    $criteriaTransacAluno->setProperty('limit','1'); 
    $retTransacAluno = $dboTransacAluno->select("seq,nometurma", $criteriaTransacAluno);
    $obTransacAluno = $retTransacAluno->fetchObject();
    
    $dboEndereco = new TDbo(TConstantes::DBENDERECO);
    $criteriaEndereco = new TCriteria();
    $criteriaEndereco->add(new TFilter('pessseq','=',$obCliente->seq));
    $obEndereco = $dboEndereco->select('*',$criteriaEndereco)->fetchObject();

if($obEndereco) {

    $dadosSacado[0] = $obCliente->pessnmrz . " (Turma: {$obTransacAluno->nometurma} / Matricula : {$obTransacAluno->seq}) CPF:";
    $dadosSacado['pessseq'] = $obCliente->seq;
    $dadosSacado['parcseq'] = $seqconta;
    $dadosSacado[1] = $obEndereco->endereco." ".$obEndereco->complemento.", ".$obEndereco->bairro."; " .$obEndereco->cidade."-".$obEndereco->estado." Cep:".$obEndereco->cep;
    $dadosSacado[2] = "";
    $dadosSacado[3] = $obCliente->pessnmrf;
}


//objeto Boleto
$obBl = new TSetBoleto($obConta->seq);
$obBl->setSacado($dadosSacado);
$obBl->setValor($obConta->valorinicial);

$mora = "Após o Vencimento, multa de 2% + Mora dia de ". $TSetModel->setValorMonetario((($obConta->valorinicial * (1/100)) / 30));
$obBl->setInstrucoes($mora,2);

$TTransacao = new TTransacao();
$obBl->setInstrucoes($TTransacao->getTextoConvenios($obConta->seq),1);
if(count($arrayContas) > 1) $obBl->setDetalhamento($arrayContas);

$parc .= "Parcela: {$obConta->numero}/{$obTransacao->numparcelas}";


$obBl->setInformacaoFatura("Fatura resferente à transação nº {$obConta->seqtransacao}. <br/> Conta nº {$obConta->seq}");
$obBl->setInstrucoesParcelamento ($parc);
$obBl->setVencimento($obConta->vencimento);


//============================================================================================	

if($dadosSacado) {
    $obBl->showBoleto();
    $obBl->load('Inscricao');

}else {
    echo 'ERRO - O Sacado não fui encontrado.';
    exit();
}
?>