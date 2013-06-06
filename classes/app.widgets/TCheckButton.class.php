<?php
/**
 * classe TCheckButton
 * Classe para construção de bot�es de verificação
 */
class TCheckButton extends TField{
    /**
     * método show()
     * exibe o widget na tela
     */
    public function show(){
        // atribui as propriedades da TAG
        $this->tag->name  = $this->name;    // nome da TAG
        $this->tag->value = $this->value;   // valor
        $this->tag->type  = 'checkbox';     // tipo do input
        
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