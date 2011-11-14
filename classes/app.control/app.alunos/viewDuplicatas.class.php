<?php
	// codifica a forma de saidad dos dados no header (tratando caracteres especiais) \\
	////header("Content-Type: text/html; charset=UTF-8",true);
	
	class viewDuplicatas{

	/**
    * método setParam()
	* Autor : Wagner Borba
    * Configura o atributo vindo do objeto pai(registro responsavel pela visualização do ap�ndice)
    * param Codigo = recebe codigo do objeto pai
    */	
	public function setParam($param){
		$this->param = $param;
	}
	
  	/*método get()
	* Autor: Jo�o Felix
	****************************************************************************
	*/	
	public function get(){
	
		//Retorna Usuario logado===================================
		$obUser = new TCheckLogin();
		$obUser = $obUser->getUser();
		//=========================================================	
		
		//TTransaction::close();
	
		//TTransaction::open('../'.TOccupant::getPath().'app.config/my_dbpetrus');
			
		//if($conn = TTransaction::get()){

            $obCodigo = $obUser->codigo;


            //retorna informações do Aluno
                $criteriaAluno = new TCriteria();
                $criteriaAluno->add(new TFilter('codigopessoa','=',$obCodigo));
            $dboAluno = new TDbo(TConstantes::DBPESSOAS_ALUNOS);
            $alunoQuery = $dboAluno->select('*', $criteriaAluno);
            $obAluno = $alunoQuery->fetchObject();

            $codigopessoa = $obAluno->codigopessoa;
          $codigotransacao = $obAluno->codigotransacao;

            //retorna informações do Cliente
                $criteriaCliente = new TCriteria();
                $criteriaCliente->add(new TFilter('codigo','=',$codigopessoa));
            $dboCliente = new TDbo(TConstantes::DBPESSOAS);
            $clienteQuery = $dboCliente->select('*', $criteriaCliente);
            $obCliente = $clienteQuery->fetchObject();

            //retorna informações das contas a receber;
                $criteriaContas = new TCriteria();
                $criteriaContas->add(new TFilter('codigopessoa','=',$codigopessoa));
                $criteriaContas->add(new TFilter('codigotransacao','=',$codigotransacao));
                $criteriaContas->add(new TFilter('tipomovimentacao','=','C'));
                $criteriaContas->add(new TFilter('ativo','=','1'));
            $dboContas = new TDbo(TConstantes::DBTRANSACOES_CONTAS);
            $contasQuery = $dboContas->select('*', $criteriaContas);

            //$sqlDuplic = "SELECT * FROM dbduplicatas where codigoCliente='".$codigopessoa."'";
            //$duplicQuery = $conn->Query($sqlDuplic);

            //Percorre a aloca contas nos vetores
            while ($obContas = $contasQuery->fetchObject()){

                    $criteriaCaixa = new TCriteria();
                    $criteriaCaixa->add(new TFilter('codigoconta', '=', $obContas->codigo));
                $dboCaixa = new TDbo(TConstantes::DBCAIXA);
                $verCaixaQuery = $dboCaixa->select('*', $criteriaCaixa);
                $obVerCaixa = $verCaixaQuery->fetchObject();

                if ($obContas->statusconta == "2" ){
                    $obContas->valordoc = $obVerCaixa->valorpago;
                    $vetContasPagas[$obContas->id]["ob"] = $obContas;
                }else{
                    $vetContasAbertas[$obContas->id]["ob"] = $obContas;
                }
            }

            //------------------------------------Fim das Informações Principais--------------------------------------

            $dta = new TSetData();

            //==================================================================
            //Contas Pagas.
            $cont_bp = '<table width="98%" class="tdatagrid_table"><tr><td class="tdatagrid_col" style="width=60%;">N� do Titulo Pago</td><td class="tdatagrid_col"style="width=25%;">Vencimento</td><td class="tdatagrid_col"style="width=15%;">Valor Pago</td></tr>';

            if ($vetContasPagas != NULL){
                foreach ($vetContasPagas as $vbp => $vl){

                    $cont_bp .= '<tr><td class="tdatagrid_row1"><img src="../app.view/app.images/sim.gif" /> Boleto referente a parcela N. '.$vl['ob']->numParcela.'</td><td class="tdatagrid_row1" style="text-align:center">'.$dta->dataPadraoPT($vl['ob']->vencimento).'</td><td  class="tdatagrid_row1" style="text-align:right">R$ '.number_format($vl['ob']->valordoc, 2, ',','.').' <img src="../app.view/app.images/sim.gif" /></td></tr>';
                }

            } else {
                $cont_bp .= '<tr><td class="tdatagrid_row1" colspan="3">- não existem titulos pagos.</td></tr>';
            }
            $cont_bp .= "</table>";

            //==================================================================
            // Contas abertas.
            $cont_bp .= '<br><table width="98%" class="tdatagrid_table"><tr><td class="tdatagrid_col"style="width=60%;">N� do Titulo Aberto</td><td class="tdatagrid_col"style="width=25%;">Vencimento</td><td class="tdatagrid_col"style="width=15%;">Valor</td></tr>';

            if ($vetContasAbertas != NULL){
                foreach ($vetContasAbertas as $vba =>$vla){
                    $cont_bp .= '<tr><td class="tdatagrid_row1"><img src="../app.view/app.images/ico_print.png" style="cursor: pointer" onClick="showBoleto(\''.$vla['ob']->codigo.'\')" /> Boleto referente a parcela N. '.$vla['ob']->numParcela.'</td><td class="tdatagrid_row1" style="text-align:center">'.$dta->dataPadraoPT($vla['ob']->vencimento).'</td><td  class="tdatagrid_row1" style="text-align:right">R$ '.number_format($vla['ob']->valornominal, 2, ',','.').' <img src="../app.view/app.images/nao.gif" /></td></tr>';
                }
            } else {
                $cont_bp .= '<tr><td class="tdatagrid_row1" colspan="4">- não existem titulos em aberto.</td></tr>';
            }
            $cont_bp .= "</table>";

            //---------------------------------------------------------------------------------------------

        
        //$obCurso = new ListaCursos();
        //$cursos = $obCurso->get();

        //Inicio do Cabe�alho
        $tabHead  = '<fieldset><legend>Informações do Aluno</legend><div style="padding: 5px">';
        $tabHead .= '<span style="width:100px; text-aling:right;"><b>N�. Matricula: </b></span>'.$obAluno->codigo.'<br>';
        $tabHead .= '<span style="width:100px; text-aling:right;"><b>Aluno: </b></span>'.$obCliente->nome_razaosocial.'<br>';
        $tabHead .= '</div></fieldset>';
        //Fim do Cabe�alho
        //Inicio do Historico
        $tabHistorico .= '<table width="100%">';
        $tabHistorico .= '<tr>';
        $tabHistorico .= '<td style="vertical-align:top;width: 50%"><fieldset><legend>Financeiro</legend><div style="padding: 5px">';

        $tabHistorico .= $cont_bp;

        $tabHistorico .= '</div></fieldset></td>';
        $tabHistorico .= '</tr>';
        $tabHistorico .= '</table>';



        //Exibe Container

        $this->ob = new TElement('div');
        $this->ob->id = "contHistorico";
        $this->ob->add($tabHead);
        $this->ob->add($tabHistorico);

        return $this->ob;

    }
}

?>

