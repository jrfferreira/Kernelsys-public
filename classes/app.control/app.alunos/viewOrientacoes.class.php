<?php
/**
* Classe  viewArquivos()
* Configura o atributo vindo do objeto pai(registro responsavel pela visualização do ap�ndice)
* Autor : Jo�o Felix
*/

class viewOrientacoes{

	/**
    * método setParam()
    * Configura o atributo vindo do objeto pai(registro responsavel pela visualização do ap�ndice)
	* Autor : Wagner Borba
    * param Codigo = recebe codigo do objeto pai
    */
	public function setParam($param){
		$this->param = $param;
	}

	/**
	* método get()
	* ===========================================================
	* Autor: Jo�o Felix
	*/
	    public function get($obCodigo){

            $TUsuario = new TUsuario();
            $obCodigo = $TUsuario->getCodigoAluno();


        //retorna informações do Aluno
        $sqlAluno = new TDbo(TConstantes::DBPESSOAS_ALUNOS);
        $critAluno = new TCriteria();
        $critAluno->add(new TFilter("codigo","=",$obCodigo));
        $alunoQuery = $sqlAluno->select("codigoturma,codigo,codigopessoa",$critAluno);

        //Monta estrutura do Curso/Turma
        while ($obAlunoTurma = $alunoQuery->fetchObject()) {

            $codigopessoa = $obAlunoTurma->codigopessoa;

            $ch = $obAlunoTurma->codigoturma;

            $this->matricula = $obAlunoTurma->codigo;

            $sqlRDisc = new TDbo(TConstantes::DBALUNOS_DISCIPLINAS);
            $critRDisc = new TCriteria();
            $critRDisc->add(new TFilter("codigoaluno","=",$this->matricula));
            $RDiscQuery = $sqlRDisc->select("*",$critRDisc);

            //retorna turma do aluno
            $sqlTurma = new TDbo(TConstantes::DBTURMAS);
            $critTurma = new TCriteria();
            $critTurma->add(new tFilter("codigo","=",$ch));
            $turmaQuery = $sqlTurma->select("*",$critTurma);

            $obTurma = $turmaQuery->fetchObject();

            //retorna Nome do Curso
            $sqlCurso = new TDbo(TConstantes::DBCURSOS);
            $critCurso = new TCriteria();
            $critCurso->add(new TFilter("codigo","=",$obTurma->codigocurso));
            $cursoQuery = $sqlCurso->select("*",$critCurso);

            $obCurso = $cursoQuery->fetchObject();


            //Atribui valores ao vetor do curso
            $vetCursos_nomeCurso = $obCurso->nome;
            $vetCursos_nomeTurma = $obTurma->titulo;

            //Monta estrutura das Disciplinas relacionadas

            while($obRDisc = $RDiscQuery->fetchObject()) {

                $this->codigoturmadisciplina = $obRDisc->codigoturmadisciplina;

                $sqlRelTurmaInicial = new TDbo(TConstantes::DBTURMAS_DISCIPLINAS);
                $critRelTurmaInicial = new TCriteria();
                $critRelTurmaInicial->add(new TFilter("codigo","=",$obRDisc->codigoturmadisciplinainicial));
                $relTurmaInicialQuery = $sqlRelTurmaInicial->select("codigodisciplina",$critRelTurmaInicial);
                $obRelTurmaInicial = $relTurmaInicialQuery->fetchObject();

                $codigodisciplinaInicial = $obRelTurmaInicial->codigodisciplina;


                $sqlRelTurma = new TDbo(TConstantes::VIEW_TURMAS_DISCIPLINAS);
                $critRelTurma = new TCriteria();
                $critRelTurma->add(new TFilter("codigo","=",$this->codigoturmadisciplina));
                $relTurmaQuery = $sqlRelTurma->select("*",$critRelTurma);
                $obRelTurma = $relTurmaQuery->fetchObject();

                $codigodisciplina = $obRelTurma->codigodisciplina;
                $codigoturma = $obRelTurma->codigoturma;


                $sqlTurmaAtual = new TDbo(TConstantes::DBTURMAS);
                $critTurmaAtual = new TCriteria();
                $critTurmaAtual->add(new tFilter("codigo","=",$codigoturma));
                $turmaAtualQuery = $sqlTurmaAtual->select("*",$critTurmaAtual);

                $obTurmaAtual = $turmaAtualQuery->fetchObject();
                $turmaAtual = $obTurmaAtual->nometurma;



                
                    $nomeProfessor = $obRelTurma->nomeprofessor;
                //retorna disciplina
                $sqlDisc = new TDbo(TConstantes::DBDISCIPLINAS);
                $critDisc = new TCriteria();
                $critDisc->add(new TFilter("codigo","=",$codigodisciplinaInicial));
                $discQuery = $sqlDisc->select("*",$critDisc);

                $obDisc = $discQuery->fetchObject();

                if($obDisc->cargahoraria == NULL) { $obDisc->cargahoraria = "-";}
                $disciplinaNome = $obRelTurma->nomedisciplina;
                $disciplinaCH = $obRelTurma-cargahoraria;

              $ementa = str_replace("\r\n", "<BR>", $obDisc->ementa);
              //Consulta de Orientações e Arquivos
                $sqlArquivos = new TDbo(TConstantes::DBTURMAS_DISCIPLINAS_ARQUIVOS);
                $critArquivos = new TCriteria();
                $critArquivos->add(new TFilter("codigoturmadisciplina","=",$this->codigoturmadisciplina));
                $discArquivos = $sqlArquivos->select("*",$critArquivos);

                while ($obArquivos = $discArquivos->fetchObject()){
                        $data = new TSetData();
                        $duracao = ($data->getData())-($obArquivos->datacad);

                    if($obArquivos->tipo == 1){
                        $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["orientacoes"][$obArquivos->codigo]["titulo"] = $obArquivos->titulo;
                        $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["orientacoes"][$obArquivos->codigo]["obs"] = str_replace("\r\n", "<BR>", $obArquivos->obs);
                        $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["orientacoes"][$obArquivos->codigo]["autor"] = $nomeProfessor;
                        $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["orientacoes"][$obArquivos->codigo]["datacad"] = $data->getDataPT($obArquivos->datacad)." (".$duracao." dias atras)";
                    }
                }


                //Atribui valores ao vetor de disciplinas do vetor do curso
                $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["nome"] = $disciplinaNome;
                $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["codigo"] = $codigodisciplina;
                $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["disciplinaCH"] = $disciplinaCH;
                $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["professor"] = $nomeProfessor;

                


            }

        }

        //Inicio do Cabe�alho

        $sqlCliente = new TDbo(TConstantes::DBPESSOAS);
        $critCliente = new TCriteria();
        $critCliente->add(new TFilter("codigo","=",$codigopessoa));
        $clienteQuery = $sqlCliente->select("*",$critCliente);

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
        $obFieds->setValue("aluno", $obCliente->nome_razaosocial);

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

        if(count($vetCursos) > 0){
        foreach($vetCursos as $chave => $valor) {
        //Disciplinas
            if ($vetCursos[$chave]['disciplinas'] == NULL) {

                $tr = new TElement('tr');
                $td = new TElement('td');
                $td->class = "tdatagrid_row1";
                $td->colspan = "4";
                $td->add("- não existem matérias relacionadas.");

                $tr->add($td);
                $tabela->add($tr);
            }else {

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

                     }else {

                         foreach($each["orientacoes"] as $chave2 => $valor2){
                             $orientacao = $each["orientacoes"][$chave2];

                                $icon = new TElement("img");
                                $icon->src = "../app.view/app.images/file_open.gif";
                                $icon->style = "cursor:pointer;";
                                $icon->title = "Ler";
                                $icon->onclick = 'viewLegenda(\'winRet\',\''.$orientacao["titulo"].'\',\'<br>'.$orientacao["obs"].'\')';


                                $tr = new TElement('tr');
                                $td = new TElement('td');
                                $td->class = "tdatagrid_row2";
                                $td->colspan = "3";
                                $td->add($icon);
                                $td->add(" - \"".$orientacao["titulo"]."\" - ".$orientacao["autor"]." em ".$orientacao["datacad"].".");
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
}

?>