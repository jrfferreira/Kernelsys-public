<?php 
set_time_limit(0);
function __autoload($classe) {
	include_once('../app.util/autoload.class.php');
	$autoload = new autoload('../',$classe);
}
include_once('TKrs.class.php');
class TSqlCompiler extends TKrs {
	
	private $tableNames = array();
	private $tableEstructures = array();
	private $dbo;
	private $xmlDomain;
	private $xmlRoot;
	private $xmlTableEstructureTemplate = array();
	
	public function __construct(){
		$this->xmlDomain = new DomDocument("1.0", "UTF-8");
		$this->xmlDomain->preserveWhiteSpace = false;
		$this->xmlDomain->formatOutput = true;
				
		$this->dbo = new TDbo_kernelsys();
		
	}
	
	public function main(){
		if($this->selectTables()){
			echo "compiled...";
		}
	}
	
	private function selectTables(){
		$criteria = new TCriteria();
		$criteria->add(new TFilter('table_schema','=','public'));
		$criteria->add(new TFilter('table_type','=','BASE TABLE'));
		$this->dbo->setEntidade('information_schema.tables');
		$tableList = $this->dbo->select('table_name',$criteria);

		$tables = $tableList->fetchAll(PDO::FETCH_COLUMN, 0);
		$this->tableNames = $tables;
		
		foreach($tables as $tableName){
			$this->createTablesEstructure($tableName);
		}
		
		return true;
		
	}
	
	private function createTablesEstructure($table){
		$xmlDomain = clone $this->xmlDomain;
		$xmlRoot =  $xmlDomain->createElement('kernelsys');
		
		$this->xmlTableEstructureTemplate[$table] = $xmlDomain->createElement($this->formatName($table));			
			
		$criteria = new TCriteria();
		$criteria->add(new TFilter('typname','=',$table));
		$criteria->add(new TFilter('attrelid','=','(typrelid)'));
		$criteria->add(new TFilter('attname','not in',"('cmin', 'cmax', 'ctid', 'oid', 'tableoid', 'xmin', 'xmax')"));
		$this->dbo->setEntidade('pg_attribute, pg_type');
		$estructureList = $this->dbo->select('attname',$criteria);

		$estructure = $estructureList->fetchAll(PDO::FETCH_COLUMN, 0);
		
		$this->tableEstructures[$table] = $estructure;
		
		$this->dbo->setEntidade($table);
		$rowList = $this->dbo->select('*');
		$rows = $rowList->fetchAll();
		
		$n = 0;
		foreach($rows as $row){
			$tempRow = $xmlDomain->createElement('row');
			foreach($estructure as $rowName){
				$tempRow->appendChild($xmlDomain->createElement($this->formatName($rowName),$row[$rowName]));
				
				if($rowName == 'id'){
					$tempRow->setAttribute('id', $row[$rowName]);
				}
			}
			$this->xmlTableEstructureTemplate[$table]->appendChild($tempRow);
		}
		
		$xmlRoot->appendChild($this->xmlTableEstructureTemplate[$table]);
		
		$xmlDomain->appendChild($xmlRoot);
		
		$xml = $xmlDomain->save($this->xmlFolder.'/'.$this->formatName($table).'.'.$this->xmlFile);
	}
}


$TSqlCompiler = new TSqlCompiler();
$TSqlCompiler->main();