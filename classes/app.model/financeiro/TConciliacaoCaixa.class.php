<?php

/**
 * Description of TConciliacaoCaixa
 *
 * author Wagner
 */
class TConciliacaoCaixa{

    public function __construct(){

        $this->function['0'] = 'setHeader';
        $this->function['1'] = 'setHeaderLote';
        $this->function['2'] = false;
        $this->function['3']['T'] = 'setDetalheT';
        $this->function['3']['U'] = 'setDetalheU';
        $this->function['4'] = false;
        $this->function['5'] = 'setTrailLote';
        $this->function['9'] = 'setTrailerArq';
    }

    /**
     * Compila um arquivo de retorno do banco e retorna um vetor com os dados
     * param $path = caminho do arquivo a ser compilado
     */
    private function compilaRetorno($path){
        $arquivo = file($path, FILE_IGNORE_NEW_LINES);
        
        foreach($arquivo as $index=>$line){

            $tipo_registro = substr($line, 7, 1);
            $func = $this->function[$tipo_registro];

                //acessa segmentos [T] e [U]
                if(is_array($func)){
                    $segmento = substr($line, 13, 1);
                    $func = $func[$segmento];
                }
                
            if($func){
                $vetor = $this->$func(0, 0);
                $inicio = 0;
                foreach($vetor as $chav=>$numChr){

                   $fim = strlen($numChr);
                   $linha[$chav] = substr($line, $inicio, $fim);
                   $inicio = $inicio+$fim;
                }
                $linhas[$func.'_'.$index] = $linha;
                $linha = array();
            }
        }
           return $linhas;
    }

    /*
     * Compila aquivo remessa para o banco
     */
    public function compilaRemessa(){

    }

    /**
     * Valinda campos do vetor
     */
    private function valida($vertor, $chave, $valor){

        // valida tamanho do campo
        if(strlen($vetor[$chave]) == strlen($valor)){
           $vetor[$chave] = $valor;
        }else{
           new setException("O campo informado exige (".strlen($vetor[$chave]).") caracteres");
        }

        return $vetor;
    }


    /*
    * Executa concilia~ao e baixa conta do coixa
    */
    public function runConciliacao($arquivo){

        $vetorDados = $this->compilaRetorno($arquivo);

        $obMasc = new TSetMascaras();

            //acessa dados do boleto [dbdados_boleto]
            $dboDadosBoleto = new TDbo(TConstantes::DBDADOS_BOLETO);
                $criteriaBoleto = new TCriteria();
                $criteriaBoleto->add(new TFilter('ativo','=','1'));
            $retDadosBoleto =   $dboDadosBoleto->select('codigocontacaixa', $criteriaBoleto);
            $obDadosBoleto = $retDadosBoleto->fetchObject();

        foreach($vetorDados as $idx=>$dados){

            //filtra dados de retorno da transacao (Seguimento T e seguimento U)
            if($dados["tipo_registro"] == "3"){

                //fintro o tipo de seguimento
                if($dados['servico_seguimento'] == 'T'){

                    //formata [nosso_numero]
                    if($dados['modalidade_nossoNum'] and $dados['nosso_numero']){
                        $nosso_num = $dados['modalidade_nossoNum'].$dados['nosso_numero']."-".$dados['uso_caixa03'];
                    }

                    $dadosRet['nosso_numero']    = $nosso_num;
                    $dadosRet['valor_nominal']   = $this->setValor($dados['valor_nominalTitulo']);
                    $dadosRet['data_vencimento'] = $this->setData($dados['data_vencimento']);
                    $dadosRet['valor_tarifa']    = $this->setValor($dados['valor_tarifa']);
                }
                elseif($dados['servico_seguimento'] == 'U'){

                    $dadosRet['valor_desconto']       = $this->setValor($dados['dTitulos_valor_desconto']);
                    $dadosRet['valor_pago']           = $this->setValor($dados['dTitulos_valor_pago']);//valor real pago pelo cliente
                    $dadosRet['valor_liquido']        = $this->setValor($dados['dTitulos_valor_liquido']);//valor apos descontos acrecimos e abatimentos
                    $dadosRet['data_pagamento']       = $this->setData($dados['data_ocorrencia']);
                    $dadosRet['data_credito']         = $this->setData($dados['data_credito']);
                    $dadosRet['data_debito_tarifa']   = $this->setData($dados['data_debito_tarifa']);


                 //acessa duplicatas
                 $dboDup = new TDbo(TConstantes::DBTRANSACOES_CONTAS_DUPLICATAS);
                    $criteriaDup = new TCriteria();
                    $criteriaDup->add(new TFilter('ndocumento','=',$dadosRet['nosso_numero']));
                 $retDup =  $dboDup->select("*", $criteriaDup);
                 $obDup = $retDup->fetchObject();

                     //Verifia a existencia da duplicata e executa a baixa da conta no caixa
                     if($obDup->ndocumento == $dadosRet['nosso_numero']){

                         //retorna  pessoa
                         $dboPessoa = new TDbo(TConstantes::DBPESSOAS);
                            $criteriaPessoa = new TCriteria();
                            $criteriaPessoa->add(new TFilter("codigo","=",$obDup->codigopessoa));
                         $retPessoa = $dboPessoa->select('nome_razaosocial', $criteriaPessoa);
                         $obPessoa = $retPessoa->fetchObject();

                        $rowRet = new TElement('div');
                        $rowRet->style = "font-family:arial; font-size:14px; border:1px solid #CCC; margin:1px; padding:4px;";
                        $rowRet->add('<span class="tlabel">Nome do Sacado:</span> '.$obPessoa->nome_razaosocial.'<br>');
                        $rowRet->add('<span class="tlabel">N. do documento:</span> '.$dadosRet['nosso_numero'].'<br>');
                        $rowRet->add('<span class="tlabel">Valor nominal:</span> '.$obMasc->setValor($dadosRet['valor_nominal']).'<br>');
                        $rowRet->add('<span class="tlabel">Valor do desconto:</span> '.$obMasc->setValor($dadosRet['valor_desconto']).'<br>');
                        $rowRet->add('<span class="tlabel">Valor pago:</span> '.$obMasc->setValor($dadosRet['valor_pago']).'<br>');
                        $rowRet->add('<span class="tlabel">Data do pagamento:</span> '.$obMasc->setData($dadosRet['data_pagamento']).'<br>');
                           // valida baixa já realizada da duplicata
                           
                           if($obDup->statusduplicata == '1' || $obDup->statusduplicata == '9' ){
                                //baixa conta
                                $obCaixa = new TCaixa();
                                $obCaixa->baixaContaCaixa($obDup->codigoconta, $dadosRet['valor_pago'], $dadosRet['valor_desconto'], 0.00, $dadosRet['nosso_numero'], 'Boleto Caixa', $obDadosBoleto->codigocontacaixa);
                                
                                $retBaixada = new TElement('div');
                                $retBaixada->style = "font-family:arial; font-size:14px; border:1px solid #CCC; margin:1px; padding:4px;";
	                            if($obCaixa){
	                                //modifica status da duplicata baixada
	                                $dboDupUp = new TDbo(TConstantes::DBTRANSACOES_CONTAS_DUPLICATAS);
	                                    $criteriaDupUp = new TCriteria();
	                                    $criteriaDupUp->add(new TFilter('codigo','=',$obDup->codigo));
	                                $dboDupUp->update(array('dataBaixa'=>date("Y-m-d"), 'statusDuplicata'=>2), $criteriaDupUp);
	                                
	                                if($obDup->statusduplicata == '9'){
	                                	$retBaixada->add(TMensagem::MSG_SUCESSO_BAIXAR_BOLETO_INATIVO);
	                                }else{
	                                	$retBaixada->add(TMensagem::MSG_SUCESSO_BAIXAR_CONTA);
	                                }
	                                $rowRet->add($retBaixada);
	                            }else{
	                                print_r($obCaixa);
	                                $rowRet->add($retBaixada);                            	
	                            }

                           }
                           else{
                                $retBaixada = new TElement('div');
                                $retBaixada->style = "font-family:arial; font-size:14px; border:1px solid #CCC; margin:1px; padding:4px;";
                                if($obDup->statusduplicata == '2'){
                                	$retBaixada->add(TMensagem::MSG_CONTA_BAIXADA);
                                }elseif($obDup->statusduplicata == '9'){
                                	$retBaixada->add(TMensagem::MSG_BOLETO_INATIVO);
                                }
                                $rowRet->add($retBaixada);
                           }
                           
                           
                           $rowRet->show();
                            

                        //zera dados
                        $dadosRet = array();

                     }else{//retorno do reconhecimento da duplicata no DB

                        $rowRet = new TElement('div');
                        $rowRet->style = "font-family:arial; font-size:14px; border:1px solid #CCC; margin:1px; padding:4px;";
                        $rowRet->add('<span class="tlabelDestaque">Não foram encontrados registros associados ao boleto de N°: </span> '.$dadosRet['nosso_numero'].'<br>');
                        $rowRet->add('<span class="tlabelDestaque">Valor nominal:</span> '.$obMasc->setValor($dadosRet['valor_nominal']).'<br>');
                        $rowRet->add('<span class="tlabelDestaque">Valor do desconto:</span> '.$obMasc->setValor($dadosRet['valor_desconto']).'<br>');
                        $rowRet->add('<span class="tlabelDestaque">Valor da tafifa:</span> '.$obMasc->setValor($dadosRet['valor_tarifa']).'<br>');
                        $rowRet->add('<span class="tlabelDestaque">Valor pago:</span> '.$obMasc->setValor($dadosRet['valor_pago']).'<br>');
                        $rowRet->add('<span class="tlabelDestaque">Data do pagamento:</span> '.$obMasc->setData($dadosRet['data_pagamento']).'<br>');
                        $rowRet->show();

                     }

                }

            }
        }
    }
    
    //configura valor recebido
    private function setValor($valor){
        
        $valAbs = abs($valor);
        $dec = substr($valAbs, -2);
        $int = substr($valAbs, 0, -2);
        $val = $int.'.'.$dec;

        return $val;
    }

    //configura data para o formato padrao
    private function setData($data){
        $d = substr($data, 0, 2);
        $m = substr($data, 2, 2);
        $y = substr($data, 4, 4);

        $data = $y.'-'.$m.'-'.$d;
        return $data;
    }


    /**
     * Gera linha do Registro Header de Arquivo
     * param chave = recebe a chave que identifica a posição do vertor
     * param valor = recebe o valor a ser atribuido a posição.
     */
    public function setHeader($chave, $valor){

        // Controle ------------------------------------------------------------
        $dados['banco']    = '104';
        $dados['Lote']     = '0000';
        $dados['Registro'] = '0'; // tipo do registro (linha) 0 = header de arquivo
        $dados['CNAB']     = '         ';//Texto de observações destinado para uso exclusivo da FEBRABAN. Preencher com Brancos.
        // Empresa -------------------------------------------------------------
        $dados['inscricao_tipo']   = '0';
        $dados['inscricao_numero'] = '00000000000000';
        $dados['uso_caixa01']      = '00000000000000000000';
        $dados['agencia_codigo']   = '00000';
        $dados['agencia_dv']       = 'x';
        $dados['codigo_cedente']   = '000000';
        $dados['uso_caixa02']      = '0000000';
        $dados['uso_caixa03']      = '0';
        $dados['nome_empresa']     = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        $dados['dnome_banco']      = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        $dados['CNAB_02']          = '          ';
        // Arquivo -------------------------------------------------------------
        $dados['arquivo_codigo']    = '0';
        $dados['arquivo_dataGer']   = '00000000';
        $dados['arquivo_horaGer']   = '000000';
        $dados['arquivo_seqNum']    = '000000';
        $dados['arquivo_layoutNum'] = '050';
        $dados['arquivo_densidade'] = '00000';
        $dados['res_banco']         = 'xxxxxxxxxxxxxxxxxxxx';
        $dados['res_empresa']       = 'xxxxxxxxxxxxxxxxxxxx';
        $dados['versao_aplicativo'] = '0000';
        $dados['CNAB_03'] = '                         ';

            if($chave and $valor){
                $dados = $this->valida($dados, $chave, $valor);
            }

        return $dados;
    }

     /**
     * Gera linha Registro Header de Lote
     * param chave = recebe a chave que identifica a posição do vertor
     * param valor = recebe o valor a ser atribuido a posição.
     */
    public function setHeaderLote($chave, $valor){

        // Controle ------------------------------------------------------------
        $dados['controle_banco']    = '104';
        $dados['controle_lote']     = '0000';
        $dados['controle_registro'] = '3';
        // Servi�o --------------------------------------------------------------
        $dados['servico_operacao'] = '0';
        $dados['servico']          = '00';
        $dados['servico_CNAB']     = '  ';
        $dados['servico_layout']   = '030';
        $dados['CNAB'] = ' ';
        // Empresa -------------------------------------------------------------
        $dados['inscricao_tipo']    = '0';
        $dados['inscricao_numero']  = '000000000000000';
        $dados['empresa_cedente']   = '000000';
        $dados['uso_caixa01']       = '00000000000000';
        $dados['agencia_codigo']    = '00000';
        $dados['agencia_dv']        = '0';
        $dados['codigo_cedente']    = '000000';
        $dados['codigo_ModPer']     = '0000000';
        $dados['uso_caixa02']       = '0';
        $dados['nome_empresa']      = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        $dados['CNAB_02']           = '          ';
        // Informações ---------------------------------------------------------
        $dados['informacao_01']     = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        $dados['informacao_02']     = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        // Controle de Cobran�a ------------------------------------------------
        $dados['num_rem_ret']   = '00000000';
        $dados['data_gravacao'] = '00000000';

        $dados['data_credito'] = '00000000';
        $dados['CNAB_03']      = '                                 ';

            if($chave and $valor){
                $dados = $this->valida($dados, $chave, $valor);
            }

           return $dados;
    }

    /**
     * Gera linha Registro Detalhe( registro da movimentação - conteudo do arquivo)
     * Segmento P (Obrigat�rio - Remessa) Informações da remessa
     * param chave = recebe a chave que identifica a posição do vertor
     * param valor = recebe o valor a ser atribuido a posição.
     */
    public function setDetalheP($chave, $valor){
        
         // Controle -----------------------------------------------------------
        $dados['controle_banco']    = '104';
        $dados['controle_lote']     = '0000';
        $dados['tipo_registro'] = '3';
        // Servi�o -------------------------------------------------------------
        $dados['servico_numRegistro'] = '00000';
        $dados['servico_seguimento']  = 'P';
        $dados['servico_CNAB']     = ' ';
        $dados['servico_codMov']   = '00';
        // Codigo Identificação ------------------------------------------------
        $dados['agencia_codigo']    = '00000';
        $dados['agencia_dv']        = '0';
        $dados['codigo_cedente']    = '000000';

        $dados['uso_caixa01']       = '00000000000';
        // Carteira/Nosso Número -----------------------------------------------
        $dados['modalidade_carteira'] = '00';
        $dados['id_tituloBanco']      = '000000000000000';
        // Caracter�stica Cobrança ---------------------------------------------
        $dados['cod_carteira']        = '0';
        $dados['forma_cadastramento'] = '0';
        $dados['tipo_documento']      = '0';
        $dados['id_emissaoBloqueto']  = '0';
        $dados['id_entregaBloqueto']  = '0';

        $dados['num_documento']  = '00000000000';
        $dados['uso_caixa02']    = '0000';
        $dados['data_vecimento'] = '00000000';
        $dados['valor_nominalTitulo']  = '000000000000000';// 2 decimais
        $dados['agencia_cobradora']    = '00000';
        $dados['agencia_cobradora_dv'] = '0';
        $dados['especie_titulo']       = '00';
        $dados['aceite']               = '0';
        $dados['data_emissaoTitulo']   = '00000000';
        // Juros ---------------------------------------------------------------
        $dados['cod_jurosMora']  = '0';
        $dados['data_jurosMora'] = '00000000';
        $dados['juros_mora']     = '000000000000000';// 2 decimais
        // Descontos 1 ---------------------------------------------------------
        $dados['cod_desconto1']  = '0';
        $dados['data_desconto']     = '00000000';
        $dados['valor_desconto']     = '000000000000000';// 2 decimais / O valor do desconto pode ser em %

        $dados['valor_iof']        = '000000000000000';// 2 decimais
        $dados['valor_abatimento'] = '000000000000000';// 2 decimais
        $dados['nosso_id_titulo']  = '0000000000000000000000000';// nosso identificador do titulo no sistema
        $dados['cod_protexto']     = '0';
        $dados['prazo_protexto']   = '00';
        $dados['cod_baixa_devolucao']   = '000';
        $dados['prazo_baixa_devolucao']   = '000';
        $dados['cod_moeda']   = '00';
        $dados['uso_caixa03'] = '0000000000';

        $dados['CNAB'] = ' ';

            if($chave and $valor){
                $dados = $this->valida($dados, $chave, $valor);
            }
        return $dados;
    }

    /**
     * Gera linha Registro Detalhe( registro da movimentação - conteudo do arquivo)
     * Segmento Q (Obrigat�rio - Remessa) Informações da remessa
     * param chave = recebe a chave que identifica a posição do vertor
     * param valor = recebe o valor a ser atribuido a posição.
     */
    public function setDetalheQ($chave, $valor){
        
        // Controle ------------------------------------------------------------
        $dados['controle_banco']    = '104';
        $dados['controle_lote']     = '0000';
        $dados['controle_registro'] = '3';
        // Servi�o -------------------------------------------------------------
        $dados['servico_numRegistro'] = '00000';
        $dados['servico_seguimento']  = 'Q';
        $dados['servico_CNAB']     = ' ';
        $dados['servico_codMov']   = '00';
        // Dados do sacado -----------------------------------------------------
        $dados['tipo_inscricao'] = '0';
        $dados['num_inscricao'] = '000000000000000';
        $dados['nome'] = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        $dados['endereco'] = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        $dados['bairro'] = 'xxxxxxxxxxxxxxx';
        $dados['cep'] = '00000';
        $dados['sufixo_cep'] = '000';
        $dados['cidade'] = 'xxxxxxxxxxxxxxx';
        $dados['uf'] = 'xx';
        // Sacado Avalista -----------------------------------------------------
        $dados['aval_tipo_inscricao'] = '0';
        $dados['aval_num_inscricao'] = '000000000000000';
        $dados['nome_avalista'] = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
        $dados['banco_correspondente'] = '000';
        $dados['nossoNum_bancoCorresp'] = 'xxxxxxxxxxxxxxxxxxxx';
        $dados['CNAB'] = '        ';

            if($chave and $valor){
                $dados = $this->valida($dados, $chave, $valor);
            }
        return $dados;
    }

     /**
     * Gera linha Registro Detalhe( registro da movimentação - conteudo do arquivo)
     * Segmento T (Obrigat�rio - Retorno) Informações da remessa
     * param chave = recebe a chave que identifica a posição do vertor
     * param valor = recebe o valor a ser atribuido a posição.
     */
    public function setDetalheT($chave, $valor){
        
        // Controle -----------------------------------------------------------
        $dados['controle_banco']    = '104';
        $dados['controle_lote']     = '0000';
        $dados['tipo_registro']     = '3';
        // Servi�o -------------------------------------------------------------
        $dados['servico_numRegistro'] = '00000';
        $dados['servico_seguimento']  = 'T';
        $dados['servico_CNAB']     = ' ';
        $dados['servico_codMov']   = '00';
        // Codigo Identificação ------------------------------------------------
        $dados['agencia_codigo']    = '00000';
        $dados['agencia_dv']        = '0';
        $dados['codigo_cedente']    = '000000';

        $dados['uso_caixa01']       = '000';
        $dados['num_banco_sacados'] = '000';
        $dados['uso_caixa02']       = '0000';
        // Nosso Número -----------------------------------------------
        $dados['modalidade_nossoNum'] = '00';
        $dados['nosso_numero']        = '000000000000000';
        $dados['uso_caixa03']         = '0';
        // Caracter�stica Cobrança ---------------------------------------------
        $dados['cod_carteira']           = '0';
        $dados['num_documento_cobranca'] = '00000000000';
        $dados['uso_caixa04']            = '0000';
        $dados['data_vencimento']        = '00000000';
        $dados['valor_nominalTitulo']    = '000000000000000';// 2 decimais
        $dados['cod_bancoCobrador']      = '000';
        $dados['agencia_cobradora']      = '00000';
        $dados['agencia_cobradora_dv']   = '0';
        $dados['id_titulo_empresa']      = '0000000000000000000000000';
        $dados['cod_moeda']   = '00';
        // Sacado --------------------------------------------------------------
        $dados['sacado_tipo_insc']  = '0';
        $dados['sacado_num_insc']   = '000000000000000';
        $dados['sacado_nome']       = '0000000000000000000000000000000000000000';

        $dados['CNAB_01']           = '          ';
        $dados['valor_tarifa']      = '000000000000000';// 2 decimais
        $dados['motivo_ocorrencia'] = 'xxxxxxxxxx';

        $dados['CNAB_02'] = '                 ';

            if($chave and $valor){
                $dados = $this->valida($dados, $chave, $valor);
            }
        return $dados;
    }

    /**
     * Gera linha Registro Detalhe( registro da movimentação - conteudo do arquivo)
     * Segmento U (Obrigat�rio - Retorno) Informações da remessa
     * param chave = recebe a chave que identifica a posição do vertor
     * param valor = recebe o valor a ser atribuido a posição.
     */
    public function setDetalheU($chave, $valor){
         // Controle -----------------------------------------------------------
        $dados['controle_banco']    = '104';
        $dados['controle_lote']     = '0000';
        $dados['tipo_registro']     = '3';
        // Servi�o -------------------------------------------------------------
        $dados['servico_numRegistro'] = '00000';
        $dados['servico_seguimento']  = 'U';
        $dados['servico_CNAB']        = ' ';
        $dados['servico_codMov']      = '00';
        // Dados do titulo -----------------------------------------------------
        $dados['dTitulos_acrecimos']       = '000000000000000';
        $dados['dTitulos_valor_desconto']  ='000000000000000';
        $dados['dTitulos_valor_abatimento']= '000000000000000';
        $dados['dTitulos_valor_iof']       = '000000000000000';
        $dados['dTitulos_valor_pago']      = '000000000000000';
        $dados['dTitulos_valor_liquido']   = '000000000000000';

        $dados['outras_despesas']          = '000000000000000';
        $dados['outros_creditos']          = '000000000000000';

        $dados['data_ocorrencia']          = '00000000';
        $dados['data_credito']             = '00000000';
        $dados['uso_caixa01']              = '0000';
        $dados['data_debito_tarifa']       = '00000000';
        $dados['codigo_sacado']            = '000000000000000';
        $dados['uso_caixa02']              = '000000000000000000000000000000';
        $dados['cod_banco_correspondente'] = '000';
        $dados['nosso_num_banco_corresp']  = '00000000000000000000';

        $dados['CNAB'] = '       ';

            if($chave and $valor){
                $dados = $this->valida($dados, $chave, $valor);
            }
        return $dados;
    }

     /**
     * Gera linha Registro Trailer de Lote
     * param chave = recebe a chave que identifica a posição do vertor
     * param valor = recebe o valor a ser atribuido a posição.
     */
    public function setTrailLote($chave, $valor){
        // Controle ------------------------------------------------------------
        $dados['controle_banco']    = '104';
        $dados['controle_lote']     = '9999';
        $dados['tipo_registro']     = '5';
        $dados['CNAB']              = '         ';

        $dados['quant_regs_lotes']      = '000000';

        // Totalização da Cobran�a Simples--------------------------------------
        $dados['quant_titulo_cobranca'] = '000000';
        $dados['valor_total_titulo_carteira'] = '00000000000000000';
        // Totalização da Cobran�a Descontada ----------------------------------
        $dados['quant_titulo_cob_desc'] = '000000';
        $dados['quant_titulo_carteira'] = '000000';

        $dados['CNAB_02']           = '                               ';
        $dados['CNAB_03']           = '                                                                                                                     ';

            if($chave and $valor){
                $dados = $this->valida($dados, $chave, $valor);
            }

        return $dados;
    }

     /**
     * Gera linha Registro Trailer de Arquivo
     * param chave = recebe a chave que identifica a posição do vertor
     * param valor = recebe o valor a ser atribuido a posição.
     */
    public function setTrailerArq($chave, $valor){
        // Controle ------------------------------------------------------------
        $dados['controle_banco']    = '104';
        $dados['controle_lote']     = '9999';
        $dados['controle_registro'] = '9';
        $dados['CNAB'] = '         ';
        // Totais --------------------------------------------------------------
        $dados['totais_quantLotes'] = '000000';
        $dados['totais_quantRegs']  = '000000';
        $dados['CNAB_02']           = '000000';
        $dados['CNAB_03']           = '                                                                                                                                                                                                             ';

            if($chave and $valor){
                $dados = $this->valida($dados, $chave, $valor);
            }

        return $dados;
    }

    /**
    * Retorna a um Element Iframe sentando a pagina de concilhação
    */
    public function setForm(){

        $iframe = new TElement('iframe');
        $iframe->src = "../app.pagina/conciliacaoCaixa.php";
        $iframe->frameborder = "0";
        $iframe->scrolling   = "auto";
        $iframe->name        = "concilaBanco";
        $iframe->id          = "concilaBanco";
        $iframe->width       = "100%";
        $iframe->height      = "80%";
        $iframe->add(" ");

        return $iframe;
        
    }

}