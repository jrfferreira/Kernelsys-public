<?php

/**
 * TAvaliacao
 *
 * Classe de controle para Avaliações
 *
 * @version 1.00
 * @category PetrusEDU
 * @package PetrusEDU
 * @author João Felix
 * @copyright BitUP S.i.
 *
 * @todo Métodos de Recuperação para opções 2,3,4
 */
class TAvaliacao {

    /**
     * getGrade
     *
     * Retorna a grade de avaliações
     * 
     * @param string $codigo Referencia do código da Grade de Avaliações
     * @return array $gradeAvaliacoes Contendo as avaliações e seus atributos quando existentes
     * 
     */
    public function getGrade($codigo) {
        try {
            $gradeAvaliacoes = array();

            $sqlGrade = new TDbo("dbavaliacoes");
            $critGrade = new TCriteria();
            $critGrade->add(new TFilter("codigograde", "=", $codigo));
            $critGrade->add(new TFilter("ativo", "=", '1'));
            $critGrade->setProperty('order', 'ordem');
            $gradeQuery = $sqlGrade->select("*", $critGrade);
            
            
            while ($obAvaliacao = $gradeQuery->fetchObject()) {
                $gradeAvaliacoes[$obAvaliacao->ordem] = $obAvaliacao;
            }

            if (count($gradeAvaliacoes)) {
                ksort($gradeAvaliacoes);
                return $gradeAvaliacoes;
            } else {
            	return false;
                //throw new ErrorException("Não há avaliações relacionadas à grade escolhida.");
            }
        } catch (Exception $e) {
            new setException($e, 0);
        }
    }

    /**
     * getAvaliacao
     *
     * Retorna a Avaliação com seus atributos
     *
     * @param string $codigoAvaliacao Referencia do código da Avaliação
     * @return array $avaliacao Contendo a avaliação, os alunos relacionados, notas e seus atributos quando existentes
     *
     */
    public function getAvaliacao($codigoAvaliacao) {
        try {
            if ($codigoAvaliacao) {
                $sqlGrade = new TDbo("dbavaliacoes");
                $critGrade = new TCriteria();
                $critGrade->add(new TFilter("codigo", "=", $codigoAvaliacao));
                $critGrade->add(new TFilter("ativo", "=", '1'));
                $gradeQuery = $sqlGrade->select("*", $critGrade);

                return $gradeQuery->fetchObject();
            } else {
                throw new ErrorException("");
            }
        } catch (Exception $e) {
            new setException($e, 0);
        }
    }

    /**
     * getMedia
     *
     * @param string $codigoAluno Referencia do código do Aluno
     * @param string $codigoTurmaDisciplina Referencia opcional do código da Disciplina
     * @return array $medias Contendo as avaliações e média do aluno referente ou não a determinada disciplina e seus atributos quando existentes
     *
     */
    public function getMedia($codigoAluno, $codigoTurmaDisciplina = null) {
        try {
            $medias = array();
            $cursos = array();

            $TTurmaDisciplina = new TTurmaDisciplinas();

            $critDiscs = new TCriteria();
            $critDiscs->add(new TFilter("codigoaluno", "=", $codigoAluno));
            if ($codigoTurmaDisciplina) {
                $critDiscs->add(new TFilter("codigoturmadisciplina", "=", $codigoTurmaDisciplina));
            }

            $sqlNotas = new TDbo("dbalunos_notas");
            $notasQuery = $sqlNotas->select("codigoavaliacao, codigoturmadisciplina, nota, ordemavaliacao", $critDiscs);

            while ($obNota = $notasQuery->fetchObject()) {
                $notas[$obNota->codigoturmadisciplina][$obNota->ordemavaliacao] = $obNota->nota;
            }            
            $sqlDiscs = new TDbo("view_alunos_disciplinas");
            $discsQuery = $sqlDiscs->select("codigoturmadisciplina, nomedisciplina, nomecurso, codigocurso, nometurma, situacao,codigograde", $critDiscs);

            while ($obDisc = $discsQuery->fetchObject()) {
                $medias[$obDisc->codigoturmadisciplina]->nomedisciplina = $obDisc->nomedisciplina;
                $medias[$obDisc->codigoturmadisciplina]->nomecurso = $obDisc->nomecurso;
                $medias[$obDisc->codigoturmadisciplina]->codigoturmadisciplina = $obDisc->codigoturmadisciplina;
                $medias[$obDisc->codigoturmadisciplina]->codigocurso = $obDisc->codigocurso;
                $medias[$obDisc->codigoturmadisciplina]->nometurma = $obDisc->nometurma;
                $medias[$obDisc->codigoturmadisciplina]->situacao = $obDisc->situacao;
                $medias[$obDisc->codigoturmadisciplina]->codigograde = $obDisc->codigograde;
                $medias[$obDisc->codigoturmadisciplina]->media = "-";
            }
            
            if (count($medias)) {
                foreach ($medias as  $ch => $disc) {
                    $medias[$disc->codigoturmadisciplina]->avaliacoes = $this->getGrade($disc->codigograde);
                }

                foreach ($medias as $ch => $discs) {
					if($discs->avaliacoes){
	                    foreach ($discs->avaliacoes as $ch2 => $vl) {
	                        $medias[$ch]->avaliacoes[$ch2]->nota = $notas[$ch][$ch2];
	                    }
                		
                    	$medias[$ch]->media = $this->processaMedia($medias[$ch]->avaliacoes);
					}
                }
                return $medias;
            } else {
                throw new ErrorException("Não há disciplinas relacionadas ao aluno escolhido.");
            }
        } catch (Exception $e) {
            new setException($e, 0);
        }
    }

    /**
     * processaMedia
     *
     * @param array $vetorAvaliacoes Referencia das notas obtidas
     * @return string $medias Contendo a média do aluno
     *
     */
    public function processaMedia($vetorAvaliacoes) {
		$cond = true;
        $notaAtual = null;

        $k = end($vetorAvaliacoes)->id;

        reset($vetorAvaliacoes);
                        
        while ($cond == true) {
        	$chave = current($vetorAvaliacoes)->id;
        	        	
            if ($chave == $k) {
                $cond = false;
            }
            
            $checagem = false;

            $matches = @preg_match("@?@i", "condicao".$vetorAvaliacoes[$chave]->condicao);
            
            if ($matches) {
                $condicao = explode("?", $vetorAvaliacoes[$chave]->condicao);
                unset($condicao[0]);

                foreach ($condicao as $vl) {
                    $node = preg_replace('@AV{@', '$vetorAvaliacoes[', $vl);
                    $node = preg_replace('@}@', ']->nota', $node);

                    $toDo[] = "({$node})";
                }

                $toDo = implode(" AND ", $toDo);

                eval('if(' . $toDo . ') { $checagem = true; } else { $checagem = false; }');
            } else {
                $checagem = true;
            }

            /*
             * 	1 -> "Avalia��o Comum"
			 *	2 -> "Avalia��o de Recupera��o por Substitui��o relacionada � Avalia��es"
			 *	3 -> "Avalia��o de Recupera��o por Agrega��o relacionada � Avalia��es"
			 *	4 -> "Avalia��o de Recupera��o por Substitui��o relacionada � M�dia"
			 *	5 -> "Avalia��o de Recupera��o por Agrega��o relacionada � M�dia"
             */

            
            if ($checagem) {
                $incontrol = current($vetorAvaliacoes)->incontrol;
                
                switch (current($vetorAvaliacoes)->codigoregra) {
                    case 1:
                        $pesos = $pesos + current($vetorAvaliacoes)->peso;
                        $nota = $nota + current($vetorAvaliacoes)->nota * current($vetorAvaliacoes)->peso;
                        break;

                    case 2:
                    	// a corrigir
                        $pesos = $pesos + current($vetorAvaliacoes)->peso;
                        $nota = $nota + current($vetorAvaliacoes)->nota * current($vetorAvaliacoes)->peso;
                        break;
                    case 3:
                    	// a corrigir
                        $pesos = $pesos + current($vetorAvaliacoes)->peso;
                        $nota = $nota + current($vetorAvaliacoes)->nota * current($vetorAvaliacoes)->peso;
                        break;
                    case 4:
                        $pesos = current($vetorAvaliacoes)->peso;
                        $nota = current($vetorAvaliacoes)->nota * current($vetorAvaliacoes)->peso;


                        break;
                    case 5:
                    	
                    	$nota = $nota / $pesos;                   	
                    	$pesos = 1;

                        $pesos = $pesos + current($vetorAvaliacoes)->peso;
                        $nota = $nota + current($vetorAvaliacoes)->nota * current($vetorAvaliacoes)->peso;
                        break;
                }
            }

            $chave = next($vetorAvaliacoes)->id;
        }

        $media = $nota / $pesos;
        
        $TSetControl = new TSetControl();
        if ($incontrol && method_exists($TSetControl, $incontrol)) {
            $media = call_user_func_array(array($TSetControl, $incontrol), array('nota' => $media));
        }
        return $media;
    }

}
