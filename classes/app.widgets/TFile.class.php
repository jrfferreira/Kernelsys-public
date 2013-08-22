<?php
/**
 * classe TFile
 * Classe para construção de botões de seleção de arquivos
 */
class TFile extends TField{
    
    /**
     * método show()
     * exibe o widget na tela
     */
    public function show(){

        // atribui as propriedades da TAG
        $this->tag->name  = $this->name;    // nome da TAG
        $this->tag->value = $this->value;   // valor da TAG
 	$this->tag->size = $this->size;   // valor da TAG
        $this->tag->type  = 'file';         // tipo de input
        
  

      //  $endLine = $this->value ? '&file='.$this->value.'&rand=12323091239012' : '&rand=12323091239012';
$edit = '1';
        if (!parent::getEditable()){

            $edit = '0';

       }
        // exibe a tag
        $this->tag->show();
       // $frame = new TElement('iframe');
       // $frame->height = '200px';
       // $frame->width = '400px';
       // $frame->border = '0';
        // se o campo não é editável
        $edit = '1';
        if (!parent::getEditable()){
       
            $edit = '0';

       }
        //$frame->style = 'border: 0px; overflow: hidden; text-align: center;';
        //$frame->src = '../app.util/TSec.php?classe=TFileFrame&metodo=show&id='.$this->tag->properties['id'].'&form='.$this->tag->properties['form'].'&seq='.$this->tag->properties[TConstantes::SEQUENCIAL].'&edit='.$edit.$endLine;

        //$frame->show();
    }
    
}