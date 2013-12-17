<?php
/**
 * 
 */

class TGetPrivilegio{

	private $privilegios = array();
	
	public function __construct($funcionalidade, $nivel = null){
	
		//Retorna Usuario logado===================================
		$obUser = new TCheckLogin();
		$this->obUser = $obUser->getUser();
		//=========================================================	
	
		$this->obsession = new TSession();
		
            $sql = new TDbo(TConstantes::DBUSUARIO_PRIVILEGIO);
                $criteria = new TCriteria();
                $criteria->add(new TFilter("usuaseq","=",$this->obUser->seq));
                $criteria->add(new TFilter("funcionalidade","=",$funcionalidade));
                $criteria->add(new TFilter("nivel","=",$nivel));
                $criteria->add(new TFilter("statseq","=",'1'));
            $rQuery = $sql->select("seq,modulo", $criteria);

                while($prv = $rQuery->fetch(PDO::FETCH_ASSOC)){
                    $this->privilegios[$prv[TConstantes::SEQUENCIAL]] = $prv['modulo'];
                }

	}
	
	public function get(){
		return $this->privilegios;
	}
	
	public function getUser(){
		return $this->obUser;
	}
}