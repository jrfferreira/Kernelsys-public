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

    /**
     * Retorna o objeto correspondente ao relacionamento Turma x Disciplina
     * param <type> $codigoaluno
     */
    public function getTurmaDisciplina($codigoTurmaDisciplina) {

        try {
            if ($codigoTurmaDisciplina) {
            	
                $this->obTDbo->setEntidade(TConstantes::VIEW_TURMAS_DISCIPLINAS);
                $criteria = new TCriteria ( );
                $criteria->add(new TFilter('codigo', '=', $codigoTurmaDisciplina));
                $retTurmaDisciplina = $this->obTDbo->select("*", $criteria);
                $obTurmaDisciplinas = $retTurmaDisciplina->fetchObject();

                $this->obTDbo->setEntidade(TConstantes::VIEW_FUNCIONARIOS_PROFESSORES);
                $criteriaProf = new TCriteria ( );
                $criteriaProf->add(new TFilter('codigo', '=', $obTurmaDisciplinas->codigoprofessor));
                $retProfessor = $this->obTDbo->select("nomeprofessor,nomeacao", $criteriaProf);
                $obProfessor = $retProfessor->fetchObject();

                $obProfessor->nomeacao = (($obProfessor->nomeacao != 'Alfabetizado') || ($obProfessor->nomeacao != 'Graduado')) ? "({$obProfessor->nomeacao})" : "";
                $obTurmaDisciplinas->nomeprofessor = $obProfessor->nomeprofessor . " {$obProfessor->nomeacao}";

                $obTurmaDisciplinas->aulas = $this->getAula($codigoTurmaDisciplina);
                $avaliacoes = $this->getAvaliacao($codigoTurmaDisciplina);
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
     * Lança a nota correspondente ao aluno
     * param <type> $codigoavaliacao
     * param <type> $codigoaluno
     * param <type> $nota
     */
    public function setNota($codigoturmadisciplina, $codigoavaliacao,  $codigoaluno, $nota) {
        try {
           if(!$nota) $nota = 0;
            $argumentossetnota = array();
            if ($codigoturmadisciplina) {
                $argumentossetnota ['codigoturmadisciplina'] = $codigoturmadisciplina;
                    $TAvaliacao = new TAvaliacao();
                    $avaliacao = $TAvaliacao->getAvaliacao($codigoavaliacao);
                if ($codigoavaliacao && $avaliacao) {
                    $argumentossetnota ['codigoavaliacao'] = $codigoavaliacao;
                    $argumentossetnota ['ordemavaliacao'] = $avaliacao->ordem;
                    if ($codigoaluno) {
                        $argumentossetnota ['codigoaluno'] = $codigoaluno;
                        if ($nota >= 0 && $nota <= 10) {

                               $TSetControl = new TSetControl();
                               if(method_exists($TSetControl, $avaliacao->incontrol)){
                            
                                    $nota = call_user_func_array(array($TSetControl, $avaliacao->incontrol), array('nota'=>$nota));
                               }

                            $argumentossetnota ['nota'] = $nota;
                            $argumentossetnota ['ativo'] = 1;

                            $retNotas = new TDbo(TConstantes::DBALUNOS_NOTAS);

                            $criteriochecagem = new TCriteria ( );
                            $criteriochecagem->add(new TFilter("codigoavaliacao", "=", $codigoavaliacao), 'AND');
                            $criteriochecagem->add(new TFilter("codigoaluno", "=", $codigoaluno), 'AND');
                            $criteriochecagem->add(new TFilter("codigoturmadisciplina", "=", $codigoturmadisciplina), 'AND');
                            $retornochecagem = $retNotas->select('id', $criteriochecagem);

                            $arqumentoUpgrade = $retornochecagem->fetch();
                            if ($arqumentoUpgrade['id'] == NULL) {
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
    public function setJustificativaFalta($codigoturmadisciplina, $codigoaluno, $codigoaula, $justificativa = '-') {
        try {
            if ($codigoturmadisciplina) {
                $argumentossetfalta ['codigoturmadisciplina'] = $codigoturmadisciplina;
                if ($codigoaluno) {
                    $argumentossetfalta ['codigoaluno'] = $codigoaluno;
                    if ($codigoaula) {
                        $obAula = $this->getAula($codigoturmadisciplina, $codigoaula);

                        $retFalta = new TDbo(TConstantes::DBALUNOS_FALTAS);

                        $criteriochecagem = new TCriteria ( );
                        $criteriochecagem->add(new TFilter("codigoturmadisciplina", "=", $codigoturmadisciplina));
                        $criteriochecagem->add(new TFilter("codigoaluno", "=", $codigoaluno));
                        $criteriochecagem->add(new TFilter("codigoaula", "=", $obAula->codigo));

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
    public function setFalta($codigoturmadisciplina, $codigoaluno, $codigoaula, $aula = 1, $situacao = 'F') {
        try {
            $argumentossetfalta = array();
            if ($codigoturmadisciplina) {
                $argumentossetfalta ['codigoturmadisciplina'] = $codigoturmadisciplina;
                if ($codigoaluno) {
                    $argumentossetfalta ['codigoaluno'] = $codigoaluno;
                    if ($codigoaula) {
                        $obAula = $this->getAula($codigoturmadisciplina, $codigoaula);
                        $argumentossetfalta ['datafalta'] = $obAula->dataaula;
                        $argumentossetfalta ['numaula'] = $aula;
                        $argumentossetfalta ['codigoaula'] = $obAula->codigo;
                        $argumentossetfalta ['ativo'] = '1';

                        if (($situacao == "F") or ($situacao == "P")) {

                            $argumentossetfalta ['situacao'] = $situacao;
                            $retFalta = new TDbo(TConstantes::DBALUNOS_FALTAS);

                            $criteriochecagem = new TCriteria ( );
                            $criteriochecagem->add(new TFilter("codigoturmadisciplina", "=", $codigoturmadisciplina));
                            $criteriochecagem->add(new TFilter("codigoaluno", "=", $codigoaluno));
                            $criteriochecagem->add(new TFilter("codigoaula", "=", $obAula->codigo));
                            $criteriochecagem->add(new TFilter("numaula", "=", $aula));

                            $retornochecagem = $retFalta->select('id', $criteriochecagem);

                            $arqumentoUpgrade = $retornochecagem->fetch();
                            if ($arqumentoUpgrade['id'] == NULL) {
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
                $toDo = implode(" AND ", $toDo);
                
            } else {
                $checagem = true;
            }
        
        foreach ($listaAlunos as $codigoAluno => $aluno) {
            $media = $TAvaliacao->getMedia($codigoAluno, $codigoTurmaDisciplina);
                                
            eval('if(' . $toDo . ') { $checagem = true; } else { $checagem = false;}');
             
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
                $criterio->add(new TFilter("codigoturmadisciplina", "=", $codigoTurmaDisciplina));
                
	                if ($situacao != "all" and $situacao) {
	                    $criterio->add(new TFilter("situacao", "=", $situacao));
	                }
	                
                $this->obTDbo->setEntidade(TConstantes::DBALUNOS_DISCIPLINAS);
                $retAlunos = $this->obTDbo->select('codigoaluno', $criterio);

                $critAlunos = new TCriteria();
                
	                while ($retAluno = $retAlunos->fetchObject()) {
	                    $critAlunos->add(new TFilter('codigo', '=', $retAluno->codigoaluno), 'or');
	                }
	                
                $critAlunos->setProperty('order', 'nomepessoa');
                
                $TAluno = new TAluno();
                $alunos = $TAluno->getAlunos($critAlunos);
                
            } else {
                throw new ErrorException("O codigo do relacionamento Turma x Disciplina é invalido.");
            }
        } catch (Exception $e) {
            $this->obTDbo->rollback();
            new setException($e);
        }
        return $alunos;
    }

    /**
     * Retorna objeto com informações da aula Informada
     * param <type> $codigoaula
     * */
    public function getAula($codigoTurmaDisciplina, $codigoAula=NULL) {

        try {

            $this->obTDbo->setEntidade(TConstantes::DBTURMAS_DISCIPLINAS_AULAS);
            if ($codigoAula) {
                $criterio = new TCriteria ( );
                $criterio->add(new TFilter("codigo", "=", $codigoAula));
                $criterio->add(new TFilter("codigoturmadisciplina", "=", $codigoTurmaDisciplina));
                $criterio->setProperty('order', 'dataaula');
                $retornoAula = $this->obTDbo->select("*", $criterio);

                $aula = $retornoAula->fetchObject();

                $obTDbo = new TDbo(TConstantes::DBALUNOS_FALTAS);
                $criterio2 = new TCriteria();
                $criterio2->add(new TFilter("codigoaula", "=", $aula->codigo));
                $criterio2->add(new TFilter("situacao", "=", 'F'));
                $criterio2->setProperty('order', 'numaula');
                $retornoFaltas = $obTDbo->select("codigoaula,codigoaluno,numaula,justificativa,situacao", $criterio2);

                while ($ret = $retornoFaltas->fetchObject()) {
                    $num = $ret->numaula;
                    $aluno = $ret->codigoaluno;
                    $aula->justificativa[$aluno] = ($ret->justificativa != null ) ? $ret->justificativa : $aula->justificativa[$aluno];
                    $aula->faltas[$num][$aluno] = $ret->situacao;
                }
            } else {
                $criterio = new TCriteria ( );
                $criterio->add(new TFilter("codigoturmadisciplina", "=", $codigoTurmaDisciplina));
                $criterio->setProperty('order', 'dataaula');
                $retornoAula = $this->obTDbo->select("*");
                $retorno = null;
                while ($retorno = $retornoAula->fetchObject()) {
                    $aula[$retorno->codigo] = $retorno;
                    $this->obTDbo->setEntidade(TConstantes::DBALUNOS_FALTAS);
                    $criterio = new TCriteria ( );
                    $criterio->add(new TFilter("codigoturmadisciplina", "=", $codigoTurmaDisciplina));
                    $criterio->add(new TFilter("codigoaula", "=", $retorno->codigo));
                    $criterio->add(new TFilter("situacao", "=", 'F'));
                    $retornoFaltas = $this->obTDbo->select("codigoaula,codigoaluno,numaula,justificativa,situacao", $criterio);
                    while ($ret = $retornoFaltas->fetchObject()) {
                        $num = $ret->numaula;
                        $aluno = $ret->codigoaluno;
                        $aula[$ret->codigoaula]->justificativa[$aluno] = ($ret->justificativa != null) ? $ret->justificativa : $aula[$ret->codigoaula]->justificativa[$aluno];
                        $aula[$ret->codigoaula]->faltas[$num][$aluno] = $ret->situacao;
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
            $this->obTDbo->setEntidade(TConstantes::DBTURMAS_DISCIPLINAS_AVALIACOES);
            if ($codigoAvaliacao) {
                $criterio = new TCriteria ();
                $criterio->add(new TFilter("codigo", "=", $codigoAvaliacao));
                $criterio->add(new TFilter("codigoturmadisciplina", "=", $codigoTurmaDisciplina));

                $retornoAvaliacao = $this->obTDbo->select("*", $criterio);
                $avaliacao = $retornoAvaliacao->fetchObject();

                $obTDbo = new TDbo(TConstantes::DBALUNOS_NOTAS);
                $criterio2 = new TCriteria();
                $criterio2->add(new TFilter("codigoavaliacao", "=", $avaliacao->codigo));
                $retornoFaltas = $obTDbo->select("codigoavaliacao,codigoaluno,nota", $criterio2);

                while ($ret = $retornoFaltas->fetchObject()) {
                    $aluno = $ret->codigoaluno;
                    $avaliacao->notas[$aluno] = $ret->nota;
                }
            } else {
                $criterio = new TCriteria ();
                $criterio->add(new TFilter("codigoturmadisciplina", "=", $codigoTurmaDisciplina));
                $retornoAvaliacao = $this->obTDbo->select("*", $criterio);
                $retorno = null;
                while ($retorno = $retornoAvaliacao->fetchObject()) {

                    $avaliacao[$retorno->codigo] = $retorno;
                    $obTDbo = new TDbo(TConstantes::DBALUNOS_NOTAS);
                    $criterio2 = new TCriteria();
                    $criterio2->add(new TFilter("codigoavaliacao", "=", $retorno->codigo));
                    $retornoFaltas = $obTDbo->select("codigoavaliacao,codigoaluno,nota", $criterio2);

                    while ($ret = $retornoFaltas->fetchObject()) {
                        $aluno = $ret->codigoaluno;
                        $avaliacao[$retorno->codigo]->notas[$aluno] = $ret->nota;
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
    public function setPresencaAlunos($codigoturmadisciplina, $codigoAula, $entidade = NULL) {
        try {
            if ($codigoAula) {
                $TAula = $this->getAula($codigoturmadisciplina, $codigoAula);
                $listaAlunos = $this->getAlunos($codigoturmadisciplina);
                $aula = 1;
                while ($aula <= $TAula->frequencia) {

                    foreach ($listaAlunos as $aluno) {
                        $this->setFalta($codigoturmadisciplina, $aluno->codigo, $TAula->codigo, $aula, 'P');
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
     * @param $idForm
     * @param $x
     */
    public function viewSetFaltasAlunos($idForm, $x) {
    	

        $THeader = new TSetHeader();
        $header = $THeader->getHead('364', 'codigo');
        $header2 = $THeader->getHead('370', 'codigo');
        $codigoAula = ($header) ? $header : $header2;
        //$codigoAula = $idForm;

        $this->obTDbo->setEntidade(TConstantes::DBTURMAS_DISCIPLINAS_AULAS);
        $criterio = new TCriteria ( );
        $criterio->add(new TFilter("codigo", "=", $codigoAula));
        $retornoAula = $this->obTDbo->select("codigoturmadisciplina", $criterio);
        $obAula = $retornoAula->fetchObject();


        //Objetos para construção da lista
        $listaAlunos = $this->getAlunos($obAula->codigoturmadisciplina);


        $aula = $this->getAula($obAula->codigoturmadisciplina, $codigoAula);
        //Monta lista com os alunos
        $obLista = new TDatagrid();

        $obLista->addColumn(new TDataGridColumn('codigo', 'Matr�cula', 'center', '100px'));
        $obLista->addColumn(new TDataGridColumn('nomealuno', 'Nome', 'left', '350px'));

        $countCols = 1;
        while ($countCols <= $aula->frequencia) {
            $obLista->addColumn(new TDataGridColumn('aula' . $countCols, $countCols . 'ª aula', 'center', '60px'));
            $countCols++;
        }

        $obLista->addColumn(new TDataGridColumn('just', 'Justificativa', 'center', '250px'));

        $obLista->createModel('100%');

        foreach ($listaAlunos as $obAluno) {
            $item['codigo'] = $obAluno->codigo;
            $item['nomealuno'] = $obAluno->nomepessoa;
            $contCampo = 1;
            while ($contCampo <= $aula->frequencia) {
                $aluno = $obAluno->codigo;
                $campo = new TCheckButton('aluno-' . $obAluno->codigo . '-aula-' . $aula->codigo . '-frequencia-' . $contCampo);
                $campo->id = 'aluno-' . $obAluno->codigo . '-aula-' . $aula->codigo . '-frequencia-' . $contCampo;
                $campo->setValue("F");
                $campo->onclick = 'setAlunoFalta(\'' . $campo->id . '\',\'' . $obAula->codigoturmadisciplina . '\',\'' . $obAluno->codigo . '\',\'' . $aula->codigo . '\',\'' . $contCampo . '\');setJustificativa(\'just' . $obAluno->codigo . '\',\'' . $obAula->codigoturmadisciplina . '\',\'' . $obAluno->codigo . '\',\'' . $aula->codigo . '\')';
                if ($aula->faltas[$contCampo][$aluno] == 'F') {
                    $campo->checked = 'checked';
                }


                $item['aula' . $contCampo] = $campo;
                $contCampo++;
            }

            $justificativa = new TEntry('just' . $obAluno->codigo);
            $justificativa->setSize('250');
            $justificativa->onchange = 'setJustificativa(\'just' . $obAluno->codigo . '\',\'' . $obAula->codigoturmadisciplina . '\',\'' . $obAluno->codigo . '\',\'' . $aula->codigo . '\')';
            $justificativa->setValue($aula->justificativa[$aluno]);
            $item['just'] = $justificativa;
            $obLista->addItem($item);
        }

        $listaAlunos = new TElement("fieldset");
        $listaAlunos->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
        $listaAlunosLegenda = new TElement("legend");
        $listaAlunosLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
        $listaAlunosLegenda->add("Lan�amento de Faltas");
        $listaAlunos->add($disciplinasLegenda);

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
        $codigoTurmaDisciplina = $THeader->getHead('58','codigo');
    	
        /*
          $this->obTDbo->setEntidade ( TConstantes::DBTURMAS_DISCIPLINAS_AVALIACOES );
          $criterio = new TCriteria ( );
          $criterio->add ( new TFilter ( "codigo", "=", $codigoAvaliacao ) );
          $retornoAula = $this->obTDbo->select ( "codigoturmadisciplina", $criterio );
          $obAula = $retornoAula->fetchObject();
         */
        $aula = $this->getAlunosAvaliacao($codigoTurmaDisciplina, $codigoAvaliacao);
        
        //Monta lista com os alunos
        $obLista = new TDatagrid();

        $obLista->addColumn(new TDataGridColumn('codigo', 'Matrícula', 'center', '200px'));
        $obLista->addColumn(new TDataGridColumn('nomealuno', 'Nome', 'left', '450px'));
        $obLista->addColumn(new TDataGridColumn('nota', 'Nota', 'center', '5'));

        $obLista->createModel('100%');

        foreach ($aula->alunos as $obAluno) {

            $aluno = $obAluno->codigo;
            $campo = new TEntry('aluno-' . $obAluno->codigo . '-avaliacao-' . $aula->codigo);
            $campo->id = 'aluno-' . $obAluno->codigo . '-avaliacao-' . $aula->codigo;
            $campo->setValue($aula->notas[$obAluno->codigo]);
            $campo->onchange = 'setAlunoNota(\'' . $campo->id . '\',\'' . $codigoTurmaDisciplina . '\',\'' . $obAluno->codigo . '\',\'' . $aula->codigo . '\')';


            $item['codigo'] = $obAluno->codigo;
            $item['nomealuno'] = $obAluno->nomepessoa;
            $item['nota'] = $campo;
            $obLista->addItem($item);
        }

        $listaAlunos = new TElement("fieldset");
        $listaAlunos->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
        $listaAlunosLegenda = new TElement("legend");
        $listaAlunosLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
        $listaAlunosLegenda->add("Lançamento de Notas");
        $listaAlunos->add($disciplinasLegenda);

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
     * @param $idForm
     */
    public function setTransacaoProfessor($idForm){
    	
    	try {

            $obHeader = new TSetHeader();
            $headerForm = $obHeader->getHead($idForm,'codigo');
            
            $transaction = new TDbo();
            
            $transaction->setEntidade(TConstantes::VIEW_TURMAS_DISCIPLINAS);
            
            $criterioDisciplina = new TCriteria();
            $criterioDisciplina->add(new Tfilter('codigo','=',$headerForm));
            
            $retDisciplina = $transaction->select('*',$criterioDisciplina);

            $obDisciplina = $retDisciplina->fetchObject();
            
            
				/** Procura produto */
            $transaction->setEntidade(TConstantes::DBPRODUTOS);
            $criterio = new TCriteria();
            $criterio->add(new TFilter('label','=','Serviços Educacionais'),'AND');
            $criterio->add(new TFilter('codigotipoproduto','=','10004326-826'),'AND');

            $retConsultaProduto = $transaction->select('codigo',$criterio);
            
            $obConsultaProduto = $retConsultaProduto->fetchObject();
            
            if($obConsultaProduto->codigo){
            	$codigoProduto = $obConsultaProduto->codigo;
	        }else{
	            $produto['label'] = "Serviços Educacionais";
	            $produto['descricao'] = "Hora Aula";
	            $produto['codigotipoproduto'] = "10004326-826";
            	
	            $retInsercaoProduto = $transaction->insert($produto);
	            $codigoProduto = $retInsercaoProduto['codigo'];
            }
           
            
            $valorTotal = $obDisciplina->cargahoraria * $obDisciplina->custohoraaula;
            
            $transaction->setEntidade(TConstantes::DBPESSOAS_FUNCIONARIOS);
            $critPessoa = new TCriteria();
            $critPessoa->add(new TFilter('codigo','=',"(SELECT t9.codigofuncionario FROM dbfuncionarios_professores t9 WHERE t9.codigo = '{$obDisciplina->codigoprofessor}' limit 1)"));
            
            $retPessoa = $transaction->select('codigopessoa',$critPessoa);
            
            $obPessoa = $retPessoa->fetchObject();

                $crit = new TCriteria();
                $crit->add(new TFilter('codigo', '=', $headerForm['codigoPai']));

                $transacao = array();
                $transacao['codigopessoa'] = $obPessoa->codigopessoa;
                $transacao['tipomovimentacao'] = 'D';
                $transacao['valortotal'] = $valorTotal;
                $transacao['ativo'] = '1';

                $transaction->setEntidade(TConstantes::DBTRANSACOES);

                $retTransacao = $transaction->insert($transacao);

                if ($retTransacao['codigo']) {

                    $transaction->setEntidade(TConstantes::DBTRANSACOES_PRODUTOS);

                    $critUpdate = new TCriteria();
                        $toInsert['codigotransacao'] = $retTransacao['codigo'];
                        $toInsert['codigoproduto'] = $codigoProduto;
                        $toInsert['tabelaproduto'] = 'dbprodutos';
                        $toInsert['valornominal'] = $valorTotal;
                        $toInsert['ativo'] = '1';

                        $retInsert = $transaction->insert($toInsert);
                        if (!$retInsert) {
                            throw new ErrorException("Não foi possível concluir. A ação foi cancelada.", 1);
                        }
                        $transaction->commit();
                        return $retTransacao['codigo'];
                        
                }
        } catch (Exception $e) {
            new setException($e, 2);
        }
    }

}

?>