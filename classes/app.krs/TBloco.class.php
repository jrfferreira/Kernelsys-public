<?php
/*
* Monta a estrutura de um bloco
* Data: 02/04/2008
* Data de altualização: --/--/----
* Programador: Wagner Borba
*/

class TBloco{

	private $objetos;
	public $formato;
	
	/*método construtor
	*instancia o objeto forms
	*param		id = identificador do objeto na base de dados
	*/
	public function __construct($idForm, $id, $codigo, $auto = NULL){
	
		//inicia objeto sesseion
		$this->obsession = new TSession();

                $this->idForm   = $idForm;
                $this->codigo   = $codigo;
		$this->idBloco  = $id;
		$this->idPai    = $idPai;
	
                //inicia uma transação com a camada de dados do form
                TTransaction::open('../'.TOccupant::getPath().'app.config/krs');
                //difine o arquivo de log do acesso aos formularios
                TTransaction::setLogger(new TLoggerTXT("../".TOccupant::getPath()."app.tmp/logAcForm.txt"));

                if($this->conn = TTransaction::get()){//testa a conex�o com o banco de dados

                    $sqlObBloco = "SELECT * FROM blocos WHERE id='".$this->idBloco."' and ativo='1'";
                    $RetObBloco = $this->conn->Query($sqlObBloco);
                    $this->ObjBloco = $RetObBloco->fetchObject();

                    $this->formato = $this->ObjBloco->formato;

                    if($auto != NULL){
                        if($auto === 'frm'){
                            $this->formato = 'frm';
                        }
                        $this->setBloco();
                    }

                }//termina teste de tranzação
			
		//termina a transass�o
		TTransaction::close();
	}

        /**
        *
        */
	public function setBloco(){

            if($this->formato == 'frm'){

                    //Instacia objeto [apendice] das abas caso aja.
                    if($this->ObjBloco->obapendice and $this->ObjBloco->obapendice != "-" ){

                        $obApendice = new TApendices();
                        $obElement = $obApendice->main($this->ObjBloco->obapendice, $this->idForm);

                        $addObj = $obElement;
                    }else{

                        $paneObj = new TCompForm($this->idForm, $this->idBloco, $this->formato, $this->codigo);
                        $addObj = $paneObj->setFields();
                        $this->campos = $paneObj->getCamp();
                    }

            }
            elseif($this->formato == 'lst'){

                //Verifica tabela de destino do bloco
                $sqlTabela = "SELECT * FROM tabelas WHERE id='".$this->ObjBloco->entidade."' order by id";
                $retTab = $this->conn->Query($sqlTabela);
                $obTabela = $retTab->fetchObject();

                    //retorna dados do formulario
                    $dboForm = new TDbo_kernelsys('forms');
                        $criteriaForm = new TCriteria();
                        $criteriaForm->add(new TFilter('id','=',$this->ObjBloco->idform));
                    $retForm = $dboForm->select('*', $criteriaForm);
                    $obForm = $retForm->fetchObject();

                    //retorna a lista
                    $dboLista = new TDbo_kernelsys('lista_form');
                        $criteriaLista = new TCriteria();
                        $criteriaLista->add(new TFilter('id','=',$obForm->idlista));
                    $retLista = $dboLista->select('id', $criteriaLista);
                    $obLista = $retLista->fetchObject();

                //gera id do conteiner da lista
                $paneRet = 'contLista'.$obLista->id;

                $listObj = new TCompLista($obLista->id, $paneRet);
                $lista = $listObj->get();

                $listDados = $listObj->getListDados();

                    // permanece objeto lista em sessão \\
                    $listaBox = "listaBox";
                    $this->obsession->setValue('obListaBox_'.$obLista->id, $lista, $listaBox);

                //cria conteiner para a lista
                $panelLista = new TElement('div');
                $panelLista->id = $paneRet;
                $panelLista->style = 'overflow:auto; width:100%; height:'.$this->ObjBloco->blocoheight.';';
                $panelLista->add($lista->getLista());

                $addObj = $panelLista;
            }
					
            $this->add($addObj);
	}
		
	/*
	* Instancia vetor de dados do bloco
	*/
	public function add($obj){
	
            if(is_array($obj)){
                foreach($obj as $vl){
                    $this->objetos[] = $vl;
                }
            }
            else{
                $this->objetos[] = $obj;
            }
	}
	
	public function getIdbloco(){
		return $this->ObjBloco->blocoid;
	}
	
	public function getNomebloco(){
		return $this->ObjBloco->nomebloco;
	}

        /**
         * Configura a visibilidade do bloco
         * param <type> $visibilidade
         */
        public function setVisibilidade($visibilidade){
            if($visibilidade){
                $this->visibilidade = "displayTrue";
            }
            else{
                $this->visibilidade = "displayFalse";
            }
        }
	
	/* método getForm
	*  Retorna o formulario montado com suas respequitivas abas
	*/
	public function getBloco(){

                //Cria elemento fieldset
                $Bloco = new TElement('fieldset');
                $Bloco->id = 'bloc_'.$this->ObjBloco->blocoid;
                $Bloco->class = $this->visibilidade." ui_bloco_fieldset ui-corner-all ui-widget-content";
                    $legBloco = new TElement('legend');
                    $legBloco->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                    $legBloco->add($this->ObjBloco->nomebloco);
                $Bloco->add($legBloco);

                $content = new TElement('div');
                $content->class = "ui_bloco_conteudo";

                foreach($this->objetos as $cont){
                        $content->add($cont);
                }
                $Bloco->add($content);
                return $Bloco;
	}
	
	public function getCamp(){
		return $this->campos;
	}
}
?>