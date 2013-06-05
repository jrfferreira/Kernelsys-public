<?php

function __autoload($classe) {
    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}


Class TFix{
	
	private $obdbo;
	
	public function __construct(){
		
		$valida = $_GET['exe'];
		
		if($valida!='true'){
			exit();
		}
		
		$this->obdbo = new TDbo();
		
	}
	
	
 	public function redefineUsuarios() {
 		
 		$this->obdbo->setEntidade(TConstantes::DBUSUARIOS);
        	$critusuario = new TCriteria();
        	$critusuario->add(new TFilter("usuario", "!=", "pauhique"));
        	$critusuario->add(new TFilter("usuario", "!=", "user"));
        	$critusuario->add(new TFilter("usuario", "!=", "admin.educacional"));
        $usuarioretorno = $this->obdbo->select("codigo,codigopessoa",$critusuario);
        
        
        while($user = $usuarioretorno->fetchObject()){
        	
        	 	$this->obdbo->setEntidade(TConstantes::DBPESSOAS);
			        $critpessoa = new TCriteria();
			        $critpessoa->add(new TFilter("codigo", "=", $user->codigopessoa));
		        $pessoaretorno = $this->obdbo->select("codigo,cpf_cnpj",$critpessoa);
		        
		        $obpessoa = $pessoaretorno->fetchObject();
		        
		        if($obpessoa->cpf_cnpj){
		       
	        		$this->obdbo->setEntidade(TConstantes::DBUSUARIOS);
	        			$dados['usuario'] = str_replace('-','',str_replace('.','',$obpessoa->cpf_cnpj));
	        			$critsetusuario = new TCriteria();
	        			$critsetusuario->add(new TFilter("codigo", "=", $user->codigo));
	        		$usuarioresultado = $this->obdbo->update($dados, $critsetusuario);
	        		
	        		if($usuarioresultado){
	        			echo $user->codigo.' -> ok <br>';
	        		}else{
	        			echo $user->codigo.' -> ERRO <br>';
	        			
	        			//deleta o usuario duplicado
		        		$this->obdbo->setEntidade(TConstantes::DBUSUARIOS);
		        		$usuarioresultado = $this->obdbo->delete($user->codigo);
	        			
	        		}
		        }	
		        else{
		        	echo 'CPF não encontrado. <br>';
		        }
        	
        }
        
 		

       
    }
}

$fix = new TFix();
$fix->redefineUsuarios();