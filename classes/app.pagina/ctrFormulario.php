<?php

/*/ Monta formulario \\\
//formulario
$formulario = new TForm('formulario');
	
	//campos
	$campos = new TSetFields();
	$campos->geraCampo('Id do formulário', 'formsequlario', 'TEntry', 'ui-state-default');
	$conteinerCampos = $campos->getConteiner();
	
	$buscar = new TElement('input');
	$buscar->type = 'submit';
	$buscar->name = 'Buscar';

$formulario->add($conteinerCampos);
$formulario->add($buscar);

$page = new TPage('Gerencia formulários');
$page->add($formulario);
$page->show();
*/

include_once('../app.util/TFix.php');

	$formseq = $_POST['formseq'];	
	$fix = new TFix(true);
	
	//print_r($_POST);

if($_POST['buscar']){
	
	$fix->mapeaFormulario($formseq);
}
elseif($_POST['excluirform'] == 'Excluir formulario'){
	
	if($_POST['confirma'] == true){
		
		$conf = true;
	}
		
	$fix->executaExcluir($formseq, $conf);
	
}
?>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Gerencia formulários</title>
</head>
<body id="tpage" class="pageDisp">
<form name="formulario" id="formulario" onsubmit="return " method="post" style="margin:0px;" enctype="application/x-www-form-urlencoded">

<label>seq do formulário</label>
<input type="text" name="formseq" size=20>
<input type="submit" value="Buscar" name="buscar">
<br><br>
<input type="checkbox" value=true name="confirma">Confirmar exclusão?
<input type="submit" value="Excluir formulario" name="excluirform">

</form>
</body>
</html>