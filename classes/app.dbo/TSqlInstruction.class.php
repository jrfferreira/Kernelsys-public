<?php
/*
 * classe TSqlInstruction
 * Esta classe prov� os m�todos
 * em comum entre todas instruções
 * SQL (SELECT, INSERT, DELETE e UPDATE)
 */
abstract class TSqlInstruction
{
    protected $sql;         // armazena a instrução SQL
    protected $criteria;    // armazena o objeto critério
    
    /**
     * método setEntity()
     *  define o nome da entidade (tabela)
     *  manipulada pela instrução SQL
     *  param $entity = tabela
     */
    final public function setEntity($entity) {
        $this->entity = $entity;
    }
    
    /*
     * método getEntity()
     *  retorna o nome da entidade (tabela)
     */
    final public function getEntity() {
        return $this->entity;
    }
    
    /*
     * método setCriteria()
     *  Define um critério de seleção dos dados
     *  atrav�s da composição de um objeto
     *  do tipo TCriteria, que oferece uma
     *  interface para definição de crit�rios
     *  param $criteria = objeto do tipo TCriteria
     */
    public function setCriteria(TCriteria $criteria) {
        $this->criteria = $criteria;
    }
    
    /*
     * método getInstruction()
     *  declarando-o como <abstract>
     *  obrigamos sua declaração nas
     *  classes filhas, uma vez que
     *  seu comportamento ser�
     *  distinto em cada uma delas,
     *  configurando polimorfismo.
     */
    abstract function getInstruction();
}