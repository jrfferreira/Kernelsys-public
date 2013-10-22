<?php

/*
 * Classe Aluno
 * Autor: João Felix
 * Data: 2009-02-10
 */

class TTurmaDisciplinas {

    private $obTDbo = NULL;
    private $obTurmaDisciplinas = NULL;

    public function __construct($codigoTurmaDisciplina = NULL) {
        $this->obTDbo = new TDbo ( );
    }


    public function getTurmasDisciplinasAtivas(){
        $this->obTDbo->setEntidade(TConstantes::VIEW_TURMA_DISCIPLINA);
        $criteria = new TCriteria();
        $criteria->add(new TFilter('status','=','1'),"OR");
        $criteria->add(new TFilter('status','=','5'),"OR");
        $retTurmaDisciplina = $this->obTDbo->select('seq,
                                                     cursseq,
                                                     nomecurso,
                                                     turmseq,
                                                     nometurma,
                                                     discseq,
                                                     nomedisciplina,
                                                     cargahoraria,
                                                     nomeprofessor,
                                                     alunos,
                                                     gdavseq', $criteria);
        $obTurmaDisciplinas = $retTurmaDisciplina->fetchObject();

        $listaTurmaDisciplinas = array();
        while ($obTurmaDisciplinas = $retTurmaDisciplina->fetchObject()) {
            $listaTurmaDisciplinas[] = $obTurmaDisciplinas;
        }
        return $listaTurmaDisciplinas;
    }

    /**
     * Retorna o objeto correspondente ao relacionamento Turma x Disciplina
     * param <type> $codigoaluno
     */
    public function getTurmaDisciplina($codigoTurmaDisciplina, $fullObject = true) {

        try {
            if ($codigoTurmaDisciplina) {
            	
                $this->obTDbo->setEntidade(TConstantes::VIEW_TURMA_DISCIPLINA);
                $criteria = new TCriteria ( );
                $criteria->add(new TFilter('seq', '=', $codigoTurmaDisciplina));
                $retTurmaDisciplina = $this->obTDbo->select("*", $criteria);
                $obTurmaDisciplinas = $retTurmaDisciplina->fetchObject();

                $this->obTDbo->setEntidade(TConstantes::VIEW_PROFESSOR);
                $criteriaProf = new TCriteria ( );
                $criteriaProf->add(new TFilter('seq', '=', $obTurmaDisciplinas->profseq));
                $retProfessor = $this->obTDbo->select("nomeprofessor,nomeacao", $criteriaProf);
                $obProfessor = $retProfessor->fetchObject();

                $obProfessor->nomeacao = (($obProfessor->nomeacao != 'Alfabetizado') || ($obProfessor->nomeacao != 'Graduado')) ? "({$obProfessor->nomeacao})" : "";
                $obTurmaDisciplinas->nomeprofessor = $obProfessor->nomeprofessor . " {$obProfessor->nomeacao}";

                if($fullObject) $obTurmaDisciplinas->aulas = $this->getAula($codigoTurmaDisciplina);
                if($fullObject) $avaliacoes = $this->getAvaliacao($codigoTurmaDisciplina);
                if ($avaliacoes) {
                    foreach ($avaliacoes as $ch => $vl) {
                        if ($vl->codigopai) {
                            $obTurmaDisciplinas->recuperacoes[$ch] = $vl;
                        } else {
                            $obTurmaDisciplinas->avaliacoes[$ch] = $vl;
                        }
                    }
                } else {
                    $obTurmaDisciplinas->avaliacoes = null;
                    $obTurmaDisciplinas->recuperacoes = null;
                }

                return $obTurmaDisciplinas;
            } else {
                throw new ErrorException("O codigo do relacionamento Turma x Disciplina é invalido.");
            }
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
    }

/**
     * Retorna o objeto correspondente ao relacionamento Turma x Disciplina
     * param <type> $codigoaluno
     */
    public function getListaTurmaDisciplina($codigoListaTurmaDisciplina, $fullObject = true) {

        try {
            if ($codigoListaTurmaDisciplina) {
                
                $this->obTDbo->setEntidade(TConstantes::VIEW_TURMA_DISCIPLINA);
                $criteria = new TCriteria ( );
                foreach($codigoListaTurmaDisciplina as $codigoTurmaDisciplina){
                    $criteria->add(new TFilter('seq', '=', $codigoTurmaDisciplina), 'OR');
                }
                $retTurmaDisciplina = $this->obTDbo->select("*", $criteria);
                $listaTurmaDisciplina = array();
                while($obTurmaDisciplinas = $retTurmaDisciplina->fetchObject()){
                    $listaTurmaDisciplina[$obTurmaDisciplinas->seq] = $obTurmaDisciplinas;
                }

                $this->obTDbo->setEntidade(TConstantes::VIEW_PROFESSOR);
                $criteriaProf = new TCriteria ( );
                foreach($listaTurmaDisciplina as $obTurmaDisciplinas){
                    if($obTurmaDisciplinas->profseq)
                    	$criteriaProf->add(new TFilter('seq', '=', $obTurmaDisciplinas->profseq),'OR');                    
                }
                $retProfessor = $this->obTDbo->select("seq,nomeprofessor,nomeacao", $criteriaProf);
                
                $listaProfessor = array();
                while($obProfessor = $retProfessor->fetchObject()){
                    $obProfessor->nomeacao = (($obProfessor->nomeacao != 'Alfabetizado') || ($obProfessor->nomeacao != 'Graduado')) ? "({$obProfessor->nomeacao})" : "";
                    $listaProfessor[$obProfessor->seq] = $obProfessor;
                }

                foreach($listaTurmaDisciplina as $codigo=>$turmaDisciplina){
                    $obProfessor = $listaProfessor[$turmaDisciplinas->codigoprofessor];
                    $listaTurmaDisciplina[$codigo]->nomeprofessor = $obProfessor->nomeprofessor . " {$obProfessor->nomeacao}";

                    if($fullObject) $listaTurmaDisciplina[$codigo]->aulas = $this->getAula($codigo);
                    if($fullObject) $avaliacoes = $this->getAvaliacao($codigo);
                    if ($avaliacoes) {
                        foreach ($avaliacoes as $ch => $vl) {
                            if ($vl->codigopai) {
                                $listaTurmaDisciplina[$codigo]->recuperacoes[$ch] = $vl;
                            } else {
                                $listaTurmaDisciplina[$codigo]->avaliacoes[$ch] = $vl;
                            }
                        }
                    } else {
                        $listaTurmaDisciplina[$codigo]->avaliacoes = null;
                        $listaTurmaDisciplina[$codigo]->recuperacoes = null;
                    }
                }

                return $listaTurmaDisciplina;
            } else {
                throw new ErrorException("O codigo do relacionamento Turma x Disciplina é invalido.");
            }
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
    }
    /**
     * Lança a nota correspondente ao aluno
     * param <type> $codigoavaliacao
     * param <type> $codigoaluno
     * param <type> $nota
     */
    public function setNota($tudiseq, $codigoavaliacao,  $codigoaluno, $nota) {
        try {
           if(!$nota) $nota = 0;
            $argumentossetnota = array();
            if ($tudiseq) {
                $argumentossetnota ['tudiseq'] = $tudiseq;
                    $TAvaliacao = new TAvaliacao();
                    $avaliacao = $TAvaliacao->getAvaliacao($codigoavaliacao);
                if ($codigoavaliacao && $avaliacao) {
                    $argumentossetnota ['avalseq'] = $codigoavaliacao;
                    $argumentossetnota ['ordem'] = $avaliacao->ordem;
                    if ($codigoaluno) {
                        $argumentossetnota ['alunseq'] = $codigoaluno;
                        if ($nota >= 0 && $nota <= 10) {

                               $TSetControl = new TSetControl();
                               if(method_exists($TSetControl, $avaliacao->incontrol)){
                            
                                    $nota = call_user_func_array(array($TSetControl, $avaliacao->incontrol), array('nota'=>$nota));
                               }

                            $argumentossetnota ['nota'] = $nota;
                            $argumentossetnota ['statseq'] = 1;

                            $retNotas = new TDbo(TConstantes::DBNOTA);

                            $criteriochecagem = new TCriteria ( );
                            $criteriochecagem->add(new TFilter("avalseq", "=", $codigoavaliacao), 'AND');
                            $criteriochecagem->add(new TFilter("alunseq", "=", $codigoaluno), 'AND');
                            $criteriochecagem->add(new TFilter("tudiseq", "=", $tudiseq), 'AND');
                            $retornochecagem = $retNotas->select('seq', $criteriochecagem);

                            $arqumentoUpgrade = $retornochecagem->fetch();
                            if ($arqumentoUpgrade['seq'] == NULL) {
                                $falta = $retNotas->insert($argumentossetnota);
                            } else {
                                $falta = $retNotas->update($argumentossetnota, $criteriochecagem);
                            }
                        } else {
                            throw new ErrorException("A nota é invalida.");
                        }
                    } else {
                        throw new ErrorException("O codigo do aluno é invalido.");
                    }
                } else {
                    throw new ErrorException("O codigo da avaliação é invalido.");
                }
            } else {
                throw new ErrorException("O codigo da disciplina é invalido.");
            }
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
    }

    /**
     * Lança justificativa da falta correspondente ao aluno
     * param <type> $codigoTurmaDisciplina
     * param <type> $codigoaluno
     * param <type> $data
     * param <type> $justificativa
     */
    public function setJustificativaFalta($tudiseq, $codigoaluno, $codigoaula, $justificativa = '-') {
        try {
            if ($tudiseq) {
                $argumentossetfalta ['tudiseq'] = $tudiseq;
                if ($codigoaluno) {
                    $argumentossetfalta ['alunseq'] = $codigoaluno;
                    if ($codigoaula) {
                        $obAula = $this->getAula($tudiseq, $codigoaula);

                        $retFalta = new TDbo(TConstantes::DBFALTA);

                        $criteriochecagem = new TCriteria ( );
                        $criteriochecagem->add(new TFilter("tudiseq", "=", $tudiseq));
                        $criteriochecagem->add(new TFilter("alunseq", "=", $codigoaluno));
                        $criteriochecagem->add(new TFilter("tdalseq", "=", $obAula->seq));

                        $retornochecagem = $retFalta->update(array('justificativa' => $justificativa), $criteriochecagem);
                    } else {
                        throw new ErrorException("A data é invalida.");
                    }
                } else {
                    throw new ErrorException("O codigo do aluno é invalido.");
                }
            } else {
                throw new ErrorException("O codigo do relacionamento Turma x Disciplina é invalido.");
            }
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
    }

    /**
     * Lança a falta correspondente ao aluno
     * param <type> $codigoTurmaDisciplina
     * param <type> $codigoaluno
     * param <type> $data
     * param <type> $aula
     * param <type> $situacao
     */
    public function setFalta($tudiseq, $codigoaluno, $codigoaula, $aula = 1, $situacao = 'F') {
        try {
            $argumentossetfalta = array();
            if ($tudiseq) {
                $argumentossetfalta ['tudiseq'] = $tudiseq;
                if ($codigoaluno) {
                    $argumentossetfalta ['alunseq'] = $codigoaluno;
                    if ($codigoaula) {
                        $obAula = $this->getAula($tudiseq, $codigoaula);
                        $argumentossetfalta ['datafalta'] = $obAula->dataaula;
                        $argumentossetfalta ['frequencia'] = $aula;
                        $argumentossetfalta ['tdalseq'] = $obAula->codigo;
                        $argumentossetfalta ['statseq'] = '1';

                        if (($situacao == "F") or ($situacao == "P")) {

                            $argumentossetfalta ['situacao'] = $situacao;
                            $retFalta = new TDbo(TConstantes::DBFALTA);

                            $criteriochecagem = new TCriteria ( );
                            $criteriochecagem->add(new TFilter("tudiseq", "=", $tudiseq));
                            $criteriochecagem->add(new TFilter("alunseq", "=", $codigoaluno));
                            $criteriochecagem->add(new TFilter("tdalseq", "=", $obAula->seq));
                            $criteriochecagem->add(new TFilter("frequencia", "=", $aula));

                            $retornochecagem = $retFalta->select('id', $criteriochecagem);

                            $arqumentoUpgrade = $retornochecagem->fetch();
                            if ($arqumentoUpgrade['seq'] == NULL) {
                                $falta = $retFalta->insert($argumentossetfalta);
                            } else {
                                $falta = $retFalta->update($argumentossetfalta, $criteriochecagem);
                            }
                        } else {
                            throw new ErrorException("A situação é invalida.");
                        }
                    } else {
                        throw new ErrorException("A data é invalida.");
                    }
                } else {
                    throw new ErrorException("O codigo do aluno é invalido.");
                }
            } else {
                throw new ErrorException("O codigo do relacionamento Turma x Disciplina é invalido.");
            }
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
    }

    /**
     * Retorna a lista de alunos do relacionamento Turma x Disciplina autorizados a executar
     * param <type> $codigoTurmaDisciplina
     */
    public function getAlunosAvaliacao($codigoTurmaDisciplina, $codigoAvaliacao) {

        //Objetos para construção da lista

        $listaAlunos = $this->getAlunos($codigoTurmaDisciplina);
        $TAvaliacao = new TAvaliacao();
        $avaliacao = $TAvaliacao->getAvaliacao($codigoAvaliacao);

    		$criterio = $avaliacao->condicao;

            if ($criterio != 1) {
                $condicao = explode("?", $criterio);
                unset($condicao[0]);
                foreach ($condicao as $vl) {
                    $node = preg_replace('@AV{@', '$media[\''.$codigoTurmaDisciplina.'\']->avaliacoes[', $vl);
                    $node = preg_replace('@}@', ']->nota', $node);
                    $toDo[] = "( {$node} )";

                }
                if(is_array($toDo))
                	$toDo = implode(" AND ", $toDo);
                
            } else {
                $checagem = true;
            }
        
        foreach ($listaAlunos as $codigoAluno => $aluno) {
            $media = $TAvaliacao->getMedia($codigoAluno, $codigoTurmaDisciplina);
                                
            if(!empty($toDo)) {
            	eval('if(' . $toDo . ') { $checagem = true; } else { $checagem = false;}');
            }
             
            if($checagem){
                $alunos[$codigoAluno] = $aluno;
                $notas[$codigoAluno] = $media[$codigoTurmaDisciplina]->avaliacoes[$avaliacao->ordem]->nota;
            }
        }

        $avaliacao->alunos = $alunos;
        $avaliacao->notas = $notas;
        
        return $avaliacao;
        /*
          }else {
          $avaliacao->alunos = $listaAlunos;
          return $avaliacao;
          }
         *
         *
         */
    }

    /**
     * Retorna a lista de alunos do relacionamento Turma x Disciplina
     * param <type> $codigoTurmaDisciplina
     */
    public function getAlunos($codigoTurmaDisciplina, $situacao = "2") {
        try {
            $alunos = array();
            if ($codigoTurmaDisciplina) {
            	
                $criterio = new TCriteria();
                $criterio->add(new TFilter("tudiseq", "=", $codigoTurmaDisciplina));
                
	                if ($situacao != "all" and $situacao) {
	                    $criterio->add(new TFilter("stadseq", "=", $situacao));
	                }
	                
                $this->obTDbo->setEntidade(TConstantes::DBALUNO_DISCIPLINA);
                $retAlunos = $this->obTDbo->select('alunseq', $criterio);

                $critAlunos = new TCriteria();
                	$filtroAlunos = false;
	                while ($retAluno = $retAlunos->fetchObject()) {
	                    $critAlunos->add(new TFilter('seq', '=', $retAluno->alunseq), 'or');
	                    $filtroAlunos = true;
	                }
	            
	            if(!$filtroAlunos){
	            	throw new ErrorException("O codigo do relacionamento Turma x Disciplina não possui nenhum aluno ativo.");
	            }
                $critAlunos->setProperty('order', 'nomepessoa');
                
                $TAluno = new TAluno();
                $alunos = $TAluno->getAlunos($critAlunos);

                return $alunos;
                
            } else {
                throw new ErrorException("O codigo do relacionamento Turma x Disciplina é invalido.");
            }
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
    }

    /**
     * Retorna objeto com informações da aula Informada
     * param <type> $codigoaula
     * */
    public function getAula($codigoTurmaDisciplina, $codigoAula=NULL) {

        try {

            $this->obTDbo->setEntidade(TConstantes::DBTURMA_DISCIPLINA_AULA);
            if ($codigoAula) {
                $criterio = new TCriteria ( );
                $criterio->add(new TFilter("seq", "=", $codigoAula));
                $criterio->add(new TFilter("tudiseq", "=", $codigoTurmaDisciplina));
                $criterio->setProperty('order', 'dataaula');
                $retornoAula = $this->obTDbo->select("*", $criterio);

                $aula = $retornoAula->fetchObject();

                $obTDbo = new TDbo(TConstantes::DBFALTA);
                $criterio2 = new TCriteria();
                $criterio2->add(new TFilter("tdalseq", "=", $aula->seq));
                $criterio2->add(new TFilter("deferido", "=", true));
                $criterio2->setProperty('order', 'frequencia');
                $retornoFaltas = $obTDbo->select("tdalseq,alunseq,frequencia,justificativa,deferido", $criterio2);

                while ($ret = $retornoFaltas->fetchObject()) {
                    $num = $ret->frequencia;
                    $aluno = $ret->codigoaluno;
                    $aula->justificativa[$aluno] = ($ret->justificativa != null ) ? $ret->justificativa : $aula->justificativa[$aluno];
                    $aula->faltas[$num][$aluno] = $ret->deferido;
                }
            } else {
                $criterio = new TCriteria ( );
                $criterio->add(new TFilter("tudiseq", "=", $codigoTurmaDisciplina));
                $criterio->setProperty('order', 'dataaula');
                $retornoAula = $this->obTDbo->select("*");
                $retorno = null;
                while ($retorno = $retornoAula->fetchObject()) {
                    $aula[$retorno->seq] = $retorno;
                    $this->obTDbo->setEntidade(TConstantes::DBFALTA);
                    $criterio = new TCriteria ( );
                    $criterio->add(new TFilter("tudiseq", "=", $codigoTurmaDisciplina));
                    $criterio->add(new TFilter("tdalseq", "=", $retorno->seq));
                    $criterio->add(new TFilter("deferido", "=", 'true', 'boolean'));
                    $retornoFaltas = $this->obTDbo->select("tdalseq,alunseq,frequencia,justificativa,deferido", $criterio);
                    while ($ret = $retornoFaltas->fetchObject()) {
                        $num = $ret->frequencia;
                        $aluno = $ret->alunseq;
                        $aula[$ret->tdalseq]->justificativa[$aluno] = ($ret->justificativa != null) ? $ret->justificativa : $aula[$ret->tdalseq]->justificativa[$aluno];
                        $aula[$ret->tdalseq]->faltas[$num][$aluno] = $ret->deferido;
                    }
                }
            }
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
        return $aula;
    }

    /**
     * Retorna objeto com informações da aula Informada
     * param <type> $codigoaula
     * */
    public function getAvaliacao($codigoTurmaDisciplina, $codigoAvaliacao=NULL) {

        try {
            $this->obTDbo->setEntidade(TConstantes::DBTURMA_DISCIPLINA_AVALIACAO);
            if ($codigoAvaliacao) {
                $criterio = new TCriteria ();
                $criterio->add(new TFilter("seq", "=", $codigoAvaliacao));
                $criterio->add(new TFilter("tudiseq", "=", $codigoTurmaDisciplina));

                $retornoAvaliacao = $this->obTDbo->select("*", $criterio);
                $avaliacao = $retornoAvaliacao->fetchObject();

                $obTDbo = new TDbo(TConstantes::DBNOTA);
                $criterio2 = new TCriteria();
                $criterio2->add(new TFilter("avalseq", "=", $avaliacao->seq));
                $retornoFaltas = $obTDbo->select("avalseq,alunseq,nota", $criterio2);

                while ($ret = $retornoFaltas->fetchObject()) {
                    $aluno = $ret->alunseq;
                    $avaliacao->notas[$aluno] = $ret->nota;
                }
            } else {
                $criterio = new TCriteria ();
                $criterio->add(new TFilter("tudiseq", "=", $codigoTurmaDisciplina));
                $retornoAvaliacao = $this->obTDbo->select("*", $criterio);
                $retorno = null;
                while ($retorno = $retornoAvaliacao->fetchObject()) {

                    $avaliacao[$retorno->seq] = $retorno;
                    $obTDbo = new TDbo(TConstantes::DBNOTA);
                    $criterio2 = new TCriteria();
                    $criterio2->add(new TFilter("avalseq", "=", $retorno->seq));
                    $retornoFaltas = $obTDbo->select("avalseq,alunseq,nota", $criterio2);

                    while ($ret = $retornoFaltas->fetchObject()) {
                        $aluno = $ret->alunseq;
                        $avaliacao[$retorno->seq]->notas[$aluno] = $ret->nota;
                    }
                }
            }

            return $avaliacao;
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
        return $avaliacao;
    }

    /**
     * Lança presença inicial para todos os alunos da disciplina
     * param <type> $codigoTurmaDisciplina
     * param <type> $data
     * param <type> $numAulas (numero de presenças)
     * param <type> $situacao
     */
    public function setPresencaAlunos($tudiseq, $codigoAula, $entidade = NULL) {
        try {
            if ($codigoAula) {
                $TAula = $this->getAula($tudiseq, $codigoAula);
                $listaAlunos = $this->getAlunos($tudiseq);
                $aula = 1;
                while ($aula <= $TAula->frequencia) {

                    foreach ($listaAlunos as $aluno) {
                        $this->setFalta($tudiseq, $aluno->seq, $TAula->seq, $aula, 'P');
                    }
                    $aula++;
                }
            } else {
                throw new ErrorException("O codigo da aula é invalido.");
            }
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
    }
	
    /**
     * 
     * @param $formseq
     * @param $x
     */
    public function viewSetFaltasAlunos($formseq, $x) {
    	

        $THeader = new TSetHeader();
        $header = $THeader->getHead('364', 'seq');
        $header2 = $THeader->getHead('370', 'seq');
        $codigoAula = ($header) ? $header : $header2;
        //$codigoAula = $formseq;

        $this->obTDbo->setEntidade(TConstantes::DBTURMA_DISCIPLINA_AULA);
        $criterio = new TCriteria ( );
        $criterio->add(new TFilter("seq", "=", $codigoAula));
        $retornoAula = $this->obTDbo->select("tudiseq", $criterio);
        $obAula = $retornoAula->fetchObject();


        //Objetos para construção da lista
        $listaAlunos = $this->getAlunos($obAula->tudiseq);


        $aula = $this->getAula($obAula->tudiseq, $codigoAula);
        //Monta lista com os alunos
        $obLista = new TDatagrid();

        $obLista->addColumn(new TDataGridColumn('seq', 'Matr�cula', 'center', '100px'));
        $obLista->addColumn(new TDataGridColumn('nomealuno', 'Nome', 'left', '350px'));

        $countCols = 1;
        while ($countCols <= $aula->frequencia) {
            $obLista->addColumn(new TDataGridColumn('aula' . $countCols, $countCols . 'ª aula', 'center', '60px'));
            $countCols++;
        }

        $obLista->addColumn(new TDataGridColumn('just', 'Justificativa', 'center', '250px'));

        $obLista->createModel('100%');

        foreach ($listaAlunos as $obAluno) {
            $item['seq'] = $obAluno->seq;
            $item['nomealuno'] = $obAluno->nomepessoa;
            $contCampo = 1;
            while ($contCampo <= $aula->frequencia) {
                $aluno = $obAluno->seq;
                $campo = new TCheckButton('aluno-' . $obAluno->seq . '-aula-' . $aula->seq . '-frequencia-' . $contCampo);
                $campo->id = 'aluno-' . $obAluno->seq . '-aula-' . $aula->seq . '-frequencia-' . $contCampo;
                $campo->setValue("F");
                $campo->onclick = 'setAlunoFalta(\'' . $campo->id . '\',\'' . $obAula->tudiseq . '\',\'' . $obAluno->seq . '\',\'' . $aula->seq . '\',\'' . $contCampo . '\');setJustificativa(\'just' . $obAluno->seq . '\',\'' . $obAula->tudiseq . '\',\'' . $obAluno->seq . '\',\'' . $aula->seq . '\')';
                if ($aula->faltas[$contCampo][$aluno] == true) {
                    $campo->checked = 'checked';
                }


                $item['aula' . $contCampo] = $campo;
                $contCampo++;
            }

            $justificativa = new TEntry('just' . $obAluno->seq);
            $justificativa->setSize('250');
            $justificativa->onchange = 'setJustificativa(\'just' . $obAluno->seq . '\',\'' . $obAula->tudiseq . '\',\'' . $obAluno->seq . '\',\'' . $aula->seq . '\')';
            $justificativa->setValue($aula->justificativa[$aluno]);
            $item['just'] = $justificativa;
            $obLista->addItem($item);
        }

        $listaAlunos = new TElement("fieldset");
        $listaAlunos->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
        $listaAlunosLegenda = new TElement("legend");
        $listaAlunosLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
        $listaAlunosLegenda->add("Lançamento de Faltas");
        $listaAlunos->add($listaAlunosLegenda);

        $content = new TElement('div');
        $content->class = "ui_bloco_conteudo";
        $content->add($obLista);
        $listaAlunos->add($content);

        $obAlunos = new TElement('div');
        $obAlunos->add($listaAlunos);

        return $obAlunos;
    }
	
    /**
     * 
     * @param $codigoAvaliacao
     */
    public function viewSetNotasAlunos($codigoAvaliacao) {

    	$THeader = new TSetHeader();
        $subHeader = $THeader->getHead('58');
    	
        /*
          $this->obTDbo->setEntidade ( TConstantes::DBTURMA_DISCIPLINA_AVALIACAO );
          $criterio = new TCriteria ( );
          $criterio->add ( new TFilter ( "codigo", "=", $codigoAvaliacao ) );
          $retornoAula = $this->obTDbo->select ( "tudiseq", $criterio );
          $obAula = $retornoAula->fetchObject();
         */
        $aula = $this->getAlunosAvaliacao($codigoTurmaDisciplina, $codigoAvaliacao);
        
        //Monta lista com os alunos
        $obLista = new TDatagrid();

        $obLista->addColumn(new TDataGridColumn('seq', 'Matrícula', 'center', '200px'));
        $obLista->addColumn(new TDataGridColumn('nomealuno', 'Nome', 'left', '450px'));
        $obLista->addColumn(new TDataGridColumn('nota', 'Nota', 'center', '5'));

        $obLista->createModel('100%');

        foreach ($aula->alunos as $obAluno) {

            $aluno = $obAluno->codigo;
            $campo = new TEntry('aluno-' . $obAluno->seq . '-avaliacao-' . $aula->seq);
            $campo->id = 'aluno-' . $obAluno->seq . '-avaliacao-' . $aula->seq;
            $campo->setValue($aula->notas[$obAluno->seq]);
            $campo->onchange = 'setAlunoNota(\'' . $campo->id . '\',\'' . $codigoTurmaDisciplina . '\',\'' . $obAluno->seq . '\',\'' . $aula->seq . '\')';


            $item['seq'] = $obAluno->seq;
            $item['nomealuno'] = $obAluno->nomepessoa;
            $item['nota'] = $campo;
            $obLista->addItem($item);
        }

        $listaAlunos = new TElement("fieldset");
        $listaAlunos->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
        $listaAlunosLegenda = new TElement("legend");
        $listaAlunosLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
        $listaAlunosLegenda->add("Lançamento de Notas");
        $listaAlunos->add($listaAlunosLegenda);

        $content = new TElement('div');
        $content->class = "ui_bloco_conteudo";
        $content->add($obLista);
        $listaAlunos->add($content);

        $obAlunos = new TElement('div');
        $obAlunos->add($listaAlunos);

        return $obAlunos;
    }

    /**
     * 
     * @param unknown_type $id
     */
    public function getTipoArquivo($id) {

        switch ($id) {
            case 1: $retorno = "Orientação";
                break;
            case 2: $retorno = "Arquivo";
                break;
        }
        return $retorno;
    }
    
    /**
     * 
     * @param $formseq
     */
    public function setTransacaoProfessor($formseq){
    	
    	try {

            $obHeader = new TSetHeader();
            $headerForm = $obHeader->getHead($formseq,'seq');
            
            $transaction = new TDbo();
            
            $transaction->setEntidade(TConstantes::VIEW_TURMA_DISCIPLINA);
            
            $criterioDisciplina = new TCriteria();
            $criterioDisciplina->add(new Tfilter('seq','=',$headerForm));
            
            $retDisciplina = $transaction->select('*',$criterioDisciplina);

            $obDisciplina = $retDisciplina->fetchObject();
            
            
				/** Procura produto */
            $transaction->setEntidade(TConstantes::DBPRODUTO);
            $criterio = new TCriteria();
            $criterio->add(new TFilter('label','=','Serviços Educacionais'),'AND');
            $criterio->add(new TFilter('codigotipoproduto','=','10004326-826'),'AND');

            $retConsultaProduto = $transaction->select('seq',$criterio);
            
            $obConsultaProduto = $retConsultaProduto->fetchObject();
            
            if($obConsultaProduto->seq){
            	$codigoProduto = $obConsultaProduto->codigo;
	        }else{
	            $produto['label'] = "Serviços Educacionais";
	            $produto['descricao'] = "Hora Aula";
	            $produto['codigotipoproduto'] = "10004326-826";
            	
	            $retInsercaoProduto = $transaction->insert($produto);
	            $codigoProduto = $retInsercaoProduto['seq'];
            }
           
            
            $valorTotal = $obDisciplina->cargahoraria * $obDisciplina->custohoraaula;
            
            $transaction->setEntidade(TConstantes::DBFUNCIONARIO);
            $critPessoa = new TCriteria();
            $critPessoa->add(new TFilter('seq','=',"(SELECT t9.funcseq FROM dbprofessor t9 WHERE t9.seq = '{$obDisciplina->profseq}' limit 1)"));
            
            $retPessoa = $transaction->select('pessseq',$critPessoa);
            
            $obPessoa = $retPessoa->fetchObject();

                $crit = new TCriteria();
                $crit->add(new TFilter('seq', '=', $headerForm['codigoPai']));

                $transacao = array();
                $transacao['pessseq'] = $obPessoa->pessseq;
                $transacao['valortotal'] = $valorTotal;
                $transacao['statseq'] = '1';

                $transaction->setEntidade(TConstantes::DBTRANSACAO);

                $retTransacao = $transaction->insert($transacao);

                if ($retTransacao['seq']) {

                    $transaction->setEntidade(TConstantes::DBTRANSACAO_PRODUTO);

                    $critUpdate = new TCriteria();
                        $toInsert['transeq'] = $retTransacao['seq'];
                        $toInsert['prodseq'] = $codigoProduto;
                        $toInsert['tabelaproduto'] = 'dbproduto';
                        $toInsert['valornominal'] = $valorTotal;
                        $toInsert['statseq'] = '1';

                        $retInsert = $transaction->insert($toInsert);
                        if (!$retInsert) {
                            throw new ErrorException("Não foi possível concluir. A ação foi cancelada.", 1);
                        }
                        $transaction->commit();
                        return $retTransacao['seq'];
                        
                }
        } catch (Exception $e) {
            new setException($e, 2);
        }
    }

    public function consolidaNotasFrequencias($listaTurmasDisciplinas = array()){
        try {

            $criteria = new TCriteria();
            $criteria->add(new TFilter('situacao','=','2'),'AND');  
            $criteriaNotas = new TCriteria();
            $criteriaFaltas = new TCriteria();            
            $criteriaFaltas->add(new TFilter('deferido', '=', true),'AND');
            $criteriaTurmasDisciplinas = new TCriteria();

            $sqlDelete = "delete from ".TConstantes::RELATORIO_ALUNO_NOTA_FREQUENCIA." where tudiseq = '1'";

            foreach($listaTurmasDisciplinas as $turmadisciplina){
                $criteria->add(new TFilter('tudiseq','=',$turmadisciplina,'numeric', '99'),'OR');
                $criteriaFaltas->add(new TFilter('tudiseq','=',$turmadisciplina,'numeric', '99'),'OR');
                $criteriaNotas->add(new TFilter('tudiseq','=',$turmadisciplina),'OR');
                $criteriaTurmasDisciplinas->add(new TFilter('seq','=',$turmadisciplina),'OR');
                $sqlDelete .= " or tudiseq = '{$turmadisciplina}'";
            }

            $this->obTDbo->sqlExec($sqlDelete);

            $this->obTDbo->setEntidade(TConstantes::DBALUNO_DISCIPLINA);
            $retAlunos = $this->obTDbo->select('alunseq,tudiseq',$criteria);

            $listaAlunos = array();

            $sqlAlunos = "select al.seq,pe.pessnmrz as aluno from dbpessoa pe inner join dbaluno al on al.pessseq = pe.seq and (pe.seq = '1' ";
            while($obAluno = $retAlunos->fetchObject()){
                if(!$listaAlunos[$obAluno->tudiseq])
                    $listaAlunos[$obAluno->tudiseq] = array();
                $sqlAlunos .= " or al.seq = '{$obAluno->alunseq}'";
                $listaAlunos[$obAluno->tudiseq][$obAluno->alunseq] = array("notas"=>array(),"faltas"=>0);
            }  

            $sqlAlunos .= ')';          

            $this->obTDbo->setEntidade("DBNOTA");
            $notasQuery = $this->obTDbo->select("alunseq,avalseq, tudiseq, nota, ordem", $criteriaNotas);

            while ($obNota = $notasQuery->fetchObject()) {
               $listaAlunos[$obNota->tudiseq][$obNota->alunseq]["notas"][$obNota->ordem] = $obNota->nota;
            }

            $alunosNomes = array();
            $retAlunosNomes = $this->obTDbo->sqlExec($sqlAlunos);
            while ($obAlunoNome = $retAlunosNomes->fetchObject()) {
                $alunosNomes[$obAlunoNome->seq] = $obAlunoNome->aluno;
            }

            $gradeAvaliacoes = array();

            $this->obTDbo->setEntidade(TConstantes::DBAVALIACAO);
            $critGrade = new TCriteria();
            $critGrade->add(new TFilter("statseq", "=", '1'));
            $critGrade->setProperty('order', 'ordem');
            $gradeQuery = $this->obTDbo->select("*", $critGrade);            
            
            while ($obAvaliacao = $gradeQuery->fetchObject()) {
                if(!$gradeAvaliacoes[$obAvaliacao->gdavseq])
                    $gradeAvaliacoes[$obAvaliacao->gdavseq] = array();
                $gradeAvaliacoes[$obAvaliacao->gdavseq][$obAvaliacao->ordem] = $obAvaliacao;
            }
            
            $this->obTDbo->setEntidade(TConstantes::DBFALTA);
            $retFaltas = $this->obTDbo->select("*", $criteria);

            while ($obFaltas = $retFaltas->fetchObject()) {
                $listaAlunos[$obFaltas->tudiseq][$obFaltas->alunseq]["faltas"]++;
            }

            $this->obTDbo->setEntidade(TConstantes::VIEW_TURMA_DISCIPLINA);
            $retTurmasDisciplinas = $this->obTDbo->select("*",$criteriaTurmasDisciplinas);
            $listaTurmasDisciplinas = array();

            while($obTurmaDisciplina = $retTurmasDisciplinas->fetchObject())
                $listaTurmasDisciplinas[$obTurmaDisciplina->seq] = $obTurmaDisciplina;

            $TUnidade = new TUnidade();
            $TParametros = $TUnidade->getParametro();
            $TAluno = new TAluno();
            $TAvaliacao = new TAvaliacao();

            $cols = "aluno,
                     matricula,
                     tudiseq,
                     disciplina,
                     curso,
                     turma,
                     nota,
                     frequencia,
                     professor,
                     aprovacaofrequencias,
                     aprovacaomedia,
                     aprovacaogeral";      

            $sql = "insert into ".TConstantes::RELATORIO_ALUNO_NOTA_FREQUENCIA." ({$cols}) values ";

            foreach($listaAlunos as $turmadisciplina=>$alunos){
                foreach($alunos as $aluno=>$listaNotasFrequencias){
                    $media = 'NULL';
                    
                    $avaliacoes = $gradeAvaliacoes[$listaTurmasDisciplinas[$turmadisciplina]->gdavseq];
                    if(sizeof($avaliacoes) > 0){

                        foreach($avaliacoes as $ordem => $av)
                            $avaliacoes[$ordem]->nota = "0.00";

                        if(sizeof($listaNotasFrequencias["notas"])  > 0)
                            foreach($listaNotasFrequencias["notas"] as $ordem => $nota)
                                $avaliacoes[$ordem]->nota = $nota;

                        $media = $TAvaliacao->processaMedia($avaliacoes);

                    }
                    

                    $faltas = $listaNotasFrequencias["faltas"];
                    $frequencia = $listaTurmasDisciplinas[$turmadisciplina]->frequencia;

                    if ($frequencia > 0)
                        $frequencia = round(((100 * ($frequencia - $faltas)) / $frequencia) * 10) / 10;
                    else
                        $frequencia = "NULL";

                    if ($frequencia >= $TParametros->academico_mediapresenca)
                        $aprovacaofrequencias = "TRUE";
                    else
                        $aprovacaofrequencias = "FALSE";

                    if ($media != 'NULL' && $media >= $TParametros->academico_medianotas)
                        $aprovacaonotas = "TRUE";
                    else
                        $aprovacaonotas = "FALSE";

                    if ($aprovacaonotas == "TRUE" and $aprovacaofrequencias == "TRUE")
                        $aprovacaogeral = "TRUE";
                    else
                        $aprovacaogeral = "FALSE";

                    $sql .= "('{$alunosNomes[$aluno]}',
                             '{$aluno}',
                             '{$turmadisciplina}',
                             '{$listaTurmasDisciplinas[$turmadisciplina]->nomedisciplina}',
                             '{$listaTurmasDisciplinas[$turmadisciplina]->nomecurso}',
                             '{$listaTurmasDisciplinas[$turmadisciplina]->nometurma}',
                              {$media},
                              {$frequencia},
                             '{$listaTurmasDisciplinas[$turmadisciplina]->nomeprofessor}',
                              {$aprovacaofrequencias},
                              {$aprovacaonotas},
                              {$aprovacaogeral}),";
                }
            }

            $sql = substr($sql,0,-1);

            $this->obTDbo->sqlExec($sql);

            $this->obTDbo->commit();

            $ob = new TElement('div');
            $ob->align = "center";
            $ob->style = "background-color:#FFFF99; margin: 10px; padding: 10px;";
            $ob->class = "ui-state-highlight";
            $ob->add("Todas as disciplinas selecionadas foram consolidadas.");

            return $ob;

        }catch(Exception $e){
            new setException($e, 2);
        }
    }

}