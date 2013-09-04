<?php

/**
 * Apresenta metodos para valida��o e manipula��o da camada de
 * Modelo de negocios do sistema.
 * (Camada que gerencia o fluxo de dados e os converte em informa��es
 * para serem retornados a camada visual)
 * @author Wagne Borba
 * @date 27/01/2010
 */
class TSetModel {
    private $status = true;
    private $argumento = array();

    /**
     * Metodo main
     * param <type> $regras
     * param <type> $valor
     * param <type> $idCampo
     * return <type>
     */
    
    public function main($regras, $valor, $idCampo) {
        try {
            if ($regras) {
                $vetRegras = explode(';', $regras);
                $this->argumento['campo'] = $idCampo;
                $this->argumento['valor'] = $valor;

                foreach ($vetRegras as $metodo) {

                    $metodoArgs = explode("=>", $metodo);
                    if ($metodoArgs[1]) {
                        $this->argumento['argumento'] = $metodoArgs[1];
                    }
                    $metodoMain = $metodoArgs[0] . "Main";

                    if ($this->argumento !== null and $this->status === true) {
                        $this->argumento = call_user_func(array($this, $metodoMain), $this->argumento);
                    } else {
                        $this->argumento = false;
                        $this->status = false;
                        continue;
                    }
                }

                return $this->argumento;
            } else {
                throw new ErrorException("As regras ou o valor não foram definidas.");
            }
        } catch (Exception $e) {
            new setException($e);
        }
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

    /**
     * Aloca dados no nivel de sessão AlocaDados
     * param $vetor = vetor com valores
     */
    public function setAlocaDadosMain($vetor) {
        try {
            if (is_array($vetor)) {
                $obAlocaDados = new TAlocaDados();
                $obAlocaDados->setValue($vetor['campo'], $vetor['valor']);
            } else {
                throw new ErrorException("O argumento passado não é um vetor válido.");
            }
        } catch (Exception $e) {
            new setException($e);
        }
        return $vetor;
    }

    /**
     * 
     * @param unknown_type $file
     * @param unknown_type $w
     */
    public function viewThumb($file, $w= '300px') {
        $tImg = new TElement('img');
        $tImg->border = 0;
        $tImg->onclick = 'viewThumb(\'' . $file . '\')';
        $tImg->width = $w;
        $tImg->src = $file;
        $tImg->valign = 'center';
        $tImg->class = 'ui-state-default';
        $tImg->style = 'margin: 5px;';

        return $tImg;
    }
	/**
	 * 
	 * @param unknown_type $vetor
	 */
    public function viewThumbMain($vetor) {
        $vetor['valor'] = $this->viewThumb($vetor['valor']);
        return $vetor;
    }

    /**
     * Pega o valor armazenado no AlocaDados e armazena no vetor
     * param <type> $vetor
     * return <type> array
     */
    public function getAlocaDadosMain($vetor) {
        try {
            if (is_array($vetor)) {
                $obAlocaDados = new TAlocaDados();
                $vetor['valor'] = $obAlocaDados->getValue($vetor['argumento']);
            } else {
                throw new ErrorException("O argumento passado não ï¿½ um vetor vï¿½lido.");
            }
        } catch (Exception $e) {
            new setException($e);
        }
        return $vetor;
    }

    /**
     * Monta e retorna um vetor contendo os itens para um campo select
     * param unknown_type $argumento
     */
    public function getItensSel($argumento) {
        try {
            if ($argumento) {

                $principal = explode('/', $argumento);
                $entity = $principal[1];
                $camposeq= $principal[2];
                $label = $principal[3];

                $args = explode(';', $principal[4]);
                $criteria = new TCriteria();

                foreach ($args as $crits) {
                    $dadosArg = explode(',', $crits);
                    $obAlocaDados = new TAlocaDados();
                    $valor = $obAlocaDados->getValue($dadosArg[2]);
                    if (!$valor) {
                        $valor = $dadosArg[2];
                    }
                    $criteria->add(new TFilter($dadosArg[0], $dadosArg[1], $valor));
                }

                $dboItens = new TDbo($entity);
                $retItens = $dboItens->select($camposeq. ',' . $label, $criteria);
                while ($obItens = $retItens->fetchObject()) {
                    $itens[$obItens->$camposeq] = $obItens->$label;
                }

                return $itens;
            } else {
                throw new ErrorException("Os argumentos não foram passados.");
            }
        } catch (Exception $e) {
            new setException($e);
        }
    }

    /**
     *
     */
    public function getItensSelMain($argumento) {
        $itens = $this->getItensSel($argumento);
        return $itens;
    }

    /**
     *
     * param <type> $valor
     * return <type>
     */
    public function setMoney($valor) {
        $valor = round($valor * 100) / 100;
        $valor = str_replace(".", ",", $valor);
        return $valor;
    }

    /**
     *
     * param <type> $vetor
     * return <type>
     */
    public function setMoneyMain($vetor) {
        $vetor['valor'] = $this->setMoney($vetor['valor']);
        return $vetor;
    }

    public function setCpfCnpj($valor) {

        $val = preg_replace('{\D}', '', $valor);
        $model = new TSetModel();
        if (strlen($val) == 11) {
            return $model->setCPF($valor);
        } else {
            return $model->setCNPJ($valor);
        }
    }

    /**
     *
     * param <type> $valor
     * return <type>
     */
    public function setCPF($valor) {
        $valor = sprintf('%011s', preg_replace('{\D}', '', $valor));
        $b1 = substr($valor, 0, 3);
        $b2 = substr($valor, 3, 3);
        $b3 = substr($valor, 6, 3);
        $b4 = substr($valor, 9, 2);
        if ($b1 || $b2 || $b3 || $b4) {
            return "$b1.$b2.$b3-$b4";
        } else {
            return $valor;
        }
    }

    /**
     *
     * param <type> $vetor
     * return <type>
     */
    public function setCPFMain($vetor) {
        $vetor['valor'] = $this->setCPF($vetor['valor']);
        return $vetor;
    }

    public function setCNPJ($valor) {
        $valor = sprintf('%014s', preg_replace('{\D}', '', $valor));
        $b1 = substr($valor, 0, 2);
        $b2 = substr($valor, 2, 3);
        $b3 = substr($valor, 5, 3);
        $b4 = substr($valor, 8, 4);
        $b5 = substr($valor, 12, 2);
        if ($b1 || $b2 || $b3 || $b4 || $b5) {
            return "$b1.$b2.$b3/$b4-$b5";
        } else {
            return $valor;
        }
    }

    /**
     * 
     * @param unknown_type $vetor
     */
    public function setTelefoneMain($vetor) {
        $vetor['valor'] = $this->setTelefone($vetor['valor']);
        return $vetor;
    }
	
    /**
     * Formata o telefone para ser exibido na tela
     * @param $valor
     */
    public function setTelefone($valor) {
        $valor = preg_replace('@[^0-9]@', '', $valor);
        if (strlen($valor) < 8) {
            $count = strlen($valor);
            for ($index = 0; $index < (8 - $count); $index++) {
                $valor = '0' . $valor;
            }
        }
        $valor = substr($valor, (strlen($valor) - 8), 8);

        $b2 = substr($valor, 0, 4);
        $b3 = substr($valor, 4, 4);
        if ($b2 || $b3) {
            return "$b2-$b3";
        } else {
            return $valor;
        }
    }

    /**
     *
     * param <type> $vetor
     * return <type>
     */
    public function setCNPJMain($vetor) {
        $vetor['valor'] = $this->setCNPJ($vetor['valor']);
        return $vetor;
    }

    /**
     * formata valor em um formato monetario com R$
     * param <type> $valor
     * return <type>
     */
    public function setValorMonetario($valor) {
        try {
            $valor = 'R$ ' . number_format($valor, 2, ',', '.');
            return $valor;
        } catch (Exception $e) {
            new setException($e);
        }
    }

    /**
     *
     * param <type> $valor
     * return <type>
     */
    public function setDataPT($valor = null) {
        $valor = $valor ? $valor : date('Y-m-d');
        $dt = explode("-", $valor);
        if ($dt[1]) {
            $data = $dt[2] . "/" . $dt[1] . "/" . $dt[0];
            return $data;
        } else {
            return $valor;
        }
    }

    /**
     *
     * param <type> $vetor
     * return <type>
     */
    public function setDataPTMain($vetor) {
        $vetor['valor'] = $this->setDataPT($vetor['valor']);
        return $vetor;
    }

    /**
     * Retorna a lebel do tipo do tipo de movimento
     * param <type> $tp
     * return <type>
     */
    public function setMovimento($tp) {
        if ($tp == "C") {
            $tp = "Crédito";
        } elseif ($tp == "D") {
            $tp = "Débito";
        }
        return $tp;
    }

    /**
     * Retorna a lebel do tipo do tipo de movimento
     * param <type> $tp
     * return <type>
     */
    public function setStatusMovimento($tp) {
    	$dbo = new TDbo(TConstantes::DBSITUACAO_MOVIMENTO);
    	$ret = $dbo->select('titulo',$tp);
        $tp = $ret->fetchObject();
        
        return $tp->titulo;
    }

    /**
     * Defini os status das contas de uma trasação
     * param <type> $tp
     * return <type>
     */
    public function setStatusConta($tp) {
        if ($tp == "1") {
            $tp = "Em aberto";
        } elseif ($tp == "2") {
            $tp = "Paga";
        } elseif ($tp == "3") {
            $tp = "Parcialmente paga";
        } elseif ($tp == "4") {
            $tp = "Extornada";
        } elseif ($tp == "5") {
            $tp = "Programada";
        } elseif ($tp == "6") {
            $tp = "Negociada";
        }
        return $tp;
    }
    
	/**
	 * 
	 * @param unknown_type $cod
	 */
    public function setCertificacaoDigitial($cod) {
        return 'CD#' . strtoupper(md5($movimentacao . date('Y-m-d'))) . date('Ymd');
    }


}