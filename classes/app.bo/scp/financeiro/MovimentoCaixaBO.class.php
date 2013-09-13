<?php


//Classe que contem os metodos necessarios para
//manipulação do movimento de caixa
//a pagar e a receber
class MovimentoCaixaBO{
	
	
	/**
	 * Atualiza  o movimento de caixa
	 * @param array $dados = dados relacionados a baixa da parcela, Ex: Conta financeira.
	 */
	public function setSaldoMovimento($head, $dados){
		
		$dbo = new TDbo();
		
		$saldoAtualizado = $this->calculaSaldoCaixa($dados['mvcxvlor'], $dados['tpmfseq']);
		$mcaixa['mvcxsdcx'] = $saldoAtualizado; //Saldo atual do caixa recalculado a cada movimento
		
			
		//gera movimento de caixa para cada parcela baixada
		$dbo->setEntidade(TConstantes::DBMOVIMENTOCAIXA);
			$criteriaSM = new TCriteria();
			$criteriaSM->add(new TFilter('seq','=', $head[TConstantes::SEQUENCIAL], 'numeric'));
		$retmovimento = $dbo->update($mcaixa,$criteriaSM);
			
		
		//Atualiza o saldo da conta financeira de acordo com o movimento
		$saldoContaFinanceira['ctfnsdcf'] = $this->calculaSaldoContaFinanceira($dados['ctfnseq'], $dados['mvcxvlor'], $dados['tpmfseq']);
		$dbo->setEntidade(TConstantes::DBCONTAFINANCEIRA);
			$criteriaCF = new TCriteria();
			$criteriaCF->add(new TFilter('seq', '=', $dados['ctfnseq'], 'numeric'));
			$criteriaCF->add(new TFilter('statseq', '!=', '3', 'numeric'));
		$retContaFinanceira = $dbo->update($saldoContaFinanceira, $criteriaCF);
			
			
		if(!$retmovimento and !$retContaFinanceira){
			exit('O saldo do movimento de caixa não pode ser atualizado.');
		}
			
		$dbo->close();
		
	}
	
	
	/**
	 * Gera o movimento de caixa para cada parcela de um documento baixada
	 * @param array $parcelas = lista de parcelas a serem baixadas
	 * @param array $dados = dados relacionados a baixa da parcela, Ex: Conta financeira.
	 */
	public function setMovimentoCaixa($parcelas, $dados){
				
		$documentoBO = new DocumentoBO();
		
		//retorna dados das parcelas
		$parcelas = $documentoBO->getParcela($parcelas);		
		
		//Instancia janela de retorno das parcelas baixadas
		$listaParcelasBaixadas = new TElement('div');//TWindow('Baixa de documentos');
		$listaParcelasBaixadas->id = 'dialogcaixa';
		$listaParcelasBaixadas->class = 'TWindow';
			$titulo = new TElement('div');
			$titulo->id='ui-dialog-title-dialogcaixa';
		$listaParcelasBaixadas->add($titulo);
		//$listaParcelasBaixadas->setAutoOpen(true);
		//$listaParcelasBaixadas->setSize('400px','300px');
		
		$dbo = new TDbo();
		foreach ($parcelas as $seqPar=>$parcela){
			
			$documento = $documentoBO->getDocumento($parcela->dcprseq, false);
			
			//Retorno o saldo do caixa atualizado
			$saldoAtualizado = $this->calculaSaldoCaixa($parcela->dcpcvlpc, $documento->tpmfseq);
		
			$mcaixa['mvcxdoct'] = $documento->dcprdcid;// Documento
			$mcaixa['mvcxdesc'] = $documento->dcprdesc;// Descrição do documento movimento
			$mcaixa['mvcxdtdc'] = $documento->dcprdtdc;// Data do documento movimentado
			$mcaixa['mvcxobse'] = $documento->dcprobse;// Observações sobre o movimento
			$mcaixa['mvcxdtcx'] = $dados['dcprdtbx'];// Data do caixa
			$mcaixa['mvcxvlor'] = $parcela->dcpcvlpc;// Valor pago/recebido no movimento
			$mcaixa['mvcxrefe'] = $parcela->dcpcdtrf;// data de Referencia
			$mcaixa['pessseq'] = $documento->pessseq;// Sequencial que identifica a pessoa
			$mcaixa['depeseq'] = $parcela->depeseq;// Sequencial que identifica o departamento
			$mcaixa['plctseq'] = $parcela->plctseq;// Sequencial do plano de contas
			$mcaixa['ctfnseq'] = $dados['ctfnseq'];// Sequencial que identifica a conta financeira
			$mcaixa['tpmfseq'] = $documento->tpmfseq;// Sequencial que identifica o tipo movimento financeiro
			$mcaixa['dcstseq'] = 1;// Sequencial que identifica a situação do movimento/documento
			$mcaixa['mvcxsdcx'] = $saldoAtualizado; //Saldo atual do caixa recalculado a cada movimento 
			$mcaixa['datacad'] = date('Y-m-d');// Data de cadastro do registro
			$mcaixa['statseq'] = 1;// Sequencial que identifica o Status do registro
			
			
			//gera movimento de caixa para cada parcela baixada
			$dbo->setEntidade(TConstantes::DBMOVIMENTOCAIXA);
			$retmovimento = $dbo->insert($mcaixa);
			
			//Atualiza o saldo da conta financeira de acordo com o movimento
			$saldoContaFinanceira['ctfnsdcf'] = $this->calculaSaldoContaFinanceira($dados['ctfnseq'], $parcela->dcpcvlpc, $documento->tpmfseq);
			$dbo->setEntidade(TConstantes::DBCONTAFINANCEIRA);
				$criteriaCF = new TCriteria();
				$criteriaCF->add(new TFilter('seq', '=', $dados['ctfnseq'], 'numeric'));
				$criteriaCF->add(new TFilter('statseq', '!=', '3', 'numeric'));
			$retContaFinanceira = $dbo->update($saldoContaFinanceira, $criteriaCF);
			
			
			if($retmovimento and $retContaFinanceira){
				
				$box = new TElement('div');
				$box->class = 'ui-state-highlight';
				$box->add('Parcela '.$parcela->dcpcnmpc.' - Documento '.$documento->dcprdcid.' Baixada com sucesso.');
				$listaParcelasBaixadas->add($box);
				
			}else{
				
				$box = new TElement('div');
				$box->add('ERRO - Parcela '.$parcela->dcpcnmpc.' - Documento '.$documento->dcprdcid.' não foi baixada. O processo foi intenrrompido.');
				$box->class = 'ui-state-error';
				
				$listaParcelasBaixadas->add($box);
				$listaParcelasBaixadas->show();
				exit();
			}
			
			$dbo->close();
		
		}
		
		return $listaParcelasBaixadas;
	
	}
	
	/**
	 * Calcula o valor do saldo atual do caixa no momento do registro 
	 * do movimento e armazena na o saldo atual no ultimo registro
	 * @param numeric $valorMovimento = valor do movimento que será calculado ao saldo atual
	 * @param numeric $tipoMovimento = tipo do movimento, crédito ou débito
	 */
	public function calculaSaldoCaixa($valorMovimento, $tipoMovimento){
		try{
			
			$dbo = new TDbo();
			
			if($valorMovimento and $tipoMovimento){
				
				$dbo->setEntidade(TConstantes::DBMOVIMENTOCAIXA);
					$criteriaMC = new TCriteria();
					$criteriaMC->add(new TFilter('statseq', '!=', '3', 'numeric'));
					$criteriaMC->add(new TFilter('mvcxsdcx', '>', 0.00, 'numeric'));
					$criteriaMC->setProperty('order', 'seq DESC');
					$criteriaMC->setProperty('limit', 1);
				$retMovimento = $dbo->select('mvcxsdcx', $criteriaMC);
				
				$obMovimento = $retMovimento->fetchObject();
				
				//calcula novo saldo do caixa
				if($tipoMovimento == 1){
					$saldo = $obMovimento->mvcxsdcx + $valorMovimento;
				}else if($tipoMovimento == 2){
					$saldo = $obMovimento->mvcxsdcx - $valorMovimento;
				}
				
				return $saldo;
				
			}
		
		}catch (Exception $e){
			new setException($e);
		}
	}
	
	/**
	 * Calcula o valor do saldo atual da cointa financeira
	 * do movimento e armazena na o saldo atual no ultimo registro
	 * @param seq $contaFinanceira = Sequencial que representa a conta financeira
	 * @param numeric $valorMovimento = valor do movimento que será calculado ao saldo atual
	 * @param seq $tipoMovimento = tipo do movimento, crédito ou débito
	 */
	public function calculaSaldoContaFinanceira($contaFinanceira, $valorMovimento, $tipoMovimento){
		
		try{
				
			$dbo = new TDbo();
				
			if($valorMovimento and $tipoMovimento){
		
				$dbo->setEntidade(TConstantes::DBCONTAFINANCEIRA);
					$criteriaCF = new TCriteria();
					$criteriaCF->add(new TFilter('seq', '=', $contaFinanceira));
					$criteriaCF->add(new TFilter('statseq', '!=', '3'));
				$retContaFinanceira = $dbo->select('ctfnsdcf', $criteriaCF);
		
				$obContaFinanceira = $retContaFinanceira->fetchObject();
		
				//calcula novo saldo do caixa
				if($tipoMovimento == 1){
					$saldo = $obContaFinanceira->ctfnsdcf + $valorMovimento;
				}else if($tipoMovimento == 2){
					$saldo = $obContaFinanceira->ctfnsdcf - $valorMovimento;
				}
		
				return $saldo;
		
			}
		
		}catch (Exception $e){
			new setException($e);
		}
		
	}
	
	
	
}

?>