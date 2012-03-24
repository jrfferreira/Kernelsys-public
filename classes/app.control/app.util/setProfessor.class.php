<?php
/* 
 * Classe destinada a aplicação de valores sobre o codigo
 */

 class setProfessor{
     function setLabel($frm){
        $consultaCodigo = new TDbo(TConstantes::VIEW_FUNCIONARIOS_PROFESSORES);
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