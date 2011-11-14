<script>
function goForm(ob){
	document.formImp.submit();
}
</script>

<?php
//=====================================================
// Efetiva matricula
//
//=====================================================

function __autoload($classe){

    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}
	//Retorna Usuario logado===================================
	//$obUser = new TCheckLogin();
	//$obUser = $obUser->getUser();
	//=========================================================	

$param = $_GET;

$dados = $_POST;

//if($param['rcod']){

	TTransaction::open('../'.TOccupant::getPath().'app.config/my_dbpetrus');
	if($conn = TTransaction::get()){
	
		//campo file
		$obfile = new TFile('arqImp');

		// lista base de dados		
		$selBDados = new TCombo('baseDados');
			$itens['0'] = "Selecione a base de dados";
			$itens['dbpessoas'] = "Clientes";
			$itens['dbpessoas'] = "Fornecedores";
		$selBDados->addItems($itens);
		$selBDados->onchange = "goForm(this)";
		
		$form = new TElement('form');
		$form->method = "POST";
		$form->action = "";
		$form->name = "formImp";
		
		$form->add($selBDados);
				
		//========================================================
		//lista as colunas da base de dados selecionada
		if($dados['baseDados'] != ""){
	
			$getCols = "show Columns from ".$dados['baseDados'];
			$runCols = $conn->Query($getCols);
			
			while($retCols = $runCols->fetchObject()){
				$cols[$retCols->Field] =  $retCols->Field;
			}
			
			$selCol = new TCombo('listCol');
			$selCol->class = "";
			$selCol->multiple="multiple";
			$selCol->addItems($cols);
			
			$form->add($selCol);		
		}
		
		//mostrao form		
		$form->show();
							
		TTransaction::close();		
	}
//}
?>
