<?php
/*
 * classe TFilter
 *  Esta classe provê uma interface
 *  para definição de filtros de seleção
 */
class TFilter extends TExpression{
    
    private $variable;  // variável
    private $value;     // valor
    private $operator;  // operador aritimético
    public  $opLogico;  // operador logico para agrupamento do filtro
    public	$tipodado = 'string';  // tipo de dado que é recebido para formação do filtro
    public  $tipoFiltro;// criterio de agrupamento do filtro
    
    /*
     * método __construct()
     *  instancia um novo filtro
     * param  $variable = variável
     * param  $operator = operador (>,<)
     * param  $value    = valor a ser comparado
     */
    public function __construct($variable, $operator, $value, $tipodado = 'string', $tipoFiltro = 1){

        // armazena as propriedades
        $this->variable = strtolower($variable);
        $this->operator = $operator;
        $this->tipodado = strtolower($tipodado);
        // transforma o valor de acordo com certas regras
        // antes de atribuir à propriedade $this->value
        $this->value    = $this->transform($value);
        $this->tipoFiltro = $tipoFiltro;
    }
    
    /*
     * método transform()
     *  recebe um valor e faz as modificações necessárias
     *  para ele ser interpretado pelo banco de dados
     *  podendo ser um integer/string/boolean ou array.
     * param $value = valor a ser transformado
     */
    private function transform($value){
    	
    	$tipodado = strtolower($this->tipodado);

        // caso seja um array
        if (is_array($value)) {

        	if($this->operator == 'BETWEEN'){
        		
        		if($value[0] and $value[1]){
        			$result = "'$value[0]'".' and '."'$value[1]'";
        		}else{
        			$result = null;
        		}
                		
            }else{
                    	
	            // percorre os valores
	            foreach ($value as $x) {
	                
	                // se for um inteiro
	                if ($tipodado == 'numeric'){
	                    $foo[]= $x;
	                    
	                }else if ($tipodado == 'string'){
	                	
	                    // se for string, adiciona aspas
	                    if(preg_match('@\(.*?\)@',$x)){
	                        $foo[]= "$x";
	                    }else{
	                        $foo[]= "'$x'";
	                    }
	                }
	            }
	            // converte o array em string separada por ","
	            $result = '(' . implode(',', $foo) . ')';
        	}

        // Caso o campo seja do tipo numérico
        }else if($tipodado == 'numeric' and is_numeric($value)){
        	
        	$result = $value;	
        	if($this->operator == 'ILIKE' or $this->operator == 'LIKE') {
        		$this->operator = '=';
        	}

        //Caso o campo seja do tipo string
        }else if($tipodado == 'string'){
        	
        	
        	if($this->operator == 'ILIKE' or $this->operator == 'LIKE') {
        		 
        		//$value =  '%'.$value.'%';
        	}
        	        	
           // adiciona aspas
           if($value == "null"){
                $result = "$value";
           }else if(preg_match('|\(.*?\)|',$value)){
                $result = "$value";
           }else{
                $result = "'$value'";
           }
        }
        //campo do tipo date
        else if($tipodado == 'date' and preg_match('|-(.*?-)|',$value)){
        	$result = "'$value'";
        
        	if($this->operator == 'ILIKE' or $this->operator == 'LIKE') {
        		$this->operator = '=';
        	}
        }
        // caso seja valor nulo
        else if (is_null($value)){
            // armazena NULL
            $result = "null";
        }
        // caso seja booleano
        else if ($tipodado == "boolean" && is_bool($value)) {
            // armazena NULL
            $result = $value ? 'TRUE' : 'FALSE';
        }
        else {
            $result = $value;
        }

        // retorna o valor
        return $result;
    }

    /*
     * método dump()
     *  retorna o filtro em forma de expressão
     */
    
    private function formatName($name){
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
    
    public function dump($formatXml = false) {
        // concatena a expressão
        if($formatXml){
        	$variable = $this->formatName($this->variable);
        }else{
        	$variable = $this->variable;
        }
        return "{$variable} {$this->operator} {$this->value}";
    }
    
	public function getVariable() {
		return $this->variable;
	}

	public function getValue() {
		return $this->value;
	}

	public function getOperator() {
		return $this->operator;
	}

	public function getOpLogico() {
		return $this->opLogico;
	}

	public function getTipoFiltro() {
		return $this->tipoFiltro;
	}

	public function setVariable($variable) {
		$this->variable = $variable;
	}

	public function setValue($value) {
		$this->value = $value;
	}

	public function setOperator($operator) {
		$this->operator = $operator;
	}

	public function setOpLogico($opLogico) {
		$this->opLogico = $opLogico;
	}

	public function setTipoFiltro($tipoFiltro) {
		$this->tipoFiltro = $tipoFiltro;
	}

}