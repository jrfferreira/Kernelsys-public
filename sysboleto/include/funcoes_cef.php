<?php
/*
 * Boleto sem registro  CEF-SIGCB
 */

$codigobanco = "104";
$codigo_banco_com_dv = geraCodigoBanco($codigobanco);
$nummoeda = "9";
$fator_vencimento = fator_vencimento($dadosboleto["data_vencimento"]);

//valor tem 10 digitos, sem virgula
$valor = formata_numero($dadosboleto["valor_boleto"],10,0,"valor");
//agencia � 4 digitos
$agencia = formata_numero($dadosboleto["agencia"],4,0);
//cendente/conta � 5 digitos mais o digito totalizando 6
$conta_ced = formata_numero($dadosboleto["conta_cedente"],5,0).formata_numero($dadosboleto["conta_cedente_dv"],1,0);
//DV do codigo do cedente
$dv_cedente = modulo_11($conta_ced);
//codigo do cedente mais dv do cedente
$conta_ced_dv = $conta_ced.$dv_cedente;
//carteira � 2 caracteres
$carteira = $dadosboleto["carteira"];

/*
* O Nosso Número no SIGCB � composto de 17 posições, sendo as 02 posições iniciais para identificar a
* Carteira e as 15 posições restantes são para livre utilização pelo Cedente divididas em 3 sequencias.
*/
$nnum = $dadosboleto["inicio_nosso_numero"].$dadosboleto["nosso_numero"];
//dv do nosso Número
$dv_nosso_numero = modulo_11($nnum);
$nossonumero_dv = "$nnum$dv_nosso_numero";

//conta cedente (sem dv) � 11 digitos
$conta_cedente = formata_numero($conta_ced_dv,11,0);
$ag_contacedente = $agencia . $conta_cedente;

$nossonumero = substr($nnum,0,17).'-'.$dv_nosso_numero;
$agencia_codigo = $agencia." / ".  formata_numero($conta_ced,11,0) ."-". $dv_cedente;

//Define campo livre
$campoLivre = $conta_ced_dv.substr($nnum, 2,3).substr($nnum, 0,1).substr($nnum, 5,3).substr($nnum, 1,1).substr($nnum, 8,9);
$dvCampoLivre = modulo_11($campoLivre);
$campoLivre = $campoLivre.$dvCampoLivre;

// Linha digitavel
$campo01 = $codigobanco.$nummoeda.substr($campoLivre, 0, 5);
$dv_campo1 = modulo_10($campo01);
$campo01 = $campo01.$dv_campo1;
$campo01Form = substr($campo01, 0, 5).'.'.substr($campo01, 5, 5);
//----------------
$campo02 = substr($campoLivre, 5, 10);
$dv_campo2 = modulo_10($campo02);
$campo02 = $campo02.$dv_campo2;
$campo02Form = substr($campo02, 0, 5).'.'.substr($campo02, 5, 6);
//----------------
$campo03 = substr($campoLivre, 15, 10);
$dv_campo3 = modulo_10($campo03);
$campo03 = $campo03.$dv_campo3;
$campo03Form = substr($campo03, 0, 5).'.'.substr($campo03, 5, 6);
//----------------
$campo05 = $fator_vencimento.$valor;
    // Numero para o codigo de barras com 44 digitos
    $numCodBarras = "$codigobanco"."$nummoeda"."$fator_vencimento"."$valor"."$campoLivre";
//DV geral do codigo de barras
$campo04 = dvGeralCodigoBarra($numCodBarras);

$numCodBarras = substr($numCodBarras, 0, 4).$campo04.substr($numCodBarras, 4);

$dadosboleto["codigo_barras"] = $numCodBarras;
$dadosboleto["linha_digitavel"] = monta_linha_digitavel($campo01Form, $campo02Form, $campo03Form, $campo04, $campo05);
$dadosboleto["agencia_codigo"] = $agencia_codigo;
$dadosboleto["nosso_numero"] = $nossonumero;
$dadosboleto["codigo_banco_com_dv"] = $codigo_banco_com_dv;



// FUNções
// Algumas foram retiradas do Projeto PhpBoleto e modificadas para atender as particularidades de cada banco

/*
 * Módulo "11", com peso de 2 a 9, utilizando o digito 1 para os restos 0, 10 ou 1
 * (regra exclusiva para c�lculo do DV geral do código de Barras);
 * Para o c�lculo considerar o conte�do das posições de 1 a 4 e de 6 a 44, iniciando pela
 * posição 44 e saltando a posição 5, sendo o sentido do c�lculo da direita para a esquerda.
*/
function dvGeralCodigoBarra($fator){
    $dvCodBarraGeral = modulo_11($fator);
    if($dvCodBarraGeral == 0 or $dvCodBarraGeral == 1 or $dvCodBarraGeral == 10){
        $dvCodBarraGeral = 1;
    }

    return $dvCodBarraGeral;
}

function formata_numero($numero,$loop,$insert,$tipo = "geral") {
	if ($tipo == "geral") {
		$numero = str_replace(",","",$numero);
		while(strlen($numero)<$loop){
			$numero = $insert . $numero;
		}
	}
	if ($tipo == "valor") {
		/*
		retira as virgulas
		formata o numero
		preenche com zeros
		*/
		$numero = str_replace(",","",$numero);
		while(strlen($numero)<$loop){
			$numero = $insert . $numero;
		}
	}
	if ($tipo = "convenio") {
		while(strlen($numero)<$loop){
			$numero = $numero . $insert;
		}
	}
	return $numero;
}


function fbarcode($valor){

//echo     $valor.'<br><br>';
//exit;

$fino = 1 ;
$largo = 3 ;
$altura = 50 ;

  $barcodes[0] = "00110" ;
  $barcodes[1] = "10001" ;
  $barcodes[2] = "01001" ;
  $barcodes[3] = "11000" ;
  $barcodes[4] = "00101" ;
  $barcodes[5] = "10100" ;
  $barcodes[6] = "01100" ;
  $barcodes[7] = "00011" ;
  $barcodes[8] = "10010" ;
  $barcodes[9] = "01010" ;
  
  for($f1=9;$f1>=0;$f1--){
    for($f2=9;$f2>=0;$f2--){
      $f = ($f1 * 10) + $f2 ;
      $texto = "" ;
      for($i=1;$i<6;$i++){
        $texto .=  substr($barcodes[$f1],($i-1),1) . substr($barcodes[$f2],($i-1),1);
      }
      $barcodes[$f] = $texto;
    }
  }


//Desenho da barra

//Guarda inicial
$codigoBarras = '<img src=imagens/p.png width='.$fino.' height='.$altura.' border=0><img src=imagens/b.png width='.$fino.' height='.$altura.' border=0><img src=imagens/p.png width='.$fino.' height='.$altura.' border=0><img src=imagens/b.png width='.$fino.' height='.$altura.' border=0> ';


$texto = $valor ;
if((strlen($texto) % 2) <> 0){
	$texto = "0" . $texto;
}

// Draw dos dados
while (strlen($texto) > 0) {
  $i = round(esquerda($texto,2));
  $texto = direita($texto,strlen($texto)-2);
  $f = $barcodes[$i];
  for($i=1;$i<11;$i+=2){
    if (substr($f,($i-1),1) == "0") {
      $f1 = $fino ;
    }else{
      $f1 = $largo ;
    }

	$codigoBarras .= '<img src=imagens/p.png width='.$f1.' height='.$altura.' border=0>';

    if (substr($f,$i,1) == "0") {
      $f2 = $fino ;
    }else{
      $f2 = $largo ;
    }

   $codigoBarras .= '<img src=imagens/b.png width='.$f2.' height='.$altura.' border=0>';

  }
}

// Draw guarda final
 $codigoBarras .= '<img src=imagens/p.png width='.$largo.' height='.$altura.' border=0><img src=imagens/b.png width='.$fino.' height='.$altura.' border=0><img src=imagens/p.png width=1 height='.$altura.' border=0>';

 return $codigoBarras;

} //Fim da função



function esquerda($entra,$comp){
	return substr($entra,0,$comp);
}

function direita($entra,$comp){
	return substr($entra,strlen($entra)-$comp,$comp);
}

function fator_vencimento($data) {
	$data = preg_split("/\//",$data);
	$ano = $data[2];
	$mes = $data[1];
	$dia = $data[0];
    return(abs((_dateToDays("1997","10","07")) - (_dateToDays($ano, $mes, $dia))));
}

function _dateToDays($year,$month,$day) {
    $century = substr($year, 0, 2);
    $year = substr($year, 2, 2);
    if ($month > 2) {
        $month -= 3;
    } else {
        $month += 9;
        if ($year) {
            $year--;
        } else {
            $year = 99;
            $century --;
        }
    }
    return ( floor((  146097 * $century)    /  4 ) +
            floor(( 1461 * $year)        /  4 ) +
            floor(( 153 * $month +  2) /  5 ) +
                $day +  1721119);
}

///* funções de modulos *\\\\\\
#########################################################
///*** modulo 10 - Prad�o Caixa Economica Federal ***\\\\
#########################################################
function modulo_10($base){

    $peso=21;//base do peso de qualculo
    $cont_base=strlen($base)-1;
    $p = 2;
	for($b=$cont_base;$b>=0;$b--){// loop do calculo

            $mult[$b] = $base[$b]*$p;// multiplica todos os componente do campo
			if($mult[$b]>9){$mult[$b] = $mult[$b]-9;}//se a $mult[$b] for mair que 9 subtrai por 9

      if($p==2){$p = 1;}else{$p = 2;}//ordem 212121212 <---
	}
    $soma = array_sum($mult);

	$resto = $soma%10;//pega o resto da divis�o
	if($resto!= 0){
		$dv = 10-$resto;//subtrai o resultado por 10
	}else{$dv = 0;}

    return $dv;//retorna o dv
}
################################ fim modulo 10 #####################################

####################################################################################
////------------------------------  Modulo 11 ---------------------------------\\\\\
####################################################################################
function modulo_11($arg){
	$base = 2;
	###########################
		$quant = strlen($arg)-1;

		for($n = $quant; $n>=0; $n--){

			$mult[] = $base*$arg[$n];

            $base = $base+1;
			if($base>9){$base = 2;}
		}
        $soma = array_sum($mult);

    if($soma < 11){
        $dc = 11-$soma;
    }else{
	//-->> divis�o <<--\\
    $resto_div = $soma%11;
	$dc = 11-$resto_div;
    
		if($dc>9){
			$dc=0;
		}
    }
	return $dc;
}
############################ fim modulo 11 ############################


function monta_linha_digitavel($c1, $c2, $c3, $c4, $c5) {
        return "$c1 $c2 $c3 $c4 $c5";
}

function geraCodigoBanco($numero) {
    $parte1 = substr($numero, 0, 3);
    $parte2 = modulo_10($parte1);
    return $parte1 . "-" . $parte2;
}

?>