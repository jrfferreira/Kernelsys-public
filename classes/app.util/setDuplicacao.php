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

if($cods['codatual'] != "" and $cods['codant'] != "" and $cods['ridform']){

		$obsession = new TSession();
		$dadosAutor = $obsession->getValue('statusFormEdition'); // retorna o tipo do form que esta em aberto
		
		
		//echo $cods['codatual'].$statusEdition.$cods['entity'];
		$gDados = new TDados($cods['codatual'], 'form', $cods['entity']);
		$gDados->delete();

        //seta novo valor do codigo para retornar o formularios
        $obsession->setValue('codigoatual'.$cods['ridform'], $cods['codant']);

        $param['tipo']    = "form";
        $param['autor']   = "listaFuncionarios";
        $param['idForm'] = $cods['ridform'];
        $param['key']     = $cods['codant'];

        $executor = new TExecs($param);
        $executor->onEdit();
		//header('Location: ../app.view/TExecs.class.php?method=onEdit()&iidForm='.$cods['ridform']);
}