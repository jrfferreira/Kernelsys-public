<?php
// codifica a forma de saidad dos dados no header (tratando caracteres especiais) \\
//header("Content-Type: text/html; charset=UTF-8",true);

/**
 * classe TElement
 * Classe para abstração de tags HTML
 */
class TElement{

    private $name;         // nome da TAG
    public $properties;    // propriedades da TAG
    public $outControl;
    public $children;
    /**
     * método construtor
     * instancia uma tag html
     * param  $name    = nome da tag
     */
    public function __construct($name){
		
        // define o nome do elemento
        $this->name = $name;
    }
    
    /**
     * método __set()
     * intercepta as atribuições à propriedades do objeto
     * 
     * param  $name    = nome da propriedade
     * param  $value   = valor
     */
    public function __set($name, $value){
	    // armazena os valores atribuídos
        // ao array properties
        $this->properties[$name] = $value;
    }

    /**
     * método getProp()
     * retorna propriedades do objeto
     * param  $prop    = nome da propriedade
     */
    public function getProp($prop){
       return $this->properties[$prop];
    }
    
    /**
     * método add()
     * Adiciona um elemento filho
     * 
     * param  $child = objeto filho
     */
    public function add($child){
		$this->children[] = $child;
    }
    /**
     * método add()
     * Retorna o numero de elementos filhos
     *
     * param  $child = objeto filho
     */
    public function countChild(){
	return count($this->children);
    }
    /**
     * método clean()
     * Adiciona um elemento filho
     *
     * param  $child = objeto filho
     */
    public function clean(){
	$this->children = null;
    }
    /**
     * método open()
     * Exibe a tag de abertura na tela
     */
    private function open(){
		
        // exibe a tag de abertura
        echo "<{$this->name}";
        if ($this->properties){
		
            // percorre as propriedades
            foreach ($this->properties as $name=>$value){
                echo " {$name}=\"{$value}\"";
            }
        }
        if(count($this->children) > 0){
            echo '>';
        }
        else{
            echo '/>';
        }
    }

    /**
     * Armazena os metodos a serem executado na camada de modelo de negocios
     * param string $control = nome dos metodos
     */
    public function setOutControl($control){
        if($control){
            $this->outcontrol = $control;
        }
    }

    /**
     *
     */
    public function dump(){

        // abre a tag
        // exibe a tag de abertura
        $html =  "<{$this->name}";
        if ($this->properties){

            // percorre as propriedades
            foreach ($this->properties as $name=>$value){
                 $html .= " {$name}=\"{$value}\"";
            }
        }
        if(count($this->children) > 0){
             $html .= '>';
        }
        else{
            $html .= '/>';
        }

       // echo "\n";
        // se possui conteúdo
        if ($this->children){

            // percorre todos objetos filhos
            foreach ($this->children as $child){

                // se for objeto
                if (is_object($child)){

                    $html .= $child->dump();
                }
                else if ((is_string($child)) or (is_numeric($child))){

                    // se for texto
                    $html .= $child;
                }
            }
            // fecha a tag
           $html .= "</{$this->name}>\n";
        }

        return $html;
    }
    
    /**
     * método show()
     * Exibe a tag na tela, juntamente com seu conteúdo
     */
    public function show(){
		
        // abre a tag
        $this->open();
       // echo "\n";
        // se possui conteúdo
        if ($this->children){
		
            // percorre todos objetos filhos
            foreach ($this->children as $child){
			
                // se for objeto
                if (is_object($child)){				
                    $child->show();
                }
                else if ((is_string($child)) or (is_numeric($child))){
				
                    // se for texto
                    echo $child;
                }
            }
            // fecha a tag
            $this->close();
        }
    }
    
    /**
     * método close()
     * Fecha uma tag HTML
     */
    public function close(){
        echo "</{$this->name}>\n";
    }
}

?>