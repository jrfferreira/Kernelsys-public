<?php
/*function __autoload($classe) {
    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}*/

if($_POST['logar'] != ""){
        if($_GET['occupant']) {
            $_POST['occupant'] = $_GET['occupant'];
        }
	include_once('../app.access/TSetlogin.class.php');	
	$obLog = new TSetlogin($_POST);
}
?>

<html>
<head>
<link rel="shortcut icon" href="favicon.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Sistema Integrado - bitUP</title>
<style>
a {color: #666; text-decoration: none; font-weight: bolder;text-shadow: #999 0px 0px 1px;}
a :hover {color: #999;; text-decoration: none; font-weight: bolder;text-shadow: #999 0px 0px 1px;}
a :visited {color: #444; text-decoration: none; font-weight: bolder;text-shadow: #999 0px 0px 1px;}
#autenticar {padding:5px; border: 1px solid #ccc; -moz-border-radius: 5px; -webkit-border-radius: 5px; border-radius: 5px; color: #666; background-color: #f0f0f0; text-shadow: 1px 1px 0px #FFF;}
#autenticar:hover {padding:5px; border: 1px solid #ccc; -moz-border-radius: 5px; -webkit-border-radius: 5px; border-radius: 5px; color: #333; background-color: #e3e3e3; text-shadow: 1px 1px 0px #FFF;}
.tabela{
 margin-top: 10%;
 text-align:center;
 font-family:Verdana, Arial, Helvetica, sans-serif;
 font-size:12px;
 width:360px;
 height:220px;
 background-image:url(app.images/dashLogin.png);
 background-position: 10px 10px;
 background-repeat:no-repeat;
}
#retorno{
	text-align:center; 
	font-family:Verdana, Arial, Helvetica, sans-serif; 
	font-size:18px; 
	color:#000;
	text-shadow: #333333 0px 0px 1px; 
	padding:20px;
}
#gerOption{
	text-align:center; 
	font-family:Verdana, Arial, Helvetica, sans-serif; 
	font-size:13px; 
	color:#000;
	text-shadow: #333333 0px 0px 1px; 
	padding:20px;
}
#options{
	text-align:center; 
	font-family:Verdana, Arial, Helvetica, sans-serif; 
	font-size:10px;
	color:#666;
	text-shadow: 1px 1px 0px #FFF;
        -moz-border-radius: 4px;
        -webkit-border-radius: 4px;
        border-radius: 4px;
        border: thin #999;
        width: 300px;
        height: 20px;
        position: relative;
        left: 50%;
        margin-left: -150px;

}	
</style>

</head>
<body onload="document.getElementById('usuario').focus();" style="margin:0px; background-image:url(app.images/texture.jpg); overflow:hidden;">
    <div><!-- <div style="background:url(app.images/icone_educacional.png) center no-repeat;"> !-->
<form action="" method="POST" name="sistema" id="sistema" style="margin:2px; ">
<table class="tabela" width="50%" border="0" align="center" cellpadding="2" cellspacing="2">
    
    <tr>
      <td height="51" colspan="2"><p>&nbsp;</p></td>
    </tr>
    <tr>
      <td width="116" height="19" align="right" style="font-weight: bold; color: #f0f0f0;text-shadow: 1px 1px 0px #666;">Usuario:</td>
      <td width="234" align="left"><input type="text" name="usuario" id="usuario" value="<?php echo $_POST['usuario'];?>" size="20" style="padding:5px; border: 1px solid #666; -moz-border-radius: 4px; -webkit-border-radius: 4px; color: #666; background-color: #f0f0f0;  "/></td>
    </tr>
    <tr>
      <td height="19" align="right" style="font-weight: bold; color: #f0f0f0;text-shadow: 1px 1px 0px #666;">Senha:</td>
      <td align="left">
        <input type="password" name="senha" id="senha" size="20" style="padding:5px; border: 1px solid #ccc; -moz-border-radius: 4px; -webkit-border-radius: 4px; color: #666; background-color: #f0f0f0;  " /></td>
    </tr>
    <tr>
      <td colspan="2" id="autenticacao">
        <input type="submit" name="logar" value="autenticar" id="autenticar" />
      </td>
    </tr>
</table>
  <div id="options">
<input type="radio" name="opOpen" class="opOpen" value="self">
		<span>Janela atual  </span>
		<!--<input type="radio" name="opOpen" class="opOpen" value="fullscree">
		<span>Tela inteira  </span>!-->
		<input type="radio" name="opOpen" class="opOpen" value="maximizado" checked="checked">
                <span>Maximizado </span>
</div>
	
	<!--<div id="gerOption">
		Esqueceu sua senha?<br>
		<input type="button" name="getSenha" id="getSenha" value="Clique Aqui" onClick="alertPetrus('Em Breve!')">
	</div>!-->
	
	<div id="retorno">
	</div>
	
		
</form>

<div style="text-align:center; positon: fixed; top: 15px; left: 50%; padding-left: -162px; z-index: 2"><!--<img src="app.images/logo_educacional_index.png" width="324" height="76" alt="">!--></div>
<div style="width: 100%; padding-top:8px; color:#666; text-align:center; vertical-align: middle; font-family:Verdana, Arial, Helvetica; font-size:10px; height:100px;text-shadow: 1px 1px 0px #FFF; background:url(app.images/icone_educacional_index.png) top center no-repeat;">
<p>Sistema Integrado Petrus Comercial<br/>Todos os direitos reservados - <a href="http://www.bitup.com.br" target="blank">BitUP S.i</a></p></div>
    </div>
    <script type="text/javascript">
if(navigator.appName == 'Microsoft Internet Explorer' || navigator.appName == 'Opera'){
    document.getElementById('options').innerHTML = 'Use um navegador atualizado:<br/><br/><a href="http://br.mozdev.org/download/" border=0 title="Instalar Firefox" alt="Instalar Firefox" target="blank"><img src="app.images/icon_firefox.png" style="height: 48px; border: 0px" /></a> <a href="http://www.google.com/chrome" border=0 title="Instalar Chrome" alt="Instalar Chrome" target="blank"><img src="app.images/icon_chrome.png" style="height: 48px; border: 0px" /></a>';
    document.getElementById('autenticacao').innerHTML = '<span style="font-size: 12px; background-color: #fff; padding: 2px; border: 1pd dotted #ccc;">Navegador não suportado</span>';
}
</script>

</body>
</html>

<?php 
    if($obLog){
        $retorno = $obLog->getRetorno();
    }

if($retorno == "erro1"){
	echo '<script> document.getElementById("retorno").innerHTML="Os campos devem ser preenchidos com caraceteres válidos."; </script>';
}elseif($retorno == "erro2"){
	echo '<script> document.getElementById("retorno").innerHTML="Dados Invalidos."; </script>';
}elseif($retorno == "erro3"){
	echo '<script> document.getElementById("retorno").innerHTML="Dados Invalidos.";</script>';
}elseif($retorno == "erro4"){
	echo '<script> document.getElementById("retorno").innerHTML=""A unidade associada ao usuario não pode ser carregada <br> Por favor, entre em contato com o Administrador do sistema.";</script>';
}
?>
