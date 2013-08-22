<?php
/* 
 * Classe destinada a aplicação de valores sobre o seq
 */

 class setProfessor{
     function setLabel($frm){
        $consultaseq= new TDbo(TConstantes::VIEW_PROFESSOR);
        $criterioseq= new TCriteria();
        $criterioseq->add(new TFilter("seq","=",$frm));
        $retConsultaseq= $consultaseq->select("seqpessoa",$criterioseq);
        $obRetseq= $retConsultaseq->fetchObject();

        $consulta = new TDbo(TConstantes::DBPESSOA);
        $criterio = new TCriteria();
        $criterio->add(new TFilter("seq","=",$obRetseq->seqpessoa));
        $retConsulta = $consulta->select("pessnmrz",$criterio);

        $obRet = $retConsulta->fetchObject();
        $retorno = $obRet->pessnmrz;

        return $retorno;
    }
 }