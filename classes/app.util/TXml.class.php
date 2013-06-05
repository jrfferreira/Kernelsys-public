<?php

    class TXml {

        public function __construct(){
            $this->dom = new DOMDocument('1.0', 'UTF-8');

        }
        
        /*
         * Função para conversão de XML em objeto
         */
        public function toObject($content){
            if(is_file($content)){
                $tmpXML = $this->dom->load($content,SimpleXMLElement);
            }else{
                $tmpXML = $this->dom->loadXML($content,SimpleXMLElement);
            }
            return get_object_vars($this->dom);
        }


    }

