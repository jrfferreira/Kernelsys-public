<?php
/**
 * 
 * 
 * @author Wagner
 *
 */
class TBetweenDate extends TField {
	
	/**
	 * método show()
	 * exibe o widget na tela
	 */
	public function show(){
		//instancia doica campos data para serem exibidos na tela
		$datain = new TEntry('datain');
		$datain->setClass('ui-state-default ui_calendario dp-applied ui-state-hover');
		$datain->setSize('70');
		$datain->setProperty('onkeypress',"livemask(this,'99/99/9999',1,this)");
		$datain->setProperty('onkeyup',"livemask(this,'99/99/9999',1,this)");
		//$datain->setProperty('onBlur',"document.getElementsByName('".$this->name."').value = this.value");
		//$datain->setProperty('onBlur',"$('#".$this->name."').attr('value',this.value)");
		
		$datafn = new TEntry('datafn');
		$datafn->setClass('ui-state-default ui_calendario dp-applied ui-state-hover');
		$datafn->setSize('70');
		$datafn->setProperty('onkeypress',"livemask(this,'99/99/9999',1,this)");
		$datafn->setProperty('onkeyup',"livemask(this,'99/99/9999',1,this)");
		//$datafn->setProperty('onBlur',"document.getElementsByName('".$this->name."').value = document.getElementsByName('".$this->name."').value+';'+this.value);
		$datafn->setProperty('onBlur',"$('#".$this->name."').attr('value',$('#datain').attr('value')+';'+this.value)");
			
		// atribui as propriedades da TAG
		$this->tag->name  = $this->name;    // nome da TAG
		$this->tag->type  = 'hidden';       // tipo de input
		$this->tag->value = $this->value;   // valor da TAG

	
		if($this->size){
			$this->tag->style = "width:{$this->size}";  // tamanho em pixels
		}
	
		// se o campo não é editável
		if (!parent::getEditable()){
			$this->tag->readonly = "1";
			$this->tag->class = 'tfield_disabled'; // classe CSS
		}
		
		//conteiner dos campos
		$between = new TElement('span');
		$between->id = 'between_'.$this->name;
		
		$between->add($datain);
		$between->add($datafn);
		$between->add($this->tag);
	
		// exibe a tag
		$between->show();
	}
}

?>