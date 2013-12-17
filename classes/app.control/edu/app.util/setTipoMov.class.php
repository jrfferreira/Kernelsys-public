<?php
//===================================================
//
//
//===================================================

class setTipoMov{

	public function setMovimento($tp){
		
		if($tp == "C"){
			$tp = "Crédito";
		}
		elseif($tp == "D"){
			$tp = "Débito";
		}
		
		return $tp;
	}
	public function setStatus($tp){
		
		if($tp == "1"){
			$tp = "Em aberto";
		}
		elseif($tp == "2"){
			$tp = "Paga";
		}
		
		return $tp;
	}
}