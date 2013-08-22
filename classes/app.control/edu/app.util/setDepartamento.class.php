<?php
class setDepartamento{
    function setLabel($frm){

        //$tabela = $this->tabela;
        //$coluna = $this->colunaLabel;

        $consulta = new TDbo(TConstantes::DBDEPARTAMENTOS);
        $criterio = new TCriteria();
        $criterio->add(new TFilter("seq","=",$frm));
        $retConsulta = $consulta->select("label",$criterio);

        $obRet = $retConsulta->fetchObject();
        $retorno = $obRet->label;

        return $retorno;
    }
    function setLotacao($frm){

        //$tabela = $this->tabela;
        //$coluna = $this->colunaLabel;

        $consulta = new TDbo(TConstantes::DBSALA);
        $criterio = new TCriteria();
        $criterio->add(new TFilter("seq","=",$frm));
        $retConsulta = $consulta->select("nome",$criterio);

        $obRet = $retConsulta->fetchObject();
        $retorno = $obRet->nome;

        return $retorno;
    }
}