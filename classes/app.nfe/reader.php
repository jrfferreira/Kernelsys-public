<?php
function __autoload($classe){
    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}

date_default_timezone_set('America/Sao_Paulo');
set_time_limit(0); // duas horas
//ignore_user_abort(true); // continua rodando após a finalização
include_once('../app.lib/nusoap/nusoap.php');

//==================================================================
            //aloca usuario padrao sem privilegios
            $setId = new TSetControl();
            $idSessao = $setId->setPass($setId->getSessionPass('portaCopo'));

                $obSession = new TSession();
                $obUnidade = new stdClass();
                $obUnidade->codigo = 'x';

                $obUser =  new stdClass();
                $obUser->codigouser  = "010101-11";
                $obUser->codigo  = "010101-11";
                $obUser->codigopessoa  = "010101-11";
                $obUser->nomepessoa = "usuario externo";
                $obUser->cpf = "000.000.000-11";
                $obUser->unidade = $obUnidade;
                $obUser->datalog = date("d/m/Y");
                $obUser->horalog = date("H:i:s");
                $obUser->codigoTema = "";

                $obSession->setValue($idSessao, $obUser);
                $obSession->setValue('pathDB', '../'.TOccupant::getPath().'app.config/my_dbpetrus');
//==================================================================

function wsdl($service,$file){
    $uf = 'GO';
    $versao = '2.00';

    $TNFeWsdl = new TNFeWsdl($service, $versao, $uf);
    $TNFeWsdl->loadXML('temp/'.$file);
    $ret = $TNFeWsdl->send('temp/retornos/ret'.$file);
    if($ret){
        if(unlink('temp/'.$file)){
            echo "\r\n\r\nEnvio efetivado\r\n\r\n";
        }
    }else{
            echo "\r\n\r\nFalha de envio, tente novamente.\r\n\r\n";
    }
}

$standby = false;

echo "\r\n";
echo "\t-----------------------------------------\r\n";
echo "\t|\tSwift - Controlador de NF-e\t|\r\n";
echo "\t|\tBitUP Sistemas Inteligentes\t|\r\n";
echo "\t-----------------------------------------\r\n";
echo "\r\n";

inicio:

$files = scandir('temp');

unset($files[array_search('.',$files)]);
unset($files[array_search('..',$files)]);
unset($files[array_search('retornos',$files)]);
unset($files[array_search('reader.php',$files)]);

$file = end($files);

//Envio de NF-e
if(preg_match("/(-nfe.xml)$/i",$file)){
    echo "[{$file}]:: Envio de NF-e";

    wsdl('enviNFe',$file);
    $standby = false;
}
//Envio de Lote de NF-e:
else if(preg_match("/(-env-lot.xml)$/i",$file)){
    echo "[{$file}]:: Envio de Lote de NF-e";

    wsdl('enviNFe',$file);
    $standby = false;
}
//Recibo:
else if(preg_match("/(rec.xml)$/i",$file)){
    echo "[{$file}]:: Recibo";
    $standby = false;
}
//Pedido do Resultado do Processamento do Lote de NF-e:
else if(preg_match("/(-ped-rec.xml)$/i",$file)){
    echo "[{$file}]:: Pedido do Resultado do Processamento do Lote de NF-e";
    $standby = false;
}
//Resultado do Processamento do Lote de NF-e:
else if(preg_match("/(-pro-rec.xml)$/i",$file)){
    echo "[{$file}]:: Resultado do Processamento do Lote de NF-e";
    $standby = false;
}
//Denegação de Uso:
else if(preg_match("/(-den.xml)$/i",$file)){
    echo "[{$file}]:: Denegação de Uso";
    $standby = false;
}
//Pedido de Cancelamento de NF-e:
else if(preg_match("/(-ped-can.xml)$/i",$file)){
    echo "[{$file}]:: Pedido de Cancelamento de NF-e";
    $standby = false;
}
//Cancelamento de NF-e:
else if(preg_match("/(-can.xml)$/i",$file)){
    echo "[{$file}]:: Cancelamento de NF-e";
    $standby = false;
}
//Pedido de Inutilização de Numeração:
else if(preg_match("/(-ped-inu.xml)$/i",$file)){
    echo "[{$file}]:: Pedido de Inutilização de Numeração";
    $standby = false;
}
//Inutilização de Numeração:
else if(preg_match("/(-inu.xml)$/i",$file)){
    echo "[{$file}]:: Inutilização de Numeração";
    $standby = false;
}
//Pedido de Consulta Situação Atual da NF-e:
else if(preg_match("/(-ped-sit.xml)$/i",$file)){
    echo "[{$file}]:: Pedido de Consulta Situação Atual da NF-e";
    $standby = false;
}
//Situação Atual da NF-e:
else if(preg_match("/(-sit.xml)$/i",$file)){
    echo "[{$file}]:: Situação Atual da NF-e";
    $standby = false;
}
//Pedido de Consulta do Status do Serviço:
else if(preg_match("/(-ped-sta.xml)$/i",$file)){
    echo "[{$file}]:: Pedido de Consulta do Status do Serviço";

    wsdl('NfeStatusServico',$file);
    $standby = false;
}
//Status do Serviço:
else if(preg_match("/(-sta.xml)$/i",$file)){
    echo "[{$file}]:: Status do Serviço";
    $standby = false;
}else{
    if(!$standby) echo "[".date('d/m/Y H:i:s')."]:: Aguardando arquivos\r\n\r\n";
    $standby = true;
}

if(!$standby) echo "\r\n\r\n";

goto inicio;


?>