<?php
/**
 *Controle de cabeçalho
 */

class TSetHeader{

    private $obsession;
    private $header;
    private $box = "headerView";
    private $complemento = "head_";

    public function __construct($seqHead = NULL){    	
        $this->obsession = new TSession();
    }

    /**
     *
     * param <type> $seqHead = Chave de acesso ao cabeçalho
     */
    public function setHeader($seqHead){
        try{
            if($seqHead){
                if(is_array($this->header)){
                    $this->obsession->setValue($this->complemento.$seqHead, $this->header, $this->box);
                }
                else{
                    throw new ErrorException("Os dados do cabeçalho não foram definidos.");
                }
            }
            else{
                throw new ErrorException("A chave do cabeçalho é inválida.");
            }

        }catch (Exception $e){
            new setException($e);
        }
    }

     /**
     *
     * param <type> $seq
     * param <type> $valor
     */
    public function add($seq, $valor){
        try{
            if($seq){
                $this->header[$seq] = $valor;
            }
            else{
                throw new ErrorException("A chave fornecida é inválida");
            }
        }catch (Exception $e){
            new setException($e);
        }
    }
    
    /**
    *
    * param <type> $chave 
    */
    public function getHead($head, $seq = NULL ){
        try{
            if($head){

                $headDados = $this->obsession->getValue($this->complemento.$head, $this->box);

                if(is_array($headDados)){
                    if($seq){
                        $retHead = $headDados[$seq];
                    }
                    else{
                        $retHead =  $headDados;
                    }
                    return $retHead;
                }
                else{
                    return false;
                }
            }
            else{
                throw new ErrorException("A chave de acesso ao cabeçalho é inválida");
            }
        }catch (Exception $e){
            new setException($e);
        }
    }

    /**
     * Adiciona um valor no cabeçalho já existente
     * param <type> $seq 
     */
    public function addHeader($head, $seq, $valor){
        try{
            
            if($seq){
                $headDados = $this->obsession->getValue($this->complemento.$head, $this->box);

                $this->clearHeader($this->complemento.$head);
                
                $headDados[$seq] = $valor;
                $this->obsession->setValue($this->complemento.$head, $headDados, $this->box);

            }
            else{
                throw new ErrorException("Os dados passados para o cabeçalho são inválidos");
            }
        }catch (Exception $e){
            new setException($e);
        }
    }

    /**
     *
     * param <formseq> $head = seq do formulário
     * return <boleano>
     */
    public function testHeader($head){
         try{       	
            if($head){
                $headDados = $this->obsession->getValue($this->complemento.$head, $this->box);

                if($headDados and $headDados != ""){
                    $test = true;
                }else{
                    $test = false;
                }
            }
            else{
                throw new ErrorException("O head passado é inválido");
            }
        }catch (Exception $e){
            new setException($e);
        }
        return $test;
    }

    /**
     * 
     */
    public function clearHeader($head = NULL){
        if($head){
        	
        	$obHead = $this->getHead($head);        	
        	
            $headfilhos = $this->getHead($head, TConstantes::HEAD_HEADCHILDS);
                                                
            if(is_array($headfilhos)){
                foreach($headfilhos as $headfilho){
                    $this->obsession->delValue($this->complemento.$headfilho[TConstantes::LISTA], $this->box);
                }
            }
            $this->obsession->delValue($this->complemento.$head, $this->box);
        }else{
            $this->obsession->delValue($this->box);
            unset($_SESSION[$this->box]);
        }
        
    }

    /**
    *
    * param <type> $formseq
    */
    public function formHeader($formseq, $nivel = null){

        try{

            if(!$formseq){
                throw new Exception("O seq do formulário não foi definido para o TSetHeader");
            }

            //Objeto DBO
            $this->dboKs = new TKrs();

                $this->dboKs->setEntidade('forms');
                    $criteriaForm = new TCriteria();
                    $criteriaForm->add(new TFilter('seq', '=', $formseq));
                $retForm = $this->dboKs->select('*', $criteriaForm);
                $Form = $retForm->fetchObject();

                //verifica a tabela relacionada
                $idEntidade = $Form->tabseq;

                //define o titulo da janela para o header
                $titulo = $Form->nomeform;

                //Informações da listagem
                $this->dboKs->setEntidade('lista');
                    $criteriaListaForm = new TCriteria();
                    $criteriaListaForm->add(new TFilter('seq', '=', $Form->listseq));
                $retListaForm = $this->dboKs->select('tipo, entidade, label, formainclude', $criteriaListaForm);
                $listaForm = $retListaForm->fetchObject();
                
                if($listaForm->tipo){
                $tipoForm = $listaForm->tipo;
                }else{
                	$tipoForm = 'form';
                }
                


                //==============================================================
                //Verifica a existencia de um cabeçalho pai
                if($Form->formseq){
                    $frmpseq = $Form->formseq;
                }

                    if($frmpseq){
                        //Retorna cabeçalho do formulario pai da lista (caso ela tenha um pai)
                        $headerFormPai = $this->getHead($frmpseq);
                        // recupera chave atual do objeto pai
                        $seqPai = $headerFormPai[TConstantes::SEQUENCIAL]; // sequencial do registro pai
                        $colunapai = $headerFormPai['colunafilho'];
                    }
               //===============================================================

            //Verifica tabela de destino do bloco
            $this->dboKs->setEntidade('tabelas');
                $criteriaTabela = new TCriteria();
                $criteriaTabela->add(new TFilter('seq','=',$idEntidade));
            $retTabela = $this->dboKs->select('*',$criteriaTabela);
            $obTabela = $retTabela->fetchObject();

            /**
            * instancia o cabeçalho do form
            * em execução e armazena em sessão
            */
            $this->add(TConstantes::FORM, $formseq);// formseq da lista
            $this->add('titulo', $titulo);//titulo do formulário
            $this->add(TConstantes::FIELD_STATUS, '');// cria atributo no cabeçalho para o status do formulário status = new - edit - view;
            $this->add('frmpseq', $frmpseq);//seq do formulário pai se ouver)
            $this->add(TConstantes::LISTA, $Form->listseq);//usado com complemento da chave de sessão do objeto lista (content+listseq)
            $this->add('formainclude', $Form->formainclude);//define a forma de de inclusão da lista
            $this->add('listseqLabel', $listaForm->lista);
            $this->add('tituloLista', $listaForm->label);
            $this->add(TConstantes::ENTIDADE, $obTabela->tabela);
            $this->add('tipo', $tipoForm);
            $this->add('listapai', $listaForm->listapai);
            $this->add('colunapai', $colunapai); //Coluna que represeta o relacionamento com o pai
            $this->add(TConstantes::SEQUENCIAL, 0); // sequencial que representao registro atual, caso já tenha sido salvo.
            $this->add('seqPai', $seqPai); // FK do relacionamento
            $this->add('colunafilho',$obTabela->colunafilho);// Coluna que será FK casa tenha filhos   
            $this->add(TConstantes::CAMPOS_FORMULARIO, '');
            $this->add('camposObrigatorios', '');
            $this->add(TConstantes::HEAD_OUTCONTROL, $Form->formoutcontrol);
            $this->add(TConstantes::FIELD_INCONTROL, $listaForm->incontrol);
            $this->add(TConstantes::HEAD_HEADCHILDS, ''); //armazena um vetor com as chaves dos filhos do mesmo
            $this->add(TConstantes::HEAD_NIVEL, $Form->nivel);


            $this->setHeader($formseq);
            /***********************************************************/
            
            return $this->getHead($formseq);

        }catch(Exception $e){
            new setException($e, 2);
        }
    }

    /**
    *
    * param <type> $listseq
    * param <type> $nivel
    * return <type>
    */
    public function listHeader($listseq, $nivel = null){
        try{

            if(!$listseq){
                throw new Exception("O seq da lista não foi definido para o cabeçalho");
            }

            //Objeto DBO
            $this->dboKs = new TKrs();

            //Informações da listagem
            $this->dboKs->setEntidade('lista');
                $criteriaListaForm = new TCriteria();
                $criteriaListaForm->add(new TFilter('seq', '=', $listseq));
            $retListaForm = $this->dboKs->select('*', $criteriaListaForm);
            $listaForm = $retListaForm->fetchObject();

                //Verifica tabela de destino do bloco
                $this->dboKs->setEntidade('tabelas');
                    $criteriaTabela = new TCriteria();
                    $criteriaTabela->add(new TFilter('seq','=',$listaForm->tabseq));
                $retTabela = $this->dboKs->select('*',$criteriaTabela);
                $obTabela = $retTabela->fetchObject();

                    if($listaForm->filtropai != '0'){
                    	
                        //Retorna cabeçalho do formulario pai da lista (caso ela tenha um pai)

                        $this->dboKs->setEntidade('forms');
                        $criteriaForms = new TCriteria();
						$criteriaForms->add(new TFilter('seq','=',$listaForm->formseq));
                        $retformseq = $this->dboKs->select('formseq',$criteriaForms);
                        $obformseq = $retformseq->fetchObject();

                        if($obformseq->formseq and $obformseq->formseq != '00'){
                            //Retorna cabe�alho do formulario pai da lista (caso ela tenha um pai)
                            $headerFormPai = $this->getHead($obformseq->formseq);

                                //armazena filhos no cabe�alho do form pai responsavel
                                $headFilhos = $headerFormPai[TConstantes::HEAD_HEADCHILDS];
                                    $headFilhos[$listseq][TConstantes::LISTA] = $listseq;
                                    $headFilhos[$listseq][TConstantes::LIST_REQUIRED] = $listaForm->required; 

                                    $this->addHeader($obformseq->formseq, TConstantes::HEAD_HEADCHILDS, $headFilhos);

                            // recupera chave atual do objeto pai
                            $seqPai = $headerFormPai[TConstantes::SEQUENCIAL];
                            $frmpseq = $obformseq->formseq;
                        }

                    }

            /**
            * instancia o cabeçalho da lista
            * em execução e armazena em sessão
            */
            $this->add(TConstantes::LISTA, $listaForm->seq);//usado como complemento da chave de sessão do objeto lista (listseq)
            $this->add(TConstantes::FORM, $listaForm->formseq);// formseq da lista
            $this->add('frmpseq', $frmpseq);//seq do formulário pai se ouver
            $this->add('tipoHead', 'lista');//define o tipo do cabeçalho
            $this->add('listseqLabel', $listaForm->lista);
            $this->add('tituloLista', $listaForm->label);
            $this->add(TConstantes::ENTIDADE, $obTabela->tabela);
            $this->add('colunafilho',$obTabela->colunafilho);
            $this->add('tipo', $tipoForm);
            $this->add('listapai', $listaForm->listapai);
            $this->add('seqPai', $seqPai);
            $this->add('listaSelecao', array());            
            $this->add('allSelecao', '0');
            $this->add('destinoseq', $listaForm->destinoseq);
            $this->add(TConstantes::FIELD_INCONTROL, $listaForm->incontrol);
            
            if($listaForm->tipo == 'form'){
        		$this->add(TConstantes::HEAD_CONTEINERRETORNO, TConstantes::CONTEINER_LISTA.$listaForm->seq); //configura conteiner de retorno das a��es
            }else if($listaForm->tipo == 'pesq'){
            	$this->add(TConstantes::HEAD_CONTEINERRETORNO, TConstantes::CONTEINER_PESQUISA.$listaForm->seq); //configura conteiner de retorno das a��es
            }
        	
        	$this->add(TConstantes::LIST_OBJECT, array());
        	$this->add(TConstantes::LIST_REQUIRED, $listaForm->required);
        	$this->add(TConstantes::LIST_COUNT, 0);
        	$this->add(TConstantes::HEAD_NIVEL, $listaForm->nivel);


            $this->setHeader($listseq);
            /***********************************************************/

            return $this->getHead($listseq);

        }catch(Exception $e){
            new setException($e, 2);
        }
    }

}