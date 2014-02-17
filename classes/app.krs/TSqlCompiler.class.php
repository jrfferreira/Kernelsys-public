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
	protected $package;
	
	public function __construct(){
		$this->obSession = new TSession();
		$this->xmlDomain = new DomDocument("1.0", "UTF-8");
		$this->xmlDomain->preserveWhiteSpace = false;
		$this->xmlDomain->formatOutput = true;
		$this->dbo = new TDbo_kernelsys();
		$this->package = $this->obSession->getValue('package');
	}
	
	public function main(){
		if($this->selectTables()){
			echo "<bR>Dados compilados com sucesso!<br>Local: ";
			echo $this->xmlFolder.'/'.$this->package.'/';
		}
	}
	
	private function selectTables(){
		$criteria = new TCriteria();
		$criteria->add(new TFilter('table_schema','=','public'));
		$criteria->add(new TFilter('table_type','=','BASE TABLE'));
		$criteria->add(new TFilter('table_name','not in',"('dbunidade','dbunidade_parametro','dbpessoa','dbusuario','dbusuario_privilegio')"));
		$this->dbo->setEntidade('information_schema.tables');
		$tableList = $this->dbo->select('table_name',$criteria);

		$tables = $tableList->fetchAll(PDO::FETCH_COLUMN, 0);
		$this->tableNames = $tables;
		
		foreach($tables as $tableName){
			$return = $this->createTablesEstructure($tableName);
			
			if($return){
				echo $tableName.' - compilado '.time().' <br><br>';
			}
			
		}
		
		return true;
	}
	
	private function createTablesEstructure($table){
		try{
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
			$crit = new TCriteria();
			$crit->add(new TFilter('statseq','=',1));
			$rowList = $this->dbo->select('*',$crit);
			$rows = $rowList->fetchAll();
			
			$n = 0;
			foreach($rows as $row){
				$tempRow = $xmlDomain->createElement('row');
				foreach($estructure as $rowName){
					$tempRow->appendChild($xmlDomain->createElement($this->formatName($rowName),$row[$rowName]));
					
					if($rowName == 'seq'){
						$tempRow->setAttribute('seq', $row[$rowName]);
					}
				}
				$this->xmlTableEstructureTemplate[$table]->appendChild($tempRow);
			}
			
			$xmlRoot->appendChild($this->xmlTableEstructureTemplate[$table]);
			
			$xmlDomain->appendChild($xmlRoot);
			
			$xml = $xmlDomain->save($this->xmlFolder.'/'.$this->package.'/'.$this->formatName($table).'.'.$this->xmlFile);
			
			//echo $xml;
			
		}catch (Exception $e) {
            new setException($e);
        }
        return true;
	}
}


$TSqlCompiler = new TSqlCompiler();
$TSqlCompiler->main();

if($_GET['reload']){
	echo '<script>setTimeout(function(){window.location.reload()},12000);</script>';
}