<?php
//--------------------------------------------------
// Aloca dados de controle necessarios em sessão.
//--------------------------------------------------

class TAlocaDados {

    public function __construct() {

        //Retorna Usuario logado===================================
        $obUser = new TCheckLogin();
        $obUser = $obUser->getUser();
        //=========================================================

        $this->obsession = new TSession();
    }

    public function setValue($chave,$valor) {
        try {
            if($valor and $chave) {
                $this->obsession->setValue($chave, $valor);

            }
        }catch (Exception $e) {
            new setException($e);
        }
    }

    /**
     *  Retorna os dados contidos em sessão que corresponda a chave.
     * param string $chave = chave da sessão
     */
    public function getValue($chave) {
        $dado = $this->obsession->getValue($chave);
        return $dado;
    }
}