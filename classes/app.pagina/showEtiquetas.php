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

$seqLista = $_GET['cod'];

if($seqLista) {

    $THeader = new TSetHeader();
    $listseq = $THeader->getHead($seqLista,TConstantes::LISTA);
    $obsession = new TSession();
    
    print_r($obsession);
    
    $cabecalho = $obsession->getValue("boxFiltro_$listseq");

    if($cabecalho) {

        if(is_array($cabecalho["cols{$listseq}"])) {
            $criterio = new TCriteria();
            foreach($cabecalho["cols{$listseq}"] as $ch=>$vl) {
                if($vl != "*") {
                    $criterio->setProperty("{$vl} ilike","%{$cabecalho["expre{$listseq}"][$ch]}%");
                }
            }
        }else {
            $criterio = new TCriteria();
            $criterio->setProperty("{$cabecalho["cols{$listseq}"]} ilike","%{$cabecalho["expre{$listseq}"]}%");
        }
    }

        /*
         * Criar um loop racionalizando as impressões
        */

       
            $dbo = new TDbo('view_patrimonios_livros');

            if(!$criterio) {
                $ret = $dbo->select('cdu,seqpha,edicao,exemplar,volume,seqlivro');
            }else {
                $ret = $dbo->select('cdu,seqpha,edicao,exemplar,volume,seqlivro',$criterio);
            }
            while($ob = $ret->fetchObject()) {
                $lista[] = array($ob->cdu,$ob->seqpha,$ob->edicao,'ex: '.$ob->exemplar,'v: '.$ob->volume,'BarCode/'.$ob->seqlivro);
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