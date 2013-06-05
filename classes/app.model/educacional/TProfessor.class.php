<?php
/*
 * Classe Professor
 * Autor: Jo�o Felix
 * Data: 2009-02-05
 */

class TProfessor {

    private $obTDbo = NULL;
    private $obProfessor = NULL;

    public function __construct(){
        $this->obTDbo = new TDbo();
    }
   /**
    * Retorna o objeto correspondente ao professor
    * param <type> $codigoprofessor
    */
   public function getProfessor($codigoprofessor = NULL){
        try{
            if($codigoprofessor){
                
                $this->obTDbo->setEntidade(TConstantes::VIEW_FUNCIONARIOS_PROFESSORES);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('codigo','=',$codigoprofessor));
                $retProfessor = $this->obTDbo->select("*", $criteria);

                $obProfessor = $retProfessor->fechtObject();        

            }else{
                throw new ErrorException("O codigo do professor � invalido.");
            } 
            
            if($obProfessor->codigopessoa){
            	$TPessoa = new TPessoa();
            	$obPessoa = $TPessoa->getPessoa($obProfessor->codigopessoa);
            	$obProfessor->pessoa = $obPessoa;            	
            }else{
            	throw new ErrorException("O Professor n�o contem um relacionamento com Funcion�rios.");
            }
        }catch (Exception $e){
        	$this->obTDbo->rollback();
            new setException($e);
        }
        return $obProfessor;
    }
}