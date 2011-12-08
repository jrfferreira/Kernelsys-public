<?php
/* classe TButton
 * respons�vel por exibir um bot�os
 */
class TButtonImg extends TField{

    private $action;
    //private $label;
    private $formName;
	
	public function setImg($src){
	
		$this->src = $src;
	}
    
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
    
    /**
     * método show()
     * exibe o bot�o
     */
    public function show(){

        $url = $this->action->serialize();
        
        // define as propriedades do bot�o
        $this->tag->name    = $this->name;    // nome da TAG
        $this->tag->type    = 'image';       // tipo de input
        $this->tag->value   = $this->label;   // r�tulo do bot�o
		$this->tag->src		= $this->src;

        // se o campo não � edit�vel
        if (!parent::getEditable())
        {
            $this->tag->disabled = "1";
            $this->tag->class = 'tfield_disabled'; // classe CSS
        }
		
       
        //define a ação do bot�o
        $this->tag->onClick = "document.{$this->formName}.action='{$url}'; ".
                              "document.{$this->formName}.submit()";
     	// exibe o bot�o
        $this->tag->show();
		
    }
}
?>
