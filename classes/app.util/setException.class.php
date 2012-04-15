<?php
/**
 * Declaração da classe para tratamento de erros
 * A classe deve ser extendida da classe Exception do PHP
 */

 class setException extends Exception{

     private $msg      = "";

     /**
      * Metodo construtor para tratamento de erro
      * param <type> $Exeption = mensagem ou objeto Exeption
      * param <type> $severidade = se o erro vai parar a execução ou não
      */
      public function __construct($Exeption, $severidade = 1){

            //Retorna Usuario logado===================================
            //$this->obUser = new TCheckLogin();
            //$this->obUser = $this->obUser->getUser();
            //=========================================================

          //Sobreescrevo as propiedades da classe passando os parametros
          //$this->cod     = $cod;

         //trata a exeção
         if(get_class($Exeption) == "ErrorException"){
             if($Exeption->getMessage()){
                $mensagem   = $Exeption->getMessage();
             }else{
                 $mensagem = $Exeption;
             }
             if($Exeption->getCode()){
                $severidade = $Exeption->getCode();
             }
         }else{
             $mensagem = $Exeption;
         }                    

          //grava o log do erro em um arquivo txt
          $retLog =  $this->setLog();

          //retorna a mensagem de erro
          $corpoMsg = new TElement('span');
          $corpoMsg->style = "font-size:11px; margin:5px;";
          $corpoMsg->add("<hr><br>{$mensagem}</hr><br/><br/>");
          //if($retLog) $corpoMsg->add("<br>O sistema <b>PetrusCOM</b> enviou uma mensagem de erro para a equipe técnica da <b>BitUP</b>.<br/>");

         // $corpoMsg->add($Exeption->getFile().' - '.$Exeption->getLine().$Exeption);

          $showMsg = new TMessage('Alerta',$corpoMsg);

          if($severidade == 1){
            exit();
          }
      }

      /**
       * Método grava num log o erro gerado
       */
      private function setLog() {
          
         //Define o arquivo que será criado ou gravado caso exista
         //Coloco como nome o nome da classe seguido de log e da data de criação do mesmo

            TTransaction::close();

            $dadosErro['codigoUser'] = $this->obUser->codigo;
            $dadosErro['classe'] = $this->file;
            $dadosErro['msg'] = "".$this->msg." - Line: [".$this->getLine()."] ".$this->getMessage();
            $dadosErro['horaCad'] = date("H:i:s");

            $mensagem = '<p><h3>Erro no sistema</h3><br/>';
            $mensagem .= '<br/><b>Usuário</b>: ' . $this->obUser->codigo;
            $mensagem .= '<br/><br/><br/><b>Classe</b>: ' . $this->file;
            $mensagem .= '<br/><b>Mensagem</b>: ' . $this->msg." - Line: [".$this->getLine()."] ".$this->getMessage();;
            $mensagem .= '<br/><br/><br/><b>Data/Hora</b>: ' . date("d/m/Y H:i:s");;
            $mensagem .= '<br/><b>IP</b>: ' . $_SERVER['REMOTE_ADDR'];
            
            
            

            //$TEmail = new TEmail();
            //$TEmail->enviar('bitup.si@gmail.com', 'Erro no sistema', $mensagem, false);


            return true;
           // $dboLog = new TDbo(TConstantes::DBUSUARIOS_ERROS);
            //$dboLog->insert($dadosErro);
      }

 }