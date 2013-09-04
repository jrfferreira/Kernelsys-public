<?php
/**
 * Gerencia execução das regras de negocio do sistema.
 * @author Wagne Borba
 * @date 22/03/2013
 */
class TControl {
	
	/**
	 * Metodo que intermedia e direciona toda a execução das RNGs
	 * @param stdClass $obj = objeto de transferência passando com atributos nativos e devolvidos com atributos de validação
	 * @param String $method = método que será executado
	 * @param String $class = Classe que deve ser instanciada para execução do método
	 */
	public function main($obj, $method, $class){
		try{
			
			
			
			$this->return = call_user_func(array($class, $method),$obj);			
			
		}
	     catch (Exception $e) {
            new setException($e);
        }	
		
	}
	
	
	

    /**
    *
    * param <type> $formseq
    * return <array>
    */
    public function setNulos($labelCampo, $valor){
        try{

             if($valor == '' or $valor == null){
               $validation = false;
             }

            if($validation === false){
                $retorno = "O campo: ".$labelCampo.' é obrigatório e deve ser preenchido com informação válida.';
            }else{
                $retorno = false;
            }

            return $retorno;
            
        }catch (Exception $e){
            new setException($e);
        }

    }

    /**
     * Aloca dados no nivel de sesão AlocaDados
     * param $vetor = vetor com valores
     */
    private function setAlocaDadosMain($vetor) {
        try {
            if(is_array($vetor)) {
                $obAlocaDados = new TAlocaDados();
                $obAlocaDados->setValue($vetor['campo'], $vetor['valor']);
            }else {
                throw new ErrorException("O argumento passado não é um vetor válido.");
            }
        }catch(Exception $e) {
            new setException($e);
        }
        return $vetor;
    }

    /**
     * Pega o valor armazenado no AlocaDados e armazena no vetor
     * param <type> $vetor
     * return <type> array
     */
    private function getAlocaDadosMain($vetor) {
        try {
            if(is_array($vetor)) {
                $obAlocaDados = new TAlocaDados();
                $vetor['valor'] = $obAlocaDados->getValue($vetor['argumento']);
            }else {
                throw new ErrorException("O argumento passado não é um vetor válido.");
            }
        }catch(Exception $e) {
            new setException($e);
        }
        return $vetor;
    }

//    /**
//     * Converte para maiúsculas o primeiro caractere de cada palavra
//     */
//    public function setUcwords($valor) {
//        try {
//            if($valor) {
//                $array = explode(" ", $valor);
//
//                foreach ($array as $ch=>$vl) {
//                    $min = strtolower($vl);
//                    if($min != "de" and $min != "da") {
//                        $min = ucwords($min);
//                    }
//                    $str[$ch] = $min;
//                }
//                $valor = implode(" ", $str);
//            }
//        }catch (Exception $e) {
//            new setException($e);
//        }
//        return $valor;
//    }
//
//    /**
//     * Converte para maiúsculas o primeiro caractere de cada palavra
//     */
//    public function setUcwordsMain($vetor) {
//        $vetor['valor'] = $this->setUcwords($vetor['valor']);
//        return $vetor;
//    }

    /*
     * Aplica configuraçs�o de encriptaçs�o em senhas ou qualquer dado
     * que precise ser encriptado. (Fora de escopo do metodo main)
    */
    public function setPass($valor) {
        if($valor) {
            $valor = md5($valor);
        }
        return $valor;
    }
    
    /**
     * Adiquire chave daq ses�o
     */
    public function getSessionPass($valor) {
        if($valor) {
          $valor = md5($valor);
        }
        return $valor;
    }
    
    /**
     * aplica encriptaçs�o dentro do escopo do metodo main.
     */
    private function setPassMain($vetor) {
        $vetor['valor'] = $this->setPass($vetor['valor']);
        return $vetor;
    }

    /**
     * Valida Duplicaçs�o baseada no campo
     * param <array> $vetor = vetor contendo o nome do campo e o valor
     */
    private function setDuplicacaoMain($vetor) {
        try{
                //retorna o cabe�alho do formul�rio
                $obHeaderForm = new TSetHeader();
                $headerForm = $obHeaderForm->getHead($vetor[TConstantes::FORM]);

                if($headerForm['colunafilho']){
                    $colunafilho = $headerForm['colunafilho'];
                }else{
                    $colunafilho = TConstantes::SEQUENCIAL;
                }

                $criteriaDup = new TCriteria();
                    if($headerForm['seqPai'] and $headerForm[TConstantes::LISTA] != $headerForm['listapai']){
                        $criteriaDup->add(new TFilter($headerForm['destinoseq'], '=', $headerForm['seqPai']));
                        $criteriaDup->add(new TFilter($colunafilho, '!=', $headerForm[TConstantes::SEQUENCIAL]));
                    }
                    if($headerForm[TConstantes::SEQUENCIAL]){
                        $criteriaDup->add(new TFilter($colunafilho, '!=', $headerForm[TConstantes::SEQUENCIAL]));
                    }
                $criteriaDup->add(new TFilter($vetor['campo'], '=', $vetor['valor']));

             $obDbo = new TDbo();
             $obDbo->setEntidade($vetor[TConstantes::ENTIDADE]);
             $retDados = $obDbo->select(TConstantes::SEQUENCIAL, $criteriaDup);
             $obDados = $retDados->fetchObject();

             if($obDados->seq){
                 
                $duplic = false;
                $vetor['seqRetorno'] = 'erro#4';
                $vetor['msg'] = "Já existe um registro com a informação fornecida ( ".$vetor['valor'].").<br>";
             }else{
                $duplic = $vetor['valor'];
             }

             $vetor['valor'] = $duplic;
             $obDbo->close();
             return $vetor;

        }catch (Exception $e){
            new setException($e);
        }

    }

    /**
    *
    */
    public function setFloat($valor) {
        try{
            $novovalor = str_replace("R$", "", $valor);
            $novovalor = str_replace(",", ".", $novovalor);
            return $novovalor;

        }catch (Exception $e){
            new setException($e);
        }

    }

    public function setFloatMain($vetor) {
        try{

            $vetor['valor'] = $this->setFloat($vetor['valor']);
            return $vetor;

        }catch (Exception $e){
            new setException($e);
        }

    }

    /**
    * Formata a data do modelo internacional para
    * no modelo brasileiro.
    */
    public function setDataDB($data = null) {
        try{

        $data = $data ? $data : date('Y-m-d');

        $dt = explode("/",$data);
        if($dt[1]) {
            $data = $dt[2]."-".$dt[1]."-".$dt[0];
            return $data;
        }else {
            return $valor;
        }

        }catch (Exception $e){
            new setException($e);
        }

    }

    /**
    * Metodo Main do setDataDB
    * param <type> $vetor
    * return <type>
    */
    public function setDataDBMain($vetor) {
        try{
            $vetor['valor'] = $this->setDataDB($vetor['valor']);
            return $vetor;

        }catch (Exception $e){
            new setException($e);
        }

    }

	/**
	 * 
	 * @param unknown_type $vetor
	 */
    public function validaCnpjMain($vetor){
    	
        $obHeaderForm = new TSetHeader();
        $headerForm = $obHeaderForm->getHead($vetor[TConstantes::FORM]);
        if(strtolower($headerForm[TConstantes::CAMPOS_FORMULARIO]['tipo']['valor']) == 'j'){
	        $cnpj = $this->setTrueCnpj($vetor['valor']);
	        if($cnpj){
	            $dbo = new TDbo($vetor[TConstantes::ENTIDADE]);
	            $crit = new TCriteria();
	            $crit->add(new TFilter($vetor['campo'],'=',$cnpj),'OR');
	            $filter = new TFilter(TConstantes::SEQUENCIAL,'=',$headerForm[TConstantes::SEQUENCIAL]);
	            $filter->tipoFiltro = 6;
	            $crit->add($filter,'AND');
	
	            $ret = $dbo->select($vetor['campo'],$crit);
	            $duplic = false;
	            while($n = $ret->fetchObject()){
	                $duplic = true;
	            }
	            if($duplic){
	                $vetor['seqRetorno'] = TConstantes::ERRO_VALIDACAO;
	                $vetor['msg'] = "O CNPJ passado já existe nos registros do sistema ( ".$vetor['valor'].").<br>";
	                $vetor['valor'] = false;
	                return $vetor;
	            }else{
	                $vetor['valor'] = $cnpj;
	                return $vetor;
	            }
	        }else{
	            $vetor['seqRetorno'] = TConstantes::ERRO_VALIDACAO;
	            $vetor['msg'] = "O CNPJ passado não é válido ( ".$vetor['valor'].").<br>";
	            $vetor['valor'] = false;
	            return $vetor;
	        }
	        
	        return $vetor;
        }
    }
    
    /**
     * 
     * @param $valor
     */
    public function setTrueCnpj($valor){
        // Valida entrada
        $cnpj = sprintf('%014s', preg_replace('@[^0-9]@', '', $valor));
        if ((strlen($cnpj) != 14) || (intval(substr($cnpj, -4)) == 0)) {
            return false;
        }else{
        // Valida checagem
        for ($t = 11; $t < 13;) {
            for ($d = 0, $p = 2, $c = $t; $c >= 0; $c--, ($p < 9) ? $p++
                                                                  : $p = 2) {
                $d += $cnpj[$c] * $p;
            }

            if ($cnpj[++$t] != ($d = ((10 * $d) % 11) % 10)) {
                return false;
            }else{
                return $cnpj;
            }
        }
        }
    }
    
	/**
	 * 
	 * @param unknown_type $vetor
	 */
    public function validaCpfMain($vetor){
        $obHeaderForm = new TSetHeader();
        $headerForm = $obHeaderForm->getHead($vetor[TConstantes::FORM]);
        $cpf = $this->setTrueCpf($vetor['valor']);
        if($cpf){
            $dbo = new TDbo($vetor[TConstantes::ENTIDADE]);
            $crit = new TCriteria();
            $crit->add(new TFilter($vetor['campo'],'=',$cpf),'OR');
            $filter = new TFilter(TConstantes::SEQUENCIAL,'!=',$headerForm[TConstantes::SEQUENCIAL]);
            $filter->tipoFiltro = 6;
            $crit->add($filter,'AND');

            $ret = $dbo->select($vetor['campo'],$crit);
            $duplic = false;
            while($n = $ret->fetchObject()){
                $duplic = true;
            }
            if($duplic){
                $vetor['seqRetorno'] = TConstantes::ERRO_VALIDACAO;
                $vetor['msg'] = "O CPF informado já existe nos registros do sistema ( ".$vetor['valor'].").<br>";
                $vetor['valor'] = false;
                return $vetor;
            }else{
                $vetor['valor'] = $cpf;
                return $vetor;
            }
        }else{
            $vetor['seqRetorno'] = TConstantes::ERRO_VALIDACAO;
            $vetor['msg'] = "O CPF informado não é válido ( ".$vetor['valor'].").<br>";
            $vetor['valor'] = false;
            return $vetor;
        }
    }


    /**
     * Formata telefone para ser armazenado no DB
     * @param unknown_type $valor
     */
    public function setTelefoneDB($valor){
        $valor = preg_replace('@[^0-9]@', '', $valor);
        $telefone = substr($valor,(strlen($valor)-8),8);
        return $telefone;
    }
    
    /**
     * 
     * @param $vetor
     */
	private function setTelefoneDBMain($vetor) {
        $vetor['valor'] = $this->setTelefoneDB($vetor['valor']);
        return $vetor;
    }
	
    /**
     * Valida CPF
     * @param $valor
     */
    public function setTrueCpf($valor){
        // Valida entrada
        $cpf = sprintf('%011s', preg_replace('@[^0-9]@', '', $valor));
        // Valida caracteres
        if ((strlen($cpf) != 11) || ($cpf == '00000000000') || ($cpf == '99999999999')) {
            return false;
        }else{

        // Valida digitos de checagem por algoritmo 11
        for ($t = 8; $t < 10;) {
            for ($d = 0, $p = 2, $c = $t; $c >= 0; $c--, $p++) {
                $d += $cpf[$c] * $p;
            }
            if ($cpf[++$t] != ($d = ((10 * $d) % 11) % 10)) {
                return false;
            }else{
                return $cpf;
            }
        }
        }
    }

    /*
    * Fun�s�o para arredondamento de notas 0,5 a 0,5 pontos
    */
    public function setArredondamentoNota($n){
        try{
            $novovalor = str_replace(",", ".", $n);
            $valorArredondado = round($novovalor * 10) / 10;

        $toCheck = explode('.', $valorArredondado);
        
        if($toCheck[1] < 5 && $toCheck[1] > 0 ){
            $toCheck[1] = 5;
        }elseif($toCheck[1] > 5 && $toCheck[1] <= 9){
            $toCheck[0] = $toCheck[0] + 1;
            $toCheck[1] = 0;
        }else{
            $toCheck[0] = $toCheck[0];
            $toCheck[1] = 0;
        }
            $valorArredondado = implode('.',$toCheck);

            return $valorArredondado;

        }catch (Exception $e){
            new setException($e);
        }
    }

    /**
     * Valida a inclusão de produtos na transação
     * apos a geração das contas
     * param <type> $vetor
     */
    public function transacaoProdutosMain($vetor){
        try{

            $obDbo = new TDbo(TConstantes::DBPARCELA);
            $criteriaContas = new TCriteria();
            $criteriaContas->add(new TFilter('seqtransacao', '=', $vetor['valor']));
            $retContas = $obDbo->select(TConstantes::SEQUENCIAL, $criteriaContas);
            $obContas = $retContas->fetchObject();

            if($obContas->seq){
                $retorno  = TConstantes::ERRO_BANCODADOS;
                $retorno .= "#Já existem contas associadas é esta transação, não é possivel alterar o valor da mesma.";
            }else{
                $retorno = false;
            }
            
            return $retorno;
            
        }catch (Exception $e){
            new setException($e);
        }
    }

    /**
     * Metodo interno para retorno direto de mensagens
     * de erro das regras de negocio
     * param <type> $msg = mensagem a ser exibida
     */
    private function showMsg($msg){
        try{
            if(!$msg){
               throw new Exception('A mensagem não é válida');
            }

            $windowMsg = new TWindow('Alerta', 'msg_rng');
            $windowMsg->add($msg);
            $windowMsg->setAutoOpen();
            $windowMsg->setSize('500','200');
            $windowMsg->show();

        }catch (Exception $e){
            new setException($e);
        }
    }

    /*
     * Função para checagem de Sistema Operacional
     */

 	/*
     * Função para checagem de navegador
     */
        public function checkBrowser(){
            $props    = array("version" => "0.0.0",
                                "brownser" => "unknown",
                                "plataform" => "unknown") ;

        $browsers = array("firefox", "msie", "opera", "chrome", "safari",
                            "mozilla", "seamonkey",    "konqueror", "netscape",
                            "gecko", "navigator", "mosaic", "lynx", "amaya",
                            "omniweb", "avant", "camino", "flock", "aol");

        $agent = strtolower($_SERVER['HTTP_USER_AGENT']);
            foreach($browsers as $browser) {
                if (preg_match("#($browser)[/ ]?([0-9.]*)#", $agent, $match))
                {
                    $ret['browser'] = $match[1] ;
                    $ret['version'] = $match[2] ;
                    break ;
                }
            }

            if (preg_match('/linux/', $agent)) {
            $ret['plataform'] = 'linux';
            }
            elseif (preg_match('/macintosh|mac os x/', $agent)) {
                $ret['plataform'] = 'mac';
            }
            elseif (preg_match('/windows|win32/', $agent)) {
                $ret['plataform'] = 'windows';
            }

            return $ret;
        }

    /**
     * 
     * @param unknown_type $vl
     */
    public function setBool($vl) {
        if ($vl == "1") {
            $vl = "Sim";
        } else {
            $vl = "Não";
        }
        return $vl;
    }

	
	public function validaCpfCnpjMain($vetor){
		try{
			$valor = $vetor['valor'];
			if($this->setTrueCnpj($valor)){
				return $this->validaCnpjMain($vetor);
			}else{
				return $this->validaCpfMain($vetor);
			}
		}catch (Exception $e){
            new setException($e);
        }
	}
	
}
?>