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
// | PHPBoleto de Jo�o Prado Maia e Pablo Martins F. Costa				  |
// | 																	  |
// | Se vc quer colaborar, nos ajude a desenvolver p/ os demais bancos :-)|
// | Acesse o site do Projeto BoletoPhp: www.boletophp.com.br             |
// +----------------------------------------------------------------------+

// +----------------------------------------------------------------------+
// | Equipe Coordenação Projeto BoletoPhp: <boletophp@boletophp.com.br>   |
// | Desenvolvimento Boleto Sudameris: Fl�vio Yutaka Nakamura             |
// +----------------------------------------------------------------------+


// ------------------------- DADOS DIN�MICOS DO SEU CLIENTE PARA A GERAção DO BOLETO (FIXO OU VIA GET) -------------------- //
// Os valores abaixo podem ser colocados manualmente ou ajustados p/ formulário c/ POST, GET ou de BD (MySql,Postgre,etc)	//

// DADOS DO BOLETO PARA O SEU CLIENTE
$dias_de_prazo_para_pagamento = 5;
$taxa_boleto = 2.95;
$data_venc = date("d/m/Y", time() + ($dias_de_prazo_para_pagamento * 86400));  // Prazo de X dias OU informe data: "13/04/2006"; 
$valor_cobrado = "2950,00"; // Valor - REGRA: Sem pontos na milhar e tanto faz com "." ou "," ou com 1 ou 2 ou sem casa decimal
$valor_cobrado = str_replace(",", ".",$valor_cobrado);
$valor_boleto=number_format($valor_cobrado+$taxa_boleto, 2, ',', '');

$dadosboleto["nosso_numero"] = "3020";		// Nosso numero - REGRA: M�ximo de 13 n�meros p/ carteira 57 (Sem registro), e 7 n�meros p/ carteira 20 (Com registro)
$dadosboleto["numero_documento"] = "1234567";		// Número do pedido ou do documento (A seu critério)
$dadosboleto["data_vencimento"] = $data_venc; // Data de Vencimento do Boleto - REGRA: Formato DD/MM/AAAA
$dadosboleto["data_documento"] = date("Y-m-d"); // Data de emiss�o do Boleto
$dadosboleto["data_processamento"] = date("Y-m-d"); // Data de processamento do boleto (opcional)
$dadosboleto["valor_boleto"] = $valor_boleto; 	// Valor do Boleto - REGRA: Com v�rgula e sempre com duas casas depois da virgula

// DADOS DO SEU CLIENTE
$dadosboleto["sacado"] = "Jos� da Silva";
$dadosboleto["endereco1"] = "Rua ABC, 123";
$dadosboleto["endereco2"] = "são Paulo - SP - CEP: 010200-000";

// INFORMACOES PARA O CLIENTE
$dadosboleto["demonstrativo1"] = "Pagamento de Compra na Loja Nonononono";
$dadosboleto["demonstrativo2"] = "Mensalidade referente a nonon nonooon nononon<br>Taxa banc�ria - R$ ".$taxa_boleto;
$dadosboleto["demonstrativo3"] = "BoletoPhp - http://www.boletophp.com.br";

// INSTRUções PARA O CAIXA
$dadosboleto["instrucoes1"] = "- Sr. Caixa, cobrar multa de 2% ap�s o vencimento";
$dadosboleto["instrucoes2"] = "- Receber até 10 dias ap�s o vencimento";
$dadosboleto["instrucoes3"] = "- Em caso de d�vidas entre em contato conosco: xxxx@xxxx.com.br";
$dadosboleto["instrucoes4"] = "&nbsp; Emitido pelo sistema Projeto BoletoPhp - www.boletophp.com.br";

// DADOS OPCIONAIS DE ACORDO COM O BANCO OU CLIENTE
$dadosboleto["quantidade"] = "";
$dadosboleto["valor_unitario"] = "";
$dadosboleto["aceite"] = "";		
$dadosboleto["uso_banco"] = ""; 	
$dadosboleto["especie"] = "R$";

// Espécie do Titulo
/*
DM	Duplicata Mercantil
DMI	Duplicata Mercantil p/ Indicação
DS	Duplicata de Servi�o
DSI	Duplicata de Servi�o p/ Indicação
DR	Duplicata Rural
LC	Letra de C�mbio
NCC Nota de Cr�dito Comercial
NCE Nota de Cr�dito a Exportação
NCI Nota de Cr�dito Industrial
NCR Nota de Cr�dito Rural
NP	Nota Promiss�ria
NPR	Nota Promiss�ria Rural
TM	Triplicata Mercantil
TS	Triplicata de Servi�o
NS	Nota de Seguro
RC	Recibo
FAT	Fatura
ND	Nota de D�bito
AP	Ap�lice de Seguro
ME	Mensalidade Escolar
PC	Parcela de Cons�rcio
*/
$dadosboleto["especie_doc"] = "DM";


// ---------------------- DADOS FIXOS DE CONFIGURAção DO SEU BOLETO --------------- //


// DADOS DA SUA CONTA - SUDAMERIS
$dadosboleto["agencia"]       = "0501";		// Número da agencia, sem digito
$dadosboleto["conta"]         = "6703255";	// Número da conta, sem digito
$dadosboleto["carteira"]      = "57";		// Deve possuir conv�nio - Carteira 57 (Sem Registro) ou 20 (Com Registro)

// SEUS DADOS
$dadosboleto["identificacao"] = "BoletoPhp - código Aberto de Sistema de Boletos";
$dadosboleto["pessnmrf"] = "";
$dadosboleto["endereco"] = "Rua Central, 123";
$dadosboleto["cidade_uf"] = "Curitiba - PR";
$dadosboleto["cedente"] = "Alcantara & Schmidt Ltda.";

// não ALTERAR!
include("include/funcoes_sudameris.php");
include("include/layout_sudameris.php");
?>
