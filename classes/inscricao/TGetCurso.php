<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
*/

class TGetCurso {

    private $dbo = NULL;
    private $form;
    private $label = array();
    private $dados = NULL;
    private $divMsg;
    private $valida = true;
    private $editable = true;

    public function  __construct($tipo, $codigo = NULL) {

        $unidade = "14303-1";
        $this->dbo = new TDbo_out($unidade);

        $this->dados = $dados;
        $this->form = new TForm('formInscricao');

        $this->obSession = new TSession();

        $this->retorno = null;

        if($tipo == 'tipoCurso') {
            $this->viewLista($unidade, $codigo, strtolower($tipo));
        }
        elseif(stripos($tipo,'|')) {
            $this->viewLista($unidade, $codigo, strtolower($tipo));
        }
        elseif($tipo == 'areaCurso') {
            $this->viewLista($unidade, $codigo, strtolower($tipo));
        }
        elseif($tipo == 'informacaoCurso') {
            $this->viewCurso($codigo);
        }
        else {
            $this->viewLista($unidade, 'lista');
        }
    }


    /*
     * 
     *
    */
    public function getCurso($codigo) {
        try {

            if($codigo) {
                $this->dbo->setEntidade("dbcursos");
                $criterioCurso = new TCriteria();
                $criterioCurso->add(new TFilter('codigo','=',$codigo));
                $retCurso = $this->dbo->select('*', $criterioCurso);

                $obCurso = $retCurso->fetch();

                if($obCurso['codigoareacurso']) {
                    $critareaCurso = new TCriteria();
                    $critareaCurso->add(new TFilter('codigo','=',$obCurso['codigoareacurso']));

                    $this->dbo->setEntidade("dbcursos_areas");
                    $retareaCurso = $this->dbo->select('titulo', $critareaCurso);
                    $obareaCurso = $retareaCurso->fetchObject();

                    $obCurso['areacurso'] = $obareaCurso->titulo;
                }
                if($obCurso['codigotipocurso']) {
                    $crittipoCurso = new TCriteria();
                    $crittipoCurso->add(new TFilter('codigo','=',$obCurso['codigotipocurso']));

                    $this->dbo->setEntidade("dbcursos_tipos");
                    $rettipoCurso = $this->dbo->select('titulo', $crittipoCurso);
                    $obtipoCurso = $rettipoCurso->fetchObject();

                    $obCurso['tipocurso'] = $obtipoCurso->titulo;
                }

                $this->dbo->setEntidade("dbturmas");
                $criterioTurmas = new TCriteria();
                $criterioTurmas->add(new TFilter('acinscricao','=','1'),'AND');
                $criterioTurmas->add(new TFilter('codigocurso','=',$codigo),'AND');
                $retTurmas = $this->dbo->select("*", $criterioTurmas);

                if($retTurmas) {
                    while($obTurma = $retTurmas->fetch()) {
                        $obCurso['turmas'][] = $obTurma;
                    }
                }

                $this->dbo->setEntidade("view_cursos_disciplinas");
                $criterioCursoDisciplinas = new TCriteria();
                $criterioCursoDisciplinas->add(new TFilter('codigocurso','=',$codigo));
                $retCursoDisciplinas = $this->dbo->select('codigodisciplina', $criterioCursoDisciplinas);

                if($retCursoDisciplinas) {
                    while($obCursoDisciplinas = $retCursoDisciplinas->fetchObject()) {
                        $this->dbo->setEntidade("dbdisciplinas");
                        $criterioDisciplina = new TCriteria();
                        $criterioDisciplina->add(new TFilter('codigo','=',$obCursoDisciplinas->codigodisciplina));
                        $retDisciplina = $this->dbo->select('*', $criterioDisciplina);

                        if($retDisciplina) {
                            $obDisciplina = $retDisciplina->fetch();
                            $obCurso['disciplinas'][] = $obDisciplina;
                        }
                    }
                }


                return $obCurso;

            }else {
                $this->sair();
            }

        }catch (Exception $e) {
            echo $e;
        }
    }

    /*
     * 
    */
    public function viewCurso($codigo) {

        $obCurso = $this->getCurso($codigo);

        $titulo = new TElement('div');
        $titulo->class = "conteiner_bot";
        $titulo->id = "TituloCurso";
        $titulo->style = "height: 25px; margin: 2px;";
        $titulo->add($obCurso["nome"]);

        $obLista = new TElement("div");
        $obLista->class = "conteiner_inscricao";
        $obLista->add($titulo);

        $table = new TTable();
        $table->width = "100%";
        $table->border = 0;
        $table->style = "font-size: 10px";

        $infoCurso = $table->addRow();
        $tempCell = $infoCurso->addCell("Tipo de Curso:");
        $tempCell->id = "TipoDeCurso";
        $tempCell->align = "left";
        $tempCell->class = "titulo_info";
        $tempCell = $infoCurso->addCell($obCurso['tipocurso']);
        $tempCell->align = "left";

        $infoCurso = $table->addRow();
        $tempCell = $infoCurso->addCell("Area:");
        $tempCell->id = "Area";
        $tempCell->align = "left";
        $tempCell->class = "titulo_info";
        $tempCell = $infoCurso->addCell($obCurso['areacurso']);
        $tempCell->align = "left";


        $infoCurso = $table->addRow();
        $tempCell = $infoCurso->addCell("Carga Horária Total:");
        $tempCell->id = "CargaHorariaTotal";
        $tempCell->align = "left";
        $tempCell->class = "titulo_info";
        $tempCell = $infoCurso->addCell($obCurso['cargahortotal']." hs");
        $tempCell->align = "left";


        $informacoes[] = $table;

        $table = new TTable();
        $table->width = "100%";
        $table->border = 0;
        $table->style = "font-size: 10px";

        $infoCurso = $table->addRow();
        $tempCell = $infoCurso->addCell("Objetivo do Curso");
        $tempCell->id = "ObjetivoDoCurso";
        $tempCell->align = "left";
        $tempCell->class = "titulo_info";

        $infoCurso = $table->addRow();
        $tempCell = $infoCurso->addCell($obCurso['objetivocurso']);
        $tempCell->align = "left";


        $informacoes[] = $table;

        $table = new TTable();
        $table->width = "100%";
        $table->border = 0;
        $table->style = "font-size: 10px";

        $infoCurso = $table->addRow();
        $tempCell = $infoCurso->addCell("Publico Alvo");
        $tempCell->id = "PublicoAlvo";
        $tempCell->class = "titulo_info";

        $infoCurso = $table->addRow();
        $tempCell = $infoCurso->addCell($obCurso['publicoalvo']);
        $tempCell->align = "left";


        $informacoes[] = $table;


        // lista disciplinas
        $disciplinas = new TTable();
        $disciplinas->width = "100%";
        $disciplinas->border = 0;
        $disciplinas->style = "font-size: 10px";
        $disciplinas->class = "lista";
        $disciplinas->cellspacing = 0;

        $titDisciplinas = $disciplinas->addRow();
        $tempCell = $titDisciplinas->addCell("Disciplinas");
        $tempCell->id = "Disciplinas";
        $tempCell->class = "titulo_info";
        if($obCurso['disciplinas'] != NULL) {
            foreach($obCurso['disciplinas'] as $disciplina) {
                $infoDisciplina = $disciplinas->addRow();
                $tempCell = $infoDisciplina->addCell($disciplina["titulo"]." - ".$disciplina["cargahoraria"]." hs");
                $tempCell->align = "left";
                $count++;
            }
        }
        $informacoes[] = $disciplinas;


        // lista turmas
        $turmas = new TTable();
        $turmas->width = "100%";
        $turmas->border = 0;
        $turmas->style = "font-size: 10px";
        $turmas->class = "lista";
        $turmas->cellspacing = 0;

        $tituloTurmas = $turmas->addRow();
        $tempCell = $tituloTurmas->addCell("Turmas");
        $tempCell->id = "Turmas";
        $tempCell->class = "titulo_info";
        $tempCell->colspan = "5";

        if($obCurso['turmas'] != NULL) {
            $count = 0;
            foreach($obCurso['turmas'] as $turma) {
                $infoTurma = $turmas->addRow();
                if(($count%2) == 1) {
                    $infoTurma->class = "odd";
                }else {
                    $infoTurma->class = "even";
                }

                $TSetModel = new TSetModel();
                $tempCell = $infoTurma->addCell("<b>".$turma["titulo"]."</b>");
                $tempCell->align = "left";
                $tempCell = $infoTurma->addCell("<b>Início:</b> <br/> ".$TSetModel->setDataPT($turma["datainicio"]));
                $tempCell->align = "left";
                $tempCell = $infoTurma->addCell("<b>Dias:</b>  <br/> ".$turma["diasaula"]);
                $tempCell->align = "left";
                $tempCell = $infoTurma->addCell("<b>Local:</b>  <br/> ".$turma["localaulas"]);
                $tempCell->align = "left";
                $a = new TElement("a");
                $a->href = "TSetInscricao.class.php?tipo=i&prod=".$turma['codigoproduto'];
                $a->target = "_blank";
                $a->add("Inscreva-se");
                $tempCell = $infoTurma->addCell($a);
                $tempCell->align = "right";

                $count++;
            }
        }
        $infoTurma = $turmas->addRow();
        if(($count%2) == 1) {
            $infoTurma->class = "odd";
        }else {
            $infoTurma->class = "even";
        }
        $tempCell = $infoTurma->addCell("Turmas Futuras (Aguardar outros horários disponíveis)");
        $tempCell->align = "left";
        $tempCell->colspan = "4";
        $a = new TElement("a");
        $a->href = "TSetInscricao.class.php?tipo=d&prod=".$obCurso['codigo'];
        $a->add("Inscreva-se");
        $tempCell = $infoTurma->addCell($a);
        $tempCell->align = "right";

        $informacoes[] = $turmas;


        foreach($informacoes as $t) {

            $obItem = new TElement("div");
            $obItem->class = "conteiner_produto";
            $obItem->style = "margin: 2px;";
            $obItem->add($t);

            $obLista->add($obItem);
        }


        $this->retorno = $obLista;
    }

    /*
     * 
     *
    */
    public function viewLista($unidade, $codigo,$tipo=null) {
        $titulo = new TElement('div');
        $titulo->class = "conteiner_bot";
        $titulo->style = "height: 25px; margin: 2px;";
        if($tipo == 'areacurso') {

            if($codigo) {
                $critTitulo = new TCriteria();
                $critTitulo->add(new TFilter('codigo','=',$codigo));
            }
            $Tdbo = new TDbo_out($unidade, "dbcursos_areas");
            $retTitulo = $Tdbo->select('titulo', $critTitulo);
            $obTitulo = $retTitulo->fetchObject();
            $titulo->add("Cursos na Área de ".$obTitulo->titulo.".");
        }
        elseif($tipo == 'tipocurso') {
            if($codigo) {
                $critTitulo = new TCriteria();
                $critTitulo->add(new TFilter('codigo','=',$codigo));
            }
            $Tdbo = new TDbo_out($unidade, "dbcursos_tipos");
            $retTitulo = $Tdbo->select('titulo', $critTitulo);
            $obTitulo = $retTitulo->fetchObject();
            $titulo->add("Cursos do tipo ".$obTitulo->titulo.".");
        }
        else {
            $titulo->add("Lista de Cursos.");
        }

        if($tipo) {
            if(strpos($tipo,'|')){
                $t = explode('|', $tipo);
                $criterio = new TCriteria();
                if($t[0] == 'p'){
                    $filtro1 = new TFilter('codigotipocurso','=','110057-00');
                    $filtro1->tipoFiltro = 3;
                    $criterio->add($filtro1,'OR');
                    $filtro2 = new TFilter('codigotipocurso','=','120057-00');
                    $filtro2->tipoFiltro = 3;
                    $criterio->add($filtro2,'OR');
                    $filtro3 = new TFilter('codigotipocurso','=','130057-00');
                    $filtro3->tipoFiltro = 3;
                    $criterio->add($filtro3,'OR');
                }else{
                    $filtro1 = new TFilter('codigotipocurso','!=','110057-00');
                    $filtro1->tipoFiltro = 3;
                    $criterio->add($filtro1,'AND');
                    $filtro2 = new TFilter('codigotipocurso','!=','120057-00');
                    $filtro2->tipoFiltro = 3;
                    $criterio->add($filtro2,'AND');
                    $filtro3 = new TFilter('codigotipocurso','!=','130057-00');
                    $filtro3->tipoFiltro = 3;
                    $criterio->add($filtro3,'AND');
                }
                if($codigo){
                    if(strpos($codigo,'|')){
                        $c = explode('|', $codigo);
                        foreach($c as $chave){
                        $filtro = new TFilter('codigoareacurso','=',$chave);
                        $filtro->tipoFiltro = 4;
                        $criterio->add($filtro,'AND');
                        }
                    }else{
                        $filtro = new TFilter('codigoareacurso','=',$codigo);
                        $filtro->tipoFiltro = 4;
                        $criterio->add($filtro,'AND');
                    }
                }
            }else{
                $criterio = new TCriteria();
                if(strpos($codigo,'|')){
                    $c = explode('|', $codigo);
                    foreach($c as $chave){
                        $filtro =new TFilter('codigo'.$tipo,'=',$chave);
                        $filtro->tipoFiltro = 4;
                        $criterio->add($filtro,'OR');
                    }
                }else{
                        $filtro =new TFilter('codigo'.$tipo,'=',$codigo);
                        $filtro->tipoFiltro = 4;
                        $criterio->add($filtro,'OR');
                }
            }
        }



        $Tdbo = new TDbo_out($unidade, "dbcursos");
        $retCursos = $Tdbo->select('codigo', $criterio);
        while($obRetCursos = $retCursos->fetchObject()) {
            $cursos[] = $obRetCursos;
        }
        $obLista = new TElement("div");
        $obLista->class = "conteiner_inscricao";
        $obLista->add($titulo);

        if($cursos){
        foreach ($cursos as $obRetCursos){
            $obCurso = $this->getCurso($obRetCursos->codigo);
            $table = new TTable();
            $table->width = "100%";
            $table->border = 0;
            $table->style = "font-size: 10px";

            $titulos = $table->addRow();
            $tempCell = $titulos->addCell('Curso');
            $tempCell->width = "60%";
            $tempCell->style = "font-weight: bolder; font-size: 11px; border-bottom: 1px dotted #f0f0f0;";
            $tempCell = $titulos->addCell('Local');
            $tempCell->style = "font-weight: bolder; font-size: 11px; text-align: center; border-bottom: 1px dotted #f0f0f0;";
            $tempCell = $titulos->addCell('Turmas');
            $tempCell->style = "font-weight: bolder; font-size: 11px; text-align: center; border-bottom: 1px dotted #f0f0f0;";
            $tempCell = $titulos->addCell('Inscrição');
            $tempCell->style = "font-weight: bolder; font-size: 11px; text-align: center; border-bottom: 1px dotted #f0f0f0;";

            $nomeCurso = $table->addRow();
            $tempCell = $nomeCurso->addCell($obCurso['nome']);
            $tempCell->style = "font-weight: bolder;";
            $tempCell->align = "left";


            if($obCurso['turmas'] != NULL) {
                $locais = null;
                foreach($obCurso['turmas'] as $turmas){
                    $locais[$turmas['localaulas']] = $turmas['localaulas'];
                }
                $locais = implode(', ',$locais);
                $tempCell = $nomeCurso->addCell($locais);
                $tempCell->align = "center";
                $tempCell = $nomeCurso->addCell("Abertas");
                $tempCell->align = "center";

            }else {
                $tempCell->colspan = "3";
            }

            $a = new TElement("a");
            $a->href = "?tipo=informacaoCurso&codigo=".$obCurso['codigo'];
            $a->add("Saiba mais");

            $tempCell = $nomeCurso->addCell($a);
            $tempCell->align = "center";


            $obItem = new TElement("div");
            $obItem->class = "conteiner_produto";
            $obItem->style = "margin: 2px;";

            $obItem->add($table);

            $obLista->add($obItem);
        }
        }else{
            $obItem = new TElement("div");
            $obItem->class = "conteiner_produto";
            $obItem->style = "margin: 2px; text-align: center; font-size: 12px; font-weight: bolder;";

            $obItem->add('Não há cursos nesta categoria.');

            $obLista->add($obItem);
        }

        $this->retorno = $obLista;
    }

    /*
     * 
     *
    */

    public function show($estilo = null) {

        $obCss = new TElement('link');
        $obCss->type = "text/css";
    	if($estilo == null){
        	$obCss->href="estilo_gap/estilo.css";
        }else{
        	$obCss->href="{$estilo}/estilo.css";
        }
        $obCss->rel="Stylesheet";

        $page = new TPage("Lista de Cursos");
        $page->addHead($obCss);
        $page->add($this->retorno);
        $page->show();
    }

}



function __autoload($classe) {
    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}

$x = new TGetCurso($_GET['tipo'],$_GET['codigo']);
$x->show($_GET['estilo']);
?>