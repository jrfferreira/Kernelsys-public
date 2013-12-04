<?php

/*
 * Classe Aluno
 * Autor: João Felix
 * Data: 2009-01-26
 */

class TAluno {

    private $obTDbo = NULL;
    private $obAluno = NULL;

    public function __construct($codigoaluno = NULL) {
        $this->obTDbo = new TDbo();
    }

    /**
     * Retorna o objeto correspondente ao aluno
     * param <type> $codigoaluno
     */
    public function getAluno($codigoaluno) {
        try {
            if ($codigoaluno) {
                $this->obTDbo->setEntidade(TConstantes::VIEW_ALUNO);
                	$criteria = new TCriteria();
                	$criteria->add(new TFilter('seq', '=', $codigoaluno));
                $retAluno = $this->obTDbo->select("*", $criteria);
                $obAluno = $retAluno->fetchObject();
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido. [TAluno - 22]");
            }
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }

        return $obAluno;
    }

    /**
     * Retorna o objeto correspondente aos alunos
     * param <objeto> $criteria
     */
    public function getAlunos(TCriteria $criteria = null) {

        try {
            $alunos = array();
            $this->obTDbo->setEntidade(TConstantes::VIEW_ALUNO);
            if ($criteria) {
                $retAluno = $this->obTDbo->select("*", $criteria);
            } else {
                $retAluno = $this->obTDbo->select("*");
            }
            if ($retAluno) {
                while ($obAluno = $retAluno->fetchObject()) {
                    $alunos[$obAluno->seq] = $obAluno;
                }
            } else {
                throw new ErrorException("Não existem alunos vinculados");
            }
            
            return $alunos;
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
    }
    
    /**
    * 
    */
    public function listaNotas($codigoAluno){
    	
    	try{
    		
    		//$obAluno = $this->getAluno($codigoAluno);
    		
    		$this->obTDbo->setEntidade(TConstantes::VIEW_NOTA);
            $criteria = new TCriteria();
            $criteria->add(new TFilter('alunseq', '=', $codigoAluno));
            
    	    $retAluno = $this->obTDbo->select("*", $criteria);
            if ($retAluno) {
            	
                while ($obNota = $retAluno->fetchObject()) {
                   $notas[$obNota->seq] = $obNota;
                }
             
            } else {
                $notas = 0;
            }
    		
    	}catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
        
    	return $notas;
    }

    /**
     * Retorna o objeto correspondente a avaliacao do aluno
     * param <objeto> $criteria
     */
    public function getNota($codigoaluno, $codigoavaliacao = null) {

        try {
            $this->obTDbo->setEntidade(TConstantes::DBNOTA);
            $criteria = new TCriteria();
            $criteria->add(new TFilter('alunseq', '=', $codigoaluno));
            if ($codigoavaliacao) {
                $criteria->add(new TFilter('avalseq', '=', $codigoavaliacao));
            }
            
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }

        return $notas;
    }

    /**
     * Retorna o objeto correspondente as faltas do aluno
     * param <objeto> $criteria
     */
    public function getFalta($codigoaluno, $tudiseq = null) {
        try {
            $this->obTDbo->setEntidade(TConstantes::DBFALTA);
            $criteria = new TCriteria();
            $criteria->add(new TFilter('alunseq', '=', $codigoaluno));
            $criteria->add(new TFilter('deferido', '=', true));
            if ($tudiseq) {
                $criteria->add(new TFilter('tudiseq', '=', $tudiseq));
                $faltas = 0;
            } else {
                $faltas = array();
            }

            $retAluno = $this->obTDbo->select("*", $criteria);
            if ($retAluno) {
                if ($tudiseq) {
                    while ($obFaltas = $retAluno->fetchObject()) {
                        $faltas = $faltas + 1;
                    }
                } else {
                    while ($obFaltas = $retAluno->fetchObject()) {
                        $faltas[$obFaltas->tudiseq] = $faltas[$obFaltas->tudiseq] ? $faltas[$obFaltas->tudiseq] + 1 : 0;
                    }
                }
            }
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }

        return $faltas;
    }

    /**
     * Retorna o objeto correspondente as disciplinas do alunp
     * param <type> $codigoaluno
     */
    public function getDisciplinas($codigoaluno, $situacao="2") {

        try {
            if ($codigoaluno) {
                $obTDbo = new TDbo(TConstantes::VIEW_ALUNO_DISCIPLINA);
                $criterio = new TCriteria();
                $criterio->add(new TFilter("alunseq", "=", $codigoaluno));
                if ($situacao && ($situacao != 'all')) {
                    $criterio->add(new TFilter("stadseq", "=", $situacao));
                }
                $criterio->setProperty('order', 'stadseq');
                $retDiscs = $obTDbo->select("*", $criterio);
                while ($obDisc = $retDiscs->fetchObject()) {
                    $retorno[$obDisc->seq] = $obDisc;
                }
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido. [TAluno - 163]");
            }
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
        return $retorno;
    }

    /**
     * Retorna o objeto correspondente as contas do aluno
     * param <type> $codigoaluno
     */
    public function getFinanceiro($codigoaluno) {
        try {
            if ($codigoaluno) {
                $obAluno = $this->getAluno($codigoaluno);

                $this->obTDbo->setEntidade(TConstantes::DBALUNO);
                $criteria = new TCriteria();
                $criteria->add(new TFilter('seq', '=', $codigoaluno));
                $retTransacs = $this->obTDbo->select('transeq', $criteria);
                $TTransacao = new TTransacao();
                while ($ret = $retTransacs->fetchObject()) {
                    $retorno->transacoes[$ret->transeq] = $TTransacao->getTransacao($ret->transeq);
                    $TContas = $TTransacao->getContas($ret->transeq);
                    $retorno->transacoes[$ret->transeq]->contas = $TContas;
                }
                $retorno->aluno = $obAluno;
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido.[TAluno - 194]");
            }
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
        return $retorno;
    }

    /**
     * Retorna o objeto [Element] correspondente as contas do aluno
     * param <type> $codigoaluno
     */
    public function viewGetFinanceiro($codigoaluno) {

        try {
            $TUsuario = new TUsuario();
            $codigoaluno = $TUsuario->getSeqAluno();
            if ($codigoaluno) {
                $getFinanceiro = $this->getFinanceiro($codigoaluno);

                $tabHead = new TElement("fieldset");
                $tabHead->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                $tabHeadLegenda = new TElement("legend");
                $tabHeadLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                $tabHeadLegenda->add("Informações do Aluno");
                $tabHead->add($tabHeadLegenda);

                $obFieds = new TSetfields();
                $obFieds->geraCampo("Nº de Matricula:", 'matricula', "TEntry", '');
                $obFieds->setProperty('matricula', 'disabled', 'disabled');
                $obFieds->setValue("matricula", $getFinanceiro->aluno->seq);

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
                $disciplinasLegenda->add("Disciplinas");
                $disciplinas->add($disciplinasLegenda);

                $datagrid = new TDataGrid();

                $datagrid->addColumn(new TDataGridColumn('impressao', '-', 'center', '3%'));
                $datagrid->addColumn(new TDataGridColumn('situacao', '-', 'center', '3%'));
                $datagrid->addColumn(new TDataGridColumn('parcela', 'Parcela', 'center', '3%'));
                $datagrid->addColumn(new TDataGridColumn('doc', 'Conta', 'left', '55%'));
                $datagrid->addColumn(new TDataGridColumn('vencimento', 'Vencimento', 'center', '15%'));
                $datagrid->addColumn(new TDataGridColumn('valor', 'Valor Nominal', 'center', '10%'));
                $datagrid->addColumn(new TDataGridColumn('valorfinal', 'Valor Pago', 'center', '10%'));
                $datagrid->createModel('100%');

                $TSetModel = new TSetModel();

                if ($getFinanceiro->transacoes) {
                    foreach ($getFinanceiro->transacoes as $key => $obTransacoes) {
                        foreach ($obTransacoes->contas as $kayContas => $obContas) {
                            $impressao = new TElement('img');
                            $impressao->src = "../app.view/app.images/petrus/new_ico_print.png";
                            $impressao->style = "cursor:pointer";
                            $impressao->onclick = "showBoleto('" . $obContas->codigo . "')";

                            $situacao = new TElement('img');
                            $situacao->src = ($obContas->stpaseq == 2) ? "../app.view/app.images/" . "sim.gif" : "../app.view/app.images/" . "nao.gif";
                            $situacao->style = "cursor:pointer";

                            $tempDisc['impressao'] = $impressao;
                            $tempDisc['situacao'] = $situacao;
                            $tempDisc['parcela'] = $obContas->numparcela;
                            $tempDisc['doc'] = $obContas->seq;
                            $tempDisc['vencimento'] = $TSetModel->setDataPT($obContas->vencimento);
                            $tempDisc['valor'] = 'R$ ' . $TSetModel->setMoney($obContas->valor);
                            $tempDisc['valorfinal'] = 'R$ ' . $TSetModel->setMoney($obContas->valorfinal);

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
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido.[TAluno - 301]");
            }
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }

        return $obAluno;
    }

    /**
     * Retorna o objeto correspondente as notas do aluno
     * param <type> $codigoaluno
     */
    public function getAcademico($codigoaluno, $situacao="2") {

        try {
            if ($codigoaluno) {
                $obAluno = $this->getAluno($codigoaluno);
                /*$TTurma = new TTurma();
                $obTurma = $TTurma->getTurma($obAluno->codigoturma);*/
/*
                $TUnidade = new TUnidade();
                $TParametros = $TUnidade->getParametro();

                $disciplinas = $this->getDisciplinas($codigoaluno, $situacao);
                $TTurmaDisciplinas = new TTurmaDisciplinas();

                $TAvaliacao = new TAvaliacao();
                $medias = $TAvaliacao->getMedia($codigoaluno);
               */

             $this->obTDbo->setEntidade(TConstantes::ALUNO_NOTA_FREQUENCIA);
             $criteria = new TCriteria();
             $criteria->add(new TFilter('alunseq','=',$codigoaluno));
                
             $retDiscs = $this->obTDbo->select('*',$criteria, true);

             $retorno->academico = array();
             while($obDisc = $retDiscs->fetchObject())
                $retorno->academico[$obDisc->tudiseq] = $obDisc;


             $retorno->aluno = $obAluno;
             return $retorno;
                
                
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido.[TAluno - 395]");
            }
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
    }

    /**
     * 
     * @param unknown_type $codigoaluno
     */
    public function viewInfoAluno($codigoaluno) {
        try {
            //$TUsuario = new TUsuario();
            //$codigoaluno = $TUsuario->getSeqAluno();
            if ($codigoaluno) {
                $getAcademico = $this->getAcademico($codigoaluno);
                                
                $obFieds = new TSetfields();
                $obFieds->geraCampo("Nº de Matricula:", 'matricula', "TEntry", '');
                $obFieds->setProperty('matricula', 'disabled', 'disabled');
                $obFieds->setValue("matricula", $getAcademico->aluno->seq);

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
                $content->class = "ui_bl_conteudo";
                $content->add($obFieds->getConteiner());
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido.[TAluno - 433]");
            }
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }

        return $content;
    }

    /**
     * Retorna o objeto [Element] correspondente as notas do aluno
     * param <type> $codigoaluno
     */
    public function viewGetAcademico($codigoaluno) {

        try {
            $TUsuario = new TUsuario();
            $codigoaluno = $TUsuario->getSeqAluno();
            if ($codigoaluno) {
                $getAcademico = $this->getAcademico($codigoaluno);
                $tabHead = new TElement("fieldset");
                $tabHead->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
                $tabHeadLegenda = new TElement("legend");
                $tabHeadLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
                $tabHeadLegenda->add("Informações do Aluno");
                $tabHead->add($tabHeadLegenda);

                $obFieds = new TSetfields();
                $obFieds->geraCampo("Nº de Matricula:", 'matricula', "TEntry", '');
                $obFieds->setProperty('matricula', 'disabled', 'disabled');
                $obFieds->setValue("matricula", $getAcademico->aluno->seq);

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
                //$datagrid->addColumn(new TDataGridColumn('inicio', 'Início', 'center', '100px'));
                $datagrid->createModel('100%');

                foreach ($getAcademico->academico as $key => $obDisc) {
                    $tempDisc['disciplina'] = $obDisc->disciplina;

                    if($obDisc->cargahoraria){
                        $tempDisc['disciplina'] .= " ({$obDisc->cargahoraria} hs)";
                    }
                    $tempDisc['professor'] = $obDisc->professor;
                    $media = new TElement('div');
                    if ($obDisc->aprovacaomedia) {
                        $media->class = 'ui-state';
                    } else {
                        $media->class = 'ui-state red-text';
                    }
                    $media->add($obDisc->nota ? $obDisc->nota : '--');
                    $tempDisc['media'] = $media;
                    $frequencia = new TElement('div');
                    if ($obDisc->aprovacaofrequencias) {
                        $frequencia->class = 'ui-state';
                    } else {
                        $frequencia->class = 'ui-state red-text';
                    }
                    $frequencia->add($obDisc->frequencia ? $obDisc->frequencia . "%" : '--');
                    $tempDisc['frequencia'] = $frequencia;
                    //$tempDisc['inicio'] = $obDisc->datainicio;
                    $datagrid->addItem($tempDisc);
                }
                $content = new TElement('div');
                $content->class = "ui_bloco_conteudo";
                $content->add($datagrid);
                $disciplinas->add($content);


                $obAluno = new TElement('div');
                $obAluno->add($tabHead);
                $obAluno->add($disciplinas);
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido.[TAluno - 535]");
            }
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }

        return $obAluno;
    }

    /**
     * Atualiza correspondente aos requisito aluno x turmas
     * param <objeto> $codigoaluno
     */
    
    public function setRequisitos($codigoaluno, $codigorequisito, $situacao) {
        try {
            if ($codigoaluno) {

                $vet['alunseq'] = $codigoaluno;
                $vet['retuseq'] = $codigorequisito;
                $vet['situacao'] = $situacao;

                $obTDbo = new TDbo(TConstantes::DBALUNO_REQUISITO);
                $criteriaAluno = new TCriteria();
                $criteriaAluno->add(new TFilter('alunseq', '=', $codigoaluno));
                $criteriaAluno->add(new TFilter('retuseq', '=', $codigorequisito));
                $qAluno = $obTDbo->select("seq", $criteriaAluno);
                $retAluno = $qAluno->fetchObject();

                if ($retAluno->seq) {
                    $acao = $obTDbo->update($vet, $criteriaAluno);
                } else {
                    $acao = $obTDbo->insert($vet);
                }

                return $acao;
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido.[TAluno - 572]");
            }
        } catch (Exception $e) {
            $obTDbo->rollback();
            new setException($e);
        }
    }

    /**
     * Retorna o objeto correspondente aos requisito aluno x turmas
     * param <objeto> $codigoaluno
     */
    public function getRequisitos($codigoaluno) {
        try {

            if (!$codigoaluno) {
                throw new ErrorException("O codigo [ " . $codigoaluno . " ] não é referente a um aluno valido.[TAluno - 588]");
            }

            $obTDbo = new TDbo(TConstantes::DBALUNO_REQUISITO);
            $criteriaAluno = new TCriteria();
            $criteriaAluno->add(new TFilter('alunseq', '=', $codigoaluno));
            $qAlunoRequisito = $obTDbo->select("*", $criteriaAluno);

            while ($obAlunoRequisito = $qAlunoRequisito->fetchObject()) {
                $requisitos[$obAlunoRequisito->alunseq] = $obAlunoRequisito;
            }

            return $requisitos;
        } catch (Exception $e) {
            new setException($e);
        }
    }

    /**
     * Retorna o objeto [Element] correspondente aos requisito aluno x turmas
     * param <objeto> $codigoaluno
     */
    public function viewSetRequisitos($codigoaluno) {
        try {

            if ($codigoaluno) {

                $obAluno = $this->getAluno($codigoaluno);

                //retorna requisitos do turmas
                $obTurma = new TTurma();
                $requisitos = $obTurma->getRequisitos($obAluno->turmseq);

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

                if ($requisitos) {
                    foreach ($requisitos as $codKey => $requisito) {

                        $campoReq = new TCheckButton("idrequisito");
                        $campoReq->setValue("1");
                        $campoReq->setId("req_" . $requisito->codigo);
                        $campoReq->setProperty('onclick', 'setRequisitos(this, \'' . $codigoaluno . '\', \'' . $requisito->seq . '\')');

                        if ($requisitosAluno[$codKey]->situacao == '1') {
                            $campoReq->checked = "checked";
                        }

                        $rowReq = $blocReq->addRow();
                        $cellRet = $rowReq->addCell($campoReq);
                        $cellRet->width = "235px";
                        $cellRet->align = "right";
                        $cellReqLabel = $rowReq->addCell($requisito->requisito);
                        $cellReqLabel->style = "TEXT-ALIGN: left; FONT-FAMILY: Arial; COLOR: black; FONT-SIZE: 14px";
                    }
                }
                $fieldReq->add($blocReq);

                $this->ob = new TElement('div');
                $this->ob->id = "contMatricula";
                $this->ob->add($tabHead);
                $this->ob->add($fieldReq);

                return $this->ob;
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido.[TAluno - 698]");
            }
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
    }

    /**
     * Retorna string com a situação do aluno em relação a disciplina
     * param <type> $codigoaluno
     */
    public function getSituacaoAlunoDisciplina($situacao) {
        switch ($situacao) {
            case 1:
                $retorno = 'A cursar';
                break;
            case 2:
                $retorno = 'Cursando';
                break;
            case 3:
                $retorno = 'Aprovado por Mérito';
                break;
            case 4:
                $retorno = 'Reprovado';
                break;
            case 5:
                $retorno = 'Trancado';
                break;
            case 6:
                $retorno = 'Evadido';
                break;
            case 7:
                $retorno = 'Aprovado por Reconhecimento';
                break;
        }
        return $retorno;
    }

    public function viewOrientacoes() {

        $TUsuario = new TUsuario();
        $obCodigo = $TUsuario->getCodigoPessoa();


        //retorna informações do Aluno
        $sqlAluno = new TDbo(TConstantes::DBALUNO);
        $critAluno = new TCriteria();
        $critAluno->add(new TFilter("pessseq", "=", $obCodigo));
        $alunoQuery = $sqlAluno->select("turmseq,seq,pessseq", $critAluno);

        //Monta estrutura do Curso/Turma
        while ($obAlunoTurma = $alunoQuery->fetchObject()) {

            $codigopessoa = $obAlunoTurma->pessseq;

            $ch = $obAlunoTurma->turmseq;

            $this->matricula = $obAlunoTurma->seq;

            $sqlRDisc = new TDbo(TConstantes::DBALUNO_DISCIPLINA);
            $critRDisc = new TCriteria();
            $critRDisc->add(new TFilter("alunseq", "=", $this->matricula));
            $RDiscQuery = $sqlRDisc->select("*", $critRDisc);

            //retorna turma do aluno
            $sqlTurma = new TDbo(TConstantes::DBTURMA);
            $critTurma = new TCriteria();
            $critTurma->add(new tFilter("seq", "=", $ch));
            $turmaQuery = $sqlTurma->select("*", $critTurma);

            $obTurma = $turmaQuery->fetchObject();

            //retorna Nome do Curso
            $sqlCurso = new TDbo(TConstantes::DBCURSO);
            $critCurso = new TCriteria();
            $critCurso->add(new TFilter("seq", "=", $obTurma->cursseq));
            $cursoQuery = $sqlCurso->select("*", $critCurso);

            $obCurso = $cursoQuery->fetchObject();


            //Atribui valores ao vetor do curso
            $vetCursos_nomeCurso = $obCurso->nome;
            $vetCursos_nomeTurma = $obTurma->titulo;

            //Monta estrutura das Disciplinas relacionadas

            while ($obRDisc = $RDiscQuery->fetchObject()) {

                $this->tudiseq = $obRDisc->tudiseq;

                $sqlRelTurmaInicial = new TDbo(TConstantes::DBTURMA_DISCIPLINA);
                $critRelTurmaInicial = new TCriteria();
                $critRelTurmaInicial->add(new TFilter("seq", "=", $obRDisc->tudiseq));
                $relTurmaInicialQuery = $sqlRelTurmaInicial->select("discseq", $critRelTurmaInicial);
                $obRelTurmaInicial = $relTurmaInicialQuery->fetchObject();

                $codigodisciplinaInicial = $obRelTurmaInicial->discseq;


                $sqlRelTurma = new TDbo(TConstantes::VIEW_TURMA_DISCIPLINA);
                $critRelTurma = new TCriteria();
                $critRelTurma->add(new TFilter("seq", "=", $this->tudiseq));
                $relTurmaQuery = $sqlRelTurma->select("*", $critRelTurma);
                $obRelTurma = $relTurmaQuery->fetchObject();

                $codigodisciplina = $obRelTurma->discseq;
                $codigoturma = $obRelTurma->turmseq;


                $sqlTurmaAtual = new TDbo(TConstantes::DBTURMA);
                $critTurmaAtual = new TCriteria();
                $critTurmaAtual->add(new tFilter("seq", "=", $codigoturma));
                $turmaAtualQuery = $sqlTurmaAtual->select("*", $critTurmaAtual);

                $obTurmaAtual = $turmaAtualQuery->fetchObject();
                $turmaAtual = $obTurmaAtual->nometurma;




                $nomeProfessor = $obRelTurma->nomeprofessor;
                //retorna disciplina
                $sqlDisc = new TDbo(TConstantes::DBDISCIPLINA);
                $critDisc = new TCriteria();
                $critDisc->add(new TFilter("seq", "=", $codigodisciplinaInicial));
                $discQuery = $sqlDisc->select("*", $critDisc);

                $obDisc = $discQuery->fetchObject();

                if ($obDisc->cargahoraria == NULL) {
                    $obDisc->cargahoraria = "-";
                }
                $disciplinaNome = $obRelTurma->nomedisciplina;
                $disciplinaCH = $obRelTurma - cargahoraria;

                $ementa = str_replace("\r\n", "<BR>", $obDisc->ementa);
                //Consulta de Orientações e Arquivos
                $sqlArquivos = new TDbo(TConstantes::DBTURMA_DISCIPLINA_ARQUIVO);
                $critArquivos = new TCriteria();
                $critArquivos->add(new TFilter("tudiseq", "=", $this->tudiseq));
                $discArquivos = $sqlArquivos->select("*", $critArquivos);

                while ($obArquivos = $discArquivos->fetchObject()) {
                    $data = new TSetData();
                    $duracao = ($data->getData()) - ($obArquivos->datacad);

                    if ($obArquivos->tipo == 1) {
                        $vetCursos[$ch]["disciplinas"][$this->tudiseq]["orientacoes"][$obArquivos->seq]["titulo"] = $obArquivos->titulo;
                        $vetCursos[$ch]["disciplinas"][$this->tudiseq]["orientacoes"][$obArquivos->seq]["obs"] = str_replace("\r\n", "<BR>", $obArquivos->obs);
                        $vetCursos[$ch]["disciplinas"][$this->tudiseq]["orientacoes"][$obArquivos->seq]["autor"] = $nomeProfessor;
                        $vetCursos[$ch]["disciplinas"][$this->tudiseq]["orientacoes"][$obArquivos->seq]["datacad"] = $data->getDataPT($obArquivos->datacad) . " (" . $duracao . " dias atras)";
                    }
                }


                //Atribui valores ao vetor de disciplinas do vetor do curso
                $vetCursos[$ch]["disciplinas"][$this->tudiseq]["nome"] = $disciplinaNome;
                $vetCursos[$ch]["disciplinas"][$this->tudiseq]["codigo"] = $codigodisciplina;
                $vetCursos[$ch]["disciplinas"][$this->tudiseq]["disciplinaCH"] = $disciplinaCH;
                $vetCursos[$ch]["disciplinas"][$this->tudiseq]["professor"] = $nomeProfessor;
            }
        }

        //Inicio do Cabe�alho

        $sqlCliente = new TDbo(TConstantes::DBPESSOA);
        $critCliente = new TCriteria();
        $critCliente->add(new TFilter("seq", "=", $codigopessoa));
        $clienteQuery = $sqlCliente->select("*", $critCliente);

        $obCliente = $clienteQuery->fetchObject();

        $tabHead = new TElement("fieldset");
        $tabHeadLegenda = new TElement("legend");
        $tabHeadLegenda->add("Informações do Aluno");
        $tabHead->add($tabHeadLegenda);

        $obFieds = new TSetfields();
        $obFieds->geraCampo("No de Matricula:", 'matricula', "TEntry", '');
        $obFieds->setProperty('matricula', 'disabled', 'disabled');
        $obFieds->setValue("matricula", $this->matricula);

        $obFieds->geraCampo("Aluno:", 'aluno', "TEntry", '');
        $obFieds->setProperty('aluno', 'disabled', 'disabled');
        $obFieds->setProperty('aluno', 'size', '60');
        $obFieds->setValue("aluno", $obCliente->pessnmrz);

        $obFieds->geraCampo("Curso:", 'curso', "TEntry", '');
        $obFieds->setProperty('curso', 'disabled', 'disabled');
        $obFieds->setProperty('curso', 'size', '60');
        $obFieds->setValue("curso", $vetCursos_nomeCurso);

        $obFieds->geraCampo("Turma:", 'turma', "TEntry", '');
        $obFieds->setProperty('turma', 'disabled', 'disabled');
        $obFieds->setProperty('turma', 'size', '60');
        $obFieds->setValue("turma", $vetCursos_nomeTurma);

        $tabHead->add($obFieds->getConteiner());

        $this->ob = new TElement('div');
        $this->ob->id = "contHistorico";
        $this->ob->add($tabHead);


////////////////////////////////////////////////////////////////////////////////
        //Gera FieldSet de Orientações
        $fieldset = new TElement('fieldset');
        $legenda = new TElement('legend');
        $legenda->add("Orientações");

        $fieldset->add($legenda);

        $tabela = new TElement('table');
        $tabela->class = "tdatagrid_table";
        $tabela->width = "100%";

        $tr = new TElement('tr');

        $td = new TElement('td');
        $td->class = "tdatagrid_col";
        $td->style = "width=30%;";
        $td->add("Disciplina");

        $tr->add($td);

        $td = new TElement('td');
        $td->class = "tdatagrid_col";
        $td->style = "width=10%;";
        $td->add("C.H.");

        $tr->add($td);

        $td = new TElement('td');
        $td->class = "tdatagrid_col";
        $td->style = "width=30%;";
        $td->add("Professor");

        $tr->add($td);
        $tabela->add($tr);

        if (count($vetCursos) > 0) {
            foreach ($vetCursos as $chave => $valor) {
                //Disciplinas
                if ($vetCursos[$chave]['disciplinas'] == NULL) {

                    $tr = new TElement('tr');
                    $td = new TElement('td');
                    $td->class = "tdatagrid_row1";
                    $td->colspan = "4";
                    $td->add("- não existem matérias relacionadas.");

                    $tr->add($td);
                    $tabela->add($tr);
                } else {

                    foreach ($vetCursos[$chave]['disciplinas'] as $chave1 => $valor1) {

                        $each = $vetCursos[$chave]['disciplinas'][$chave1];

                        $tr = new TElement('tr');
                        $td = new TElement('td');
                        $td->class = "tdatagrid_row1";
                        $td->colspan = "1";
                        $td->add($each["nome"]);

                        $tr->add($td);

                        $td = new TElement('td');
                        $td->class = "tdatagrid_row1";
                        $td->colspan = "1";
                        $td->add($each["disciplinaCH"]);

                        $tr->add($td);

                        $td = new TElement('td');
                        $td->class = "tdatagrid_row1";
                        $td->colspan = "1";
                        $td->add($each["professor"]);

                        $tr->add($td);

                        $tabela->add($tr);

                        if ($each["orientacoes"] == NULL) {

                            $tr = new TElement('tr');
                            $td = new TElement('td');
                            $td->class = "tdatagrid_row2";
                            $td->colspan = "3";
                            $td->add("- não existem orientações relacionadas.");

                            $tr->add($td);
                            $tabela->add($tr);
                        } else {

                            foreach ($each["orientacoes"] as $chave2 => $valor2) {
                                $orientacao = $each["orientacoes"][$chave2];

                                $icon = new TElement("img");
                                $icon->src = "../app.view/app.images/file_open.gif";
                                $icon->style = "cursor:pointer;";
                                $icon->title = "Ler";
                                $icon->onclick = 'viewLegenda(\'winRet\',\'' . $orientacao["titulo"] . '\',\'<br>' . $orientacao["obs"] . '\')';


                                $tr = new TElement('tr');
                                $td = new TElement('td');
                                $td->class = "tdatagrid_row2";
                                $td->colspan = "3";
                                $td->add($icon);
                                $td->add(" - \"" . $orientacao["titulo"] . "\" - " . $orientacao["autor"] . " em " . $orientacao["datacad"] . ".");
                                $td->style = "padding-left: 10px;";

                                $tr->add($td);

                                $tabela->add($tr);
                            }
                        }
                    }
                }
            }
        }//valida foreach


        $fieldset->add($tabela);
        $this->ob->add($fieldset);
        $this->ob->add("<BR>");




////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


        return $this->ob;
    }

    /**
     * 
     */
    public function viewArquivos() {



        $TUsuario = new TUsuario();
        $obCodigo = $TUsuario->getCodigoPessoa();


        //retorna informações do Aluno
        $sqlAluno = new TDbo(TConstantes::DBALUNO);
        $critAluno = new TCriteria();
        $critAluno->add(new TFilter("pessseq", "=", $obCodigo));
        $alunoQuery = $sqlAluno->select("turmseq,seq,pessseq", $critAluno);

        //Monta estrutura do Curso/Turma
        while ($obAlunoTurma = $alunoQuery->fetchObject()) {

            $codigopessoa = $obAlunoTurma->pessseq;

            $ch = $obAlunoTurma->turmseq;

            $this->matricula = $obAlunoTurma->seq;

            $sqlRDisc = new TDbo(TConstantes::DBALUNO_DISCIPLINA);
            $critRDisc = new TCriteria();
            $critRDisc->add(new TFilter("alunseq", "=", $this->matricula));
            $RDiscQuery = $sqlRDisc->select("*", $critRDisc);

            //retorna turma do aluno
            $sqlTurma = new TDbo(TConstantes::DBTURMA);
            $critTurma = new TCriteria();
            $critTurma->add(new tFilter("seq", "=", $ch));
            $turmaQuery = $sqlTurma->select("*", $critTurma);

            $obTurma = $turmaQuery->fetchObject();

            //retorna Nome do Curso
            $sqlCurso = new TDbo(TConstantes::DBCURSO);
            $critCurso = new TCriteria();
            $critCurso->add(new TFilter("seq", "=", $obTurma->cursseq));
            $cursoQuery = $sqlCurso->select("*", $critCurso);

            $obCurso = $cursoQuery->fetchObject();


            //Atribui valores ao vetor do curso
            $vetCursos_nomeCurso = $obCurso->nome;
            $vetCursos_nomeTurma = $obTurma->titulo;

            //Monta estrutura das Disciplinas relacionadas

            while ($obRDisc = $RDiscQuery->fetchObject()) {

                $this->tudiseq = $obRDisc->tudiseq;

                $sqlRelTurmaInicial = new TDbo(TConstantes::DBTURMA_DISCIPLINA);
                $critRelTurmaInicial = new TCriteria();
                $critRelTurmaInicial->add(new TFilter("seq", "=", $obRDisc->tudiseq));
                $relTurmaInicialQuery = $sqlRelTurmaInicial->select("discseq", $critRelTurmaInicial);
                $obRelTurmaInicial = $relTurmaInicialQuery->fetchObject();

                $codigodisciplinaInicial = $obRelTurmaInicial->discseq;


                $sqlRelTurma = new TDbo(TConstantes::VIEW_TURMA_DISCIPLINA);
                $critRelTurma = new TCriteria();
                $critRelTurma->add(new TFilter("seq", "=", $this->tudiseq));
                $relTurmaQuery = $sqlRelTurma->select("*", $critRelTurma);
                $obRelTurma = $relTurmaQuery->fetchObject();

                $codigodisciplina = $obRelTurma->discseq;
                $codigoturma = $obRelTurma->turmseq;


                $sqlTurmaAtual = new TDbo(TConstantes::DBTURMA);
                $critTurmaAtual = new TCriteria();
                $critTurmaAtual->add(new tFilter("seq", "=", $codigoturma));
                $turmaAtualQuery = $sqlTurmaAtual->select("*", $critTurmaAtual);

                $obTurmaAtual = $turmaAtualQuery->fetchObject();
                $turmaAtual = $obTurmaAtual->nometurma;




                $nomeProfessor = $obRelTurma->nomeprofessor;
                //retorna disciplina
                $sqlDisc = new TDbo(TConstantes::DBDISCIPLINA);
                $critDisc = new TCriteria();
                $critDisc->add(new TFilter("seq", "=", $codigodisciplinaInicial));
                $discQuery = $sqlDisc->select("*", $critDisc);

                $obDisc = $discQuery->fetchObject();

                if ($obDisc->cargahoraria == NULL) {
                    $obDisc->cargahoraria = "-";
                }
                $disciplinaNome = $obRelTurma->nomedisciplina;
                $disciplinaCH = $obRelTurma - cargahoraria;

                $ementa = str_replace("\r\n", "<BR>", $obDisc->ementa);
                //Consulta de Orientações e Arquivos
                $sqlArquivos = new TDbo(TConstantes::DBTURMA_DISCIPLINA_ARQUIVO);
                $critArquivos = new TCriteria();
                $critArquivos->add(new TFilter("tudiseq", "=", $this->tudiseq));
                $discArquivos = $sqlArquivos->select("*", $critArquivos);

                while ($obArquivos = $discArquivos->fetchObject()) {
                    $data = new TSetData();
                    $duracao = ($data->getData()) - ($obArquivos->datacad);

                    if ($obArquivos->tipo == 2) {
                        $vetCursos[$ch]["disciplinas"][$this->tudiseq]["arquivos"][$obArquivos->seq]["titulo"] = $obArquivos->titulo;
                        $vetCursos[$ch]["disciplinas"][$this->tudiseq]["arquivos"][$obArquivos->seq]["obs"] = str_replace("\r\n", "<BR>", $obArquivos->obs);
                        $vetCursos[$ch]["disciplinas"][$this->tudiseq]["arquivos"][$obArquivos->seq]["autor"] = $pessoa->setLabel($obArquivos->profseq);
                        $vetCursos[$ch]["disciplinas"][$this->tudiseq]["arquivos"][$obArquivos->seq]["arquivo"] = $obArquivos->arquivo;
                        $vetCursos[$ch]["disciplinas"][$this->tudiseq]["arquivos"][$obArquivos->seq]["datacad"] = $data->getDataPT($obArquivos->datacad) . " (" . $duracao . " dias atras)";
                    }
                }


                //Atribui valores ao vetor de disciplinas do vetor do curso
                $vetCursos[$ch]["disciplinas"][$this->tudiseq]["nome"] = $disciplinaNome;
                $vetCursos[$ch]["disciplinas"][$this->tudiseq]["codigo"] = $codigodisciplina;
                $vetCursos[$ch]["disciplinas"][$this->tudiseq]["disciplinaCH"] = $disciplinaCH;
                $vetCursos[$ch]["disciplinas"][$this->tudiseq]["professor"] = $nomeProfessor;
            }
        }

        //Inicio do Cabe�alho

        $sqlCliente = new TDbo(TConstantes::DBPESSOA);
        $critCliente = new TCriteria();
        $critCliente->add(new TFilter("seq", "=", $codigopessoa));
        $clienteQuery = $sqlCliente->select("*", $critCliente);

        $obCliente = $clienteQuery->fetchObject();

        $tabHead = new TElement("fieldset");
        $tabHeadLegenda = new TElement("legend");
        $tabHeadLegenda->add("Informações do Aluno");
        $tabHead->add($tabHeadLegenda);

        $obFieds = new TSetfields();
        $obFieds->geraCampo("No de Matricula:", 'matricula', "TEntry", '');
        $obFieds->setProperty('matricula', 'disabled', 'disabled');
        $obFieds->setValue("matricula", $this->matricula);

        $obFieds->geraCampo("Aluno:", 'aluno', "TEntry", '');
        $obFieds->setProperty('aluno', 'disabled', 'disabled');
        $obFieds->setProperty('aluno', 'size', '60');
        $obFieds->setValue("aluno", $obCliente->pessnmrz);

        $obFieds->geraCampo("Curso:", 'curso', "TEntry", '');
        $obFieds->setProperty('curso', 'disabled', 'disabled');
        $obFieds->setProperty('curso', 'size', '60');
        $obFieds->setValue("curso", $vetCursos_nomeCurso);

        $obFieds->geraCampo("Turma:", 'turma', "TEntry", '');
        $obFieds->setProperty('turma', 'disabled', 'disabled');
        $obFieds->setProperty('turma', 'size', '60');
        $obFieds->setValue("turma", $vetCursos_nomeTurma);

        $tabHead->add($obFieds->getConteiner());

        $this->ob = new TElement('div');
        $this->ob->id = "contHistorico";
        $this->ob->add($tabHead);

////////////////////////////////////////////////////////////////////////////////
        //Gera FieldSet de Arquivos
        $fieldset = new TElement('fieldset');
        $legenda = new TElement('legend');
        $legenda->add("Arquivos");

        $fieldset->add($legenda);

        $tabela = new TElement('table');
        $tabela->class = "tdatagrid_table";
        $tabela->width = "100%";

        $tr = new TElement('tr');

        $td = new TElement('td');
        $td->class = "tdatagrid_col";
        $td->style = "width=30%;";
        $td->add("Disciplina");

        $tr->add($td);

        $td = new TElement('td');
        $td->class = "tdatagrid_col";
        $td->style = "width=10%;";
        $td->add("C.H.");

        $tr->add($td);

        $td = new TElement('td');
        $td->class = "tdatagrid_col";
        $td->style = "width=30%;";
        $td->add("Professor");

        $tr->add($td);
        $tabela->add($tr);

        if (count($vetCursos) > 0) {
            foreach ($vetCursos as $chave => $valor) {
                //Disciplinas
                if ($vetCursos[$chave]['disciplinas'] == NULL) {

                    $tr = new TElement('tr');
                    $td = new TElement('td');
                    $td->class = "tdatagrid_row1";
                    $td->colspan = "4";
                    $td->add("- não existem materias relacionadas.");

                    $tr->add($td);
                    $tabela->add($tr);
                } else {

                    foreach ($vetCursos[$chave]['disciplinas'] as $chave1 => $valor1) {

                        $each = $vetCursos[$chave]['disciplinas'][$chave1];

                        $tr = new TElement('tr');
                        $td = new TElement('td');
                        $td->class = "tdatagrid_row1";
                        $td->colspan = "1";
                        $td->add($each["nome"]);

                        $tr->add($td);

                        $td = new TElement('td');
                        $td->class = "tdatagrid_row1";
                        $td->colspan = "1";
                        $td->add($each["disciplinaCH"]);

                        $tr->add($td);

                        $td = new TElement('td');
                        $td->class = "tdatagrid_row1";
                        $td->colspan = "1";
                        $td->add($each["professor"]);

                        $tr->add($td);

                        $tabela->add($tr);

                        if ($each["arquivos"] == NULL) {

                            $tr = new TElement('tr');
                            $td = new TElement('td');
                            $td->class = "tdatagrid_row2";
                            $td->colspan = "3";
                            $td->add("- não existem arquivos relacionados.");

                            $tr->add($td);
                            $tabela->add($tr);
                        } else {

                            foreach ($each["arquivos"] as $chave2 => $valor2) {
                                $arquivo = $each["arquivos"][$chave2];

                                $icon = new TElement("img");
                                $icon->src = "../app.view/app.images/file_open.gif";
                                $icon->style = "cursor:pointer;";
                                $icon->title = "Ler";
                                $icon->onclick = 'viewLegenda(\'winRet\',\'' . $arquivo["titulo"] . '\',\'<br>' . $arquivo["obs"] . '\')';

                                $save = new TElement("img");
                                $save->src = "../app.view/app.images/file_save.gif";
                                $save->style = "cursor:pointer;";
                                $save->title = "Salvar";
                                $save->onclick = 'window.open(\'' . $arquivo["arquivo"] . '\')';


                                $tr = new TElement('tr');
                                $td = new TElement('td');
                                $td->class = "tdatagrid_row2";
                                $td->colspan = "3";
                                $td->add($icon);
                                $td->add("  ");
                                $td->add($save);
                                $td->add(" - \"" . $arquivo["titulo"] . "\" - " . $arquivo["autor"] . " em " . $arquivo["datacad"] . ".");
                                $td->style = "padding-left: 10px;";

                                $tr->add($td);

                                $tabela->add($tr);
                            }
                        }
                    }
                }
            }
        }//valida foreach

        $fieldset->add($tabela);
        $this->ob->add($fieldset);
        $this->ob->add("<BR>");




////////////////////////////////////////////////////////////////////////////////


        return $this->ob;
    }

}
