<?php
class setAluno{

     function setLabel($frm){

        $consultaCodigo = new TDbo(TConstantes::DBPESSOAS_ALUNOS);
        $criterioCodigo = new TCriteria();
        $criterioCodigo->add(new TFilter("codigo","=",$frm));
        $retConsultaCodigo = $consultaCodigo->select("codigopessoa",$criterioCodigo);
        $obRetCodigo = $retConsultaCodigo->fetchObject();

        $consulta = new TDbo(TConstantes::DBPESSOAS);
        $criterio = new TCriteria();
        $criterio->add(new TFilter("codigo","=",$obRetCodigo->codigopessoa));
        $retConsulta = $consulta->select("nome_razaosocial",$criterio);

        $obRet = $retConsulta->fetchObject();
        $retorno = $obRet->nome_razaosocial;

        return $retorno;
    }
 }