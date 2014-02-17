<?php
/**
 * Classe que representa o objeto(lista) de um conjunto de dados
 * Versão: v002
 * Data: 22/10/2008
 * Data de altualização: 13/11/2012
 * Programador: Wagner Borba
 * ************************************************************************** */

class TCompLista {

    private $obLista; //objeto lista
    private $conteinerRetorno;
    public $panel;
    private $dboKs;
      
    /**
     * Acessa o Db de registro com as informções para as listas serem geradas
     * @param unknown_type $listseq = ID da lista no registro
     * @param unknown_type $paneRet = Local de retorno da lista
     */
    public function __construct($listseq) {
    	
        // Retorna Usuario logado===================================
        $this->obUser = new TCheckLogin();
        $this->obUser = $this->obUser->getUser();
        //=========================================================
        
        $this->listseq = $listseq;

        //Instancia manipulador de sessão
        $this->obsession = new TSession();
        $this->editable = $this->obsession->getValue(TConstantes::STATUS_VIEWFORM);
        
        //Abre conexão com o BD de Registro Kernelsys
        $this->dboKs = new TKrs();
        
        	//Retorna todos os parametros necessários da lista em questão
            if ($this->listseq != "") {

            	//Retorna parametros da lista
                $tKrs = new TKrs('lista');
                	$crit = new TCriteria();
                	$crit->add(new TFilter('seq','=',$this->listseq));
                	$crit->add(new TFilter('statseq','=','1'));
                	$crit->setProperty('order', 'seq');
                $retLista = $tKrs->select('*',$crit);
                $this->listaInfo = $retLista->fetchObject();

                $this->formseq = $this->listaInfo->formseq;
                
                //Retorna parametros das tabelas da lista
                $tKrs = new TKrs('tabelas');
                	$crit = new TCriteria();
                	$crit->add(new TFilter('seq','=',$this->listaInfo->tabseq));
                	$crit->setProperty('order', 'seq');
                $retTab = $tKrs->select('*',$crit);
                $this->obTabela = $retTab->fetchObject();

                $setEntidade = $this->obTabela->tabela_view;

                //retorna ações a serem incluidas na barra de navegação da lista
                $dboBarraAction = new TKrs('lista_bnav');
	                $criterioBarraAction = new TCriteria();
	                $criterioBarraAction->add(new TFilter('listseq', '=', $this->listseq));
                $retBarraAction = $dboBarraAction->select('*', $criterioBarraAction);
                while ($obBarraAction = $retBarraAction->fetchObject()) {
                    $this->actionsBarraNav[$obBarraAction->seq] = $obBarraAction;
                }                     
                
                //Retorna parametros das ações da lista
                $tKrs = new TKrs('lista_actions');
                	$crit = new TCriteria();
                	$crit->add(new TFilter(TConstantes::LISTA,'=',$this->listaInfo->seq));
                	$crit->add(new TFilter('statseq','=','1'));
                	$crit->setProperty('order', 'ordem');
                $retAction = $tKrs->select('*',$crit);
                
                while ($obAct = $retAction->fetchObject()) {
                    $obAct->title = $obAct->label;
                    $obAct->alt = $obAct->label;
                    $obAct->label = '-';
                    $this->obAction[$obAct->seq] = $obAct;
                }
                
                //Retorna os campos para aplicar na lista
                $this->getListaCampo($this->conn, $this->listaInfo->seq);

                //Retorna parametros das colunas da lista
                $tKrs = new TKrs('coluna');
                	$crit = new TCriteria();
                	$crit->add(new TFilter('listseq','=',$this->listaInfo->seq));
                	$crit->add(new TFilter('statseq','=','1'));
                	$crit->setProperty('order', 'ordem');
                $retCols = $tKrs->select('*',$crit);
                                
                //percorre colunas da listagem \\
                while($colsInfo = $retCols->fetchObject()) {

                    $colsInfo->coluna = strtolower($colsInfo->coluna);
                    $this->colunas[$colsInfo->coluna] = $colsInfo;
                }//temina loop
                $this->campoChave = TConstantes::SEQUENCIAL;
               
            }
            ///////////////////////////////////////////////////////////////////
            
            /**
             * instancia o cabeçalho da lista
             * em execução e armazena em sessão
             */
            $objHeader = new TSetHeader();
            $testeHeader = $objHeader->testHeader($this->listaInfo->seq);            
            if ($testeHeader) {
                $this->obHeader = $objHeader->getHead($this->listaInfo->seq);
            } else {
                $this->obHeader = $objHeader->listHeader($this->listaInfo->seq);
            }

            if ($this->obHeader[TConstantes::HEAD_SEQUENCIALPAI]) {
                $this->seqPai = $this->obHeader[TConstantes::HEAD_SEQUENCIALPAI];
            }
            
            // mantem objeto conteiner de retorno das açães da lista
        	$this->conteinerRetorno = $this->obHeader[TConstantes::HEAD_CONTEINERRETORNO];           
            /***********************************************************/

        //////////////////////////////////////////////////////////////////////////////////
        //inicia construtor da lista
        $this->obLista = new TSetlista($this->listseq, $setEntidade, $this->listaInfo->label, $this->conteinerRetorno);
        $this->obLista->setCampoChave($this->campoChave);

        //Configura ordenação na Lista
        if($this->listaInfo->ordem){
            $ordem = $this->listaInfo->ordem;
            $ordem = preg_replace('/\//i',' ', $ordem);
            $ordem = preg_replace('/\;/i',',', $ordem);
            $ordem = preg_replace('/(\;|\,)$/i','', $ordem);

            $this->obLista->setOrdem($ordem);
         }
         
        //Configura trigger na lista
        if ($this->listaInfo->trigger) {
            $this->obLista->setTrigger($this->listaInfo->trigger);
        }

        /////////////////////////////////////////////////////////////////////////////////
        // se a lista for do tipo [bloco] se aplica o criterio de retorno por seq
        //if ($this->listaInfo->filtropai != '0' and $this->seqPai) {
            //$this->obLista->addCriterio($this->listaInfo->filtropai, $this->seqPai, "=", 'AND',3);
        //}
        
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        // Configura filtro padrão na lista de dados
        if ($this->listaInfo->filtro != "") {

            $getFiltPd = explode(';', $this->listaInfo->filtro);

            foreach ($getFiltPd as $pdFiltro) {
                // pos 0 = coluna table | pos 1 = operador logico(=,ILIKE,>, etc) | pos 2 = operador condicional(OR - AND)
                // | pos 3 = classe ou valor fixo | pos 4 = metodo se o pos 3 for uma classe
                $vetorFiltro = explode('/', $pdFiltro);

                if (method_exists($vetorFiltro[3], $vetorFiltro[4])) {
                    $objetoDinamicofiltro = new $vetorFiltro[3];
                    //verifica se vai ser passando argumento
                    if($vetorFiltro[6]){
                        $dadosFiltro = call_user_func(array($objetoDinamicofiltro, $vetorFiltro[4]), $this->listseq);
                    	$tipodado = $vetorFiltro[6] ? $vetorFiltro[6] : 'numeric';
                    }else{
                        $dadosFiltro = call_user_func(array($objetoDinamicofiltro, $vetorFiltro[4]));
                    	$tipodado = $vetorFiltro[5] ? $vetorFiltro[5] : 'numeric';
                    }
                } else {
                    $dadosFiltro = $vetorFiltro[3];
                    $tipodado = $vetorFiltro[4] ? $vetorFiltro[4] : 'numeric';
                }
                // matem filtro em sessão
                // $filtro = array("expre" =>  $dadosFiltro, "cols" => $vetorFiltro[0], "Manterfilt" => true );
                // $this->obsession->setValue("dadosFiltroListaAtual",$filtro);

                $this->obLista->addCriterio($vetorFiltro[0], $dadosFiltro, $vetorFiltro[1], $vetorFiltro[2], $tipodado, 'filtroLista');
            }
            $vetorFiltro = NULL;
        }
        
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        //verifica e compila objeto APÊNDICE
        if ($this->listaInfo->obapendice and $this->listaInfo->obapendice != "-" and $this->listaInfo->obapendice != "" and $this->listaInfo->obapendice != "0") {

            if ($this->obHeader['frmpseq']) {
                $chaveApendice = $this->obHeader['frmpseq'];
            } else {
                $chaveApendice = $this->formseq;
            }

            //testa a existencia do cabeçalho
            $testHeader = new TSetHeader();
            if($testHeader->testHeader($chaveApendice) === false){
                $testHeader->formHeader($chaveApendice);
            }


            if (!$chaveApendice) {
                $chaveApendice = NULL;
            }
            $this->obLista->addApendice($this->listaInfo->obapendice, $chaveApendice);
        }
        
    }
    
    /**
    * Retorna Os campos a serem inseridos na listagem.
    */
    private function getListaCampo($conn, $listseq){
                  
      $tKrs = new TKrs('lista_fields');
      $crit = new TCriteria();
      $crit->add(new TFilter(TConstantes::LISTA,'=',$listseq));
      $crit->add(new TFilter('statseq','=','1'));
      $crit->setProperty('order', 'ordem');
      $retAcao = $tKrs->select('*',$crit);
      
      
        while ($obAct = $retAcao->fetchObject()) {
          $obAct->title = $obAct->label;
          $obAct->alt = $obAct->label;
          $obAct->label = '-';
          $this->obAction[$obAct->seq] = $obAct;
        }
            
    }

    /**
     * Retona dados o autor diretamente do
     * objeto lista (sem sessão)
     */
    public function getListDados() {
        $this->obHeader = new TSetHeader();
        return $this->obHeader->getHead($this->formseq);
    }

    /*
     * configura visualizaçao de acoes sobrepondo
     * a definida no registro do sistema
     * acoes -> [incluir, filtrar, exluir, editar, viazualizar, enviar, replicar, seleção]
     */
    public function setViewAction($ac1, $ac2, $ac3, $ac4, $ac5, $ac6, $ac7, $ac8) {

        $this->listaInfo->acincluir = $ac1;
        $this->listaInfo->acfiltrar = $ac2;
        $this->listaInfo->acdeletar = $ac3;
        $this->listaInfo->aceditar = $ac4;
        $this->listaInfo->acviews = $ac5;
        $this->listaInfo->acenviar = $ac6;
        $this->listaInfo->acreplicar = $ac7;
        $this->listaInfo->acselecao = $ac8;
    }

    /* método de configuração da lista de dados
     * monta um lista de dados de acordo com os dados do formulario em questão,
     * representado no modelo de dados pelo (id) do form
     */
    private function setLista() {

        //loop de atribuição das colunas da lista de dados
        foreach ($this->colunas as $seq => $cols) {

            if($cols->alinhalabel) {
                $cols->alinhalabel = 'left';
            }
            $this->obLista->addTop($cols);
        }

        //habilita riltro
        if ($this->listaInfo->acfiltro == 1) {
            $this->obLista->onFiltro();
        }
        
    	if ($this->listaInfo->aclimite == 1) {
            $this->obLista->onLimite();
        }

        //==================================================================\\
        //Acessa e checa os PRIVILEGIOS de acesso as funcionalidades da lista
        $nivel = 2; //nivel das opções da lista [1 = adicionar / 2 = editar / 3 = deletar]
        $obPrivilegios = new TGetPrivilegio($this->formseq, $nivel);
        $privilegios = $obPrivilegios->get();

        $privilegioIncluir = array_search('1', $privilegios);
        if (!$privilegioIncluir) {
            $this->listaInfo->acincluir = 0;
        }
        $privilegioEditar = array_search('2', $privilegios);
        if (!$privilegioEditar) {
            $this->listaInfo->aceditar = 0;
        }
        $privilegioDeletar = array_search('3', $privilegios);
        if (!$privilegioDeletar) {
            $this->listaInfo->acdeletar = 0;
        }

        $privilegioReplicar = array_search('4', $privilegios);
        if (!$privilegioReplicar) {
            $this->listaInfo->acreplicar = 0;
        }

        $privilegioSelecionar = array_search('5', $privilegios);
        if (!$privilegioSelecionar) {
            $this->listaInfo->acselecao = 0;
        }
        //==================================================================\\
        //adiciona Elementos na barra de navegação das listas
        if (count($this->actionsBarraNav) > 0) {

            foreach ($this->actionsBarraNav as $idBarraNav => $obBarraNav) {

                $ActionBarraNav = new TSetAction($obBarraNav->funcaojs);
                $ActionBarraNav->setMetodo($obBarraNav->metodo);
                $ActionBarraNav->setTipoRetorno("form");
                $ActionBarraNav->setIdForm($obBarraNav->argumento);
                $ActionBarraNav->setAlvo($this->conteinerRetorno);

                $botBarraNav = new TButton($obBarraNav->nome);
                $botBarraNav->setAction($ActionBarraNav->getAction(), $obBarraNav->label);

                $this->obLista->addBot($botBarraNav);
            }
        }

        //Adicina botões na barra de navegação
        if($this->listaInfo->acselecao != "0" and $this->editable != "form") {

            $botmarcarTodos = new TCheckButton('addAll');
            $botmarcarTodos->onclick = 'addAllReg(this)'; //onSelecao(this, '.$this->listseq.', \'all\')';
            $botmarcarTodos->id = 'addAllReg';

            $this->act['acSelecao'] = new TAction('onSelecao');
            $this->act['acSelecao']->setParameter('ob', 'this');
            $this->act['acSelecao']->setParameter(TConstantes::LISTA, $this->listseq);
            $this->act['acSelecao']->nome = "acselecao";
            $this->act['acSelecao']->field = $this->campoChave;
            $this->act['acSelecao']->label = $botmarcarTodos;
            $this->act['acSelecao']->title = 'Selecionar';
            $this->act['acSelecao']->value = "1";
            $this->act['acSelecao']->tipoCampo = "TCheckButton";

            $this->obLista->addAction($this->act['acSelecao']);
            
        }

        if ($this->listaInfo->acincluir != "0") {

            $ActionNew = new TSetAction('prossExe');
            $ActionNew->setMetodo('onNew');
            $ActionNew->setTipoRetorno("form");
            $ActionNew->setIdForm($this->formseq);
            $ActionNew->setAlvo($this->conteinerRetorno);

            $this->bt['incluir'] = new TIcon("ui-icon-plusthick", "icons_incluirLista");
            $this->bt['incluir']->setAction($ActionNew);
            $this->bt['incluir']->setTitle($this->listaInfo->acincluir);

            $this->obLista->addBot($this->bt['incluir']);
        }

        if ($this->listaInfo->acdeletar == 1) {

            $this->act['del'] = new TSetAction('prossExe');
            $this->act['del']->setMetodo('onDelete');
            $this->act['del']->setTipoRetorno('lista');
            $this->act['del']->setConfirme('Você deseja realmente excluir o registro?');
            $this->act['del']->setIdForm($this->listseq);
            $this->act['del']->setAlvo($this->conteinerRetorno);
            $this->act['del']->nome = "acdelete";
            $this->act['del']->field = $this->campoChave;
            $this->act['del']->label = '-';
            $this->act['del']->title = 'Deletar';
            $this->act['del']->img = 'new_ico_delete.png';

            $this->obLista->addAction($this->act['del']->getAction());
        }

        if ($this->listaInfo->aceditar == 1) {
        
            $this->act['edit'] = new TSetAction('prossExe');
            $this->act['edit']->setMetodo('onEdit');
            $this->act['edit']->setTipoRetorno('form');
            $this->act['edit']->setIdForm($this->formseq);
            $this->act['edit']->setAlvo($this->conteinerRetorno);
            $this->act['edit']->nome = "acedit";
            $this->act['edit']->field = $this->campoChave;
            $this->act['edit']->label = '-';
            $this->act['edit']->title = 'Editar';
            $this->act['edit']->img = 'new_ico_edit.png';
            

            $this->obLista->addAction($this->act['edit']->getAction());
        }

        if ($this->listaInfo->acreplicar == 1) {

            $this->act['reply'] = new TSetAction('prossExe');
            $this->act['reply']->setMetodo('onReply');
            $this->act['reply']->setTipoRetorno('form');
            $this->act['reply']->setIdForm($this->formseq);
            $this->act['reply']->setAlvo($this->conteinerRetorno);
            $this->act['reply']->nome = "acreply";
            $this->act['reply']->field = $this->campoChave;
            $this->act['reply']->label = '-';
            $this->act['reply']->title = 'Replicar';
            $this->act['reply']->img = 'new_ico_clone.png';

            $this->obLista->addAction($this->act['reply']->getAction());
        }

        //TODO: Eliminar a coluna acviews no edu_krs
        /* if ($this->listaInfo->acviews == 1) {

            $this->act['view'] = new TSetAction('prossExe');
            $this->act['view']->setMetodo('onView');
            $this->act['view']->setTipoRetorno('form');
            $this->act['view']->setIdForm($this->formseq);
            $this->act['view']->setAlvo($this->conteinerRetorno);
            $this->act['view']->nome = "acviews";
            $this->act['view']->field = $this->campoChave;
            $this->act['view']->label = '-';
            $this->act['view']->title = 'Visualizar';
            $this->act['view']->img = 'new_ico_view.png';

            $this->obLista->addAction($this->act['view']->getAction());
        } */

        if ($this->listaInfo->acenviar != 0) {

            $this->act['enviar'] = new TAction('setDadosPesquisa');
            $this->act['enviar']->setParameter(TConstantes::LISTA, $this->listseq);
            $this->act['enviar']->setParameter('tipoRetorno', 'form');
       //     $this->act['enviar']->setAlvo($this->conteinerRetorno);
            $this->act['enviar']->nome = "acenviar";
            $this->act['enviar']->field = $this->campoChave;
            $this->act['enviar']->label = '-';
            $this->act['enviar']->title = 'Enviar';
            $this->act['enviar']->img = 'new_ico_enviar.png';

            $this->obLista->addAction($this->act['enviar'], $this->listaInfo->pesquisa);
        }

        //adiciona ações na lista
        if (count($this->obAction) > 0) {
            foreach ($this->obAction as $seqAct => $actInfo) {

            	$metodoExe = explode(';', $actInfo->metodoexe);

                if ($actInfo->actionjs == "prossExe") {
                    $inAct = new TSetAction($actInfo->actionjs);
                    $inAct->setMetodo($metodoExe[0]);
                    	if($metodoExe[1]){
                    		$inAct->metodoarg = $metodoExe[1];
                    	}
                    $inAct->setTipoRetorno($actInfo->tiporetorno);
                    $inAct->setIdForm($this->formseq);
                    $inAct->setConfirme($actInfo->confirm);
                    $inAct->setAlvo($this->conteinerRetorno);
                    $inAct->nome = $actInfo->nome;
                    $inAct->field = $actInfo->campoparam;
                    $inAct->label = $actInfo->label;
                    $inAct->img = $actInfo->img;
                    $inAct = $inAct->getAction();
                } else {

                    $inAct = new TAction($actInfo->actionjs);

                    if ($actInfo->tipocampo) {
                        $inAct->setParameter('this', "this");
                    }
                    if ($metodoExe[0]) {
                        $inAct->setParameter('metodo', $metodoExe[0]);
                        if($metodoExe[1]){
                        	$inAct->setParameter('metodoarg',$metodoExe[1]);
                        }
                        
                    }
                    if ($actInfo->tiporetorno) {
                        $inAct->setParameter('tiporetorno', $actInfo->tiporetorno);
                    }
                    if ($actInfo->confirm) {
                        $inAct->setParameter('confirme', $actInfo->confirm);
                    }

                    $inAct->nameAction = $actInfo->nameAction;
                    $inAct->field = $actInfo->campoparam;
                    $inAct->label = $actInfo->label;
                    $inAct->img = $actInfo->img;
                }

                $this->obLista->addAction($inAct);
                $inAct = NULL;
            }
        }
    }

    /*
    *
    */
    public function get() {
    	
        $this->setLista();

        // Subustitui objeto lista da sessão pelo novo objeto lista \\
        $idBoxAtual = 'obListaBox_' . $this->listseq;
        $listaBox = "listaBox";
        $this->obsession->setValue($idBoxAtual, $this->obLista, $listaBox);

        $this->dboKs->close();

        return $this->obLista;
    }

}