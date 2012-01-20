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
     * param $codigo = Codigo do registro na base de dados
     * param $tipo = tipo de formulário (form/bloco)
     * param $entidade = entidade(tabela) alvo da ação
     */
    public function __construct($idForm, $codigo, $tipo, $entidade = NULL) {

        $this->idForm = $idForm;

            //retorna o cabeçalho do formulário
            $this->obHeaderForm = new TSetHeader();
            $this->headerForm = $this->obHeaderForm->getHead($this->idForm);

        $this->ent    = $entidade;
        $this->codigoReg  = $codigo;

        if($this->codigoReg) {

            $this->entidades[$this->ent] = $this->ent;

            $this->dados = $this->load($this->ent,$this->codigoReg,$this->campoChave);
            if($tipo == 'form') {
                $this->setDados($this->idForm);
            }
        }

    }

    /**
     * Congura vetor de entidades com a lista das entidades
     * que se relacionam em order pir->filhos
     * param <id> $idForm = id do formulario que contem o relacionamento
     */
    private function setRelations($idForm) {

        try {
        		$tableExists = false;
                $tKrs = new TKrs('form_x_tabelas');
                $criterio = new TCriteria();
                $criterio->add(new TFilter('formid','=',$idForm));
                $criterio->add(new TFilter('ativo','=','1'));
                $formTables = $tKrs->select('*',$criterio);
                	
                $tKrs->setEntidade('tabelas');
                $criterioTabela = new TCriteria();
                while($ft = $formTables->fetchObject()){
                	$tableExists = true;
                	$criterioTabela->add(new TFilter('id','=',$ft->tabelaid),'OR');
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
     * param $idForm = id do formulario pai do relacionamento (form_x_tabelas)
     */
    public function setDados($idForm) {

        $this->setRelations($idForm);

        foreach($this->entidades as $k=>$entity) {

            $sDados = $this->Load($entity, $this->codigoReg);

            if($sDados) {// verifica se há registro no vetor
                foreach($sDados as $ec=>$ev) {

                    if(!array_key_exists($ec, $this->dados)){
                         $this->dados[$ec] = $ev;
                    }
                }
            }
        }

    }

    /**
    * método delete()
    *  Excluir um conjunto de objetos (collection) da base de dados
    *  através de um critério de seleção.
    *  param $criteria = objeto do tipo TCriteria
    */
    public function delete() {
            $dbo = new TDbo($this->ent);
            $dbo->delete($this->codigoReg, $colunafilho);
    }

    /**
     * método load()
     *  Recupera (retorna) um objeto da base de dados
     *  atrav�s de seu ID e instancia ele na memória
     *  param $codigo = ID do objeto
     */
    public function load($entidade, $codigo) {

        $colunafilho = $this->setColuna($entidade);

        // cria critério de seleção baseado no ID
        $criteria = new TCriteria;
        $criteria->add(new TFilter($colunafilho, '=', $codigo));

        $loadDbo = new TDbo($entidade);
        $result = $loadDbo->select('*', $criteria);

        // se retornou algum dado
        if ($result) {
            // retorna os dados em forma de vetor
            while($objeto = $result->fetch(PDO::FETCH_ASSOC)) {
                $obj[$objeto['codigo']] = $objeto;
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

       if($entidade == $this->headerForm['entidade']){
          $colunafilho = "codigo";
       }else{
          $colunafilho = $this->headerForm['colunafilho'];
       }

       return $colunafilho;
    }

    /*
    *
    */
    public function get() {
        return $this->dados;
    }

}

//$ob = new TDados(1);
//print_r($ob->get());

?>