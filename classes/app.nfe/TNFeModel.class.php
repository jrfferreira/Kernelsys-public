<?php

final class TNFeModel {

    //Urls para algoritmos de assinatura
    private $URLdsig = 'http://www.w3.org/2000/09/xmldsig#';
    private $URLCanonMeth = 'http://www.w3.org/TR/2001/REC-xml-c14n-20010315';
    private $URLSigMeth = 'http://www.w3.org/2000/09/xmldsig#rsa-sha1';
    private $URLTransfMeth_1 = 'http://www.w3.org/2000/09/xmldsig#enveloped-signature';
    private $URLTransfMeth_2 = 'http://www.w3.org/TR/2001/REC-xml-c14n-20010315';
    private $URLDigestMeth = 'http://www.w3.org/2000/09/xmldsig#sha1';
    //Chave privada
    private $privatecert = 'cert/privatekey.pem';
    //Chave pública
    private $publiccert = 'cert/publickey.pem';
    //Variaveis para tratamento de erros
    public $erroStatus = null;
    public $erroMsg = null;
    // senha de decriptaçao da chave
    public $pass = null;
    //Debug SOAP
    public $soapDebug = null;

    public function geraChaveAcesso($uf, $data, $cnpj, $modelo, $serie, $numNfe, $formaEmissao, $seq, $digitoverificador = null) {

        $cnpj = sprintf('%014s', preg_replace('{\D}', '', $cnpj));

        if (preg_match("/([0-9]{2})\/([0-9]{2})\/([0-9]{4})/", $data)) {
            $newData = explode('/', $data);
            $data = "$newData[2]-$newData[1]-$newData[0]";
        }
        $data = substr($data, 2);
        $data = substr(preg_replace('{\D}', '', $data), 0, -2);
        $uf = substr($uf, 0, 2);
        $modelo = substr($modelo, 0, 2);
        $serie = substr($serie, 0, 3);
        $numNfe = substr($numNfe, 0, 9);
        if (strlen($numNfe) < 9) {
            $count = strlen($numNfe);
            for ($index = 0; $index < (9 - $count); $index++) {
                $numNfe = '0' . $numNfe;
            }
        }
        $formaEmissao = substr($formaEmissao, 0, 1);
        $seq= substr($seq, 0, 8);
        if (strlen($seq) < 8) {
            $count = strlen($seq);
            for ($index = 0; $index < (8 - $count); $index++) {
                $seq= '0' . $seq;
            }
        }

        $chavedeacesso = $uf . $data . $cnpj . $modelo . $serie . $numNfe . $formaEmissao . $seq;

        if (!$digitoverificador) {
            return $chavedeacesso . $this->geraDigitoVerificador($chavedeacesso);
        } else {
            return $chavedeacesso . $digitoverificador;
        }
    }

    public function geraDigitoVerificador($chavedeacesso) {

        $digitos = str_split($chavedeacesso);

        $peso = 2;
        for ($i = (count($digitos) - 1); $i >= 0; $i--) {
            $ponderacao[$i] = $digitos[$i] * $peso;
            $peso = ($peso == 9) ? 2 : $peso + 1;
        }

        $resto = array_sum($ponderacao) % 11;

        $digitoverificador = ($resto <= 1) ? 0 : (11 - $resto);

        return $digitoverificador;
    }

    /**
     * Assinador para arquivos XML
     *
     * @param	string $docxml String contendo o arquivo XML a ser assinado
     * @param   string $tagid TAG do XML que devera ser assinada
     * @return	mixed FALSE se houve erro ou string com o XML assinado
     */
    public function assinaXML($docxml, $tagid='') {
        if ($tagid == '') {
            $this->erroMsg = 'Uma tag deve ser indicada para que seja assinada.';
            $this->erroStatus = TRUE;
            return FALSE;
        }
        if ($docxml == '') {
            $this->erroMsg = 'Um xml deve ser passado para que seja assinado.';
            $this->erroStatus = TRUE;
            return FALSE;
        }
        // obter o chave privada para a assinatura
        $fp = fopen($this->privatecert, "r");
        $priv_key = fread($fp, 8192);
        fclose($fp);
        //$pkeyid = openssl_get_privatekey($priv_key);
        $pkeyid = openssl_pkey_get_private($priv_key);
        // limpeza do xml
        $order = array("\r\n", "\n", "\r");
        $replace = '';
        $docxml = str_replace($order, $replace, $docxml);
        // carrega o documento no DOM
        $xmldoc = new DOMDocument('1.0', 'utf-8');
        $xmldoc->preservWhiteSpace = FALSE; //elimina espaços em branco
        $xmldoc->formatOutput = FALSE;
        // muito importante deixar ativadas as opçoes para limpar os espacos em branco
        // e as tags vazias
        $xmldoc->loadXML($docxml, LIBXML_NOBLANKS | LIBXML_NOEMPTYTAG);
        $root = $xmldoc->documentElement;
        //extrair a tag com os dados a serem assinados
        $node = $xmldoc->getElementsByTagName($tagid)->item(0);
        $id = trim($node->getAttribute("Id"));
        $idnome = preg_replace('/[^0-9]/', '', $id);
        //extrai os dados da tag para uma string
        $dados = $node->C14N(FALSE, FALSE, NULL, NULL);
        //calcular o hash dos dados
        $hashValue = hash('sha1', $dados, TRUE);
        //converte o valor para base64 para serem colocados no xml
        $digValue = base64_encode($hashValue);
        //monta a tag da assinatura digital
        $Signature = $xmldoc->createElementNS($this->URLdsig, 'Signature');
        $root->appendChild($Signature);
        $SignedInfo = $xmldoc->createElement('SignedInfo');
        $Signature->appendChild($SignedInfo);
        //Cannocalization
        $newNode = $xmldoc->createElement('CanonicalizationMethod');
        $SignedInfo->appendChild($newNode);
        $newNode->setAttribute('Algorithm', $this->URLCanonMeth);
        //SignatureMethod
        $newNode = $xmldoc->createElement('SignatureMethod');
        $SignedInfo->appendChild($newNode);
        $newNode->setAttribute('Algorithm', $this->URLSigMeth);
        //Reference
        $Reference = $xmldoc->createElement('Reference');
        $SignedInfo->appendChild($Reference);
        $Reference->setAttribute('URI', '#' . $id);
        //Transforms
        $Transforms = $xmldoc->createElement('Transforms');
        $Reference->appendChild($Transforms);
        //Transform
        $newNode = $xmldoc->createElement('Transform');
        $Transforms->appendChild($newNode);
        $newNode->setAttribute('Algorithm', $this->URLTransfMeth_1);
        //Transform
        $newNode = $xmldoc->createElement('Transform');
        $Transforms->appendChild($newNode);
        $newNode->setAttribute('Algorithm', $this->URLTransfMeth_2);
        //DigestMethod
        $newNode = $xmldoc->createElement('DigestMethod');
        $Reference->appendChild($newNode);
        $newNode->setAttribute('Algorithm', $this->URLDigestMeth);
        //DigestValue
        $newNode = $xmldoc->createElement('DigestValue', $digValue);
        $Reference->appendChild($newNode);
        // extrai os dados a serem assinados para uma string
        $dados = $SignedInfo->C14N(FALSE, FALSE, NULL, NULL);
        //inicializa a variavel que irá receber a assinatura
        $signature = '';
        //executa a assinatura digital usando o resource da chave privada
        $resp = openssl_sign($dados, $signature, $pkeyid);
        //codifica assinatura para o padrao base64
        $signatureValue = base64_encode($signature);
        //SignatureValue
        $newNode = $xmldoc->createElement('SignatureValue', $signatureValue);
        $Signature->appendChild($newNode);
        //KeyInfo
        $seqInfo = $xmldoc->createElement('KeyInfo');
        $Signature->appendChild($seqInfo);
        //X509Data
        $X509Data = $xmldoc->createElement('X509Data');
        $seqInfo->appendChild($X509Data);
        //carrega o certificado sem as tags de inicio e fim
        $cert = $this->__cleanCerts($this->privatecert);
        //X509Certificate
        $newNode = $xmldoc->createElement('X509Certificate', $cert);
        $X509Data->appendChild($newNode);
        //grava na string o objeto DOM
        $docxml = $xmldoc->saveXML();
        // libera a memoria
        openssl_free_key($pkeyid);
        return $docxml;
    }

    /**
     * Estabelece comunicaçao com servidor SOAP da SEFAZ, usando as chaves publica e privada
     * parametrizadas na contrução da classe.
     *
     * @param    array   $param Matriz com o cabeçalho e os dados da mensagem soap
     * @param    string  $urlsefaz Designaçao do URL do serviço SOAP
     * @param    string  nome do método do serviço SOAP desejado
     * @return   array  Array com a resposta do SOAP ou String do erro ou false
     * */
    public function sendSoap($param, $urlsefaz, $service) {
        try {
            //monta a url do serviço
            $URL = (preg_match('|(\?wsdl)$|i', $urlsefaz)) ? $urlsefaz : $urlsefaz . '?wsdl';
            //inicia a conexao SOAP
            $client = new nusoap_client($URL, true);
            $client->authtype = 'certificate';
            $client->soap_defencoding = 'UTF-8';
            //Seta parametros para a conexao segura
            $client->certRequest['sslkeyfile'] = $this->privatecert;
            $client->certRequest['sslcertfile'] = $this->publiccert;
            $client->certRequest['passphrase'] = $this->pass;
            $client->certRequest['verifypeer'] = false;
            $client->certRequest['verifyhost'] = false;
            $client->certRequest['trace'] = 1;
        }
        //em caso de erro retorne o mesmo
        catch (Exception $ex) {
            if (is_bool($client->getError())) {
                $this->erroStatus = False;
                $this->erroMsg = '';
            } else {
                $this->erroStatus = True;
                $this->erroMsg = $client->getError();
            }
        }
        // chama a funçao do webservice, passando os parametros
        $result = $client->call($service, $param);
        $this->soapDebug = htmlspecialchars($client->debug_str, ENT_QUOTES);
        // retorna o resultado da comunicaçao

        return $result;
    }

    /**
     * Verifica o xml com base no xsd
     * Esta função pode validar qualquer arquivo xml do sistema de NFe
     * Há um bug no libxml2 para versões anteriores a 2.7.3
     * que causa um falso erro na validação da NFe devido ao
     * uso de uma marcação no arquivo tiposBasico_v1.02.xsd
     * onde se le {0 , } substituir por *
     *
     * @param    string  $docxml  string contendo o arquivo xml a ser validado
     * @param    string  $xsdfile Path completo para o arquivo xsd
     * @return   array   ['staus','error']
     */
    public function validaXML($docXml, $xsdFile) {
        // Habilita a manipulaçao de erros da libxml
        libxml_use_internal_errors(true);
        // instancia novo objeto DOM
        $xmldoc = new DOMDocument();
        // carrega o xml
        $xml = $xmldoc->loadXML($docXml);
        $errorMsg = '';
        // valida o xml com o xsd
        if (!$xmldoc->schemaValidate($xsdFile)) {
            // carrega os erros em um array
            $aIntErrors = libxml_get_errors();
            $flagOK = FALSE;
            foreach ($aIntErrors as $intError) {
                switch ($intError->level) {
                    case LIBXML_ERR_WARNING:
                        $errorMsg .= " Atenção: $intError->code: ";
                        break;
                    case LIBXML_ERR_ERROR:
                        $errorMsg .= " Erro: $intError->code: ";
                        break;
                    case LIBXML_ERR_FATAL:
                        $errorMsg .= " Erro Fatal: $intError->code: ";
                        break;
                }
                $errorMsg .= $intError->message . ';';
            }
        } else {
            $flagOK = TRUE;
            $errorMsg = '';
        }
        return array(TConstantes::FIELD_STATUS => $flagOK, 'error' => $errorMsg);
    }


    //Retorna o seqdo Estado segundo tabela de dominio
    public function getseqUF($uf,$ob = null){
            $TDbo = new TDbo('dominio.dbestados','bitup');
            $crit = new TCriteria();
            $crit->add(new TFilter('estado', '=', $uf),'OR');
            $crit->add(new TFilter('uf', '=', $uf),'OR');
            $ret = $TDbo->select('sequf', $crit);

            $ob = $ret->fetchObject();

            if($ob->sequf){
               return $ob->sequf;
            }else{
               return $uf;
            }

    }

    //Retorna o seqdo municipio segundo tabela de dominio
    public function getseqMunicipio($cidade,$ob = null){
            $TDbo = new TDbo('dominio.dbcidades','bitup');
            $crit = new TCriteria();
            $crit->add(new TFilter('cidade', '=', $cidade));
            $ret = $TDbo->select('seqibge', $crit);

            $ob = $ret->fetchObject();

            if($ob->seqibge){
               return $ob->seqibge;
            }else{
               return $cidade;
            }

    }
    //Retorna seqnumérico aleatorio para a nota fiscal
    public function geraseqNumerico($param,$ob = null){
        $return = "";
        while(strlen($return) >= 8){
            $return = (string) $return . rand(0,9);
        }
        return $return;
    }

    //Retorna o ambiente (1 ou 2)
    public function getAmbiente($param,$ob = null){
        return $ob->ambiente;
    }

    public function validaNFe(){
        /*
                versao
                Id
                cUF
                cNF
                dEmi
                cDV
                procEmi = 0
                verProc
        */

    }
}

?>