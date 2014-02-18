<?php
// +----------------------------------------------------------------------+
// | BoletoPhp - Vers�o Beta                                              |
// +----------------------------------------------------------------------+
// | Este arquivo est� dispon�vel sob a Licença GPL dispon�vel pela Web   |
// | em http://pt.wikipedia.org/wiki/GNU_General_Public_License           |
// | Você deve ter recebido uma c�pia da GNU Public License junto com     |
// | esse pacote; se não, escreva para:                                   |
// |                                                                      |
// | Free Software Foundation, Inc.                                       |
// | 59 Temple Place - Suite 330                                          |
// | Boston, MA 02111-1307, USA.                                          |
// +----------------------------------------------------------------------+

// +----------------------------------------------------------------------+
// | Originado do Projeto BBBoletoFree que tiveram colaborações de Daniel |
// | William Schultz e Leandro Maniezo que por sua vez foi derivado do	  |
// | PHPBoleto de Jo�o Prado Maia e Pablo Martins F. Costa				        |
// | 														                                   			  |
// | Se vc quer colaborar, nos ajude a desenvolver p/ os demais bancos :-)|
// | Acesse o site do Projeto BoletoPhp: www.boletophp.com.br             |
// +----------------------------------------------------------------------+

// +--------------------------------------------------------------------------------------------------------+
// | Equipe Coordenação Projeto BoletoPhp: <boletophp@boletophp.com.br>              		             				|
// | Desenvolvimento Boleto Banco do Brasil: Daniel William Schultz / Leandro Maniezo / Rog�rio Dias Pereira|
// +--------------------------------------------------------------------------------------------------------+


// ------------------------- DADOS DIN�MICOS DO SEU CLIENTE PARA A GERAção DO BOLETO (FIXO OU VIA GET) -------------------- //
// Os valores abaixo podem ser colocados manualmente ou ajustados p/ formulário c/ POST, GET ou de BD (MySql,Postgre,etc)	//


$taxa_boleto = $dadosbl['taxa_administrativa'];
$dadosboleto["especie"] = $dadosbl['moeda'];
 
// valor do documento
$valor_cobrado = $dadosblDn[4];
$valor_cobrado = str_replace(",", ".",$valor_cobrado);
$valor_boleto = number_format($valor_cobrado+$taxa_boleto, 2, ',', '');


$dadosboleto["nosso_numero"] = $compNossoNumero;
$dadosboleto["numero_documento"] = ($dadosbl['NumDocumento']);	// Num do pedido ou do documento

$dadosboleto["data_vencimento"] = $data_venc_formatada; // Data de Vencimento do Boleto - REGRA: Formato DD/MM/AAAA
$dadosboleto["data_documento"] = date("d/m/Y"); // Data de emissão do Boleto
$dadosboleto["data_processamento"] = date("d/m/Y"); // Data de processamento do boleto (opcional)
$dadosboleto["valor_boleto"] = $valor_boleto; 	// Valor do Boleto - REGRA: Com v�rgula e sempre com duas casas depois da virgula


// DADOS DO SEU CLIENTE
$dadosboleto["sacado"] = $dadosblDn[0];
$dadosboleto["endereco1"] = $dadosblDn[1];
$dadosboleto["endereco2"] = $dadosblDn[2];
$dadosboleto["pessnmrf_sacado"] = $dadosblDn[3];

// INFORMACOES PARA O CLIENTE

$dadosboleto["demonstrativo1"] = $taxa_boleto;
$dadosboleto["demonstrativo2"] = $dadosbl['inst_cliente1'];
$dadosboleto["demonstrativo3"] = $dadosbl['inst_cliente2'];

$dadosboleto["instrucoes1"] = $dadosbl['instrucao1'];
$dadosboleto["instrucoes2"] = $dadosbl['instrucao2'];
$dadosboleto["instrucoes3"] = $dadosbl['instrucao3'];
$dadosboleto["instrucoes4"] = $dadosbl['instrucao4'];

// DADOS OPCIONAIS DE ACORDO COM O BANCO OU CLIENTE
$dadosboleto["quantidade"] = "10";
$dadosboleto["valor_unitario"] = "10";
$dadosboleto["aceite"] = "N";		
$dadosboleto["uso_banco"] = ""; 	
$dadosboleto["especie_doc"] = "DM";


// ---------------------- DADOS FIXOS DE CONFIGURAção DO SEU BOLETO --------------- //


// DADOS DA SUA CONTA - BANCO DO BRASIL
$dadosboleto["agencia"] = $dadosbl['agencia']; // Num da agencia, sem digito
$dadosboleto["conta"] = $dadosbl['conta']; 	// Num da conta, sem digito

// DADOS PERSONALIZADOS - BANCO DO BRASIL
$dadosboleto["convenio"] = $dadosbl['convenio'];  // Num do conv�nio - REGRA: 6 ou 7 ou 8 d�gitos
$dadosboleto["contrato"] = $dadosbl['contrato']; // Num do seu contrato
$dadosboleto["carteira"] = $dadosbl['carteira'];
$dadosboleto["variacao_carteira"] = "-019";  // Variação da Carteira, com tra�o (opcional)

// TIPO DO BOLETO
$dadosboleto["formatacao_convenio"] = strlen($dadosbl['convenio']); // REGRA: 8 p/ Conv�nio c/ 8 d�gitos, 7 p/ Conv�nio c/ 7 d�gitos, ou 6 se Conv�nio c/ 6 d�gitos
$dadosboleto["formatacao_nosso_numero"] = strlen($compNossoNumero) == 6 ? '1':'2'; // REGRA: Usado apenas p/ Conv�nio c/ 6 d�gitos: informe 1 se for NossoN�mero de até 5 d�gitos ou 2 para opção de até 17 d�gitos

/*
#################################################
DESENVOLVIDO PARA CARTEIRA 18

- Carteira 18 com Convenio de 8 digitos
  Nosso Número: pode ser até 9 d�gitos

- Carteira 18 com Convenio de 7 digitos
  Nosso Número: pode ser até 10 d�gitos

- Carteira 18 com Convenio de 6 digitos
  Nosso Número:
  de 1 a 99999 para opção de até 5 d�gitos
  de 1 a 99999999999999999 para opção de até 17 d�gitos

#################################################
*/


// SEUS DADOS

$dadosboleto["identificacao"] = $dadosbl['identificacao'];
$dadosboleto["pessnmrf"] = $dadosbl['pessnmrf'];
$dadosboleto["endereco"] = $dadosbl['endereco'];
$dadosboleto["cidade_uf"] = $dadosbl['cidade_ur'];
$dadosboleto["cedente"] = $dadosbl['cedente'];

// não ALTERAR!
include("include/funcoes_bb.php"); 
include("include/layout_bb.php");
?>
