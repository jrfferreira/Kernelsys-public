<?php
/*
 * classe TTransaction
 *  Esta classe provê os métodos
 *  necess�rios manipular transações
 */
final class TTransaction{

    private static $conn;     // conexão ativa
    private static $logger;   // objeto de LOG
    
    /*
     * método __construct()
     *  Est� declarado como private para
     *  impedir que se crie instâncias de TTransaction
     */
    private function __construct(){}
    
    /*
     * método open()
     *  Abre uma transação e uma conexão ao BD
     *  param $database = nome do banco de dados
     */
    public static function open($database){

        try{
        	
        	$obsession = new TSession();
        	
        	//definie a chave de sessão para a conexão
        	$db = explode('/',$database);
        	$db = array_pop($db);
        	$pathchave = 'conn@'.$db;
        	
        	$conex_sessao = $_REQUEST[$pathchave];
        	
  //	self::$conn = $obsession->getValue(TConstantes::TRANSACTION);
        	
           // abre uma conexão e armazena
           // na propriedade estática $conn
	           if(is_a($conex_sessao,'PDO') && $conex_sessao->inTransaction()){
	           		self::$conn = $conex_sessao;
	           }else{
	           		$conexao = TConnection::open($database);
	           		self::$conn = $conexao;
	           		$_REQUEST[$pathchave] = $conexao;
	           }
	           
                // inicia a transação
                if(self::$conn && !self::$conn->InTransaction()){
                	self::$conn->beginTransaction();
                }
               
   //$obsession->setValue(TConstantes::TRANSACTION, self::$conn);
                
                // desliga o log de SQL
                self::$logger = NULL;
           
           //if (empty(self::$conn) or !self::$conn){
           //}
        }
        catch (Exception $e){
            self::close();
        }
    }
    
    /*
     * método get()
     *  Retorna a conexão ativa da transação
     */
    public static function get(){
        // retorna a conexão ativa
        return self::$conn;
    }
    
    /*
     * método rollback()
     *  Desfaz todas operações realizadas na transação
     */
    public static function rollback(){
        if (is_a(self::$conn,'PDO')){
		
            // desfaz as operações realizadas
            // durante a transação
            $rollback = self::$conn->rollback();
            self::$conn = NULL;
            return $rollback;
        }
    }

     /*
     * método close()
     *  Aplica todas operações realizadas na transaão e mantem ela aberta para
      * futuras operações
     */
    public static function commit(){
        if (is_a(self::$conn,'PDO')){
            // aplica as operações realizadas
            // durante a transação
            self::$conn->commit();
        }
    }
    
    /*
     * método close()
     *  Aplica todas operações realizadas e fecha a transação
     */
    public static function close(){
    	
        if (is_a(self::$conn,'PDO')){
            // aplica as operações realizadas
            // durante a transação     	
            self::$conn->commit();
            self::$conn = NULL;  
        }
    }
    
    /*
     * Metodo TestTransaction
     * Testa se ah uma transação ativa com o banco de dados
     */
    public static function testTransaction(){
    	if(self::$conn){    		
    		$test = self::$conn->InTransaction();
    	}else{
    		$test = false;
    	}
    	return $test;
    }
    
    /*
     * método setLogger()
     *  define qual estrat�gia (algoritmo de LOG será usado)
     */
    public static function setLogger(TLogger $logger){
        self::$logger = $logger;
    }
    
    /*
     * método log()
     *  armazena uma mensagem no arquivo de LOG
     *  baseada na estrat�gia ($logger) atual
     */
    public static function log($message){
	
        // verifica existe um logger
        if (is_object(self::$logger)){
			
        	echo "<script>console.log('".$message."');</script>";
            self::$logger->write($message);
        }
    }
}