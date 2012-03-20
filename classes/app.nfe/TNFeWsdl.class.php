<?php

final class TNFeWsdl {

    //Variavel dos parametros XML (Cabeçalho, corpo)
    private $parametros = array();
    //Variavel do serviço utilizado
    public $service = null;
    //Variavel para o ambiente (1 = Produção; 2 = Homologação)
    public $ambiente = 2;

    public function __construct($service, $versao, $uf) {
        $this->versaodados = $versao;
        $this->uf = $uf;

        $TDbo = new TDbo('dominio.dbwebservices','bitup');
        $crit = new TCriteria();
        $crit->add(new TFilter('uf', '=', strtoupper($uf)));
        $crit->add(new TFilter('versao', '=', $versao));
        $crit->add(new TFilter('servico', ' ilike ', $service));
        $retWsdl = $TDbo->select('url,servico,schemaxml', $crit);

        //Verifica a existencia do método
        if ($wsdl = $retWsdl->fetchObject()) {
            $this->service->url = $wsdl->url;
            $this->service->metodo = $wsdl->servico;
            $this->service->schemaxml = $wsdl->schemaxml;
        } else {
            exit();
        }

        $this->parametros['nfeCabecMsg'] = '<?xml version="1.0" encoding="utf-8"?><cabecMsg versao="1.02" xmlns="http://www.portalfiscal.inf.br/nfe"><versaoDados>' . $this->versaodados . '</versaoDados></cabecMsg>';
        $this->parametros['nfeDadosMsg'] = null;
    }
   

    public function load($xml) {
        $xmlfragment = new DOMDocument();
        if (is_file($xml)) {
                $xmlfragment->load($xml);
        }else{
                $xmlfragment->loadHTML($xml);            
        }
        $check = $xmlfragment->schemaValidate('schemas/'.$this->service->schemaxml);
        if($check){
            $xml = $xmlfragment->saveHTML();
            $this->service->xml = trim($xml);
        }
        return $check;
    }

    public function model(DOMDocument $xml, $schema){

            $TDboCampos = new TDbo('dominio.dbwebservices_campos','bitup');
            $critCampos = new TCriteria();
            //$critCampos->add(new TFilter('versao', '=', $versao));
            $critCampos->add(new TFilter('schemaxml', ' ilike ', $schema));
            $critCampos->add(new TFilter('metodovalidacao', '!=', ''));
            $retCampos = $TDboCampos->select('*', $critCampos);

            //adiciona campos do metodo
            while ($campo = $retCampos->fetchObject()) {
                $ch = strtolower($campo->campo);
                $id = $campo->identificador;
                $this->camposchaves[$ch] = $id;
                $this->service->campos[$id]['id'] = $campo->identificador;
                $this->service->campos[$id]['nome'] = $campo->campo;
                $this->service->campos[$id]['pai'] = $campo->campopai;
                $this->service->campos[$id]['elemento'] = $campo->elemento;
                $this->service->campos[$id]['tamanho'] = $campo->tamanho;
                $this->service->campos[$id]['decimais'] = $campo->decimais;
                $this->service->campos[$id]['ocorrencia'] = $campo->ocorrencia;
                $this->service->campos[$id]['metodovalidacao'] = $campo->metodovalidacao;
            }
            foreach($this->service->campos[$id] as $campo){
                if($campo['elemento'] == 'A') {
                    $nodes = $xml->getElementsByTagName($campo['pai']);
                }else{
                    $nodes = $xml->getElementsByTagName($campo['nome']);

                }
                for ($i = 0; $i < $nodes->length; ++$i) {
                    $node = $nodes->item($i);

                     $exec = split('/\//i', $string);
                     $classe = $exec[0];
                     $metodo = $exec[1];
                     $ObExec = new $classe();

                    if($campo['elemento'] == 'A'){
                        if($node->hasAttribute($campo['nome'])){
                            if(method_exists($ObExec, $metodo)) $tochange = call_user_func_array(array($ObExec, $metodo), array($node->getAttribute($campo['nome']),$this));
                            $node->setAttribute($campo['nome'],$tochange);
                            unset ($ObExec);
                        }
                    }else{
                        if(method_exists($ObExec, $metodo)) $tochange = call_user_func_array(array($ObExec, $metodo), array($node->nodeValue,$this));
                        $node->nodeValue = $tochange;
                        unset ($ObExec);
                    }
                }
            }

            return $xml;


    }

    public function send($arquivoretorno = null) {
        if ($this->service->xml) {
            $xmlbody = new DOMDocument();     
            $xmlbody->loadHTML($this->service->xml);
            $TNFeModel = new TNFeModel();
            $xmlbody = $this->model($xmlbody,$this->service->schemaxml);
            $this->parametros['nfeDadosMsg'] = $xmlbody->saveHTML();
            $retComunicacao = $TNFeModel->sendSoap($this->parametros, $this->service->url, $this->service->metodo);

            $retono = $retComunicacao ? $retComunicacao : $TNFeModel->soapDebug;

            if ($arquivoretorno) {
                $xmlfragment = new DOMDocument();
                $xmlfragment->loadHTML($retono);
                if ($xmlfragment->save($arquivoretorno)) {
                    return true;
                } else {
                    return false;
                }
            } else {
                return $retono;
            }
        } else {
            return false;
        }
}

}

?>