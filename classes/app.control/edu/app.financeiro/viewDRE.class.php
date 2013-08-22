<?php
			
function __autoload($classe){

    include_once('../../app.util/autoload.class.php');
    $autoload = new autoload('../../',$classe);
}

// codifica a forma de saidad dos dados no header (tratando caracteres especiais) \\
			//header("Content-Type: text/html; charset=UTF-8",true);
			
	//Retorna Usuario logado===================================
	$obUser = new TCheckLogin();
	$obUser = $obUser->getUser();
	//=========================================================	

	//TTransaction::close();
	
		//TTransaction::open('../app.config/my_dbpetrus');

			
		//if($conn = TTransaction::get()){
							
			$data1 = $_POST['dt1'];
			$data2 = $_POST['dt2'];			
			$obdata = new TSetData();
			$vetIntervalo = $obdata->setIntervalo($data1,$data2);
			
			//retorna porcentagem
			function porcentagem ($total, $parcial){
				if($total != "" and $parcial != ""){
					$porce = ($parcial * 100) / $total;
					$porcent  = number_format($porce, 2, ',', '.').'%';
					return $porcent;
				}
				else{
					return 0;
				}
			}
			
			// gera SQL
            $critCaixa = new TCriteria();
			foreach($vetIntervalo as $dt){
                if($dt == end($vetIntervalo)){
                $critCaixa->add(new TFilter("dataPag","=",$dt));
                }else{
                $critCaixa->add(new TFilter("dataPag","=",$dt),"or");
                }
            }
						

            $sqlContas = new TDbo(TConstantes::DBPLANO_CONTA);
            $contasQuery = $sqlContas->select("seq,nomeConta,tipoConta,tipoCusto");

            //$sqlContas = "SELECT seq,nomeConta,tipoConta,tipoCusto FROM dbtransacoes_contas";
			//$contasQuery = $conn->Query($sqlContas);
			
				
			while ($obContas = $contasQuery->fetchObject()){
			$vetCtNome[$obContas->seq] = $obContas->nomeConta;
			$vetCtTipo[$obContas->seq] = $obContas->tipoConta;
			$vetCtCusto[$obContas->seq] = $obContas->tipoCusto;
			$vetContas[$obContas->seq] = 0;
			}	
            $sqlCaixa = new TDbo(TConstantes::DBCAIXA);
            $caixaQuery = $sqlCaixa->select("seqconta,valorpago,tipomovimentacao,datacad,dataPag",$critCaixa);

			//$sqlCaixa = "SELECT seqconta,valorpago,tipomovimentacao,datacad,dataPag FROM dbcaixa where ".$sqlData;
			//$caixaQuery = $conn->Query($sqlCaixa);
				
				while($obCaixa = $caixaQuery->fetchObject()){
					
						$vetContas[$obCaixa->seqconta] = $vetContas[$obCaixa->seqconta] + $obCaixa->valorpago;
							
						if ($obCaixa->tipomovimentacao == "C" and $obCaixa->datacad == $obCaixa->dataPag){							
								$valorReceitaAVistaTotal = $valorReceitaAVistaTotal + $obCaixa->valorpago;								
						}
						elseif ($obCaixa->tipomovimentacao == "C" and $obCaixa->dataPag != $obCaixa->datacad){							
								$valorReceitaAPrazoTotal = $valorReceitaAPrazoTotal + $obCaixa->valorpago;								
						}
													
				}
					
				$valorReceitaTotal = $valorReceitaAVistaTotal + $valorReceitaAPrazoTotal;
				
			$valorReceitaTotalV = 'R$ '.number_format($valorReceitaTotal, 2, ',', '.');
			$valorReceitaAVistaTotalV = 'R$ '.number_format($valorReceitaAVistaTotal, 2, ',', '.');
			$valorReceitaAPrazoTotalV = 'R$ '.number_format($valorReceitaAPrazoTotal, 2, ',', '.');


			
					
		foreach($vetContas as $ch_ => $v_){
			
					
					if($vetCtCusto[$ch_] != "Fixo" and $vetCtTipo[$ch_] == "D"){
						
						$valorDespVarTotal = $valorDespVarTotal + $v_;
						
					}
					elseif($vetCtCusto[$ch_] == "Fixo" and $vetCtTipo[$ch_] == "D"){
						
						$valorDespFixoTotal = $valorDespFixoTotal + $v_;
						
					}
		}
			$valorDespVarTotalV = 'R$ '.number_format($valorDespVarTotal, 2, ',', '.');
			$valorDespFixoTotalV = 'R$ '.number_format($valorDespFixoTotal, 2, ',', '.');
			
			$valorMargemCOntribuicao = $valorReceitaTotal - $valorDespVarTotal;
			$valorMargemCOntribuicaoV = 'R$ '.number_format($valorMargemCOntribuicao, 2, ',', '.');
			
			$valorLucroOperacional = $valorMargemCOntribuicao - $valorDespFixoTotal;
			$valorLucroOperacionalV = 'R$ '.number_format($valorLucroOperacional, 2, ',', '.');
			
			//$impostodeRenda = "5000";
			//$impostodeRendaV = 'R$ '.number_format($impostodeRenda, 2, ',', '.');
			
			$valorLucroExercicio = $valorLucroOperacional;// - $impostodeRenda;
			$valorLucroExercicioV = 'R$ '.number_format($valorLucroExercicio, 2, ',', '.');
			
			$divisor = $valorMargemCOntribuicao*$valorReceitaTota;

			if($divisor == 0){$divisor = 1;}
			$pontoEquilibrio = $valorDespFixoTotal/$divisor;
			$pontoEquilibrioV = 'R$ '.number_format($pontoEquilibrio, 2, ',', '.');
			
			
		foreach($vetContas as $ch__ => $v__){
					if($vetCtCusto[$ch__] != "Fixo" and $vetCtTipo[$ch__] == "D"){
						
						$valorDespVarV = 'R$ '.number_format($v__, 2, ',', '.');
						$tabDREDespVar .= '<tr  class="tdatagrid_row1">';
						$tabDREDespVar .= '<td width="65%" style="padding: 15px;"><b> <img src="../app.view/app.images/icon_menos.png"> '.$vetCtNome[$ch__]."</b></td>";
						$tabDREDespVar .= '<td width="20%" style="text-align:right">'.$valorDespVarV."</td>";
						$tabDREDespVar .= '<td width="15%"><center>'.porcentagem($valorDespVarTotal,$v__)."</center></td>";
						$tabDREDespVar .= '</tr>';
					}
					elseif($vetCtCusto[$ch__] == "Fixo" and $vetCtTipo[$ch__] == "D"){
						
						$valorDespFixV = 'R$ '.number_format($v__, 2, ',', '.');
						$tabDREDespFixo .= '<tr  class="tdatagrid_row1">';
						$tabDREDespFixo .= '<td width="65%" style="padding: 15px;"><b> <img src="../app.view/app.images/icon_menos.png"> '.$vetCtNome[$ch__]."</b></td>";
						$tabDREDespFixo .= '<td width="20%" style="text-align:right">'.$valorDespFixV."</td>";
						$tabDREDespFixo .= '<td width="15%"><center>'.porcentagem($valorDespFixoTotal,$v__)."</center></td>";
						$tabDREDespFixo .= '</tr>';
					}
		}

	
			//
			$tabDRE .= '<legend>Relat�rio de '.$data1.' até '.$data2.'</legend><table width="70%" border="0"   align="center">';
			//
			
			//Receita
			$tabDRE .= '<div><tr>';
			$tabDRE .= '<td width="65%" class="tdatagrid_col"><div id="icone_Relatorio"  onclick="showdiv(\'receita\')"><img src="../app.view/app.images/icon_expandir.png"></div>1. Receita de Vendas</td>';
			$tabDRE .= '<td width="20%" style="text-align:right" class="tdatagrid_col">'.$valorReceitaTotalV.'</td>';
			$tabDRE .= '<td width="15%" class="tdatagrid_col"><center>100%<center></td>';
			$tabDRE .= '</tr></table></div>';
			
			$tabDRE .= '<div id="receita" style="display: none;"><table width="70%" border="0"   align="center"><tr  class="tdatagrid_row1">';
			$tabDRE .= '<td width="65%" style="padding: 15px;"><b><img src="../app.view/app.images/icon_mais.png"> Vendas a Vista</b></td>';
			$tabDRE .= '<td width="20%" style="text-align:right">'.$valorReceitaAVistaTotalV."</td>";
			$tabDRE .= '<td width="15%"><center>'.porcentagem($valorReceitaTotal,$valorReceitaAVistaTotal)."</center></td>";
			$tabDRE .= '</tr>';
			$tabDRE .= '<tr  class="tdatagrid_row1">';
			$tabDRE .= '<td width="65%" style="padding: 15px;"><b><img src="../app.view/app.images/icon_mais.png"> Vendas a Prazo</b></td>';
			$tabDRE .= '<td width="20%" style="text-align:right">'.$valorReceitaAPrazoTotalV."</td>";
			$tabDRE .= '<td width="15%"><center>'.porcentagem($valorReceitaTotal,$valorReceitaAPrazoTotal)."</center></td>";
			$tabDRE .= '</tr></table></div>';
			
			$tabDRE .= '<div><table width="70%" border="0"   align="center"><tr>';
			$tabDRE .= '<td width="65%" class="tdatagrid_col"><div id="icone_Relatorio" onclick="showdiv(\'despvar\')"><img src="../app.view/app.images/icon_expandir.png"></div>2. Custo de Produtos Vendidos</td>';
			$tabDRE .= '<td width="20%" style="text-align:right" class="tdatagrid_col">'.$valorDespVarTotalV."</td>";
			$tabDRE .= '<td width="15%" class="tdatagrid_col"><center>100%<center></td>';
			$tabDRE .= '</tr></div></table>';
			
			$tabDRE .= '<div id="despvar" style="display: none;"><table width="70%" border="0"   align="center">'.$tabDREDespVar.'</table></div>';
						
			$tabDRE .= '<div><table width="70%" border="0"   align="center"><tr>';
			$tabDRE .= '<td width="65%" class="tdatagrid_col"><div id="icone_Relatorio"><img src="../app.view/app.images/icon_none.png"></div>3. Margem de Contribuição (1-2)</td>';
			$tabDRE .= '<td width="20%" style="text-align:right" class="tdatagrid_col">'.$valorMargemCOntribuicaoV."</td>";
			$tabDRE .= '<td width="15%" class="tdatagrid_col"><center>'.porcentagem($valorReceitaTotal,$valorMargemCOntribuicao)."</center></td>";
			$tabDRE .= '</tr><table></div>';
			
			$tabDRE .= '<div><table width="70%" border="0"   align="center"><tr>';
			$tabDRE .= '<td width="65%" class="tdatagrid_col"><div id="icone_Relatorio" onclick="showdiv(\'despfixo\')"><img src="../app.view/app.images/icon_expandir.png"></div>4. Despesas Operacionais</td>';
			$tabDRE .= '<td width="20%" style="text-align:right" class="tdatagrid_col">'.$valorDespFixoTotalV."</td>";
			$tabDRE .= '<td width="15%" class="tdatagrid_col"><center>100%<center></td>';
			$tabDRE .= '</tr></table></div>';
			
			$tabDRE .= '<div id="despfixo" style="display: none;"><table width="70%" border="0"   align="center">'.$tabDREDespFixo.'</table></div>';
			
			$tabDRE .= '<div><table width="70%" border="0"   align="center"><tr>';
			$tabDRE .= '<td width="65%" class="tdatagrid_col"><div id="icone_Relatorio" onclick="showdiv(\'lucroop\')"><img src="../app.view/app.images/icon_expandir.png"></div>5. Lucro operacional (3-4)</td>';
			$tabDRE .= '<td width="20%" style="text-align:right" class="tdatagrid_col">'.$valorLucroOperacionalV."</td>";
			$tabDRE .= '<td width="15%" class="tdatagrid_col"><center>'.porcentagem($valorMargemCOntribuicao,$valorLucroOperacional)."</center></td>";
			$tabDRE .= '</tr></table></div>';
			
			$tabDRE .= '<div id="lucroop" style="display: none;"><table width="70%" border="0"   align="center"><tr  class="tdatagrid_row1">';
			$tabDRE .= '<td width="65%" style="padding: 15px;"><b> <img src="../app.view/app.images/icon_mais.png" > Receita Financeira</b></td>';
			$tabDRE .= '<td width="20%" style="text-align:right"> - </td>';
			$tabDRE .= '<td width="15%"><center> - </center></td>';
			$tabDRE .= '</tr>';
			$tabDRE .= '<tr  class="tdatagrid_row1">';
			$tabDRE .= '<td width="65%" style="padding: 15px;"><b> <img src="../app.view/app.images/icon_menos.png"> Despesa Financeira</b></td>';
			$tabDRE .= '<td width="20%" style="text-align:right"> - </td>';
			$tabDRE .= '<td width="15%"><center> - </center></td>';
			$tabDRE .= '</tr></table></div>';
			
			$tabDRE .= '<div><table width="70%" border="0"   align="center"><tr>';
			$tabDRE .= '<td width="65%" class="tdatagrid_col"><div id="icone_Relatorio" onclick="showdiv(\'impostoderenda\')"><img src="../app.view/app.images/icon_expandir.png"></div>6. L.A.I.R.</td>';
			$tabDRE .= '<td width="20%" style="text-align:right" class="tdatagrid_col">'.$valorLucroOperacionalV."</td>";
			$tabDRE .= '<td width="15%" class="tdatagrid_col"><center>100%<center></td>';
			$tabDRE .= '</tr></table></div>';
			
			$tabDRE .= '<div id="impostoderenda" style="display: none;"><table width="70%" border="0"   align="center"><tr  class="tdatagrid_row1">';
			$tabDRE .= '<td width="65%" style="padding: 15px;"><b> <img src="../app.view/app.images/icon_menos.png"> Imposto de Renda</b></td>';
			$tabDRE .= '<td width="20%" style="text-align:right"> R$ 0,00 </td>';
			$tabDRE .= '<td width="15%"><center>15,00%</center></td>';
			$tabDRE .= '</tr></table></div>';
			
			$tabDRE .= '<div><table width="70%" border="0"   align="center"><tr>';
			$tabDRE .= '<td width="65%" class="tdatagrid_col"><div id="icone_Relatorio"><img src="../app.view/app.images/icon_none.png"></div>7. Lucro L�quido do Exercicio</td>';
			$tabDRE .= '<td width="20%" style="text-align:right" class="tdatagrid_col">'.$valorLucroExercicioV."</td>";
			$tabDRE .= '<td width="15%" class="tdatagrid_col"><center>'.porcentagem($valorMargemCOntribuicao,$valorLucroExercicio)."</center></td>";
			$tabDRE .= '</tr></div>';
			
			$tabDRE .= '<div><tr>';
			$tabDRE .= '<td width="65%" class="tdatagrid_col"><div id="icone_Relatorio"><img src="../app.view/app.images/icon_none.png"></div>8. Ponto de Equil�brio Operacional (4/3*100)</td>';
			$tabDRE .= '<td width="20%" style="text-align:right" class="tdatagrid_col">'.$pontoEquilibrioV."</td>";
			$tabDRE .= '<td width="15%" class="tdatagrid_col"><center>'.porcentagem($valorMargemCOntribuicao,$pontoEquilibrio)."</center></td>";
			$tabDRE .= '</tr></div>';
			
			//
			$tabDRE .= '</table>';	
			$Bloco2 .= $tabDRE;
			
		$ob = new TElement('div');
		$ob->id = "containerDRE";
		$ob->add($Bloco2);
	
		$ob->show();		
		

