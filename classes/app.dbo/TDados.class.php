<?php
/**
 * Provem todos os metodos para manipular e retornar o valor de um conjuto de tabelas do banco de dados
 * Data: 20/08/2008
 * author Wagner Borba
 */
class TDados {

    private $dados;

    /**
     * Monta a extrutura básica para o funcionamento da classe
     * param $seq= seqdo registro na base de dados
     * param $tipo = tipo de formulário (form/bloco)
     * param $entidade = entidade(tabela) alvo da ação
     */
    public function __construct($formseq, $seq, $tipo, $entidade) {

        $this->formseq = $formseq;

            //retorna o cabeçalho do formulário
            $this->obHeaderForm = new TSetHeader();
            $this->headerForm = $this->obHeaderForm->getHead($this->formseq);

        $this->ent    = $entidade;
        $this->seqReg  = $seq;

        if($this->seqReg) {

            $this->entidades[$this->ent] = $this->ent;

            //$this->dados = $this->load($this->ent,$this->seqReg,$this->campoChave);
            //if($tipo == 'form') {
                $this->setDados($this->formseq);
            //}
            }

    }

    /**
     * Congura vetor de entidades com a lista das entidades
     * que se relacionam em order pir->filhos
     * param <id> $formseq = id do formulario que contem o relacionamento
     */
    private function setRelations($formseq) {

        try {
        		$tableExists = false;
                $tKrs = new TKrs('form_x_tabelas');
                $criterio = new TCriteria();
                $criterio->add(new TFilter('formseq','=',$formseq));
                $criterio->add(new TFilter('statseq','=','1'));
                $formTables = $tKrs->select('*',$criterio);
                	
                $tKrs->setEntidade('tabelas');
                $criterioTabela = new TCriteria();
                while($ft = $formTables->fetchObject()){
                	$tableExists = true;
                	$criterioTabela->add(new TFilter('seq','=',$ft->tabseq),'OR');
                }
                
                if(!$tableExists){
                	throw new ErrorException(TMensagem::ERRO_VINCULO_TABELA_NAO_ENCONTRADO, 2);
                }
                
                $exeQuery = $tKrs->select('*',$criterioTabela);
                
                while($listEntidades = $exeQuery->fetchObject()) {
                    $this->entidades[$listEntidades->tabela] = $listEntidades->tabela;
                }

        }catch (Exception $e) {
            new setException($e);
        }
    }

    /**
     * Retorna tabelas relacionadas as tabela principal
     * param $formseq = id do formulario pai do relacionamento (form_x_tabelas)
     */
    public function setDados($formseq) {

        $this->setRelations($formseq);

        foreach($this->entidades as $k=>$entity) {

            $sDados = $this->Load($entity, $this->seqReg);

            if($sDados) {// verifica se há registro no vetor
                foreach($sDados as $ec=>$ev) {

                    if(!is_array($this->dados) || !array_key_exists($ec, $this->dados)){
                         $this->dados[$entity][$ec] = $ev;
                    }
                }
            }
        }

    }

    /**
    * mÃ©todo delete()
    *  Excluir um conjunto de objetos (collection) da base de dados
    *  atravÃ©s de um critÃ©rio de seleÃ§Ã£o.
    *  param $criteria = objeto do tipo TCriteria
    */
    public function delete() {
            $dbo = new TDbo($this->ent);
            $dbo->delete($this->seqReg, $colunafilho);
    }

    /**
     * mÃ©todo load()
     *  Recupera (retorna) um objeto da base de dados
     *  atravï¿½s de seu ID e instancia ele na memÃ³ria
     *  param $seq= ID do objeto
     */
    public function load($entidade, $seq) {

        $coluna = $this->setColuna($entidade);

        // cria critério de seleção baseado no SEQ
        $criteria = new TCriteria;
        $criteria->add(new TFilter($coluna, '=', $seq, 'numeric'));

        $loadDbo = new TDbo($entidade);
        $result = $loadDbo->select('*', $criteria);

        // se retornou algum dado
        if ($result) {
            // retorna os dados em forma de vetor
            while($objeto = $result->fetch(PDO::FETCH_ASSOC)) {
                $obj[$objeto[TConstantes::SEQUENCIAL]] = $objeto;
            }

            if(count($obj)==1) {
                $obj = $obj[key($obj)];
            }
        }
        
        //retorna descrição dos campos com pesquisa ativadas.
        $dadosColPesq = $this->getColunaPesquisa($entidade, $obj);
        if($dadosColPesq){
        	foreach($dadosColPesq as $col => $value){
        		if($value){
        			$obj[$col] = $value;
        		}
        	}
        }
        
        
        //armazena dados do form no cabeçalho
        $this->obHeaderForm->addHeader($this->formseq, TConstantes::HEAD_DADOSFORM, $obj);
                
        return $obj;
    }

    /**
     *
     * param <type> $entidade
     * return <type>
     */
    public function setColuna($entidade){

       if($entidade == $this->headerForm[TConstantes::ENTIDADE]){
          $coluna = "seq";
       }else{
          $coluna = $this->headerForm['colunafilho'];
       }

       return $coluna;
    }

    /**
     * Verifica a existencia de um campo de pesquisa no formulario
     * para preencher a descrição do mesmo na edição
     * @param unknown $tabela
     */
    private function getColunaPesquisa($tabela, $dados){
    	
    	//inicia uma transação com a camada de dados do form
    	$obKDbo = new TKrs();
    	
    	$obKDbo->setEntidade('tabelas');
	    	$criteriaTab = new TCriteria();
	    	$criteriaTab->add(new TFilter('tabela','=',$tabela, 'string'));	
    	$retTabela = $obKDbo->select("*", $criteriaTab);
    	$obtabela = $retTabela->fetchObject();
    	
    	$obKDbo->setEntidade('campos');
    		$criteriCamp = new TCriteria();
    		$criteriCamp->add(new TFilter('tabseq','=',$obtabela->seq, 'numeric'), 'AND');
    		$criteriCamp->add(new TFilter('ativapesquisa','!=',0, 'numeric'));
    	$retCampo = $obKDbo->select("*", $criteriCamp);
    	
    	while($obCampo = $retCampo->fetchObject()){
	    	$obKDbo->setEntidade('lista');
		    	$criteriLista = new TCriteria();
		    	$criteriLista->add(new TFilter('seq','=',$obCampo->ativapesquisa, 'numeric'), 'AND');
		    	$criteriLista->add(new TFilter('tipo','=','pesq', 'string'));
		    $retLista = $obKDbo->select("*", $criteriLista);
	    	$obLista = $retLista->fetchObject();
	    	
	    	$colPesq = explode(',',$obLista->pesquisa);
	    	$colunaFK = explode('=',$colPesq[1]);
	    	$colunaDesc = explode('=',$colPesq[0]);
	    		    	
	    		//Retorna a entidade da pesquisa
		    	$obKDbo->setEntidade('tabelas');
		    		$criteriaTabPesq = new TCriteria();
		    		$criteriaTabPesq->add(new TFilter('seq','=',$obLista->tabseq, 'numeric'));
		    	$retTabelaPesq = $obKDbo->select("*", $criteriaTabPesq);
		    	$obTabelaPesq = $retTabelaPesq->fetchObject();
		    	
		    	if($obTabelaPesq->tabela != $obTabelaPesq->tabela_view){
		    		$entidadePesq = $obTabelaPesq->tabela_view;
		    	}else{
		    		$entidadePesq = $obTabelaPesq->tabela;
		    	}
		    	
		    	$dbo = new TDbo($entidadePesq);
		    		$criteriaDoc = new TCriteria();
		    		$criteriaDoc->add(new TFilter('seq', '=', $dados[$colunaFK[0]],'numeric'));
		    	$retDocumento = $dbo->select($colunaDesc[1],$criteriaDoc);
		    	$colunaDescPesq = $retDocumento->fetchObject();
	    	
		    	$dadosColPesq[$colunaDesc[0]] = $colunaDescPesq->$colunaDesc[1];
    	}
    	
    	return $dadosColPesq;
    }

    /*
    *
    */
    public function get() {
        return $this->dados;
    }

}
