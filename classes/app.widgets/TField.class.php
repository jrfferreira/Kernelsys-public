<?php
/**
 * classe TField
 * Classe base para construção dos widgets para formul�ros
 */
abstract class TField {

    protected $name;
    public    $id;
    protected $size;
    protected $value;
    protected $editable;
    protected $tag;
    protected $classField;
    public    $outControl;
    public    $label;
    public    $actPesquisa; //propridade da pesquisa

    /**
     * método construtor
     * instancia um campo do formulario
     * param  $name    = nome interno do campo
     */
    public function __construct($name) {
        // define algumas caractersticas iniciais
        self::setEditable(true);
        self::setName($name);

        // cria uma tag HTML do tipo <input>
        $this->tag = new TElement('input');
        $this->tag->id    = $name;
        $this->classField = "ui-state-default";
    }

    /*
    *
    */
    public function __set($prop, $valor) {

        $this->tag->$prop = $valor;
    }

    /**
     * Armazena os metodos a serem executado na camada de modelo de negocios
     * param string $control = nome dos metodos
     */
    public function setOutControl($control) {
        if($control) {
            $this->outControl = $control;
        }
    }

    /**
     * método setClass()
     * Define uma nova classe css
     * param  $name    = nome do widget
     */
    public function setClass($class, $agreg = NULL) {
        if($agreg) {
            $this->tag->class = $this->classField." ".$class;
        }
        else {
            $this->tag->class = $class;
        }
    }

    /**
     * método setName()
     * Define o nome do widget
     * param  $name    = nome do widget
     */
    public function setName($name) {
        $this->name = $name;
    }

    /**
     * método getName()
     * Retorna o nome do widget
     */
    public function getName() {
        return $this->name;
    }

    /**
     * método setId()
     * Define o nome do widget
     * param  $id    = id (HTML) do widget
     */
    public function setId($id) {
        $this->tag->id = $id;
        $this->id = $id;
    }

    /**
     * método getId()
     * Retorna o id (HTML) do widget
     */
    public function getId() {
        return $this->id;
    }

    /**
     * método setValue()
     * Define o valor de um campo
     * param  $value   = valor do campo
     */
    public function setValue($value) {

        //Executa a controle de modelo de negócio
        if($this->outControl) {
            $obModel = new TSetModel();
            $retModel = $obModel->main($this->outControl, $value, $this->name);
            $value = $retModel['valor'];
        }

        $this->value = $value;
    }

    /**
     * método getValue()
     * Retorna o valor de um campo
     */
    public function getValue() {
        return $this->value;
    }

    /**
     * método setEditable()
     * Define se o campo poderão ser editado
     * param  $editable = TRUE ou FALSE
     */
    public function setEditable($editable) {
        $this->editable = $editable;
    }

    /**
     * método getEditable()
     * Retorna o valor da propriedade editable
     */
    public function getEditable() {
        return $this->editable;
    }

    /**
     * método setProperty()
     * Define uma propriedade para o campo
     * param  $name  = nome da propriedade
     * param  $valor = valor da propriedade
     */
    public function setProperty($name, $value) {
        // $this->tag é um objeto agregado
        // será executado o seu método __set()
        // lidando internamente com a propriedade
        $this->tag->$name = $value;
    }

    /**
     * método setSize()
     * Define a largura do widget
     * param  $size    = tamanho em pixels
     */
    public function setSize($size) {
        if(!$this->disab) {
            $this->size = $size;
        }
    }
}