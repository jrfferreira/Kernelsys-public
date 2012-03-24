<?php

function __autoload($classe){

    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}
include_once('../app.lib/nusoap/nusoap.php');
date_default_timezone_set('America/Sao_Paulo');

$TNFeModel = new TNFeModel();

// carga das variaveis da funçao do webservice
/*
        // array para comunicaçao soap
        $param = array('nfeCabecMsg'=>'<?xml version="1.0" encoding="utf-8"?><cabecMsg versao="1.02" xmlns="http://www.portalfiscal.inf.br/nfe"><versaoDados>2.00</versaoDados></cabecMsg>',
            'nfeDadosMsg'=>'<consStatServ xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" versao="2.00" xmlns="http://www.portalfiscal.inf.br/nfe"><tpAmb>2</tpAmb><cUF>52</cUF><xServ>STATUS</xServ></consStatServ>');
        //envia o xml para o SOAP
        $retorno = $TNFeModel->sendSoap($param,'https://nfe.sefaz.go.gov.br/nfe/services/NfeStatusServico', 'NfeStatusServico');

        echo $TNFeModel->soapDebug;
  */

$doc = new DOMDocument( );
$cancNFe = $doc->createElement( 'div', '1' );
$doc->appendChild($cancNFe);
echo $doc->saveHTML();

?>