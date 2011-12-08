<?php


class TSetCuston{

	public function __construct(){
	
		$this->botMin = new TElement('div');
		$this->botMin->id    = "botCuston";
		$this->botMin->onclick = "showBarCuston('menuBarCuston')";
		$this->botMin->class = "stbotCuston";
		$this->botMin->add('<img src="app.images/orb.png" border="0">');
		
		
		$this->menuBar = new TElement('div');
		$this->menuBar->id    = "menuBarCuston";
		$this->menuBar->class = "stMmenuBar";
		$this->menuBar->add('Customizar');
			
				$this->barraP = new TElement('div');
				$this->barraP->id   	   = "optionCuston01";
				$this->barraP->class	   = "stOptionCuston";
				$this->barraP->onMouseOver = "this.className='stOptionCustonoff'";
				$this->barraP->onMouseOut  = "this.className='stOptionCuston'";
				$this->barraP->add("Cor da barra principal");
				
				$this->fundoPg = new TElement('div');
				$this->fundoPg->id    = "optionCuston02";
				$this->fundoPg->class = "stOptionCuston";
				$this->fundoPg->onMouseOver = "this.className='stOptionCustonoff'";
				$this->fundoPg->onMouseOut  = "this.className='stOptionCuston'";
				$this->fundoPg->add("Cor de fundo");
		
		$this->menuBar->add($this->barraP);
		$this->menuBar->add($this->fundoPg);		
				
		
		$this->botMin->add($this->menuBar);
	}
	
	
	public function getBot(){
		return $this->botMin;
	}
	

}

?>
