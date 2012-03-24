<?php
//=====================================================
// Sistema de gerenciamento de privilégios
//=====================================================


class TShowPrivilegios{

	public function setParam($param){
		
		//Retorna Usuario logado===================================
		$obUser = new TCheckLogin();
		$obUser = $obUser->getUser();
		//=========================================================	
	
		$this->param = $param;
	}

	public function get(){
		
		try {
		
			TTransaction::close();
			TTransaction::open('../'.TOccupant::getPath().'app.config/krs');
			
			if($this->conn = TTransaction::get()){		
				$sqlMenu = "select * from modulos_principais where ativo='1'";
				$runMenu = $this->conn->Query($sqlMenu);
				
				$divM = new TElement('div');
				
				TTransaction::close();
				
					// retorna transação com a base de dados
					$obsession = new TSession();
					$patchDB   = $obsession->getValue('pathDB');
					TTransaction::open($patchDB);
			
				if($conn = TTransaction::get()){		
					
					while($retMenu = $runMenu->fetchObject()){
					
							// checa privilegio liberado
							$sqlUser = "select * from dbusuarios where codigo='".$this->param."'";
							$runUser = $conn->Query($sqlUser);
							$retUser = $runUser->fetchObject();
							
							$sqlCkPriv = "select id,ativo from dbusuarios_privilegios where codigo='".$retUser->codigopessoa."' and nivel='0' and modulo='".$retMenu->id."'";
							$runCkPriv = $conn->Query($sqlCkPriv);
							$retCkPriv = $runCkPriv->fetchObject();
												
						$obCheck = new TCheckButton('menuOp'.$retMenu->id);
						$obCheck->setValue($retMenu->id);
							if($retCkPriv->ativo == "1"){
								$obCheck->checked = '1';
							}
						$obCheck->onclick = "setPvlShow(this, '".$this->param."')";
				
							$obLabel = new TElement('div');
							$obLabel->style = "margin:5px;";
							
							$obLabel->add($obCheck);
							$obLabel->add($retMenu->labelmodulo);
							
						$divM->add($obLabel);
					}
					TTransaction::close();
				}	
							
							
			//Cria elemento fieldset Modulos
			$BlocoM = new TElement('fieldset');
			$BlocoM->id = 'bloc_Menu';
			$BlocoM->style = "width:250px; height:430px;";
				$legBlocoM = new TElement('legend');
				$legBlocoM->add('Menu Principal');
				$BlocoM->add($legBlocoM);
			$BlocoM->add($divM);
			
			//Cria elemento fieldset submodulos
			$BlocoSM = new TElement('fieldset');
			$BlocoSM->id = 'blocPai_SubMenu';
			$BlocoSM->style = "width:250px; height:430px;";
				$legBlocoSM = new TElement('legend');
				$legBlocoSM->add('Submenu');
				$BlocoSM->add($legBlocoSM);
				
				$contSub = new TElement('div');
				$contSub->id    = "bloc_subMenu";
				$contSub->style = "overflow:auto; height:430px;";
				$contSub->add(" ");
			$BlocoSM->add($contSub);
			
			
			//conteiner pai
			$conteiner = new TElement('div');
			$conteiner->add($BlocoM);
			$conteiner->add($BlocoSM);
			
			return $conteiner;
				
			}//teste de conexão
		
		} catch (Exception $e) {
            new setException($e, 2);
        }
	
	}
			
}
?>