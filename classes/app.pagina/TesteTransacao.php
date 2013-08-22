<html>
<head>
<title>Teste Transação</title>
</head>
<body>
<form name="TesteTransacao" method="post">
<input type="text" id="valor1" name="statdesc"/>
<input type="submit" name="Adicionar" value="Adicionar">
<input type="submit" name="Commit" value="Commit"/>
</form></body></html>


<?php

/*
* run()
* Executa determinado método de acordo com
* os parámetros recebidos
*/
if(!function_exists("__autoload") && !is_callable("__autoload")) {
    function __autoload($classe) {

        include_once('../app.util/autoload.class.php');
        $autoload = new autoload('',$classe);
    }
}


$object = $_POST;

    	// inicia transação com o banco
        //TTransaction::open('../occupant/SCP/app.config/my_dbpetrus');
        
        
echo '....';
//cria objeto para manter no banco
$dbo = new TDbo('dbstatus');



		$dto['id'] = 234;
		$dto['statdesc'] = $_POST['statdesc'];
		$dto['statseq'] = 1;

if($object['Adicionar']){
		
	try{
	
		$retornoSQL = $dbo->insert($dto);
		
		print_r($retornoSQL);
	
		  $criteria = new TCriteria();
		  $criteria->add(new TFilter('statdesc','=',$dto['statdesc']));
		  $retDados = $dbo->select('*',$criteria);
		  $dados = $retDados->fetchObject();
		    
		  print_r($dados);
		  
		  echo '<br><br> ---> Adicionar executado';
	  
	}catch(Exception $e){
		print_r($e);
	}
	
}
elseif($object['Commit']){
	
	    // Commita a trasação
        $dbo->commit();
        
        echo TTransaction::testTransaction();
        
      $criteria = new TCriteria();
	  $criteria->add(new TFilter('statdesc','=',$dto['statdesc']));   
	  $retDados = $dbo->select('*',$criteria);
	  $dados = $retDados->fetchObject();
	  
	  print_r($dados);
	
}

?>