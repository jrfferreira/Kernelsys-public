<?php
/**
 *
 */

class TSetHeader{

    private $obsession;
    private $header;
    private $box = "headerView";
    private $complemento = "head_";

    public function __construct($keyHead = NULL){
        $this->obsession = new TSession();
    }

    /**
     *
     * param <type> $keyHead = Chave de acesso ao cabeçalho
     */
    public function setHeader($keyHead){
        try{
            if($keyHead){
                if(is_array($this->header)){
                    $this->obsession->setValue($this->complemento.$keyHead, $this->header, $this->box);
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
     * param <type> $key
     * param <type> $valor
     */
    public function add($key, $valor){
        try{
            if($key){
                $this->header[$key] = $valor;
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
    public function getHead($head, $key = NULL ){
        try{
            if($head){

                $headDados = $this->obsession->getValue($this->complemento.$head, $this->box);

                if(is_array($headDados)){
                    if($key){
                        $retHead = $headDados[$key];
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
     *
     * param <type> $key 
     */
    public function addHeader($head, $key, $valor){
        try{
            
            if($key){
                $headDados = $this->obsession->getValue($this->complemento.$head, $this->box);

                $this->clearHeader($this->complemento.$head);
                    $headDados[$key] = $valor;
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
     * param <idForm> $head = id do formulário
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
            $headfilhos = $this->getHead($head, 'headfilhos');
            if(is_array($headfilhos)){
                foreach($headfilhos as $headfilho){
                    $this->obsession->delValue($this->complemento.$headfilho, $this->box);
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
    * param <type> $idForm
    */
    public function onHeader($idForm, $nivel = null){

        try{

            if(!$idForm){
                throw new Exception("O id do formulário não foi definido para o TSetHeader");
            }

            //Objeto DBO
            $this->dboKs = new TDbo_kernelsys();

                $this->dboKs->setEntidade('forms');
                    $criteriaForm = new TCriteria();
                    $criteriaForm->add(new TFilter('id', '=', $idForm));
                $retForm = $this->dboKs->select('*', $criteriaForm);
                $Form = $retForm->fetchObject();

                //verifica a tabela relacionada
                $idEntidade = $Form->entidade;

                //define o titulo da janela para o header
                $titulo = $Form->nomeform;

                //Informações da listagem
                $this->dboKs->setEntidade('lista_form');
                    $criteriaListaForm = new TCriteria();
                    $criteriaListaForm->add(new TFilter('id', '=', $Form->idlista));
                $retListaForm = $this->dboKs->select('tipo, entidade, label, formainclude', $criteriaListaForm);
                $listaForm = $retListaForm->fetchObject();
                $tipoForm = $listaForm->tipo;


                //==============================================================
                //Verifica a existencia de um cabeçalho pai
                if($Form->formpai){
                    $idFormPai = $Form->formpai;
                }

                    if($idFormPai){
                        //Retorna cabeçalho do formulario pai da lista (caso ela tenha um pai)
                        $headerFormPai = $this->getHead($idFormPai);
                        // recupera chave atual do objeto pai
                        $codigoPai = $headerFormPai['codigo'];
                        $destinoCodigo = $headerFormPai['colunafilho'];
                    }
               //===============================================================

            //Verifica tabela de destino do bloco
            $this->dboKs->setEntidade('tabelas');
                $criteriaTabela = new TCriteria();
                $criteriaTabela->add(new TFilter('id','=',$idEntidade));
            $retTabela = $this->dboKs->select('*',$criteriaTabela);
            $obTabela = $retTabela->fetchObject();

            /**
            * instancia o cabeçalho da lista
            * em execução e armazena em sessão
            */
            $this->add('idForm', $idForm);// idForm da lista
            $this->add('titulo', $titulo);//titulo do formulário
            $this->add('status', '');// cria atributo no cabeçalho para o status do formulário status = new - edit - view;
            $this->add('idFormPai', $idFormPai);//id do formulário pai se ouver
            $this->add('idLista', $Form->idlista);//usado com complemento da chave de sessão do objeto lista (content+idLista)
            $this->add('formainclude', $Form->formainclude);//define a forma de de incluisão da lista
            $this->add('idListaLabel', $listaForm->lista);
            $this->add('tituloLista', $listaForm->label);
            $this->add('entidade', $obTabela->tabela);
            $this->add('colunafilho',$obTabela->colunafilho);
            $this->add('tipo', $tipoForm);
            $this->add('listapai', $listaForm->listapai);
            $this->add('destinocodigo', $destinoCodigo);
            $this->add('codigoPai', $codigoPai);
            $this->add('camposSession', '');
            $this->add('camposObrigatorios', '');
            $this->add('formOutControl', $Form->formoutcontrol);
            $this->add('incontrol', $listaForm->incontrol);
            $this->add('headfilhos', ''); //armazena um vetor com as chaves dos filhos do mesmo


            $this->setHeader($idForm);
            /***********************************************************/
            
            return $this->getHead($idForm);

        }catch(Exception $e){
            new setException($e, 2);
        }
    }

    /**
    *
    * param <type> $idLista
    * param <type> $nivel
    * return <type>
    */
    public function onHeaderLista($idLista, $nivel = null){
        try{

            if(!$idLista){
                throw new Exception("O id da lista não foi definido para o TSetHeader");
            }

            //Objeto DBO
            $this->dboKs = new TDbo_kernelsys();

            //Informações da listagem
            $this->dboKs->setEntidade('lista_form');
                $criteriaListaForm = new TCriteria();
                $criteriaListaForm->add(new TFilter('id', '=', $idLista));
            $retListaForm = $this->dboKs->select('*', $criteriaListaForm);
            $listaForm = $retListaForm->fetchObject();

                //Verifica tabela de destino do bloco
                $this->dboKs->setEntidade('tabelas');
                    $criteriaTabela = new TCriteria();
                    $criteriaTabela->add(new TFilter('id','=',$listaForm->entidade));
                $retTabela = $this->dboKs->select('*',$criteriaTabela);
                $obTabela = $retTabela->fetchObject();

                    if($listaForm->filtropai != '0'){
                        //Retorna cabeçalho do formulario pai da lista (caso ela tenha um pai)

                        $this->dboKs->setEntidade('forms');
                            $criteriaForms = new TCriteria();
                            $criteriaForms->add(new TFilter('id','=',$listaForm->forms_id));
                        $retFormPai = $this->dboKs->select('formpai',$criteriaForms);
                        $obFormPai = $retFormPai->fetchObject();

                        if($obFormPai->formpai and $obFormPai->formpai != '00'){
                            //Retorna cabeçalho do formulario pai da lista (caso ela tenha um pai)
                            $headerFormPai = $this->getHead($obFormPai->formpai);

                                //armazena filhos no cabeçalho do forme pai responsavel
                                $headFilhos = $headerFormPai['headfilhos'];
                                    $headFilhos[$idLista] = $idLista;
                                    $this->addHeader($obFormPai->formpai, 'headfilhos', $headFilhos);

                            // recupera chave atual do objeto pai
                            $codigoPai = $headerFormPai['codigo'];
                            $idFormPai = $obFormPai->formpai;
                        }

                    }

            /**
            * instancia o cabeçalho da lista
            * em execução e armazena em sessão
            */
            $this->add('idLista', $listaForm->id);//usado com complemento da chave de sessão do objeto lista (idLista)
            $this->add('idForm', $listaForm->forms_id);// idForm da lista
            $this->add('idFormPai', $idFormPai);//id do formulário pai se ouver
            $this->add('tipoHead', 'lista');//define a do cabeçalho
            $this->add('idListaLabel', $listaForm->lista);
            $this->add('tituloLista', $listaForm->label);
            $this->add('entidade', $obTabela->tabela);
            $this->add('colunafilho',$obTabela->colunafilho);
            $this->add('tipo', $tipoForm);
            $this->add('listapai', $listaForm->listapai);
            $this->add('codigoPai', $codigoPai);
            $this->add('listaSelecao', array());
            $this->add('allSelecao', '0');
            $this->add('destinocodigo', $listaForm->destinocodigo);
            $this->add('incontrol', $listaForm->incontrol);

            $this->setHeader($idLista);
            /***********************************************************/

            return $this->getHead($idLista);

        }catch(Exception $e){
            new setException($e, 2);
        }
    }

}
?>
