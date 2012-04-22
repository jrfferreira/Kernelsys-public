<?php
/* TSec - Tipe Single Execution Class
 * Recebe os argumentos do AJAX via get ou post instancia
 * e executa a classe e o metodo em questão e retona em forma de sainda na tela para
 * a funcao autora da acao
 */

function __autoload($classe){
    include_once('autoload.class.php');
    $autoload = new autoload('../',$classe);
}

//Atribui controlador de erros personalizado
if(!function_exists('errorHandler')){
	include_once('../app.util/errorHandler.php');
}
set_error_handler("errorHandler" , E_ALL^E_NOTICE);

/**
 * Recepta as ações enviadas por get ou post
 * instancia o objeto execs e executa o
 * metodo em questão
*/

$param = array();
if(count($_GET) >= 2){
    $param = $_GET;
    //array_pop($param);

}
else if($_POST){
     $param = $_POST;
}


if($param['classe'] and $param['metodo']){
	

    $method  = $param['metodo'];
    $classe  = $param['classe'];

   //retira os dois primeiros paramentos da vetor de paramentros
   $parametros = $param;
   array_shift($parametros);
   array_shift($parametros);

   $ObExec = new $classe();
   if(method_exists($ObExec, $method)){

      //$retorno = $ObExec->$method($parametros);
      $retorno = call_user_func_array(array($ObExec, $method), $parametros);

      if($retorno){
          if(is_object($retorno)){
              return $retorno->show();
          }else{
            echo $retorno;
          }
      }
   }
   else{
     // lança exeção de erro na execução da sql
     new setException("O método ".$method." não existe na classe ".$param['classe']."(). -  TSec.php - Line 21");
   }

}else{
     // lança exeção de erro na execução da sql
     new setException("Os argumentos basicos [classe - metodo] não foram encontrados. TSec.php - Line 9");
}
