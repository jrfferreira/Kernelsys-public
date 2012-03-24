<?php
class setTurmaDisciplina{

     function setLabel($frm){

        $consultaCodigo = new TDbo(TConstantes::DBTURMAS_DISCIPLINAS);
        $criterioCodigo = new TCriteria();
        $criterioCodigo->add(new TFilter("codigo","=",$frm));
        $retConsultaCodigo = $consultaCodigo->select("*",$criterioCodigo);
        $obRetCodigo = $retConsultaCodigo->fetchObject();

        $consultaCurso = new TDbo(TConstantes::DBCURSOS);
        $criterioCurso = new TCriteria();
        $criterioCurso->add(new TFilter("codigo","=",$obRetCodigo->codigocurso));
        $retConsultaCurso = $consultaCurso->select("nome",$criterioCurso);

        $consultaDisc = new TDbo(TConstantes::DBDISCIPLINAS);
        $criterioDisc = new TCriteria();
        $criterioDisc->add(new TFilter("codigo","=",$obRetCodigo->codigodisciplina));
        $retConsultaDisc = $consultaDisc->select("titulo",$criterioDisc);

        $consultaTurma = new TDbo(TConstantes::DBTURMAS);
        $criterioTurma = new TCriteria();
        $criterioTurma->add(new TFilter("codigo","=",$obRetCodigo->codigoturma));
        $retConsultaTurma = $consultaTurma->select("nometurma",$criterioTurma);

        $obRetCurso = $retConsultaCurso->fetchObject();
        $obRetDisc = $retConsultaDisc->fetchObject();
        $obRetTurma = $retConsultaTurma->fetchObject();

        $retorno = $obRetDisc->titulo." (".$obRetTurma->nometurma." - ".$obRetCurso->nome.")";

        return $retorno;
    }
    function setCurso($frm){


        $consultaCurso = new TDbo(TConstantes::DBCURSOS);
        $criterioCurso = new TCriteria();
        $criterioCurso->add(new TFilter("codigo","=",$frm));
        $retConsultaCurso = $consultaCurso->select("nome",$criterioCurso);


        $obRetCurso = $retConsultaCurso->fetchObject();


        $retorno = $obRetCurso->nome;

        return $retorno;
    }
    function setTurma($frm){

        $consultaTurma = new TDbo(TConstantes::DBTURMAS);
        $criterioTurma = new TCriteria();
        $criterioTurma->add(new TFilter("codigo","=",$frm));
        $retConsultaTurma = $consultaTurma->select("nometurma",$criterioTurma);

        $obRetTurma = $retConsultaTurma->fetchObject();

        $retorno = $obRetTurma->nometurma;

        return $retorno;
    }
    function setDisciplina($frm){

        $consultaDisc = new TDbo(TConstantes::DBDISCIPLINAS);
        $criterioDisc = new TCriteria();
        $criterioDisc->add(new TFilter("codigo","=",$frm));
        $retConsultaDisc = $consultaDisc->select("titulo",$criterioDisc);


        $obRetDisc = $retConsultaDisc->fetchObject();


        $retorno = $obRetDisc->titulo;

        return $retorno;
    }
 }