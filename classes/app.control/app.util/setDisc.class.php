<?php
class setDisc{
    
    function setCH($frm){

        $consulta = new TDbo(TConstantes::DBDISCIPLINAS);
        $criterio = new TCriteria();
        $criterio->add(new TFilter("codigo","=",$frm));
        $retConsulta = $consulta->select("titulo,cargahoraria",$criterio);

        $obRet = $retConsulta->fetchObject();
        $retorno = $obRet->titulo." - ".$obRet->cargahoraria." h";
        
        return $retorno;
    }
}

//comentario

?>
