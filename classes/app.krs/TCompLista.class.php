<?php
/**
 * Classe que representa o objeto(lista) de um conjunto de dados
 * Versão: v002
 * Data: 22/10/2008
 * Data de altualização: --/--/----
 * Programador: Wagner Borba
 * ************************************************************************** */

class TCompLista {

    private $obLista;
 	//objeto lista
    private $pane;
    public $panel;
    private $dboKs;

    /**
     * Acessa o Db de registro com as informções para as listas serem geradas
     * @param unknown_type $idLista = ID da lista no registro
     * @param unknown_type $paneRet = Local de retorno da lista
     */
    public function __construct($idLista, $paneRet) {

        // Retorna Usuario logado===================================
        $this->obUser = new TCheckLogin();
        $this->obUser = $this->obUser->getUser();
        //=========================================================
        
        //Abre conexão com o BD de Registro Kernelsys
        $this->dboKs = new TDbo_kernelsys();

        $this->idLista = $idLista;

        //Instancia manipulador de sessão
        $this->obsession = new TSession();
        $this->editable = $this->obsession->getValue('statusViewForm');

        //inicia uma transação com a camada de dados
        TTransaction::open('../'.TOccupant::getPath().'app.config/krs');        
        $this->conn = TTransaction::get();             
        
        if ($this->conn) {//testa a conexão com o banco de dados
            if ($this->idLista != "") {

                //Informações da listagem
                $sqlLista = "SELECT * FROM lista_form WHERE id='" . $this->idLista . "' and ativo='1'";
                $RetLista = $this->conn->query($sqlLista);
                $this->listaInfo = $RetLista->fetchObject();

                $this->idForm = $this->listaInfo->forms_id;

                //Verifica tabela de destino do bloco
                $sqlTabela = "SELECT * FROM tabelas WHERE id='" . $this->listaInfo->entidade . "' order by id";
                $retTab = $this->conn->query($sqlTabela);
                $this->obTabela = $retTab->fetchObject();

                $setEntidade = $this->obTabela->tabela_view;

                //retorna ações a serem incluidas na barra de navegação da lista
                $dboBarraAction = new TDbo_kernelsys('lista_bnav');
	                $criterioBarraAction = new TCriteria();
	                $criterioBarraAction->add(new TFilter('lista_form_id', '=', $this->idLista));
                $retBarraAction = $dboBarraAction->select('*', $criterioBarraAction);
                while ($obBarraAction = $retBarraAction->fetchObject()) {
                    $this->actionsBarraNav[$obBarraAction->id] = $obBarraAction;
                }          

                //retorna ações da lista
                $sqlAction = "SELECT * FROM lista_actions WHERE idlista='" . $this->listaInfo->id . "' and ativo='1' order by ordem";
                $retAction = $this->conn->Query($sqlAction);                

                while ($obAct = $retAction->fetchObject()) {
                    $obAct->title = $obAct->label;
                    $obAct->alt = $obAct->label;
                    $obAct->label = '-';
                    $this->obAction[$obAct->id] = $obAct;
                }
                
                //Retorna os campos para aplicar na lista
                $this->getListaCampo($this->conn, $this->listaInfo->id);

                # instancia objetos colunas da lista
                $sqlCols = "SELECT * FROM lista_colunas WHERE lista_form_id='" . $this->listaInfo->id . "' and ativo='1' order by ordem";
                $RetCols = $this->conn->Query($sqlCols);

                //percorre colunas da listagem \\
                while($colsInfo = $RetCols->fetchObject()) {

                    $colsInfo->coluna = strtolower($colsInfo->coluna);
                    $this->colunas[$colsInfo->coluna] = $colsInfo;
                }//temina loop
                $this->campoChave = 'codigo';
               
            }

            /**
             * instancia o cabeçalho da lista
             * em execução e armazena em sessão
             */
            $objHeader = new TSetHeader();
            $testeHeader = $objHeader->testHeader($this->listaInfo->id);
            if ($testeHeader) {
                $this->obHeader = $objHeader->getHead($this->listaInfo->id);
            } else {
                $this->obHeader = $objHeader->onHeaderLista($this->listaInfo->id);
            }

            if ($this->obHeader['codigoPai']) {
                $this->codigoPai = $this->obHeader['codigoPai'];
            }
            /***********************************************************/
            
        }
        
        // mantem objeto conteiner de retorno das açães da lista
        $this->pane = $paneRet;

        //////////////////////////////////////////////////////////////////////////////////
        //inicia construtor da lista
        $this->obLista = new TSetlista($this->idLista, $setEntidade, $this->listaInfo->label, $this->pane);
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
        // se a lista for do tipo [bloco] se aplica o criterio de retorno por codigo
        if ($this->listaInfo->filtropai != '0' and $this->codigoPai) {
            $this->obLista->addCriterio($this->listaInfo->filtropai, $this->codigoPai, "=", 'AND','filtroPai');
        }
        
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
                    if($vetorFiltro[5]){
                        $dadosFiltro = call_user_func(array($objetoDinamicofiltro, $vetorFiltro[4]), $this->idLista);
                    }else{
                        $dadosFiltro = call_user_func(array($objetoDinamicofiltro, $vetorFiltro[4]));
                    }
                } else {
                    $dadosFiltro = $vetorFiltro[3];
                }
                // matem filtro em sessão
                // $filtro = array("expre" =>  $dadosFiltro, "cols" => $vetorFiltro[0], "Manterfilt" => true );
                // $this->obsession->setValue("dadosFiltroListaAtual",$filtro);

                $this->obLista->addCriterio($vetorFiltro[0], $dadosFiltro, $vetorFiltro[1], $vetorFiltro[2],'filtroLista');
            }
            $vetorFiltro = NULL;
        }
        
        //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        //verifica e compila objeto APÊNDICE
        if ($this->listaInfo->obapendice and $this->listaInfo->obapendice != "-" and $this->listaInfo->obapendice != "" and $this->listaInfo->obapendice != "0") {

            if ($this->obHeader['idFormPai']) {
                $chaveApendice = $this->obHeader['idFormPai'];
            } else {
                $chaveApendice = $this->idForm;
            }

            //testa a existencia do cabeçalho
            $testHeader = new TSetHeader();
            if($testHeader->testHeader($chaveApendice) === false){
                $testHeader->onHeader($chaveApendice);
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
    private function getListaCampo($conn, $idLista){
            
      //retorna ações da lista
      $sqlAcao = "SELECT * FROM lista_fields WHERE idlista='" . $idLista . "' and ativo='1' order by ordem";
      $retAcao = $conn->Query($sqlAcao);

        while ($obAct = $retAcao->fetchObject()) {
          $obAct->title = $obAct->label;
          $obAct->alt = $obAct->label;
          $obAct->label = '-';
          $this->obAction[$obAct->id] = $obAct;
        }
            
    }

    /**
     * Retona dados o autor diretamente do
     * objeto lista (sem sessão)
     */
    public function getListDados() {
        $this->obHeader = new TSetHeader();
        return $this->obHeader->getHead($this->idForm);
    }

    /*
     * configura visualizaçao de acoes sobrepondo
     * a definida no registro do sistema
     * acoes -> [incluir, filtrar, exluir, editar, viazualizar, enviar]
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
        foreach ($this->colunas as $key => $cols) {

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
        $obPrivilegios = new TGetPrivilegio($this->idForm, $nivel);
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
                $ActionBarraNav->setAlvo($this->pane);

                $botBarraNav = new TButton($obBarraNav->nome);
                $botBarraNav->setAction($ActionBarraNav->getAction(), $obBarraNav->label);

                $this->obLista->addBot($botBarraNav);
            }
        }

        //Adicina botões na barra de navegação
        if($this->listaInfo->acselecao != "0" and $this->editable != "form") {

            $botmarcarTodos = new TCheckButton('addAll');
            $botmarcarTodos->onclick = 'addAllReg(this)'; //onSelecao(this, '.$this->idLista.', \'all\')';
            $botmarcarTodos->id = 'addAllReg';

            $this->act['acSelecao'] = new TAction('onSelecao');
            $this->act['acSelecao']->setParameter('ob', 'this');
            $this->act['acSelecao']->setParameter('idLista', $this->idLista);
            $this->act['acSelecao']->nome = "acselecao";
            $this->act['acSelecao']->field = $this->campoChave;
            $this->act['acSelecao']->label = $botmarcarTodos;
            $this->act['acSelecao']->title = 'Selecionar';
            $this->act['acSelecao']->value = "1";
            $this->act['acSelecao']->tipoCampo = "TCheckButton";

            $this->obLista->addAction($this->act['acSelecao']);
            
        }

        if ($this->listaInfo->acincluir != "0" and $this->editable != "form") {

            $ActionNew = new TSetAction('prossExe');
            $ActionNew->setMetodo('onNew');
            $ActionNew->setTipoRetorno("form");
            $ActionNew->setIdForm($this->idForm);
            $ActionNew->setAlvo($this->pane);

            $this->bt['incluir'] = new TIcon("ui-icon-plusthick", "icons_incluirLista");
            $this->bt['incluir']->setAction($ActionNew);
            $this->bt['incluir']->setTitle($this->listaInfo->acincluir);

            $this->obLista->addBot($this->bt['incluir']);
        }

        if ($this->listaInfo->acdeletar == 1 and !$this->editable) {

            $this->act['del'] = new TSetAction('prossExe');
            $this->act['del']->setMetodo('onDelete');
            $this->act['del']->setTipoRetorno('lista');
            $this->act['del']->setConfirme('Você deseja realmente excluir o registro?');
            $this->act['del']->setIdForm($this->idLista);
            $this->act['del']->setAlvo($this->pane);
            $this->act['del']->nome = "acdelete";
            $this->act['del']->field = $this->campoChave;
            $this->act['del']->label = '-';
            $this->act['del']->title = 'Deletar';
            $this->act['del']->img = 'new_ico_delete.png';

            $this->obLista->addAction($this->act['del']->getAction());
        }

        if ($this->listaInfo->aceditar == 1 and !$this->editable) {

            $this->act['edit'] = new TSetAction('prossExe');
            $this->act['edit']->setMetodo('onEdit');
            $this->act['edit']->setTipoRetorno('form');
            $this->act['edit']->setIdForm($this->idForm);
            $this->act['edit']->setAlvo($this->pane);
            $this->act['edit']->nome = "acedit";
            $this->act['edit']->field = $this->campoChave;
            $this->act['edit']->label = '-';
            $this->act['edit']->title = 'Editar';
            $this->act['edit']->img = 'new_ico_edit.png';

            $this->obLista->addAction($this->act['edit']->getAction());
        }

        if ($this->listaInfo->acreplicar == 1 and !$this->editable) {

            $this->act['reply'] = new TSetAction('prossExe');
            $this->act['reply']->setMetodo('onReply');
            $this->act['reply']->setTipoRetorno('form');
            $this->act['reply']->setIdForm($this->idForm);
            $this->act['reply']->setAlvo($this->pane);
            $this->act['reply']->nome = "acreply";
            $this->act['reply']->field = $this->campoChave;
            $this->act['reply']->label = '-';
            $this->act['reply']->title = 'Replicar';
            $this->act['reply']->img = 'new_ico_clone.png';

            $this->obLista->addAction($this->act['reply']->getAction());
        }

        if ($this->listaInfo->acviews == 1) {

            $this->act['view'] = new TSetAction('prossExe');
            $this->act['view']->setMetodo('onView');
            $this->act['view']->setTipoRetorno('form');
            $this->act['view']->setIdForm($this->idForm);
            $this->act['view']->setAlvo($this->pane);
            $this->act['view']->nome = "acviews";
            $this->act['view']->field = $this->campoChave;
            $this->act['view']->label = '-';
            $this->act['view']->title = 'Visualizar';
            $this->act['view']->img = 'new_ico_view.png';

            $this->obLista->addAction($this->act['view']->getAction());
        }

        if ($this->listaInfo->acenviar == 1) {

            $this->act['enviar'] = new TAction('setDadosPesquisa');
            $this->act['enviar']->setParameter('idLista', $this->idLista);
            $this->act['enviar']->setParameter('tipoRetorno', 'form');
            $this->act['enviar']->nome = "acenviar";
            $this->act['enviar']->field = $this->campoChave;
            $this->act['enviar']->label = '-';
            $this->act['enviar']->title = 'Enviar';
            $this->act['enviar']->img = 'new_ico_enviar.png';

            $this->obLista->addAction($this->act['enviar'], $this->listaInfo->pesquisa);
        }

        //adiciona ações na lista
        if (count($this->obAction) > 0) {
            foreach ($this->obAction as $keyAct => $actInfo) {


                if ($actInfo->actionjs == "prossExe") {
                    $inAct = new TSetAction($actInfo->actionjs);
                    $inAct->setMetodo($actInfo->metodoexe);
                    $inAct->setTipoRetorno($actInfo->tiporetorno);
                    $inAct->setIdForm($this->idForm);
                    $inAct->setConfirme($actInfo->confirm);
                    $inAct->setAlvo($this->pane);
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
                    if ($actInfo->metodoexe) {
                        $inAct->setParameter('metodo', $actInfo->metodoexe);
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
        $idListaBoxAtual = 'obListaBox_' . $this->idLista;
        $listaBox = "listaBox";
        $this->obsession->setValue($idListaBoxAtual, $this->obLista, $listaBox);

        $this->dboKs->close();

        return $this->obLista;
    }

}
?>