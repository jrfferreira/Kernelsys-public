<?php

function __autoload($classe) {
    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}

class PassRecover {
	private $seqCode;
	private $dbo;
	public $unidade;
	public $seq;
	
	public function PassRecover($seqCode){
		$this->keyCode = $seqCode;
		
		$this->unidade = "14303-1";
        $this->seq = "010101-11";
        $this->dbo = new TDbo_out($this->unidade);
	}
	
	public function request($seqUsuario){
		$this->dbo->setEntidade('dbusuario');
        $criterio = new TCriteria();
        $criterio->add(new TFilter('usuario','='),$seqUsuario);
        $retUsuario = $this->dbo->select(TConstantes::SEQUENCIAL, $criterio);
        $obUsuario = $retUsuario->fetchObject();
        $seqUsuario = $obUsuario->seq;
        
        if(!empty($seqUsuario)){
			$tUsuario = new TUsuario();
        	$tUsuario->requestRecoverPassword($seqUsuario);
        }
	}
	
	public function change($newPass,$confirm){
		$tUsuario = new TUsuario();
		$tentativa = $tUsuario->recoverPassword($this->keyCode,$newPass,$confirm);
			
			if($tentativa){
				//alteração concluida;
			}else{
				//chave não é válida
			}
	}
	
	public function show(){
		$page = new TPage('Formulário de Inscrição');
        $page->add($form);
        

            $tryChange = new TElement('input');
            $tryChange->type = "submit";
            $tryChange->name = "try";
            $tryChange->class = "botao";
            $tryChange->value = "Gravar";
            
            $newPass = new TEntry('novaSenha');
        	$newPass->class = "campos";
        	$newPass->setSize("180");
        	
            $confirm = new TEntry('confirmacao');
        	$confirm->class = "campos";
        	$confirm->setSize("180");
        	
        	$usuario = new TEntry('usuario');
        	$usuario->class = 'campos';
        	$usuario->setSize('200');
            
            
        $page->show();
	}
}

$passRecover = new PassRecover($_GET['keycode']);

if($_GET['keycode']){
	if($_POST['try'] == true){		
		$newPass = $_POST['novaSenha'];
		$confirm = $_POST['confirmacao'];
		
		if(!empty($newPass) && !empty($confirm)){	
			$passRecover->change($newPass,$confirm);		
		}
	}
}else{
	if($_POST['try'] == true){			
        	$passRecover->request($_POST['usuario']);  	//Requisição feita            
	}
}

