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

            $dboCurso = new TDbo(TConstantes::DBCURSOS);
                $criteriaCurso = new TCriteria();
                $criteriaCurso->add(new TFilter("codigo","=",$codigoCurso));
            $retCurso = $dboCurso->select("*",$criteriaCurso);
            $obCurso = $retCurso->fetchObject();

            if($disciplinas){
            $obCurso->disciplinas = $this->getListaDisciplinas($obCurso->codigo);
            }

            return $obCurso;

        }catch (Exception $e){
            new setException($e);
        }

    }
    public function buttonAddCursoDisciplina($idForm){

        $div = new TElement('div'); 
       $div->id = 'ret_addCursoDisciplinas';
        $button = new TElement('input');
        $button->id = "addCursoDisciplinas";
        $button->type = "button";
        $button->onclick = "addAllDisciplinasCurso('ret_addCursoDisciplinas','$idForm')";
        $button->class = "ui-state-default ui-corner-all";        
        $button->title = 'Adicionar os Registros Selecionados';
        $button->value = "Adicionar os Registros Selecionados";

        $div->style = "text-align: center; padding: 5px;";
        $div->class = "ui-widget-content";
        $div->add($button);
        return $div;
    }

    public function addCursoDisciplina($idForm){

        $obHeader = new TSetHeader();
        $headerForm = $obHeader->getHead($idForm);

        $data['codigocurso'] = $obHeader->getHead($headerForm['idFormPai'],'codigoPai');
        $data['ativo'] = '1';

        $headerLista = $obHeader->getHead($headerForm['idLista'],'listaSelecao');
        $listaDisciplinas = $this->getListaDisciplinas($data['codigocurso']);

        //foreach($headerLista as $ch=>$vl){
        //    echo "<i>$ch</i> = <b>$vl</b><br/>";
        //}

        $cont = 0;
        foreach($headerLista as $ch=>$vl){
            if(!$listaDisciplinas[$ch]){
                $data['codigodisciplina'] = str_replace(array('[',']','"',"'"), '', $vl);
                $dboDisciplina = new TDbo(TConstantes::DBCURSOS_DISCIPLINAS);
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
        return $cont." disciplina{$plural} adicionada{$plural} com sucesso.";
    }

    public function getListaDisciplinas($codigoCurso){
        try{
            $dboDisciplina = new TDbo(TConstantes::DBCURSOS_DISCIPLINAS);
                $criteriaDisicplina = new TCriteria();
                $criteriaDisicplina->add(new TFilter("codigocurso","=",$codigoCurso));
            $retDisciplinas = $dboDisciplina->select("*",$criteriaDisicplina);

            $disciplinas = array();
            while($disciplina = $retDisciplinas->fetchObject()){
                $disciplinas[] = $disciplina->codigodisciplina;
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

            $vetInsert['cargahortotal'] = $soma;
            $sqlInsertCHT = new TDbo(TConstantes::DBCURSOS);
                $critInsert = new TCriteria();
                $critInsert->add(new TFilter("codigo","=",$codigoCurso));
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
