<?php
/**
 * classe TCombo
 * Classe para construção de combo boxes
 */
class TCombo extends TField {

    private $items; // array contendo os itens da combo
    private $teste;

    /**
     * método construtor
     * instancia a combo box
     * param  $name = nome do campo
     */
    public function __construct($name, $optionDefault = true) {

        // executa o método construtor da classe pai.
        parent::__construct($name);
        // cria uma tag HTML do tipo <select>
        $this->tag = new TElement('select');
        $this->tag->class = 'ui-state-default';       // classe CSS
        $this->tag->id   = $name;

        if($optionDefault){
            $this->items[0] = "Selecione uma opção";
        }
    }

    /*
    *
    */
    public function __set($prop, $valor){
        if($prop){
            $this->$prop = $valor;
            $this->tag->$prop = $valor;
        }
    }

    /**
     * método addItems()
     * adiciona items é combo box
     * param $items = array de itens
     */
    public function addItems($items) {
        if ($items and count($items) > 0) {
            if(!$items[0] and $this->items){
                $this->items = $this->items+$items;
            }else{
                $this->items = $items;
            }
            $this->teste = true;
        }
    }

    /*
    *
    *
    */
    public function setPadrao($codigo,$valor) {

        // cria uma TAG <option> com um valor padr�o
        $this->optionPD = new TElement('option');
        $this->optionPD->add($valor);
        $this->optionPD->value = $codigo;   // valor da TAG

    }

    /**
     * método show()
     * exibe o widget na tela
     */
    public function show() {

        // atribui as propriedades da TAG
        $this->tag->name  = $this->name;    // nome da TAG
        $this->tag->style = "width:{$this->size}";  // tamanho em pixels

        if($this->optionPD) {
            // adiciona a opção é combo
            $this->tag->add($this->optionPD);
        }

        if ($this->teste === true) {

            // percorre os itens adicionados
            if(is_array($this->items) and count($this->items) > 0){

                foreach ($this->items as $codigo => $item) {

                    if($item == null) {
                        $item = $codigo;
                    }
                    // cria uma TAG <option> para o item
                    $option = new TElement('option');
                    $option->value = $codigo;  // define o índice da opção
                    $option->add($item);     // adiciona o texto da opção

                    // caso seja a opção selecionada
                    if ($codigo == $this->value) {

                        // seleciona o item da combo
                        $option->selected = 1;
                    }
                    // adiciona a opção é combo
                    $this->tag->add($option);
                }
            }
            $this->teste = false;
        }

        // verifica se o campo é editável
        if (!parent::getEditable()) {

            // desabilita a TAG input
            $this->tag->readonly = "1";
            $this->tag->class = 'tfield_disabled'; // classe CSS
        }
        

        // exibe a combo
        $this->tag->show();
    }
}
?>