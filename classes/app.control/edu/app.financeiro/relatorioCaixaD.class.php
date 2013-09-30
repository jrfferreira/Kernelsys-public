<?php
//Relatorio do caixa 
//periodo atual mais os 12 meses anteriores


class relatorioCaixaD{

	public function setParam($param){
		$this->param = $param;
	}

	public function get(){
	
		//Retorna Usuario logado===================================
		$obUser = new TCheckLogin();
		$obUser = $obUser->getUser();
		//=========================================================	
	
		$this->obsession = new TSession();
		
		//TTransaction::close();
		//TTransaction::open($this->obsession->getValue("pathDB"));
		
		//if($conn = TTransaction::get()){////////////////////////////////////////////////////////////////////
		
				//Retorna informações do usuario logado
				$setseq= new TSetControl();
				$idSessao = $setseq->setPass('portaCopo');
				//armazena usuario em sessão
				$this->obUser = $this->obsession->getValue($idSessao);
	
			//Cria elemento fieldset
			$Bloco = new TElement('fieldset');
			$Bloco->id = 'bloc_Periodo';
				$legBloco = new TElement('legend');
				$legBloco->add('Seleção do Periodo');
			$Bloco->add($legBloco);
			
				// campos ================================
				$obFieds = new TSetfields();
				
				$obFieds->geraCampo("Periodo:", 'periodo', "TCombo", '');
				$obFieds->setProperty('periodo', 'id', 'periodo');
				$obFieds->setProperty('periodo', 'setSize', '70');
								
					// itens do campo Periodos =====

                    $sqlProgDs = new TDbo(TConstantes::DBTURMA_DISCIPLINA);
                    $critProgDs = new TCriteria();
                    $critProgDs->add(new TFilter("profseq","=",$this->obUser->seq));
                    $queryProg = $sqlProgDs->select("seq,discseq,profseq", $critProgDs);

					//$sqlProgDs = "select seq,discseq,profseq from DBTURMA_DISCIPLINA where profseq='".$this->obUser->seq."'";
					//$queryProg = $conn->Query($sqlProgDs);
					
					$itensDs[0] = 'Selecione a disciplina';
					while($infoProg = $queryProg->fetchObject()){
                        $sqlItensDs = new TDbo(TConstantes::DBDISCIPLINA);
                        $critItensDs = new TCriteria();
                        $critItensDs->add(new TFilter("seq","=",$infoProg->discseq));
                        $queryDs = $sqlItensDs->select("*", $critItensDs);


						//$sqlItensDs = "select * from dbdisciplinas where seq='".$infoProg->discseq."'";
						//$queryDs = $conn->Query($sqlItensDs);

						$obDs = $queryDs->fetchObject();
											
						$itensDs[$infoProg->discseq.'*'.$infoProg->seq] = $obDs->titulo; 
					}					
					// itens fim ==========
					$itensPeriodo[01] = "01/".date(Y); 
					$itensPeriodo[02] = "02/".date(Y);
					$itensPeriodo[03] = "03/".date(Y);
					$itensPeriodo[04] = "04/".date(Y);
					$itensPeriodo[05] = "05/".date(Y);
					$itensPeriodo[06] = "06/".date(Y);
					$itensPeriodo[07] = "07/".date(Y);
					$itensPeriodo[08] = "08/".date(Y);
					$itensPeriodo[09] = "09/".date(Y);
					$itensPeriodo[10] = "10/".date(Y);
					$itensPeriodo[11] = "11/".date(Y);	
					$itensPeriodo[12] = "12/".date(Y);				
					
				$obFieds->setProperty('periodo', 'addItems', $itensPeriodo);

			// campos fim ============================	
			
			$Bloco->add($obFieds->getConteiner());
			
			
			//================================================
			//Cofigura RELATORIO 
			//================================================
			
				//set Table
				$this->obTableR = new TDataGrid();
			
			
				//Retorna contas de credito
                $sqlContas = new TDbo(TConstantes::DBPLANO_CONTA);
                $critContas = new TCriteria();
                $critContas->add(new TFilter("unidseq","=",$this->obUser->unidade->seq));
				$critContas->add(new TFilter("tipoConta","=","D"));
                $retContas = $sqlContas->select("seq,nomeConta",$critContas);

                //$sqlContas = "select seq,nomeConta from dbcontas where tipoConta='D' and unidade='".$this->obUser->unidade->seq."'";
				//$retContas = $conn->Query($sqlContas);
				
				while($obContas = $retContas->fetchObject()){
					$contas[$obContas->seq]['despesas']  = $obContas->nomeConta;
				}
				
		//gera colunas
		$colR = new TDataGridColumn('despesas', 'despesas', 'center', '100');
		$this->obTableR->addColumn($colR);		
				
		//monta criterios de retorno do caixa
		$mBase = date("n");
		$aBase = date("Y")-1;
		$dataArg = " dataPag like '%0".$mBase.'/'.$aBase."' or ";
		
		for($d = 13; $d>=1; $d--){
		
				if($mBase<10){$dCol = "0".$mBase; }else{ $dCol = $mBase; }
				
				//colunas======================
				$confNome = new TSetData();
				$nomeCol = $confNome->setMes($mBase, '1');
																							
					$col[$mBase] = new TDataGridColumn('mesD'.$dCol."/".$aBase, $nomeCol, 'center', '80');
					$col[$mBase]->setTransformer("setMoeda,setValor");
					$this->obTableR->addColumn($col[$mBase]);
				//=======================================	
								
			if($d > 1){ $op = " or "; }else{ $op = "";}
			
			$dataArg .= " dataPag like '%".$dCol."/".$aBase."'".$op;
			
			if($mBase<12){
				$mBase = $mBase+1;
			}else{
				$mBase = 1;
				$aBase = $aBase+1;
			}
			
		}
								
			// cria modelo da tabela		
			$this->obTableR->createModel('100%');
		//===================================
				
			
			// Retorna informações do caixa  ==========================
                $sqlCaixa = new TDbo(TConstantes::DBCAIXA);
                $critCaixa = new TCriteria();
                $critCaixa->add(new TFilter("tipo","=",'D'));
                $critCaixa->add(new TFilter("unidseq","=",$this->obUser->unidade->seq));
                $retCaixa = $sqlCaixa->select("*",$critCaixa);

				//$sqlCaixa = "select * from dbcaixa where ".$dataArg." and tipo='D' and unidade='".$this->obUser->unidade->seq."' ";
				//$retCaixa = $conn->Query($sqlCaixa);
				
				$colTotal['despesas'] = "Total de Despesas";
				
				while($obCaixa = $retCaixa->fetch()){

						$vetDataPg = explode('/',$obCaixa['dataPag']);
						$periodoCorrente = $vetDataPg[1]."/".$vetDataPg[2];
						
						//calcula despesas
						$colTotal['mes'.$periodoCorrente] = $colTotal['mesD'.$periodoCorrente]+$obCaixa['valorpago'];
		
						//linhas
						$contas[$obCaixa['contaCentro']]['mesD'.$periodoCorrente] = $contas[$obCaixa['contaCentro']]['mesD'.$periodoCorrente]+$obCaixa['valorpago'];
				}
				
				$this->obTableR->addItem($colTotal);
				
				foreach($contas as $k=>$v){
					$this->obTableR->addItem($v);
				}
			//=========================================================	
			
					
			//Cria elemento fieldset
			$Bloco2 = new TElement('fieldset');
			$Bloco2->id = 'bloc_Table';
				$legBloco2 = new TElement('legend');
				$legBloco2->add('Relat�rio');
			$Bloco2->add($legBloco2);
			$Bloco2->add($this->obTableR);
			
			//============================================================
			//Gera Gr�fico de despesas
				include "../app.grafic/classes/libchart.php";
	
				//objeto grafico
				$chart = new VerticalBarChart();
				// objeto barra
				$dataSet = new XYDataSet();
				//add barras
				$mBaseG = date("n");
				$aBaseG = date("Y")-1;
				for($xg = 13; $xg>=1; $xg--){
		
						$colConf = new TSetData();
						$colN = $colConf->setMes($mBaseG, '1');
						
						if($colTotal['mesD0'.$mBaseG."/".$aBaseG] == ""){
							$valG = 0;
						}else{
							$valG = $colTotal['mesD0'.$mBaseG."/".$aBaseG];
						}
					$dataSet->addPoint(new Point($colN, $valG));
					
								if($mBaseG<12){
									$mBaseG = $mBaseG+1;
								}else{
									$mBaseG = 1;
									$aBaseG = $aBaseG+1;
								}
				}
				//add barras no grafico
				$chart->setDataSet($dataSet);
			
				$chart->setTitle("Gr�fico de despesas por periodo");
				$path = "../app.grafic/graficos/despesasCaixa".date("i.s").".png";
				$chart->render($path);
				
				$img = '<img src="'.$path.'" align="middle" border="2" />';
			
			//Cria elemento fieldset
			$Bloco3 = new TElement('fieldset');
			$Bloco3->id = 'bloc_Grafico';
				$legBloco3 = new TElement('legend');
				$legBloco3->add('Gr�fico de despesas');
			$Bloco3->add($legBloco3);
			$Bloco3->add($img);
			//==========================================================================
			
			
						
			//intancia formulario
			$obform = new TElement('form');
			$obform->name = "formRelatorio";
			$obform->method = "POST";
			$obform->action = ""; 
			$obform->style = "margin:0px;";
			$obform->add($Bloco);
			$obform->add($Bloco2);
			$obform->add($Bloco3);
		
		//}//////////////////////////////////////////////////////////////////////////////////////////////////
		//TTransaction::close();
		
		$this->obCont = new TElement('div');
		$this->obCont->add($obform);
		
		return $this->obCont;
	}
}