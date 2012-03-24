<?php
session_start();

function __autoload($classe) {

    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}
//Retorna Usuario logado===================================

     $obUser = new TCheckLogin();
     $obUser = $obUser->getUser();
//=========================================================	
     
/*
 * select codigopessoa,codigoturma from view_pessoas_alunos t1 where t1.codigopessoa not in (select codigopessoa from dbtransacoes) order by codigoturma
 */
$TDbo = new TDbo(TConstantes::DBPESSOAS_ALUNOS);
$crit = new TCriteria();
$crit->add(new TFilter("codigopessoa","not in", "(select codigopessoa from dbtransacoes)"));
$retAlunos = $TDbo->select("*",$crit);

while ($ob = $retAlunos->fetchObject()){
	$a[] = $ob;
}

foreach($a as $obAluno){

	$obCurso = new TCurso();
	$curso = $obCurso->getCurso($obAluno->codigocurso);

	$obTurma = new TTurma();
	$turma  = $obTurma->getTurma($obAluno->codigoturma);
	$descontos = $obTurma->getTurmaDescontos($obAluno->codigoturma);
	$convenios = $obTurma->getTurmaConvenios($obAluno->codigoturma);
	
	//compões instroções de pagamento da conta =====================
	if(is_array($descontos)){
		foreach($descontos as $desc){
			if($desc->tipodesconto == '1'){
				$valorDesconto = $desc->valordescontado."%";
			}else{
				$model = new TSetModel();
				$valorDesconto = $model->setValorMonetario($desc->valordescontado);
			}
			$infoDescontos .= "Pagamento até o dia ".$desc->dialimite.", desconto não acumulado de ".$valorDesconto." <br>";
		}
	}
	//==============================================================

	//=========================================================
	// Gera contas na transação da turma

	$vetorData = explode('-', "2011-01-31");
	$dataFixa = $vetorData[2];


	$trasacao = new TTransacao();

	
	$trasacao->setPessoa($obAluno->codigopessoa);
	$trasacao->setVencimento("2011-01-31");
	$trasacao->setInstrincoesPagamento($infoDescontos);

	if($turma->padraovencimento == '1'){
		$trasacao->setPadraoVencimento();
	}
	$TUnidade = new TUnidade();
	$matricula_independente = $TUnidade->getParametro('matricula_independente');
	
	//configura transação da matrícula
		$trasacao->setValorNominal($turma->valortotal);
		$trasacao->setTipoMovimento('C');
		$trasacao->setDesconto($turma->valordescontado, "2");
		$trasacao->setAcrescimo('0.00');
		$trasacao->setParcelas($turma->numparcelas);
		$trasacao->setPlanoConta($turma->codigoplanoconta);
		
		$codigotransacao = $trasacao->run($turma->numparcelas);
	
	//=================================================================

	 
	echo "Transação {$codigotransacao} gerada com sucesso:<BR/> Valor: {$turma->valortotal}<br/>Aluno: {$obAluno->codigopessoa}<br/><br/><br/>";
	 

}