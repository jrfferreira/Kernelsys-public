<?php
/**
 * Contem todos os metodos para manipulação de estatus dos registros
 * desde representação das labels até alteração de estatus de registros especificos
 * Autor:
 * Data: 2009-11-08
 */


class TStatus{

    /**
     * Altera o valor do estatus no registro correspondente ao seqpassado
     * 
     * param <seq> $seq= seqdo registro do qual sera alterado o estatus.
     * param <string> $entidade = nome da entidade [tabela] onde est� contido o registro.
     * param <string> $estatus1 = valor do estatus atual do registro.
     * param <string> $estatus2 = novo valor do estatus.
     */
    public function setStatus($seq, $entidade, $estatus1, $estatus2){

         //autera estatus de edição para statseq
        if($seq && $entidade){

            $obTDboStatus = new TDbo();
            $obTDboStatus->setEntidade($entidade);

                $criteriaStatus = new TCriteria();
                $criteriaStatus->add(new TFilter(TConstantes::SEQUENCIAL,'=',$seq));
                $criteriaStatus->add(new TFilter('statseq','=',$estatus1));

            $retStatus = $obTDboStatus->select("statseq", $criteriaStatus);
            $obStatus = $retStatus->fetchObject();
            if($obStatus->statseq == $estatus1){
                $retUpStatus = $obTDboStatus->update(array("statseq"=>$estatus2), $criteriaStatus);
                if(!$retUpStatus){
                    $obTDboStatus->rollback();
                    $obTDboStatus->close();
                    new setException("Erro ao atualizar o estatus do resgistro [".$seq."] da tabela [".$entidade."] - TStatus - Line - 28.");
                }
            }
            $obTDboStatus->close();
        }else{
            new setException("código inválido");
        }
    } 

    /*
    * Retorna string para valor boolean
    */
    public function getBoolean($frm){
        switch($frm){
            case 0:
                $retorno = "não";
                break;
            case 1:
                $retorno = "Sim";
                break;

        }
        return $retorno;
    }

}