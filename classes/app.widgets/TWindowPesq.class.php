<?php
class TWindowPesq {

    private $x;         // coluna
    private $y;         // linha
    private $width;     // largura
    private $height;    // altura
    private $title;     // t�tulo da janela
    private $content;   // conte�do da janela
    static private $counter;   // contador
    public $winid;		//id da janela

    /**
     * método construtor
     * incrementa o contador de janelas
     */

    public function __construct($title , $id = NULL){

        // incrementa o contador de janelas
        // para exibir cada um com um ID diferente
        self::$counter ++;
        $this->title = $title;

		$this->winid = 'TWindow'.$id;
		$this->id = $id;
    }

    /**
     * método setPosition()
     * define a coluna e linha (x,y) que a janela ser� exibido na tela
     * param  $x   = coluna (em pixels)
     * param  $y   = linha (em pixels)
     */
    public function setPosition($x, $y)
    {
        // atribui os pontos cardinais
        // do canto superior esquerdo da janela
        $this->x = $x;
        $this->y = $y;
    }

    /*
     * método setSize()
     * define a largura e altura da janela em tela
     * param  $width   = largura (em pixels)
     * param  $height  = altura  (em pixels)
     */
    public function setSize($width, $height){

        // atribui as dimens�es
        $this->width = $width;
        $this->height = $height;
    }

    /*
     * método add()
     * adiciona um conte�do � janela
     * param  $content = conte�do a ser adicionado
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
        $TWindow->class = "TWindow_pesq";
        //$TWindow->style = "width:".$this->width."px; height: ".$this->height."px";
        $TWindow->title = $this->title;
        $TWindow->id = $this->winid;
        $TWindow->add($this->content);
        $TWindow->show();

    }
}