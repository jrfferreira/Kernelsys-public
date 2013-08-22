<?php
class setDisc{
    
    function setCH($frm){

        $consulta = new TDbo(TConstantes::DBDISCIPLINA);
        $criterio = new TCriteria();
        $criterio->add(new TFilter("seq","=",$frm));
        $retConsulta = $consulta->select("titulo,cargahoraria",$criterio);

        $obRet = $retConsulta->fetchObject();
        $retorno = $obRet->titulo." - ".$obRet->cargahoraria." h";
        
        return $retorno;
    }
}
