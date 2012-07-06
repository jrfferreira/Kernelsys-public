<?php
/*function __autoload($classe) {
    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}*/
$dominioValido = false;
$prefixoEndereco = '';

if($_GET['occupant']){
	$prefixoEndereco = 'occupant/'.$_GET['occupant'].'/';
}


if(file_exists("../{$prefixoEndereco}app.config/my_dbpetrus.ini")){
	$dominioValido = true;
}

$enderecoGetPath = "../{$prefixoEndereco}app.config/getPath.js";

if($_POST['logar'] != ""){
        if($_GET['occupant']) {
            $_POST['occupant'] = $_GET['occupant'];
        }
	include_once('../app.access/TSetlogin.class.php');	
	$obLog = new TSetlogin($_POST);
}
?>
<!doctype html>
<html>
<head>
<link rel="shortcut icon" href="favicon.ico" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Sistema Integrado - bitUP</title>
<script type="text/javascript" src="<?php echo $enderecoGetPath; ?>"></script>
<style>
/*******************
SELECTION STYLING
*******************/

::selection {
	color: #fff;
	background: #f676b2; /* Safari */
}
::-moz-selection {
	color: #fff;
	background: #f676b2; /* Firefox */
}

/*******************
BODY STYLING
*******************/

* {
	margin: 0;
	padding: 0;
	border: none;
	outline: none;
}

body {
	background: url(app.images/light_toast.png);	
	font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
	font-weight:300;
	text-align: left;
	text-decoration: none;
	height: 500px;
}

#wrapper {
	/* Center wrapper perfectly */
	width: 300px;
	height: 400px;
	margin: 70px auto;
}

/* Download Button (Demo Only) */
.download {
	display: block;
	position: absolute;
	float: right;
	right: 25px;
	bottom: 25px;
	padding: 5px;
	
	font-weight: bold;
	font-size: 11px;
	text-align: right;
	text-decoration: none;
	color: rgba(0,0,0,0.5);
	text-shadow: 1px 1px 0 rgba(256,256,256,0.5);
}

.download:hover {
	color: rgba(0,0,0,0.75);
	text-shadow: 1px 1px 0 rgba(256,256,256,0.5);
}

.download:focus {
	bottom: 24px;
}

/*
.gradient {
	width: 600px;
	height: 600px;
	position: fixed;
	left: 50%;
	top: 50%;
	margin-left: -300px;
	margin-top: -300px;
	
	background: url(app.images/gradient.png) no-repeat;
}
*/

.gradient {
	/* Center Positioning */
	width: 600px;
	height: 600px;
	position: fixed;
	left: 50%;
	top: 50%;
	margin-left: -300px;
	margin-top: -300px;
	z-index: -2;
	
	/* Fallback */ 
	background-image: url(app.images/gradient.png); 
	background-repeat: no-repeat; 
	
	/* CSS3 Gradient */
	background-image: -webkit-gradient(radial, 0% 0%, 0% 100%, from(rgba(70, 179, 211,0.2)), to(rgba(70, 179, 211,0)));
	background-image: -webkit-radial-gradient(50% 50%, 40% 40%, rgba(70, 179, 211,0.2), rgba(70, 179, 211,0));
	background-image: -moz-radial-gradient(50% 50%, 50% 50%, rgba(70, 179, 211,0.2), rgba(70, 179, 211,0));
	background-image: -ms-radial-gradient(50% 50%, 50% 50%, rgba(70, 179, 211,0.2), rgba(70, 179, 211,0));
	background-image: -o-radial-gradient(50% 50%, 50% 50%, rgba(70, 179, 211,0.2), rgba(70, 179, 211,0));
}

/*******************
LOGIN FORM
*******************/

.login-form {
	width: 300px;
	margin: 0 auto;
	position: relative;
	
	background: #f3f3f3;
	border: 1px solid #fff;
	border-radius: 5px;
	
	box-shadow: 0 1px 3px rgba(0,0,0,0.5);
	-moz-box-shadow: 0 1px 3px rgba(0,0,0,0.5);
	-webkit-box-shadow: 0 1px 3px rgba(0,0,0,0.5);
}

/*******************
HEADER
*******************/

.login-form .header {
	padding: 25px 10px 17px 10px;
}

.login-form .header h1 {
	font-family: Arial;
	font-weight: 300;
	text-align: center;
	font-size: 28px;
	line-height:34px;
	color: #414848;
	text-shadow: 1px 1px 0 rgba(256,256,256,1.0);
	margin-bottom: 10px;
}

.login-form .header div {
	font-size: 11px;
	line-height: 16px;
	text-align: center;
	color: #678889;
	text-shadow: 1px 1px 0 rgba(256,256,256,1.0);
}

.login-form .header span a, .login-form .header span a:visited,.login-form .header span a:hover,.login-form .header span a:clicked{
	font-size: 12px;
	font-weight: bolder;
	text-decoration:none;
	line-height: 16px;
	color: #56C2E1;
}

/*******************
CONTENT
*******************/

.login-form .content {
	padding: 0 30px 25px 30px;
}

.login-form .options {
  padding: 15px 0px 0px 0px;	
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 13px;
  text-align: center;
}

/* Input field */
.login-form .content .input {
	width: 188px;
	padding: 15px 25px;
	
	font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
	font-weight: 400;
	font-size: 14px;
	color: #9d9e9e;
	text-shadow: 1px 1px 0 rgba(256,256,256,1.0);
	
	background: #fff;
	border: 1px solid #fff;
	border-radius: 5px;
	
	box-shadow: inset 0 1px 3px rgba(0,0,0,0.50);
	-moz-box-shadow: inset 0 1px 3px rgba(0,0,0,0.50);
	-webkit-box-shadow: inset 0 1px 3px rgba(0,0,0,0.50);
}

/* Second input field */
.login-form .content .password, .login-form .content .pass-icon {
	margin-top: 25px;
}

.login-form .content .input:hover {
	background: #dfe9ec;
	color: #414848;
}

.login-form .content .input:focus {
	background: #dfe9ec;
	color: #414848;
	
	box-shadow: inset 0 1px 2px rgba(0,0,0,0.25);
	-moz-box-shadow: inset 0 1px 2px rgba(0,0,0,0.25);
	-webkit-box-shadow: inset 0 1px 2px rgba(0,0,0,0.25);
}

.user-icon, .pass-icon {
	width: 46px;
	height: 47px;
	display: block;
	position: absolute;
	left: 0px;
	padding-right: 2px;
	z-index: -1;
	
	-moz-border-radius-topleft: 5px;
	-moz-border-radius-bottomleft: 5px;
	-webkit-border-top-left-radius: 5px;
	-webkit-border-bottom-left-radius: 5px;
}

.user-icon {
	top:130px; /* Positioning fix for slide-in, got lazy to think up of simpler method. */
	background: rgba(65,72,72,0.75) url(app.images/user-icon.png) no-repeat center;	
}

.pass-icon {
	top:178px;
	background: rgba(65,72,72,0.75) url(app.images/pass-icon.png) no-repeat center;
}

.content input:focus + div{
	left: -46px;
}

/* Animation */
.input, .user-icon, .pass-icon, .button, .register {
	transition: all 0.5s ease;
	-moz-transition: all 0.5s ease;
	-webkit-transition: all 0.5s ease;
	-o-transition: all 0.5s ease;
	-ms-transition: all 0.5s ease;
}

/*******************
FOOTER
*******************/

.login-form .footer {
	padding: 25px 30px 25px 30px;
	overflow: auto;
	
	background: #d4dedf;
	border-top: 1px solid #fff;
	
	box-shadow: inset 0 1px 0 rgba(0,0,0,0.15);
	-moz-box-shadow: inset 0 1px 0 rgba(0,0,0,0.15);
	-webkit-box-shadow: inset 0 1px 0 rgba(0,0,0,0.15);
}

/* Login button */
.login-form .footer .button {
	float:right;
	padding: 11px 25px;
	
	font-family: 'Bree Serif', serif;
	font-weight: 300;
	font-size: 18px;
	color: #fff;
	text-shadow: 0px 1px 0 rgba(0,0,0,0.25);
	
	background: #56c2e1;
	border: 1px solid #46b3d3;
	border-radius: 5px;
	cursor: pointer;
	
	box-shadow: inset 0 0 2px rgba(256,256,256,0.75);
	-moz-box-shadow: inset 0 0 2px rgba(256,256,256,0.75);
	-webkit-box-shadow: inset 0 0 2px rgba(256,256,256,0.75);
}

.login-form .footer .button:hover {
	background: #3f9db8;
	border: 1px solid rgba(256,256,256,0.75);
	
	box-shadow: inset 0 1px 3px rgba(0,0,0,0.5);
	-moz-box-shadow: inset 0 1px 3px rgba(0,0,0,0.5);
	-webkit-box-shadow: inset 0 1px 3px rgba(0,0,0,0.5);
}

.login-form .footer .button:focus {
	position: relative;
	bottom: -1px;
	
	background: #56c2e1;
	
	box-shadow: inset 0 1px 6px rgba(256,256,256,0.75);
	-moz-box-shadow: inset 0 1px 6px rgba(256,256,256,0.75);
	-webkit-box-shadow: inset 0 1px 6px rgba(256,256,256,0.75);
}

/* Register button */
.login-form .footer .register {
	display: block;
	float: right;
	padding: 10px;
	margin-right: 20px;
	
	background: none;
	border: none;
	cursor: pointer;
	
	font-family: 'Bree Serif', serif;
	font-weight: 300;
	font-size: 18px;
	color: #414848;
	text-shadow: 0px 1px 0 rgba(256,256,256,0.5);
}

.login-form .footer .register:hover {
	color: #3f9db8;
}

.login-form .footer .register:focus {
	position: relative;
	bottom: -1px;
}

#retorno {
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 13px;

  position: relative;
  padding: 7px 15px;
  margin-bottom: 18px;
  color: #404040;

  background-color: #eedc94;
  background-repeat: repeat-x;

  background-image: -khtml-gradient(linear, left top, left bottom, from(#fceec1), to(#eedc94));
  background-image: -moz-linear-gradient(top, #fceec1, #eedc94);
  background-image: -ms-linear-gradient(top, #fceec1, #eedc94);
  background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #fceec1), color-stop(100%, #eedc94));
  background-image: -webkit-linear-gradient(top, #fceec1, #eedc94);
  background-image: -o-linear-gradient(top, #fceec1, #eedc94);
  background-image: linear-gradient(top, #fceec1, #eedc94);
  filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#fceec1', endColorstr='#eedc94', GradientType=0);
  
  text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
  border-color: #eedc94 #eedc94 #e4c652;
  border-color: rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.1) rgba(0, 0, 0, 0.25);
  text-shadow: 0 1px 0 rgba(255, 255, 255, 0.5);
  border-width: 1px;
  border-style: solid;
  
  -webkit-border-radius: 4px;
  -moz-border-radius: 4px;
  border-radius: 4px;
  
  -webkit-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.25);
  -moz-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.25);
  box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.25);
}

input[type='checkbox'] {
  -webkit-box-shadow: inset 0 1px 2px white,
                      0 1px 2px rgba(0, 0, 0, .2);
  -webkit-appearance: none;
  -webkit-margin-start: 0;
  -webkit-margin-end: 3px;
  background: -webkit-linear-gradient(#fafafa, #dcdcdc);
  border-radius: 3px;
  border: 1px solid #a0a0a0;
  display: inline-block;
  height: 16px;
  margin-bottom: 0;
  margin-top: 0;
  position: relative;
  top: 3px;
  vertical-align: baseline;
  width: 16px;
}

input[type='checkbox']:disabled {
  opacity: .75;
}

input[type='checkbox']:not(:disabled):not(:active):hover {
  background: -webkit-linear-gradient(#fff, #e6e6e6);
  text-shadow: 0 1px 0 rgba(255, 255, 255, 1);
}

input[type='checkbox']:not(:disabled):active {
  -webkit-box-shadow: inset 0 1px 3px rgba(0, 0, 0, .2);
  background: -webkit-linear-gradient(#f0f0f0, #bebebe);
  border: 1px solid #808080;
  text-shadow: 0 1px 0 rgba(255, 255, 255, .25);
}

input[type='checkbox']:checked::before {
  color: #808080;
  content: url('../images/checkmark.png');
  font-size: 13px;  /* Explicitly set the font size so that the positioning
                       of the checkmark is correct. */
  height: 16px;
  left: 2px;
  position: absolute;
}

input[type='radio'] {
  -webkit-box-shadow: inset 0 1px 2px white,
                      0 1px 2px rgba(0, 0, 0, .2);
  -webkit-appearance: none;
  -webkit-margin-start: 0;
  -webkit-margin-end: 3px;
  -webkit-transition: border 500ms;
  background: -webkit-linear-gradient(#fafafa, #dcdcdc);
  border-radius: 100%;
  border: 1px solid #a0a0a0;
  display: inline-block;
  height: 15px;
  margin-bottom: 0;
  position: relative;
  top: 3px;
  vertical-align: baseline;
  width: 15px;
}

input[type='radio']:disabled {
  opacity: .75;
}

input[type='radio']:not(:disabled):not(:active):hover {
  background: -webkit-linear-gradient(#fff, #e6e6e6);
  text-shadow: 0 1px 0 rgba(255, 255, 255, 1);
}

input[type='radio']:not(:disabled):active {
  -webkit-box-shadow: inset 0 1px 3px rgba(0, 0, 0, .2);
  background: -webkit-linear-gradient(#f0f0f0, #bebebe);
  border: 1px solid #808080;
  text-shadow: 0 1px 0 rgba(255, 255, 255, .25);
}

input[type='radio']:checked::before {
  -webkit-box-shadow: 0 1px 0 rgba(255, 255, 255, .5);
  -webkit-margin-start: 4px;
  background: #808080;
  border-radius: 10px;
  content: '';
  display: inline-block;
  font-size: 13px;
  font-weight: 400;
  height: 5px;
  left: 0;
  margin-top: 4px;
  opacity: 1;
  position: absolute;
  top: 0;
  vertical-align: top;
  width: 5px;
}

html[dir='rtl'] input[type='radio']:checked::before {
  right: 0;
}

input[type='radio']:active:checked::before {
  background: #606060;
}

/* .checkbox and .radio classes wrap labels. */

.checkbox,
.radio {
  margin: 9px 0;
}

.checkbox label,
.radio label {
  display: -webkit-box;
}

/* Make sure long spans wrap at the same place they start. */
.checkbox label input ~ span,
.radio label input ~ span {
  -webkit-box-flex: 1;
  -webkit-margin-start: 0.4em;
  display: block;
}

.checkbox label input[type=checkbox],
.radio label input[type=radio] {
  margin-top: 0;
  top: 0;
  vertical-align: top;
}

/* These rules are copied from button.css */
input[type='checkbox']:not(.custom-appearance):focus,
input[type='radio']:not(.custom-appearance):focus {
  -webkit-box-shadow: inset 0 1px 2px white,
      0 1px 2px rgba(0, 0, 0, .2),
      0 0 1px #c0c0c0,
      0 0 1px #c0c0c0,
      0 0 1px #c0c0c0;
  -webkit-transition: border-color 200ms;
  border-color: #4080fa;
  outline: none;
}

label > input[type=radio] ~ span,
label > input[type=checkbox] ~ span,
input[type=checkbox] ~ label {
  color: #444;
}

label:hover > input[type=checkbox]:disabled ~ span,
label:hover > input[type=radio]:disabled ~ span,
input[type=checkbox]:disabled ~ label:hover {
  color: #888;
}

label:hover > input[type=checkbox]:not(:disabled) ~ span,
label:hover > input[type=radio]:not(:disabled) ~ span,
input[type=checkbox]:not(:disabled) ~ label:hover {
  color: #222;
}
</style>

</head>
<body onload="document.getElementById('usuario').focus();" id="corpo">
    <div id="retorno">
	</div>
    <div id="wrapper">

    <form action="" method="POST" name="sistema" id="sistema" class="login-form" style="margin:2px; ">
	
		<div class="header">
		<h1><img src="app.images/logo.png"/></h1>
		<div>Todos os direitos reservados - <a href="http://www.bitup.com.br" target="blank">Bitup</a></div>
		</div>
	
		<div class="content">
		<input id="usuario" name="usuario" type="text" class="input username" placeholder="Usuário" value="<?php echo $_POST['usuario'];?>"/>
		<div class="user-icon"></div>
		<input id="senha" name="senha" type="password" class="input password" placeholder="Senha" />
		<div class="pass-icon"></div>	
		
		<div id="options" class="options">
			<input type="radio" name="opOpen" class="opOpen" value="self">
					<label for="opOpen">Janela atual</label>
					<input type="radio" name="opOpen" class="opOpen" value="maximizado" checked="checked">
					<label for="opOpen">Maximizado</label>
			</div>	
		</div>

		<div class="footer" id="autenticacao">
		<input type="submit" name="logar" value="<?php echo $dominioValido ? 'Entrar' : 'Este dominio é invalido!'  ?>" id="autenticar" <?php if(!$dominioValido) echo "disabled='disabled'" ?> class="button" />

		</div>
	
	</form>

</div>
<div class="gradient"></div>

<script type="text/javascript">
    
    	href = (window.location.href).split('?');

    	if(href[0] != getPath()+'/app.view/'){
    		document.getElementById('corpo').innerHTML = 'Aguarde, você está sendo redirecionado...';
    		window.location.href = getPath();
    	}
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
	echo '<script> document.getElementById("retorno").innerHTML="Os campos devem ser preenchidos com caracteres válidos."; </script>';
}elseif($retorno == "erro2" || $retorno == "erro3"){
	echo '<script> document.getElementById("retorno").innerHTML="Dados Inválidos.";</script>';
}elseif($retorno == "erro4"){
	echo '<script> document.getElementById("retorno").innerHTML="A unidade associada ao usuário não pode ser carregada <br> Por favor, entre em contato com o Administrador do sistema.";</script>';
}else{
	echo '<script> document.getElementById("retorno").style.display = "none"; </script>';
}
?>