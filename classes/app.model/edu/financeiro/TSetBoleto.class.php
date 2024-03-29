﻿<?php
//========================================================
// Objeto que carregao boleto bancario CFE
// 29/11/2008
//========================================================

class TSetBoleto {

    private $dadosC 	= NULL;
    //Dados do sacado
    private $infoSacado 	= NULL;
    //dados gerados pelo boleto
    private $dadosBoleto = NULL;
    
    public $boleto = NULL;

    public function __construct($parcseq, $cofiseq) {

        // estarta o buffer de saida
        //ob_start();

        $criteriaInfo = new TCriteria();
        $criteriaInfo->add(new TFilter('cofiseq','=',$cofiseq));
        $dboInfo = new TDbo(TConstantes::DBBOLETO_ESTRUTURA);
        $qDados = $dboInfo->select("*", $criteriaInfo);

        $this->dadosC = $qDados->fetch();

        $this->mascara = new TSetMascaras();
        $this->setModel = new TSetModel();

        // gera registro do boleto na base de dados dbduplicatas
        $dboInDuplic = new TDbo(TConstantes::DBBOLETO);
        $this->boleto = $dboInDuplic->insert(array("statseq"=>"1",'parcseq'=>$parcseq));

        if($this->boleto) {
            $this->seq = $this->boleto['seq'];
        }
        else {
            exit('O historico do boleto não pode ser gerado');
        }
    }

    // Carraga dados do sacado vai vetor
    // p1 = Nome do sacado
    // p2 = codigo do cliente
    // p3 = codigo do conta credito
    // p4 = Endere�o
    // p5 = Endere�o 2
    // p6 = CPF - CNPJ
    public function setSacado($infoSacado) {
        if(is_array($infoSacado)) {
            $this->infoSacado = $infoSacado;
        }
    }

    /**
     * Configura o valor do boleto
     * param $valor = valor do boleto
     */
    public function setValor($valor) {
        if(is_numeric($valor)) {
            $this->infoSacado[4] = $valor;
        }
        else {
            new setException("ERRO - Valor do documento é Invalido. Linha 59 - TSetBoleto");
            exit();
        }
    }

    /*
    * Configura desconto
    */
    public function setDesconto($valor) {
        $this->desconto = $valor;

    }

    public function setInstrucoesParcelamento($texto){
        $this->instrucoesParcelamento = $texto;

    }
    public function setInstrucoes($texto,$posicao = null){
        if(!$posicao){
          $this->instrucoesPagamento = $texto;
      }else{
          $this->instrucoesPagamento[$posicao] = $texto;        	
      }
  }
    /*
     * Seta o prazo de dias a partir da data de vencimento
    */
    public function setPrazo($prazo) {
        $this->dadosC['dias_prazo'] = $prazo;
    }

    /*
    * Seta data de vencimento do boleto
    */
    public function setVencimento($data) {
        //date("d/m/Y", time() + ($dias_de_prazo_para_pagamento * 86400));
        $this->data_venc = $data;
    }

    public function setInformacaoFatura($infoFatura){
        $this->infoFatura = $infoFatura;
    }

    public function setDetalhamento($array){
        $this->detalhamento = $array;
    }
    /*
    * Gera o boleto
    */
    public function showBoleto() {

        //dados do cedente
        $dadosbl = $this->dadosC;
        $dadosbl['NumDocumento'] = $this->boleto['seq'];


        //Formata parte contadora do nosso Número=============
        //calcula zeros necessarios
        $compNossoNumero = $dadosbl['prefixo_nosso_numero'] . sprintf('%0'.$dadosbl['digitos_nosso_numero'].'s', $this->seq);
        //=====================================================

        //dados do sacado
        foreach($this->infoSacado as $k=>$d) {
            $dadosblDn[$k] =   $d;
        }


        if($this->instrucoesPagamento){
        	if(is_array($this->instrucoesPagamento)){
        		foreach($this->instrucoesPagamento as $ch => $vl){
                 $dadosbl['instrucao'.$ch] = $vl;        			
             }
         }else{
            $dadosbl['instrucao3'] = $this->instrucoesPagamento;
        }
    }
    if($this->infoFatura){
        $dadosbl['infoFatura'] = $this->infoFatura;
    }
    if($this->instrucoesParcelamento){
        $dadosbl['parcelamento'] = $this->instrucoesParcelamento;
    }
    if($this->detalhamento){
        $dadosbl['detalhamento'] = $this->detalhamento;
    }


        //formata data para Impressão do boleto
    $data_venc_formatada = $this->mascara->setData($this->data_venc);


        //Imprime o boleto ========================
    include_once($this->dadosC['template']);
    $this->bkpHTML = $htmlBoleto;
        //===========================================

        // Verifica o campo data a ser aplicada na expressão do filtro padrão ======
    $dadosboleto["data_processamento"] = $this->mascara->setData($dadosboleto["data_processamento"]);
        //==========================================================================

    $this->dadosBoleto[0] = $nossonumero;
    $this->dadosBoleto[1] = $dadosboleto["data_processamento"];
    $this->dadosBoleto[2] = $valor_boleto;
    $this->dadosBoleto[3] = $this->data_venc;

    $this->dadosSacado = $dadosblDn;
}

    /*
    * grava os dados do boleto em baco de dados pra compensação posterior
    */
    public function load($classific) {

        try {

            if($this->dadosSacado[3] and $this->dadosSacado[4]) {

                $args["parcseq"] = $this->infoSacado['parcseq'];
                $args["nDocumento"] = $this->dadosBoleto[0];
                //$args["dataProcesso"] = $this->mascara->setDataDb($this->dadosBoleto[1]);
                $args["cpfSacado"] = $this->dadosSacado[3];
                $args["valordoc"] = $this->dadosSacado[4];
                $args["vencimento"] = $this->data_venc;
                $args["tipoboleto"] = $this->dadosC['tipoboleto'];
                $args["classificacao"] = $classific;
                $args["bkp"] = $this->bkpHTML;
                
                $criteriaDup = new TCriteria();
                $criteriaDup->add(new TFilter('seq','=',$this->seq));

                $dboUp = new TDbo(TConstantes::DBBOLETO);
                $dboUp->update($args, $this->seq);
                $dboUp->commit();

            }else {
                // se não existir, lança um erro
                new setException('Erro nos dados do sacado ao atualizar a duplicata. Linha 113 - TSetBoleto');
            }

        }
        catch(Exception $e) {
            new setException("ERRO AO GRAVAR BOLETO - <br><bR>\n".$e);
        }

    }

    /*
    *
    */
    public function getDados() {
        if(is_array($this->dadosBoleto)) {
            return $this->dadosBoleto;
        }
    }

}