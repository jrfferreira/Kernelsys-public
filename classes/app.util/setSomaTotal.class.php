<?php
     /**
      * Retorna soma dos campos selecionadas da tabela.
      * Data: 25/05/2009
      * author Jo�o Felix
      * method setSomaTotal = "Retorna a soma dos valores da consulta";
      * method setContagemTotal = "Retorna a quantidade de ocorrencias da consulta";
      * global $entidade = "Tabela consultada";
      * global $col = "Coluna da entidade";
      * global $op = "Operador para consulta (criterio)";
      * global $criterio = "Variavel para comparação";
     */
class setSomaTotal{

    public function setSomaTotal($entidade,$col,$op,$criterio){

        $str = strtoupper($entidade);

            $obRetConsulta = new TDbo(TConstantes::$str);
            $critRet = new TCriteria();
            $critRet->add(new TFilter($col,$op,$criterio));
            $obRet = $obRetConsulta->select($col,$critRet);

            $soma = 0;
        foreach ($obRet as $vl){
            $soma = $soma + $vl;
        }

        return $soma;
    }
 
}

?>