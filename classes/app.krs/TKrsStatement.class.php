<?php 

class TKrsStatement {
	
	private $statement;
	
	public function __construct($statement){
		$this->statement = $statement;
	}
	
	public function fetch(){
		$output = $this->getOutput();
		if($output){
			return $output;
		}else{
			return false;
		}
	}
	
	public function fetchAll(){
		return $this->statement;
	}
	
	public function fetchObject(){
		$output = $this->getOutput();
		if($output){
			return (object) $output;
		}else{
			return false;
		}
	}
	
	private function getOutput(){
		if(count($this->statement) > 0){
		$output = current($this->statement);
		$key = @key(current($this->statement));
		unset($this->statement[$key]);
		next($this->statement);
		
		return $output;
		}else{
			return false;
		}
	}
}