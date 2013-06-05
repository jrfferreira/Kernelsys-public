<?php

class TkrsGenerator {
	private $dbo;
	private $tabelas;
	
	protected $entidade;
	protected $form;
	protected $aba;
	protected $bloco;
	protected $lista;
	protected $campos;
	protected $listaColunas;
	
	public function __construct($pathIni){		
		$this->dbo = new TDbo_kernelsys(null, null, $pathIni);
	}
	
	public function main(){
		
		$this->descobrirTabelas();
		
	}
	
	private function descobrirTabelas(){
		$criteria = new TCriteria();
		$criteria->add(new TFilter('table_schema','=','public'));
		$criteria->add(new TFilter('table_type','=','BASE TABLE'));
		$this->dbo->setEntidade('information_schema.tables');
		$tableList = $this->dbo->select('table_name',$criteria);
		
		$tables = $tableList->fetchAll(PDO::FETCH_COLUMN, 0);
		$this->tableNames = $tables;
		
		foreach($tables as $tableName){
			$this->tabelas[$tableName] = $tableName;
		}
		
		$this->descobrirCampos();
	}
	
	private function descobrirCampos(){
		foreach($this->tabelas as $table){
			$criteria = new TCriteria();
			$criteria->add(new TFilter('typname','=',$table));
			$criteria->add(new TFilter('attrelid','=','(typrelid)'));
			$criteria->add(new TFilter('attname','not in',"('cmin', 'cmax', 'ctid', 'oid', 'tableoid', 'xmin', 'xmax')"));
			$this->dbo->setEntidade('pg_attribute, pg_type');
			$estructureList = $this->dbo->select('attname',$criteria);
			
			$estructure = $estructureList->fetchAll(PDO::FETCH_COLUMN, 0);
			
			$this->campos[$table] = $estructure;
		}
	}
	
	protected function geraEntidades(){
		
	}
	
	protected function geraFormulario(){
		
	}
	
	protected function geraAba(){
		
	}
	
	protected function geraBloco(){
		
	}
	
	protected function geraCampos(){
		
	}
	
	protected function geraLista(){
		
	}
	
	protected function geraListaColunas(){
		
	}
}

$krsGenerator = new TkrsGenerator('krs');
$krsGenerator->main();

