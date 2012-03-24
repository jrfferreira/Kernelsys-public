<?php
/**
 * Provem todos os metodos para manipular banco de dados
 * Data: 28/04/2009
 * author Wagner Borba
 */

class TDbo_kernelsys {

    private $entity = NULL;
    private $conn   = NULL;
    private $autoClose = true;

    public function __construct($entity = NULL, $val = NULL) {

        if($entity and $entity != "") {
            $this->setEntidade($entity);
        }else {
            $this->autoClose = false;
        }

        try {

            TTransaction::open('../'.TOccupant::getPath().'app.config/krs');
            $this->conn = TTransaction::get();

        }catch(Exception $e) {
            new setException(TMensagem::ERRO_GERAL_CONEXAO);
        }
    }

    /**
     *
     */
    public function close() {
        TTransaction::close();
    }


    /**
     * Instancia o atributo entidade
     * param <String> $entity = Entidade
     */
    public function setEntidade($entity) {
        try {
            if($entity or $entity != "") {
                $this->entity = $entity;
            }
            else {
                // se não existir, lança um erro
                throw new ErrorException("Entidade '$entity' não definida corretamente");
            }
        }catch (Exception $e) {
            new setException($e);
        }
    }

    /**
     * executa rollback na transação atual caso necessario
     */
    public function rollback() {
        try {
            $rollback = TTransaction::rollback();
        }catch (Exception $e) {
            new setException($e);
        }
        return $rollback;
    }
    /**
     * Monta e executa uma sql select e retona o resultado da execução
     * Data: 28/04/2009
     * author Wagner Borba
     * param colunas = Colunas da entidade a serem retornadas (*) retorna todas
     */
    public function select($cols, TCriteria $criteria = NULL) {
        try {
            if($cols) {

                // instancia instruções de SELECT
                $sql = new TSqlSelect;
                $sql->setEntity($this->entity);

                //verifica se colunas é um vetor
                if(is_array($cols)) {
                    foreach($cols as $col) {
                        $sql->addColumn($col);
                    }
                }
                elseif(strpos($cols, ",")) {
                    $exCol = explode(",", $cols);
                    foreach($exCol as $cl) {
                        $sql->addColumn($cl);
                    }

                }
                else {
                    $sql->addColumn($cols);
                }

                // verifica se o creterio de seleção foi definido
                if($criteria) {
                    // define o critério de seleção de dados
                    $sql->setCriteria($criteria);
                    //$criteria->add(new TFilter('id', '=', $id));
                }

                // inicia transação
                if ($this->conn) {

                    // grava log de select (data - hora | autor | ação)
                    //TTransaction::log($sql->getInstruction());

                    //executa sql
                    $result= $this->conn->Query($sql->getInstruction());

                    // se retornou algum dado
                    if (!$result) {
                        $this->rollback();
                        // lança exeção de erro na execução da sql
                        throw new ErrorException("Ocorreu um erro na execuão da SQL -> [".$sql->getInstruction()."]");
                    }

                    //fecha tansação automaticamente se necessario
                    if($this->autoClose) {
                        TTransaction::close();
                    }
                    return $result;

                }
                else {
                    // se não tiver transação, retorna uma exceção
                    throw new ErrorException('Não há transação ativa !!');
                }

            }else {

                $this->rollback();
                // se não existir, lança um erro
                throw new ErrorException("Coluna precisa ser definida -> '$cols'");
            }
        }catch (Exception $e) {
            new setException($e);
        }
    }

    /**
     * Monta e executa uma sql insert e retona o resultado da execução
     * Data: 28/04/2009
     * author Wagner Borba
     * param dados = Vetor com todos os dados e colunas (vetor[coluna] = Valor) a serem inseridos na entidade
     */
    public function insert(array $dados) {

        try {
            if($dados != NULL and $dados != "" and is_array($dados)) {
                // incrementa o ID
                //$this->id = $this->getLast() +1;

                // cria uma instrução de insert
                $sql = new TSqlInsert;
                $sql->setEntity($this->entity);

                // percorre os dados do objeto
                foreach ($dados as $key => $value) {
                    // passa os dados do objeto para o SQL
                    $sql->setRowData($key, $value);
                }

                // inicia transação
                if ($this->conn) {

                    // grava log de insert (data - hora | autor | ação)
                    TTransaction::log($sql->getInstruction());

                    //executa sql
                    $result = $this->conn->Query($sql->getInstruction());

                            $idRegAtual = $this->conn->lastInsertId($this->entity.'_id_seq');

                    if(!$result) {
                        throw new ErrorException("Ouve um problema ao inserir os dados");
                    }

                    //fecha tansação
                    if($this->autoClose) {
                        TTransaction::close();
                    }

                    $retorno['id']     = $idRegAtual;

                    return $retorno;

                }else {
                    // levanta uma exceção
                    throw new ErrorException('Não há transação ativa.');
                }

            }else {
                //levanta uma exceção
                throw new ErrorException("Os dados não foram definidos corretamente para o 'insert' -> '$dados'");
            }

        }catch(Exception $e) {
            $this->rollback();
            // lança exeção de erro na execução da sql
            new setException("Ocorreu um erro na execução da SQL de Insert <br>.".$e);
        }
    }


    /**
     * Monta e executa uma sql update e retona o resultado da execução
     * Data: 28/04/2009
     * author Wagner Borba
     * param dados = vetor com todos os dados a serem atualizados
     */
    public function update(array $dados, TCriteria $criteria) {

        try {
            // verifica se o creterio de seleção foi definido
            if($criteria) {

                // instancia instrução de update
                $sql = new TSqlUpdate;
                $sql->setEntity($this->entity);

                // define o critério de seleção de dados
                $sql->setCriteria($criteria);

                // percorre os dados do objeto
                foreach ($dados as $key => $value) {
                    // passa os dados do objeto para o SQL
                    $sql->setRowData($key, $value);
                }

                // inicia transação
                if ($this->conn) {

                    // grava log de upDate (data - hora | autor | ação)
                    TTransaction::log($sql->getInstruction());

                    //executa sql
                    $result = $this->conn->Query($sql->getInstruction());

                    // se retornou algum dado
                    if (!$result) {
                        // lança exeção de erro na execução da sql
                        throw new ErrorException("Ocorreu um erro na execuçãoo da SQL -> [".$sql->getInstruction()."]");
                    }

                    //fecha tansação
                    //TTransaction::close();
                    return $result;

                }
                else {
                    // se não tiver transação, retorna uma exceção
                    throw new ErrorException('Não hã transação ativa');
                }

            }else {
                throw new ErrorException("Criterio Obrigatorio - Creterio de atualização não foi definido corretamente -> '$criteria->dump()'");
            }

        }catch(Exception $e) {
            $this->rollback();
            // lança exeção de erro na execução da sql
            new setException($e);
        }
    }

    /**
     * Monta e executa uma sql delete e retona o resultado da execução
     * Data: 28/04/2009
     * author Wagner Borba
     * param Parametro = Codigo do registro que sera deletado da entidade(table)
     *  param # coluna = Coluna na qual o criterio sera aplicado para a exclus�o
     *                    caso não haja o pad�o � [codigo]
     */
    public function delete($param, $col = NULL) {

        // o ID � o parâmetro ou a propriedade ID
        //$id = $id ? $id : $this->id;
        try {
            if($param != NULL and $param != "") {

                // instancia uma instrução de DELETE
                $sql = new TSqlDelete;
                $sql->setEntity($this->entity);

                // define coluna padr�o para o objeto criteria
                if(!$col) {
                    $col = 'id';
                }

                // cria critério de seleção de dados
                $criteria = new TCriteria;
                $criteria->add(new TFilter($col, '=', $param));

                // define o critério de seleção baseado no ID
                $sql->setCriteria($criteria);

                // inicia transação
                if ($this->conn) {

                    // grava log de upDate (data - hora | autor | ação)
                    TTransaction::log($sql->getInstruction());

                    //executa sql
                    $result = $this->conn->Query($sql->getInstruction());

                    // se retornou algum dado
                    if (!$result) {

                        // lança exeção de erro na execução da sql
                        throw new ErrorException("Ocorreu um erro na execução da SQL -> [".$sql->getInstruction()."]");
                    }

                    //fecha tansação
                    if($this->autoClose) {
                        TTransaction::close();
                    }
                    return $result;

                }else {
                    // se não tiver transação, retorna uma exceção
                    throw new ErrorException('Não há transação ativa');
                }

            }else {
                // se não existir criterio, lança um erro
                throw new ErrorException("Criterio Obrigatorio - Creterio de exclusão não foi definido corretamente -> '$criteria->dump()'");
            }

        }catch(Exception $e) {
            $this->rollback();
            // lança exeção de erro na execução da sql
            new setException($e);
        }
    }

}
?>
