<?php
/*Class TSetaba
*configura o sistema de abas
*10/03/2008
*/

class TSetAbas extends TForm {

    public $ObAba;		// objeto aba
    private $bots = array();		//armazena objetos buttons do formulario

    public function __construct($idForm, $tituloJanela = 'Titulo da janela', $dimensao = NULL, $autoSave = 1) {

        parent::__construct($idForm);
        $this->ObAba = new TAbas($idForm, $tituloJanela, $dimensao);
        if($autoSave){
            $this->ObAba->setAutoSave($idForm);
        }
    }


    //método addAba
    //adiciona abas no formulário
    //param		$lab = nome da aba
    //param		$conteudo = conteudo a ser exibido na aba
    public function addAba($lab, $conteudo, $impressao = NULL) {
        
        $this->ObAba->addAbas($lab, $conteudo, $impressao);
    }

    /*
	*Metodo addBotao
	*Adiciona botões de ação no formulário
	*
    */
    public function addBotao($nome, $label, $action, $classecss = null) {

        $this->bots[$nome] = new TButton($nome);
        $this->bots[$nome]->setAction($action,$label);

        if($classecss){
             $this->bots[$nome]->setClass($classecss);
        }

        if($action->disabled){
            $this->bots[$nome]->disabled = 'true';
        }
    }


    /*método setCampos
	*Consigura os campos dentro do formulário
	*param	$campos = vetor com todos os campos do formulario
    */
    public function setCampos($campos) {

        $this->campos = $campos;

        if(!empty($this->bots)) {
            $fields = $this->campos+$this->bots;
        }else {
            $fields = $this->campos;
        }
        $this->setFields($fields);
    }

    /*
	*
	*param	$entidade = nome da tabela na base de dados
    */
    public function setAbas() {

        if(!empty($this->bots)) {
            foreach($this->bots as $ch=>$botao) {
                $this->ObAba->setBotao($botao);
            }
        }
        $this->add($this->ObAba);
    }

}