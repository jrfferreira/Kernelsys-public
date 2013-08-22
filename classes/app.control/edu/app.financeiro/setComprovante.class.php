<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class setComprovante{
    public function __construct($cod){
        
        
      $this->seqconta = $cod;

        $setConta = new TDbo(TConstantes::DBPARCELA);
                $criteriaContas = new TCriteria();
                $criteriaContas->add(new TFilter(TConstantes::SEQUENCIAL,'=',$this->seqconta));
        $retConta = $setConta->select("*",$criteriaContas);
        $obConta = $retConta->fetchObject();

        $setUnid = new TDbo(TConstantes::DBUNIDADE);
        $critUnid = new TCriteria();
        $critUnid->add(new TFilter("seq","=",$obConta->unidade));
        $retUnid = $setUnid->select("cidade",$critUnid);
        $obUnid = $retUnid->fetchObject();

        $this->valor = str_replace(".", ",", $obConta->valornominal);
        $this->parcela = $obConta->numParcela;
      $pessoa = new setPessoa();
        $this->seqpessoa = "<B>".$pessoa->setLabel($obConta->seqpessoa)."</B>";
        $this->transacao = $obConta->seqtransacao;
        $this->cidade = $obUnid->cidade;
      $data = new TSetData();
        $this->data = $data->dataPadraoPT($obConta->datacad);

      if($obConta->tipomovimentacao == "C"){
          $this->movimentacao = "Recebemos de";
      }else{
          $this->movimentacao = "Pagamos a";
      }

      $this->show();
    }

public function show(){

$html = "<h2>Conta n� ".$this->seqconta."</h2><BR /><BR /><BR />".$this->movimentacao." ".$this->seqpessoa." a quantia de R$ ".$this->valor." referente � parcela ".$this->parcela." da transação ".$this->transacao.".<br /><br /><BR />".$this->cidade.", ".$this->data."<BR /><BR /> Assinatura:_____________________________________________";
return $html;

}

}