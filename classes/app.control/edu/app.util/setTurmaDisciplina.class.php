<?php
class setTurmaDisciplina{

     function setLabel($frm){

        $consultaseq= new TDbo(TConstantes::DBTURMA_DISCIPLINA);
        $criterioseq= new TCriteria();
        $criterioseq->add(new TFilter("seq","=",$frm));
        $retConsultaseq= $consultaseq->select("*",$criterioseq);
        $obRetseq= $retConsultaseq->fetchObject();

        $consultaCurso = new TDbo(TConstantes::DBCURSO);
        $criterioCurso = new TCriteria();
        $criterioCurso->add(new TFilter("seq","=",$obRetseq->seqcurso));
        $retConsultaCurso = $consultaCurso->select("nome",$criterioCurso);

        $consultaDisc = new TDbo(TConstantes::DBDISCIPLINA);
        $criterioDisc = new TCriteria();
        $criterioDisc->add(new TFilter("seq","=",$obRetseq->seqdisciplina));
        $retConsultaDisc = $consultaDisc->select("titulo",$criterioDisc);

        $consultaTurma = new TDbo(TConstantes::DBTURMA);
        $criterioTurma = new TCriteria();
        $criterioTurma->add(new TFilter("seq","=",$obRetseq->seqturma));
        $retConsultaTurma = $consultaTurma->select("nometurma",$criterioTurma);

        $obRetCurso = $retConsultaCurso->fetchObject();
        $obRetDisc = $retConsultaDisc->fetchObject();
        $obRetTurma = $retConsultaTurma->fetchObject();

        $retorno = $obRetDisc->titulo." (".$obRetTurma->nometurma." - ".$obRetCurso->nome.")";

        return $retorno;
    }
    function setCurso($frm){


        $consultaCurso = new TDbo(TConstantes::DBCURSO);
        $criterioCurso = new TCriteria();
        $criterioCurso->add(new TFilter("seq","=",$frm));
        $retConsultaCurso = $consultaCurso->select("nome",$criterioCurso);


        $obRetCurso = $retConsultaCurso->fetchObject();


        $retorno = $obRetCurso->nome;

        return $retorno;
    }
    function setTurma($frm){

        $consultaTurma = new TDbo(TConstantes::DBTURMA);
        $criterioTurma = new TCriteria();
        $criterioTurma->add(new TFilter("seq","=",$frm));
        $retConsultaTurma = $consultaTurma->select("nometurma",$criterioTurma);

        $obRetTurma = $retConsultaTurma->fetchObject();

        $retorno = $obRetTurma->nometurma;

        return $retorno;
    }
    function setDisciplina($frm){

        $consultaDisc = new TDbo(TConstantes::DBDISCIPLINA);
        $criterioDisc = new TCriteria();
        $criterioDisc->add(new TFilter("seq","=",$frm));
        $retConsultaDisc = $consultaDisc->select("titulo",$criterioDisc);


        $obRetDisc = $retConsultaDisc->fetchObject();


        $retorno = $obRetDisc->titulo;

        return $retorno;
    }
 }