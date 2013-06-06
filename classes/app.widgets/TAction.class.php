<?php

/**
 * classe TAction
 * encapsula uma ação
 */
class TAction {

    private $actions;
    private $param;
    private $pkey;

    /**
     * método __construct()
     * Instancia uma nova ação
     * param  $action = método a ser executado
     */
    public function __construct($actions) {

        $this->actions = $actions;
    }

    //Intercepta atributos não declarados e os instancia
    public function __set($param, $value) {
        $this->$param = $value;
    }

    /**
     * método setParameter()
     * acrescenta um parâmetro ao método a ser executdao
     * param  $param = nome do parâmetro
     * param  $value = valor do parâmetro
     */
    public function setParameter($param, $value) {

        if ($param == "this" or $value == "this") {
            $this->param[$param] = $value;
        } else {
            $this->param[$param] = "'$value'";
        }
    }

    public function getParameter($param) {
        if ($this->param[$param]){
            return $this->param[$param];
        } else {
            return false;
        }
    }

    /**
     * método setPath()
     * acrescenta um parâmetro ao método a ser executdao
     * param  $idRetorno = id do objeto HTML receptor do retorno
     */
    public function setPath($idRetorno) {
        $this->ret = "'$idRetorno'";
    }

    /**
     * método serialize()
     * transforma a ação em uma string do tipo URL
     */
    public function serialize() {

        if (count($this->param) >= 1) {//verifica se h� paremtros a serem passados.
            $param = implode(',', $this->param);
        }

        //injeta argumento chave nos paramentos da ação JS. Exp:Codigo = 90984-03
        //if($this->pkey!=""){ $param = $param.','.$this->pkey; }
        //agrega objeto de retono aos paramentos da ação JS
        //if($this->ret!=""){ $param = $param.','.$this->ret; }

        if ($param) {
            $param = ltrim($param, ',');
            $act = $this->actions . "(" . $param . ")";
        } else {
            $act = $this->actions;
        }

        /* / verifica se h� par�metros
          if ($this->param){

          $c = 0;
          foreach($this->param as $pr){

          if($c!=0){ $separador = ','; }
          $act .=  $separador."'$pr'";

          $c++;
          }

          } */

        if ($this->actions != "") {

            return $act;
        } else {
            return false;
        }
    }

}