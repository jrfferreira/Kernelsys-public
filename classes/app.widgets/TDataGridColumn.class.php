<?php
/**
 * class TDataGridColumn
 * Representa uma coluna de uma listagem
 */
class TDataGridColumn
{
    private $name;
    public $label;
    private $align;
    private $width;
    private $action;
    private $transformer;
    private $visibilidade;
    
    /**
     * método __construct()
     * Instancia uma coluna nova
     * param  $name  = nome da coluna no banco de dados
     * param  $label = r�tulo de texto que ser� exibido
     * param  $align = alinhamento da coluna (left, center, right)
     * param  $width = largura da coluna (em pixels)
     */
    public function __construct($name, $label, $align, $width){
        // atribui os par�metros �s propriedades do objeto
        $this->name  = $name;
        $this->label = $label;
        $this->align = $align;
        $this->width = $width;
    }
	
	public function __set($name, $value){
	    // armazena os valores atribu�dos
        // ao array properties
        $this->$name = $value;
    }
    
    /**
     * método getName()
     * Retorna o nome da coluna no banco de dados
     */
    public function getName(){
        return $this->name;
    }
    
    /**
     * método getLabel()
     * Retorna o nome do r�tulo de texto da coluna
     */
    public function getLabel(){
        return $this->label;
    }
    
    /**
     * método getAlign()
     * Retorna o alinhamento da coluna (left, center, right)
     */
    public function getAlign(){
        return $this->align;
    }
    
    /**
     * método getWidth()
     * Retorna a largura da coluna (em pixels)
     */
    public function getWidth(){
        return $this->width;
    }
    
    /**
     * método setAction()
     * Define uma ação a ser executada quando o usu�rio
     * clicar sobre o t�tulo da coluna
     * param  $action = objeto TAction contendo a ação
     */
    public function setAction(TAction $action){
        $this->action = $action;
    }
    
    /**
     * método getAction()
     * Retorna a ação vinculada � coluna
     */
    public function getAction(){
	
        // verifica se a coluna possui ação
        if ($this->action){
		
            return $this->action->serialize();
        }
    }
    
    /**
     * método setTransformer()
     * Define uma função(class) (callback) a ser aplicada sobre
     * todo dado contido nesta coluna
     * param  $callback = função do PHP ou do usu�rio
     */
    public function setTransformer($callback){
	
        $this->transformer = $callback;
    }

    /**
     * método getTransformer()
     * Retorna a função (callback) aplicada � coluna
     */
    public function getTransformer(){
	
        return $this->transformer;
    }

     /**
     * método setVisibilidade()
     * configura a visibilidade da coluna na tela
     */
    public function setVisibilidade($visibilidade){
      $this->visibilidade = $visibilidade;
    }

     /**
     * método getVisibilidade()
     * retorna a visibilidade da coluna
     */
    public function getVisibilidade(){
        return $this->visibilidade;
    }
}
