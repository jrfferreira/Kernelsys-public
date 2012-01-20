<?php

/**
 * WebService para consulta de Informações do curso.
 */
function __autoload($classe) {
	include_once ('../app.util/autoload.class.php');
	$autoload = new autoload ( '../', $classe );
}

$dataset = parse_ini_file ( '../' . TOccupant::getPath () . 'app.config/dataset.ini' );

function getLista($unidade, $tipo = null, $area = null, $notEmpty = null) {
	
	$criterio = new TCriteria ();
	
	if ($area) {
		$filtro = new TFilter ( 'codigoareacurso', '=', $area );
		$filtro->tipoFiltro = 4;
		$criterio->add ( $filtro, 'AND' );
	}
	
	if ($tipo) {
		if ($tipo == 'p') {
			$filtro1 = new TFilter ( 'codigotipocurso', '=', '110057-00' );
			$filtro1->tipoFiltro = 3;
			$criterio->add ( $filtro1, 'OR' );
			$filtro2 = new TFilter ( 'codigotipocurso', '=', '120057-00' );
			$filtro2->tipoFiltro = 3;
			$criterio->add ( $filtro2, 'OR' );
			$filtro3 = new TFilter ( 'codigotipocurso', '=', '130057-00' );
			$filtro3->tipoFiltro = 3;
			$criterio->add ( $filtro3, 'OR' );
		} elseif ($tipo == 't') {
			$filtro1 = new TFilter ( 'codigotipocurso', '!=', '110057-00' );
			$filtro1->tipoFiltro = 3;
			$criterio->add ( $filtro1, 'AND' );
			$filtro2 = new TFilter ( 'codigotipocurso', '!=', '120057-00' );
			$filtro2->tipoFiltro = 3;
			$criterio->add ( $filtro2, 'AND' );
			$filtro3 = new TFilter ( 'codigotipocurso', '!=', '130057-00' );
			$filtro3->tipoFiltro = 3;
			$criterio->add ( $filtro3, 'AND' );
			$filtro4 = new TFilter ( 'codigotipocurso', '!=', '10054860-960' );
			$filtro4->tipoFiltro = 3;
			$criterio->add ( $filtro4, 'AND' );
			
		}
	}
	
	if($notEmpty == true){
			$filtro5 = new TFilter ("(SELECT count(t5.codigocurso) AS count FROM dbturmas t5 WHERE t5.codigocurso = t0.codigo and t5.acinscricao = '1')", '>', 0 );
			$filtro5->tipoFiltro = 5;
			$criterio->add ( $filtro5, 'AND' );
	}
	
	$Tdbo = new TDbo_out ( $unidade, "dbcursos as t0" );
	$retCursos = $Tdbo->select ( '*', $criterio );
	while ( $obRetCursos = $retCursos->fetchObject() ) {
		$cursos [] = $obRetCursos;
	}
	if(count($cursos) > 0){
		return $cursos;
	}else{
		return "Nenhum curso foi encontrado";
	}
}

function getCurso($unidade, $codigo) {
	try {
		$dbo = new TDbo_out ( $unidade );
		if ($codigo) {
			$dbo->setEntidade ( "dbcursos" );
			$criterioCurso = new TCriteria ();
			$criterioCurso->add ( new TFilter ( 'codigo', '=', $codigo ) );
			$retCurso = $dbo->select ( '*', $criterioCurso );
			
			$obCurso = $retCurso->fetch ();
			
			if ($obCurso ['codigoareacurso']) {
				$critareaCurso = new TCriteria ();
				$critareaCurso->add ( new TFilter ( 'codigo', '=', $obCurso ['codigoareacurso'] ) );
				
				$dbo->setEntidade ( "dbcursos_areas" );
				$retareaCurso = $dbo->select ( 'titulo', $critareaCurso );
				$obareaCurso = $retareaCurso->fetchObject ();
				
				$obCurso ['areacurso'] = $obareaCurso->titulo;
			}
			if ($obCurso ['codigotipocurso']) {
				$crittipoCurso = new TCriteria ();
				$crittipoCurso->add ( new TFilter ( 'codigo', '=', $obCurso ['codigotipocurso'] ) );
				
				$dbo->setEntidade ( "dbcursos_tipos" );
				$rettipoCurso = $dbo->select ( 'titulo', $crittipoCurso );
				$obtipoCurso = $rettipoCurso->fetchObject ();
				
				$obCurso ['tipocurso'] = $obtipoCurso->titulo;
			}
			
			$dbo->setEntidade ( "dbturmas" );
			$criterioTurmas = new TCriteria ();
			$criterioTurmas->add ( new TFilter ( 'acinscricao', '=', '1' ), 'AND' );
			$criterioTurmas->add ( new TFilter ( 'codigocurso', '=', $codigo ), 'AND' );
			$retTurmas = $dbo->select ( "*", $criterioTurmas );
			
			if ($retTurmas) {
				while ( $obTurma = $retTurmas->fetch () ) {
					$obCurso ['turmas'] [] = $obTurma;
				}
			}
			
			$dbo->setEntidade ( "view_cursos_disciplinas" );
			$criterioCursoDisciplinas = new TCriteria ();
			$criterioCursoDisciplinas->add ( new TFilter ( 'codigocurso', '=', $codigo ) );
			$retCursoDisciplinas = $dbo->select ( 'codigodisciplina', $criterioCursoDisciplinas );
			
			if ($retCursoDisciplinas) {
				while ( $obCursoDisciplinas = $retCursoDisciplinas->fetchObject () ) {
					$dbo->setEntidade ( "dbdisciplinas" );
					$criterioDisciplina = new TCriteria ();
					$criterioDisciplina->add ( new TFilter ( 'codigo', '=', $obCursoDisciplinas->codigodisciplina ) );
					$retDisciplina = $dbo->select ( '*', $criterioDisciplina );
					
					if ($retDisciplina) {
						$obDisciplina = $retDisciplina->fetch ();
						$obCurso ['disciplinas'] [] = $obDisciplina;
					}
				}
			}
			
			return $obCurso;
		
		} else {
			return "Não foi possivel encontrar este curso.";
		}
	
	} catch ( Exception $e ) {
		echo $e;
	}
}

$server = new SoapServer ( null, array ('uri' => $dataset ['pathSystem'] . '/app.wsdl/' ) );
$server->addFunction ( "getLista" );
$server->addFunction ( "getCurso" );

$server->handle ();