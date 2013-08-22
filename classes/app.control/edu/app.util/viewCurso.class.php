<?php
//===================================================
//
//
//===================================================

class viewCurso{

	public function getCurso($id){
		//Retorna Usuario logado===================================
		$obUser = new TCheckLogin();
		$obUser = $obUser->getUser();
		//=========================================================	

            $sql = new TDbo(TConstantes::DBTURMA);
            $critSql = new TCriteria();
            $critSql->add(new TFilter("id","=",$id));
            $ret = $sql->select("*",$critSql);

			$obTurma = $ret->fetchObject();
			
            $sqlCr = new Tdbo(TConstantes::DBCURSO);
            $critSqlCr = new TCriteria();
            $critSqlCr->add(new TFilter("id","=",$obTurma->seqcurso));
            $retCr = $sqlCr->select("*",$critSqlCr);

			$obCr = $retCr->fetchObject();
			
			$rett = $obCr->id.' - '.$obCr->nome;
			
			return 	$rett;	
	}
}	