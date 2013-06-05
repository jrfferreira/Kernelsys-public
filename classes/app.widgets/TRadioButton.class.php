<?php
/**
 * classe TRadioButton
 * Classe para construção de r�dio
 */
class TRadioButton extends TField{

    private $checked;
	
	public function setId($id){
		$this->tag->id = $id;
	}
	
	/*
	*Intercepta propriedade não declarada
	*/
	public function __set($prop,$val){
		$this->tag->$prop = $val;
	}
    
    /**
     * método show()
     * exibe o widget na tela
     */
    public function show(){
	
        // atribui as propriedades da TAG
        $this->tag->name  = $this->name;
        $this->tag->value = $this->value;
        $this->tag->type  = 'radio';
        
        // se o campo não � edit�vel
        if (!parent::getEditable()){
		
            // desabilita a TAG input
            $this->tag->readonly = "1";
            $this->tag->class = 'tfield_disabled'; // classe CSS
        }
		
        // exibe a tag
        $this->tag->show();
    }
}