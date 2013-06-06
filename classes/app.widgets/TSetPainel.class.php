<?php
/*Class TSetPainel
*configura o sistema de paineis
*10/03/2008
*/

class TSetPainel extends TForm{

	/*
	*método construtor
	*paran 		$form = nome do formulário
	*/
	public function __construct($form){

		parent::__construct($form);

		$this->ObAba = new TPainel();
	}


	//método addAba
	//adiciona abas no formulário
	//param		$lab = nome da aba
	//param		$conteudo = conteudo a ser exibido na aba
	public function addAba($lab, $conteudo){
	
		$this->ObAba->addAbas($lab, $conteudo);
	}

	/*
	*Metodo addBotao
	*Adiciona bot�es de ação no formulario
	*
	*/
	public function addBotao($nome,$label,$action){
	
			$this->bots[$nome] = new TButton($nome);
			$this->bots[$nome]->setAction(new TAction($action),$label);
						
	}

	
	/*método setCampos
	*Consigura os campos dentro do formulário
	*param		$campos = vetor com todos os campos do formulario
	*/
	public function setCampos($campos){
		
			$this->campos = $campos;
		$this->setFields($this->campos+$this->bots);
	}

	/*
	*
	*param		$entidade = nome da tabela na base de dados
	*/
	public function showForm(){
	
		foreach($this->bots as $botao){
			$this->ObAba->setBotao($botao);
		}
		
		$this->add($this->ObAba);
				
		$ObPage = new TPage('formulário');
		$ObPage->add($this);
		$ObPage->show();
	}

}


function __autoload($classe){

    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}

$fields = new TSetfields('contascaixa');

$fields->geraCampo('teste1','teste1','TEntry', '');
$fields->geraCampo('teste2','teste2','TEntry', '');
$fields->geraCampo('teste3','teste3','TEntry', '');
$fields->geraCampo('teste4','teste4','TEntry', '');

$fields->geraCampo('botão','bot','TButton', '');
	$fields->setProperty('bot','setAction','onView');

$form = new TSetAbas('teste');
$form->addBotao('salvar','Salvar','onSave');


$form->addAba('Teste1',$fields->getConteiner());
$form->addAba('Teste2',$fields->getConteiner());

$form->setCampos($fields->getCampos());
$form->showForm();
