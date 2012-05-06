<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class setComprovante{
    public function __construct($cod){
        
        
      $this->codigoconta = $cod;

        $setConta = new TDbo(TConstantes::DBTRANSACOES_CONTAS);
                $criteriaContas = new TCriteria();
                $criteriaContas->add(new TFilter('codigo','=',$this->codigoconta));
        $retConta = $setConta->select("*",$criteriaContas);
        $obConta = $retConta->fetchObject();

        $setUnid = new TDbo(TConstantes::DBUNIDADES);
        $critUnid = new TCriteria();
        $critUnid->add(new TFilter("codigo","=",$obConta->unidade));
        $retUnid = $setUnid->select("cidade",$critUnid);
        $obUnid = $retUnid->fetchObject();

        $this->valor = str_replace(".", ",", $obConta->valornominal);
        $this->parcela = $obConta->numParcela;
      $pessoa = new setPessoa();
        $this->codigopessoa = "<B>".$pessoa->setLabel($obConta->codigopessoa)."</B>";
        $this->transacao = $obConta->codigotransacao;
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

$html = "<h2>Conta n� ".$this->codigoconta."</h2><BR /><BR /><BR />".$this->movimentacao." ".$this->codigopessoa." a quantia de R$ ".$this->valor." referente � parcela ".$this->parcela." da transação ".$this->transacao.".<br /><br /><BR />".$this->cidade.", ".$this->data."<BR /><BR /> Assinatura:_____________________________________________";
return $html;

}

}