<?php


class TExeSql{

	public function __construct($sql){
	
		//inicia objeto sesseion
		$this->obsession = new TSession();

                //Retorna Usuario logado===================================
		$this->obUser = new TCheckLogin();
		$this->obUser = $this->obUser->getUser();
		//=========================================================
		
		TTransaction::open($this->obsession->getValue('pathDB'));
                $conn = TTransaction::get();
        
			if($conn){

                if(strpos($sql, "show") === false and strpos($sql, "SHOW") === false){
                    
                    //implementa criteio de unidade fabril(Filiais)=====================================
                    $this->criteria = new TCriteria();
                    $this->criteria->add(new TFilter('unidade', '=', $this->obUser->unidade->codigo),'');
                    $this->criteria->add(new TFilter('unidade', '=', 'x'),'or ');
                    //===================================================================================

                    //edita sql
                    $vtSql = explode(' order ',$sql);
                    if(strpos($vtSql[0], "where") !== false or strpos($vtSql[0], "WHERE") !== false){
                        $vtSql[0] .= ' and '.$this->criteria->dump();
                    }
                    else{
                        $vtSql[0] .= " WHERE ".$this->criteria->dump();
                    }

                    if($vtSql[1]!=""){
                        $vtSql[0] .= ' order '.$vtSql[1];
                    }
                    $sql = $vtSql[0];
                }

				$this->Ret = $conn->Query($sql);
			}
		TTransaction::close();
		
	}
	
	public function get(){
		return $this->Ret;
	}

}