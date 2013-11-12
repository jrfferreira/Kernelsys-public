<?php

//Classe que contem os metodos necessarios para 
//manipulação de documentos 
//a pagar e a receber
class DocumentoBO{
	
	/**
	 * Retorna o documento e suas parcelas
	 * @param int $documento = sequencial que identifica o documento
	 * @param bool $parcelas = define se o ducumento retornará as parcelas
	 */
	public function getDocumento($documento, $parcelas = true){
		try{
			if($documento){
	
				$dbo = new TDbo();
	
				$dbo->setEntidade(TConstantes::DBDOCUMENTOPAGARRECEBER);
				$criteriaDoc = new TCriteria();
				$criteriaDoc->add(new TFilter('seq', '=', $documento,'numeric'));
				$retDocumento = $dbo->select('*',$criteriaDoc);
	
				$obDocumento = $retDocumento->fetchObject();
	
				if($parcelas){
					//retorna parcelas do documento
					$dbo->setEntidade(TConstantes::DBDOCUMENTOPARCELA);
					$criteriaPar = new TCriteria();
					$criteriaPar->add(new TFilter('dcprseq', '=',$documento, 'numeric'));
					$retParcela = $dbo->select('*',$criteriaPar);
						
					while($parcela = $retParcela->fetchObject()){
						$obDocumento->parcelas[] = $parcela;
					}
				}
					
				return $obDocumento;
			}
		}catch (Exception $e){
			new setException($e);
		}
	}
	
	/**
	 * Altera o situação do documento em questão para concluido quando 
	 * todas as parcelas do documento forem baixadas
	 * @param array $head = Cabeçalho do formuario em questão
	 * @param array $dados = dados do furmulario em questão
	 */
	private function setSituacaoDocumento($parcela){
		
		if($parcela){
			
			$dbo = new TDbo();
			
			//retorna o numerodo do documento da parcela em questão
			$dbo->setEntidade(TConstantes::DBDOCUMENTOPARCELA);
				$critPar = new TCriteria();
				$critPar->add(new TFilter(TConstantes::SEQUENCIAL, '=', $parcela,'numeric'));
				$retPar = $dbo->select('dcprseq',$critPar);
			$parcela = $retPar->fetchObject();
			$documento = $parcela->dcprseq;
			
			$dbo->setEntidade(TConstantes::DBDOCUMENTOPARCELA);
				$criteriaPar = new TCriteria();
				$criteriaPar->add(new TFilter('dcprseq', '=', $documento,'numeric'));
				$criteriaPar->add(new TFilter('stpcseq', '=', 1,'numeric'), 'or');	
				$criteriaPar->add(new TFilter('stpcseq', '=', 3,'numeric'), 'or');
			$retParcelas = $dbo->select('*',$criteriaPar);
			$parcelas = $retParcelas->fetchObject();
			
			if(!$parcelas){
				
				$dadoDoc['dcstseq'] = 2;
				
				$dbo->setEntidade(TConstantes::DBDOCUMENTOPAGARRECEBER);
					$criteriaDoc = new TCriteria();
					$criteriaDoc->add(new TFilter(TConstantes::SEQUENCIAL, '=', $documento,'numeric'));
					$retDocumento = $dbo->update($dadoDoc,$criteriaDoc);
					
			}
			
		//	$dbo->close();
			
		}
		
	}
	
	/**
	 * Executa a baixa de uma parcela paga
	 * @param $head = head do formulario em questão
	 */
	public function baixaParcela($head, $dados = null){
		try {
			
			if($head){
				
				$obHead = new TSetHeader();
				$this->headList = $obHead->getHead(key($head[TConstantes::HEAD_HEADCHILDS]));
				
				//Valinda parcela selecionada
				if(count($this->headList[TConstantes::LIST_SELECAO]) > 0){
					
					// Valinda conta financeira
					if($dados and !$dados['ctfnseq']){
						
						$seqErro = TConstantes::ERRO_VALIDACAO;
						echo $seqErro.'#Nenhuma Conta Financeira foi selecionada.';
						return $seqErro;
					}
					
					$windowResp = $this->setParcela($this->headList[TConstantes::LIST_SELECAO], $dados, TConstantes::BAIXA_PARCELA);		
					
				}else{
					    
					$seqErro = TConstantes::ERRO_VALIDACAO;
    				echo $seqErro.'#Nenhuma parcela foi selecionada.';
    				return $seqErro;
				}
				
				return $windowResp;
				
			}
			
		}catch (Exception $e){
			new setException($e);
		}
		
		
	}
	
	/**
	 * Executa ações predefinidas nas parcelas
	 * @param array $parcelas = vetor de sequenciais das parcelas
	 * @param string $action = baixa/extorno/cancelar
	 */
	private function setParcela($parcelas, $dados, $action = TConstantes::BAIXA_PARCELA){
		try{
			
			if($parcelas){
				
				//Altera a situação da parcela para baixada
				if($action == TConstantes::BAIXA_PARCELA){
					
					$situacaoParcela['stpcseq'] = 2;		
					$dbo = new TDbo();
									
					foreach ($parcelas as $k=>$parcela){
						
						//altera situação da parcela para baixada
						$dbo->setEntidade($this->headList[TConstantes::ENTIDADE]);
							$criteriaPc = new TCriteria();
							$criteriaPc->add(new TFilter('seq','=',$parcela, 'numeric'));
							$criteriaPc->add(new TFilter('stpcseq','=',1, 'numeric'));
						$retParcela = $dbo->update($situacaoParcela, $criteriaPc);
						
						if(!$retParcela){
							exit('Parcelas não pode ser baixada.');
						}else{
							
							//verifica situação das parcelas para atualizar situação do documento
							$this->setSituacaoDocumento($parcela);
						}
					}
					
					//Movimento de caixa
					$obMovimentoCaixa = new MovimentoCaixaBO();
					$windowResp = $obMovimentoCaixa->setMovimentoCaixa($parcelas, $dados);
					
					$dbo->close();
					
					return $windowResp;
					
				}
			
			}		
			
		}catch (Exception $e){
			new setException($e);
		}
	}
	
	/**
	 * Valida a edição de parcelas com situação diferente de ABERTA
	 * @param array $head = Cabeçalho do formuario em questão
	 * @param array $dados = dados do furmulario em questão
	 */
	public function validaEdicaoParcela($head, $dados){
		
		if($dados["stpcseq"] != 1){
			$seqErro = TConstantes::ERRO_VALIDACAO;
			echo $seqErro.'#A parcela não pode ser alterada. Só é possivel alterar uma parcela em aberto.';
			return $seqErro;
		}
		
	}
	
	/**
	 * Retorna uma parcela ou uma lista definda de parcelas
	 * @param unknown $parcela
	 */
	public function getParcela($parcela){
	try{
		
		$dbo = new TDbo();
		$dbo->setEntidade(TConstantes::DBDOCUMENTOPARCELA);
		$criteriaPar = new TCriteria();
		
		if(is_array($parcela)){
						
			//retorna dados das parcelas
			foreach ($parcela as $seqParcela){
				$criteriaPar->add(new TFilter('seq','=',$seqParcela, 'numeric'), "OR");
			}
			$retParcelas = $dbo->select('*', $criteriaPar);
			
			while($par = $retParcelas->fetchObject()){
				$parcela[$par->seq] = $par;
			}
		}else{
			

			$criteriaPar->add(new TFilter('seq','=',$parcela, 'numeric'));
			$retParcela = $dbo->select('*', $criteriaPar);
			$parcela = $retParcela->fetchObject();
			
		}

		return $parcela;
		
	}catch (Exception $e){
			new setException($e);
		}
	}
		

	/**
	 * Replica parcelas em sequência de acordo com referencia lançada
	 * @param array $head = Cabeçalho do formuario em questão
	 * @param array $dados = dados do furmulario em questão
	 */
	public function replicaParcela($head, $dados){
		
		$obData = new TSetData();
		$param['method'] = 'onSave';
		$param['tipoRetorno'] = 'form';
		$param['formseq'] = 163;
		$param['typeRun'] = 'multiple';
		
		$obHeader = new TSetHeader();
		$obHeader->addHeader(163,TConstantes::HEAD_OUTCONTROL,0);
		
		for($i = 1;$dados['dcpcrpqt']>$i;$i++){
			
			$dadoAtual = $dados;
			
			$dadoAtual['dcpcnmpc'] += 1;
			$dadoAtual['dcpcdtvc'] = $obData->calcData($obData->dataPadrao($dadoAtual['dcpcdtvc']), 30, '-');
			
			$_POST = $dadoAtual;
			
			$obMain = new TMain('onSave', $param);	
			
		}	
	}
		

}

?>