<?php
//--------------------------------------------------------------
// Gera códigos

class geraCodigo{

	private $codigo = NULL;
	private $fator  = NULL;
	
	public function __construct($fator){
	
		$this->fator = $fator;
		$sizeFator = 6-strlen($this->fator);
		
		$cod  = "0".date(m);
		$cod .= date(s);
		for($x = 0; $x<$sizeFator; $x++){
			$comCod .= $cod[$x];
		}
				
		if($this->fator != ""){
            $complemento = rand(10, 99)*rand(15, 95);
            $complemento = substr($complemento, -2);
                $this->cadigo = $this->fator.$comCod.'-'.$complemento;
		}
		
	}
    
	public function get(){
		return $this->cadigo;
	}

}

//$obcod = new geraCodigo(date(i));
//echo $obcod->get();

?>