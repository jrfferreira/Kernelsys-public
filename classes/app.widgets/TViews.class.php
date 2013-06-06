<?php
/********************************************************************************************************
*
*
*lista dados do objeto passa em forma de lista e fornece ferramentas para manipulalos
********************************************************************************************************/

class TViews{

	private $obj = NULL;
	
	/*método construtor
	*Instancia propriedades
	*/
	public function __construct($object){
			$this->objVetor = $object;
			
		// instancia objeto TTable
        $this->table = new TTable();
        $this->table->width  	  = '100%';
       	$this->table->cellpadding = "0";
		$this->table->cellspacing = "0";
		$this->table->border 	  = '0';
        $this->table->style       = 'border:1px solid #999999;';
		
	}
	
	public function setIntera(){
	
		$this->compVetor($this->objVetor);
		
		return $this->table;
	}
	
	/*
	*Compila vetor
	*/
	private function compVetor($vetor){
	
		foreach($vetor as $k=>$v){
					
			if(is_array($v)){
					$this->compVetor($v);
			}else{
				$linha[$ch] = $this->table->addRow();
				$linha[$ch]->addCell($k)->style = 'width:30%; padding:2px; text-align:right; background-color:#C8D0D2;';
				$linha[$ch]->addCell($v)->style = 'width:70%; padding:2px; ';
			}
		}
		
		return $linha;
	
	}

}