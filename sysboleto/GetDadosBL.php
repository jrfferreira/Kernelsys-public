<?php
// get dados do boleto gerado \\

function __autoload($classe){
	if(file_exists("../classes/{$classe}.php"))
	{
	 	include_once("../classes/{$classe}.php");
	}
  	elseif (file_exists("../classes/html/{$classe}.php"))
    {
        include_once("../classes/html/{$classe}.php");
    }
	elseif (file_exists("../classes/app.int/{$classe}.php"))
    {
      	include_once("../classes/app.int/{$classe}.php");
    }
	elseif (file_exists("../classes/app.int/{$classe}.class.php"))
    {
        include_once("../classes/app.int/{$classe}.class.php");
    }
	elseif (file_exists("../classes/app.sql/{$classe}.php"))
    {
        include_once("../classes/app.sql/{$classe}.php");
    }
}

	// registra boleto na base de dados
	$ObInsert = new TInsert("regboleto");
	
	$ObInsert->sacado = $dadosboleto["sacado"];
	$ObInsert->docsacado = $dadosboleto["pessnmrf_sacado"];
	$ObInsert->lndigitavel = $dadosboleto["linha_digitavel"];
	$ObInsert->nossonumero = $dadosboleto["nosso_numero"];
	$ObInsert->numerodoc = $dadosboleto["numero_documento"];
	$ObInsert->dataprocessamento = $dadosboleto["data_processamento"];
	$ObInsert->datavencimento = $dadosboleto["data_vencimento"];
	$ObInsert->valordoc = $dadosboleto["valor_boleto"];
	$ObInsert->taxaboleto = $taxa_boleto;
	
	$ObInsert->ExeInsert();
	
	// atualiza dados no aquivo de dados dinamicos do boleto
	$GetDAtual = file("dados/ddataBl.txt",FILE_IGNORE_NEW_LINES);
	
	$ObIn=new TArqtxt("dados/ddataBL.txt");
	$ObIn->lipFile();

	// informações fixas do boleto
	$ObIn->addLine($GetDAtual[0]);
	$ObIn->addLine($GetDAtual[1]);
	$ObIn->addLine($GetDAtual[2]);
	$ObIn->addLine($GetDAtual[3]);
	//======================================
	$ObIn->addLine($GetDAtual[4]);
	//======================================
	$ObIn->addLine($dadosboleto["linha_digitavel"]);
	$ObIn->addLine($dadosboleto["nosso_numero"]);
	$ObIn->addLine($dadosboleto["data_vencimento"]);
	$ObIn->addLine($dadosboleto["valor_boleto"]);
	$ObIn->addLine($GetDAtual[10]);
	$ObIn->addLine($dadosboleto["data_processamento"]);
	$ObIn->addLine($dadosboleto["numero_documento"]);

?>