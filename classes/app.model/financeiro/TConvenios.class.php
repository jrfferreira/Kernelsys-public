<?php
/* 
 * Oferece as funionalidades necessárias para a mainipulação das informações 
 * dos convenios cadastrados
 * Date: 07/05/2010
 */

class TConvenios{


    /**
     * Recebe o código do tipo de convenio
     * e atribui a label correspondente
     * param <type> $tipoConvenio
     * return <type>
     */
    public function setTipoConvenio($tipoConvenio){

        switch($tipoConvenio){
            case 1:
                $retorno = "Desconto";
                break;
            case 2:
                $retorno = "Bolsa";
                break;
            case 3:
                $retorno = "Parceria";
                break;
            default:
                $retorno = "Não definido";
                break;
        }
        return $retorno;
    }

    /**
     * Recebe o código do tipo de trasação
     * e atribui a label correspondente
     * param <type> $tipoTransacao
     * return <type>
     */
    public function setTipoTransacao($tipoTransacao){

        switch($tipoTransacao){
            case 1:
                $retorno = "Crédito";
                break;
            case 2:
                $retorno = "Débito";
                break;
            default:
                $retorno = "Não definido";
                break;
        }
        return $retorno;
    }

    /**
     * Recebe o código do formato do valor
     * e atribui a label correspondente
     * param <type> $tipoFormato
     * return <type>
     */
    public function setFormato($tipoFormato){

        switch($tipoFormato){
            case 1:
                $retorno = "Valor";
                break;
            case 2:
                $retorno = "Percentual";
                break;
            default:
                $retorno = "Não definido";
                break;
        }
        return $retorno;
    }
    
	/*
	 * 
	 */
    public function atualizaDuplicatasConvenio($codigoConvenio = null) {
        try {
            if ($codigoConvenio) {
                $convenio = new TDbo('dbconvenios');
                $critConvenio = new TCriteria();
                $critConvenio->add(new TFilter('codigo', '=', $codigoConvenio));
                $retConvenio = $convenio->select('datavigencia', $critConvenio);
                $obConvenio = $retConvenio->fetchObject();

                $transacs = new TDbo('dbtransacoes_convenios');
                $crit = new TCriteria();
                $crit->add(new TFilter('codigoconvenio', '=', $codigoConvenio));
                $retTransacs = $transacs->select('codigotransacao', $crit);

                $critContas = new TCriteria();
                $filter = new TFilter('vencimento', '>', $obConvenio->datavigencia);
                $filter->tipoFiltro = '951';
                $critContas->add($filter, 'AND');
                while ($ob = $retTransacs->fetchObject()) {
                    $critContas->add(new TFilter('codigotransacao', '=', $ob->codigotransacao), 'OR');
                }
                
                $contas= new TDbo('dbtransacoes_contas');
                $retContas = $contas->select('codigotransacao', $critContas);

                $critDelete = new TCriteria();
                while ($obC = $retContas->fetchObject()) {
                    $critDelete->add(new TFilter('codigoconta', '=', $obC->codigo), 'OR');
                }

                $duplicatas = new TDbo('dbtransacoes_contas_duplicatas');
                //$duplicatas->delete($critDelete,'codigoconvenio');
                $duplicatas->update(array('statusduplicata' => '9'), $critDelete);
            }
        } catch (Exception $e) {
            new setException($e);
        }
    }
	
    /*
     * 
     */
    public function atualizaTransacao($idform) {

        try {

            if ($idform) {
                //retorna dados do cabeÃ§alho
                $obHeader = new TSetHeader();
                $obHeader = $obHeader->getHead($idform);
                $codigoTransacConvenio = $obHeader['codigo'];

                $dbo = new TDbo('dbtransacoes_convenios');
                $crit = new TCriteria();
                $crit->add(new TFilter('codigo', '=', $codigoTransacConvenio));
                $ret = $dbo->select('codigoconvenio', $crit);
                $ob = $ret->fetchObject();
                $codigoConvenio = $ob->codigoconvenio;

                $this->atualizaDuplicatasConvenio($codigoConvenio);
            }
        } catch (Exception $e) {
            new setException($e);
        }
    }

    /*
     * Retorna a lista de convêncios com seus respetcivos descontos
     * param <strig> $codigoConvenio = codigo do convêncio
     * return <array> Vetor de objetos convênio
     * autor João Felix
     */
    public function getConvenio($codigoConvenio) {
        try{
            $convenio = new TDbo('dbconvenios');
	            $critConvenio = new TCriteria();
	            $critConvenio->add(new TFilter('codigo', '=', $codigoConvenio));
            $retConvenio = $convenio->select('*', $critConvenio);
            $obConvenio = $retConvenio->fetchObject();

            $desconto = new TDbo('dbconvenios_descontos');
	            $critDesconto = new TCriteria();
	            $critDesconto->add(new TFilter('codigoconvenio', '=', $codigoConvenio));
            $retDesconto = $desconto->select('*', $critDesconto);

            while($obDesconto = $retDesconto->fetchObject()){
                $array['descontos'][$obDesconto->dialimite] += $obDesconto->valor;
            }
            $array['convenio'] = $obConvenio->titulo;

            return $array;
        } catch (Exception $e) {
            new setException($e);
        }
    }

    /**
     * 
     * @param $codigoConta
     */
    public function getTextoConvenios($arrayConvenios, $obConta = null) {
        $texto = 'Descontos não informados';
        $tConvenios = new TConvenios();
        $descontos = null;
        if(is_array($arrayConvenios)){
        foreach ($arrayConvenios as $codigoConvenio) {
        	$dboConvenio = new TDbo_out('14303-1','dbconvenios');
        	$critConvenio = new TCriteria();
        	$critConvenio->add(new TFilter('codigo', '=', $codigoConvenio));
        	$retConvenio = $dboConvenio->select('*', $critConvenio);
        	$obConvenio = $retConvenio->fetchObject();
        	
        	$desconto = new TDbo_out('14303-1','dbconvenios_descontos');
        	$critDesconto = new TCriteria();
        	$critDesconto->add(new TFilter('codigoconvenio', '=', $codigoConvenio));
        	$retDesconto = $desconto->select('*', $critDesconto);
        	
        	$convenio = array();
        	while($obDesconto = $retDesconto->fetchObject()){
        		$convenio['descontos'][$obDesconto->dialimite] += $obDesconto->valor;
        		$descontos[$obDesconto->dialimite] += $obDesconto->valor;
        	}
        	$convenio['convenio'] = $obConvenio->titulo;
        }
        
        if(is_array($descontos)){
        if($descontos["--"]){
            $descontoInicial = $descontos["--"];
            unset($descontos["--"]);
        }

        ksort($descontos);
        $espelho = $descontos;
        
            $endKey = end($espelho);
            $endKey = key($espelho);          
            
        if(is_string($obConta)){
        	$valorConta = $obConta;
        }else{
        	$valorConta = $obConta->valorreal;
            $dt = explode("-", $obConta->vencimento);
            $mesVencimento = "/". $dt[1] . "/" . $dt[0];
        }
        $prev = null;
        $texto = null;
        if(count($descontos)) {
            foreach ($descontos as $ch => $vl) {
    
                $valorCheio = number_format(($obConta->valorreal - $descontoInicial), 2, ',', '.');
                $valorAtual = $valorCheio - $vl;
                if ($valorAtual <= 0) {
                    $valorAtual = 0;
                }
    
                $valorAtual = number_format($valorAtual, 2, ',', '.');
                if($prev) {
                    $texto .= "Pagamento de {$prev}{$mesVencimento} a {$ch}/{$mesVencimento} - R$ {$valorAtual} ;" . '<br/>';
                } else {
                    $texto .= "Pagamento até {$ch}{$mesVencimento} .................... - R$ {$valorAtual} ;" . '<br/>';
                }
                
                if($descontoInicial && ($ch == $endKey)){   
                    $texto .= "Pagamento após {$ch}{$mesVencimento} ................. - R$ {$valorCheio} (+ juros e multas se aplicável);" . '<br/>';              
                }
                
                $prev = $ch + 1;
                if(strlen($prev) == 1) $prev = '0'.$prev;
            }
        }elseif($descontoInicial){
            $texto = "Para pagamento até o vencimento - R$ " . number_format ( ($valorConta - $descontoInicial), 2, ',', '.' ) . '<br/>';
        }
        

        $texto = preg_replace('@(;<br/>)$@i','.',$texto);
        }
    }
        return $texto;
    }
    

}