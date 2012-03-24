<?php
//================================================================
// Gerenciamento de unidades
//
//================================================================

function __autoload($classe){

    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}

class TSetUnidade{

	public function __construct(){
	
		//TTransaction::open('../app.config/my_dbpetrus');
		
		//if($this->conn = TTransaction::get()){

            $sql = new TDbo(TConstantes::DBUNIDADES);
            $criteria = new TCriteria();
            $criteria->add(new TFilter("ativo","=","1"));
            $qrUd = $sql->select("*", $criteria);
		
			//$sql = "select * from dbunidades where ativo='1'";
			//$qrUd = $this->conn->Query($sql);
				$retUnid = $qrUd->fetchAll();
			
			foreach($retUnid as $unid){
				$this->unidade[$unid['id']] = $unid['unidade'];
			}	
		//}
	}
	
	public function setMenu(){
	
		foreach($this->unidade as $key=>$label){
			$obOp = new TElement('option');
			$obOp->value = $key;
			$obOp->add($label);
			
			$obOp->show();		
		}
	
	}
	
}