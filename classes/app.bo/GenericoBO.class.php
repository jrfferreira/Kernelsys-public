<?php
/*
 * Implementa as regras de negócio de uso genérico a todos 
 * os casos de uso e interfaces necessárioas.
 * Autor: Wagner Borba
 * Dsta: 19/05/2013
 */
class GenericoBO {
	
	protected $obDbo = null; 
	
	public function __construct(){
		
		$this->obDbo = new TDbo();
		
	}
	
	/**
	 * Implementa o método para retornar a lista de 
	 * filhos do node passado como paramentro
	 * 
	 */
	protected function getChilds($entidade, $seq, $colunafk){
		try{		
				//carrega os filhos do relacionamento se existir
				$this->obDbo->setEntidade($entidade);
					$obCriteriaPai = new TCriteria();
					$obCriteriaPai->add(new TFilter($colunafk, '=', $seq));
				$retorno = $this->obDbo->select(TConstantes::SEQUENCIAL, $obCriteriaPai);
				
			    while($regs = $retorno->fetchObject()){
                	
			    	$childs[$regs->seq] = $regs;
            	}
            	
            	if(count($childs) > 0){
            		
            		foreach($childs as $sq => $ob){
            			
            			$cchilds = $this->getChilds($entidade, $sq, $colunafk);
            			
            		}
            		
            		$registros = array_merge($childs, $cchilds);
            	}
            	
            	$registros = $childs;
            	
		}catch (Exception $e){
            new setException($e);
        }
        return $registros;
	}

	
	/**
	 * Implementa a regra para alteração de status em cascata
	 * em todos os filhos do objeto passado como parametro.
	 * @param object $obj = instancia do objeto ou array do campo status
	 * @param String $colunafk = Campo que representa a chave strangeira do auto relacionamento
	 */
	public function statusCascading($obj, $colunafk){
		try{
			if(!$obj){
				
				$entidade = $obj[TConstantes::ENTIDADE];
				$seq      = $obj[TConstantes::SEQUENCIAL];
				
				
				$nodes = $this->getChilds($entidade, $seq, $colunafk);
				
				//if(count($nodes) > 0){
				
				//	while($nodes){
						
						
						
				//	}
				//}
				
				
				//carrega os filhos do relacionamento se existir
				$this->obDbo->setEntidade($entidade);
					$obCriteriaPai = new TCriteria();
					$obCriteriaPai->add(new TFilter('depepai', '=', $seq));
				$retorno = $this->obDbo->select(TConstantes::SEQUENCIAL, $obCriteriaPai);
				
			    while($regs = $retorno->fetchObject()){
                	
			    	
			    	
            	}
				
			}else{
				throw new Exception('O parametro enviado para o método statusConcading é inválido');
			}			
	    }catch (Exception $e){
            new setException($e);
        }
		
	}
	
	
}

?>