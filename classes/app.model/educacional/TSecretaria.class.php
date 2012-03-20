<?php

class TSecretaria {

    /**
     * Retorna o objeto [Element] correspondente as notas do aluno na turma atual
     * param <type> $codigoaluno
     */
    public function viewGetAcademico($codigoaluno) {

        try {
            if($codigoaluno) {
            	
                $TAluno = new TAluno();
                $getAcademico = $TAluno->getAcademico($codigoaluno);
                $tabHead = new TElement("fieldset");
                $tabHead->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                $tabHeadLegenda = new TElement("legend");
                $tabHeadLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                $tabHeadLegenda->add("Informações do Aluno");
                $tabHead->add($tabHeadLegenda);

                $obFieds = new TSetfields();
                $obFieds->geraCampo("Nº de Matricula:", 'matricula', "TEntry", '');
                $obFieds->setProperty('matricula', 'disabled', 'disabled');
                $obFieds->setValue("matricula", $getAcademico->aluno->codigo);

                $obFieds->geraCampo("Aluno:", 'aluno', "TEntry", '');
                $obFieds->setProperty('aluno', 'disabled', 'disabled');
                $obFieds->setProperty('aluno', 'size', '60');
                $obFieds->setValue("aluno", $getAcademico->aluno->nomepessoa);

                $obFieds->geraCampo("Curso:", 'curso', "TEntry", '');
                $obFieds->setProperty('curso', 'disabled', 'disabled');
                $obFieds->setProperty('curso', 'size', '60');
                $obFieds->setValue("curso", $getAcademico->aluno->nomecurso);

                $obFieds->geraCampo("Turma:", 'turma', "TEntry", '');
                $obFieds->setProperty('turma', 'disabled', 'disabled');
                $obFieds->setProperty('turma', 'size', '60');
                $obFieds->setValue("turma", $getAcademico->aluno->nometurma);

                $content = new TElement('div');
                $content->class = "ui_bloco_conteudo";
                $content->add($obFieds->getConteiner());
                $tabHead->add($content);

                $disciplinas = new TElement("fieldset");
                $disciplinas->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                $disciplinasLegenda = new TElement("legend");
                $disciplinasLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                $disciplinasLegenda->add("Disciplinas");
                $disciplinas->add($disciplinasLegenda);

                $datagrid = new TDataGrid();

                $datagrid->addColumn(new TDataGridColumn('disciplina', 'Disciplina', 'left', '300px'));
                $datagrid->addColumn(new TDataGridColumn('professor', 'Professor', 'center', '200px'));
                $datagrid->addColumn(new TDataGridColumn('media', 'Média', 'center', '100px'));
                $datagrid->addColumn(new TDataGridColumn('frequencia', 'Frequência', 'center', '100px'));
                $datagrid->addColumn(new TDataGridColumn('situacao', 'Situaçao', 'center', '100px'));
                $datagrid->createModel('100%');

                foreach($getAcademico->academico->disciplinas as $key => $obDisc) {
                    $tempDisc['disciplina'] = $obDisc->nomedisciplina;
                     if($obDisc->cargahoraria){
                        $tempDisc['disciplina'] .= " ({$obDisc->cargahoraria} hs)";
                    }
                    $tempDisc['professor'] = $obDisc->nomeprofessor;
                    $media = new TElement('div');
                    if ($obDisc->aprovacaonotas) {
                        $media->class = 'ui-state';
                    } else {
                        $media->class = 'red-text';
                    }
                    $media->add($obDisc->media ? $obDisc->media : '--');
                    $tempDisc['media'] = $media;
                    $frequencia = new TElement('div');
                    if ($obDisc->aprovacaofrequencias) {
                        $frequencia->class = 'ui-state';
                    } else {
                        $frequencia->class = 'red-text';
                    }
                    $frequencia->add($obDisc->frequencia ? $obDisc->frequencia."%" : '--');
                    $tempDisc['frequencia'] = $frequencia;
                    $tempDisc['situacao'] = $obDisc->situacao;
                    $datagrid->addItem($tempDisc);
                }
                $content = new TElement('div');
                $content->class = "ui_bloco_conteudo";
                $content->add($datagrid);
                $disciplinas->add($content);


                $obAluno = new TElement('div');
                $obAluno->add($tabHead);
                $obAluno->add($disciplinas);

            }else {
                throw new ErrorException("O codigo ".$codigoaluno." não é referente a um aluno valido. [TSecretaria - 96]");
            }
        }catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }

        return $obAluno;
    }

    /**
     * Retorna o objeto [Element] correspondente as notas do aluno
     * param <type> $codigoaluno
     */
    public function viewGetAcademicoCompleto($codigoaluno) {

        try {
            if($codigoaluno) {
                $TAluno = new TAluno();
                $getAcademico = $TAluno->getAcademico($codigoaluno,'all');
                $tabHead = new TElement("fieldset");
                $tabHead->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                $tabHeadLegenda = new TElement("legend");
                $tabHeadLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                $tabHeadLegenda->add("Informações do Aluno");
                $tabHead->add($tabHeadLegenda);

                $obFieds = new TSetfields();
                $obFieds->geraCampo("Nº de Matricula:", 'matricula', "TEntry", '');
                $obFieds->setProperty('matricula', 'disabled', 'disabled');
                $obFieds->setValue("matricula", $getAcademico->aluno->codigo);

                $obFieds->geraCampo("Aluno:", 'aluno', "TEntry", '');
                $obFieds->setProperty('aluno', 'disabled', 'disabled');
                $obFieds->setProperty('aluno', 'size', '60');
                $obFieds->setValue("aluno", $getAcademico->aluno->nomepessoa);

                $obFieds->geraCampo("Curso:", 'curso', "TEntry", '');
                $obFieds->setProperty('curso', 'disabled', 'disabled');
                $obFieds->setProperty('curso', 'size', '60');
                $obFieds->setValue("curso", $getAcademico->aluno->nomecurso);

                $obFieds->geraCampo("Turma:", 'turma', "TEntry", '');
                $obFieds->setProperty('turma', 'disabled', 'disabled');
                $obFieds->setProperty('turma', 'size', '60');
                $obFieds->setValue("turma", $getAcademico->aluno->nometurma);

                $content = new TElement('div');
                $content->class = "ui_bloco_conteudo";
                $content->add($obFieds->getConteiner());
                $tabHead->add($content);

                $disciplinas = new TElement("fieldset");
                $disciplinas->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                $disciplinasLegenda = new TElement("legend");
                $disciplinasLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                $disciplinasLegenda->add("Disciplinas");
                $disciplinas->add($disciplinasLegenda);

                $datagrid = new TDataGrid();

                $datagrid->addColumn(new TDataGridColumn('disciplina', 'Disciplina', 'left', '300px'));
                $datagrid->addColumn(new TDataGridColumn('professor', 'Professor', 'center', '200px'));
                $datagrid->addColumn(new TDataGridColumn('media', 'Média', 'center', '100px'));
                $datagrid->addColumn(new TDataGridColumn('frequencia', 'Frequência', 'center', '100px'));
                $datagrid->addColumn(new TDataGridColumn('situacao', 'Situaçao', 'center', '100px'));
                $datagrid->createModel('100%');

                foreach($getAcademico->academico->disciplinas as $key => $obDisc) {
                    $tempDisc['disciplina'] = $obDisc->nomedisciplina;
                    $tempDisc['professor'] = $obDisc->nomeprofessor;
                    $media = new TElement('div');
                    $media->add($obDisc->media ? $obDisc->media : '--');
                    $tempDisc['media'] = $media;
                    $frequencia = new TElement('div');
                    $frequencia->add($obDisc->frequencia ? $obDisc->frequencia."%" : '--');
                    $tempDisc['frequencia'] = $frequencia;
                    $tempDisc['situacao'] = $obDisc->situacao;
                    $datagrid->addItem($tempDisc);
                }
                $content = new TElement('div');
                $content->class = "ui_bloco_conteudo";
                $content->add($datagrid);
                $disciplinas->add($content);


                $obAluno = new TElement('div');
                $obAluno->add($tabHead);
                $obAluno->add($disciplinas);

            }else {
                throw new ErrorException("O codigo ".$codigoaluno." não é referente a um aluno valido. [TSecretaria - 187]");
            }
        }catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }

        return $obAluno;
    }

    /**
     * Retorna o objeto [Element] correspondente as notas dos alunos da disciplina
     * param <type> $codigoDisciplina
     */
    public function viewGetAcademicoDisciplina($codigoTurmaDisciplina) {

        try {
            if($codigoTurmaDisciplina) {
            	
                $TTurmaDisciplina = new TTurmaDisciplinas();
                $obDisciplina   = $TTurmaDisciplina->getTurmaDisciplina($codigoTurmaDisciplina);
                
                $tabHead = new TElement("fieldset");
                $tabHead->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                $tabHeadLegenda = new TElement("legend");
                $tabHeadLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                $tabHeadLegenda->add("Informações da Disciplina");
                $tabHead->add($tabHeadLegenda);

                $obFieds = new TSetfields();
                $obFieds->geraCampo("Curso:", 'curso', "TEntry", '');
                $obFieds->setProperty('curso', 'disabled', 'disabled');
                $obFieds->setProperty('curso', 'size', '60');
                $obFieds->setValue("curso", $obDisciplina->nomecurso);

                $obFieds->geraCampo("Turma:", 'turma', "TEntry", '');
                $obFieds->setProperty('turma', 'disabled', 'disabled');
                $obFieds->setProperty('turma', 'size', '60');
                $obFieds->setValue("turma", $obDisciplina->nometurma);

                $obFieds->geraCampo("Disciplina:", 'disciplina', "TEntry", '');
                $obFieds->setProperty('disciplina', 'disabled', 'disabled');
                $obFieds->setProperty('disciplina', 'size', '60');
                $obFieds->setValue("disciplina", $obDisciplina->nomedisciplina);
                $content = new TElement('div');

                $content->class = "ui_bloco_conteudo";
                $content->add($obFieds->getConteiner());
                $tabHead->add($content);

                $disciplinas = new TElement("fieldset");
                $disciplinas->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                $disciplinasLegenda = new TElement("legend");
                $disciplinasLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                $disciplinasLegenda->add("Disciplinas");
                $disciplinas->add($disciplinasLegenda);

                $datagrid = new TDataGrid();

                $datagrid->addColumn(new TDataGridColumn('matricula', 'Matrícula', 'center', '100px'));
                $datagrid->addColumn(new TDataGridColumn('aluno', 'Aluno', 'left', '350px'));
                $datagrid->addColumn(new TDataGridColumn('media', 'Média', 'center', '100px'));
                $datagrid->addColumn(new TDataGridColumn('frequencia', 'Frequência', 'center', '100px'));
                $datagrid->addColumn(new TDataGridColumn('situacao', 'Situaçao', 'center', '100px'));
                $datagrid->createModel('100%');

/*				$obAlunos = $TTurmaDisciplina->getAlunos($codigoTurmaDisciplina,'all');
                foreach($obAlunos as $codigoaluno => $aluno) {
                	
	                $TAluno = new TAluno();
	                $getAcademico = $TAluno->getAcademico($codigoaluno);
	                $obDisc = $getAcademico->academico->disciplinas[$codigoTurmaDisciplina];
	                    $tempDisc['matricula'] = $aluno->codigo;
	                    $tempDisc['aluno'] = $aluno->nomepessoa;
	
	                    $media = new TElement('div');
	                    if ($obDisc->aprovacaonotas) {
	                        $media->class = 'ui-state';
	                    }else {
	                        $media->class = 'ui-state-error';
	                    }
	                    $media->add($obDisc->media ? $obDisc->media : '--');
	                    $tempDisc['media'] = $media;
	                    $frequencia = new TElement('div');
	                    if ($obDisc->aprovacaofrequencias) {
	                        $frequencia->class = 'ui-state';
	                    }else {
	                        $frequencia->class = 'ui-state-error';
	                    }
	                    $frequencia->add($obDisc->frequencia ? $obDisc->frequencia."%" : '--');
	                    $tempDisc['frequencia'] = $frequencia;
	                    $tempDisc['situacao'] = $obDisc->situacao;
	                    $datagrid->addItem($tempDisc);
	                    
                }*/
                
                $content = new TElement('div');
                $content->class = "ui_bloco_conteudo";
                $content->add($datagrid);
                $disciplinas->add($content);


                $obAluno = new TElement('div');
                $obAluno->add($tabHead);
                $obAluno->add($disciplinas);

            }else {
                throw new ErrorException("O codigo ".$codigoaluno." não é referente a um aluno valido. [TSecretaria - 291]");
            }
            
        }catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }

        return $obAluno;
    }
    
    /**
     * Retorna o objeto [Element] correspondente as notas dos alunos da disciplina
     * param <type> $codigoDisciplina
     */
    public function viewRelatorioNotas($codigoTurma) {

        try {
            if($codigoTurma) {
            	
                $TTurma  = new TTurma();
                $obTurma = $TTurma->getTurma($codigoTurma, false);
                
                $tabHead = new TElement("fieldset");
                $tabHead->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                $tabHeadLegenda = new TElement("legend");
                $tabHeadLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                $tabHeadLegenda->add("Informações da Disciplina");
                $tabHead->add($tabHeadLegenda);

                $obFieds = new TSetfields();
                $obFieds->geraCampo("Curso:", 'curso', "TEntry", '');
                $obFieds->setProperty('curso', 'disabled', 'disabled');
                $obFieds->setProperty('curso', 'size', '60');
                $obFieds->setValue("curso", $obTurma->nomecurso);

                $obFieds->geraCampo("Turma:", 'turma', "TEntry", '');
                $obFieds->setProperty('turma', 'disabled', 'disabled');
                $obFieds->setProperty('turma', 'size', '60');
                $obFieds->setValue("turma", $obTurma->titulo);
                
                $content = new TElement('div');
                $content->class = "ui_bloco_conteudo";
                $content->add($obFieds->getConteiner());
                $tabHead->add($content);

                $disciplinas = new TElement("fieldset");
                $disciplinas->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                $disciplinasLegenda = new TElement("legend");
                $disciplinasLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                $disciplinasLegenda->add("Disciplinas");
                $disciplinas->add($disciplinasLegenda);
                            
                
                //Cria colunas com as diciplinas
                $listaTurmaDisciplinas = $TTurma->getTurmaDiciplinas($obTurma->codigo);
                
                $datagrid = new TDataGrid();
                $datagrid->addColumn(new TDataGridColumn('alunos', 'Alunos', 'left', '200px'));
                foreach($listaTurmaDisciplinas as $codigoTurmaDisciplinas => $obTurmaDisciplinas){
 
	                $datagrid->addColumn(new TDataGridColumn($obTurmaDisciplinas->nomedisciplina, $obTurmaDisciplinas->nomedisciplina, 'center', '200px'));
                }
                $datagrid->createModel('100%');
                
                $TAluno = new TAluno();
                	//monta criteria de retorno do aluno.
                	$criteriaAluno = new TCriteria();
                	$criteriaAluno->add(new TFilter('codigoturma','=',$obTurma->codigo));
               	$listaAlunos = $TAluno->getAlunos($criteriaAluno);
               	
               	$TAvaliacao = new TAvaliacao();
               	
                foreach($listaAlunos as $codigoaluno => $aluno) {

	                $alunoNotas = $TAluno->listaNotas($codigoaluno);	                
	                
	                    $tempDisc['alunos'] = $aluno->nomepessoa;
	                    foreach($listaTurmaDisciplinas as $codigoTurmaDisciplina => $obTurmaDisciplinas){
	                    	
	                    	foreach($alunoNotas as $obNota){
	                    		if($codigoTurmaDisciplina == $obNota->codigoturmadisciplina){
	                    			$notas = $notas.' '.$obNota->avaliacao.': '.$obNota->nota;
	                    		}
	                    	}
	                    	$tempDisc[$obTurmaDisciplinas->nomedisciplina] = $notas;
	                    	$notas="";
	                    }
	                    
	                    $datagrid->addItem($tempDisc);
	                    
                }
                
                $content = new TElement('div');
                $content->class = "ui_bloco_conteudo";
                $content->add($datagrid);
                $disciplinas->add($content);


                $obAluno = new TElement('div');
                $obAluno->add($tabHead);
                $obAluno->add($disciplinas);
                
                $obAluno->show();

            }else {
                throw new ErrorException("O codigo ".$codigoaluno." não é referente a um aluno valido. [TSecretaria - 291]");
            }
            
        }catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }

        return $obAluno;
    }
    
    /**
     * Retorna o objeto [Element] correspondente as contas do aluno
     * param <type> $codigoaluno
     */
    public function viewGetFinanceiro($codigoaluno) {
        try {
            if($codigoaluno){
                $TAluno = new TAluno();
                $getFinanceiro = $TAluno->getFinanceiro($codigoaluno);

                $tabHead = new TElement("fieldset");
                $tabHead->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                $tabHeadLegenda = new TElement("legend");
                $tabHeadLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                $tabHeadLegenda->add("Informações do Aluno");
                $tabHead->add($tabHeadLegenda);

                $obFieds = new TSetfields();
                $obFieds->geraCampo("Nº de Matricula:", 'matricula', "TEntry", '');
                $obFieds->setProperty('matricula', 'disabled', 'disabled');
                $obFieds->setValue("matricula", $getFinanceiro->aluno->codigo);

                $obFieds->geraCampo("Aluno:", 'aluno', "TEntry", '');
                $obFieds->setProperty('aluno', 'disabled', 'disabled');
                $obFieds->setProperty('aluno', 'size', '60');
                $obFieds->setValue("aluno", $getFinanceiro->aluno->nomepessoa);

                $obFieds->geraCampo("Curso:", 'curso', "TEntry", '');
                $obFieds->setProperty('curso', 'disabled', 'disabled');
                $obFieds->setProperty('curso', 'size', '60');
                $obFieds->setValue("curso", $getFinanceiro->aluno->nomecurso);

                $obFieds->geraCampo("Turma:", 'turma', "TEntry", '');
                $obFieds->setProperty('turma', 'disabled', 'disabled');
                $obFieds->setProperty('turma', 'size', '60');
                $obFieds->setValue("turma", $getFinanceiro->aluno->nometurma);

                $content = new TElement('div');
                $content->class = "ui_bloco_conteudo";
                $content->add($obFieds->getConteiner());
                $tabHead->add($content);

                $disciplinas = new TElement("fieldset");
                $disciplinas->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                $disciplinasLegenda = new TElement("legend");
                $disciplinasLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                $disciplinasLegenda->add("Parcelas");
                $disciplinas->add($disciplinasLegenda);

                $datagrid = new TDataGrid();

                $datagrid->addColumn(new TDataGridColumn('impressao', '-', 'center', '3%'));
                $datagrid->addColumn(new TDataGridColumn('situacao', '-', 'center', '3%'));
                $datagrid->addColumn(new TDataGridColumn('parcela', 'Parcela', 'center', '3%'));
                $datagrid->addColumn(new TDataGridColumn('doc', 'Conta', 'left', '55%'));
                $datagrid->addColumn(new TDataGridColumn('vencimento', 'Vencimento', 'center', '15%'));
                $datagrid->addColumn(new TDataGridColumn('valor', 'Valor Nominal', 'center', '10%'));
                $datagrid->addColumn(new TDataGridColumn('valorpago', 'Valor Pago', 'center', '10%'));
                $datagrid->createModel('100%');

                $TSetModel = new TSetModel();

                if($getFinanceiro->transacoes){
                foreach($getFinanceiro->transacoes as $key => $obTransacoes) {
                    foreach($obTransacoes->contas as $kayContas => $obContas) {
                        $impressao = new TElement('img');
                        $impressao->src = "../app.view/app.images/petrus/new_ico_print.png";
                        $impressao->style = "cursor:pointer";
                        $impressao->onclick = ($obContas->statusconta == 1) ? "showBoleto('".$obContas->codigo."')" : "alert('Não é possível imprimir o boleto.')";

                        $situacao = new TElement('img');
                        $situacao->src = ($obContas->statusconta == 2) ? "../app.view/app.images/sim.gif" : "../app.view/app.images/nao.gif";
                        $situacao->style = "cursor:pointer";

                        $tempDisc['impressao'] = $impressao;
                        $tempDisc['situacao'] = $situacao;
                        $tempDisc['parcela'] = $obContas->numparcela;
                        $tempDisc['doc'] = $obContas->codigo;
                        $tempDisc['vencimento'] = $TSetModel->setDataPT($obContas->vencimento);
                        $tempDisc['valor'] = 'R$ '.$TSetModel->setMoney($obContas->valornominal);
                        $tempDisc['valorpago'] = 'R$ '.$TSetModel->setMoney($obContas->valorpago);

                        $datagrid->addItem($tempDisc);
                    }
                }
                }
                $content = new TElement('div');
                $content->class = "ui_bloco_conteudo";
                $content->add($datagrid);
                $disciplinas->add($content);


                $obAluno = new TElement('div');
                $obAluno->add($tabHead);
                $obAluno->add($disciplinas);

            }else {
                throw new ErrorException("O codigo ".$codigoaluno." não é referente a um aluno valido. [TSecretaria - 397]");
            }
        }catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }

        return $obAluno;
    }

    public function viewSetRequisitos($codigoaluno){
        try{

            if($codigoaluno){

                $obAluno = $this->getAluno($codigoaluno);

                //retorna requisitos do turmas
                $obTurma = new TTurma();
                $requisitos = $obTurma->getRequisitos($obAluno->codigoturma);

                $tabHead = new TElement("fieldset");

                        $tabHead->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                        $tabHeadLegenda = new TElement("legend");
                        $tabHeadLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                        $tabHeadLegenda->add("Informações do Aluno");
                        $tabHead->add($tabHeadLegenda);

                        $obFieds = new TSetfields();
                        $obFieds->geraCampo("Nº de Matricula:", 'matricula', "TEntry", '');
                        $obFieds->setProperty('matricula', 'disabled', 'disabled');
                        $obFieds->setValue("matricula", $codigoaluno);

                        $obFieds->geraCampo("Aluno:", 'aluno', "TEntry", '');
                        $obFieds->setProperty('aluno', 'disabled', 'disabled');
                        $obFieds->setProperty('aluno', 'size', '60');
                        $obFieds->setValue("aluno", $obAluno->nomepessoa);

                        $obFieds->geraCampo("Curso:", 'curso', "TEntry", '');
                        $obFieds->setProperty('curso', 'disabled', 'disabled');
                        $obFieds->setProperty('curso', 'size', '60');
                        $obFieds->setValue("curso", $obAluno->nomecurso);

                        $obFieds->geraCampo("Turma:", 'turma', "TEntry", '');
                        $obFieds->setProperty('turma', 'disabled', 'disabled');
                        $obFieds->setProperty('turma', 'size', '60');
                        $obFieds->setValue("turma", $obAluno->nometurma);

                        $content = new TElement('div');
                        $content->class = "ui_bloco_conteudo";
                        $content->add($obFieds->getConteiner());
                        $tabHead->add($content);


                $fieldReq = new TElement("fieldset");
                $fieldReq->class = ' ui_bloco_fieldset ui-corner-all ui-widget-content';
                $legendaReq = new TElement("legend");
                $legendaReq->add("Pré-requisitos");
                $legendaReq->class = ' ui_bloco_legendas ui-corner-all ui-widget-content';
                $fieldReq->add($legendaReq);

                $blocReq = new TTable();
                $blocReq->border = 0;

                    //Retorna requisitos baseado no código da inscrição pois o aluno ainda não existe
                    $requisitosAluno = $this->getRequisitos($codigoaluno);

                foreach($requisitos as $codKey=>$requisito) {

                    $campoReq = new TCheckButton("idrequisito");
                    $campoReq->setValue("1");
                    $campoReq->setId("req_".$requisito->codigo);
                    $campoReq->setProperty('onclick','setRequisitos(this, \''.$codigoaluno.'\', \''.$requisito->codigo.'\')');

                    if($requisitosAluno[$codKey]->situacao == '1'){
                        $campoReq->checked = "checked";
                    }

                    $rowReq = $blocReq->addRow();
                    $cellRet = $rowReq->addCell($campoReq);
                    $cellRet->width = "235px";
                    $cellRet->align = "right";
                    $cellReqLabel = $rowReq->addCell($requisito->requisito);
                    $cellReqLabel->style = "TEXT-ALIGN: left; FONT-FAMILY: Arial; COLOR: black; FONT-SIZE: 14px";

                }
                $fieldReq->add($blocReq);

                $this->ob = new TElement('div');
                $this->ob->id = "contMatricula";
                $this->ob->add($tabHead);
                $this->ob->add($fieldReq);

                return $this->ob;

            }else{
                throw new ErrorException("O codigo ".$codigoaluno." não é referente a um aluno valido. [TSecretaria - 494]");
            }

        }catch (Exception $e){
            $this->obTDbo->rollback();
            new setException($e);
        }
    }

    /*
     *
     */
    public function getFrequenciaAlunos($codigoTurmaDisciplina){
        $TTurmaDisciplina = new TTurmaDisciplinas($codigoTurmaDisciplina);
        $obAulas = $TTurmaDisciplina->getAula($codigoTurmaDisciplina);

        $TSetModel = new TSetModel();
        $datas = array();
        $faltas = array();
        if($obAulas){
            ksort($obAulas);
            foreach($obAulas as $ch=>$aula){
                $numaula = 1;

                if($aula->faltas) ksort($aula->faltas);

                while($numaula <= $aula->frequencia){
                    $lbl = substr($TSetModel->setDataPT($aula->dataaula),0,-5) . ' ('.$numaula.'ª)';
                    $datas[] = $lbl;
                    $faltas[$lbl] = $aula->faltas[$numaula] ? count($aula->faltas) : 0;
                    $numaula++;
                }
            }
        }
        $ob->datas = $datas;
        $ob->faltas = $faltas;

        return $ob;
    }
     /*
     * Retorna objeto TElement com grafico de ocupação da sala
     */
    public function viewTaxaOcupacao($codigoturmadisciplina){
       try{
                $TTurmaDisciplina = new TTurmaDisciplinas();
                $obDisciplina   = $TTurmaDisciplina->getTurmaDisciplina($codigoturmadisciplina);

                $TTurma = new TTurma();
                $obTurma = $TTurma->getTurma($obDisciplina->codigoturma);
                if($obDisciplina->codigosala){
                    $dbo = new TDbo(TConstantes::DBSALAS);
                    $crit = new TCriteria();
                    $crit->add(new TFilter('codigo','=',$obDisciplina->codigosala));
                    $ret = $dbo->select('capacidade',$crit);
                    $obSala = $ret->fetchObject();
                }
            $obFrequencias = $this->getFrequenciaAlunos($codigoturmadisciplina);
        
            $label0 = $obFrequencias->datas;
            $data_ = $obFrequencias->faltas;
        if($data_){

                    foreach($label0 as $ch=>$vl){
                        $data0[$ch] = $obDisciplina->alunos - $data_[$vl];
                    }

                    $media = round(array_sum($data0) / count($data0));
        }

            $chart_width = 90 * count($data0);

            $chart_width = $chart_width > 550 ? $chart_width : 550;

            $data1['inscritos'] = $obTurma->inscritos;
            $data1['vagas'] = $obTurma->vagas;
            $data1['capacidade'] = $obSala->capacidade;
            $data1['alunos'] = $obDisciplina->alunos;
            $data1['frequentes'] = $media ? $media : 0;

                $tabHead = new TElement("fieldset");
                $tabHead->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                $tabHeadLegenda = new TElement("legend");
                $tabHeadLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                $tabHeadLegenda->add("Informações da Disciplina");
                $tabHead->add($tabHeadLegenda);

                $obFieds = new TSetfields();
                $obFieds->geraCampo("Curso:", 'curso', "TEntry", '');
                $obFieds->setProperty('curso', 'disabled', 'disabled');
                $obFieds->setProperty('curso', 'size', '60');
                $obFieds->setValue("curso", $obDisciplina->nomecurso);

                $obFieds->geraCampo("Turma:", 'turma', "TEntry", '');
                $obFieds->setProperty('turma', 'disabled', 'disabled');
                $obFieds->setProperty('turma', 'size', '60');
                $obFieds->setValue("turma", $obDisciplina->nometurma);

                $obFieds->geraCampo("Disciplina:", 'disciplina', "TEntry", '');
                $obFieds->setProperty('disciplina', 'disabled', 'disabled');
                $obFieds->setProperty('disciplina', 'size', '60');
                $obFieds->setValue("disciplina", $obDisciplina->nomedisciplina);
                $content = new TElement('div');

                $content->class = "ui_bloco_conteudo";
                $content->add($obFieds->getConteiner());
                $tabHead->add($content);

          if($data0){
          $TChart0 = new TChart('Média de Frequência', $chart_width, '350');
          $TChart0->addLabel($label0);
          $TChart0->addPoint($data0,'Presentes');

          $grafico0 = new TElement('div');
          $img_grafico0 = $TChart0->show('line');
          $img_grafico0->style = 'display: inline';
          }

          $TChart1 = new TChart('Taxa de Ocupação', $chart_width, '350');

            //$TChart0->addLabel(array('Capacidade','Vagas', 'Inscrições','Matrículas','Frequentes'));
            $TChart1->addPoint($data1['inscritos'],'Inscrições');
            $TChart1->addPoint($data1['vagas'],'Vagas');
            $TChart1->addPoint($data1['capacidade'],'Capacidade');
            $TChart1->addPoint($data1['alunos'],'Matrículas');
            $TChart1->addPoint($data1['frequentes'],'Frequentes');
          $img_grafico1 = $TChart1->show('bar');
          $img_grafico1->style = 'display: inline';
          
          $graficos = new TElement('div');
          $graficos->style = 'vertical-align: middle; text-align: center';
          $graficos->add($img_grafico1);
          $graficos->add($img_grafico0);

          $ret = new TElement('div');
          $ret->add($tabHead);

          $ret->add($graficos);

          return $ret;

       } catch (Exception $e) {
            $this->obTDbo->rollback ();
            new setException ($e);
        }
    }

    /*
     * Visualiza opções para manipulação acadêmica
     */
    public function viewProcessosAcademicos($codigoaluno) {

        try {
            if($codigoaluno) {
               	$TAluno = new TAluno();            	
                $obAluno = $TAluno->getAluno($codigoaluno);
                $TTurma = new TTurma();
                $obTurma = $TTurma->getTurma($obAluno->codigoturma);
            	
                //$getAcademico = $TAluno->getAcademico($codigoaluno);
                $tabHead = new TElement("fieldset");
                $tabHead->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                $tabHeadLegenda = new TElement("legend");
                $tabHeadLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                $tabHeadLegenda->add("Informações do Aluno");
                $tabHead->add($tabHeadLegenda);

                $obFieds = new TSetfields();
                $obFieds->geraCampo("Nº de Matricula:", 'matricula', "TEntry", '');
                $obFieds->setProperty('matricula', 'disabled', 'disabled');
                $obFieds->setValue("matricula", $obAluno->codigo);

                $obFieds->geraCampo("Aluno:", 'aluno', "TEntry", '');
                $obFieds->setProperty('aluno', 'disabled', 'disabled');
                $obFieds->setProperty('aluno', 'size', '60');
                $obFieds->setValue("aluno", $obAluno->nomepessoa);

                $obFieds->geraCampo("Curso:", 'curso', "TEntry", '');
                $obFieds->setProperty('curso', 'disabled', 'disabled');
                $obFieds->setProperty('curso', 'size', '60');
                $obFieds->setValue("curso", $obTurma->nomecurso);

                $obFieds->geraCampo("Turma:", 'turma', "TEntry", '');
                $obFieds->setProperty('turma', 'disabled', 'disabled');
                $obFieds->setProperty('turma', 'size', '60');
                $obFieds->setValue("turma", $obTurma->titulo);

                $content = new TElement('div');
                $content->class = "ui_bloco_conteudo";
                $content->add($obFieds->getConteiner());
                $tabHead->add($content);

                $TProcessosAcademicos = new TProcessoAcademico();
                $itens_menu = $TProcessosAcademicos->getProcessoAcademico();

                $menu = new TElement("fieldset");
                $menu->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                $menuLegenda = new TElement("legend");
                $menuLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                $menuLegenda->add("Opções");
                $menu->add($menuLegenda);

                  $datagrid = new TDataGrid();

                $datagrid->addColumn(new TDataGridColumn('ac', '-', 'center', '20px'));
                $datagrid->addColumn(new TDataGridColumn('processo', 'Processo', 'left', '95%'));
                $datagrid->createModel('100%');


                $img = new TElement('img');
                $img->src   = "../app.view/app.images/petrus/new_ico_config.png";
                $img->style = "cursor:pointer";
                $img->style = "width: 17px; height: 17px";

               

                foreach($itens_menu as $ch => $vl){

                    $confirmacao = "O processo <b>{$vl['titulo']}</b> foi selecionado, deseja realmente continuar?<br/><br/>";
                    $confirmacao .= "<b>Procedimento:</b> {$vl['procedimento']}";
                    if($vl['requisitos']) $confirmacao .= "<br/><br/>Requisitos: {$vl['requisitos']} ";

                $acao = new TElement('div');
                $acao->class="datagrid-icon ui-state-hover";
                $acao->alt="Iniciar Processo";
                $acao->title="Iniciar Processo";
                $acao->style="font-size: 11px; vertical-align: middle;";
                $acao->add($img);
                $acao->add(' Iniciar');
                    $acao->onclick = "prossExe('onEdit','form','{$vl['formulario']}','{$codigoaluno}','respostaAproveitamento','{$confirmacao}')";
                    $tempmenu['ac'] = $acao;
                    $tempmenu['processo'] = '&nbsp;&nbsp;'.$vl['titulo'];
                    $datagrid->addItem($tempmenu);
                }
                $divResp = new TElement('div');
                $divResp->id = "respostaAproveitamento";
                $divResp->style = "";
                $divResp->add('');

                $menu->add($divResp);
                $menu->add($datagrid);

                $obAluno = new TElement('div');
                $obAluno->add($tabHead);
                $obAluno->add($menu);

            }else {
                throw new ErrorException("O codigo ".$codigoaluno." não é referente a um aluno valido.");
            }
        }catch (Exception $e) {
            new setException($e);
        }

        return $obAluno;
    }

	/**
	 * 
	 * @param unknown_type $codigoSolicitacao
	 * @return TElement
	 */
    public function viewAtendimentoSolicitacao($codigoSolicitacao){
            try{

                $dbo = new TDbo(TConstantes::VIEW_ALUNOS_SOLICITACOES);
                $crit = new TCriteria();
                $crit->add(new TFilter('codigo','=',$codigoSolicitacao));
                $ret = $dbo->select('*',$crit);
                $obSolicitacao = $ret->fetchObject();

                $TProcessoAcademico = new TProcessoAcademico();
                $obProcesso = $TProcessoAcademico->execProcessoAcademico($obSolicitacao->codigoaluno,$obSolicitacao->codigosolicitacao);




                if($obProcesso){
                    $resposta = new TElement("fieldset");
                    $resposta->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                    $resposta->style = 'height: 100%;';
                    $respostaLegenda = new TElement("legend");
                    $respostaLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                    $respostaLegenda->add("Resolução");
                    $resposta->add($respostaLegenda);
                    $resposta->add($obProcesso);

                    $obAluno = new TElement('div');
                    $obAluno->add($resposta);

                    return $obAluno;
                    }

            }catch (Exception $e) {
            new setException($e);
        }
     }

}