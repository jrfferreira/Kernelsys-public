<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class TSetAction{

    private $obAction;
    private $param = array();

    /**
     *
     * param <type> $function = função a ser executada pela [Action]
     */
    public function  __construct($function) {
        try{
            if($function){
             $this->obAction = new TAction($function);
            }else{
                throw new ErrorException("O nome da função é inválido.");
            }
        }catch (Exception $e){
            new setException($e);
        }
    }

    public function getAction(){
        
         $this->obAction->setParameter('metodo',$this->param['metodo']);
         $this->obAction->setParameter('tipoRetorno',$this->param['tipoRetorno']);
         $this->obAction->setParameter('idForm',$this->param['idForm']);
         $this->obAction->setParameter('key',$this->param['key']);
         $this->obAction->setParameter('alvo',$this->param['alvo']);
         $this->obAction->setParameter('confirme',$this->param['confirme']);

         return $this->obAction;
    }

    //Intercepta atributos não declarados e os instancia
    public function __set($key, $value){
            $this->obAction->$key = $value;
    }

    /**
    *
    * param <type> $metodo
    */
    public function setMetodo($metodo){
         try{
            if($metodo){
                $this->param['metodo'] = $metodo;
            }else{
                throw new ErrorException("O nome do método é inválido.");
            }
        }catch (Exception $e){
            new setException($e);
        }
    }

    /**
    *
    * param <type> $autor
    */
    public function setTipoRetorno($tipoRetorno){
         try{
            if($tipoRetorno){
                $this->param['tipoRetorno'] = $tipoRetorno;
            }else{
                throw new ErrorException("O nome do tipo retorno é inválido.");
            }
        }catch (Exception $e){
            new setException($e);
        }
    }

    /**
     *
     * param <type> $idForm
     */
    public function setIdForm($idForm){
         try{
            if($idForm){
                $this->param['idForm'] = $idForm;
            }else{
                throw new ErrorException("O nome do idForm é inválido.");
            }
        }catch (Exception $e){
            new setException($e);
        }
    }

    /**
     *
     * param <type> $key
     */
    public function setKey($key){
         try{
            if($key){
                $this->param['key'] = $key;
            }else{
                throw new ErrorException("A valor para key é inválido.");
            }
        }catch (Exception $e){
            new setException($e);
        }
    }

    /**
     *
     * param <type> $alvo
     */
    public function setAlvo($alvo){
         try{
            if($alvo){
                $this->param['alvo'] = $alvo;
            }else{
                throw new ErrorException("A valor para alvo é inválido.");
            }
        }catch (Exception $e){
            new setException($e);
        }
    }

    public function setConfirme($msg){
         try{
            if($msg){
                $this->param['confirme'] = $msg;
            }
        }catch (Exception $e){
            new setException($e);
        }
    }

}
?>
