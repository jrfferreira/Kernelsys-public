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
    public  $tipoFiltro;// criterio de agrupamento do filtro
    
    /*
     * método __construct()
     *  instancia um novo filtro
     * param  $variable = variável
     * param  $operator = operador (>,<)
     * param  $value    = valor a ser comparado
     */
    public function __construct($variable, $operator, $value, $tipoFiltro = 1){

        // armazena as propriedades
        $this->variable = strtolower($variable);
        $this->operator = $operator;
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

        // caso seja um array
        if (is_array($value)) {

            // percorre os valores
            foreach ($value as $x) {
                
                // se for um inteiro
                if (is_integer($x) or is_numeric($x)){
                    $foo[]= $x;
                }
                else if (is_string($x)){
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
        // caso seja uma string
        else if (is_string($value)){

           // adiciona aspas
           if($value == "null"){
                $result = "$value";
           }else if(preg_match('|\(.*?\)|',$value)){
                $result = "$value";
           }else{
                $result = "'$value'";
           }
        }
        // caso seja valor nulo
        else if (is_null($value)){
            // armazena NULL
            $result = "null";
        }
        // caso seja booleano
        else if (is_bool($value)) {
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
    public function dump() {
        // concatena a expressão
        return "{$this->variable} {$this->operator} {$this->value}";

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
?>