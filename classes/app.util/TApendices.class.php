<?php
/* 
 * Executa os metodos apendices definidos nas listas e nos abas do sistema
 * e returna um objeto Element para o modulo view
 * Autor: Wagner Borba
 * Data: 01/02/2010
 */

class TApendices{

    public function main($apendice, $chaveHeader = NULL){
         try{
              $vet = explode("/",$apendice);
              $classe = $vet[0];
              $metodo = $vet[1];

              if($chaveHeader){

                $getHeaderForm = new TSetHeader();
                $obHeaderForm = $getHeaderForm->getHead($chaveHeader);
                $argumento = $obHeaderForm[TConstantes::SEQUENCIAL];

                if(!$argumento){
                   $argumento = $chaveHeader;
                }
                
                    $ob = new $classe;
                    $element = call_user_func(array($ob, $metodo), $argumento, $chaveHeader);
                    
              }else{
                    $ob = new $classe;
                    $element = call_user_func(array($ob, $metodo));
              }


            if(get_class($element) == "TElement"){
                return $element;
            }else{
                throw new ErrorException("O retorno do apendice passado não é um objeto [Element] válido.");
            }
            
        }catch (Exception $e){
            new setException($e);
        }
   }
}
