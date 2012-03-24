<?php

    class TRequest{

        public function __construct($url,$method){

            $this->url = parse_url($url);

            if ($this->url['scheme'] == 'http') {
                $this->socket = fsockopen($this->url['host'], 80);

                if(strtoupper($method) == 'POST'){
                   $this->method = "POST ".$this->url['path']." HTTP/1.1\r\n";
                }elseif(strtoupper($method) == 'GET'){
                   $this->method = "GET ".$this->url['path']." HTTP/1.1\r\n";
                }

                $this->host = "Host: ".$this->url['host']."\r\n";
                $this->contentType = "Content-type: application/x-www-form-urlencoded\r\n";
            }
        }

        public function setData($_data){
            if(is_array($_data)){
                $this->data = $_data;

                while(list($n,$v) = each($_data)){
                    $data[] = "$n=$v";
                 }
                 $this->dataString = implode('&', $data);
                 $this->dataLenght = "Content-length: ". strlen($this->dataString) ."\r\n";

            }else{
                return false;
            }
        }

        function requestResult() {

            // send the request headers:
            fputs($this->socket, $this->method);
            fputs($this->socket, $this->host);
            fputs($this->socket, "Referer: $referer\r\n");
            fputs($this->socket, $this->contentType);
            fputs($this->socket, $this->dataLenght);
            fputs($this->socket, "Connection: close\r\n\r\n");
            fputs($this->socket, $this->dataString);

            $this->result = '';
            while(!feof($this->socket)) {
                $this->result .= fgets($this->socket);
            }

            fclose($this->socket);

           $this->result = explode("\r\n\r\n", $this->result, 2);

          //  $header = isset($result[0]) ? $result[0] : '';
          //  $content = isset($result[1]) ? $result[1] : '';
            
          //  $this->result = array($header, $content);

            return $this->result;

        }

        public function XmlObject($content = null){

            if(!$content){
                $content = $this->result[1];
            }
            $tmpXML = simplexml_load_string($content);

            return get_object_vars($tmpXML);
        }

    }
