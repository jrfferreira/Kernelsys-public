<?php
/**
 * Classe Unidade
 * Autor: João Felix
 * data:  13/04/2010
*/
class TUnidade {
    private $obTDbo = NULL;
    private $obUnidade = NULL;
    private $obUnidadeParametro = NULL;


    public function __construct($unidseq = null){
        $obUser = new TCheckLogin();
        $obUser = $obUser->getUser();
        if($unidseq){
            $this->unidseq = $unidseq;
        }else{
            $this->unidseq = $obUser->unidade->seq;
        }

    }

	/**
     * Retorna um objeto Unidade complento
     * param <seq> $sequnidade = seqda unidade
     */
    public function getUnidade(){
        try{
            if($this->unidseq) {
                    $this->obTDbo = new TDbo();
                    $this->obTDbo->setEntidade(TConstantes::DBUNIDADE);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter(TConstantes::SEQUENCIAL,'=',$this->unidseq));
                    $retUnidade = $this->obTDbo->select("*", $criteria);
                    $this->obUnidade = $retUnidade->fetchObject();

                    return $this->obUnidade;
             }else{
                 throw new ErrorException("A unidade não foi encontrada.");
             }
         }catch (Exception $e) {
            new setException($e);
            $this->obTDbo->rollback();
        }

    }
    /**
     * Retorna um objeto Unidade complento
     * param <seq> $sequnidade = seqda unidade
     */
    public function getParametro($parametro = null){
        try{
            if($this->unidseq) {
                    $this->obTDbo = new TDbo();
                    $this->obTDbo->setEntidade(TConstantes::DBUNIDADE_PARAMETRO);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('unidseq','=',$this->unidseq));
                    if($parametro){
                        $criteria->add(new TFilter('parametro','=',strtolower($parametro)));
                    }
                    $retUnidade = $this->obTDbo->select("parametro,valor", $criteria);
                    
                    while($t = $retUnidade->fetchObject()){
                            $param = $t->parametro;
                            $this->obUnidadeParametro->$param = $t->valor;
                     }
                     
                    if($parametro){
                    	return $this->obUnidadeParametro->$parametro;
                    }else{
                    	return $this->obUnidadeParametro;
                    }
             }else{
                 throw new ErrorException("A unidade não foi encontrada.");
             }
         }catch (Exception $e) {
            new setException($e);
            $this->obTDbo->rollback();
        }

    }
    
}