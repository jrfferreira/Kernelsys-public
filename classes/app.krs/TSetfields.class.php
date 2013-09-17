<?php
/**
 * Classe TSetform
 * configura os campos do formulario em tabelas
 * Autor: Wagne Borba
 * 07/04/2008
 */

class TSetfields {

    public $fields = array(); // armazena campos do formulário
    public $labs   = array(); // armazena os label dos campos
    public $bots   = array(); // armazena objeto botão de ação
    public $conteiner; 		  // objeto tabela ( conteiner primario do formulário )
    private $campoHelp = NULL; // contem o [ help ] do campo


    /**
     * Metodo __construct()
     * Configura atibutos e metodos basicos para o funcionamento da class
     */
    public function __construct($nivelRaiz = NULL) {

        if($nivelRaiz) {
            $this->nivelRaiz = $nivelRaiz;
        }
        //inicia objeto sesseion
        $this->obsession = new TSession();

        $this->conteiner = new TTable($propriedades);
        $this->conteiner->style   	= 'border:0px';
        $this->conteiner->cellpadding	= "1";
        $this->conteiner->cellspacing 	= "2";
        $this->conteiner->align		= "center";
        $this->conteiner->width  	= "100%";
    }

    /**
     * Metodo setCampo
     * adiciona um campo no vetor de campos
     * param	$lab = label do campo
     * param	$campo = objento TFild do campo no formulário
     * param   $actPesquisa = ativa o botão de pesquisa no contexo do campo
     */
    public function addCampo($lab, $campo, $actPesquisa = NULL) {

        $this->fields[$campo->getId()] = $campo;
        $this->fields[$campo->getId()]->label = $lab;

        if($actPesquisa){
            $this->fields[$campo->getId()]->actPesquisa = $actPesquisa;
        }
    }

    /**
     * Gera campo direto
     * param <type> $lab
     * param <type> $nomeCampo
     * param <type> $tipoCampo
     * param <type> $styleClass
     * param <type> $actPesquisa
     */
    function geraCampo($lab, $nomeCampo, $tipoCampo, $styleClass, $actPesquisa = NULL) {

        $campo = new TSetCampo();
        $campo->setCampo($nomeCampo, $tipoCampo, $styleClass);

        $obField = $campo->getCampo();
        $obField->label = $lab;

        $this->fields[$nomeCampo] = $obField;


        if($actPesquisa) {
            $this->fields[$campo->getId()]->actPesquisa = $actPesquisa;
        }
    }

    /**
     * Atribui propriedades especificas nos campos do conteiner
     * param <type> $campo
     * param <type> $prop
     * param <type> $valor
     */
    public function setProperty($campo, $prop, $valor) {
    	if(method_exists($this->fields[$campo],$prop)){
    		$this->fields[$campo]->$prop($valor);
    	}else{
        $this->fields[$campo]->$prop = $valor;
    }
    }

    /*
    * Configura HELP do campo
    */
    function setHelp($campo, $msg) {
        if($campo and $msg) {
            $this->campoHelp[$campo] = $msg;
        }
    }

    /*
    * cria uma trigger onload nos campos
    */
    public function addTrigger($campo, $funcIsca) {
        $this->trigger[$campo] = $funcIsca;
    }

    /*Método setValue
    * Atribui valor ao campo
    * param		$campo = Identificador do campo
    * param		$valor = valor do campo
    */
    public function setValue($campo, $valor) {
        if(count($this->fields)>0) {
            
            if($this->fields[$campo]) {
                $this->fields[$campo]->setValue($valor);
            }
        }
        else {
            echo 'ERRO: Nenhum campo foi definido. Aquivo TSetfields.class.php - linha 41 - método [setValue()]';
            exit();
        }
    }


    /**
     * Metodo getCampos()
     * Retorna um vetor com todos os campos (servirá de paramentro para TForm)
     * Autor: Wagner Borba
     */
    public function getCampos() {
//        foreach($this->fields as $chave => $field){
//            $fields[$chave] = $field->getCampo();
//        }
        return $this->fields;
    }

    /**
     * Metodo addObjetos()
     * Adiciona objetos(Elementos html) anexo no escopo do bloco
     * Autor: Wagner Borba
     * param Object = Objeto a ser injetado no bloco
     */
    public function addObjeto($obj, $concat = NULL) {
        $this->fields[$obj->getName()] = $obj;

        if(get_class($obj) == 'TButton') {
            $this->labs[$obj->getName()] = ' ';
        }
    }

    /*Método setRow()
    * configura a linha da tabela para os capos gerando a label de cada campo
    * Autor: Wagner Borba
    */
    private function setRow(){

        //add campo na linha
        foreach($this->fields as $ch => $obField){

           // $field = $obField->getCampo();
            $row = $this->conteiner->addRow();

            //adiciona trigger no campo
            if($this->trigger[$ch]){
                $obField->trigger = $this->trigger[$ch];
            }

            //Conteiner da label
            if($obField->label != ""){
                $cellLabel = $row->addCell(" ");
                $cellLabel->class = "tlabel";
                if(get_class($obField) != 'TButton' && get_class($obField) != 'THidden'){
                    $cellLabel->add($obField->label);
                }
            }


            //adiciona campo na tabela de campos
            $cellCont = $row->addCell($obField);
            if(!$obField->label){
                $cellCont->colspan = '2';
            }

            //Conteiner do campo
            if(get_class($obField) != 'TElement') {
                $cellCont->id = $obField->getId()."cell";
            }

            //atribui botao de pesquisa
            if($obField->actPesquisa) {
            	
            	
            	//cria campo hidden para o sequencial
            	$campoLabel = new TSetCampo();
            	$campoLabel->setId($obField->getId().'Label');            	
            	$campoLabel->setCampo($obField->getId().'Label','TEntry', '');
            	$campoLabel = $campoLabel->getCampo();
            	$campoLabel->setSize('300');
            	$campoLabel->disabled = 'disabled';
            	
            	          	
	            	//redefine o nome do campo label
	            	//$obField->setName($obField->getName().'Label');
	            	//$obField->setId($obField->getId().'Label');
	            	//$obField->manter = false;
	            	//$obField->getElement()->properties['view'] = 'false';
	            	
            	$cellCont->add($campoLabel);
	            	
            	

                $contPesq = new TElement('img');
                $contPesq->id 		= 'botPesq'.$ch;
                $contPesq->src 		= "../app.view/app.images/ico_view.png";
                $contPesq->border 	= "0";
                $contPesq->alt 		= "Pesquisar";
                $contPesq->align	= "absbottom";
                $contPesq->hspace	= "0";
                $contPesq->vspace	= "0";
                $contPesq->onClick	= "prossExe('onPesquisa', 'lista', '".$obField->actPesquisa."','".$obField->actPesquisa."', 'winRet', '')";
                $cellCont->add($contPesq);
            }

            // injeta [HELP] no escopo do campo
            if($this->campoHelp[$ch]) {

                $liHelp = new TElement('span');
                $liHelp->id = "icons";
                $liHelp->title = $this->campoHelp[$ch];
                $liHelp->class = "ui-icon ui-icon-help";
                $liHelp->style = "display: inline; padding-left:18px; font-size: 9px; padding-top: 3px; padding-bottom: 3px;";
                $liHelp->add('');

                $cellCont->add($liHelp);
            }

            //adiciona espaço [label] do campo
            if(get_class($obField) != 'TMultiSelect' and get_class($obField) != 'THidden') {

                $obLab2 = new TElement('span');
                $obLab2->id = $obField->getId()."dsp";
                //$obLab2->class = "ui-state-default";
                $obLab2->add("");

                $cellCont->add($obLab2);
            }

        }

    }

    /**
     * Método getConteiner()
     * Retorna conteiner(bloco)
     * Autor: Wagner Borba
     */
    public function getConteiner() {
        $this->setRow();
        return $this->conteiner;
    }
}