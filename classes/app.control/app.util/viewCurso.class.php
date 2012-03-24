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

		//TTransaction::open('../'.TOccupant::getPath().'app.config/my_dbpetrus');
			
		//if($conn = TTransaction::get()){
            $sql = new TDbo(TConstantes::DBTURMAS);
            $critSql = new TCriteria();
            $critSql->add(new TFilter("id","=",$id));
            $ret = $sql->select("*",$critSql);

			//$sql = "select * from dbturma where id='".$id."'";
			//$ret = $conn->Query($sql);
			$obTurma = $ret->fetchObject();
			
            $sqlCr = new Tdbo(TConstantes::DBCURSOS);
            $critSqlCr = new TCriteria();
            $critSqlCr->add(new TFilter("id","=",$obTurma->codigocurso));
            $retCr = $sqlCr->select("*",$critSqlCr);

			//$sqlCr = "select * from dbcursos where id='".$obTurma->codigocurso."'";
			//$retCr = $conn->Query($sqlCr);
			$obCr = $retCr->fetchObject();
			
			$rett = $obCr->id.' - '.$obCr->nome;
			
			return 	$rett;	
		//}
	}
}	
?>