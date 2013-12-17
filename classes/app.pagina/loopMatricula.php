<?php
//==========================================================
// Executar a matricula de todas as inscrições da unidade
//
//==========================================================
session_start();

function __autoload($classe) {

    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}
//Retorna Usuario logado===================================

     $obUser = new TCheckLogin();
     $obUser = $obUser->getUser();
//=========================================================



 $obTDbo = new TDbo(TConstantes::DBINSCRICAO);
 $criteria = new TCriteria();
    $criteria->add(new TFilter('unidade','=','10103366-866'));
    $criteria->setProperty('limit',1);
 $retQuery = $obTDbo->select('codigo',$criteria);

if($obCodigoInscricao = $retQuery->fetchObject()){
     $codigoInscricao = $obCodigoInscricao->codigo;

     $TMatricula = new TMatricula();

     if($TMatricula->setMatricula($codigoInscricao,null)){
        echo "<script>console.log('sucesso','".$codigoInscricao."'); window.location.reload();</script>";
     } else {
        echo "<script>console.log('erro','".$codigoInscricao."');</script>";
     }


}