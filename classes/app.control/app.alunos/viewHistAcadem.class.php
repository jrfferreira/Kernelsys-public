<?php
/**
* Classe  viewHistAcadem()
* Configura o atributo vindo do objeto pai(registro responsavel pela visualização do ap�ndice)
* Autor : Jo�o Felix
*/

class viewHistAcadem{

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
	    public function get(){

        //Retorna Usuario logado===================================
        $obUser = new TCheckLogin();
        $obUser = $obUser->getUser();
        //=========================================================

//        TTransaction::close();
//
//        TTransaction::open('../'.TOccupant::getPath().'app.config/my_dbpetrus');
//
//        if($conn = TTransaction::get()){


            //-----------------------------------Inicio das Informações Principais-------------------------------------

            //retorna codigo do Cliente
            $obCodigo = $obUser->codigo;

        //retorna informações do Aluno
        $sqlAluno = new TDbo(TConstantes::DBPESSOAS_ALUNOS);
        $critAluno = new TCriteria();
        $critAluno->add(new TFilter("codigopessoa","=",$obCodigo));
        $alunoQuery = $sqlAluno->select("codigoturma,codigo,codigopessoa",$critAluno);

        //retorna medias Necessarias
        $sqlMedias = new TDbo(TConstantes::DBPARAMETROS);
        $mediasQuery = $sqlMedias->select("medianota,mediapresenca");
        $obMedias = $mediasQuery->fetchObject();

        $medianota = $obMedias->medianota;
        $mediapresenca = $obMedias->mediapresenca;

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
            $vetCursos_nomeTurma = $obTurma->nometurma;

            //Monta estrutura das Disciplinas relacionadas

            while($obRDisc = $RDiscQuery->fetchObject()) {

                $this->codigoturmadisciplina = $obRDisc->codigoturmadisciplina;

                $sqlRelTurmaInicial = new TDbo(TConstantes::DBTURMAS_DISCIPLINAS);
                $critRelTurmaInicial = new TCriteria();
                $critRelTurmaInicial->add(new TFilter("codigo","=",$obRDisc->codigoturmadisciplinainicial));
                $relTurmaInicialQuery = $sqlRelTurmaInicial->select("codigodisciplina",$critRelTurmaInicial);
                $obRelTurmaInicial = $relTurmaInicialQuery->fetchObject();

                $codigodisciplinaInicial = $obRelTurmaInicial->codigodisciplina;


                $sqlRelTurma = new TDbo(TConstantes::DBTURMAS_DISCIPLINAS);
                $critRelTurma = new TCriteria();
                $critRelTurma->add(new TFilter("codigo","=",$this->codigoturmadisciplina));
                $relTurmaQuery = $sqlRelTurma->select("codigodisciplina,codigoturma,codigoprofessor,frequencia,datas",$critRelTurma);
                $obRelTurma = $relTurmaQuery->fetchObject();

                $codigodisciplina = $obRelTurma->codigodisciplina;
                $codigoturma = $obRelTurma->codigoturma;


                $sqlTurmaAtual = new TDbo(TConstantes::DBTURMAS);
                $critTurmaAtual = new TCriteria();
                $critTurmaAtual->add(new tFilter("codigo","=",$codigoturma));
                $turmaAtualQuery = $sqlTurmaAtual->select("*",$critTurmaAtual);

                $obTurmaAtual = $turmaAtualQuery->fetchObject();
                $turmaAtual = $obTurmaAtual->nometurma;


                $sqlProfessor = new TDbo(TConstantes::DBPESSOAS);
                $critProfessor = new TCriteria();
                $critProfessor->add(new TFilter("codigo","=",$obRelTurma->codigoprofessor));
                $professorQuery = $sqlProfessor->select("*",$critProfessor);

                $obProfessor = $professorQuery->fetchObject();


                $sqlProfessorCurriculo = new TDbo(TConstantes::DBFUNCIONARIOS_PROFESSORES);
                $critProfessorCurriculo = new TCriteria();
                $critProfessorCurriculo->add(new TFilter("codigo","=",$obProfessor->codigo));
                $professorCurriculoQuery = $sqlProfessorCurriculo->select("*",$critProfessorCurriculo);
                $obProfessorCurriculo = $professorCurriculoQuery->fetchObject();

                $curriculoProf = $obProfessorCurriculo->curriculo;


                    $professorEscolaridade = new setFormacao();
                    $professorTitularidade = $professorEscolaridade->setTitularidade($obRelTurma->codigoprofessor);

                    $nomeProfessor = $obProfessor->nome_razaosocial;
                //retorna disciplina
                $sqlDisc = new TDbo(TConstantes::DBDISCIPLINAS);
                $critDisc = new TCriteria();
                $critDisc->add(new TFilter("codigo","=",$codigodisciplinaInicial));
                $discQuery = $sqlDisc->select("*",$critDisc);

                $obDisc = $discQuery->fetchObject();

                if($obDisc->cargahoraria == NULL) { $obDisc->cargahoraria = "X"; }
                $disciplinaNome = $obDisc->titulo;
                $disciplinaCH = $obDisc->cargahoraria;

              $ementa = str_replace("\r\n", "<BR>", $obDisc->ementa);
               // $ementa = str_replace("&#13;", " ", $ementa);


               // $ementa = $obDisc->dcementa;

                //Retorna Datas
                $frmtData = new TSetData();

                if(strlen(rtrim($datasDisciplina)) == 10){
                $datasDisciplina = (string) $frmtData->dataPadraoPT($obRelTurma->datas);
                }else{
                    $datasDisciplina = (string) $obRelTurma->datas;

                }

                $dataInicial_unFrmt = split(',',$obRelTurma->datas);
                $dataInicial_unFrmt = $dataInicial_unFrmt[0];
                if($dataInicial_unFrmt) {



                    if(substr($dataInicial_unFrmt,4,1) == "-"){
                        $dataInicial = $frmtData->dataPadraoPT($dataInicial_unFrmt);
                    }else{
                        $dataInicial = $dataInicial_unFrmt;
                    }
                }
                //Retorna frequencias necessarias
                $frequencia = $obRelTurma->frequencia;

                //retorna Faltas do Aluno
                $sqlFaltas = new TDbo(TConstantes::DBALUNOS_FALTAS);
                $critFaltas = new TCriteria();
                $critFaltas->add(new TFilter("matAluno","=",$this->matricula));
                $critFaltas->add(new TFilter("codigoturmadisciplina","=",$this->codigoturmadisciplina));
                $faltaQuery = $sqlFaltas->select("datafalta,situacao",$critFaltas);



                $numeroFaltas = 0;
                $datasFaltas = "";
                $numeroFrequencia = 0;
                $data = new TSetData();

                while($obFaltas = $faltaQuery->fetchObject()) {
                    if ($obFaltas->situacao == "F") {
                        $numeroFaltas++;
                        $datasFaltas .= $data->dataPadraoPT($obFaltas->datafalta).", ";
                    }
                    $numeroFrequencia++;
                }

                //Calcula porcentagem de faltas
                if($frequencia > 0 and $numeroFrequencia > 0) {
                    $porcentagemFaltas = ($numeroFaltas*100)/$frequencia;
                    $porcentagemPresenca = 100-$porcentagemFaltas;
                }else {
                    $porcentagemPresenca = 100;
                }

                if($numeroFaltas == NULL){
                    $numeroFaltas = "não existem faltas";
                }

                //retorna Avaliações da Disciplina
                $sqlAvaliacao = new TDbo(TConstantes::DBTURMAS_DISCIPLINAS_AVALIACOES);
                $critAvaliacao = new TCriteria();
                $critAvaliacao->add(new TFilter("codigoturmadisciplina","=",$this->codigoturmadisciplina));
                $avaliacaoQuery = $sqlAvaliacao->select("*",$critAvaliacao);

                //Variaveis para calculo de media
                $divisor = 0;
                $dividendo = 0;
                $legendaNotas = "";

                //Retorna notas do Aluno
                while ($obAvaliacao = $avaliacaoQuery->fetchObject()) {


                    if(!$obAvaliacao->codigoPai) {

                        $sqlNotas = new TDbo(TConstantes::DBALUNOS_NOTAS);
                        $critNotas = new TCriteria();
                        $critNotas->add(new TFilter("codigoaluno","=",$this->matricula));
                        $critNotas->add(new TFilter("idavaliacao","=",$obAvaliacao->codigo));
                        $notasQuery = $sqlNotas->select("nota",$critNotas);

                        $obNota1 = $notasQuery->fetchObject();

                        if($obNota1->nota < $medianota) {
                            $sqlAvaliacaoRec = new TDbo(TConstantes::DBTURMAS_DISCIPLINAS_AVALIACOES);
                            $critAvaliacaoRec = new TCriteria();
                            $critAvaliacaoRec->add(new TFilter("codigoturmadisciplina","=",$this->codigoturmadisciplina));
                            $critAvaliacaoRec->add(new TFilter("codigoPai","=",$obAvaliacao->codigo));
                            $avaliacaoQueryRec = $sqlAvaliacaoRec->select("*",$critAvaliacaoRec);
                            $obAvaliacaoRec = $avaliacaoQueryRec->fetchObject();

                            $sqlNotas = new TDbo(TConstantes::DBALUNOS_NOTAS);
                            $critNotas = new TCriteria();
                            $critNotas->add(new TFilter("codigoaluno","=",$this->matricula));
                            $critNotas->add(new TFilter("idavaliacao","=",$obAvaliacaoRec->codigo));
                            $notasQuery = $sqlNotas->select("nota",$critNotas);

                            $obNota2 = $notasQuery->fetchObject();

                        }
                        if($obNota1->nota > $obNota2->nota){
                            $obNota = $obNota1;
                        }else{
                            $obNota = $obNota2;
                        }
                        if (!$obNota->nota) {
                            $obNota->nota = 0;
                        }
                        $divisor = $divisor + $obAvaliacao->peso;
                        $dividendo = $dividendo + ($obNota->nota*$obAvaliacao->peso);
                        $legendaNotas .= $obAvaliacao->avaliacao." (Peso ".$obAvaliacao->peso.") = ".$obNota->nota."<br>";

                        }

                }
                if($divisor != 0) {
                    $nota = floatval($dividendo/$divisor);
                }else {
                    $nota = "--";
                }
                //Atribui valores ao vetor de disciplinas do vetor do curso
                $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["nome"] = $disciplinaNome;
                $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["codigo"] = $codigodisciplina;
                $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["disciplinaCH"] = $disciplinaCH;
                $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["legendaDisciplina"] = $ementa;
                $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["turma"] = $turmaAtual;
                $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["professor"] = $nomeProfessor;

                $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["legendaProfessor"] = $curriculoProf;
                $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["professorTitularidade"] = $professorTitularidade;
                $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["faltas"] = substr($porcentagemPresenca,0,4);
                $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["legendaFaltas"] = $datasFaltas." (".$numeroFaltas.")";
                $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["nota"] = $nota;
                $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["legendaNotas"] = $legendaNotas;
                $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["dataInicial"] = $dataInicial;
                $vetCursos[$ch]["disciplinas"][$this->codigoturmadisciplina]["legendaDatas"] =  $datasDisciplina;


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
        $obFieds->geraCampo("N� de Matricula:", 'matricula', "TEntry", '');
        $obFieds->setProperty('matricula', 'disabled', 'disabled');
        $obFieds->setValue("matricula", $this->matricula);

        $obFieds->geraCampo("Aluno:", 'aluno', "TEntry", '');
        $obFieds->setProperty('aluno', 'disabled', 'disabled');
        $obFieds->setProperty('aluno', 'size', '60');
        $obFieds->setValue("aluno", $obCliente->nome_razaosocial);

        $obFieds->geraCampo("Curso:", 'curso', "TEntry", '');
        $obFieds->setProperty('curso', 'disabled', 'disabled');
        $obFieds->setProperty('curso', 'size', '60');
        $obFieds->setValue("curso", $vetCursos_nomeCurso.' - '.$vetCursos_nomeTurma);

        $tabHead->add($obFieds->getConteiner());

        $this->ob = new TElement('div');
        $this->ob->id = "contHistorico";
        $this->ob->add($tabHead);

        $fieldset = new TElement('fieldset');
        $legenda = new TElement('legend');
        $legenda->add("");

        $fieldset->add($legenda);

        $tabela = new TElement('table');
        $tabela->class = "tdatagrid_table";
        $tabela->width = "100%";

        $tr = new TElement('tr');

        $td = new TElement('td');
        $td->class = "tdatagrid_col";
        $td->style = "width=25%;";
        $td->add("Disciplina");

        $tr->add($td);

        $td = new TElement('td');
        $td->class = "tdatagrid_col";
        $td->style = "width=5%;";
        $td->add("C.Horaria");

        $tr->add($td);

        $td = new TElement('td');
        $td->class = "tdatagrid_col";
        $td->style = "width=10%;";
        $td->add("Turma");

        $tr->add($td);

        $td = new TElement('td');
        $td->class = "tdatagrid_col";
        $td->style = "width=20%;";
        $td->add("Professor");

        $tr->add($td);

        $td = new TElement('td');
        $td->class = "tdatagrid_col";
        $td->style = "width=10%;";
        $td->add("Titularidade");

        $tr->add($td);

        $td = new TElement('td');
        $td->class = "tdatagrid_col";
        $td->style = "width=7%;";
        $td->add("Presen�a");

        $tr->add($td);

        $td = new TElement('td');
        $td->class = "tdatagrid_col";
        $td->style = "width=7%;";
        $td->add("Nota");

        $tr->add($td);

        $td = new TElement('td');
        $td->class = "tdatagrid_col";
        $td->style = "width=25%;";
        $td->add("In�cio");

        $tr->add($td);

        $tabela->add($tr);

        $fieldset->add($tabela);

        if(count($vetCursos) > 0){
        foreach ($vetCursos as $chave => $valor) {


        //Disciplinas
            if ($vetCursos[$chave]['disciplinas'] == NULL) {

                $tr = new TElement('tr');
                $td = new TElement('td');
                $td->class = "tdatagrid_row1";
                $td->colspan = "3";
                $td->add("- não existem mat�rias relacionadas.");

                $tr->add($td);
                $tabela->add($tr);
            }else {

                foreach ($vetCursos[$chave]['disciplinas'] as $chave1 => $valor1) {

                    if($vetCursos[$chave]['disciplinas'][$chave1]["nota"] >= $medianota) {
                        $corTextoNota = "#0000FF";
                    }else {
                        $corTextoNota = "#FF0000";
                    }

                    if($vetCursos[$chave]['disciplinas'][$chave1]["faltas"] > $mediapresenca) {
                        $corTextoFaltas = "#0000FF";
                    }else {
                        $corTextoFaltas = "#FF0000";
                    }

                    $tr = new TElement('tr');

                    $td = new TElement('td');
                    $td->class = "tdatagrid_row1";
                    $td->style = "width=25%;";

                    //$Icon = new TElement('span');
                    //$Icon->style = "cursor:pointer;";
                    //$Icon->id = "icone_Relatorio";

                    //$img = new TElement('img');
                    //$img->src = "../app.view/app.images/lupa.gif";
                    //$img->onclick = 'viewLegenda(\'winRet\',\'Faltas e Notas\',\'<b>Faltas:</b><br>'.$vetCursos[$chave]['disciplinas'][$chave1]["legendaFaltas"].'<br><br><b>Notas:</b><br>'.$vetCursos[$chave]['disciplinas'][$chave1]["legendaNotas"].'\')';

                    //$Icon->add($img);
                    //$td->add($Icon);

                    $td->add($vetCursos[$chave]['disciplinas'][$chave1]["nome"]);
                    $td->style = "cursor:pointer";
                    $td->onclick = 'viewLegenda(\'winRet\',\'Ementa\',\'<br>'.$vetCursos[$chave]['disciplinas'][$chave1]["legendaDisciplina"].'\')';
                    $tr->add($td);

                     $td = new TElement('td');
                    $td->class = "tdatagrid_row1";
                    $td->style = "width=5%;text-align:center;";
                    $td->add($vetCursos[$chave]['disciplinas'][$chave1]["disciplinaCH"]);

                    $tr->add($td);

                    $td = new TElement('td');
                    $td->class = "tdatagrid_row1";
                    $td->style = "width=10%;text-align:center;";
                    $td->add($vetCursos[$chave]['disciplinas'][$chave1]["turma"]);

                    $tr->add($td);

                    $td = new TElement('td');
                    $td->class = "tdatagrid_row1";
                    $td->style = "width=20%;";
                    $td->add($vetCursos[$chave]['disciplinas'][$chave1]["professor"]);
                    $td->style = "cursor:pointer";
                    $td->onclick = 'viewLegenda(\'winRet\',\'Curr�culo\',\'<br>'.$vetCursos[$chave]['disciplinas'][$chave1]["legendaProfessor"].'\')';


                    $tr->add($td);

                    $td = new TElement('td');
                    $td->class = "tdatagrid_row1";
                    $td->style = "width=10%;text-align:center;";
                    $td->add($vetCursos[$chave]['disciplinas'][$chave1]["professorTitularidade"]);

                    $tr->add($td);

                    $td = new TElement('td');
                    $td->class = "tdatagrid_row1";
                    $td->style = "text-align:center;width=7%;cursor:pointer;color: ".$corTextoFaltas;
                    $td->add("<B>".$vetCursos[$chave]['disciplinas'][$chave1]["faltas"]."%</B>");
                    $td->onclick = 'viewLegenda(\'winRet\',\'Faltas\',\'<br>'.$vetCursos[$chave]['disciplinas'][$chave1]["legendaFaltas"].'\')';


                    $tr->add($td);

                    $td = new TElement('td');
                    $td->class = "tdatagrid_row1";
                    $td->style = "text-align:center;cursor:pointer;width=7%;color: ".$corTextoNota;

                    $td->add("<b>".$vetCursos[$chave]['disciplinas'][$chave1]["nota"]."</b>");
                    $td->onclick = 'viewLegenda(\'winRet\',\'Notas\',\'<br>'.$vetCursos[$chave]['disciplinas'][$chave1]["legendaNotas"].'\')';

                    $tr->add($td);

                    $td = new TElement('td');
                    $td->class = "tdatagrid_row1";
                    $td->style = "text-align: left; width=25%;";

                    $Icon = new TElement('span');
                    $Icon->style = "cursor:pointer;";
                    $Icon->id = "icone_Datas";

                    //                    $img = new TElement('img');
                    //                    $img->src = "../app.view/app.images/calendar.gif";
                    //                    $img->onclick = 'viewLegenda(\'winRet\',\'Datas\',\'<div id=div_calendario_multiplo>'.$vetCursos[$chave]['disciplinas'][$chave1]["legendaDatas"].'</div> \')';

                    $campoDatas = new TElement('input');
                    $campoDatas->readyOnly = 'true';
                    $campoDatas->class = 'ui_calendario_multiplo';
                    $campoDatas->value = $vetCursos[$chave]['disciplinas'][$chave1]["legendaDatas"];

                    //$Icon->add($img);
                    $Icon->add($campoDatas);
                    $td->add($Icon);
                    //$td->add($vetCursos[$chave]['disciplinas'][$chave1]["dataInicial"]);

                    $tr->add($td);


                    $tabela->add($tr);

                }
            }




        }
        }//valida foreach
        $this->ob->add($fieldset);

        $info = new TElement('div');
        $info->style = 'font-size:10px; padding-left:5px';
        $info->add('* As datas e nomes de professores podem sofrer alteração sem aviso pr�vio.');

        $this->ob->add($info);



        return $this->ob;


    }
}

?>