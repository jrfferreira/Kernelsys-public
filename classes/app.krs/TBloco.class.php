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
	public $formseq;
	public $blocseq;
	public $idPai;
	public $seq;
	
	/*método construtor
	*instancia o objeto forms
	*param		id = identificador do objeto na base de dados
	*/
	public function __construct($formseq, $blocseq, $seq, $auto = NULL){
	
		//inicia objeto sesseion
		$this->obsession = new TSession();

                $this->formseq   = $formseq;
                $this->seq  	= $seq;
				$this->blocseq  = $blocseq;
				$this->idPai    = $idPai;
                    
                    $criterio = new TCriteria();
                    $criterio->add(new TFilter('seq', '=', $this->blocseq));
                    $criterio->add(new TFilter('statseq', '=', '1'));
                    
                    $tKrs = new TKrs('blocos');
                    $RetObBloco = $tKrs->select('*',$criterio);
                    
                    $this->ObjBloco = $RetObBloco->fetchObject();
                    
                    $this->formato = $this->ObjBloco->formato;

                    if($auto != NULL){
                        if($auto === 'frm'){
                            $this->formato = 'frm';
                        }
                        $this->setBloco();
                    }
	}

    /**
    *
    */
	public function setBloco(){

            if($this->formato == 'frm'){

                    //Instacia objeto [apendice] das abas caso aja.
                    if($this->ObjBloco->obapendice and $this->ObjBloco->obapendice != "-" ){

                        $obApendice = new TApendices();
                        $obElement = $obApendice->main($this->ObjBloco->obapendice, $this->formseq);

                        $addObj = $obElement;
                    }else{

                        $paneObj = new TCompForm($this->formseq, $this->blocseq, $this->formato, $this->seq);
                        $addObj = $paneObj->setFields();
                        $this->campos = $paneObj->getCamp();
                    }

            }
            elseif($this->formato == 'lst'){
                //Verifica tabela de destino do bloco
                $dboTab = new TKrs('tabelas');
                $criteriaFormTab = new TCriteria();
                $criteriaFormTab->add(new TFilter('seq','=',$this->ObjBloco->tabseq));                
                $retTab = $dboTab->select('*', $criteriaFormTab);
                $obTabela = $retTab->fetchObject();

                    //retorna dados do formulario
                    $dboForm = new TKrs('forms');
                        $criteriaForm = new TCriteria();
                        $criteriaForm->add(new TFilter('seq','=',$this->ObjBloco->formseq));
                    $retForm = $dboForm->select('*', $criteriaForm);
                    $obForm = $retForm->fetchObject();

                    //retorna a lista
                    $dboLista = new TKrs('lista');
                        $criteriaLista = new TCriteria();
                        $criteriaLista->add(new TFilter('seq','=',$obForm->listseq));
                    $retLista = $dboLista->select('seq', $criteriaLista);
                    $obLista = $retLista->fetchObject();

                //gera id do conteiner da lista
                $paneRet = TConstantes::CONTEINER_LISTA.$obLista->seq;

                $listObj = new TCompLista($obLista->seq);
                $lista = $listObj->get();

                $listDados = $listObj->getListDados();

                    // permanece objeto lista em sessão \\
                    $listaBox = "listaBox";
                    $this->obsession->setValue('obListaBox_'.$obLista->seq, $lista, $listaBox);

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
	
	public function getBlocoSeq(){
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
				$obsession = new TSession();
				$developer = $obsession->getValue('developer');

                //Cria elemento fieldset
                $Bloco = new TElement('fieldset');
                $Bloco->id = 'bloc_'.$this->ObjBloco->blocoid;
                $Bloco->class = $this->visibilidade." ui_bloco_fieldset ui-corner-all ui-widget-content";
                    $legBloco = new TElement('legend');
                    $legBloco->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                    $legBloco->add(($developer ? $this->ObjBloco->seq.' - ' : '').$this->ObjBloco->nomebloco);
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