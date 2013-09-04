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
	 * Executa a baixa de uma parcela paga
	 * @param seq = sequencial da parcela a ser baixada
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
					
					$listaParcelasBaixadas = $this->setParcela($this->headList[TConstantes::LIST_SELECAO], $dados, TConstantes::BAIXA_PARCELA);		
					
				}else{
					    
					$seqErro = TConstantes::ERRO_VALIDACAO;
    				echo $seqErro.'#Nenhuma parcela foi selecionada.';
    				return $seqErro;
				}
				
				return $listaParcelasBaixadas;
				
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
	public function setParcela($parcelas, $dados, $action = TConstantes::BAIXA_PARCELA){
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
						}
					}
					
					//Movimento de caixa
					$obMovimentoCaixa = new MovimentoCaixaBO();
					$listaParcelasBaixadas = $obMovimentoCaixa->setMovimentoCaixa($parcelas, $dados);
					
					$dbo->close();
					
					return $listaParcelasBaixadas;
					
				}
			
			}		
			
		}catch (Exception $e){
			new setException($e);
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
		

}

?>