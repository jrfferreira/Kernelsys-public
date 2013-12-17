<?php
/*
 * classe TRecord
 *  Esta classe prov� os m�todos necess�rios para armazenar e 
 *  recuperar objetos da base de dados (Active Record)
 */
abstract class TRecord{

    protected $data;  // array contendo os dados do objeto
    
    /* método __construct()
     *  instancia um Active Record
     *  se passado o $seq, já carrega o objeto
     *  param [$seq] = ID do objeto
     */
    public function __construct($seq = NULL){

         //Retorna Usuario logado===================================
		$this->obUser = new TCheckLogin();
		$this->obUser = $this->obUser->getUser();
		//=========================================================

        if ($seq){ // se o ID for informado

            // carrega o objeto correspondente
            $this->objeto = $this->load($seq);
            if ($this->objeto){

                $this->fromArray($this->objeto->toArray());
            }
        }
    }
    
    /*
     * método __clone()
     *  executado quando o objeto for clonado. 
     *  Limpa o ID para que seja gerado um novo ID para o clone.
     */
    public function __clone(){

        unset($this->seq);
    }
    
    /*
     * método __get()
     * Executado sempre que uma propriedade for requerida
     */
    private function __get($prop){

        // verifica se existe método get_<propriedade>
        if (method_exists($this, 'get_'.$prop)) {

            // executa o método get_<propriedade>
            return call_user_func(array($this, 'get_'.$prop));
        }
        else{
            // retorna o valor da propriedade
            return $this->data[$prop];
        }
    }
    
    /*
     * método __set()
     * Executado sempre que uma propriedade for atribu�da.
     */
    private function __set($prop, $value){
        
        // verifica se existe método set_<propriedade>
        if (method_exists($this, 'set_'.$prop)){

            // executa o método set_<propriedade>
            call_user_func(array($this, 'set_'.$prop), $value);
        }
        else{
            // atribui o valor da propriedade
            $this->data[$prop] = $value;
        }
    }
    
    /*
     * método getEntity()
     *  retorna o nome da entidade (tabela)
     */
    private function getEntity() {
        // obt�m o nome da classe
        $classe = strtolower(get_class($this));
        // retorna o nome da classe - "Record"
        return substr($classe, 0, -6);
    }
    
    /* 
     * método fromArray
     * preenche os dados do objeto com um array
     */
    public function fromArray($data){
        $this->data = $data;
    }
    
    /* 
     * método toArray
     * retorna os dados do objeto como array
     */
    public function toArray() {
        return $this->data;
    }
    
    /*
     * método store()
     *  Armazena o objeto na base de dados e retorna
     *  o Número de linhas afetadas pela instrução SQL (zero ou um)
     */
    public function store() {
		// verifica se tem ID ou se existe na base de dados
		// se não ouver um ID adiciona um novo registro
		// se ouver um ID execura a atualização do registro na base dade dados
        if (empty($this->data['seq']) or (!$this->load($this->seq)))
        {
            // incrementa o ID
            $this->seq = $this->getLast() +1;
            // cria uma instrução de insert
            $sql = new TSqlInsert;
            $sql->setEntity($this->getEntity());

            // percorre os dados do objeto
            foreach ($this->data as $seq => $value)
            {
                // passa os dados do objeto para o SQL
                $sql->setRowData($seq, $this->$seq);
            }
        }
        else{
		
            // instancia instrução de update 
            $sql = new TSqlUpdate;
            $sql->setEntity($this->getEntity());
			
			// cria um critério de seleção baseado no ID
            $criteria = new TCriteria;
            $criteria->add(new TFilter('seq', '=', $this->seq));

            $sql->setCriteria($criteria);
			
			
	        // percorre os dados do objeto
            foreach ($this->data as $seq => $value)
            {
                if ($seq !== 'seq') // o seq não precisa ir no UPDATE
                {
                    // passa os dados do objeto para o SQL
                    $sql->setRowData($seq, $this->$seq);
                }
            }

        }
        // inicia transação de dados entre formulario e base de dados
        if ($conn = TTransaction::get()){
		
            // faz o log e executa o SQL
            TTransaction::log($sql->getInstruction());
            $result = $conn->exec($sql->getInstruction());
            // retorna o resultado
            return $result;
        }
        else
        {
            // se não tiver transação, retorna uma exceção
            new setException('não h� transação ativa !!');
        }
    }
    
    /*
     * método load()
     *  Recupera (retorna) um objeto da base de dados
     *  atrav�s de seu ID e instancia ele na mem�ria
     *  param $seq = ID do objeto
     */
    public function load($seq){
	
	    // instancia instrução de SELECT
        $sql = new TSqlSelect;
        $sql->setEntity($this->getEntity());
        $sql->addColumn('*');
        
        // cria critério de seleção baseado no ID
        $criteria = new TCriteria;
        $criteria->add(new TFilter('seq', '=', $seq));

        // define o critério de seleção de dados
        $sql->setCriteria($criteria);
		
				

        // inicia transação
        if ($conn = TTransaction::get()){

            // cria mensagem de log e executa a consulta
            TTransaction::log($sql->getInstruction());
			   $result= $conn->Query($sql->getInstruction());
			   
			 // se retornou algum dado
            if ($result){

                // retorna os dados em forma de objeto
                $objeto = $result->fetchObject(get_class($this));
		
            }
            return $objeto;
        }
        else
        {
            // se não tiver transação, retorna uma exceção
            new setException('não h� transação ativa !!');
        }
    }
    
    /*
     * método delete()
     *  Exclui um objeto da base de dados atrav�s de seu ID.
     *  param $seq = ID do objeto
     */
    public function delete($seq = NULL){
        
        // o ID � o parâmetro ou a propriedade ID
        $seq = $seq ? $seq : $this->seq;
        // instancia uma instrução de DELETE
        $sql = new TSqlDelete;
        $sql->setEntity($this->getEntity());
        
        // cria critério de seleção de dados
        $criteria = new TCriteria;
        $criteria->add(new TFilter('seq', '=', $seq));
        // define o critério de seleção baseado no ID
        $sql->setCriteria($criteria);
        
        // inicia transação
        if ($conn = TTransaction::get())
        {
            // faz o log e executa o SQL
            TTransaction::log($sql->getInstruction());
            $result = $conn->exec($sql->getInstruction());
            // retorna o resultado
            return $result;
            
        }else{
            // se não tiver transação, retorna uma exceção
            new setException('não h� transação ativa !!');
        }
    }
    
    /*
     * método getLast()
     * Retorna o �ltimo ID
     */
    private function getLast() {
        // inicia transação
        if ($conn = TTransaction::get()) {
            // instancia instrução de SELECT
            $sql = new TSqlSelect;
            $sql->addColumn('max(seq) as seq');
            $sql->setEntity($this->getEntity());
            // cria log e executa instrução SQL
            TTransaction::log($sql->getInstruction());
            $result= $conn->Query($sql->getInstruction());
            // retorna os dados do banco
            $row = $result->fetch();
            return $row[0];
        }
        else {
            // se não tiver transação, retorna uma exceção
            new setException('não h� transação ativa !!');
        }
    }
	
	/*metedo getVetora()
	*Converter o objeto corrente 
	*e retornar uma vetor com todas as propriedade validas do objeto
	*/
	public function getVetor(){
		
		foreach($this->data as $ch=>$vl){
			$objVetor[$ch] =  $vl;
		}
		
		return 	$objVetor;
	}
	
}