<?php
/**
 * classe TRadioGroup
 * Classe para exibição de um grupo de Radio Buttons
 */
class TRadioGroup extends TField{

    private $layout = 'horizontal';
    private $items;
    
    /**
     * método setLayout()
     * Define a direção das opções (vertical ou horizontal)
     */
    public function setLayout($dir){
	
        $this->layout = $dir;
    }
    
    /**
     * method addItems($items)
     * adiciona itens (bot�es de r�dio)
     * param  $items = array idexado contendo os itens
     */
    public function addItems($items){
	
        $this->items = $items;
    }
	
	public function __set($prop, $valor){
		$this->props[$prop] = $valor;
	}
    
    /**
     * método show()
     * exibe o widget na tela
     */
    public function show(){
	
        if ($this->items){
		$cont = 1;
            // percorre cadauma das opções do rádio
            foreach ($this->items as $index => $label){
			
                $button = new TRadioButton($this->name);
                $button->setValue($index);
				$button->setId($this->name.$cont);
					$cont++;
				
				//atribui propriedades
				if($this->props){
					foreach($this->props as $kProp=>$vProp){
						
						$button->$kProp = $vProp;
					}
				}
                
                // se possui qualquer valor
                if ($this->value == $index){
                    // marca o radio button
                    $button->setProperty('checked', '1');
                }		
                $button->show();
              		$obj = new TElement('span');
					$obj->add( $label);
					$obj->style = 'font-size:11px; padding-right:15px;';
					$obj->show();
                
                if ($this->layout == 'vertical')
                {
                    // exibe uma tag de quebra de linha
                    $br = new TElement('br');
                    $br->show();
                }
                
                echo "\n";
            }
        }
    }
}
?>
