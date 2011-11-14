<?php
//==========================================================
// Gera boleto de inscrição
//
//==========================================================
session_start();
set_time_limit(0); // duas horas
ignore_user_abort(true); // continua rodando após a finalização


function __autoload($classe) {

    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}

include_once('../app.lib/fpdf/code128.php');
//Retorna Usuario logado===================================

$obUser = new TCheckLogin();
$obUser = $obUser->getUser();
//=========================================================

$codigoLista = $_GET['cod'];

if($codigoLista) {

    $THeader = new TSetHeader();
    $idLista = $THeader->getHead($codigoLista,'idLista');
    $obsession = new TSession();
    
    print_r($obsession);
    
    $cabecalho = $obsession->getValue("boxFiltro_$idLista");

    if($cabecalho) {

        if(is_array($cabecalho["cols{$idLista}"])) {
            $criterio = new TCriteria();
            foreach($cabecalho["cols{$idLista}"] as $ch=>$vl) {
                if($vl != "*") {
                    $criterio->setProperty("{$vl} ilike","%{$cabecalho["expre{$idLista}"][$ch]}%");
                }
            }
        }else {
            $criterio = new TCriteria();
            $criterio->setProperty("{$cabecalho["cols{$idLista}"]} ilike","%{$cabecalho["expre{$idLista}"]}%");
        }
    }

        /*
         * Criar um loop racionalizando as impressões
        */

       
            $dbo = new TDbo('view_patrimonios_livros');

            if(!$criterio) {
                $ret = $dbo->select('cdu,codigopha,edicao,exemplar,volume,codigolivro');
            }else {
                $ret = $dbo->select('cdu,codigopha,edicao,exemplar,volume,codigolivro',$criterio);
            }
            while($ob = $ret->fetchObject()) {
                $lista[] = array($ob->cdu,$ob->codigopha,$ob->edicao,'ex: '.$ob->exemplar,'v: '.$ob->volume,'BarCode/'.$ob->codigolivro);
            }


        $espHorizontal = '10,68';
        $espVertical = '2,54';
        $largura = '10,16';
        $altura = '2,54';
        $margemEsq = '0,40';
        $margemSup = '1,27';
        $colunas = '2';
        $linhas = '10';

        $TEtiquetas = new TEtiquetas();
        $TEtiquetas->setDiagramacao($espHorizontal, $espVertical, $largura, $altura, $margemEsq, $margemSup, $colunas, $linhas);
        $TEtiquetas->addDados($lista);
        $TEtiquetas->geraPDF();
    
}
?>