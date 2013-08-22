<?php
/**
 * Provem todos os metodos para manipular banco de dados
 * Data: 28/04/2009
 * author Wagner Borba
 */

class TDbo_out {

    private $entity = NULL;
    private $conn   = NULL;
    private $autoClose = true;
    private $unidade = NULL;

    public function __construct($unidade = null, $entity = NULL) {

        if($entity and $entity != "") {
            $this->setEntidade($entity);
        }else {
            $this->autoClose = false;
        }

        try {

            //valida unidade
            if($unidade){
               $this->unidade = $unidade;
            }

            //inicia objeto sesseion
            $this->obsession = new TSession();

            //direciona o path
            $pathDB = '../'.TOccupant::getPath().'app.config/my_dbpetrus';

            if($this->autoClose) {
                TTransaction::close();
            }
            if(!TTransaction::get()) {
                TTransaction::open($pathDB);
            }
            $this->conn = TTransaction::get();

        }catch(Exception $e) {
            echo $e;
        }

        // }
        // else{
        // se não existir, lança um erro
        //     echo "Entidade '$entity' não definida corretamente");
        // }
    }

    
    public function commit() {
    	
        $this->conn->commit();
    	return true;
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
            echo $e;
        }
    }

    /**
     * executa rollback na transação atual caso necessario
     */
    public function rollback() {
        try {
            $rollback = TTransaction::rollback();
        }catch (Exception $e) {
            echo $e;
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

                // instancia instrução de SELECT
                $sql = new TSqlSelect;
                $sql->setEntity($this->entity);

                //verifica se colunas � um vetor
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

                    //adiciona criterio de seleção por unidade automaticamente
                    if($this->unidade)
                    $criteria->add(new TFilter('unidade','=',$this->unidade));

                    // define o critério de seleção de dados
                    $sql->setCriteria($criteria);
                    //$criteria->add(new TFilter('seq', '=', $seq));
                }

                // inicia transação
                if ($this->conn) {

                    // grava log de select (data - hora | autor | ação)
                    TTransaction::log($sql->getInstruction());

                    //executa sql
                    $result= $this->conn->Query($sql->getInstruction());

                    // se retornou algum dado
                    if ($result) {
                        // retorna os dados em forma de objeto
                        // $objeto = $result->fetchObject(get_class($this));
                    }
                    else {

                        $this->rollback();
                        // lança exeção de erro na execução da sql
                        throw new ErrorException("Ocorreu um erro na execução da SQL -> [".$sql->getInstruction()."]");
                    }
                    //fecha tansação
                    if($this->autoClose) {
                        TTransaction::close();
                    }
                    return $result;

                }
                else {
                    // se não tiver transação, retorna uma exceção
                    throw new ErrorException('não h� transação ativa !!');
                }

            }else {

                $this->rollback();
                // se não existir, lança um erro
                throw new ErrorException("Coluna precisa ser definida -> '$cols'");
            }
        }catch (Exception $e) {
            echo $e;
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
                //$this->seq = $this->getLast() +1;

                //acrecenta dados pad�es no insert
                if(!$dados['unidade'] && $this->unidade) {
                    $dados['unidade'] = $this->unidade;
                }

                //adiciona data do cadastro no registro
                $dados['dataCad'] = date("Y-m-d");


                // cria uma instrução de insert
                $sql = new TSqlInsert;
                $sql->setEntity($this->entity);

                // percorre os dados do objeto
                foreach ($dados as $seq => $value) {
                    // passa os dados do objeto para o SQL
                    $sql->setRowData($seq, $value);
                }

                // inicia transação
                if ($this->conn) {

                    // grava log de insert (data - hora | autor | ação)
                    TTransaction::log($sql->getInstruction());

                     //executa sql
                    $result = $this->conn->Query($sql->getInstruction(). " RETURNING ".TConstantes::SEQUENCIAL);
                    
                    if($result) {
                    	
                    	$lastId = $result->fetchObject();
                    	

                        if(!$dados[TConstantes::SEQUENCIAL]) {
                             //retorna id da operação
                            $idRegAtual = $codRegistro = $lastId->seq;
                        } else {
                            $idRegAtual = $codRegistro = $dados[TConstantes::SEQUENCIAL];
                        }

                        //fecha tansação
                        if($this->autoClose) {
                            TTransaction::close();
                        }

                        $retorno['id']     = $idRegAtual;
                        $retorno[TConstantes::SEQUENCIAL] = $codRegistro;

                        return $retorno;
                    }
                    else{
                        echo $sql->getInstruction().'<br>';
                         // levanta uma exceção
                         throw new ErrorException('não foi possivel executar a SQL [insert].');
                    }

                }else {
                    // levanta uma exceção
                    throw new ErrorException('não há transação ativa.');
                }

            }else {
                //levanta uma exceção
                throw new ErrorException("Os dados não foram definidos corretamente para o 'insert' -> '$dados'");
            }

        }catch(Exception $e) {
            $this->rollback();
            // lança exeção de erro na execução da sql
            echo $e.'<br><br>';
        }
    }
    public function sqlExec($sql){
        if($sql){

            $result = $this->conn->Query($sql);
            return $result;
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

                //adiciona criterio de seleção por unidade automaticamente
                if($this->obUser) {
                    $criteria->add(new TFilter('unidade','=',$this->obUser->unidade->seq));
                }

                // instancia instrução de update
                $sql = new TSqlUpdate;
                $sql->setEntity($this->entity);

                // define o critério de seleção de dados
                $sql->setCriteria($criteria);
                //$criteria->add(new TFilter('seq', '=', $seq));
                //$sql->setCriteria($criteria);

                // percorre os dados do objeto
                foreach ($dados as $seq => $value) {
                    if ($seq !== 'seq'  and $value !== "") { // o seq não precisa ir no UPDATE
                        // passa os dados do objeto para o SQL
                        $sql->setRowData($seq, $value);
                    }
                }

                // inicia transação
                if ($this->conn) {

                    // grava log de upDate (data - hora | autor | ação)
                    TTransaction::log($sql->getInstruction());

                    //executa sql
                    $result = $this->conn->Query($sql->getInstruction());

                    // echo '<br><br>---'.$sql->getInstruction();

                    // se retornou algum dado
                    if (!$result) {
                        // lança exeção de erro na execução da sql
                        throw new ErrorException("Ocorreu um erro na execução da SQL -> [".$sql->getInstruction()."]");
                    }//fecha tansação
                        if($this->autoClose) {
                            TTransaction::close();
                        }
                    return $result;

                }
                else {
                    // se não tiver transação, retorna uma exceção
                    throw new ErrorException('não h� transação ativa');
                }

            }else {
                throw new ErrorException("Criterio Obrigatorio - Creterio de atualização não foi definido corretamente -> '$criteria->dump()'");
            }

        }catch(Exception $e) {
            $this->rollback();
            // lança exeção de erro na execução da sql
            echo $e;
        }
    }

}