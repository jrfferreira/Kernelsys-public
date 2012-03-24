<?php
/*******************************************************************************
Classe conteiner de ações da estrutura de dados
Versão: 1.1.2
Data: 06/03/2010
Programador: Wagner Borba
*******************************************************************************/

/*
* run()
* Executa determinado método de acordo com
* os par�metros recebidos
*/
if(!function_exists("__autoload") && !is_callable("__autoload")) {
    function __autoload($classe) {

        include_once('../app.util/autoload.class.php');
        $autoload = new autoload('',$classe);
    }
}


/**
 * Recepta as ações enviadas por get
 * instancia o objeto execs e executa o
 * metodo em questão
 */
if ($_GET['method']) {
			
    $method = $_GET['method'];
    $ObExec = new TExecs($method, $_GET);
}

#########################################################################################################################

class TExecs {

    public function __construct($metodo, $param) {

        $this->param = $param;
        $this->tipoRetorno = $this->param['tipoRetorno'];
        
        //Retorna Usuario logado===================================
        $obUser = new TCheckLogin();
        $this->obUser = $obUser->getUser();

        //print_r($this->obUser);
        //=========================================================
        
        //Instancia manipulador de sessão
        $this->obsession = new TSession();

        /*
        * incia lista apartir do menu
        * O paramentro [idForm] só é enviado por um formulário pai
        * por esse motivo é usando para verificar se a ação envida foi
        * disparada pelo formulário pai.
        */
        if($this->param['idForm']) {

            $this->idForm = $this->param['idForm'];
            $this->obHeader = new TSetHeader();
            

            //define o nivel de execução
            if($this->param['nivel'] == 1){
                $this->obHeader->clearHeader();
                $this->nivelExec = $this->param['nivel'];
            }
            else{
                $this->nivelExec = 2;
            }

                //=========================================================================================
                //recupera dados do autor (CABEÇALHO) emissor do comando a ser executado no fluxo atual)
                if($this->tipoRetorno == 'lista'){
                    if($this->obHeader->testHeader($this->idForm)){
                        $this->headerDados = $this->obHeader->getHead($this->idForm);
                    }
                }elseif($this->tipoRetorno == 'form'){
                    if(!$this->obHeader->testHeader($this->idForm)){
                        $this->obHeader->onHeader($this->idForm);
                    }
                    $this->headerDados = $this->obHeader->getHead($this->idForm);
                    
                }
                $this->entidadeForm = $this->headerDados['entidade'];
                //=========================================================================================

                //define idLista, caso não esteja no Head idLista=idForm
                if($this->headerDados['idLista']){
                    $this->idLista = $this->headerDados['idLista'];
                }else{
                    $this->idLista = $this->idForm;
                }

            // chaves de acesso a listabBox
            $this->idListaBoxAtual = 'obListaBox_'.$this->idLista;
            $this->listaBox = "listaBox";
            //Limpa sessão do listaBox
            if($this->param['nivel'] == 1){
                $this->obsession->setValue($this->idListaBoxAtual, null, $this->listaBox);
            }

            /**
            * Limpa campo de status de Visualização do formulário
            * atribuido quando executado o botão de visualizar
            */
            $this->obsession->setValue('statusViewForm', NULL);
        }
        


        //configura conteiner de retorno das ações
        $this->paneRet = 'contLista'.$this->idLista;

        //testa existencia do metodo e executa
        if(method_exists($this, $metodo)) {
        	
        	array_shift($param);//retira a primeira posição [metodo] dos paramentros
            call_user_func(array($this, $metodo), $param);
        }
        
    }
    #############################################################################################
    #############################################################################################

    /*
    * método getList()
    * Instancia objeto lista diretamente do TCompLista
    */
    public function getList() {

        //limpa estatos de viazualização quando ativado pela lista interna
        if($tp == $this->obsession->getValue('statusViewForm')) {
            //limpa campo de status de visualização do formulário
            $this->obsession->setValue('statusViewForm', NULL);
        }
        
        //lista de dados
        $setLista = new TCompLista($this->idLista, $this->paneRet);

        $this->obLista = $setLista->get();

        // dados do autor direto do objeto lista
        $listDados = $setLista->getListDados();

        $this->showlist();
    }

    /**
    * Instancia objeto (lista) armazenado em sessão
    * e disponibilida o mesmo na classe de execução
    */
    private function getObLista(){
        if($this->idLista) {
            $this->obLista = $this->obsession->getValue($this->idListaBoxAtual, $this->listaBox);
        }
    }

    
    
    /**
     * método getform()
     * instancia objeto form
     */
    public function getform($key = NULL, $dados = NULL) {
        /**
         * armazena codigo do objeto(registro) em sessão para associações (chave estrangeira) dos objetos filhos
         */
        if($key){
            $this->obsession->setValue('codigoatual'.$this->idForm, $key);
        }
        
    
        /**
        * Instancia objeto lista principal
        * usando DForm que monta o fomul�rio pai
        * completo (form, aba, blocos e botões)
        */
        $OBform = new TForms($this->idForm, $key);

        if($dados){
            $OBform->setDados($dados);
        }
           
        $forms = $OBform->getForm();
        $forms->show();

        //define o formulário em aberto
        $this->obsession->setValue('checkFormPrimario',$this->headerDados['idlista']);
    }

     /**
     * Abre o formulário para criar um novo registro
     */
    public function onNew() {
    	
            //==============================================
            //aplica regras de negocio na inclusão da lista
            $retorno = $this->setInControl();

        $this->obsession->setValue('statusFormEdition', NULL);
        //grava status do formulário no cabeçalho
        $this->obHeader->addHeader($this->idForm, "status", 'new');

        /*
        #-------- Gera novo registo no banco de dados --------#
        if($this->headerDados['formainclude'] == "one"){
            
            if(!$this->headerDados['idFormPai']) {

                $dadoPadrao['codigoautor'] = $this->obUser->codigo;
                $dadoPadrao['ativo'] = '9';

                $dboInsert = new TDbo($this->entidadeForm);
                $codRegistro  = $dboInsert->insert($dadoPadrao);

                $codRegistro = $codRegistro['codigo'];
            }
            else{ //executado se o inclusão for feita a partir de uma lista secundaria

                // recupera campo de destino do codigo armazenado em seção
                //$destinoCodigo = $this->headerDados['destinocodigo'];
                $colunaPai = $this->headerDados['destinocodigo'];

                $dadosSec[$colunaPai] = $this->headerDados['codigoPai'];
                $dadosSec['codigoautor'] = $this->obUser->codigo;
                $dadosSec['ativo'] = '9';

                $dboInsertSec = new TDbo($this->entidadeForm);
                $codSecundario = $dboInsertSec->insert($dadosSec);

                $codRegistro =  $codSecundario['codigo'];
            }
            
            

            #----------------------------------------------------#
            // Executa o formulario se o mesmo for solicitado
            $ObDados = new TDados($this->idForm, $codRegistro, $this->headerDados['tipo'], $this->entidadeForm);
           	$dados = $ObDados->get();
            
        }
        elseif($this->headerDados['formainclude'] == "multiple"){
            $codRegistro = null;
            $dados = null;
        }
        */

        $forms = $this->getform();
    }


    /**
     * método onEdit
     * carrega os dados do registro no formulário
     * param  $param = parámetros passados via URL ($_GET) instanciado no contrutor
     */
    public function onEdit() {

        try {

            //==============================================
            //aplica regras de negocio na inclusão da lista
            $retorno = $this->setInControl();

            // obtém o objeto pelo ID
            $ObDados = new TDados($this->idForm, $this->param['key'], $this->headerDados['tipo'], $this->entidadeForm);
            $dados = $ObDados->get();
            //Altera estatus do registro para edição - 8
//            if($dados['ativo'] == '1') {
//                $obStatus = new TStatus();
//                $obStatus->setStatus($dados['codigo'], $this->entidadeForm, $dados['ativo'], '8');
//            }
        

            /**
             * armazena ID do registro em questão para registro de hist�rico
             * de movemento do sistema
             */
            $this->obsession->setValue('statusFormEdition', 'editando');
            //grava status do formulário no cabeçalho
            $this->obHeader->addHeader($this->idForm, "status", 'edit');            

            // Executa o editor do formulário se o mesmo for solicitado
            $this->getform($this->param['key'], $dados);

        }
        catch (Exception $e) { // em caso de exceção
            TTransaction::rollback();
            // exibe a mensagem gerada pela exceção
            new setException($e->getMessage());
            // desfaz todas alterações no banco de dados
        }
    }

    /*
    * Gera um formulário independente
    * onSet precisa ser reavaliado
    */
    public function onFormOpen() {

        $OBform = new TForms($this->idForm);

        //Adicina botões na barra de navegação
        // Botão padrão [Fechar]
        $action1 = new TAction('onClose');
        $action1->setParameter('tipoRetorno', 'form');
        $action1->setParameter('idForm', $this->idForm);
        $action1->setParameter('alvo', '');
        $action1->setParameter('confirme', '');
        $OBform->setButton('fechar_botform'.$this->idForm, 'Fechar', $action1);

        $forms = $OBform->getForm();
        $forms->show();
    }

   
    /*
    * Exibe todas as informações do objeto(registro) via o Id do mesmo
    */
    public function onView() {
        try {

            //grava status do formulário no cabeçalho
            $this->obHeader->addHeader($this->idForm, "status", 'view');

            // obt�m o objeto pelo ID
            $ObDados = new TDados($this->idForm, $this->param['key'], $this->headerDados['tipo'], $this->entidadeForm);
            $dados = $ObDados->get();

            if($this->obsession->getValue('statusViewForm') != "form") {
                $this->obsession->setValue('statusViewForm', $this->headerDados['tipo']);
            }

            // Executa o editor do formulario se o mesmo for solicitado
            $forms = $this->getform($this->param['key'],$dados);

        }
        catch (Exception $e) { // em caso de exceção

            TTransaction::rollback();
            // exibe a mensagem gerada pela exceção
            new TMessage('error', '<b>Erro</b>' . $e->getMessage());
            // desfaz todas alterações no banco de dados

        }
    }

    /*
    *Recarega a lista alvo
    */
    public function onRefresh() {

        //recarrega a lista
        $this->getList();
        //limpa [id] do formulario secundario em sessão ref.:(compilerData.php)
        $this->obsession->setValue('tempBloco',NULL);
    }

    /**
     * Executa ação de salvar do formulario armazenado em sessão
     * return <type> 
     */
    function onSave(){
    	
    		//atribui o valor aos campos
    		$dados = $this->headerDados;
	        $camposSession = $this->headerDados['camposSession'];
	        $dadosForm = $_POST;
			
			foreach($dadosForm as $nomeCampo=>$valorCampo){
			    if($camposSession){
			        $campoAtual = $camposSession[$nomeCampo];
			        $campoAtual['valor']  = $valorCampo;
			        $campoAtual['status'] = 0;
			        
			        $camposSession[$nomeCampo] = $campoAtual;
			    }
			}
			//atualiza a auteração na sessão
			$this->obHeader->addHeader($this->idForm, 'camposSession',  $camposSession);  
			
        $codigo= $this->headerDados['codigo'];
        
        
        if($camposSession){

                $unidade = $this->obUser->unidade->codigo;
                $codigoPai = $this->headerDados['codigoPai'];
                // recupera campo de destino do codigo armazenado em sessão
                $destinoCodigo = $this->headerDados['destinocodigo'];//"codigo";
                
            $obControl = new TSetControl();
            $codigoRetorno = 'erro#0';

            $dadosCampos = null;
            foreach($camposSession as $campo=>$infoCampo){

                        //=====================================================================
                        //valida campos obrigatários
                        if($infoCampo['obrigatorio'] == '1'){
                            $retornoValidaNulos = $obControl->setNulos($infoCampo['label'], $infoCampo['valor']);

                            if($retornoValidaNulos !== false){
                                $codigoErro = 'erro#2';
                                echo $codigoErro.'#'.$retornoValidaNulos;
                                exit();
                            }
                        }
                        
                        //======================================================================
                        
                  if($infoCampo[status] == 0){
                        /***************************************************************************
                        * Aplica regra de negócios do campo se ouver
                        */
                        if($infoCampo['incontrol'] != "0" and $infoCampo['incontrol'] != "") {

                            $returVal = $obControl->main($infoCampo['idForm'], $infoCampo['entidade'], $infoCampo['incontrol'], $infoCampo['valor'], $campo);

                            if($returVal['valor'] === false) {
                                $codigoRetorno = $returVal['codigoRetorno'];
                                echo $codigoRetorno.'#'.$returVal['msg'];
                                exit();
                            }else{
                                $valor = $returVal['valor'];
                            }
                        }else{
                            $valor = $infoCampo['valor'];
                        }

                        //agrupa campos para salvar
                        $dadosCampos[$infoCampo['entidade']][$campo] = $valor;
                    }
                }


                //percorre os campos agrupados por entidade e grava em banco
                if(count($dadosCampos) > 0){
                	                	
	                foreach($dadosCampos as $entidade=>$dados){
	
	                    //Define o campo chave da operação =============================
	                    if($entidade != $this->headerDados['entidade']){
	                        $colunaReferencia = $this->headerDados['colunafilho'];
	                    }else{
	                        $colunaReferencia = "codigo";
	                    }
	                    //==============================================================
	
	                    $obDbo = new TDbo();
	                    //consulta se o registro já existe
	                    $obDbo->setEntidade($entidade);
	                        $criterioValReg = new TCriteria();
	                        $criterioValReg->add(new TFilter($colunaReferencia, '=',$codigo));
	                        $Check = $obDbo->select('codigo', $criterioValReg);
	                    $resCheck = $Check->fetch();
	                    
	                    //se o registro já existir
	                    if(!$resCheck['codigo']) {
	                    	
	                        //valores padrões
	                        if($codigo){
	                            $dados[$colunaReferencia]   = $codigo;
	                        }
	                        if($codigoPai){
	                            $dados[$destinoCodigo]  = $codigoPai;
	                        }
	                        
	                        $dados['unidade']      = $unidade;
	                        $dados['codigoautor']  = $this->obUser->codigo;
	                        $dados['datacad']      = date("Y-m-d");
	                        $dados['ativo']        = '1';
									
	                        $obDbo->setEntidade($entidade);
	                        $retorno = $obDbo->insert($dados);
				
	                        $codigo = $retorno['codigo'];
	                        
	                    }else{
							
	                    	$obDbo->setEntidade($entidade);
	                           $criteriaUpCampo = new TCriteria();
	                           $criteriaUpCampo->add(new TFilter($colunaReferencia, '=', $codigo));
	                        $Query = $obDbo->update($dados, $criteriaUpCampo);
	                        
	                    }
	                    $obDbo->close();
	                }//fim do loop salvar
                }
          }
          //Fecha o formulário
          $this->onClose();
          return $codigo;
          
        }

    /*
    *
    */
    public function onClose() {

//        if($this->headerDados['formainclude'] == 'one'){
//    	
//                //autera estatus de edição para Ativo
//                if($codigoRegAtual) {
//
//                    //define o campo de acesso ao registro considerando o tipo form ou secundario
//                    $campoReferencia = "codigo";
//
//                    $obTDboStatus = new TDbo();
//                    $obTDboStatus->setEntidade($this->entidadeForm);
//    	
//
//                    $criteriaStatus = new TCriteria();
//                    $criteriaStatus->add(new TFilter($campoReferencia,'=',$codigoRegAtual));
//                    $retStatus = $obTDboStatus->select("ativo", $criteriaStatus);
//                    $obStatus = $retStatus->fetchObject();
//
//                    if($obStatus->ativo == '9' or $obStatus->ativo == '8') {
//                        $retUpStatus = $obTDboStatus->update(array("ativo"=>"1"), $criteriaStatus);
//
//                        if(!$retUpStatus) {
//                            $obTDboStatus->rollback();
//                            $obTDboStatus->close();
//                            new setException("Erro ao atualizar o estatus do resgistro [".$codigoRegAtual."] - TExecs - Line - 516.");
//                        }
//                    }
//                    $obTDboStatus->close();
//                }
//
//            //==========================================================================
//            //Executa metodo formOutControl do formulario presentes no cabeçalho
//            $formOutControl = $this->headerDados['formOutControl'];
//            if($formOutControl) {
//
//                $expFormOutControl = explode('/', $formOutControl);
//
//                $classeOutControl = $expFormOutControl[0];
//                $metodoOutControl = $expFormOutControl[1];
//                $obOutControl = new $classeOutControl();
//
//                call_user_func(array($obOutControl, $metodoOutControl), $this->idForm);
//            }
//        }

        //recarrega a lista
        $this->getList();
        //destroi cabeçalho do form
        $this->obHeader->clearHeader($this->idForm);
    }

    /*
    *
    */
    public function onCancel() {

        // obt�m o objeto pelo ID
        //$ObDados = new TDados($this->idForm, $this->param['key'], $this->headerDados['tipo'], $this->entidadeForm);
        //$ObDados->delete();

        $this->showlist();
        $this->obHeader->clearHeader($this->idForm);
    }

    #############################################
    # ações da lista
    #############################################

    /**
     * transfere para lista em sessão a ação deletar executa na camada visual
     * pelo botão responsavel pela ação (excluir)
     */
    public function onDelete() {

            //==============================================
            //aplica regras de negocio na inclusão da lista
            $retorno = $this->setInControl();

        if($this->param['key'] and $this->entidadeForm) {

            $this->getObLista();
            //onDelente TSetlista();
            $this->obLista->onDelete($this->param['key'], $this->entidadeForm);
            $this->showlist();
        }
        else {
            // Lan�a exeção de erro na execução da sql
            new setException("Os parametros não foram definidos corretamente (TExecs.onDelete) - Linha - 579");
        }
    }

    /*
    *filtra dados
    */
    public function onFilter() {

        $this->getObLista();
        $filtro = $_POST;

        $this->obLista->setFiltro($filtro);
        $this->obLista->clearSelecao();
        $this->showlist();
    }
    
    /*
    *fAltera limite
    */
    public function onChangeLimit() {
        $this->getObLista();
        
       	$limite = $this->obsession->getValue("comboLimite" . $this->idLista);

       	$this->obsession->__dump(); exit();
       	
        $this->obLista->setLimite($limite);
        $this->obLista->clearSelecao();
        $this->showlist();
    }
    
    /*
    *limpa sessões de filtro
    */
    public function onClearFilter() {
        $this->getObLista();
        
        $this->obLista->clear();
        $this->obLista->clearSelecao();
//  $this->obsession->setValue("dadosFiltroListaAtual",NULL);
        $this->showlist();
    }

    /*
    *Exibe janela de filtro
    */
    public function onViewFilter() {

        $this->getObLista();
        $filtro = $_POST;

        $this->obLista->setFiltro($filtro);

    }

    /**
     * método onOrder()
     * metodo para ordenar lista de dados
     */
    public function onOrder($param) {
        try{
            if($param['key']!="") {
                
                $this->getObLista();

                if($this->obLista){
                    $this->obLista->setOrdem($param['key']);
                    $this->showlist();
                }
                else{
                    throw new ErrorException("A lista não foi instanciada na memoria de execução.");
                }
            }else{
                throw new ErrorException("A coluna passada � inv�lida.");
            }
        }catch(Exception $e){
            new setException($e);
        }
    }


     /**
     * método onReply
     * gatilho para replicação de formularios
     * param  $param = parâmetros passados via URL ($_GET) instanciado no contrutor
     */
    public function onReply() {

        try {
            $this->getObLista();
            $cloneForm = new TCloneForm();
            $cloneForm->confirm($this->idForm, $this->param['key'],$this->idLista);

        }
        catch (Exception $e) { // em caso de exceção
            TTransaction::rollback();
            // exibe a mensagem gerada pela exceção
            new setException($e->getMessage());
            // desfaz todas alterações no banco de dados
        }
    }

    /*
    *Retrocede os registros listados
    */
    public function onBack() {

        $this->getObLista();

        if($this->obLista->posicao>0) {
            $posicao = $this->obLista->posicao - $this->obLista->limite;
        }
        $this->obLista->setPosition($posicao);
        $this->showlist();
    }

    /*
    *Avan�a os registros listados
    */
    public function onNext() {

        $this->getObLista();

        $posicao = $this->obLista->posicao + $this->obLista->limite;
       
        $this->obLista->setPosition($posicao);
        $this->showlist();
    }

    /*
    * Executa a janalea de pesquisa
    */
    public function onPesquisa() {

        $obPesq = new TSetPesquisa($this->param['key'], "pesq");
        $obPesq->show();
    }

        /**
     * método onPrint()
     * metodo para imprimir uma lista de dados
     */
    public function onPrint($param) {
        try{            
            $this->getObLista();
            $this->obLista->setPrint();

        }catch(Exception $e){
            new setException($e);
        }
    }

    /**
    * executa ação de multeseleção na lista
    */
    public function onSelecao(){
        try{
            if($this->param['dados'] and $this->param['acselecao']){
            	
            	//$dados = json_decode($this->param['dados']);
            	
               $this->getObLista();
               $this->obLista->setSelecao($this->param['idForm'], $this->param['dados'], $this->param['acselecao']);

               if($this->param['dados'] == 'all'){
                   $this->showlist();
               }
            }else{
                throw new Exception('Os dados passados para a seleção são inv�lidos.');
            }
        }catch(Exception $e){
            new setException($e);
        }
    }

    /*método showlist()
    /Armazena novo objeto lista em sessão e imprime o novo objeto
    */
    public function showlist() {

        if(!$this->obLista){
            $this->getObLista();
        }

        //Limpa o hist�rico da lista em sessão
        if($this->nivelExec == 1){
            $this->obsession->delValue($this->listaBox);
        }

        if($this->nivelExec == 1) {
           //isntancia um formulario
           $panel = new TPanel('');
           $panel->id = $this->paneRet;
           $panel->add($this->obLista->getLista());
            //$panel = new TWindow('Lista '.$this->headerDados['tituloLista'],$this->paneRet);            
            //$panel->add($this->obLista->getLista());
        }
        elseif($this->nivelExec == 2) {
            $panel = $this->obLista->getLista();
        }

        // Subustitui objeto lista da sessão pelo novo objeto lista \\
        $this->obsession->setValue($this->idListaBoxAtual, $this->obLista, $this->listaBox);
      
        $panel->show();

    }

    /**
     *
     * param <type> $chave
     * return <type>
     */
    private function getHeader($chave){
        if($chave){

            /**
            * instancia o cabeçalho do formulário
            * em execução e armazena em sessão
            */
                $obHeader = new TSetHeader();
                $obHeader->onHeader($chave);

                //retorna o cabeçalho do formulário
                $header = $obHeader->getHead($chave);
            /***********************************************************/

            return $header;

        }
    }

    /**
    *
    */
    private function setInControl(){
        if($this->headerDados['incontrol']){

            $obInControl = new TSetControl();
            $retorno = $obInControl->main($this->headerDados['idForm'], $this->entidadeForm, $this->headerDados['incontrol'], $this->headerDados['codigoPai'], $this->paneRet);
            
            if($retorno){
               echo $retorno;
               exit;
            }
        }
    }
}

?>
