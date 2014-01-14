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


    public function updateDataAtualizacao($tudiseq){
    	try {
    		$tdboTurmaDisciplina = new TDbo(TConstantes::DBTURMA_DISCIPLINA);
    		$critTurmaDisciplina = new TCriteria();
    		$critTurmaDisciplina->add(new TFilter("seq", "=", $tudiseq));
    		$tdboTurmaDisciplina->update(array("dataatualizacao"=>date("Y-m-d")), $critTurmaDisciplina);
    	}catch (Exception $e){
            new setException($e);
    	}
    }
    
    public function getTurmasDisciplinasAtivas(){
        $this->obTDbo->setEntidade(TConstantes::VIEW_TURMA_DISCIPLINA);
        $criteria = new TCriteria();
        $criteria->add(new TFilter('sttuseq','=','1'),"OR");
        $criteria->add(new TFilter('sttuseq','=','5'),"OR");
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

                if($obTurmaDisciplinas->profseq){
                	$this->obTDbo->setEntidade(TConstantes::VIEW_PROFESSOR);
                	$criteriaProf = new TCriteria ( );
                	$criteriaProf->add(new TFilter('seq', '=', $obTurmaDisciplinas->profseq));
                	$retProfessor = $this->obTDbo->select("nomeprofessor,nomeacao", $criteriaProf);
                	$obProfessor = $retProfessor->fetchObject();
                	
                	$obProfessor->nomeacao = (($obProfessor->nomeacao != 'Alfabetizado') || ($obProfessor->nomeacao != 'Graduado')) ? "({$obProfessor->nomeacao})" : "";

                	$obTurmaDisciplinas->nomeprofessor = $obProfessor->nomeprofessor . " {$obProfessor->nomeacao}";
                }

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
                            
                            $this->updateDataAtualizacao($tudiseq);

                            $arqumentoUpgrade = $retornochecagem->fetch();
                            if ($arqumentoUpgrade['seq'] == NULL) {
                                $falta = $retNotas->insert($argumentossetnota);
                            } else {
                                $falta = $retNotas->update($argumentossetnota, $criteriochecagem);
                                $this->obTDbo->commit();
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
                        
                        $this->updateDataAtualizacao($tudiseq);
                        
                        $retFalta->commit();
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
                        $argumentossetfalta ['tdalseq'] = $codigoaula;
                        $argumentossetfalta ['statseq'] = '1';

                        if (($situacao == "F") or ($situacao == "P")) {

                            $argumentossetfalta ['deferido'] = $situacao == "P" ? false : true;
                            $retFalta = new TDbo(TConstantes::DBFALTA);

                            $criteriochecagem = new TCriteria ( );
                            $criteriochecagem->add(new TFilter("tudiseq", "=", $tudiseq));
                            $criteriochecagem->add(new TFilter("alunseq", "=", $codigoaluno));
                            $criteriochecagem->add(new TFilter("tdalseq", "=", $obAula->seq));
                            $criteriochecagem->add(new TFilter("frequencia", "=", $aula));

                            $retornochecagem = $retFalta->select('seq', $criteriochecagem);

                            $arqumentoUpgrade = $retornochecagem->fetch();
                            if ($arqumentoUpgrade['seq'] == NULL) {
                                $falta = $retFalta->insert($argumentossetfalta);
                            } else {
                                $falta = $retFalta->update($argumentossetfalta, $criteriochecagem);
                            }
                            

                            $this->updateDataAtualizacao($tudiseq);
                            
                            $retFalta->commit();
                            
                            
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
	            	return array();//throw new ErrorException("O codigo do relacionamento Turma x Disciplina não possui nenhum aluno ativo.");
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
                $criterio2->add(new TFilter("deferido", "=", true, 'boolean'));
                $criterio2->setProperty('order', 'frequencia');
                $retornoFaltas = $obTDbo->select("tdalseq,alunseq,frequencia,justificativa,deferido", $criterio2);

                while ($ret = $retornoFaltas->fetchObject()) {
                    $num = $ret->frequencia;
                    $aluno = $ret->alunseq;
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
    public function viewSetFaltasAlunos($codigoAula, $formseq) {

    	$this->obTDbo->setEntidade(TConstantes::DBTURMA_DISCIPLINA_AULA);
        $criterio = new TCriteria ( );
        $criterio->add(new TFilter("seq", "=", $codigoAula));
        $retornoAula = $this->obTDbo->select("tudiseq", $criterio);
        $obAula = $retornoAula->fetchObject();

       	$tudiseq = $obAula->tudiseq;

        //Objetos para construção da lista
        $listaAlunos = $this->getAlunos($tudiseq);

		if($codigoAula){
        	$aula = $this->getAula($tudiseq, $codigoAula);			
		}
        //Monta lista com os alunos
        $obLista = new TDatagrid();

        $obLista->addColumn(new TDataGridColumn('seq', 'Matrícula', 'center', '100px'));
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
        	$TUnidade = new TUnidade();
        	$avalseq = $TUnidade->getParametro("avaliacao_padrao");

            $criteria = new TCriteria();
            $criteria->add(new TFilter('stadseq','=','2'),'AND');  
            $criteriaNotas = new TCriteria();
            $criteriaNotas->add(new TFilter("avalseq", "=", $avalseq));
            $criteriaFaltas = new TCriteria();            
            $criteriaFaltas->add(new TFilter('deferido', '=', true, 'boolean'),'AND');
            $criteriaTurmasDisciplinas = new TCriteria();

            $sqlDelete = "delete from ".TConstantes::ALUNO_NOTA_FREQUENCIA." where tudiseq = '1'";

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
                $listaAlunos[$obAluno->tudiseq][$obAluno->alunseq] = array("nota"=>0,"faltas"=>0);
            }  

            $sqlAlunos .= ')';          

            if(count($listaAlunos) > 0){
            $this->obTDbo->setEntidade("DBNOTA");
            $notasQuery = $this->obTDbo->select("alunseq,avalseq, tudiseq, nota", $criteriaNotas);

            while ($obNota = $notasQuery->fetchObject()) {
               $listaAlunos[$obNota->tudiseq][$obNota->alunseq]['nota'] = $obNota->nota;
            }

            $alunosNomes = array();
            $retAlunosNomes = $this->obTDbo->sqlExec($sqlAlunos);
            while ($obAlunoNome = $retAlunosNomes->fetchObject()) {
                $alunosNomes[$obAlunoNome->seq] = $obAlunoNome->aluno;
            }

            /*
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
            } */
            
            $this->obTDbo->setEntidade(TConstantes::DBFALTA);
            $retFaltas = $this->obTDbo->select("*", $criteriaFaltas);

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
                     alunseq,
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

            $sql = "insert into ".TConstantes::ALUNO_NOTA_FREQUENCIA." ({$cols}) values ";

            foreach($listaAlunos as $turmadisciplina=>$alunos){
                foreach($alunos as $aluno=>$listaNotasFrequencias){
                    $media = 'NULL';
                    
                    /* $avaliacoes = $gradeAvaliacoes[$listaTurmasDisciplinas[$turmadisciplina]->gdavseq];
                    if(sizeof($avaliacoes) > 0){

                        foreach($avaliacoes as $ordem => $av)
                            $avaliacoes[$ordem]->nota = "0.00";

                        if(is_array($listaNotasFrequencias["notas"]) && count($listaNotasFrequencias["notas"])  > 0){
                        	foreach($listaNotasFrequencias["notas"] as $ordem => $nota){
                                $avaliacoes[$ordem]->nota = $nota;
                        	}
                        }

                        $media = $TAvaliacao->processaMedia($avaliacoes);

                    } */
                    
                    $media = $listaNotasFrequencias["nota"];
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
            }
            
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

    public function viewLancamentoNota($tudiseq) {
    	$TUnidade = new TUnidade();
    	try {
    		if($tudiseq) {
    			$turmaDisciplina = $this->getTurmaDisciplina($tudiseq,false); 
    			$alunos = $this->getAlunos($tudiseq);
    			$avalseq = $TUnidade->getParametro("avaliacao_padrao");
    			$listaNotas = array();
    			
    			$obTDbo = new TDbo(TConstantes::DBNOTA);
    			$criterio = new TCriteria();
    			$criterio->add(new TFilter("tudiseq", "=", $tudiseq));
    			$criterio->add(new TFilter("avalseq", "=", $avalseq));
    			$obSelectNotas = $obTDbo->select("alunseq,nota",$criterio);
    			
    			while($obNota = $obSelectNotas->fetchObject()){
    				$listaNotas[$obNota->alunseq] = $obNota->nota;
    			}
    			
    			$tabHead = new TElement("fieldset");
    			$tabHead->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
    			$tabHeadLegenda = new TElement("legend");
    			$tabHeadLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
    			$tabHeadLegenda->add("Informações da Disciplina");
    			$tabHead->add($tabHeadLegenda);
    
    			$obFieds = new TSetfields();
    			$obFieds->geraCampo("Curso:", 'curso', "TEntry", '');
    			$obFieds->setProperty('curso', 'disabled', 'disabled');
    			$obFieds->setValue("curso", $turmaDisciplina->nomecurso);
    
    			$obFieds->geraCampo("Turma:", 'turma', "TEntry", '');
    			$obFieds->setProperty('turma', 'disabled', 'disabled');
    			$obFieds->setProperty('turma', 'size', '60');
    			$obFieds->setValue("turma", $turmaDisciplina->nometurma);
    
    			$obFieds->geraCampo("Disciplina:", 'disciplina', "TEntry", '');
    			$obFieds->setProperty('disciplina', 'disabled', 'disabled');
    			$obFieds->setProperty('disciplina', 'size', '60');
    			$obFieds->setValue("disciplina", $turmaDisciplina->nomedisciplina);
    
    			$obFieds->geraCampo("Professor:", 'professor', "TEntry", '');
    			$obFieds->setProperty('professor', 'disabled', 'disabled');
    			$obFieds->setProperty('professor', 'size', '60');
    			$obFieds->setValue("professor", $turmaDisciplina->nomeprofessor);
    
    			$content = new TElement('div');
    			$content->class = "ui_bloco_conteudo";
    			$content->add($obFieds->getConteiner());
    			$tabHead->add($content);
    
    			$listaAlunos = new TElement("fieldset");
    			$listaAlunos->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
    			$alunosLegenda = new TElement("legend");
    			$alunosLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
    			$alunosLegenda->add("Alunos");
    			$listaAlunos->add($alunosLegenda);
    
    			$datagrid = new TDataGrid();
    
    			$datagrid->addColumn(new TDataGridColumn('matricula', 'Matrícula', 'center', '80px'));
    			$datagrid->addColumn(new TDataGridColumn('nomealuno', 'Nome do Aluno', 'left', '300px'));
    			$datagrid->addColumn(new TDataGridColumn('nota', 'Nota', 'center', '100px'));
    			$datagrid->createModel('100%');
    
    			foreach($alunos as $key => $obAluno) {
    				$tempDisc = array();
    				$tempDisc['matricula'] = $obAluno->seq;
    				$tempDisc['nomealuno'] = $obAluno->nomepessoa;
    				
    				$campoNota = new TEntry('nota'.$obAluno->seq);
    				$campoNota->setProperty('onkeypress', 'validaValorNota(this)');
    				$campoNota->setProperty('onchange', 'validaValorNota(this);setAlunoNota(\'nota'.$obAluno->seq.'\','.$tudiseq.','.$obAluno->seq.','.$avalseq.')');
    				$campoNota->setProperty('placeholder', 'Nota');
    				$campoNota->setProperty('style', 'text-align:center;');
    				
    				if(key_exists($key, $listaNotas)){
    					$campoNota->setValue($listaNotas[$obAluno->seq]);
    				}
    				
    				$campoNota->setSize(60);
    				
    				$tempDisc['nota'] = $campoNota;
    				
    				$datagrid->addItem($tempDisc);
    			}
    			$content = new TElement('div');
    			$content->class = "ui_bloco_conteudo";
    			$content->add($datagrid);
    			$listaAlunos->add($content);
    
    
    			$obAluno = new TElement('div');
    			$obAluno->add($tabHead);
    			$obAluno->add($listaAlunos);
    
    		}else {
    			throw new ErrorException("O codigo ".$tudiseq." não é referente a uma disciplina válida.");
    		}
    	}catch (Exception $e) {
    		$this->obTDbo->rollback();
    		new setException($e);
    	}
    
    	return $obAluno;
    }
}