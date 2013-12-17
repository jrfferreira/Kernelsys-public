<?php
//==========================================================
//
//
//==========================================================
session_start();

$seq= $_GET['rcod'];

function __autoload($classe){

	include_once('../app.util/autoload.class.php');
	$autoload = new autoload('../',$classe);
}

$TTurmaDisciplina = new TTurmaDisciplinas();

$obDisciplina = $TTurmaDisciplina->getTurmaDisciplina($seq);

$turma = $obDisciplina->nometurma;
$curso = $obDisciplina->nomecurso;
$disciplina = $obDisciplina->nomedisciplina;
$cargahoraria = $obDisciplina->cargahoraria;
$professor = $obDisciplina->nomeprofessor;

if($cargahoraria){
	$cargahoraria = $cargahoraria . " hr";
}

if($professor == " ()"){
	$professor = "--";
}

$tabela = new TElement("table");
$tabela->__set("width","100%");

$tr = new TElement("tr");
$td = new TElement("td");

$td->__set("class","titulo");
$td->__set("style","font-size:24px;");
$td->__set("colspan","3");
$td->__set("width","100%");

$td->add("Lista de Presença");
$tr->add($td);
$tabela->add($tr);

$tr = new TElement("tr");
$th = new TElement("th");

$th->__set("width","36%");
$th->__set("align","left");
$th->__set("scope","col");
$th->add('Curso: '.$curso);

$tr->add($th);


$th = new TElement("th");

$th->__set("width","40%");
$th->__set("align","left");
$th->__set("scope","col");
$th->add('<b>Turma: </b>'.$turma);

$tr->add($th);

$td = new TElement("td");

$td->__set("width","24%");
$td->__set("rowspan","3");
$td->__set("scope","col");

$img = new TElement("img");
$img->__set("src","../".TOccupant::getPath()."app.config/logo.png");
$img->__set("width","100px");
$img->__set("style","max-width: 100px; max-height: auto");

$td->add($img);

$tr->add($td);


$tabela->add($tr);



$tr = new TElement("tr");

$th = new TElement("th");
$th->__set("align","left");
$th->__set("scope","row");
$th->add('Disciplina: '.$disciplina);

$tr->add($th);

$th = new TElement("th");
$th->__set("align","left");
$th->__set("scope","row");
$th->add('C.H: '.$cargahoraria);

$tr->add($th);
$tabela->add($tr);

$tr = new TElement("tr");

$th = new TElement("th");
$th->__set("align","left");
$th->__set("scope","row");
$th->__set("colspan","2");
$th->add('Professor(a): '.$professor);

$tr->add($th);
$tabela->add($tr);


$br = new TElement("br");

$tabelaNomes = new TElement("table");
$tabelaNomes->__set("width","100%");
$tabelaNomes->cellpadding = "0";
$tabelaNomes->cellspacing = 1;

$tr = new TElement("tr");

$tdNome = new TElement("td");
$tdNome->class =  "titulo";
$tdNome->style =  "font-size: 13px; font-weight: bold;";
$tdNome->scope = "col";
$tdNome->add("Aluno");

$tdMatricula = new TElement("td");
$tdMatricula->width = "15%";
$tdMatricula->class =  "titulo";
$tdMatricula->style =  "font-size: 13px; font-weight: bold;";
$tdMatricula->scope = "col";
$tdMatricula->add("Matricula");


$TUnidade = new TUnidade();
$numDatas = $TUnidade->getParametro('listapresenca_datas');
$numCampos = $TUnidade->getParametro('listapresenca_datascampos');

$numDatas = $numCampos->listapresenca_datas;
$numCampos = $numCampos->listapresenca_datascampos;

if(!$numCampos){
	$numCampos = 1;
}

$tdData = new TElement("td");
$tdData->width = "15%";
$tdData->class =  "titulo";
$tdData->style =  "font-size: 13px; font-weight: bold;";
$tdData->scope = "col";
$tdData->colspan = $numCampos;
$tdData->add("_____/_____/______");

$numDatas = $numDatas ? $numDatas : 1;

$tr->add($tdNome);
$tr->add($tdMatricula);

$n = 0;
while($n < $numDatas){
	$tr->add($tdData);
	$n++;
}

$tabelaNomes->add($tr);

$retAlunosDisc = $TTurmaDisciplina->getAlunos($seq);

foreach ($retAlunosDisc as $obAlunos){
	$tr = new TElement("tr");
	$tr->height = "8px";

	$th = new TElement("th");
	$th->scope = "row";
	$th->style = "font-size: 11px;";
	$th->add($obAlunos->nomepessoa);

	$td = new TElement("td");
	$td->style = "font-size: 11px;";
	$td->add($obAlunos->codigo);

	$tdEmpty = new TElement("td");
	$tdEmpty->add("&nbsp;");

	$tr->add($th);
	$tr->add($td);
	$n = 0;
	while($n < $numDatas){	
		$n2 = 0;
		while ($n2 < $numCampos){
			$tr->add($tdEmpty);
			$n2++;
		}
		$n++;
	}

	$tabelaNomes->add($tr);

}

$ass_Obs = new TElement("table");
$ass_Obs->width = "100%";
$ass_Obs->height = "100px";
$ass_Obs->border = 0;

$tr = new TElement("tr");

$td = new TElement("td");
$td->width = "30%";
$td->style = "text-align: center;. vertical-align: top;";
$td->add("<br>");
$td->add("<br>");
$td->add("_____________________________________");
$td->add("<br>");
$td->add("Assinatura do(a) Professor(a)");

$td2 = new TElement("td");
$td2->width = "70%";
$td2->style = "text-align: left; vertical-align: top;";
$td2->add("Observações:");

$tr->add($td);
$tr->add($td2);

$ass_Obs->add($tr);

$doc = new TElement("html");

$docTitle = new TElement("title");
$docTitle->add('Lista de Presença - '.$disciplina);

$docStyle = new TElement("style");
$docStyle->add("table{border:1px solid #000;}");
$docStyle->add("th {border: thin solid #999;text-align: left;}");
$docStyle->add("td {border: thin solid #999;text-align: center;}");
$docStyle->add("td.titulo {border:1px solid #000;text-align: center;background-color: #E8E8E8;}");
$docStyle->add("body{font-family:Arial, Helvetica, sans-serif;font-size: 13px;}");

$docBody = new TElement("body");
$docBody->style = "vertical-align: top; weight: 100%";

$docBody->add($tabela);
$docBody->add($br);
$docBody->add($tabelaNomes);
$docBody->add($br);
$docBody->add($ass_Obs);

$docHead = new TElement('head');
$docHead->add('<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />');
$docHead->add($docTitle);
$docHead->add($docStyle);

$doc->add($docHead);
$doc->add($docBody);


$doc->show();

?>