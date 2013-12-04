<?php
/**
 * Provem todos os metodos para manipular banco de dados
 * Data: 28/04/2009
 * author Wagner Borba
 */

class TDbo {

    private $entity = NULL;
    private $conn   = NULL;
    private $autoClose = true;
    private $realUser = true;

    public function __construct($entity = NULL, $val = NULL) {
    	    	
    	try {

	        if($entity and $entity != "") {
	            $this->setEntidade($entity);
	        }else {
	            $this->autoClose = false;
	        }
			
	        //inicia objeto sesseion
	        $this->obsession = new TSession();
	
	        //Testa login e Retorna Usuario logado=====================
	        if($val != "bitup") {
	            $this->obUser = new TCheckLogin();
	            $this->obUser = $this->obUser->getUser();
	        }else{
	            $this->realUser = false;
	        }
	        //=========================================================
	       	        
	        
	        $pathDB = false;
	        //valida o nivel em que o dbo esta sendo chamado e direciona o path
	        if(file_exists($this->obsession->getValue('pathDB').'.ini')) {
	            $pathDB = $this->obsession->getValue('pathDB');
	        }
	        elseif(file_exists('../'.$this->obsession->getValue('pathDB').'.ini')) {
	            $pathDB = '../'.$this->obsession->getValue('pathDB');
	        }
	        elseif(file_exists('../../'.$this->obsession->getValue('pathDB').'.ini')) {
	            $pathDB = '../../'.$this->obsession->getValue('pathDB');
	        }
		        
	        	//abre conexão com o banco.
	            TTransaction::open($pathDB);
	        	$this->conn = TTransaction::get();

        }catch(Exception $e) {
            $this->close();
            new setException($e);
        }

    }

     /**
     *
     */
    public function commit() {
        TTransaction::commit();
        return true;
    }

    /**
     *
     */
    public function close() {
        TTransaction::close();
    }

    /*
     * Função para checar se a entidade de fato existe.
     */
    public function checkEntidade($entity = null){
        try{
            if($entity or $entity != "" or $this->entity) {
                $entity = $entity ? strtolower($entity) : strtolower($this->entity);
                $select = "select relname from pg_class where relname = '{$entity}' and relkind='r'";
                $result = $this->conn->Query($select);
                if($result){
                    $check = $result->fetchObject();
                    if($check->relname == $entity){
                        return true;
                    }else{
                        return false;
                    }
                }
            }
            else {
                // se não existir, lança um erro
                throw new ErrorException("Entidade '$entity' não definida corretamente", 1055);
            }
        }catch (Exception $e) {
            new setException($e);
        }
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
                throw new ErrorException("Entidade '$entity' não definida corretamente", 1055);
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
    public function select($cols, $criteria = NULL, $whitoutRules = false) {
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
                	if(!($criteria instanceof TCriteria)){
                		$seq = $criteria;
                		$criteria = new TCriteria();
                		$criteria->add(new TFilter('seq', '=', $seq, 'numeric'));
                	}
                    //adiciona criterio de seleção por unidseq automaticamente
                    if($this->obUser) {
                        if($this->obUser->unidseq->seq!= 'x' && $this->realUser && !$whitoutRules){
                            $criteria->add(new TFilter('unidseq','=',$this->obUser->unidseq->seq,'numeric','unidseq'));
                           // $criteria->add(new TFilter('unidseq','=','x','unidseq'),'OR');
                        }
                    }

                    // define o critério de seleção de dados
                    $sql->setCriteria($criteria);
                    //$criteria->add(new TFilter('seq', '=', $seq));
                }
                // inicia transação
                if ($this->conn) {
                    // grava log de select (data - hora | autor | ação)
                    TTransaction::log($sql->getInstruction());
        			//echo "<script>console.log(\"".$sql->getInstruction()."\");</script>";
                    
                    //executa sql
                    $result = $this->conn->Query($sql->getInstruction());

                    // se retornou algum dado
                    if(!$result) {
                        $this->rollback();
                        // Lança exção de erro na execução da sql
                        throw new ErrorException("SQL: " . $sql->getInstruction() . '<br/>' . $this->setErro(), 1);
                    }
                    //fecha tansação automaticamente se necessario
                    if($this->autoClose) {
                        //TTransaction::close();
                    }
    
                    return $result;

                }
                else {
                    // se não tiver transação, retorna uma exceção
                    throw new ErrorException(TMensagem::ERRO_TRANSACAO_INATIVA, 2);
                }

            }else {

                $this->rollback();
                // se não existir, lança um erro
                throw new ErrorException("Coluna precisa ser definida -> '$cols'", 2);
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
    public function insert($dados = array()) {

        try {
                // incrementa o ID
                //$this->seq = $this->getLast() +1;

                //acrecenta dados padrões no insert
                if(!$dados['unidseq'] && $this->realUser) {
                    $dados['unidseq'] = $this->obUser->unidseq->seq;
                }

                if(!$dados['usuaseq'] && $this->realUser) {
                    $dados['usuaseq'] = $this->obUser->seq;
                }
                //adiciona data do cadastro no registro
                if(!$dados['datacad']){
                    $dados['datacad'] = date("Y-m-d");
                }
                if(!$dados['statseq']){
                	$dados['statseq'] = 1;
                }

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

 //echo $sql->getInstruction().'<br><br>';      
               
                    
                    //executa sql
                    $result = $this->conn->Query($sql->getInstruction(). " RETURNING ".TConstantes::SEQUENCIAL);
                    
                    if($result) {
                    	
                    	$idRegAtual = $result->fetchObject()->seq;
                    	
                    	//$idRegAtual = $this->conn->lastInsertId($this->entity."_".TConstantes::SEQUENCIAL."_seq");

                        $retorno['id']     = $idRegAtual;
                        $retorno[TConstantes::SEQUENCIAL] = $idRegAtual;

                        //fecha tansação
                        TTransaction::close();


                        return $retorno;

                    }else {
                        // levanta uma exceção
                        throw new ErrorException('Não foi possivel executar a SQL [insert('.$sql->getInstruction().')].');
                    }

                }else {
                    // levanta uma exceção
                    throw new ErrorException(TMensagem::ERRO_TRANSACAO_INATIVA, 2);
                }

        }catch(Exception $e) {
            $this->rollback();
            // Lança exeção de erro na execução da sql
            new setException($e);
        }
    }


    /**
     * Monta e executa uma sql update e retona o resultado da execução
     * Data: 28/04/2009
     * author Wagner Borba
     * param dados = vetor com todos os dados a serem atualizados
     */
    public function update(array $dados, $criteria) {

        try {
            // verifica se o creterio de seleção foi definido
            if($criteria) {
            	if(!($criteria instanceof TCriteria)){
            		$seq = $criteria;
            		$criteria = new TCriteria();
            		$criteria->add(new TFilter('seq', '=', $seq, 'numeric'));
            	}

                //adiciona criterio de seleção por unidseq automaticamente
                if($this->obUser) {
                    $criteria->add(new TFilter('unidseq','=',$this->obUser->unidseq->seq));
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

                    // grava log de upDate (data - hora | autor | alçao)
                    TTransaction::log($sql->getInstruction());
                    
                    //executa sql
                    $result = $this->conn->Query($sql->getInstruction());
                    

                    // se retornou algum dado
                    if (!$result) {
                        // Lança exeção de erro na execução da sql
                        throw new ErrorException("Ocorreu um erro na execução da SQL -> [".$sql->getInstruction()."]", 2);
                    }

                    //fecha tansação automaticamente se necessario
                    //TTransaction::close();

                    return $result;

                }
                else {
                    // se não tiver transação, retorna uma exceção
                    throw new ErrorException(TMensagem::ERRO_TRANSACAO_INATIVA, 2);
                }

            }else {
                throw new ErrorException("Criterio Obrigatorio - Creterio de atualização não foi definido corretamente -> '$criteria->dump()'", 2);
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
     * param Parametro = seqdo registro que sera deletado da entidade(table)
     *  param # coluna = Coluna na qual o criterio sera aplicado para a exclusão
     *                    caso não haja o padrão é [seq]
     */
    public function delete($param, $col = NULL) {

        // o ID � o parâmetro ou a propriedade ID
        //$seq = $seq ? $seq : $this->seq;
        try {
            if($param != NULL and $param != "") {

                // instancia uma instrução de DELETE
                $sql = new TSqlDelete;
                $sql->setEntity($this->entity);

                // define coluna padr�o para o objeto criteria
                if(!$col) {
                    $col = TConstantes::SEQUENCIAL;
                }

                // cria critério de seleção de dados
                $criteria = new TCriteria;
                $criteria->add(new TFilter($col, '=', $param,  'numeric'));

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

                        // Lança exeção de erro na execução da sql
                        throw new ErrorException($this->setErro(), 2);
                    }

                    //fecha tansação
                    //TTransaction::close();
                    
                    return $result;

                }else {
                    // se não tiver transação, retorna uma exceção
                    throw new ErrorException(1050);
                }

            }else {
                // se não existir criterio, lança um erro
                throw new ErrorException("Critério Obrigatorio - Crtério de exclusão não foi definido corretamente -> '$criteria->dump()'", 2);
            }

        }catch(Exception $e) {
            $this->rollback();
            // Lança exeção de erro na execução da sql
            new setException($e);
        }
    }

    /**
     * método count()
     *  Retorna a quantidade de objetos da base de dados
     *  que satisfazem um determinado critério de seleção.
     *  param $criteria = objeto do tipo TCriteria
     * param <type> $criteria
     * return <type>
     */
    public function count($criteria = NULL) {

        // instancia instrução de SELECT
        $sql = new TSqlSelect;
        $sql->addColumn('count(seq)');
        $sql->setEntity($this->entity);
                
        // atribui o critério passado como parâmetro
        if($criteria == NULL) {
        	$criteria = new TCriteria();            
        }
        
        	//adiciona criterio de seleção por unidseq automaticamente
        	if($this->obUser) {
        		$criteria->add(new TFilter('unidseq','=',$this->obUser->unidseq->seq));
        	}
        	
        	$criteria->setProperty('group', null);
        	$criteria->setProperty('order', null);
                   	
        	$sql->setCriteria($criteria);
        	
        // inicia transação
        $conn = TTransaction::get();
        if ($conn) {
        	
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
            new setException('não hà transação ativa !!');
        }
    }

    /**
    *
    */
    public function sqlExec($sql){
        if($sql){

            $result = $this->conn->Query($sql);
            return $result;
        }
    }

    /**
     *
     * return <type>
     */
    private function setErro(){
        
        $dbExecao = $this->conn->errorInfo();

        if($dbExecao[0] == '23503'){
            $mensagem = TMensagem::ERRO_RESTRICAO_DELETE;
        }
        elseif($dbExecao[0] == '42883'){
            $mensagem = TMensagem::ERRO_TIPODADOS_PESQUISA;
        }

        return $mensagem;
    }

}