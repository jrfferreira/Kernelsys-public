<?php

// ------------------------- DADOS DIN�MICOS DO SEU CLIENTE PARA A GERAção DO BOLETO (FIXO OU VIA GET) -------------------- //
// Os valores abaixo podem ser colocados manualmente ou ajustados p/ formulário c/ POST, GET ou de BD//

// GERA VETOR Q PREECHE OS CAMPOS DO BOLETO APARTIR DO TXT
//include_once("InjetDados.php");


// ---------------------- DADOS FIXOS DE CONFIGURAção DO SEU BOLETO --------------- //

// DADOS DA SUA CONTA - CEF
$dadosboleto["agencia"] = $dadosbl['agencia']; // Num da agencia, sem digito

// DADOS PERSONALIZADOS - CEF
$dadosboleto["conta_cedente"] = $dadosbl['conta']; // ContaCedente do Cliente, sem digito (Somente N�meros)
$dadosboleto["conta_cedente_dv"] = $dadosbl['digito']; // Digito da ContaCedente do Cliente
$dadosboleto["carteira"] = $dadosbl['carteira']; // código da Carteira: pode ser SR (Sem Registro) ou CR (Com Registro) - (Confirmar com gerente qual usar)

// SEUS DADOS
$dadosboleto["identificacao"] = $dadosbl['identificacao'];
$dadosboleto["pessnmrf"] = $dadosbl['pessnmrf'];
$dadosboleto["endereco"] = $dadosbl['endereco'];
$dadosboleto["cidade_uf"] = $dadosbl['cidade_ur'];
$dadosboleto["cedente"] = $dadosbl['cedente'];

// DADOS DE CONFIGURAção DO BOLETO PARA O SEU CLIENTE
$taxa_boleto = $dadosbl['taxa_administrativa'];
$dadosboleto["especie"] = $dadosbl['moeda'];
 
// valor do documento
$valor_cobrado = $dadosblDn[4];
$valor_cobrado = str_replace(",", ".",$valor_cobrado);
$valor_boleto = number_format($valor_cobrado+$taxa_boleto, 2, ',', '');


$dadosboleto["inicio_nosso_numero"] = 0; // Carteira SR: 80, 81 ou 82  -  Carteira CR: 90 (Confirmar com gerente qual usar)
    /*
     * O Nosso Número no SIGCB � composto de 17 posições, sendo as 02 posições iniciais para identificar a
     * Carteira e as 15 posições restantes são para livre utilização pelo Cedente.
     */
$dadosboleto["nosso_numero"] = $compNossoNumero;
$dadosboleto["numero_documento"] = ($dadosbl['NumDocumento']);	// Num do pedido ou do documento

$dadosboleto["data_vencimento"] = $data_venc_formatada; // Data de Vencimento do Boleto - REGRA: Formato DD/MM/AAAA
$dadosboleto["data_documento"] = date("d/m/Y"); // Data de emissão do Boleto
$dadosboleto["data_processamento"] = date("d/m/Y"); // Data de processamento do boleto (opcional)
$dadosboleto["valor_boleto"] = $valor_boleto; 	// Valor do Boleto - REGRA: Com v�rgula e sempre com duas casas depois da virgula

// INSTRUções PARA O CAIXA
$dadosboleto["instrucoes1"] = $dadosbl['instrucao1'];
$dadosboleto["instrucoes2"] = $dadosbl['instrucao2'];
$dadosboleto["instrucoes3"] = $dadosbl['instrucao3'];
$dadosboleto["instrucoes4"] = $dadosbl['instrucao4'];
//$dadosboleto["instrucoes"] = $dadosbl['instrucoes'];


// DADOS DO SEU CLIENTE
$dadosboleto["sacado"] = $dadosblDn[0];
$dadosboleto["endereco1"] = $dadosblDn[1];
$dadosboleto["endereco2"] = $dadosblDn[2];
$dadosboleto["pessnmrf_sacado"] = $dadosblDn[3];

// INFORMACOES PARA O CLIENTE
$dadosboleto["demonstrativo1"] = $taxa_boleto;
$dadosboleto["demonstrativo2"] = $dadosbl['inst_cliente1'];
$dadosboleto["demonstrativo3"] = $dadosbl['inst_cliente2'];

// DADOS OPCIONAIS DE ACORDO COM O BANCO OU CLIENTE
$dadosboleto["quantidade"] = "";
$dadosboleto["valor_unitario"] = "";
$dadosboleto["aceite"] = "";		
$dadosboleto["uso_banco"] = ""; 	
$dadosboleto["especie_doc"] = "";


// não ALTERAR!
include("include/funcoes_cef.php"); 
include("include/layout_fibra.php");
echo $htmlBoleto;
//include_once("GetDadosBL.php");
?>
