<?php

	
class setTipoForm {
		
	public function setParam($param){
	
		//Retorna Usuario logado===================================
		$obUser = new TCheckLogin();
		$obUser = $obUser->getUser();
		//=========================================================	
	
		$this->param = $param;
		
		$this->ob = new TElement("script");
		$this->ob->add('document.getElementById("tipo").onload = setTipoForm()');

		return $this->ob;
	}	

}
?>