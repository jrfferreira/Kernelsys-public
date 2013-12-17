<?php
/**
 * 
 * @author Wagner
 *
 */	

function __autoload($classe) {
    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}

Class TFix{
	
	private $obdbo;
	protected $vetorForm = array();
	
	public function __construct($exe = false){
		
		$valida = $exe;
		
		if($valida!='true'){
			exit();
		}
		
		$this->obdbo = new TDbo();
		
	}	
	
 	public function redefineUsuarios() {
 		
 		$this->obdbo->setEntidade(TConstantes::DBUSUARIO);
        	$critusuario = new TCriteria();
        	$critusuario->add(new TFilter("usuario", "!=", "pauhique"));
        	$critusuario->add(new TFilter("usuario", "!=", "user"));
        	$critusuario->add(new TFilter("usuario", "!=", "admin.educacional"));
        $usuarioretorno = $this->obdbo->select("seq,seqpessoa",$critusuario);
        
        
        while($user = $usuarioretorno->fetchObject()){
        	
        	 	$this->obdbo->setEntidade(TConstantes::DBPESSOA);
			        $critpessoa = new TCriteria();
			        $critpessoa->add(new TFilter("seq", "=", $user->seqpessoa));
		        $pessoaretorno = $this->obdbo->select("seq,pessnmrf",$critpessoa);
		        
		        $obpessoa = $pessoaretorno->fetchObject();
		        
		        if($obpessoa->pessnmrf){
		       
	        		$this->obdbo->setEntidade(TConstantes::DBUSUARIO);
	        			$dados['usuario'] = str_replace('-','',str_replace('.','',$obpessoa->pessnmrf));
	        			$critsetusuario = new TCriteria();
	        			$critsetusuario->add(new TFilter("seq", "=", $user->seq));
	        		$usuarioresultado = $this->obdbo->update($dados, $critsetusuario);
	        		
	        		if($usuarioresultado){
	        			echo $user->seq.' -> ok <br>';
	        		}else{
	        			echo $user->seq.' -> ERRO <br>';
	        			
	        			//deleta o usuario duplicado
		        		$this->obdbo->setEntidade(TConstantes::DBUSUARIO);
		        		$usuarioresultado = $this->obdbo->delete($user->seq);
	        			
	        		}
		        }	
		        else{
		        	echo 'CPF não encontrado. <br>';
		        }
        	
        }
    }
	
    /*
     * Mapea o formulário em questão
     */
    public function mapeaFormulario($formseq){
    	
    	
    	//Arquivo de conexão
    	$dbok = new TDbo_kernelsys();    	
    	
    	$dbok->setEntidade('forms');
	      	$criteriaform = new TCriteria();
	      	$criteriaform->add(new TFilter("seq", "=", $formseq));
	    $resultform = $dbok->select('*',$criteriaform);
	   
	    $obform = $resultform->fetchObject();
	    
	    $this->vetorForm['forms'] = $obform;

	   
	   //dados do formulario
	   echo '-----------------------------------------------<br>';
	   echo $obform->nomeform;
	   echo ' - ';
	   echo $obform->seq;
	   echo '<br>--------------------------------------------<br>';
	   
	   
	   // Retorna Abas
	   $dbok->setEntidade('form_x_abas');
	      	$criteriaformabas = new TCriteria();
	      	$criteriaformabas->add(new TFilter("formseq", "=", $formseq));
	    $resultformabas = $dbok->select('*',$criteriaformabas);
	   	    
	    while($obformabas = $resultformabas->fetchObject()){
	    	
	    	$this->vetorForm['form_x_abas'][] = $obformabas;
	    	
	    	//echo '- Aba - ';
		    $dbok->setEntidade('abas');
		      	$criteriaabas = new TCriteria();
		      	$criteriaabas->add(new TFilter("seq", "=", $obformabas->abaseq));
		    $resultabas = $dbok->select('*',$criteriaabas);
		    $obabas = $resultabas->fetchObject();
		    
		   // echo  '- '.$obabas->nomeaba.'<br>';
		    
		    $this->vetorForm['abas'][$obabas->seq] = $obabas;
		    
		    	//mostra os Blocos
		    	$dbok->setEntidade('blocos_x_abas');
	      			$criteriaabasblocos = new TCriteria();
	      			$criteriaabasblocos->add(new TFilter("abaseq", "=", $obabas->seq));
	    		$resultabasblocos = $dbok->select('*',$criteriaabasblocos);
	    
	    		//echo '--- Blocos <br>';
	    	    while($obabasblocos = $resultabasblocos->fetchObject()){
	    	    	
	    	    	$this->vetorForm['blocos_x_abas'][] = $obabasblocos;
	    	
				    $dbok->setEntidade('blocos');
				      	$criteriablocos = new TCriteria();
				      	$criteriablocos->add(new TFilter("seq", "=", $obabasblocos->blocseq));
				    $resultblocos = $dbok->select('*',$criteriablocos);
				    $obblocos = $resultblocos->fetchObject();
				    
				    //echo  '------  '.$obblocos->nomebloco.'<br>';	

				    $this->vetorForm['blocos'][$obblocos->seq] = $obblocos;
				    
				    		//mostra os Campos
					    	$dbok->setEntidade('campos_x_blocos');
				      			$criteriablocoscampos = new TCriteria();
				      			$criteriablocoscampos->add(new TFilter("blocseq", "=", $obblocos->seq));
				    		$resultblocoscampos = $dbok->select('*',$criteriablocoscampos);
				    	
	    					//echo '--------- Campos  <br>';
				    	    while($blocoscampos = $resultblocoscampos->fetchObject()){
				    	    	
				    	    	$this->vetorForm['campos_x_blocos'][] = $blocoscampos;
				    	
							    $dbok->setEntidade('campos');
							      	$criteriacampos = new TCriteria();
							      	$criteriacampos->add(new TFilter("seq", "=", $blocoscampos->campseq));
							    $resultcampos = $dbok->select('*',$criteriacampos);
							    $obcampos = $resultcampos->fetchObject();
							    
							     //echo  '-----------  '.$obcampos->campo.' = '.$obcampos->label.'<br>';
							     
							     $this->vetorForm['campos'][$obcampos->seq] = $obcampos;
							     
							     //Propriedades dos campos
							     $dbok->setEntidade('campos_x_propriedades');
							      	$criteriacamposprop = new TCriteria();
							      	$criteriacamposprop->add(new TFilter("campseq", "=", $obcampos->seq));
							     $resultcamposprop = $dbok->select('*',$criteriacamposprop);
							     
							     while($camposprop = $resultcamposprop->fetchObject()){
							     	
							     		//echo '*********************** '.$camposprop->metodo.'<br>';

							     		$this->vetorForm['campos_x_propriedades'][$camposprop->seq] = $camposprop; 
							     }
							     
				    	    }
	    		}
	    	
	    }
	    
	    
	    ////////////////////////////
	    // Listas do formulario
	    
	    $dbok->setEntidade('lista');
	      	$criterialistaform = new TCriteria();
	      	$criterialistaform->add(new TFilter("formseq", "=", $formseq));
	    $resultlistaform = $dbok->select('*',$criterialistaform);
	    
	   	$oblistaform = $resultlistaform->fetchObject();

		   //dados da Lista
		  // echo '<br><br>-----------------------------------------------<br>Lista = ';
		  // echo $oblistaform->label;
		  // echo ' - ';
		  // echo $oblistaform->seq;
		   //echo '<br>--------------------------------------------<br>';
		   
		   $this->vetorForm['lista'][] = $oblistaform;
		   
		   
		$dbok->setEntidade('coluna');
	      	$criterialistacolunas = new TCriteria();
	      	$criterialistacolunas->add(new TFilter("listseq", "=", $oblistaform->seq));
	    $resultlistacolunas = $dbok->select('*',$criterialistacolunas);
	    
	   //echo '---Colunas - <br>';
	    while($listacolunas = $resultlistacolunas->fetchObject()){
	    	
	    	///echo '------ '.$listacolunas->label.'<br>';
	    	
	    	$this->vetorForm['coluna'][] = $listacolunas;
	    }
	    
	    
	   // print_r($this->vetorForm);
	    
	    return $this->vetorForm;
	    	
    }
    
    /**
     * Exluir o formulario de todos os suas ramificações
     * @param unknown_type $formseq
     */
    private function excluiFormulario($formseq){
    	
    	
    	$form = $this->mapeaFormulario($formseq);
    	
    	//obj de conexão
    	$dbok = new TDbo_kernelsys();     	
    	
    	foreach($form as $key => $ob){
    		
			if(!is_array($ob)){
	    		$dbok->setEntidade($key);		      	
		    	$result = $dbok->delete($ob->seq, 'seq');
		    
		    	echo '<br>Excluindo... '.$key.' ID = '.$ob->seq;
			}else{
				
				foreach($ob as $k2 => $ob2){
					
					$dbok->setEntidade($key);		      	
		    		$result = $dbok->delete($ob2->seq, 'seq');
		    
		    		echo '<br>Excluindo... '.$key.' ID = '.$ob2->seq;
				}
				
				
			}
    		
    	}
    		
    		//deleta o menu do modulo
    		$dbok->setEntidade('menu');		      	
			$result = $dbok->delete($formseq, 'form');
    	
    	$dbok->close();
    	echo '<br>-------------------------------------------<br>pronto';
    	
    }
    
    /**
     * Executa o medoto privado excluir formulário para confirmar a ação
     */
    public function executaExcluir($formseq, $conf){
    	
    	if($conf === true){
    		$this->excluiFormulario($formseq);
    	}else{
    		echo 'é necessário confirmar a ação';
    		
    	}
    }
    
}