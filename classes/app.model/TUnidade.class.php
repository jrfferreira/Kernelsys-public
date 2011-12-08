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


    public function __construct($codigounidade = null){
        $obUser = new TCheckLogin();
        $obUser = $obUser->getUser();
        if($codigounidade){
            $this->unidade = $codigounidade;
        }else{
            $this->unidade = $obUser->unidade->codigo;
        }

    }

	/**
     * Retorna um objeto Unidade complento
     * param <codigo> $codigounidade = codigo da unidade
     */
    public function getUnidade(){
        try{
            if($this->unidade) {
                    $this->obTDbo = new TDbo();
                    $this->obTDbo->setEntidade(TConstantes::DBUNIDADES);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('codigo','=',$this->unidade));
                    $retUnidade = $this->obTDbo->select("*", $criteria);
                    $this->obUnidade = $retUnidade->fetchObject();

                    return $this->obUnidade;
             }else{
                 throw new ErrorException("A unidade ".$codigounidade." não foi encontrada.");
             }
         }catch (Exception $e) {
            new setException($e);
            $this->obTDbo->rollback();
        }

    }
    /**
     * Retorna um objeto Unidade complento
     * param <codigo> $codigounidade = codigo da unidade
     */
    public function getParametro($parametro = null){
        try{
            if($this->unidade) {
                    $this->obTDbo = new TDbo();
                    $this->obTDbo->setEntidade(TConstantes::DBUNIDADES_PARAMETROS);
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
?>
