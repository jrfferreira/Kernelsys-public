<?php	
class setCriterioFolhaPag{
	
		
	public function setParam($param){
		$this->param = $param;
	}
	
			
	public function get(){
		
		//Retorna Usuario logado===================================
		$obUser = new TCheckLogin();
		$obUser = $obUser->getUser();
		//=========================================================	
		
		//TTransaction::close();
	
		//TTransaction::open('../app.config/my_dbpetrus');
			
		//if($conn = TTransaction::get()){
			
			
			//Cria elemento fieldset
			$Bloco = new TElement('fieldset');
			$Bloco->id = 'bloc_criterios';
			//$Bloco->style = "height:150px;";
							
				// campos ================================
				//$obFieds = new TSetfields();
				
				/*$obFieds->geraCampo("Conta D�bito:", 'conta', "TCombo", '');
				$obFieds->id = 'conta';
				$obFieds->setProperty('conta', 'setSize', '300');
				$obFieds->setProperty('conta', 'addItems', $vetC);
				
				$obFieds->geraCampo("Vencimento do primeiro pagamento:", 'venc', "TEntry", '');
				$obFieds->setProperty('venc', 'onkeypress', "mask(this,'99/99/9999',1,this)");
				$obFieds->setProperty('venc', 'onkeyup', "mask(this,'99/99/9999',1,this)");
				$obFieds->id = 'venc';
				$obFieds->setProperty('venc', 'setSize', '100');*/
				
				
				$botaoGeraRelatorio = new TButton('gerar');
				$botaoGeraRelatorio->id = "gerar";
				$botaoGeraRelatorio->value = "Gerar Folha";
				$botaoGeraRelatorio->setProperty("onclick","geraFolha('app.control/app.financeiro/geraFolhaPag.class.php','bl_folhapag')");
				$botaoGeraRelatorio->setAction(new TAction(""), "Gerar Folha");
				
		
 			// campos fim ============================	
			
			//$Bloco->add($obFieds->getConteiner());
			$Bloco->add($botaoGeraRelatorio);
			
			$Bloco2 = new TElement('fieldset');
			$Bloco2->id = 'bl_folhapag';
					
			//intancia formulario
			$obform = new TElement('form');
			$obform->name = "formFolhaPag";
			$obform->method = "POST";
			$obform->action = ""; 
			$obform->style = "margin:0px;";
			$obform->add($Bloco);
			
		$this->ob = new TElement('div');
		$this->ob->id = "captaCriterios";
		$this->ob->add($obform);
		$this->ob->add($Bloco2);
		
			
		return $this->ob;	
			
		//}
	}
}