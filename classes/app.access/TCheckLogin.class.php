<?php
/**
 * Checa e valida o usuario logado
 *
 */

class TCheckLogin {

    private $user = NULL;

    public function __construct() {

        try {

            $setId = new TSetControl();
            $this->seq = $setId->getSessionPass('portaCopo');
                        
            $this->obsession = new TSession();            
            $dadosUser = $this->obsession->getValue($this->seq);
            
            if($dadosUser){
            	$dadosUser->unidade = $dadosUser->unidseq;
                $this->user = $dadosUser;
                if(!$this->user->seq or !$this->user->pessseq) {
                    // se não existir, lança um erro
                    throw new ErrorException("Ouve uma falha ao tentar carregar o perfil do usuario.");
                }
            }else {
            	           	
                $_SESSION = array();
                session_destroy();
       
                $occupant = $occupant ? '?occupant=' . $occupant : null;
                throw new ErrorException("Ouve uma falha ao carregar o perfil do usuario logado.");
                
                //throw new ErrorException('<script language="JavaScript">location.href="../app.view/'.$occupant.'";</script>');
                
            }
            
        }catch(Exception $e) {
            // se não existir, lança um erro
            echo $e;
            exit();
            //new setException("Ouve um problema ao tentar carregar o perfil do usuario. ".$e);
        }

    }

    public function getUser() {
        return $this->user;
    }
}