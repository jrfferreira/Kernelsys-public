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
     * param $entidade = entidade(tabela) alvo da aÃ§Ã£o
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

                    if(is_null($this->dados) || !array_key_exists($ec, $this->dados)){
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
        $criteria->add(new TFilter($coluna, '=', $seq));

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

    /*
    *
    */
    public function get() {
        return $this->dados;
    }

}
