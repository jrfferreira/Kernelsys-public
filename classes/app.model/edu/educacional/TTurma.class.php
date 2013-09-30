<?php
/**
 * Classe turma
 * @author Wagner Borba
 * @date 20/01/2010
*/


class TTurma {

    private $obTDbo = NULL;
    private $obTurma = NULL;
    private $obTurmaDisciplinas = array();

    /**
     * Retorna um objeto turma complento
     * param <codigo> $codigoturma = codigo da turma
     */
    public function getTurma($codigoturma, $disciplinas = true, $fullObject = true) {
        try {
            $this->obTDbo = new TDbo();
            if($codigoturma) {

                $this->obTDbo->setEntidade(TConstantes::DBTURMA);
                $criteria = new TCriteria();
                $criteria->add(new TFilter('seq','=',$codigoturma));
                $retTurma = $this->obTDbo->select("*", $criteria);
                $this->obTurma = $retTurma->fetchObject();

                //retorna informações do curso
                $curso = new TCurso();
                $obCurso = $curso->getCurso($this->obTurma->cursseq);

                if($obCurso->seq) {
                    $this->obTurma->turmseq = $this->obTurma->seq;
                    $this->obTurma->nomecurso = $obCurso->nome;
                    $this->obTurma->publicoalvo = $obCurso->publicoalvo;
                    $this->obTurma->tpcuseq = $obCurso->tpcuseq;
                    $this->obTurma->arcuseq = $obCurso->arcuseq;
                }else {
                    throw new ErrorException("o curso não foi encontrado.");
                }

                if($disciplinas){
                    $this->obTurma->disciplinas = $this->getTurmaDiciplinas($codigoturma, null, $fullObject);
                }
                
                $this->obTurma->labelStatus = $this->getStatus($this->obTurma->statseq);

                $this->obTDbo->close();

                return $this->obTurma;
            }else {
                throw new ErrorException($codigoturma." O codigo da turma é invalido.");
            }
        }catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
    }
    
    /**
     * Gera chequebox na lista de disciplinas.
     * @param INT $formseq = Id do formulario em quest�o.
     */
    public function buttonAddTurmaDisciplina($formseq){

        $div = new TElement('div');
        $div->id = 'ret_addTurmaDisciplinas';
        $button = new TElement('input');
        $button->id = "addTurmaDisciplinas";
        $button->type = "button";
        $button->onclick = "addAllDisciplinasTurma('ret_addTurmaDisciplinas','$formseq')";
        $button->class = "ui-state-default ui-corner-all";
        $button->title = 'Adicionar os Registros Selecionados';
        $button->value = "Adicionar os Registros Selecionados";

        $div->style = "text-align: center; padding: 5px;";
        $div->class = "ui-widget-content";
        $div->add($button);
        return $div;
    }

    /**
     * Retorna a lista de objetos Requisitos
     * param <type> $codigoturma
     */
    public function getRequisitos($codigoturma) {

        try {
            if(!$codigoturma){
                throw new ErrorException("O codigo da turma é inválido. getRequisitos");
            }

                $obDbo = new TDbo(TConstantes::DBREQUISITO_TURMA);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('turmseq','=',$codigoturma));
                $retRequisitos = $obDbo->select('*', $criteria);

                $objs = NULL;
                while($objs = $retRequisitos->fetchObject()) {
                    $requisitos[$objs->seq] = $objs;
                }

                //Valida existencia das disciplinas na turma ===================
                if(count($requisitos) == 0) {
                    $requisitos = null;
                }
                //==============================================================

        }catch (Exception $e) {
            new setException($e);
        }
        return $requisitos;
    }

    /**
     * Retorna a lista de objetos TurmaConvenios
     * param <type> $codigoturma
     */
    public function getTurmaConvenios($codigoturma) {

        try {
            if($codigoturma) {
                $obDbo = new TDbo(TConstantes::DBTURMA_CONVENIO);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('turmseq','=',$codigoturma));
                $retTurmaDescontos = $obDbo->select("*", $criteria);

                $objs = NULL;
                while($objs = $retTurmaDescontos->fetchObject()) {
                    $descontos[] = $objs;
                }

                //Valida existencia de descontos na turma ===================
                if(count($descontos) == 0) {
                    $descontos = false;
                }
                //==============================================================
            }else {
                throw new ErrorException("O codigo da turma [ $codigoturma ] é inválido.");
            }
        }catch (Exception $e) {
            new setException($e);
        }
        return $descontos;
    }
    
    /**
    * Retorna turma disciplina de acordo com o codigo
    * da turma e da disciplina
    */
    public function getTurmaDisciplina($codigoturma, $codigodisciplina){
        try {
            if($codigoturma and $codigodisciplina) {

                $obDbo = new TDbo(TConstantes::DBTURMA_DISCIPLINA);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('turmseq','=',$codigoturma));
                    $criteria->add(new TFilter('discseq','=',$codigodisciplina));
                $retTurmaDisciplinas = $obDbo->select('*', $criteria);
                //objeto disciplina
                $obTurmaDiscplina = $retTurmaDisciplinas->fetchObject();

                if($obTurmaDiscplina){
                    return $obTurmaDiscplina;
                }else{
                    return null;
                }

            }else{
                throw new Exception(TMensagem::ERRO_VALOR_INVALIDO);
            }

        }catch (Exception $e) {
            new setException($e);
        }
    }
    /**
     * Retorna a lista de objetos TurmaDescontos
     * param <type> $codigoturma
     */
    public function getTurmaDescontos($codigoturma) {

        try {
            if($codigoturma) {
                $obDbo = new TDbo(TConstantes::VIEW_TURMA_CONVENIO_DESCONTO);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('turmseq','=',$codigoturma));
                    $criteria->setProperty('order','dialimite');
                $retTurmaDescontos = $obDbo->select("*", $criteria);

                $objs = NULL;
                while($objs = $retTurmaDescontos->fetchObject()) {
                    $descontos[] = $objs;
                }

                //Valida existencia de descontos na turma ===================
                if(count($descontos) == 0) {
                    $descontos = false;
                }
                //==============================================================
            }else {
                throw new ErrorException("O codigo da turma [ $codigoturma ] é inválido.");
            }
        }catch (Exception $e) {
            new setException($e);
        }
        return $descontos;
    }

    /**
     * Retorna a lista de objetos turmaDiciplinas
     * param <type> $codigoturma
     */
    public function getDiciplinas($codigoturma) {

        try {
            if($codigoturma) {

                if(!$cols) {
                    $cols = "*";
                }
                $obDbo = new TDbo(TConstantes::DBTURMA_DISCIPLINA);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('turmseq','=',$codigoturma));
                $retTurmaDisciplinas = $obDbo->select($cols, $criteria);

                //objeto disciplina
                $obDiscplina = new TTurmaDisciplinas();
                $objs = NULL;

                while($objs = $retTurmaDisciplinas->fetchObject()) {
                    $disciplinas[$objs->discseq] = $objs->discseq;
                }

                //Valida existencia das disciplinas na turma ===================
                if(count($disciplinas) == 0) {
                    $disciplinas = false;
                }
                //==============================================================

            }else {
                throw new ErrorException("O codigo da turma é inválido.");
            }
        }catch (Exception $e) {
            new setException($e);
        }
        return $disciplinas;
    }
    /**
     * Retorna a lista de objetos turmaDiciplinas
     * param <type> $codigoturma
     */
    public function getTurmaDiciplinas($codigoturma, $cols = NULL, $fullObject = true) {

        try {
            if($codigoturma) {

                if(!$cols) {
                    $cols = "*";
                }
                $obDbo = new TDbo(TConstantes::DBTURMA_DISCIPLINA);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('turmseq','=',$codigoturma));
                $retTurmaDisciplinas = $obDbo->select($cols, $criteria);

                //objeto disciplina
                $obDiscplina = new TTurmaDisciplinas();
                $objs = NULL;

                $lista = array();
                while($objs = $retTurmaDisciplinas->fetchObject()) {
                    if($objs->seq)
                        $lista[] = $objs->seq;
                }

                if(count($lista) > 0){
                	$disciplinas = $obDiscplina->getListaTurmaDisciplina($lista,$fullObject);
                }

                //Valida existencia das disciplinas na turma ===================
                if(count($disciplinas) == 0) {
                    $disciplinas = false;
                }
                //==============================================================

            }else {
                throw new ErrorException("O seq da turma é inválido.");
            }
        }catch (Exception $e) {
            new setException($e);
        }
        return $disciplinas;
    }

    /**
     * Retorna um vetor contendo uma lista de objetos turma
     */
    public function listaTurmas($codigoturma) {
        try {

        }catch (Exception $e) {
            new setException($e);
        }
    }
    /**
    * Retorna o status atual da turma
    * param <type> $status
    */
    public function getStatus($status){
        switch($status){
            case 1:
                $retorno = "Aberta";
                break;
            case 2:
                $retorno = "Adiada";
                break;
            case 3:
                $retorno = "Cancelada";
                break;
            case 4:
                $retorno = "Concluida";
                break;
            case 5:
                $retorno = "Em Andamento";
                break;
            default:
                $retorno = "Não definido";
                break;
        }
        return $retorno;
    }
     /**
     *
     * @param string $formseq
     */
    public function addTurmaDisciplina($formseq){
    	
        $obCurso = false;
        $obHeader = new TSetHeader();
        $headerForm = $obHeader->getHead($formseq);

        $data['turmseq'] = $obHeader->getHead($headerForm['frmpseq'],'codigoPai');
        $data['statseq'] = '1';

        $headerLista = $obHeader->getHead($headerForm['idLista'],'listaSelecao');
        $TurmaDiciplinas = $this->getDiciplinas($data['turmseq']);

        $dbo = new TDbo(TConstantes::DBCURSO_DISCIPLINA);
        $crit = new TCriteria();
        foreach($headerLista as $ch=>$vl){
            $var = new TFilter('seq','=',$vl);
            $crit->add($var,'OR');
        }
        $retDiscs = $dbo->select('seq,cursseq,discseq',$crit);

       while($vl = $retDiscs->fetchObject()){
           $codigoCurso = $vl->cursseq;
           if(!$obCurso){
               $TCurso = new TCurso();
               $obCurso = $TCurso->getCurso($codigoCurso, false);
               $data['gdavseq'] = $obCurso->gdavseq;
           }
           if(!$TurmaDiciplinas[$vl->discseq]){
               $data['discseq'] = str_replace(array('[',']','"',"'"), '', $vl->discseq);
               $dboDisciplina = new TDbo(TConstantes::DBTURMA_DISCIPLINA);
               $ret = $dboDisciplina->insert($data);

               $discs_av[] = $ret['seq'];
           }
        }
        
        $cont = count($discs_av);
        
        if($cont > 1){
        	$plural = 's';
        }else{
        	$plural = '';
        }
        
        if($cont == 0){
        	$cont = "Nenhuma";
        }
        return $cont." disciplina{$plural} adicionada{$plural} com sucesso.";
    }
    /**
     * Calcura, atualiza e retorna a carga horaria da turma
     * * param <codigo> $codigoturma = codigo da turma
     */
    public function getCargaHoraria($codigoturma) {

        try {
            if($codigoturma) {

                $soma = 0;
                $disciplinas = $this->getTurmaDiciplinas($codigoturma);
                if($disciplinas) {
                    foreach($disciplinas as $codigo=>$obDc) {
                        $soma = $soma+$obDc->cargahoraria;
                    }
                }

                $obDto = new TDbo(TConstantes::DBTURMA);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('seq','=',$codigoturma));
                $obDto->update(array("cargahoraria"=>$soma), $criteria);

                $divLabel = new TElement('div');
                $divLabel->class = "ui-state-highlight";
                $divLabel->style = "padding:5px;";
                $divLabel->align = "right";
                $divLabel->add("Total de horas: ".$soma);

            }else {
                throw new ErrorException("O codigo da turma é inválido.");
            }

        }catch (Exception $e) {
            new setException($e);
        }

        return $divLabel;
    }

    /**
     *
     * param <type> $formseq
     */
    public function setProduto($formseq){
        try{

            if(!$formseq){
                throw new ErrorException("Ouve um problema na geração o produto da turma. Entre em contato com o suporte.", 1);
            }

           $obHeader = new TSetHeader();
           $headerForm = $obHeader->getHead($formseq);

             $produtoTurma = new TProduto();
             $codigoproduto = $produtoTurma->setProdutoParametro($formseq);

             //Insere o codigo do produto na especialização======================================
            $dadosUpdate['prodseq'] = $codigoproduto;
            $dboUpdateProduto = new TDbo(TConstantes::DBTURMA);
                $criteriaUpdate = new TCriteria();
                $criteriaUpdate->add(new TFilter("seq", "=", $headerForm['seq']));
            $updateProdutoTurma = $dboUpdateProduto->update($dadosUpdate, $criteriaUpdate);

            if(!$updateProdutoTurma){
                $dboUpdateProduto->rollback();
                throw new ErrorException("O codigo dó produto não pode ser atualizado.", 1);
            }
            //==================================================================================

            //gera taxa de inscrição
            $this->setTaxaInscricao($headerForm['seq']);

        }catch (Exception $e){
            new setException($e);
        }
    }

    /**
    * Gera um produto caso seja necessario no ato da conclusão da turma
    * param <type> $codigo
    * param <type> $tabela
    */
    public function setTaxaInscricao($codigoTurma) {

        try{

            if(!$codigoTurma){
                throw new ErrorException("Ouve um problema na geração da taxa de inscrição relacionada a truma. Entre em contato com o suporte.", 1);
            }

            $dbo = new TDbo();

            //configura produto taxa de inscrição
            $dbo->setEntidade(TConstantes::DBTURMA);
                $criteriaTurma = new TCriteria();
                $criteriaTurma->add(new TFilter('seq','=',$codigoTurma));
            $retTurma = $dbo->select('seq, valortaxa, titulo, prodseq', $criteriaTurma);
            $obTurma = $retTurma->fetchObject();

            //configura produto taxa de inscrição
            $dbo->setEntidade(TConstantes::DBPRODUTO);
                $criteriaProduto = new TCriteria();
                $criteriaProduto->add(new TFilter('tabela','=',$codigoTurma));
            $retProduto =$dbo->select('seq', $criteriaProduto);
            $obProduto = $retProduto->fetchObject();
            $dbo->close();
            
                if(!$obProduto->seq and $obTurma->valortaxa and $obTurma->valortaxa > 0){

                    $prodTaxa = new TProduto();
                        $prodTaxa->setValue('label', 'Taxa de inscrição');
                        $prodTaxa->setValue('valor', $obTurma->valortaxa);
                        $prodTaxa->setValue('descricao', 'Taxa de inscrição relacionada a turma: '.$obTurma->titulo);
                        $prodTaxa->setValue('valoralteravel', '0');
                        $prodTaxa->setValue('tabela', $obTurma->codigo);
                        $prodTaxa->setValue('ativo', '1');
                     $prodTaxa->addProduto();
                }

        }catch (Exception $e) {
            new setException($e);
        }
    }

    /**
    * Retorna as opções de turmas abertas para o curso escolhido
    * param <type> $codigocurso
    */
    public function setOptionSelect($codigocurso){
        try{

                $obTDbo = new TDbo(TConstantes::VIEW_TURMA);
                $criteria = new TCriteria();
                $criteria->add(new TFilter('cursseq','=',$codigocurso));
                $retTurma = $obTDbo->select("*", $criteria);

                    $option = new TElement('option');
                    $option->value = 0;
                    $option->add('Escolha a turma');
                    $option->show();
                    
                while($obTurma = $retTurma->fetchObject()){
                    $option = new TElement('option');
                    $option->value = $obTurma->seq;
                    $option->add($obTurma->titulo);
                    $option->show();
                }

        }catch (Exception $e) {
            new setException($e);
        }
    }
    /**
    * Retorna o tipo de desconto progressivo na Turma
    * param <type> $status
    */
    public function getTipoDesconto($status){
        switch($status){
            case 1:
                $retorno = "Valor Percentual";
                break;
            case 2:
                $retorno = "Valor Fixo";
                break;
        }
        return $retorno;
    }


    public function getCursoSeq($idLista){
        $header = new TSetHeader();
        //$headerLista = $header->getHead($idLista,'formseq');
        //$headerForm = $header->getHead($headerLista,'frmpseq');
        //$headerForm = $header->getHead($headerForm,'frmpseq');
        $headerForm = $header->getHead('5','camposSession');
        return $headerForm['cursseq']['valor'];
    }
}