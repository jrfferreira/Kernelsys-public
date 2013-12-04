<?php
/* 
 * Prove todos os metodos especificos para gerenciamento
 * dos dados do curso
 * Autor: Wagner Borba
 * Data: 22/03/2010
 */

class TCurso{
    /**
     * Retorna um objeto curso e suas informações
     *
     */
    public function getCurso($codigoCurso,$disciplinas = true){
        try{

            $dboCurso = new TDbo(TConstantes::DBCURSO);
                $criteriaCurso = new TCriteria();
                $criteriaCurso->add(new TFilter("seq","=",$codigoCurso));
            $retCurso = $dboCurso->select("*",$criteriaCurso);
            $obCurso = $retCurso->fetchObject();

            if($disciplinas){
            $obCurso->disciplinas = $this->getListaDisciplinas($obCurso->seq);
            }

            return $obCurso;

        }catch (Exception $e){
            new setException($e);
        }

    }
    public function buttonAddCursoDisciplina($formseq){

        $div = new TElement('div'); 
       $div->id = 'ret_addCursoDisciplinas';
        $button = new TElement('input');
        $button->id = "addCursoDisciplinas";
        $button->type = "button";
        $button->onclick = "addAllDisciplinasCurso('ret_addCursoDisciplinas','$formseq')";
        $button->class = "ui-state-default ui-corner-all";        
        $button->title = 'Adicionar os Registros Selecionados';
        $button->value = "Adicionar os Registros Selecionados";

        $div->style = "text-align: center; padding: 5px;";
        $div->class = "ui-widget-content";
        $div->add($button);
        return $div;
    }

    public function addCursoDisciplina($formseq){

        $obHeader = new TSetHeader();
        $headerForm = $obHeader->getHead($formseq);

        $data['pjcuseq'] = $obHeader->getHead($headerForm['frmpseq'],TConstantes::HEAD_SEQUENCIALPAI);
        $data['statseq'] = '1';

        $headerLista = $obHeader->getHead($headerForm[TConstantes::LISTA]);
        $listaDisciplinas = $this->getListaDisciplinas($data['pjcuseq']);

        //foreach($headerLista as $ch=>$vl){
        //    echo "<i>$ch</i> = <b>$vl</b><br/>";
        //}

        $cont = 0;
        foreach($headerLista[TConstantes::LIST_SELECAO] as $ch=>$vl){
            if(!$listaDisciplinas[$ch]){
                $data['discseq'] = str_replace(array('[',']','"',"'"), '', $vl);
                $dboDisciplina = new TDbo(TConstantes::DBPROJETO_CURSO_DISCIPLINA);
                $dboDisciplina->insert($data);
                $cont++;
            }
        }
        
        if($cont > 1){
        	$plural = 's';
        }else{
        	$plural = '';
        }
        
        if($cont == 0){
        	$cont = "Nenhuma";
        }
        
        $obHeader->addHeader($headerForm[TConstantes::LISTA],TConstantes::LIST_SELECAO,array());
        
        return $cont." disciplina{$plural} adicionada{$plural} com sucesso.";
    }

    public function getListaDisciplinas($codigoCurso){
        try{
            $dboDisciplina = new TDbo(TConstantes::VIEW_CURSO_DISCIPLINA);
                $criteriaDisicplina = new TCriteria();
                $criteriaDisicplina->add(new TFilter("cursseq","=",$codigoCurso));
            $retDisciplinas = $dboDisciplina->select("*",$criteriaDisicplina);

            $disciplinas = array();
            while($disciplina = $retDisciplinas->fetchObject()){
                $disciplinas[] = $disciplina->discseq;
            }

            $TDisciplinas = new TDisciplina();
            $disciplinas = $TDisciplinas->getListaDisciplina($disciplinas);
            return $disciplinas;
            
        }catch (Exception $e){
            new setException($e);
        }
    }
    
    public function getListaDisciplinasProjetoCurso($pjcuseq){
    	try{
    		$dboDisciplina = new TDbo(TConstantes::VIEW_PROJETO_CURSO_DISCIPLINA);
    		$criteriaDisicplina = new TCriteria();
    		$criteriaDisicplina->add(new TFilter("pjcuseq","=",$pjcuseq));
    		$retDisciplinas = $dboDisciplina->select("*",$criteriaDisicplina);
    
    		$disciplinas = array();
    		while($disciplina = $retDisciplinas->fetchObject()){
    			$disciplinas[] = $disciplina->discseq;
    		}
    
    		$TDisciplinas = new TDisciplina();
    		$disciplinas = $TDisciplinas->getListaDisciplina($disciplinas);
    		return $disciplinas;
    
    	}catch (Exception $e){
    		new setException($e);
    	}
    }

    /**
     *
     * param <type> $codigoCurso
     * return <type> 
     */
    public function getCargaHoraria($codigoCurso){
         try{

            $disciplinas = $this->getListaDisciplinas($codigoCurso);

            $soma = 0;
            if($disciplinas){
                foreach($disciplinas as $disc){
                    $soma = $soma + $disc->cargahoraria;
                }
            }

            $vetInsert['cargahoraria'] = $soma;
            $sqlInsertCHT = new TDbo(TConstantes::DBPROJETO_CURSO);
                $critInsert = new TCriteria();
                $critInsert->add(new TFilter("seq","=",$codigoCurso));
            $sqlInsertCHT = $sqlInsertCHT->update($vetInsert, $critInsert);

            $string = "Carga Horaria Total: ".$soma;
            $this->ob = new TElement('div');
            $this->ob->align = "right";
            $this->ob->class = "ui-box ui-widget-content ui-state-default";
            $this->ob->add ($string);

            return $this->ob;

         }catch (Exception $e){
             new setException($e);
         }
    }
    
    public function getCargaHorariaProjetoCurso($codigoCurso){
    	try{
    
    		$disciplinas = $this->getListaDisciplinasProjetoCurso($codigoCurso);
    
    		$soma = 0;
    		if($disciplinas){
    			foreach($disciplinas as $disc){
    				$soma = $soma + $disc->obDisciplina->cargahoraria;
    			}
    		}
    
    		$vetInsert['cargahoraria'] = $soma;
    		$sqlInsertCHT = new TDbo(TConstantes::DBPROJETO_CURSO);
    		$critInsert = new TCriteria();
    		$critInsert->add(new TFilter("seq","=",$codigoCurso));
    		$sqlInsertCHT = $sqlInsertCHT->update($vetInsert, $critInsert);
    
    		$string = "Carga Horaria Total: ".$soma;
    		$this->ob = new TElement('div');
    		$this->ob->align = "right";
    		$this->ob->class = "ui-box ui-widget-content ui-state-default";
    		$this->ob->add ($string);
    
    		return $this->ob;
    
    	}catch (Exception $e){
    		new setException($e);
    	}
    }

    /**
     * Retorna o nome do curso (label)
     * param <type> $codigoCurso
     */
    public function getLabel($codigoCurso){
        try{
            $obCurso = $this->getCurso($codigoCurso);
            return $obCurso->nome;
        }catch (Exception $e){
            new setException($e);
        }
    }
}
