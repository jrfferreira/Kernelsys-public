<?php
/**
 * classe TSession
 * Gerencia uma seção com o usuário
 */
class TSession {
    /**
     * método construtor
     * inicializa uma seção
     */
    public function __construct() {

        session_cache_expire(3600);
        $cache_expire = session_cache_expire();
        
        
        if(!session_id()){
        	session_start();
        }
        
        $id_ss = session_id();
        $var = $_SESSION;
        
        $nivel_execucao = "nivelExec";
        $this->nivel = $this->getValue($nivel_execucao, "0");

    }

    /**
     * método setValue()
     * Armazena uma variável na seção
     * param  $var   = Nome da variável
     * param  $value = Valor
     */
    public function setValue($var, $value, $nivel = NULL) {

	$value = serialize($value);
	
        if($nivel) {
            $_SESSION[$nivel][$var] = $value;
        }
        else {
            $_SESSION[$var] = $value;
        }


        //instancia vetor com lista de elementos [chave para limpeza] em sessão
        $vetSession = $_SESSION['KeyBoxSession'];
        $vetSession[$var] = $var;
        $_SESSION['KeyBoxSession'] = $vetSession;
    }

    /**
     * método getValue()
     * Retorna uma variável da seção
     * param  $var   = Nome da variável
     */
    public function getValue($var, $nivel = NULL) {
        if($nivel) {
            return unserialize($_SESSION[$nivel][$var]);
        }else {        	
            return unserialize($_SESSION[$var]);
        }
    }

    /*
	*Limpa endereço da sessão
    */
    public function delValue($var, $nivel = NULL) {
        if($nivel) {

            $_SESSION[$nivel][$var] = NULL;
            unset($_SESSION[$nivel][$var]);
        }else {
            $_SESSION[$var] = NULL;
            unset($_SESSION[$var]);
        }
    }

    /**
     * método freeSession()
     * Destr�i os dados de uma sessão
     */
    public function freeSession() {

        $_SESSION = array();
        session_destroy();
    }
    
    public function __dump(){
    	var_dump($_SESSION);
    }
}
?>
