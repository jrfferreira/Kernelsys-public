<?php 

/**
 * Classe para consulta no banco XML
 * Funcionamento clonado do TDbo
 * 
 * @author jr8116
 *
 */
class TKrs {
	protected $xmlFolder = "../app.krs/schemas";
	protected $xmlFile = "kernelsys.xml";
	
	private $table;
	private $tableName;
	private $keySort;
	
	public function __construct($table = null){
		if(!empty($table)){
			$this->loadXmlTable($table);
		}
	}
	protected function formatName($name){
		$nameArray = explode('_',$name);
		if(is_array($nameArray)){
			foreach($nameArray as $i=>$n){
				$nameArray[$i] = ucfirst($n);
			}
			$name = implode('',$nameArray);
		}
	
		$first = strtolower(substr($name,0,1));
		$others = substr($name,1);
		$name = $first . $others;
		return $name;	
	}
	
	protected function reverseFormatName($name){
		$name = preg_replace('/([A-Z])/', '_\1', $name);
		$name = strtolower($name);
		if(is_array($nameArray)){
			foreach($nameArray as $i=>$n){
				$nameArray[$i] = strtolower($n);
			}
			$name = implode('_',$nameArray);
		}
		return $name;	
	}
	
	public function select($rows,$tCriteria = null){
		
		if($rows == '*'){
			$rowsRequired = true;
		}else{
			$rowsRequired = explode(',',$rows);
		}
		$filter = array();
		if(is_object($tCriteria)){
			
			$dump = $tCriteria->dump(true);
			if(strlen($dump) > 0){
				$dump= "[{$dump}]";
			}
			$filterString = "//kernelsys/{$this->formatName($this->tableName)}/row{$dump}";

			$xpath = new DOMXPath($this->table);
			
			$rows = $xpath->query($filterString);
			
		}else{		
			$rows = $this->table->getElementsByTagName('row');
		}		
		
		$response = array();
		//foreach($rows as $i => $row){
		for($i=0; $i<$rows->length; $i++){
			$row = $rows->item($i);
			//foreach($row->childNodes as $n => $column){
			for($n=0; $n < $row->childNodes->length; $n++){
				$column =  $row->childNodes->item($n);
				if($column->nodeName != '#text' && ($rowsRequired === true || array_search($column->nodeName, $rowsRequired) !== false)){
					if($column->nodeName != '#text'){
						$response[$i][$this->reverseFormatName($column->nodeName)] = $column->nodeValue;
					}
				}
			}
		}


		if($tCriteria->getProperty('order')){
				$this->sortBy($response, $tCriteria->getProperty('order'));
		}
		
		$statement = new TKrsStatement($response);
		
		return $statement;
	}
	
	public function close(){
		return true;
	}
	
	public function setEntidade($table){
			$this->loadXmlTable($table);		
	}
	
	private function loadXmlTable($table){
			$this->tableName = $table;
			$this->table = new DomDocument();
			$this->table->load($this->xmlFolder.'/'.$this->formatName($table).'.'.$this->xmlFile);			
	}

	public function sortBy(&$items, $key){
	  if (is_array($items)){
	  	$_REQUEST['key'] = $key;
	    return usort($items, "krsSort");
	  }
	  return false;
	}
}

function krsSort ($a, $b){
	$key = $_REQUEST['key'];
	if($a[$key] == $b[$key]){
		return 0;
	}else if($a[$key] > $b[$key]){
		return 1;
	}else{
		return -1;
	}
}