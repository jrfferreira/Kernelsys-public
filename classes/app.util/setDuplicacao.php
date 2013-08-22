<?php
//======================================================================
//
//
//======================================================================

function __autoload($classe){

    include_once('autoload.class.php');
    $autoload = new autoload('../',$classe);
}

		//Retorna Usuario logado===================================
		$obUser = new TCheckLogin();
		$obUser = $obUser->getUser();
		//=========================================================	

$cods = $_POST;

if($cods['codatual'] != "" and $cods['codant'] != "" and $cods['rformseq']){

		$obsession = new TSession();
		$dadosAutor = $obsession->getValue(TConstantes::STATUS_EDITIONFORM); // retorna o tipo do form que esta em aberto
		
		
		//echo $cods['codatual'].$statusEdition.$cods['entity'];
		$gDados = new TDados($cods['codatual'], 'form', $cods['entity']);
		$gDados->delete();

        //seta novo valor do seqpara retornar o formularios
        $obsession->setValue('seqatual'.$cods['rformseq'], $cods['codant']);

        $param['tipo']    = "form";
        $param['autor']   = "listaFuncionarios";
        $param[TConstantes::FORM] = $cods['rformseq'];
        $param['key']     = $cods['codant'];

        $executor = new TMain($param);
        $executor->onEdit();
		//header('Location: ../app.view/TMain.class.php?method=onEdit()&iformseq='.$cods['rformseq']);
}