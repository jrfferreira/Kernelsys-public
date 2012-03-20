<?php
/* classe TButton
 * respons�vel por exibir um bot�os
 */
class TButton extends TField{

    private $action;
    private $formName;
    private $class = "";
    
    /**
     * método setAction
     * define a ação do bot�o (função a ser executada)
     * param  $action  = ação do bot�o
     * param  $label   = r�tulo do bot�o
     */
    public function setAction($action, $label){

        $this->action = $action;
        $this->label  = $label;
    }
    
    /**
     * método setFormName
     * define o nome do formulário para a ação bot�o
     * param  $name = nome do formulário
     */
    public function setFormName($name){
        $this->formName = $name;
    }
    
    /*
    *Intercepta propriedade não declarada
    */
    public function __set($prop,$val){
        $this->tag->$prop = $val;
    }

    /**
     * seta classe css do botão
     * param <type> $class
     */
    public function setClass($class){
        $this->class = " ".$class;// redefine a classe do botão
    }
	
    /**
     * método show()
     * exibe o bot�o
     */
    public function show(){
	
		$act = $this->action->serialize();

        // define as propriedades do bot�o
        $this->tag->name    = $this->name;    // nome da TAG
        $this->tag->type    = 'button';       // tipo de input
        $this->tag->value   = $this->label;   // rótulo do botão
        $this->tag->class   = "ui-state-default ui-corner-all".$this->class;
        
        // se o campo não � edit�vel
        if (!parent::getEditable()){
        	
            $this->tag->disabled = "1";
            $this->tag->class = 'tfield_disabled ui-state-default ui-corner-all'; // classe CSS
        }
		
       	if($act){
			//define a ação do bot�o
			$this->tag->onClick = "$act";
		}
		
     	// exibe o bot�o
        $this->tag->show();
		
    }
}