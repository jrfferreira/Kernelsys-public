<?php
/*
 * classe TCriteria
 *  Esta classe prov� uma interface
 *  utilizada para definição de crit�rios
 */
class TCriteria extends TExpression{

    private $expressions = array();  // armazena a lista de express�es
    private $operators;    // armazena a lista de operadores
    private $properties;   // propriedades do critério
    
    /*
     * método add()
     *  adiciona uma expressão ao critério
     * param  $expression = expressão (objeto TExpression)
     * param  $operator   = operador lógico de comparação
     */
    public function add(TExpression $expression, $operator = self::AND_OPERATOR){
    	
        //// agrega o resultado da expressão à lista de expressões
        if(!is_array($this->expressions[$expression->tipoFiltro])){
        	$this->expressions[$expression->tipoFiltro] = array();
        } 
                
        if(in_array($expression, $this->expressions[$expression->tipoFiltro]) === false){
            $expression->opLogico = $operator;
            $this->expressions[$expression->tipoFiltro][] = $expression;
        }
        //print_r($this->expressions);
        
    }
	
	/*método clear
	*limpa os criterios de pesquisa
	*/
	public function clear(){
		$this->expressions = NULL;
		$this->operators   = NULL;
	}
    
	public function drop(){
		return $this->expressions;
	}
	
    /*
     * método dump()
     *  retorna a expressão final
     */
    public function dump($formatXml = false){

        // concatena a lista de expressães
        if(is_array($this->expressions)){
        	
            $operator = "";
            foreach ($this->expressions as $gp=>$expression){

                //$expression = array_unique($expression);

                $result = ' (';
                foreach($expression as $obExp){
                    // concatena o operador com a respectiva expressão
                    $result .=  ' '.$operator.' '.$obExp->dump($formatXml).' ';
                    $operator = strtolower($obExp->opLogico);
                }
                $result .= ') ';

                $groups[] = $result;

//                if(empty($group)){ unset($operator);}
//                $group = $group.$operator.$result;
                
                $operator = NULL;
                $result = NULL;
            }

            $group = is_array($groups) ? implode('and', $groups) : $groups;

            $resultExp = trim($group);
            return "{$resultExp}";
        }
    }
	    
    /*
     * método setProperty()
     *  define o valor de uma propriedade
     * param  $property = propriedade
     * param  $value    = valor
     */
    public function setProperty($property, $value = null){
    	if($value){
        	$this->properties[$property] = $value;
    	}else{
    		unset($this->properties[$property]);
    	}
    }
    
    /*
     * método getProperty()
     *  retorna o valor de uma propriedade
     * param  $property = propriedade
     */
    public function getProperty($property = null){
    	if($property){
        	return $this->properties[$property];
    	}else{
    		return $this->properties;
    	}
    }
}
