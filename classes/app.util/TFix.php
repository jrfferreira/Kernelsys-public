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
		$this->obkrs = new  TDbo_kernelsys();
		
	}
	
	/**
	 * Deleta um modolo do sistema em cascata
	 * Wagner borba
	 * Vers„o 1.0
	 */
	public function excluirModulo($get){
		
		$id_menumodulo = $get['menu_modulos'];
		
		$this->obkrs->setEntidade('menu_modulos');
		 	$critmenu = new TCriteria();
        	$critmenu->add(new TFilter("id", "=", $id_menumodulo));
       	$menumodulo = $this->obkrs->select("id,form,metodo",$critmenu);
       	
		$menumodulo = $menumodulo->fetchObject();
		
		if($menumodulo->metodo = 'getList'){
			
			$idform = $menumodulo->form;
			
			$this->obkrs->setEntidade('forms');
			 	$critform = new TCriteria();
	        	$critform->add(new TFilter("id", "=", $idform));
	       	$form = $this->obkrs->select("id,nomeform",$critform);
	       	
			$form = $form->fetchObject();
			
			//Abas do formulario
			$this->obkrs->setEntidade('form_x_abas');
			 	$critformabas = new TCriteria();
	        	$critformabas->add(new TFilter("formid", "=", $form->id));
	       	$formaba = $this->obkrs->select("formid,abaid",$critformabas);
	       	
	       	
			while($auxformaba = $formaba->fetchObject()){
				
				//blocos e abas
				$this->obkrs->setEntidade('blocos_x_abas');
				 	$critblocosabas = new TCriteria();
		        	$critblocosabas->add(new TFilter("abaid", "=", $auxformaba->abaid));
		       	$blocoaba = $this->obkrs->select("blocoid,abaid",$critblocosabas);
				
				while($auxblocoaba = $blocoaba->fetchObject()){
					
					$lstbloboaba[] = $auxblocoaba;
					
				}
				
				$lstformaba[] = $auxformaba;
				
			}
			
			
			print_r($lstformaba+$lstbloboaba);
			
		}
       	
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
		        	echo 'CPF n√£o encontrado. <br>';
		        }
        	
        }
        
 		

       
    }
}


echo '-------------------- FIX ---------------------<br>';

$fix = new TFix();

//$fix->redefineUsuarios();
$fix->excluirModulo($_GET);


echo '<br>------------------ END FIX -------------------';


?>
