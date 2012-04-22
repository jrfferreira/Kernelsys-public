<?php
/**
 * Apresenta metodos para validação e manipulação da camada de
 * controle do sistema.
 * (Camada que gerencia o fluxo de informaçães e as converte em dados
 * para serem armazenadas em banco de dados.)
 * @author Wagne Borba
 * @date 27/01/2010
 */
class TSetControl {

    private $status = true;
    private $argumento =  array();

    public function main($idForm, $entidade, $regras, $valor, $idCampo) {
        try {
            if($idForm and $entidade and $regras) {

                $this->display_campo = $idCampo.'dsp';

                $vetRegras = explode(';',$regras);
                $this->argumento['idForm'] = $idForm;
                $this->argumento['entidade'] = $entidade;
                $this->argumento['campo'] = $idCampo;
                $this->argumento['valor'] = $valor;

                foreach($vetRegras as $metodo) {

                    $metodoArgs = explode("=>",$metodo);
                    if($metodoArgs[1]) {
                        $this->argumento['argumento'] = $metodoArgs[1];
                    }

                    $metodoMain = $metodoArgs[0]."Main";

                    if($this->argumento['valor'] !== null and $this->status === true) {
                        $this->argumento = call_user_func(array($this, $metodoMain),$this->argumento);
                    }
                    else {
                        $this->argumento = false;
                        $this->status = false;
                        continue;
                    }
                }

                return $this->argumento;

            }else {
                throw new ErrorException("As dados não foram definidas corretamente.");
            }
        }
        catch (Exception $e) {
            new setException($e);
        }
    }

    /**
    *
    * param <type> $idForm
    * return <array>
    */
    public function setNulos($labelCampo, $valor){
        try{

             if($valor == '' or $valor == null){
               $validation = false;
             }

            if($validation === false){
                $retorno = "O campo: ".$labelCampo.' � obrigatório e deve ser preenchido com informaç�o válida.';
            }else{
                $retorno = false;
            }

            return $retorno;
            
        }catch (Exception $e){
            new setException($e);
        }

    }

    /**
     * Aloca dados no nivel de ses�o AlocaDados
     * param $vetor = vetor com valores
     */
    private function setAlocaDadosMain($vetor) {
        try {
            if(is_array($vetor)) {
                $obAlocaDados = new TAlocaDados();
                $obAlocaDados->setValue($vetor['campo'], $vetor['valor']);
            }else {
                throw new ErrorException("O argumento passado não � um vetor v�lido.");
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
                throw new ErrorException("O argumento passado não � um vetor v�lido.");
            }
        }catch(Exception $e) {
            new setException($e);
        }
        return $vetor;
    }

    /*
     * Aplica configuraç�o de encriptaç�o em senhas ou qualquer dado
     * que precise ser encriptado. (Fora de escopo do metodo main)
    */
    public function setPass($valor) {
        if($valor) {
            $valor = md5($valor);
        }
        return $valor;
    }
    
    /**
     * Adiquire chave daq sesão
     */
    public function getSessionPass($valor) {
        if($valor) {
          $valor = md5($valor);
        }
        return $valor;
    }
    
    /**
     * aplica encriptaç�o dentro do escopo do metodo main.
     */
    private function setPassMain($vetor) {
        $vetor['valor'] = $this->setPass($vetor['valor']);
        return $vetor;
    }

    /**
     * Valida Duplicaç�o baseada no campo
     * param <array> $vetor = vetor contendo o nome do campo e o valor
     */
    private function setDuplicacaoMain($vetor) {
        try{
                //retorna o cabeçalho do formulário
                $obHeaderForm = new TSetHeader();
                $headerForm = $obHeaderForm->getHead($vetor['idForm']);

                if($headerForm['colunafilho']){
                    $colunafilho = $headerForm['colunafilho'];
                }else{
                    $colunafilho = 'codigo';
                }

                $criteriaDup = new TCriteria();
                    if($headerForm['codigoPai'] and $headerForm['idLista'] != $headerForm['listapai']){
                        $criteriaDup->add(new TFilter($headerForm['destinocodigo'], '=', $headerForm['codigoPai']));
                        $criteriaDup->add(new TFilter($colunafilho, '!=', $headerForm['codigo']));
                    }
                    if($headerForm['codigo']){
                        $criteriaDup->add(new TFilter($colunafilho, '!=', $headerForm['codigo']));
                    }
                $criteriaDup->add(new TFilter($vetor['campo'], '=', $vetor['valor']));

             $obDbo = new TDbo();
             $obDbo->setEntidade($vetor['entidade']);
             $retDados = $obDbo->select('codigo', $criteriaDup);
             $obDados = $retDados->fetchObject();

             if($obDados->codigo){
                 
                $duplic = false;
                $vetor['codigoRetorno'] = 'erro#4';
                $vetor['msg'] = "Já existe um registro com a informaç�o fornecida ( ".$vetor['valor'].").<br>";
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
    public function validaCpfCnpjMain($vetor){
    	
        $obHeaderForm = new TSetHeader();
        $headerForm = $obHeaderForm->getHead($vetor['idForm']);
        if(strtolower($headerForm['camposSession']['tipo']['valor']) == 'j'){
	        $cnpj = $this->setTrueCnpj($vetor['valor']);
	        if($cnpj){
	            $dbo = new TDbo($vetor['entidade']);
	            $crit = new TCriteria();
	            $crit->add(new TFilter($vetor['campo'],'=',$vetor['valor']),'OR');
	            $crit->add(new TFilter($vetor['campo'],'=',$cnpj),'OR');
	            $filter = new TFilter('codigo','=',$headerForm['codigo']);
	            $filter->tipoFiltro = 6;
	            $crit->add($filter,'AND');
	
	            $ret = $dbo->select($vetor['campo'],$crit);
	            $duplic = false;
	            while($n = $ret->fetchObject()){
	                $duplic = true;
	            }
	            if($duplic){
	                $vetor['codigoRetorno'] = 'erro#4';
	                $vetor['msg'] = "O CNPJ passado já existe nos registros do sistema ( ".$vetor['valor'].").<br>";
	                $vetor['valor'] = false;
	                return $vetor;
	            }else{
	                $vetor['valor'] = $cnpj;
	                return $vetor;
	            }
	        }else{
	            $vetor['codigoRetorno'] = 'erro#4';
	            $vetor['msg'] = "O CNPJ passado não é válido ( ".$vetor['valor'].").<br>";
	            $vetor['valor'] = false;
	            return $vetor;
	        }
	        
	        return $vetor;
        }else{
        	$cpf = $this->setTrueCpf($vetor['valor']);
        	if($cpf){
        		$dbo = new TDbo($vetor['entidade']);
        		$crit = new TCriteria();
        		$crit->add(new TFilter($vetor['campo'],'=',$vetor['valor']),'OR');
        		$crit->add(new TFilter($vetor['campo'],'=',$cpf),'OR');
        		$filter = new TFilter('codigo','!=',$headerForm['codigo']);
        		$filter->tipoFiltro = 6;
        		$crit->add($filter,'AND');
        	
        		$ret = $dbo->select($vetor['campo'],$crit);
        		$duplic = false;
        		while($n = $ret->fetchObject()){
        			$duplic = true;
        		}
        		if($duplic){
        			$vetor['codigoRetorno'] = 'erro#4';
        			$vetor['msg'] = "O CPF informado já existe nos registros do sistema ( ".$vetor['valor'].").<br>";
        			$vetor['valor'] = false;
        			return $vetor;
        		}else{
        			$vetor['valor'] = $cpf;
        			return $vetor;
        		}
        	}else{
        		$vetor['codigoRetorno'] = 'erro#4';
        		$vetor['msg'] = "O CPF informado não é válido ( ".$vetor['valor'].").<br>";
        		$vetor['valor'] = false;
        		return $vetor;
        	}
        }
    }
    
    /**
     * 
     * @param $valor
     */
    public function setTrueCnpj($valor){
        // Valida entrada
        $cnpj = sprintf('%014s', preg_replace('{\D}', '', $valor));
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
	 * @return string|unknown|string
	 */
	public function validaQuantidadeItensMain($vetor){
        $obHeaderForm = new TSetHeader();
        $headerForm = $obHeaderForm->getHead($vetor['idForm']);
        if($vetor['valor']){
        	$dbo = new TDbo('dbtransacoes_itens');
            $crit = new TCriteria();
            $filter = new TFilter('codigo','=',$headerForm['codigo']);
            $filter->tipoFiltro = 6;
            $crit->add($filter,'AND');
            
            $Produto = $dbo->select('codigoproduto',$crit);
            $retProduto = $Produto->fetchObject();
            
        	
            $dbo = new TDbo('view_produtos');
            $crit = new TCriteria();
            $filter = new TFilter('codigo','=',$retProduto->codigoproduto);
            $filter->tipoFiltro = 6;
            $crit->add($filter,'AND');

            $ret = $dbo->select('quantidadedisponivel',$crit);
            $n = $ret->fetchObject();
            $qtde = $n->quantidadedisponivel ? $n->quantidadedisponivel : 0;
            if($vetor['valor'] > $qtde){
                $vetor['codigoRetorno'] = 'erro#4';
                $vetor['msg'] = "não � possível prosseguir com o formulário de pedidos.<br><p>A quantidade informada ({$vetor['valor']}) � superior à quantidade disponível em estoque ({$qtde})</p>";
                $vetor['valor'] = false;
                return $vetor;
            }else{
                $vetor['valor'] = $vetor['valor'];
                return $vetor;
            }
        }else{
            $vetor['codigoRetorno'] = 'erro#4';
            $vetor['msg'] = "É necessario informar umq quantidade de itens.<br>";
            $vetor['valor'] = false;
            return $vetor;
        }
    }

    /**
     * Formata telefone para ser armazenado no DB
     * @param unknown_type $valor
     */
    public function setTelefoneDB($valor){
        $valor = preg_replace('{\D}', '', $valor);
        $telefone = substr($valor,(strlen($valor)-10),10);
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
        $cpf = sprintf('%011s', preg_replace('{\D}', '', $valor));
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
    * Funç�o para arredondamento de notas 0,5 a 0,5 pontos
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
     * Valida a inclus�o de produtos na transação
     * apos a geração das contas
     * param <type> $vetor
     */
    public function transacaoProdutosMain($vetor){
        try{

            $obDbo = new TDbo(TConstantes::DBTRANSACOES_CONTAS);
            $criteriaContas = new TCriteria();
            $criteriaContas->add(new TFilter('codigotransacao', '=', $vetor['valor']));
            $retContas = $obDbo->select('codigo', $criteriaContas);
            $obContas = $retContas->fetchObject();

            if($obContas->codigo){
                $retorno  = 'erro#5';
                $retorno .= "#Já existem contas associadas � esta transação, não � possivel alterar o valor da mesma.";
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
               throw new Exception('A mensagem não � uma String v�lida');
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
}