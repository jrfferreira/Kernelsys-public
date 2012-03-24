<?php
/* 
 * Classe: TSolicitacao
 * Autor: João Felix. Data: 2010-04-09
 */

class TSolicitacao {

    /*
     * Retorna String para a situação da Solicitação
     */
    function getStatus($frm){
        switch($frm){
            case 1:
                $retorno = "Aprovada";
                break;
            case 2:
                $retorno = "Sob análise";
                break;
            case 3:
                $retorno = "Negada";
                break;
        }
        return $retorno;
    }
}