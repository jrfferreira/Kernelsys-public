<?php
/**
 * classe TPage
 * Classe para controle do fluxo de execução
 */
class TPage {

    /**
    * método __construct()
    *
    */
    public function __construct($tit, $func = NULL) {
        // parent::__construct('html');


        $this->head = new TElement('head');

        $this->head->add('<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />');

        if($tit != "untitled") {
            $this->titulo = new TElement('title');
            $this->titulo->add($tit);
            $this->head->add($this->titulo);
        }

        $this->body = new TElement('body');
        $this->body->onload="atribuicao();";
        if($func) {
            $this->body->onload .= $func;
        }
        $this->body->id    = "tpage";
        $this->body->class = "pageDisp";
        //$this->body->style = "";

        $this->html = new TElement('html');
        $this->html->xmlns="http://www.w3.org/1999/xhtml";
        $this->html->__set("lang","pt-br");
        $this->html->__set("xml:lang","en");
        $this->html->add($this->head);
        $this->html->add($this->body);
    }

    public function add($child) {
        $this->body->add($child);
    }

    /**
    *
    * param <type> $ob
    */
    public function addHead($ob){
        $this->head->add($ob);
    }

    /**
    *
    */
    public function setJqueryUi($dir = null){

        $includes = new includesUI($dir);
        $vetIncludes = $includes->get($dir);
        foreach($vetIncludes as $obIncludes) {
            $this->addHead($obIncludes);
        }

    }

    /**
     * método show()
     * Exibe o conte�do da p�gina
     */
    public function show() {
       // echo '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">';
       //echo '<!DOCTYPE HTML>';
       echo '<?xml version="1.0" encoding="UTF-8"?>';
        $this->html->show();
    }

}