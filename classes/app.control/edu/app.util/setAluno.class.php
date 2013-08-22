<?php
class setAluno{

     function setLabel($frm){

        $consultaseq= new TDbo(TConstantes::DBALUNO);
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