<?php
/**
 *Class TAbas
 *Cria um sistema de abas apra lista e formularios
 */
class TAbas {

    public $vAbas 	= array(); 	//propriedade como vetor de abas
    public $pagina;			 	// objeto pagina (page)
    public $bots 	= array();	// objetos botões de ação do form
    protected $defalt;		 	// configura aba de inicialização
    private $idNum = 0;         //id num�rico das abas
    private $divBot = array();


    //método construtor
    //gera tabela conteniner da aba por meio da agregação da classe TTable
    //instancia os estilos utilizados, por agragação.
    public function __construct($id = NULL, $tituloJanela = 'Titulo da janela', $dimensao = NULL) {

        //div pai
        $this->divPai = new TElement('div');
        $this->divPai->class = "tabs";
        $this->tabs = new TElement('ul');
        $this->id = $id.'-tabs';

       // janela objeto formulário
       $this->window = new TWindow($tituloJanela, $id.'-window');
       $this->window->setAutoOpen();
        if($dimensao){
            $dimensao = explode(';', $dimensao);
            $this->window->setSize($dimensao[0],$dimensao[1]);
        }
       //$this->window->setDraggable();
    }

    /*método setBotao
	*Instancia propriedade botão das abas
	*param 		$bot = array de objetos TButton
    */
    public function setBotao(TButton $bot) {

        if(is_object($bot)) {
            $this->bots[] = $bot;
        }
        else {
            $this->bots = $bot;
        }
    }
/*
 * Função responsavel pelo Auto Save
 */
    public function setAutoSave($idForm){
        $this->autoSave = new TElement('div');
        $this->autoSave->style = "height: 16px; display: inline-block; float: right; width: 250px; text-align: right;";

       $iconSalvar = new TElement('div');
       $iconSalvar->class = "botaosalvarAutomatico ui-icon ui-icon-close";
       $iconSalvar->ligado = 'false';
       $iconSalvar->form = $idForm;
       $iconSalvar->style = "width: 16px; height: 16px; display: inline-block; float: right; position: relative; cursor: pointer; margin-top: 6px; margin-left: 4px; ";
       $iconSalvar->title = "Salvar Automaticamente";
       $iconSalvar->onClick = "autoSaveForm(this,'{$idForm}')";
       $iconSalvar->trigger = "autoSaveForm(this,'{$idForm}')";
       $iconSalvar->add(' ');
       //$IconSalvar = new TIcon('ui-icon-bullet','botaosalvarAutomatico', 'botaosalvarAutomatico');
       //$IconSalvar->setTitle('Salvar automaticamente');

       $textoSalvar = new TElement('div');
       $textoSalvar->ligado = 'false';
       $textoSalvar->id = "botaosalvarAutomatico_label".$idForm;
       $textoSalvar->class = "botaosalvarAutomatico_label";
       $textoSalvar->style = "margin-top: 7px; margin-right: 4px; ";
       $textoSalvar->add('Salvar Automaticamente');

       $this->autoSave->add($iconSalvar);
       $this->autoSave->add($textoSalvar);
    }
    /*Metodo addAbas
	*adiciona abas
    */
    public function addAbas($nome, $dados, $impressao = NULL) {

        //configura impressão
        if($impressao) {
            $this->impressao = " impressao";
            $this->impLabel  = " impLabel";
        }

        //contador das abas
        $this->idNum++;

        //cabe�alho das abas
        $headAba = new TElement('li');
        $link = new TElement('a');
        $link->href = "#".$this->id."-Aba-".$this->idNum;
        $link->class = $this->impLabel.$this->idNum;
        $link->id    = $this->id."-link-Aba-".$this->idNum;
        $link->add($nome);
        $headAba->add($link);
        $this->headAbas[] = $headAba;

        $DvAba = new TElement('div');
        $DvAba->class 	= $this->impressao.$this->idNum;
        $DvAba->id 	= $this->id."-Aba-".$this->idNum;

        $pCont = new TElement('div');
        $pCont->add("");

        if(is_array($dados)) {
            foreach($dados as $ob) {
                $pCont->add($ob);
            }
        }
        else {
            $pCont->add($dados);
        }
        $DvAba->add($pCont);

        $this->vAbas[$this->idNum] = $DvAba;
    }



    /*método setAbas
	*tem como função montar as abas para exibição
	*
    */
    private function setAbas() {

        //percorre botões das abas
        foreach($this->headAbas as $codigo => $obj) {
            $this->tabs->add($obj);
        }

        $this->divPai->add($this->tabs);

        foreach($this->vAbas as $divAba) {
            $this->divPai->add($divAba);
        }

        //configura display dos botões de ação padrão da aba
        //$divFerramentas = new TElement('div');
        //$divFerramentas->class = "ui-dialog-buttonpane";

        if(is_array($this->bots)) {
            foreach($this->bots as $bts) {
                $this->window->addButton($bts);
            }
        }else{
            $this->window->addButton($this->bots);
        }

       $this->window->addButton($this->autoSave);
       $this->window->add($this->divPai);

    }

    /*método Show
	*Propaga o metodo show para exibiss�o das abas em tela
    */
    public function show() {

        $this->setAbas();
        $this->window->show();
    }
}

?>