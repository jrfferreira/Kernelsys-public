<?php
/**
 * classe TEntry
 * Classe para construção de caixas de texto
 */
class TEntry extends TField{

    /**
     * método show()
     * exibe o widget na tela
     */
    public function show(){
	 
        // atribui as propriedades da TAG
        $this->tag->name  = $this->name;    // nome da TAG
        $this->tag->value = $this->value;   // valor da TAG
        $this->tag->type  = 'text';         // tipo de input
		
		if($this->size){
                    $this->tag->style = "width:{$this->size}";  // tamanho em pixels
		}
        
        // se o campo não � edit�vel
        if (!parent::getEditable()){
            $this->tag->readonly = "1";
            $this->tag->class = 'tfield_disabled'; // classe CSS
        }
        
        // exibe a tag
        $this->tag->show();
    }
}