<?php
/*
 * Classe que alplica mascaras padr�es nos campos
 */


class TSetMascaras{

    /*
     * Formata numeros como valor monet�rio
     */
    public function setValor($valor, $moeda = "R$"){
        $val = "$moeda ".number_format($valor, 2, ",", ".");
        return $val;
    }

    /*
     * Formata valor no padr�o do banco de dados
    */
    public function setValorDb($valor){

        $val = str_replace("R$ ","",$valor);
        $val = explode(',', $val);
        $val = str_replace('.', '', $val[0]);

        return $val;
    }

    /*
     * formata data no formato nacional
     */
    public function setData($data){
            if(preg_match("/([0-9]{4})\-([0-9]{1,2})\-([0-9]{1,2})/", $data, $newData)){
                $data =  "$newData[3]/$newData[2]/$newData[1]";
            }
           return $data;
    }

    /*
     * Formata data no padr~ao do banco de dados
     */
    public function setDataDb($data){

        if((preg_match("/([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})/", $data, $newData)) and (strlen($data) == "10")){

            
            $data =  "$newData[3]-$newData[2]-$newData[1]";
        }

        return $data;
    }
}
?>
