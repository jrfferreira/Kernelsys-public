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
                $criteria->add(new TFilter("codigousuario","=",$this->obUser->codigouser));
                $criteria->add(new TFilter("funcionalidade","=",$funcionalidade));
                $criteria->add(new TFilter("nivel","=",$nivel));
                $criteria->add(new TFilter("ativo","=",'1'));
            $rQuery = $sql->select("codigo,modulo", $criteria);

                while($prv = $rQuery->fetch(PDO::FETCH_ASSOC)){
                    $this->privilegios[$prv['codigo']] = $prv['modulo'];
                }

	}
	
	public function get(){
		return $this->privilegios;
	}
	
	public function getUser(){
		return $this->obUser;
	}
}