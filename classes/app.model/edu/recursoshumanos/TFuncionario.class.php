<?php
class TFuncionario {
	
	private $obTDbo = NULL;
	
	public function __construct() {
		$this->obTDbo = new TDbo();
	}
	public function transformaPessoaFuncionario($seq){
		try {
			if(is_numeric($seq) && $seq > 0){
				$this->obTDbo->setEntidade(TConstantes::DBPESSOA);
				
				$criterio = new TCriteria();
					$criterio->add(new TFilter('seq','=',$seq));
				
				if($this->obTDbo->update(array("funcionario"=>true), $criterio)){
					
					$this->obTDbo->setEntidade(TConstantes::DBCARGO);
					$cargoQuery = $this->obTDbo->select('seq');
					
					$cargo = $cargoQuery->fetchObject()->seq;
					
					$this->obTDbo->setEntidade(TConstantes::DBDEPARTAMENTO);
					$departamentoQuery = $this->obTDbo->select('seq');
						
					$departamento = $departamentoQuery->fetchObject()->seq;
					
					if($cargo && $departamento){
						
						$dados = array("deptseq"=>$departamento,
									   "cargseq"=>$cargo,
									   "pessseq"=>$seq);
						
						$this->obTDbo->setEntidade(TConstantes::DBFUNCIONARIO);
						if($this->obTDbo->insert($dados)){
							$this->obTDbo->commit();
							return true;
						}
					}
				}
			}
			
			throw new ErrorException('O sequencial informado não é válido');
			
		} catch (Exception $e){
			$this->obTDbo->rollback();
			return false;
		}
	}
	
}