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


    public function __construct($sequnidade = null){
        $obUser = new TCheckLogin();
        $obUser = $obUser->getUser();
        if($sequnidade){
            $this->unidade = $sequnidade;
        }else{
            $this->unidade = $obUser->unidade->seq;
        }

    }

	/**
     * Retorna um objeto Unidade complento
     * param <seq> $sequnidade = seqda unidade
     */
    public function getUnidade(){
        try{
            if($this->unidade) {
                    $this->obTDbo = new TDbo();
                    $this->obTDbo->setEntidade(TConstantes::DBUNIDADE);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter(TConstantes::SEQUENCIAL,'=',$this->unidade));
                    $retUnidade = $this->obTDbo->select("*", $criteria);
                    $this->obUnidade = $retUnidade->fetchObject();

                    return $this->obUnidade;
             }else{
                 throw new ErrorException("A unidade ".$sequnidade." não foi encontrada.");
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
            if($this->unidade) {
                    $this->obTDbo = new TDbo();
                    $this->obTDbo->setEntidade(TConstantes::DBUNIDADE_PARAMETRO);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('unidade','=',$this->unidade));
                    if($parametro){
                        $criteria->add(new TFilter('parametro','=',strtolower($parametro)));
                    }
                    $retUnidade = $this->obTDbo->select("parametro,valor", $criteria);
                    
                    while($t = $retUnidade->fetchObject()){
                            $param = $t->parametro;
                            $this->obUnidadeParametro->$param = $t->valor;
                     }
                    return $this->obUnidadeParametro;
             }else{
                 throw new ErrorException("A unidade ".$this->unidade." não foi encontrada.");
             }
         }catch (Exception $e) {
            new setException($e);
            $this->obTDbo->rollback();
        }

    }
    
}