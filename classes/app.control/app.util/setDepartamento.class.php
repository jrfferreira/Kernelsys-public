<?php
class setDepartamento{
    function setLabel($frm){

        //$tabela = $this->tabela;
        //$coluna = $this->colunaLabel;

        $consulta = new TDbo(TConstantes::DBDEPARTAMENTOS);
        $criterio = new TCriteria();
        $criterio->add(new TFilter("codigo","=",$frm));
        $retConsulta = $consulta->select("label",$criterio);

        $obRet = $retConsulta->fetchObject();
        $retorno = $obRet->label;

        return $retorno;
    }
    function setLotacao($frm){

        //$tabela = $this->tabela;
        //$coluna = $this->colunaLabel;

        $consulta = new TDbo(TConstantes::DBSALAS);
        $criterio = new TCriteria();
        $criterio->add(new TFilter("codigo","=",$frm));
        $retConsulta = $consulta->select("nome",$criterio);

        $obRet = $retConsulta->fetchObject();
        $retorno = $obRet->nome;

        return $retorno;
    }
}