<?php
/* 
 * Classe Disciplina
 * Autor: João Felix
 * data:  26/01/2010
 */

class TDisciplina{

    private $obTDbo = NULL;
    private $obDisciplina = NULL;

   /**
    * Retorna o objeto correspondente a disciplina
    * param <type> $codigodisciplina
    */
   public function getDiciplina($codigodisciplina, $cols = NULL){
        try{
            if($codigodisciplina){
                if(!$cols){ $cols = "*";}                
                $this->obTDbo = new TDbo(TConstantes::DBDISCIPLINA);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('seq','=',$codigodisciplina));
                $retDisciplina = $this->obTDbo->select($cols, $criteria);

                $this->obDisciplina = $retDisciplina->fetchObject();

            }else{
                throw new ErrorException("O seq da disciplina é invalido.");
            }
        }catch (Exception $e){
            new setException($e);
        }        
        return $this->obDisciplina;
    }

    /**
    * Retorna uma lista de objetos TDisciplina
    */
    public function getListaDisciplina($listaCodigoDisciplina, $cols = "*"){
        try{
            if($listaCodigoDisciplina){              
                $this->obTDbo = new TDbo(TConstantes::DBDISCIPLINA);
                    $criteria = new TCriteria();

                foreach($listaCodigoDisciplina as $codigodisciplina){                    
                    $criteria->add(new TFilter('seq','=',$codigodisciplina),'OR');
                }

                $retDisciplina = $this->obTDbo->select($cols, $criteria);

                $lista = array();
                while($disc = $retDisciplina->fetchObject()){
                    $tDisc = new TDisciplina();
                    $tDisc->obDisciplina = $disc;
                    $lista[$disc->seq] = $tDisc;
                }
                return $lista;
            }else{
                throw new ErrorException("A lista de codigos de disciplinas é invalido.");
            }
        }catch (Exception $e){
            new setException($e);
        }        
    }
}