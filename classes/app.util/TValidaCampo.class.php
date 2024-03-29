<?php

class TValidaCampo{

	public function __construct($conn){
		if($conn){
			$this->conn = $conn;
		}
		else{
			echo 'erro na conex�o';
			exit();
		}
	}

	public function valDuplic($table, $cols, $args, $op = NULL){
			
	
		if(is_array($cols)){
			if(is_array($args)){
			
				if(!$op){ $op = "AND";	}
			
				$i = 0;
				foreach($cols as $col){
					$conds .= $col."='".$args[$i]."' ".$op." ";
					$i++;
				}
				
				$conds = rtrim($conds, "$op ");
			}else{
				echo "Ouve uma incoerencia entre as colunas e seu argumentos, Ambos devem ser representados pelo mesmo padr�o. ex: array=>array";
				exit();
			}
		}
		else{
			$conds = $cols."='".$args."'";
		}
		
		$sqlDup = "select seq from ".$table." where ".$conds;
		$run = $this->conn->Query($sqlDup);
		$obVal = $run->fetchObject();
		
		if($obVal->seq != "" and $obVal->seq){
			$retorno[0] = 1; // caso haja o registro
			$retorno[1] = $obVal->seq;
		}
		else{
			$retorno[0] = 0;
		}
		
		return $retorno;


    //==================================================================================
    // Aplica validação nos campos submetidos
    if($dados['validacao'] != "" and !$statusEdition) {

        $obValida = new TValidaCampo($conn);

        // valida duplicação
        if(strpos($dados['validacao'], "VD") !== false) {

            $teste = $obValida->valDuplic($dados['entity'], $campo, $valor);

            if($teste[0] == "1") {
                echo '<img src="../app.view/app.images/iscaImg.png" onload="retValidacao(\''.$dados[TConstantes::SEQUENCIAL].'\', \''.$teste[1].'\', \''.$iformseq.'\', \''.$dados['entity'].'\')" />';
            }
            $obsession->setValue(TConstantes::STATUS_EDITIONFORM, $campo);
        }

        // Valida campo vazio
        if(strpos($dados['validacao'], "VN")) {

            $teste2 = $obValida->valDuplic($dados['entity'], $campo, $valor);

            if($teste2[0] == "1") {
                echo '<img src="../app.view/app.images/iscaImg.png" onload="retValidacao(\''.$dados[TConstantes::SEQUENCIAL].'\', \''.$teste2[1].'\', \''.$iformseq.'\', \''.$dados['entity'].'\')" />';
            }
        }
    }
    //==================================================================================
	
	}

}