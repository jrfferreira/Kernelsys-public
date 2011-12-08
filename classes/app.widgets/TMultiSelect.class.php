<?php
/**
 * classe TMultiSelect
 * Classe para construção de combo boxes
 */
class TMultiSelect extends TField {

    private $items; // array contendo os itens da combo
    private $teste;
    private $actionOption;

    /**
     * método construtor
     * instancia a combo box
     * param  $name = nome do campo
     */
    public function __construct($name) {

        // executa o método construtor da classe pai.
        parent::__construct($name);
        // cria uma tag HTML do tipo <select>
        $this->tag = new TElement('select');
        $this->tag->id   = $name;
        $this->tag->multiple = 'multiple';
    }

    /**
     * método addItems()
     * adiciona items é combo box
     * param $items = array de itens
     */
    public function addItems($items) {
        if ($items !== false) {
            $this->items = $items;
            $this->teste = true;
        }
    }

    //capitura ação do campo e injeta nos filhos
    public function setAction($valor){
        $this->actionOption = $valor;
    }

    /*
    *
    *
    */
    public function setPadrao($codigo,$valor) {

        // cria uma TAG <option> com um valor padrão
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
            $qtd = 1;
            foreach ($this->items as $codigo => $item) {

                if($item == null) {
                    $item = $codigo;
                }
                // cria uma TAG <option> para o item
                $option = new TElement('option');
                $option->name = $this->name;
                $option->id   = $this->name.$qtd;
                $option->type = 'option';
                $option->value = $codigo;  // define o índice da opção
                $option->onclick = 'multiSelect_'.$this->actionOption;
                $option->add($codigo);
                $option->add(' - ');
                $option->add($item);     // adiciona o texto da opção
                

                // caso seja a opção selecionada
                if ($codigo == $this->value) {

                    // seleciona o item da combo
                    $option->selected = 1;
                }
                // adiciona a opção é combo
                $this->tag->add($option);
                $qtd++;
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