<?php

if(!function_exists("__autoload") && !is_callable("__autoload")) {
    function __autoload($classe) {

        include_once('../app.util/autoload.class.php');
        $autoload = new autoload('',$classe);
    }
}

class perfilSit {

	public function __construct(){
		
		//retorna os cargos
	$ob = new TDbo(''); 
		
	}
	
	
}

?>