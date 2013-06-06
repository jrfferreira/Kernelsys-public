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

                $this->obTDbo->setEntidade(TConstantes::DBTURMAS);
                $criteria = new TCriteria();
                $criteria->add(new TFilter('codigo','=',$codigoturma));
                $retTurma = $this->obTDbo->select("*", $criteria);
                $this->obTurma = $retTurma->fetchObject();

                //retorna informações do curso
                $curso = new TCurso();
                $obCurso = $curso->getCurso($this->obTurma->codigocurso);

                if($obCurso->codigo) {
                    $this->obTurma->codigoturma = $this->obTurma->codigo;
                    $this->obTurma->nomecurso = $obCurso->nome;
                    $this->obTurma->publicoalvo = $obCurso->publicoalvo;
                    $this->obTurma->codigotipocurso = $obCurso->tipocurso;
                    $this->obTurma->codigoareacurso = $obCurso->areacurso;
                }else {
                    throw new ErrorException("o curso não foi encontrado.");
                }

                if($disciplinas){
                    $this->obTurma->disciplinas = $this->getTurmaDiciplinas($codigoturma, null, $fullObject);
                }
                
                $this->obTurma->labelStatus = $this->getStatus($this->obTurma->status);

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
     * @param INT $idForm = Id do formulario em quest�o.
     */
    public function buttonAddTurmaDisciplina($idForm){

        $div = new TElement('div');
        $div->id = 'ret_addTurmaDisciplinas';
        $button = new TElement('input');
        $button->id = "addTurmaDisciplinas";
        $button->type = "button";
        $button->onclick = "addAllDisciplinasTurma('ret_addTurmaDisciplinas','$idForm')";
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

                $obDbo = new TDbo(TConstantes::DBTURMAS_REQUISITOS);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('codigoturma','=',$codigoturma));
                $retRequisitos = $obDbo->select('*', $criteria);

                $objs = NULL;
                while($objs = $retRequisitos->fetchObject()) {
                    $requisitos[$objs->codigo] = $objs;
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
                $obDbo = new TDbo(TConstantes::DBTURMAS_CONVENIOS);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('codigoturma','=',$codigoturma));
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

                $obDbo = new TDbo(TConstantes::DBTURMAS_DISCIPLINAS);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('codigoturma','=',$codigoturma));
                    $criteria->add(new TFilter('codigodisciplina','=',$codigodisciplina));
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
                $obDbo = new TDbo(TConstantes::DBTURMAS_DESCONTOS);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('codigoturma','=',$codigoturma));
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
                $obDbo = new TDbo(TConstantes::DBTURMAS_DISCIPLINAS);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('codigoturma','=',$codigoturma));
                $retTurmaDisciplinas = $obDbo->select($cols, $criteria);

                //objeto disciplina
                $obDiscplina = new TTurmaDisciplinas();
                $objs = NULL;

                while($objs = $retTurmaDisciplinas->fetchObject()) {
                    $disciplinas[$objs->codigodisciplina] = $objs->codigodisciplina;
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
                $obDbo = new TDbo(TConstantes::DBTURMAS_DISCIPLINAS);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('codigoturma','=',$codigoturma));
                $retTurmaDisciplinas = $obDbo->select($cols, $criteria);

                //objeto disciplina
                $obDiscplina = new TTurmaDisciplinas();
                $objs = NULL;

                $lista = array();
                while($objs = $retTurmaDisciplinas->fetchObject()) {
                    if($objs->codigo)
                        $lista[] = $objs->codigo;
                }

                $disciplinas = $obDiscplina->getListaTurmaDisciplina($lista,$fullObject);

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
     * @param string $idForm
     */
    public function addTurmaDisciplina($idForm){
    	
        $obCurso = false;
        $obHeader = new TSetHeader();
        $headerForm = $obHeader->getHead($idForm);

        $data['codigoturma'] = $obHeader->getHead($headerForm['idFormPai'],'codigoPai');
        $data['ativo'] = '1';

        $headerLista = $obHeader->getHead($headerForm['idLista'],'listaSelecao');
        $TurmaDiciplinas = $this->getDiciplinas($data['codigoturma']);

        $dbo = new TDbo(TConstantes::DBCURSOS_DISCIPLINAS);
        $crit = new TCriteria();
        foreach($headerLista as $ch=>$vl){
            $var = new TFilter('codigo','=',$vl);
            $crit->add($var,'OR');
        }
        $retDiscs = $dbo->select('id,codigocurso,codigodisciplina',$crit);

       while($vl = $retDiscs->fetchObject()){
           $codigoCurso = $vl->codigocurso;
           if(!$obCurso){
               $TCurso = new TCurso();
               $obCurso = $TCurso->getCurso($codigoCurso, false);
               $data['codigograde'] = $obCurso->codigograde;
           }
           if(!$TurmaDiciplinas[$vl->codigodisciplina]){
               $data['codigodisciplina'] = str_replace(array('[',']','"',"'"), '', $vl->codigodisciplina);
               $dboDisciplina = new TDbo(TConstantes::DBTURMAS_DISCIPLINAS);
               $ret = $dboDisciplina->insert($data);

               $discs_av[] = $ret['codigo'];
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

                $obDto = new TDbo(TConstantes::DBTURMAS);
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('codigo','=',$codigoturma));
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
     * param <type> $idForm
     */
    public function setProduto($idForm){
        try{

            if(!$idForm){
                throw new ErrorException("Ouve um problema na geração o produto da turma. Entre em contato com o suporte.", 1);
            }

           $obHeader = new TSetHeader();
           $headerForm = $obHeader->getHead($idForm);

             $produtoTurma = new TProduto();
             $codigoproduto = $produtoTurma->setProdutoParametro($idForm);

             //Insere o codigo do produto na especialização======================================
            $dadosUpdate['codigoproduto'] = $codigoproduto;
            $dboUpdateProduto = new TDbo(TConstantes::DBTURMAS);
                $criteriaUpdate = new TCriteria();
                $criteriaUpdate->add(new TFilter("codigo", "=", $headerForm['codigo']));
            $updateProdutoTurma = $dboUpdateProduto->update($dadosUpdate, $criteriaUpdate);

            if(!$updateProdutoTurma){
                $dboUpdateProduto->rollback();
                throw new ErrorException("O codigo dó produto não pode ser atualizado.", 1);
            }
            //==================================================================================

            //gera taxa de inscrição
            $this->setTaxaInscricao($headerForm['codigo']);

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
            $dbo->setEntidade(TConstantes::DBTURMAS);
                $criteriaTurma = new TCriteria();
                $criteriaTurma->add(new TFilter('codigo','=',$codigoTurma));
            $retTurma = $dbo->select('codigo, valortaxa, titulo, codigoproduto', $criteriaTurma);
            $obTurma = $retTurma->fetchObject();

            //configura produto taxa de inscrição
            $dbo->setEntidade(TConstantes::DBPRODUTOS);
                $criteriaProduto = new TCriteria();
                $criteriaProduto->add(new TFilter('tabela','=',$codigoTurma));
            $retProduto =$dbo->select('codigo', $criteriaProduto);
            $obProduto = $retProduto->fetchObject();
            $dbo->close();
            
                if(!$obProduto->codigo and $obTurma->valortaxa and $obTurma->valortaxa > 0){

                    $prodTaxa = new TProduto();
                        $prodTaxa->setValue('label', 'Taxa de inscrição');
                        $prodTaxa->setValue('valor', $obTurma->valortaxa);
                        $prodTaxa->setValue('descricao', 'Taxa de inscrição relacionada a turma: '.$obTurma->titulo);
                        $prodTaxa->setValue('valoralteravel', '0');
                        $prodTaxa->setValue('tabela', $obTurma->codigo);
                        $prodTaxa->setValue('codigotipoproduto', '10004326-826');
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

                $obTDbo = new TDbo(TConstantes::DBTURMAS);
                $criteria = new TCriteria();
                $criteria->add(new TFilter('codigocurso','=',$codigocurso));
                $retTurma = $obTDbo->select("*", $criteria);

                    $option = new TElement('option');
                    $option->value = 0;
                    $option->add('Escolha a turma');
                    $option->show();
                    
                while($obTurma = $retTurma->fetchObject()){
                    $option = new TElement('option');
                    $option->value = $obTurma->codigo;
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


    public function getCodigoCurso($idLista){
        $header = new TSetHeader();
        //$headerLista = $header->getHead($idLista,'idForm');
        //$headerForm = $header->getHead($headerLista,'idFormPai');
        //$headerForm = $header->getHead($headerForm,'idFormPai');
        $headerForm = $header->getHead('5','camposSession');
        return $headerForm['codigocurso']['valor'];
    }
}