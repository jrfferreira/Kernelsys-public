<?php
// =====================================================
// Sistema de gerenciamento de privilégios
// =====================================================

class TShowPrivilegios {
	
	public function setParam($param) {
		
		// Retorna Usuario logado===================================
		$obUser = new TCheckLogin ();
		$obUser = $obUser->getUser ();
		// =========================================================
		
		$this->param = $param;
	}
	
	public function get() {
		
		try {
			$tKrs = new TKrs ( 'modulo' );
			$criterio = new TCriteria ();
			$criterio->add ( new TFilter ( 'statseq', '=', '1' ) );
			
			$runMenu = $tKrs->select ( '*', $criterio );
			
			$divM = new TElement ( 'div' );
			
			// retorna transação com a base de dados
			$obsession = new TSession ();
			TTransaction::close ();
			$patchDB = $obsession->getValue ( 'pathDB' );
			TTransaction::open ( $patchDB );
			
			if ($conn = TTransaction::get ()) {
				
				while ( $retMenu = $runMenu->fetchObject () ) {
					
					// checa privilegio liberado
					$sqlUser = "select * from dbusuario where seq='" . $this->param . "'";
					$runUser = $conn->Query ( $sqlUser );
					$retUser = $runUser->fetchObject ();
					
					$sqlCkPriv = "select seq,statseq from dbusuario_privilegio where seq='" . $retUser->seqpessoa . "' and nivel='0' and modulo='" . $retMenu->seq . "'";
					$runCkPriv = $conn->Query ( $sqlCkPriv );
					$retCkPriv = $runCkPriv->fetchObject ();
					
					$obCheck = new TCheckButton ( 'menuOp' . $retMenu->seq );
					$obCheck->setValue ( $retMenu->seq );
					if ($retCkPriv->statseq == "1") {
						$obCheck->checked = '1';
					}
					$obCheck->onclick = "setPvlShow(this, '" . $this->param . "')";
					
					$obLabel = new TElement ( 'div' );
					$obLabel->style = "margin:5px;";
					
					$obLabel->add ( $obCheck );
					$obLabel->add ( $retMenu->labelmodulo );
					
					$divM->add ( $obLabel );
				}
				TTransaction::close ();
			}
			
			// Cria elemento fieldset Modulos
			$BlocoM = new TElement ( 'fieldset' );
			$BlocoM->id = 'bloc_Menu';
			$BlocoM->style = "width:250px; height:430px;";
			$legBlocoM = new TElement ( 'legend' );
			$legBlocoM->add ( 'Menu Principal' );
			$BlocoM->add ( $legBlocoM );
			$BlocoM->add ( $divM );
			
			// Cria elemento fieldset submodulos
			$BlocoSM = new TElement ( 'fieldset' );
			$BlocoSM->id = 'blocPai_SubMenu';
			$BlocoSM->style = "width:250px; height:430px;";
			$legBlocoSM = new TElement ( 'legend' );
			$legBlocoSM->add ( 'Submenu' );
			$BlocoSM->add ( $legBlocoSM );
			
			$contSub = new TElement ( 'div' );
			$contSub->id = "bloc_subMenu";
			$contSub->style = "overflow:auto; height:430px;";
			$contSub->add ( " " );
			$BlocoSM->add ( $contSub );
			
			// conteiner pai
			$conteiner = new TElement ( 'div' );
			$conteiner->add ( $BlocoM );
			$conteiner->add ( $BlocoSM );
			
			return $conteiner;
		
		} catch ( Exception $e ) {
			new setException ( $e, 2 );
		}
	
	}

}