<?php
/*
 * Classe especifica para envio de Upload Ajax
 */
class TFrameFile extends TField {

    public function show(){

        // atribui as propriedades da TAG
        $this->tag->name  = $this->name;    // nome da TAG
        $this->tag->value = $this->value;   // valor da TAG
 	$this->tag->size = $this->size;   // valor da TAG
        $this->tag->type  = 'file';         // tipo de input



        $endLine = $this->value ? '&file='.$this->value.'&rand=12323091239012' : '&rand=12323091239012';

        // exibe a tag
        //$this->tag->show();



        $frame = new TElement('iframe');
        if ($this->tag->size){
            $size = explode(';', $this->tag->size);
            if($size[1]){
                $frame->height = $size[1];
                $frame->width =  $size[0];             
                
            }else{
                $frame->height = $size[0];
                $frame->width = $size[0];                 
            }
        }else{
                $frame->height = '200px';
                $frame->width = '400px';
        }
        $frame->border = '0';
        // se o campo não é editável
        $edit = '1';
        if (!parent::getEditable())
        {
            $edit = '0';
        }
        $frame->style = 'border: 0px; overflow: hidden; text-align: center;';
        $frame->src = '../app.util/TSec.php?classe=TFrame&metodo=show&id='.$this->tag->properties['id'].'&form='.$this->tag->properties['form'].'&codigo='.$this->tag->properties['codigo'].'&edit='.$edit.$endLine;

        $frame->show();
    }

    
}