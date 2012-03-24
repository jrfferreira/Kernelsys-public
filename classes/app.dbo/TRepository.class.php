<?php
/*
 * classe TRepository
 *  Esta classe provê os métodos
 *  necessários para manipular coleções de objetos.
*/
final class TRepository {

    private $classe; 	// nome da classe manipulada pelo repositório
    private $cols;	//armazena lista de colunas a serem retornada pelo load e armazenada no repositorio

    /* método __construct()
     *  instancia um Reposit�rio de objetos
     *  param $class = Classe dos Objetos
    */
    public function __construct($entidade) {
        $this->entidade = $entidade;
    }

    /**
     *
     * param array $col = vetor de colunas a serem consultadas
     */
    public function setCols(array $col) {
        $this->cols = $col;
    }

    /*
     * método load()
     *  Recuperar um conjunto de objetos (collection) da base de dados
     *  atrav�s de um critério  de seleção, e instancià-los em mem�ria
     *  param $criteria = objeto do tipo TCriteria
    */
    public function load(TCriteria $criteria) {

        // checa colunas, se não ouver retorna todas  ---------
        if(count($this->cols)>0) {
            // configura campo que representa a chave estrangeira do sistema
            foreach($this->cols as $idcolun=>$colFormato) {
                $vetColumn[] = $idcolun;
            }
            $colunas = implode(',', $vetColumn);
        }
        else {
            $colunas = '*';
        }//------------------------------------------------------

            $dbo = new TDbo($this->entidade);
            $result = $dbo->select($colunas, $criteria);
            if ($result) {

                // percorre os resultados da consulta, retornando um objeto
                while ($row = $result->fetchObject()) {

                    //converti data padr�o internacional para padrão brasileiro====================
                    foreach($row as $kDado=>$dado) {
                        if (preg_match("/([0-9]{4})-([0-9]{1,2})-([0-9]{1,2})/", $dado, $newData)) {
                            $row->$kDado = "$newData[3]/$newData[2]/$newData[1]";
                        }
                    }
                    //==============================================================================

                    // armazena no array $results;
                    $results[] = $row;
                }
            }

            return $results;

    }

    /*
     * método delete()
     *  Excluir um conjunto de objetos (collection) da base de dados
     *  atrav�s de um critério de seleção.
     *  param $criteria = objeto do tipo TCriteria
    */
//    public function delete(TCriteria $criteria) {
//        // instancia instrução de DELETE
//        $sql = new TSqlDelete;
//        $sql->setEntity($this->entidade);
//        // atribui o critério passado como parâmetro
//        $sql->setCriteria($criteria);
//
//        // inicia transação
//        if($conn = TTransaction::get()) {
//
//            // registra mensagem de log
//            TTransaction::log($sql->getInstruction());
//            // executa instrução de DELETE
//            $result = $conn->exec($sql->getInstruction());
//            return $result;
//        }
//        else {
//            // se não tiver transação, retorna uma exceção
//            new setException('não há transação ativa !!');
//        }
//    }

    /*
     * método count()
     *  Retorna a quantidade de objetos da base de dados
     *  que satisfazem um determinado critério de seleção.
     *  param $criteria = objeto do tipo TCriteria
    */
    public function count($criteria = NULL) {

        // instancia instrução de SELECT
        $sql = new TSqlSelect;
        $sql->addColumn('count(id)');
        $sql->setEntity($this->entidade);
        // atribui o critério passado como parâmetro
        if($criteria) {
            $criteria->setProperty('order', null);
            $criteria->setProperty('limit', null);
            $sql->setCriteria($criteria);
        }

        // inicia transação
        if ($conn = TTransaction::get()) {

            // registra mensagem de log
            TTransaction::log($sql->getInstruction());
            // executa instrução de SELECT
            $result= $conn->Query($sql->getInstruction());
            if ($result) {
                $row = $result->fetch();
            }
            // retorna o resultado
            return $row[0];
        }
        else {
            // se não tiver transação, retorna uma exceção
            new setException('não há transação ativa !!');
        }
    }
}