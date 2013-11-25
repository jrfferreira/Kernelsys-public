<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
*/

class TSetCampo {

    /*
    * Formata campo field no Padrão do projeto
    */
    public function setCampo($campoNome, $tipoCampo, $styleClass, $editable = true) {

        if($this->nome == "") {
            $this->nome = $campoNome;
        }
        //$this->nome = strtolower($this->nome);

        if($tipoCampo == "TElement") {
            $this->fields = new TElement('span');
            $this->fields->id = $this->id;
            $this->fields->class = $styleClass;

        }else {      	

            //instancia objeto campo normalmente
            $this->fields = new $tipoCampo($this->nome);
            $this->fields->setId($this->id);
            $this->fields->setClass($styleClass, true);
            
            if($this->tipodado){
            	$this->fields->tipodado = $this->tipodado;
            }

            //define se o campo é editavel
            if(!$editable) {
                $this->fields->setClass(TClassJQuery::CLASS_CAMPO_DISABLED);
            }
        }

        //seta ações do campo
        if($tipoCampo == "TMultiSelect"){
            foreach($this->action as $action){
                $this->fields->setAction($action);
            }
        }

        //seta atributo outControl no campo
        if($this->control) {
            $this->fields->setOutControl($this->control);
        }
        
        //seta descrição do campo de pesquisa, caso haja
        if($this->descPesq) {
        	$this->fields->setDescPesq($this->descPesq);
        }
    }
    
    /*
     * retorna o tipo do campo de acordo com o modelo do krs
     * #paran seq = sequencial do tipo do campo
     */
    public function getTipoCampo($seq){
    
    	 $dbo = new TKrs('tipo_campo');
       	 $criteriaCampoProps = new TCriteria();
       	 $criteriaCampoProps->add(new TFilter('seq','=',$seq));
    
    	$Result = $dbo->select("*", $criteriaCampoProps);
    
    	if($tpca=$Result->fetchObject()){
    		return $tpca;
    	}
    
    }
    
    /**
     * Instancia o atributo que contem o outcontrol
     * param <type> $control
     */
    public function setOutControl($control) {
    	if($control and $control != "-") {
    		$this->control = $control;
    	}
    }
    
    /**
     * seta um nome especifico para o campo
     * param <string> $nome = nome do campo
     */
    public function setNome($nome) {
    	$this->nome = $nome;
    }
    
    /**
     * seta um id especifico para o campo
     * param <string> $id = id do campo
     */
    public function setId($id) {
    	$this->id = $id;
    }
    
    /*
    * Seta o tipo do dado definido para o campo
    * param <string> $tipodado = tipo de dado do campo
    */
    public function setTipoDado($tipodado){
    	$this->tipodado = $tipodado;
    }

    /**
    * define as ações do campo
    * param <type> $evento = evento javascript que dispara a a�ão
    * param <type> $action = a�ão a ser disparada pelo evento javascript
    */
    public function setAction($evento, $action){
    	$evento = strtolower($evento);
        if($this->action[$evento]){
            $this->action[$evento] = $this->action[$evento].'; '.$action;
        }else{
            $this->action[$evento] = $action;
        }

    }

    /**
     *
     * param <type> $propriedade
     * param <type> $valor 
     */
    public function setPropriedade($propriedade, $valor){

        $actions = array('onabort','onblur','onchange','onclick','ondblclick','ondragdrop','onerror','onfocus','onkeydown','onkeypress','onkeyup','onload','onmousedown','onmousemove','onmouseout','onmouseover','onmouseup','onmove','onreset','onresize','onselect','onsubmit','onunload');
        //caso a propriedade seja uma a�ão javascript
        if(in_array(strtolower($propriedade),$actions)){
            $this->setAction($propriedade, $valor);
        }
        elseif(method_exists($this->fields, $propriedade)) {//se o valor passado for um m�todo do campo

            if(!is_array($valor)){

                // se valor da propriedade for composto converte em vetor
                $vls = explode(";",$valor);

                // verifica se o valor da propriedade � composto ou simples
                if(count($vls) > 1) {
                    $this->fields->$propriedade($vls[0],$vls[1]);
                }else {

                    // Propriedades especificas dos bot�es de a�ão
                    if($this->fields instanceof TButton and $propriedade == "setAction"){

                        //vefifica as a��es inseridas atravez do registro do kernelsys
                        if(strpos($valor, '=')) {
                            $vact = explode('=', $valor);

                            $bAction = new TAction($vact[0]);

                            $paramentros = explode(',', $vact[1]);
                            foreach($paramentros as $kact=>$aparam) {
                                $bAction->setParameter('arg'.$kact, $aparam);
                            }
                        }
                        else {
                            $bAction = new TAction($valor);
                        }
                        $this->fields->$propriedade($bAction, $this->label);
                        $this->label = ' ';

                    }else {
                        $this->fields->$propriedade($valor);
                    }
                }

            }else{
                $this->fields->$propriedade($valor);
            }

        }
        else {// senão, atribui propriedade
           $this->fields->$propriedade = $valor;
        }
    }

     /**
     * seta uma label para o campo
     * param <string> $nome = label do campo
     */
    public function setLabel($label) {
        $this->fields->label = $label;
    }

    /**
    *
    * param <type> $valor
    */
    public function setValue($valor){
        $this->fields->setValue($valor);
    }

    /**
    *
    * return <type> 
    */
    public function getId(){
        return $this->fields->getId();
    }

    /**
    *
    */
    public function getCampo(){

        if(is_array($this->action)){
            foreach($this->action as $evento => $act){
                 $this->fields->$evento = $act;
            }
        }
        return $this->fields;
    }

}