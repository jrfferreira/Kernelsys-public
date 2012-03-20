<?php

class TProcessoAcademico {

    public function getProcessoAcademico($codigo = null) {
        try {

            $dbo = new TDbo(TConstantes::DBPROCESSOS_ACADEMICOS);
            $crit = new TCriteria();
            $crit->add(new TFilter('ativo', '=', '1'));
            if ($codigo) $crit->add(new TFilter('codigo', '=', $codigo));
            $crit->setProperty('order', 'titulo');
            $ret = $dbo->select('*', $crit);

            if ($ret) {

                while ($obProc = $ret->fetch()) {
                    $obProcessos[$obProc['codigo']] = $obProc;
                }

                if (count($obProcessos) == 1) $obProcessos = $obProcessos[$codigo];
                return $obProcessos;
            } else {
                throw new ErrorException("Erro na seleÃ§ão de processos. Não hÃ¡ processos disponÃ­veis.");
            }
        } catch (Exception $e) {
            new setExcpetion($e);
        }
    }

    public function execProcessoAcademico($codigoaluno, $opcao) {
        try {
            if ($codigoaluno) {

                if ($opcao) {
                    $processo = $this->getProcessoAcademico($opcao);
                    $retorno = new TElement('div');
                    $retorno->style = "width: 100%;";
                    $retorno->add('<h2>' . $processo['titulo'] . '</h2>');
                    $retorno->add('<p><b>Procedimento:</b> ' . $processo['procedimento'] . '</p>');
                    $retorno->add('<p><b>Requisitos:</b> ' . $processo['requisitos'] . '</p>');

                    $conclui = new TElement('div');
                    $conclui->class = "ui-state-highlight ui-corner-all";
                    $conclui->style = "vertical-align: middle; text-align: center;";

                    $botoes = new TElement('div');

                    $labelSpan = new TElement("span");
                    $labelSpan->style = "padding: 3px";
                    $labelSpan->add('Confirmar Escolha');

                    $botoes->add($labelSpan);
                    $botoes->style = "width: 120px;";
                    $botoes->onclick = 'confirmaProcessoAcademico(\'' . $codigoaluno . '\',\'' . $opcao . '\')';
                    $botoes->class = "botActionOff ui-state-default ui-corner-all";
                    $botoes->alt = 'Confirmar Escolha';
                    $botoes->title = 'Confirmar Escolha';

                    $conclui->add($botoes);

                    $retorno->add($conclui);
                    return $retorno;
                } else {
                    throw new ErrorException("O processo Acadêmico especificado não é valido.");
                }
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido.");
            }
        } catch (Exception $e) {
            new setExcpetion($e);
        }
    }

    public function viewDetalheProcessoAcademico($codigo,$idForm) {
                    $dbo = new TDbo(TConstantes::DBPROCESSOS_ACADEMICOS);
                    $crit = new TCriteria();
                    $crit->add(new TFilter('formulario','=',$idForm));
                    $ret = $dbo->select('*',$crit);
                    $processo = $ret->fetch();
                    $retorno = new TElement('div');
                    $retorno->style = "width: 100%;";
                    $retorno->add('<p><b>Procedimento</b>: ' . $processo['procedimento'] . '</p>');
                    $retorno->add('<p><b>Requisitos:</b>: ' . $processo['requisitos'] . '</p>');
                    
                    $div = new TElement('div');
                    $div->id = 'retornoProcessoAcademico';
                    $div->add('');

                    $retorno->add($div);
                    
                    return $retorno;
        
    }

    /*
     * Metodo para Abandono de Curso
    */

    public function setAbandonoCurso($codigoaluno) {
        try {
            if ($codigoaluno) {
                $processo = $this->getProcessoAcademico('10005328-928');

                $dbo2 = new TDbo(TConstantes::VIEW_ALUNOS_DISCIPLINAS);
                $crit = new TCriteria();
                $crit->add(new TFilter('situacao','in','(\'1\',\'2\')'));
                $crit->add(new TFilter('codigoaluno','=',$codigoaluno));
                $ret2 = $dbo2->select('nomedisciplina',$crit);
                
                while($disc = $ret2->fetchObject()) {
                    $discs .= $disc->nomedisciplina.'<br/>';
                }

                $dbo = new TDbo(TConstantes::DBALUNOS_DISCIPLINAS);
                $ret = $dbo->update(array('situacao'=>'6','obs'=>'Evadido em'.date('d/m/Y')), $crit);

                $div = new TElement('div');
                $div->class = "ui-state-highlight ui-corner-all";
                $div->style = "vertical-align: middle; text-align: center; font-size: 16px;";

                if($ret) {
                    $div->add('<p><span style="font-size: 16px;">Aluno evadido das disciplinas:<br/>'.$discs.'</span></p>');
                } else {
                    throw new ErrorException("No momento não é possivel concluir o processo, tente novamente.");
                }
                $div->add("Processo de <b>{$processo['titulo']}</b> Concluido com sucesso");
                return $div;
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido.");
            }
        } catch (Exception $e) {
            new setExcpetion($e);
        }
    }
    
/*
     * Metodo para Trancamento Curso
    */

    public function setTrancamentoCurso($codigoaluno) {
    	
        try {
            if ($codigoaluno) {
                $processo = $this->getProcessoAcademico('10005370-970');

                $dbo2 = new TDbo(TConstantes::VIEW_ALUNOS_DISCIPLINAS);
                $crit = new TCriteria();
                $crit->add(new TFilter('situacao','in','(\'1\',\'2\')'),'AND');
                $crit->add(new TFilter('codigoaluno','=',$codigoaluno));
                $ret2 = $dbo2->select('nomedisciplina',$crit);

                while($disc = $ret2->fetchObject()) {
                    $discs .= $disc->nomedisciplina.'<br/>';
                }

                $dbo = new TDbo(TConstantes::DBALUNOS_DISCIPLINAS);
                $ret = $dbo->update(array('situacao'=>'5','obs'=>'Trancado em'.date('d/m/Y')), $crit);

                $div = new TElement('div');
                $div->class = "ui-state-highlight ui-corner-all";
                $div->style = "vertical-align: middle; text-align: center; font-size: 16px;";

                if($ret) {
                    $div->add('<p><span style="font-size: 16px;">Aluno evadido das disciplinas:<br/>'.$discs.'</span></p>');
                } else {
                    throw new ErrorException("No momento não é possivel concluir o processo, tente novamente.");
                }
                $div->add("Processo de <b>{$processo['titulo']}</b> Concluido com sucesso");
                return $div;
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido.");
            }
        } catch (Exception $e) {
            new setExcpetion($e);
        }
    }
    
    /*
     * Metodo para Abono de faltas
    */

    private function setAbonoFalta($codigoaluno) {
        try {
            if ($codigoaluno) {
                $processo = $this->getProcessoAcademico('10005329-929');

                $div = new TElement('div');
                $div->class = "ui-state-highlight ui-corner-all";
                $div->style = "vertical-align: middle; text-align: center; font-size: 16px;";
                $div->add("Processo de <b>{$processo['titulo']}</b> Concluido com sucesso");
                return $div;
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido.");
            }
        } catch (Exception $e) {
            new setExcpetion($e);
        }
    }
    /*
     * Metodo para Aproveitamento de Disciplina
    */

   public function setAprovDisc($idform) {
            if ($idform) {
                                   //retorna dados do cabeçalho
                        $obHeader = new TSetHeader();
                        $obHeader = $obHeader->getHead($idform);
                        $codigoalunodisciplina = $obHeader['codigo'];

                    $dbo = new TDbo(TConstantes::DBALUNOS_DISCIPLINAS_APROVEITAMENTOS);
                    $crit = new TCriteria();
                    $crit->add(new TFilter('codigoalunodisciplina','=',$codigoalunodisciplina),'AND');
                    $ret = $dbo->select('count(id) contagem',$crit);

                    $obRet = $ret->fetchObject();

                    if($obRet->contagem > 0){
                            $dbo2 = new TDbo(TConstantes::DBALUNOS_DISCIPLINAS);
                            $crit2 = new TCriteria();
                            $crit2->add(new TFilter('codigo','=',$codigoalunodisciplina),'AND');
                            $dbo2->update(array('situacao' =>'7'),$crit2);
                    }

            }
    }

    public function formOutAproveitamento($idform){
                try{

            if(!$idForm){
                throw new ErrorException("Erro na conclusao do formulario.", 1);
            }

           $obHeader = new TSetHeader();
           $headerForm = $obHeader->getHead($idForm);


             //Insere o codigo do produto na especializaÃ§ão======================================
            $dadosUpdate['situacao'] = $codigoproduto;
            $dboUpdateProduto = new TDbo(TConstantes::DBTURMAS);
                $criteriaUpdate = new TCriteria();
                $criteriaUpdate->add(new TFilter("codigo", "=", $headerForm['codigo']));
            $updateProdutoTurma = $dboUpdateProduto->update($dadosUpdate, $criteriaUpdate);

            if(!$updateProdutoTurma){
                $dboUpdateProduto->rollback();
                throw new ErrorException("A disciplina não pode ser atualizada.", 1);
            }
            //==================================================================================

            //gera taxa de inscriÃ§ão
            $this->setTaxaInscricao($headerForm['codigo']);

        }catch (Exception $e){
            new setException($e);
        }

        confirmaProcessoAcademico('10005502-202','10005332-932');
    }
    /*
     * Metodo para Atestado de Matricula
    */

    private function setAtestadoMatricula($codigoaluno) {
        try {
            if ($codigoaluno) {
                $processo = $this->getProcessoAcademico('10005336-936');

                $div = new TElement('div');
                $div->class = "ui-state-highlight ui-corner-all";
                $div->style = "vertical-align: middle; text-align: center; font-size: 16px;";
                $div->add("Processo de <b>{$processo['titulo']}</b> Concluido com sucesso");
                return $div;
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno válido.");
            }
        } catch (Exception $e) {
            new setExcpetion($e);
        }
    }
    /*
     * Metodo para ColaÃ§ão de Grau em Gabinete
    */

    private function setColacaoGabinete($codigoaluno) {
        try {
            if ($codigoaluno) {
                $processo = $this->getProcessoAcademico('10005341-941');

                $div = new TElement('div');
                $div->class = "ui-state-highlight ui-corner-all";
                $div->style = "vertical-align: middle; text-align: center; font-size: 16px;";
                $div->add("Processo de <b>{$processo['titulo']}</b> Concluido com sucesso");
                return $div;
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno válido.");
            }
        } catch (Exception $e) {
            new setExcpetion($e);
        }
    }
    /*
     * Metodo para Destrancamento de Matrícula
    */

    public function setDestrancamentoMatricula($codigoaluno) {
        try {
            if ($codigoaluno) {
                $processo = $this->getProcessoAcademico('10005344-944');

                $dbo = new TDbo(TConstantes::DBPESSOAS_ALUNOS);
                $criterio = new TCriteria();
                $criterio->add(new TFilter('codigo','=',$codigoaluno));
                $retCodTurma = $dbo->select('codigoturma',$criterio);
                
                $codigoTurma = $retCodTurma->fetchObject()->codigoturma;
                
                $dboTurmas = new TDbo(TConstantes::DBTURMAS_DISCIPLINAS);
				$critTurma = new TCriteria();
				$critTurma->add(new TFilter('codigoturma','=',$codigoTurma));
				
				$retDiscTurma = $dboTurmas->select('codigo,codigodisciplina',$critTurma);
								
				$critUpdateDisciplinas = new TCriteria();
				$filtro = new TFilter('codigoaluno','=',$codigoaluno);
				$filtro->tipoFiltro = "123";
                $critUpdateDisciplinas->add($filtro,'AND');
                
				while($obTurmaDisciplina = $retDiscTurma->fetchObject()){
					$filtro2 = new TFilter('codigodisciplina','=',$obTurmaDisciplina->codigodisciplina);
					$filtro2->tipoFiltro = "321";
					$critUpdateDisciplinas->add($filtro2,'OR');
				}
                
				$dboAlunoDisciplina = new TDbo(TConstantes::DBALUNOS_DISCIPLINAS);
                				
				$update = $dboAlunoDisciplina->update(Array('situacao' => '2'), $critUpdateDisciplinas);
                
				if($update){                
	                $div = new TElement('div');
	                $div->class = "ui-state-highlight ui-corner-all";
	                $div->style = "vertical-align: middle; text-align: center; font-size: 16px;";
	                $div->add("Processo de <b>{$processo['titulo']}</b> Concluido com sucesso");
	                return $div;
				}else{
					throw new ErrorException("Não foi possível concluir o processo, tente novamente.");
				}
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido.");
            }
        } catch (Exception $e) {
            new setExcpetion($e);
        }
    }
    /*
     * Metodo para Guia de Tranferencia
    */

    private function setGuiaTransferencia($codigoaluno) {
        try {
            if ($codigoaluno) {
                $processo = $this->getProcessoAcademico('10005346-946');

                $div = new TElement('div');
                $div->class = "ui-state-highlight ui-corner-all";
                $div->style = "vertical-align: middle; text-align: center; font-size: 16px;";
                $div->add("Processo de <b>{$processo['titulo']}</b> Concluido com sucesso");
                return $div;
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido.");
            }
        } catch (Exception $e) {
            new setExcpetion($e);
        }
    }
    /*
     * Metodo para HistÃ³rico Escolar
    */

    private function setHistoricoEscolar($codigoaluno) {
        try {
            if ($codigoaluno) {
                $processo = $this->getProcessoAcademico('10005347-947');

                $div = new TElement('div');
                $div->class = "ui-state-highlight ui-corner-all";
                $div->style = "vertical-align: middle; text-align: center; font-size: 16px;";
                $div->add("Processo de <b>{$processo['titulo']}</b> Concluido com sucesso");
                return $div;
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido.");
            }
        } catch (Exception $e) {
            new setExcpetion($e);
        }
    }
    /*
     * Metodo para Justificativa de Falta
    */

    private function setJustificativaFalta($codigoaluno) {
        try {
            if ($codigoaluno) {
                $processo = $this->getProcessoAcademico('10005349-949');

                $div = new TElement('div');
                $div->class = "ui-state-highlight ui-corner-all";
                $div->style = "vertical-align: middle; text-align: center; font-size: 16px;";
                $div->add("Processo de <b>{$processo['titulo']}</b> Concluido com sucesso");
                return $div;
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido.");
            }
        } catch (Exception $e) {
            new setExcpetion($e);
        }
    }
    /*
     * Metodo para Prova de Segunda Chamada
    */

    private function setProvaSegundaChamada($codigoaluno) {
        try {
            if ($codigoaluno) {
                $processo = $this->getProcessoAcademico('10005362-962');

                $div = new TElement('div');
                $div->class = "ui-state-highlight ui-corner-all";
                $div->style = "vertical-align: middle; text-align: center; font-size: 16px;";
                $div->add("Processo de <b>{$processo['titulo']}</b> Concluido com sucesso");
                return $div;
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido.");
            }
        } catch (Exception $e) {
            new setExcpetion($e);
        }
    }
    /*
     * Metodo para Ressarcimento para DesistÃªncia do Curso
    */

    private function setRessarcimento($codigoaluno) {
        try {
            if ($codigoaluno) {
                $processo = $this->getProcessoAcademico('10005367-967');

                $div = new TElement('div');
                $div->class = "ui-state-highlight ui-corner-all";
                $div->style = "vertical-align: middle; text-align: center; font-size: 16px;";
                $div->add("Processo de <b>{$processo['titulo']}</b> Concluido com sucesso");
                return $div;
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido.");
            }
        } catch (Exception $e) {
            new setExcpetion($e);
        }
    }
    /*
     * Metodo para RevalidaÃ§ão de Diploma
    */

    private function setRevalidacaoDiploma($codigoaluno) {
        try {
            if ($codigoaluno) {
                $processo = $this->getProcessoAcademico('10005330-930');

                $div = new TElement('div');
                $div->class = "ui-state-highlight ui-corner-all";
                $div->style = "vertical-align: middle; text-align: center; font-size: 16px;";
                $div->add("Processo de <b>{$processo['titulo']}</b> Concluido com sucesso");
                return $div;
            } else {
                throw new ErrorException("O codigo " . $codigoaluno . " não é referente a um aluno valido.");
            }
        } catch (Exception $e) {
            new setExcpetion($e);
        }
    }
    
    /*
     * Metodo para Regularização de Aluno Especial
    */

    public function setRegularizacaoAlunoEspecial($codigodisciplinaantiga = null,$codigodisciplinanova = null,$codigoturmadisciplina = null) {
        try {                
		$processo = $this->getProcessoAcademico('10010117-317');
            if ($codigodisciplinaantiga) {
                
                $crit = new TCriteria();
                $crit->add(new TFilter('codigo','=',$codigodisciplinaantiga));
                
                $dbo = new TDbo(TConstantes::DBALUNOS_DISCIPLINAS);
                $ret = $dbo->update(array('situacao' => '1'),$crit);
              }
		if($codigodisciplinanova && $codigoturmadisciplina){  
                $crit1 = new TCriteria();
                $crit1->add(new TFilter('codigo','=',$codigodisciplinanova));
                
                $dbo1 = new TDbo(TConstantes::DBALUNOS_DISCIPLINAS);
                $ret1 = $dbo1->update(array('situacao' => '2','codigoturmadisciplina'=>$codigoturmadisciplina),$crit1);
}
                
                if($ret || $ret1){
	                $div = new TElement('div');
	                $div->class = "ui-state-highlight ui-corner-all";
	                $div->style = "vertical-align: middle; text-align: center; font-size: 16px;";
	                $div->add("Processo de <b>{$processo['titulo']}</b> Concluido com sucesso");
	                return $div;
                }
          
        } catch (Exception $e) {
            new setExcpetion($e);
        }
    }
}