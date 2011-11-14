<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Informações do boleto bancario</title>

<style>
.geral{
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-size:12px;
	border:1px solid #CCCCCC;
	padding:3px;
}

.OkMsg{
	margin:40px;
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-size:16px;
	border:1px solid #6699FF;
	text-align:center;
	padding:10px;
}

</style>
</head>

<body>
<form name="dadosboletoCEF" id="dadosboletoCEF" action="" method="post">

<?php
/*
cadastro de noticias
*/

function __autoload($classe){
	if(file_exists("../../classes/{$classe}.php"))
	{
	 	include_once("../../classes/{$classe}.php");
	}
  	elseif (file_exists("../../classes/html/{$classe}.php"))
    {
        include_once("../../classes/html/{$classe}.php");
    }
	elseif (file_exists("../../classes/app.int/{$classe}.php"))
    {
      	include_once("../../classes/app.int/{$classe}.php");
    }
	elseif (file_exists("../../classes/app.int/{$classe}.class.php"))
    {
        include_once("../../classes/app.int/{$classe}.class.php");
    }
	elseif (file_exists("../../classes/app.sql/{$classe}.php"))
    {
        include_once("../../classes/app.sql/{$classe}.php");
    }
}

if($_POST['salvar']!=""){
	// ---------------------- DADOS FIXOS DE CONFIGURAção DO SEU BOLETO --------------- //
	// DADOS DA SUA CONTA - CEF
	$agencia = $_POST['agencia']; // Num da agencia, sem digito
	$conta_cedente = $_POST['conta_cedente']; // ContaCedente do Cliente, sem digito (Somente N�meros)
	$conta_cedente_dv = $_POST['conta_cedente_dv']; // Digito da ContaCedente do Cliente
	$carteira = $_POST['carteira']; // código da Carteira: pode ser SR (Sem Registro) ou CR (Com Registro) - (Confirmar com gerente qual usar)
	
	// SEUS DADOS
	$identificacao = $_POST['identificacao'];
	$cpf_cnpj = $_POST['cpf_cnpj'];
	$endereco = $_POST['endereco'];
	$cidade_uf  = $_POST['cidade'];
	$cedente = $_POST['cedente'];
	$taxa_boleto = $_POST['taxa_boleto'];
	$especie = $_POST['especie'];
	// DADOS DE CONFIGURAção DO BOLETO PARA O SEU CLIENTE
	$dias_de_prazo_para_pagamento = $_POST['dias_de_prazo_para_pagamento'];
	//===============================\\
	
	// INSTRUções PARA O CAIXA
	$instrucoes1 = $_POST['instrucoes1'];
	$instrucoes2 = $_POST['instrucoes2'];
	$instrucoes3 = $_POST['instrucoes3'];
	$instrucoes4 = $_POST['instrucoes4'];
	
	// INFORMACOES PARA O CLIENTE
	$demonstrativo1 = $_POST['demonstrativo1'];
	$demonstrativo2 = $_POST['demonstrativo2'];
	
	echo '<div class="OkMsg">cadastrada com sucesso.</div>';
	
}else{
	$InfoBl= file("../dados/dataBL.txt",FILE_IGNORE_NEW_LINES);
	
	// ---------------------- DADOS FIXOS DE CONFIGURAção DO SEU BOLETO --------------- //
	// DADOS DA SUA CONTA - CEF
	$agencia = $InfoBl[0]; // Num da agencia, sem digito
	// DADOS PERSONALIZADOS - CEF
	$conta_cedente = $InfoBl[1]; // ContaCedente do Cliente, sem digito (Somente N�meros)
	$conta_cedente_dv = $InfoBl[2]; // Digito da ContaCedente do Cliente
	$carteira = $InfoBl[3]; // código da Carteira: pode ser SR (Sem Registro) ou CR (Com Registro) - (Confirmar com gerente qual usar)
	
	// SEUS DADOS
	$identificacao = $InfoBl[4];
	$cpf_cnpj = $InfoBl[5];
	$endereco = $InfoBl[6];
	$cidade_uf  = $InfoBl[7];
	$cedente = $InfoBl[8];
	$taxa_boleto = $InfoBl[9];
	$especie = $InfoBl[10];
	// DADOS DE CONFIGURAção DO BOLETO PARA O SEU CLIENTE
	$dias_de_prazo_para_pagamento = $InfoBl[11];
	//===============================\\
		
	// INSTRUções PARA O CAIXA
	$instrucoes1 = $InfoBl[12];
	$instrucoes2 = $InfoBl[13];
	$instrucoes3 = $InfoBl[14];
	$instrucoes4 = $InfoBl[15];
	
	// INFORMACOES PARA O CLIENTE
	$demonstrativo2 = $InfoBl[16];
	$demonstrativo3 = $InfoBl[17];
}

?>

<table width="700" border="0" align="center" cellpadding="2" cellspacing="2" class="geral">
  <tr>
    <td colspan="2" style="background-color:#E9E9E9;">
	Dados bancarios do cedente</td>
    </tr>
  <tr>
    <td width="36%" align="right">N&uacute;mero da agencia: </td>
    <td width="64%">
	<input type="text" name="agencia" id="agencia" size="10" value="<?php echo $agencia;?>" maxlength="4"></td>
  </tr>
  <tr>
    <td colspan="2" align="right" style="background-color:#E9E9E9;"></td>
    </tr>
  <tr>
    <td align="right">Conta do Cedente :</td>
    <td><input type="text" name="conta_cedente" id="conta_cedente" size="15"  value="<?php echo $conta_cedente;?>" maxlength="11">
      Digito
      <input type="text" name="conta_cedente_dv" id="conta_cedente_dv" size="1" value="<?php echo $conta_cedente_dv;?>" maxlength="1"></td>
  </tr>
  <tr>
    <td align="right">Tipo de Carteira:</td>
    <td>
	<select name="carteira" id="carteira">
		<option value="01">Com Registro</option>
		<option value="00">Sem Registro</option>
    </select>	</td>
  </tr>
  <tr>
    <td colspan="2" style="background-color:#E9E9E9;">
      Dados do Fixo do cedente</td>
    </tr>
  <tr>
    <td align="right">Identifica&ccedil;&atilde;o do Cedente </td>
    <td><input type="text" name="identificacao" id="identificacao" size="50"  value="<?php echo $identificacao;?>" maxlength="80"></td>
  </tr>
  <tr>
    <td align="right">Cedente: </td>
    <td><input type="text" name="cedente" id="cedente" size="50"  value="<?php echo $cedente;?>" maxlength="80"></td>
  </tr>
  <tr>
    <td align="right">CPF/CNPJ do Cedente </td>
    <td><input type="text" name="cpf_cnpj" id="cpf_cnpj" size="18"  value="<?php echo $cpf_cnpj;?>" maxlength="20"></td>
  </tr>
  <tr>
    <td align="right">Endere&ccedil;o do Cedente </td>
    <td><input type="text" name="endereco" id="endereco" size="50"  value="<?php echo $endereco;?>" maxlength="80"></td>
  </tr>
  <tr>
    <td align="right">Cidade - UF </td>
    <td><input type="text" name="cidade" id="cidade" size="30"  value="<?php echo $cidade_uf;?>" maxlength="60"></td>
  </tr>
  <tr>
    <td align="right"> Taxa do Boleto:</td>
    <td><input type="text" name="taxa_boleto" id="taxa_boleto" size="60"  value="<?php echo $taxa_boleto;?>" maxlength="80"></td>
  </tr>
  <tr>
    <td align="right">Especie (Moeda): </td>
    <td><input type="text" name="especie" id="especie" size="4"  value="<?php echo $especie;?>" maxlength="3"></td>
  </tr>
  <tr>
    <td align="right">Prazo para pagamento:</td>
    <td><input type="text" name="dias_de_prazo_para_pagamento" id="dias_de_prazo_para_pagamento" size="4"  value="<?php echo $dias_de_prazo_para_pagamento;?>" maxlength="3"></td>
  </tr>
  <tr>
    <td colspan="2" style="background-color:#E9E9E9;">Instru&ccedil;&otilde;es para o caixa </td>
    </tr>
  <tr>
    <td align="right">Instru&ccedil;&otilde;es: linha 1: </td>
    <td><input type="text" name="instrucoes1" id="instrucoes1" size="60"  value="<?php echo $instrucoes1;?>" maxlength="80"></td>
  </tr>
  <tr>
    <td align="right">Instru&ccedil;&otilde;es: linha 2:</td>
    <td><input type="text" name="instrucoes2" id="instrucoes2" size="60"  value="<?php echo $instrucoes2;?>" maxlength="80"></td>
  </tr>
  <tr>
    <td align="right">Instru&ccedil;&otilde;es: linha 3:</td>
    <td><input type="text" name="instrucoes3" id="instrucoes3" size="60"  value="<?php echo $instrucoes3;?>" maxlength="80"></td>
  </tr>
  <tr>
    <td align="right">Instru&ccedil;&otilde;es: linha 4:</td>
    <td><input type="text" name="instrucoes4" id="instrucoes4" size="60"  value="<?php echo $instrucoes4;?>" maxlength="80"></td>
  </tr>
  <tr>
    <td colspan="2" style="background-color:#E9E9E9;">Instru&ccedil;&otilde;es para o cliente </td>
    </tr>
	  <tr>
    <td align="right">Instru&ccedil;&otilde;es: linha 1: </td>
    <td><input type="text" name="demonstrativo1" id="demonstrativo1" size="60"  value="<?php echo $demonstrativo1;?>" maxlength="80"></td>
  </tr>
  <tr>
    <td align="right">Instru&ccedil;&otilde;es: linha 2:</td>
    <td><input type="text" name="demonstrativo2" id="demonstrativo2" size="60"  value="<?php echo $demonstrativo2;?>" maxlength="80"></td>
  </tr>
  <tr>
    <td colspan="2" align="center">
	<hr><input type="submit" name="salvar" value="salvar not�cia"></hr></td>
  </tr>
</table>
</form>
</body>
</html>
<?php
if($_POST['salvar']!=""){
	
	$ObIn=new TArqtxt("../dados/dataBL.txt");
	$ObIn->lipFile();
	
	// informações fixas do boleto
	$ObIn->addLine($agencia);

	$ObIn->addLine($conta_cedente);
	$ObIn->addLine($conta_cedente_dv);
	$ObIn->addLine($carteira);
	
	$ObIn->addLine($identificacao);
	$ObIn->addLine($cpf_cnpj);
	$ObIn->addLine($endereco);
	$ObIn->addLine($cidade_uf);
	$ObIn->addLine($cedente);
	$ObIn->addLine($taxa_boleto);
	$ObIn->addLine($especie);
	$ObIn->addLine($dias_de_prazo_para_pagamento);
	//====================================
	$ObIn->addLine($instrucoes1);
	$ObIn->addLine($instrucoes2);
	$ObIn->addLine($instrucoes3);
	$ObIn->addLine($instrucoes4);
	
	$ObIn->addLine($demonstrativo1);
	$ObIn->addLine($demonstrativo2);
}
?>
