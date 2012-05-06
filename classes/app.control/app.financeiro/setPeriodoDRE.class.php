<?php
/**
* método setPeriodo()
* Autor : Jo�o Felix
* ========================================================
*/
	
class setPeriodoDRE{
	
	/**
    * método setParam()
	* Autor : Wagner Borba
    * Configura o atributo vindo do objeto pai(registro responsavel pela visualização do ap�ndice)
    * param Codigo = recebe codigo do objeto pai
    */	
	public function setParam($param){
		$this->param = $param;
	}
	
	/**
	* método get()
	* Autor: Jo�o Felix
	****************************************************************************
	*/		
	public function get(){
	
		//Retorna Usuario logado===================================
		$obUser = new TCheckLogin();
		$obUser = $obUser->getUser();
		//=========================================================	
		
		//TTransaction::close();
	
		//TTransaction::open('../'.TOccupant::getPath().'app.config/my_dbpetrus');
			
		//if($conn = TTransaction::get()){
			
			
			//Cria elemento fieldset
			$Bloco = new TElement('fieldset');
			$Bloco->id = 'bloc_criterios';
			//$Bloco->style = "height:150px;";
				$legBloco = new TElement('legend');
				$legBloco->add('Periodo');
			$Bloco->add($legBloco);
				// campos ================================
				$obFieds = new TSetfields();
				
				$obFieds->geraCampo("Data Inicial:", 'dataDre1', "TEntry", '');
				$obFieds->setProperty('dataDre1', 'onkeypress', "mask(this,'99/99/9999',1,this)");
				$obFieds->setProperty('dataDre1', 'onkeyup', "mask(this,'99/99/9999',1,this)");
				$obFieds->setProperty('dataDre1', 'setSize', '100');
				
				$obFieds->geraCampo("Data Final:", 'dataDre2', "TEntry", '');
				$obFieds->setProperty('dataDre2', 'onkeypress', "mask(this,'99/99/9999',1,this)");
				$obFieds->setProperty('dataDre2', 'onkeyup', "mask(this,'99/99/9999',1,this)");
				$obFieds->setProperty('dataDre2', 'setSize', '100');
				
				
				$botaoGeraRelatorio = new TButton('gerar');
				$botaoGeraRelatorio->id = "gerar";
				$botaoGeraRelatorio->value = "Visualizar";
				$botaoGeraRelatorio->setProperty("onclick","runIntervalo('app.control/app.financeiro/viewDRE.class.php','bl_relatorio')");
				$botaoGeraRelatorio->setAction(new TAction(""), "Visualizar");
				
		
 			// campos fim ============================	
			
			$Bloco->add($obFieds->getConteiner());
			$Bloco->add($botaoGeraRelatorio);
			
			$Bloco2 = new TElement('fieldset');
			$Bloco2->id = 'bl_relatorio';
                        $Bloco2->add("<BR>");
					
		
		$this->ob = new TElement('div');
		$this->ob->id = "captaPeriodo";
		$this->ob->add($Bloco);
		$this->ob->add($Bloco2);
		
			
		return $this->ob;	
			
		//}
	}
}