<?php
     /**
      * Classe para controle de E-mails
      * Data: 2009-10-05
      * author João Felix
     */
class TEmail {
    /*
     * Envia email
     * $destinatario = E-mail a receber a mensagem.
     * $titulo = Assunto da mensagem
     * $mensagem = Mensagem a ser enviada (Aceita HTML)
     * $remetente = codigo do Usuario remetente, valor nulo corrensponde ao email da Unidade.
     */
    function enviar($destinatario,$titulo,$mensagem,$save= true,$remetente = NULL) {

        //INICIO - Retorna informações de envio, Nome da Unidade e Informações Principais

        $sql = new TDbo(TConstantes::DBUNIDADES_PARAMETROS);
        $crit = new TCriteria();
        $crit->add(new TFilter("parametro","=",'enviarEmail'));
        $ret = $sql->select("valor enviaEmail",$crit);
        $ob = $ret->fetchObject();

       if($ob->enviaEmail == '1'){
        $obUser = new TCheckLogin();
        $obUser = $obUser->getUser();
        $unidade = $obUser->unidade->codigo;
        $codigoUser = $obUser->codigo;

        $sqlParametro = new TDbo(TConstantes::DBUNIDADES);
        $crit = new TCriteria();
        $crit->add(new TFilter("codigo","=",$unidade));
        $retParametro = $sqlParametro->select("*",$crit);
        $obParametro = $retParametro->fetchObject();

        $remetente_padrao = $obParametro->email;
        //FIM

        //INICIO - Gera rodap� da mensagem
        $fotter = $obParametro->razaoSocial." (".$obParametro->nomeunidade.")<BR />Telefone de Contato:".$obParametro->telefone;
        //FIM

        //INICIO - Valida o Titulo da Mensagem
        if(!$titulo) {
            $titulo = "E-mail Petrus EDU.";
        }
        //FIM

        //INICIO - Gera TAG inicial da mensagem
        $headers  = 'MIME-Version: 1.0'."\r\n";
        $headers .= 'Content-type: text/html; charset=UTF-8'."\r\n";
        $headers .= 'To:'.$destinatario."\r\n";
        //FIM

        //INICIO - Validada Remetente
        if($remetente) {
            $sqlRemetente = new TDbo(TConstantes::DBPESSOAS);
            $critRemetente = new TCriteria();
            $critRemetente->add(new TFilter("codigo","=",$remetente));
            $retRemetente = $sqlRemetente->select("*",$crit);
            
            $obRemetente = $retRemetente->fetchObject();
            
            $headers .= "From: ".$obRemetente->nome_razaosocial."<".$obRemetente->email1."> \r\n";
            //$headers .= "Reply-To: ".$obParametro->nome." <".$remetente_padrao."> \r\n";
        }else {
            $headers .= "From: ".$obParametro->razaoSocial."<".$remetente_padrao."> \r\n";
        }
        //FIM

        //INICIO - Concatena mensagem e rodap�

        $ordem   = array("\r\n", "\n", "\r");
        $altera = '<BR />';
        $mensagem_html = str_replace($ordem, $altera, $mensagem);
        $corpo = "<HTML><BODY><P>".$mensagem_html."</P><BR /><P>".$fotter."</P></BODY></HTML>";
        //FIM

        //INICIO - Envia e-mail            
            $dadosEmail['codigoRemetente'] = $codigoUser;
            $dadosEmail['destinatario'] = $destinatario;
            $dadosEmail['mensagem'] = str_replace('<BR />', "\r\n", $headers."\r\n".$mensagem."\r\n\r\n".$fotter);
            $dadosEmail['horaCad'] = date("H:i:s");

            if($save){
            $sqlInsert = new TDbo(TConstantes::DBEMAILS);
            $insert = $sqlInsert->insert($dadosEmail);
            }
        if(mail($destinatario,$titulo,$corpo,$headers)) {
            $dadosEmail['codigoRemetente'] = $codigoUser;
            $dadosEmail['destinatario'] = $destinatario;
            $dadosEmail['mensagem'] = str_replace('<BR />', "\r\n", $headers."\r\n".$mensagem."\r\n\r\n".$fotter);
            $dadosEmail['horaCad'] = date("H:i:s");

            if($save){
            $sqlInsert = new TDbo(TConstantes::DBEMAILS);
            $insert = $sqlInsert->insert($dadosEmail);
            }
            return true;
            
        }else{
            new setException(TMensagem::ERRO_MAIL_ACESSO);
        }
        //FIM

       }else{return false;}
      
    }
}