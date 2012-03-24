<?php
/**
 * classe TForm
 * Classe para construção de formulários
 * 
 */

class TForm{

    protected $fields;      // array de objetos contidos pelo form
    private   $name;        // nome do formulário
    
    /*
     * método construtor
     * instancia o formulário
     * param  $name = nome do formulário
     */
    public function __construct($name = 'my_form'){
	        $this->setName($name);
    }

    /**
     * método setName()
     * define o nome do formulário
     * param  $name    = nome do formulário
     */
    public function setName($name){
        $this->name = $name;
    }
    
    /**
     * método setEditable()
     * Define se o formulário poderá ser editado
     * param  $bool = TRUE ou FALSE
     */
    public function setEditable($bool){
        if ($this->fields){
            foreach ($this->fields as $object){
                $object->setEditable($bool);
            }
        }
    }
    
    /**
     * método setFields()
     * Define quais são os campos do formulário
     * param  $fields = array de objetos TField
     */
    public function setFields($fields){

        if($fields) foreach ($fields as $identif=>$field){
            if ($field instanceof TField){
               // $name = $field->getName();
                $name = $identif;
				
                $this->fields[$name] = $field;

                if ($field instanceof TButton or $field instanceof TButtonImg){
                    $field->setFormName($this->name);
                }
            }
        }
    }
    
    /**
     * método getField()
     * Retorna um campo do formulário por seu nome
     * param  $name    = nome do campo
     */
    public function getField($name){
	
        return $this->fields[$name];
    }
    
    /**
     * método setData()
     * Atribui dados aos campos do formulário
     * param  $object = objeto com dados
     */
    public function setData($object){

        if(count($this->fields) > 0){

            foreach ($this->fields as $name => $field){

                    $coluna = $field->getName();
                if ($coluna){ // labels não possuem nome


                    if(is_object($object)){
                        if($object->$coluna != ""){
                            $valorCampo = $object->$coluna;
                        }
                    }
                    else if(is_array($object)){
                        if($object[$coluna] != ""){
                            $valorCampo = $object[$coluna];
                        }
                    }                    

                     $field->setValue($valorCampo);
                     $valorCampo = NULL;
                }
            }
        }
    }
    
    /**
     * método getData()
     * Retorna os dados do formulário em forma de objeto
     */
    public function getData($class = 'StdClass'){

        $object = new $class;
        foreach ($_POST as $key=>$val){
            if (get_class($this->fields[$key]) == 'TCombo'){

                if ($val !== '0'){
                    $object->$key = $val;
                }
            }
            else{
                $object->$key = $val;
            }
        }
        
        // percorre os arquivos de upload
        foreach ($_FILES as $key => $content){
            $object->$key = $content['tmp_name'];
        }
        
        return $object;
    }

    /**
     * método add()
     * Adiciona um objeto no formulário
     * param  $object = objeto a ser adicionado
     */
    public function add($object){
        $this->child = $object;
    }

    /*
     * Configura se o formulário podera ser submetido
     */
    public function setSubmit($valor){
        $this->submit = $valor;
    }
 
  /**
     * método show()
     * Exibe o formulário na tela
     */
    public function show(){
	
        // instancia TAG de formulário
        $tag = new TElement('form');
        $tag->name   = $this->name; // nome do formulário
		$tag->id     = $this->name;
        $tag->onsubmit = "return $this->submit";// function(){return false;};
        $tag->method = 'post';      // método de transferência
		$tag->style = "margin:0px;";
        $tag->enctype = "application/x-www-form-urlencoded";//"Content-Type: text/html; charset=UTF-8";
        // adiciona o objeto filho ao formulário
        $tag->add($this->child);
        // exibe o formulário
        $tag->show();
    }

}// fim da class


?>