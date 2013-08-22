
<?php

$cpf_cpnj_Layout = isset($dadosboleto["pessnmrf"]) ? "<br>" . $dadosboleto["pessnmrf"] : '';

$htmlBoleto = '

<HTML>
<HEAD>
<TITLE>' . $dadosboleto["identificacao"] . '</TITLE>
<META http-equiv=Content-Type content=text/html charset=UTF-8>
<meta name="Generator" content="Projeto BoletoPHP - www.boletophp.com.br - Licença GPL" />
<style type=text/css>
<!--.cpl {  font: bold 12px sans-serif; color: black}
<!--.cp {  font: bold 10px sans-serif; color: black}
<!--.ti {  font: 9px sans-serif}
<!--.ld { font: bold 15px sans-serif; color: #000000}
<!--.caixa {padding-top: 5px; font: bold 15px sans-serif; color: #FFF; background-color: #ccc; margin: 5px; text-align: center; vertical-align: middle; height: 25px;}
<!--.bloco {padding-top: 10px; font: bold 15px sans-serif; color: #FFF; background-color: #ccc; margin: 5px; text-align: center; vertical-align: middle; height: 30px;border-radius: 6px; -moz-border-radius: 6px; -webkit-border-radius: 6px; }
<!--.ct { FONT: 8px sans-serif; COLOR: #000033}
<!--.cn { FONT: 9px sans-serif; COLOR: black }
<!--.bc { font: bold 20px sans-serif; color: #000000 }
<!--.ld2 { font: bold 12px sans-serif; color: #000000 }
--></style> 
</head>

<BODY text=#000000 bgColor=#ffffff topMargin=0 rightMargin=0>';

$htmlBoleto .= '<table cellspacing=0 cellpadding=0 width=666 border=0>
<tr>
<td rowspan=3 style="text-align: center; vertical-align: middle;"><IMG SRC=../'.TOccupant::getPath().'app.config/logo.jpg style="height: 60px; max-width: 120px; margin: 10px; vertical-align: middle;"></td>
<td colspan=2 align="center" height=40><span class=ld>
<span class="campotitulo">
' . $dadosboleto["linha_digitavel"] . '
</span></span></td>
</tr>
<tr>
<td align="right" ><span class=cpl>
<span class="campotitulo">
Cedente: ' . $dadosboleto["cedente"] . ' - CNPJ: ' . $dadosboleto["pessnmrf"] . '
</span></span></td>
<td></td>
</tr>
<tr>
<td align="right" ><span class=cpl>
<span class="campotitulo">
Sacado: ' . $dadosboleto["sacado"] . ' - CPF: ' . $dadosboleto["pessnmrf_sacado"] . '
</span></span></td>
<td></td>
</tr>
<table><br/>';

$htmlBoleto .= '<table cellspacing=0 cellpadding=0 width=666 border=0>
<tr>
<td width="50%" align=center valign=middle>
<div class="ld"><span class="campotitulo">
' . $dadosbl['parcelamento'] . '
</span></div>
<span class=cpl>' . $dadosbl['infoFatura'] . '
</span>
</td>

<td width="25%"><span class=ct valign=bottom height=13 style="margin-left: 10px;">Vencimento</span><div class=bloco>' . $dadosboleto["data_vencimento"] . '</div></td>
<td width="25%"><span class=ct valign=bottom height=13 style="margin-left: 10px;">Valor da Fatura</span><div class=bloco>R$ ' . $dadosboleto["valor_boleto"] . '</div></td>
</tr>
<table>';

if ($dadosbl['detalhamento']) {
    $htmlBoleto .= '<br/><table width=666 cellspacing=0 cellpadding=0 border=0><tr><td valign=top><DIV ALIGN="CENTER" class=caixa>Historico de Faturas</DIV></TD></TR><TR><TD valign=top class=cp align=center>';
    $htmlBoleto .= '<table width=650 cellspacing=0 cellpadding=0 border=0><tr height=20><td class=cp>Doc.</td><td class=cp>Valor</td><td class=cp>Vencimento</td><td class=cp>Situação</td><td class=cp align=right>Valor Pago</td><tr>';

    foreach($dadosbl['detalhamento'] as $ch => $vl){
        $htmlBoleto .= '<tr><td class=cp>'.$vl['codigo'].'</td><td class=cn>'.$vl['valornominal'].'</td><td class=cn>'.$vl['vencimento'].'</td><td class=cn>'.$vl['situacao'].'</td><td class=cn align=right>'.$vl['valorpago'].'</td><tr>';
        }

    $htmlBoleto .= '</table><br/>';


    $htmlBoleto .= '</TD></TR></TABLE><br/><table cellspacing=0 cellpadding=0 width=666 border=0><TBODY><TR><TD class=ct width=666><img height=1 src=imagens/6.png width=665 border=0></TD></TR><TR><TD class=ct width=666><div align=right><b class=cp>Recibo
do Sacado</b></div></TD></tr></tbody></table><table width=666 cellspacing=5 cellpadding=0 border=0><tr><td width=41 height=40px></TD></tr></table>';
} else {
    $htmlBoleto .= '<br/><table width=666 cellspacing=0 cellpadding=0 border=0><tr><td valign=top class=cp><DIV ALIGN="CENTER" class=caixa>Instruções
de Impressão</DIV></TD></TR><TR><TD valign=top class=cp><DIV ALIGN="left" style="margin-left: 15px;">
<p>
<li>Imprima em impressora jato de tinta (ink jet) ou laser em qualidade normal ou alta (não use modo econômico).<br>
<li>Utilize folha A4 (210 x 297 mm) ou Carta (216 x 279 mm) e margens mínimas à esquerda e à direita do formulário.<br>
<li>Corte na linha indicada. não rasure, risque, fure ou dobre a região onde se encontra o código de barras.<br>
<li>Caso não apareça o código de barras no final, clique em F5 para atualizar esta tela.
<li>Caso tenha problemas ao imprimir, copie a sequencia numérica abaixo e pague no caixa eletrônico ou no internet banking:<br><br>
<span class="ld2">
&nbsp;&nbsp;&nbsp;&nbsp;Linha Digitável: &nbsp;'.$dadosboleto["linha_digitavel"].'<br>
&nbsp;&nbsp;&nbsp;&nbsp;Valor: &nbsp;&nbsp;R$ '.$dadosboleto["valor_boleto"].'<br>
</span>
</DIV></td></tr></table><br><table cellspacing=0 cellpadding=0 width=666 border=0><TBODY><TR><TD class=ct width=666><img height=1 src=imagens/6.png width=665 border=0></TD></TR><TR><TD class=ct width=666><div align=right><b class=cp>Recibo
do Sacado</b></div></TD></tr></tbody></table><table width=666 cellspacing=5 cellpadding=0 border=0><tr><td width=41 height=40px></TD></tr></table>';

        }
$htmlBoleto .= '<table cellspacing=0 cellpadding=0 width=666 border=0><tr><td class=ct width=666></td></tr><tbody><tr><td class=ct width=666>
<div align=right>Corte na linha pontilhada</div></td></tr><tr><td class=ct width=666><img height=1 src=imagens/6.png width=665 border=0></td></tr></tbody></table><br><table cellspacing=0 cellpadding=0 width=666 border=0><tr><td class=cp width=150> 
  <span class="campo"><IMG 
      src=../../sysboleto/imagens/logocaixa.jpg width="120" border=0></span></td>
<td width=3 valign=bottom><img height=22 src=imagens/3.png width=2 border=0></td><td class=cpt width=58 valign=bottom><div align=center><font class=bc>'.$dadosboleto["codigo_banco_com_dv"].'</font></div></td><td width=3 valign=bottom><img height=22 src=imagens/3.png width=2 border=0></td><td class=ld align=right width=453 valign=bottom><span class=ld> 
<span class="campotitulo">
'.$dadosboleto["linha_digitavel"].'
</span></span></td>
</tr><tbody><tr><td colspan=5><img height=2 src=imagens/2.png width=666 border=0></td></tr></tbody></table><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=472 height=13>Local 
de pagamento</td><td class=ct valign=top width=7 height=13><img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=180 height=13>Vencimento</td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top width=472 height=12>Pagável 
em qualquer Banco até o vencimento</td><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top align=right width=180 height=12> 
  <span class="campo">
  '.$dadosboleto["data_vencimento"].'
  </span></td>
</tr><tr><td valign=top width=7 height=1><img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=472 height=1><img height=1 src=imagens/2.png width=472 border=0></td><td valign=top width=7 height=1><img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=180 height=1><img height=1 src=imagens/2.png width=180 border=0></td></tr></tbody></table><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=472 height=13>Cedente</td><td class=ct valign=top width=7 height=13><img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=180 height=13>Agência/código 
cedente</td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top width=472 height=12> 
  <span class="campo">
  '.$dadosboleto["cedente"].'
  </span></td>
<td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top align=right width=180 height=12> 
  <span class="campo">
  '.$dadosboleto["agencia_codigo"].'
  </span></td>
</tr><tr><td valign=top width=7 height=1><img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=472 height=1><img height=1 src=imagens/2.png width=472 border=0></td><td valign=top width=7 height=1><img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=180 height=1><img height=1 src=imagens/2.png width=180 border=0></td></tr></tbody></table><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13> 
<img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=113 height=13>Data 
do documento</td><td class=ct valign=top width=7 height=13> <img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=153 height=13>N<u>o</u> 
documento</td><td class=ct valign=top width=7 height=13> <img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=62 height=13>Espécie 
doc.</td><td class=ct valign=top width=7 height=13> <img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=34 height=13>Aceite</td><td class=ct valign=top width=7 height=13> 
<img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=82 height=13>Data 
processamento</td><td class=ct valign=top width=7 height=13> <img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=180 height=13>Nosso 
Número</td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top  width=113 height=12><div align=left> 
  <span class="campo">
  '.$dadosboleto["data_documento"].'
  </span></div></td><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top width=153 height=12> 
    <span class="campo">
    '.$dadosboleto["numero_documento"].'
    </span></td>
  <td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top  width=62 height=12><div align=left><span class="campo">
    '.$dadosboleto["especie_doc"].'
  </span> 
 </div></td><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top  width=34 height=12><div align=left><span class="campo">
 '.$dadosboleto["aceite"].'
 </span> 
 </div></td><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top  width=82 height=12><div align=left> 
   <span class="campo">
   '.$dadosboleto["data_processamento"].'
   </span></div></td><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top align=right width=180 height=12> 
     <span class="campo">
     '.$dadosboleto["nosso_numero"].'
     </span></td>
</tr><tr><td valign=top width=7 height=1><img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=113 height=1><img height=1 src=imagens/2.png width=113 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=153 height=1><img height=1 src=imagens/2.png width=153 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=62 height=1><img height=1 src=imagens/2.png width=62 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=34 height=1><img height=1 src=imagens/2.png width=34 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=82 height=1><img height=1 src=imagens/2.png width=82 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=180 height=1> 
<img height=1 src=imagens/2.png width=180 border=0></td></tr></tbody></table><table cellspacing=0 cellpadding=0 border=0><tbody><tr> 
<td class=ct valign=top width=7 height=13> <img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top COLSPAN="3" height=13>Uso 
do banco</td><td class=ct valign=top height=13 width=7> <img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=83 height=13>Carteira</td><td class=ct valign=top height=13 width=7> 
<img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=53 height=13>Espécie</td><td class=ct valign=top height=13 width=7> 
<img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=123 height=13>Quantidade</td><td class=ct valign=top height=13 width=7> 
<img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=72 height=13> 
Valor Documento</td><td class=ct valign=top width=7 height=13><img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=180 height=13>(=) 
Valor documento</td></tr><tr> <td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td valign=top class=cp height=12 COLSPAN="3"><div align=left> 
 </div></td><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top  width=83> 
<div align=left> <span class="campo">SR
  
</span></div></td><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top  width=53><div align=left><span class="campo">
'.$dadosboleto["especie"].'
</span> 
 </div></td><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top  width=123><span class="campo">
 '.$dadosboleto["quantidade"].'
 </span> 
 </td>
 <td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top  width=72> 
   <span class="campo">
   '.$dadosboleto["valor_unitario"].'
   </span></td>
 <td class=cp valign=top width=7 height=12> <img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top align=right width=180 height=12> 
   <span class="campo">
   '.$dadosboleto["valor_boleto"].'
   </span></td>
</tr><tr><td valign=top width=7 height=1> <img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=7 height=1><img height=1 src=imagens/2.png width=75 border=0></td><td valign=top width=7 height=1><img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=31 height=1><img height=1 src=imagens/2.png width=31 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=83 height=1><img height=1 src=imagens/2.png width=83 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=53 height=1><img height=1 src=imagens/2.png width=53 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=123 height=1><img height=1 src=imagens/2.png width=123 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=72 height=1><img height=1 src=imagens/2.png width=72 border=0></td><td valign=top width=7 height=1> 
<img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=180 height=1><img height=1 src=imagens/2.png width=180 border=0></td></tr></tbody> 
</table><table cellspacing=0 cellpadding=0 width=666 border=0><tbody><tr><td align=right width=10><table cellspacing=0 cellpadding=0 border=0 align=left><tbody> 
<tr> <td class=ct valign=top width=7 height=13><img height=13 src=imagens/1.png width=1 border=0></td></tr><tr> 
<td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td></tr><tr> 
<td valign=top width=7 height=1><img height=1 src=imagens/2.png width=1 border=0></td></tr></tbody></table></td><td valign=top width=468 rowspan=5><font class=ct>Instruções 
(Texto de responsabilidade do cedente)</font><br><br><span class=ct> <FONT class=campo>
'.$dadosboleto["instrucoes1"].'; '.$dadosboleto["instrucoes2"].'<br></FONT><br></span><span class=cp>
        '.$dadosboleto["instrucoes3"].'<br>
            '.$dadosboleto["instrucoes4"].'<br></FONT><br><br>
</span></td>
<td align=right width=188><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=180 height=13>(-) 
Desconto / Abatimentos</td></tr><tr> <td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top align=right width=180 height=12></td></tr><tr> 
<td valign=top width=7 height=1><img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=180 height=1><img height=1 src=imagens/2.png width=180 border=0></td></tr></tbody></table></td></tr><tr><td align=right width=10> 
<table cellspacing=0 cellpadding=0 border=0 align=left><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=imagens/1.png width=1 border=0></td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td></tr><tr><td valign=top width=7 height=1> 
<img height=1 src=imagens/2.png width=1 border=0></td></tr></tbody></table></td><td align=right width=188><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=180 height=13>(-) 
Outras deduções</td></tr><tr><td class=cp valign=top width=7 height=12> <img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top align=right width=180 height=12></td></tr><tr><td valign=top width=7 height=1><img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=180 height=1><img height=1 src=imagens/2.png width=180 border=0></td></tr></tbody></table></td></tr><tr><td align=right width=10> 
<table cellspacing=0 cellpadding=0 border=0 align=left><tbody><tr><td class=ct valign=top width=7 height=13> 
<img height=13 src=imagens/1.png width=1 border=0></td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td></tr><tr><td valign=top width=7 height=1><img height=1 src=imagens/2.png width=1 border=0></td></tr></tbody></table></td><td align=right width=188> 
<table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=180 height=13>(+) 
Mora / Multa</td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top align=right width=180 height=12></td></tr><tr> 
<td valign=top width=7 height=1> <img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=180 height=1> 
<img height=1 src=imagens/2.png width=180 border=0></td></tr></tbody></table></td></tr><tr><td align=right width=10><table cellspacing=0 cellpadding=0 border=0 align=left><tbody><tr> 
<td class=ct valign=top width=7 height=13><img height=13 src=imagens/1.png width=1 border=0></td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td></tr><tr><td valign=top width=7 height=1><img height=1 src=imagens/2.png width=1 border=0></td></tr></tbody></table></td><td align=right width=188> 
<table cellspacing=0 cellpadding=0 border=0><tbody><tr> <td class=ct valign=top width=7 height=13><img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=180 height=13>(+) 
Outros acréscimos</td></tr><tr> <td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top align=right width=180 height=12></td></tr><tr><td valign=top width=7 height=1><img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=180 height=1><img height=1 src=imagens/2.png width=180 border=0></td></tr></tbody></table></td></tr><tr><td align=right width=10><table cellspacing=0 cellpadding=0 border=0 align=left><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=imagens/1.png width=1 border=0></td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td></tr></tbody></table></td><td align=right width=188><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=180 height=13>(=) 
Valor cobrado</td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top align=right width=180 height=12></td></tr></tbody> 
</table></td></tr></tbody></table><table cellspacing=0 cellpadding=0 width=666 border=0><tbody><tr><td valign=top width=666 height=1><img height=1 src=imagens/2.png width=666 border=0></td></tr></tbody></table><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=659 height=13>Sacado</td></tr><tr><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top width=659 height=12><span class="campo">
'.$dadosboleto["sacado"].'
</span> 
'.$dadosboleto["pessnmrf_sacado"] .'
</td>
</tr></tbody></table><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=cp valign=top width=7 height=12><img height=12 src=imagens/1.png width=1 border=0></td><td class=cp valign=top width=659 height=12><span class="campo">
'.$dadosboleto["endereco1"].'
</span> 
</td>
</tr></tbody></table><table cellspacing=0 cellpadding=0 border=0><tbody><tr><td class=ct valign=top width=7 height=13><img height=13 src=imagens/1.png width=1 border=0></td><td class=cp valign=top width=472 height=13> 
  <span class="campo">
  '.$dadosboleto["endereco2"].'
  </span></td>
<td class=ct valign=top width=7 height=13><img height=13 src=imagens/1.png width=1 border=0></td><td class=ct valign=top width=180 height=13>Cód. 
baixa</td></tr><tr><td valign=top width=7 height=1><img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=472 height=1><img height=1 src=imagens/2.png width=472 border=0></td><td valign=top width=7 height=1><img height=1 src=imagens/2.png width=7 border=0></td><td valign=top width=180 height=1><img height=1 src=imagens/2.png width=180 border=0></td></tr></tbody></table><TABLE cellSpacing=0 cellPadding=0 border=0 width=666><TBODY><TR><TD class=ct  width=7 height=12></TD><TD class=ct  width=409 >Sacador/Avalista</TD><TD class=ct  width=250 ><div align=right>Autenticação 
mecânica - <b class=cp>Ficha de Compensação</b></div></TD></TR><TR><TD class=ct  colspan=3 ></TD></tr></tbody></table><TABLE cellSpacing=0 cellPadding=0 width=666 border=0><TBODY><TR><TD vAlign=bottom align=left height=50>';

$codBarra =  fbarcode($dadosboleto["codigo_barras"]);
$htmlBoleto .= $codBarra.'  </TD>
</tr></tbody></table>';

$htmlBoleto .= '</BODY></HTML>

';
?>
