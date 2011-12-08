<?php

//header("Content-Type: text/html; charset=UTF-8",true);
/**
 * classe TWindow
 * TWindow � um container que exibe seu conte�do
 * em um painel flutuante na tela
 */


class TWindow {

    private $x;         // coluna
    private $y;         // linha
    private $width;     // largura
    private $height;    // altura
    private $autoOpen = 'false'; //abrir quando instanciada
    private $modal = 'true'; // Draggable
    private $drag = 'false'; // Draggable
    private $title;     // título da janela
    private $content;   // conte�do da janela
    static private $counter;   // contador
    public $winid;		//id da janela

    /**
     * método construtor
     * incrementa o contador de janelas
     */

    public function __construct($title , $id = NULL){

        $this->header = new TSetHeader();
        $this->interface = $this->header->getHead('interface');
        // incrementa o contador de janelas
        // para exibir cada um com um ID diferente
        self::$counter ++;
        $this->title = $title;
    
        if($id == NULL){
            $id = substr(md5($title),2,10);
        }
        //$window_id = 'TWindow'.self::$counter;
        //$this->winid = 'TWindow'.self::$counter;
        $this->winid = $id;
        $this->id = $id;
    

        //Conteiner dos botôes da janela
        $this->paneButton = new TElement('div');
        //$this->paneButton->class = "ui-dialog-buttonpane";
        $this->paneButton->id = $id.'-buttonpane';
    }

    /**
     * método setPosition()
     * define a coluna e linha (x,y) que a janela ser� exibido na tela
     * param  $x   = coluna (em pixels)
     * param  $y   = linha (em pixels)
     */
    public function setPosition($x, $y){
        // atribui os pontos cardinais
        // do canto superior esquerdo da janela
        $this->x = $x;
        $this->y = $y;
    }

    public function setDraggable(){
        $this->drag = 'true';
    }

    public function setResizable(){
        $this->resize = 'true';
    }

    public function setModal($d){
      $this->modal = $d;
    }

    public function setEscFunction(){
        $this->closeOnEscape = 'true';
    }

    /*
     * param
     * $t= 'true' or 'false
     */
    public function setAutoOpen(){
        $this->autoOpen = 'true';
    }
    /**
    public function getZindex(){
        $zIndex = (($this->interface['zIndex'])/100 + 1) * 100 ;
        $this->header->addHeader('interface','zIndex',$zIndex);

        return $zIndex;
    }
    */
    /**
     * Adiciona botões no conteiner de botões da janela
     * param <button> $bot = botão;
     */
    public function addButton($bot){
        if($bot){
            $this->paneButton->add($bot);
        }
    }

    /*
     * método setSize()
     * define a largura e altura da janela em tela
     * param  $width   = largura (em pixels)
     * param  $height  = altura  (em pixels)
     */
    public function setSize($width, $height = '500px'){

        // atribui as dimensões
        $this->win_width = $width;
        $this->win_height = $height;
    }

    /*
     * método add()
     * adiciona um conteúdo à janela
     * param  $content = conteúdo a ser adicionado
     */
    public function add($content){

        $this->content = $content;
    }

	/*
	*define visualização padr�o
	*atributo de visualização
	*/
	public function setView($tvis = NULL){
            $this->tvis = $tvis;
	}

    /*
     * método show()
     * exibe a janela na tela
     */
    public function show(){
        $TWindow = new TElement("div");
        $TWindow->class = "TWindow";
        //$TWindow->onLoad = "$('.TWindow').resize(".$this->width.", ".$this->height.")";
        $TWindow->win_width = $this->win_width;
        $TWindow->win_height = $this->win_height;
        $TWindow->draggable = $this->drag;
        $TWindow->resizable = $this->resize;
        $TWindow->title = $this->title;
        $TWindow->modal = $this->modal;
        $TWindow->autoOpen = $this->autoOpen;
        $TWindow->id = $this->winid;
        //$TWindow->index = $this->getZindex();
        $TWindow->closeOnEscape = $this->closeOnEscape;
        $TWindow->add($this->content);
        $TWindow->add($this->paneButton);
        $TWindow->show();
    }
}
?>