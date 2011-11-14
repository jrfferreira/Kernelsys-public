<?php
/* 
 * Classe TLivro
 * Autor: Joao Felix.
 * Data: 2010-04-15
 */

 class TLivro {
         public function __construct() {
            // Checa usuario logado e retona o mesmo
            $this->obTDbo = new TDbo();
        }
        public function getLivro($codigolivro){
            try{
                if($codigolivro){
                    $this->obTDbo->setEntidade(TConstantes::VIEW_PATRIMONIOS_LIVROS);
                    $criterio = new TCriteria();
                    $criterio->add(new TFilter("codigolivro","=",$codigolivro));
                    $retLivro = $this->obTDbo->select("*",$criterio);
                    
                    if($obLivro = $retLivro->fetchObject()){
                        return $obLivro;
                    }else{
                        throw new ErrorException("O ".$codigolivro."codigo não é referente a um registro válido.");
                    }
                }else{
                    throw new ErrorException("É necessário um código válido para consulta. - ".$codigolivro);
                }
            }catch (Exception $e) {
                new setException($e);
                $this->obTDbo->rollback();
            }
        }

        public function getSituacao($situacao){
            switch ($situacao) {
                case 1: return "Locado"; break;
                case 2: return "Reservado"; break;
                case 3: return "Devolvido"; break;
            }
        }
 }
?>
