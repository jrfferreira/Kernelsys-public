<?php
/**
 * TPopulaCampo
 *
 * Classe para polular campo 
 * @author João Felix
 */
class TPopulaCampo {

    function __autoload($classe){

        include_once('autoload.class.php');
        $autoload = new autoload('../',$classe);
    }

    public function commit($campofk,$colfk,$tabela,$col){
        if($campofk && $colfk && $tabela && $col){
            $tDbo = new TDbo($tabela);
            $crit = new TCriteria();
            $crit->add(new TFilter($colfk,'=',$campofk));
            $ret = $tDbo->select($col,$crit);

            $ob = $ret->fetchObject();

            if($ob->$col){
                return $ob->$col;
            }else{
                return "";
            }
        }else{
            return "";
        }
    }
}