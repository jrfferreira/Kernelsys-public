<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class TInscricao{

    /**
     * Retorna o objeto inscrição
     * param <type> $codigoinscricao
     * return <type>
     */
    public function getInsncricao($codigoinscricao, $curso = true, $turma = true){

        try{
            //Retorna objeto aluno inscrito atualizado
            $obTDbo = new TDbo(TConstantes::VIEW_INSCRICAO);
                $criteriaInscrito = new TCriteria();
                $criteriaInscrito->add(new TFilter('seq','=',$codigoinscricao));
            $Inscrito = $obTDbo->select('*', $criteriaInscrito);
            $obInscrito = $Inscrito->fetchObject();

                if($curso){
                   $curso = new TCurso();
                   $obInscrito->curso = $curso->getCurso($obInscrito->cursseq);
                }

               //instancia objeto turma
                if($turma){
                   $obTurma = new TTurma();
                   $turma = $obTurma->getTurma($obInscrito->turmseq, true, false);
                   //$turma->descontos = $obTurma->getTurmaDescontos($obInscrito->codigoturma);
                   $obInscrito->turma = $turma;
                }

            return $obInscrito;

        }catch (Exception $e){
            $obTDbo->rollback();
            new setException($e);
        }
    }

    /**
    * gera 1° transação como matrícula
    * param <type> $codigoinscricao
    * param <type> $vencimento
    */
    private function setTransacaoMatricula($codigoinscricao,$vencimentomatricula){

        try{
        	$TSetControl = new TSetControl();
        	if($vencimentomatricula){
        		$vencimentomatricula = $TSetControl->setDataDB($vencimentomatricula);
        	}else{
        		$vencimentomatricula = $obInscricao->vencimentomatricula;
        	}

            $obInscricao = $this->getInsncricao($codigoinscricao);
            $obTurma     = $obInscricao->turma;

                //compões instroções de pagamento da conta =====================
//                if(is_array($obTurma->descontos)){
//                    foreach($obTurma->descontos as $descontos){
//                        if($descontos->tipodescotno == '1'){
//                            $valorDesconto = $descontos->valordescontado."%";
//                        }else{
//                            $model = new TSetModel();
//                            $valorDesconto = $model->setValorMonetario($descontos->valordescontado);
//                        }
//                        $infoDescontos .= "Pagamento até o dia ".$descontos->dialimite.", desconto de ".$valorDesconto." <br>";
//                    }
//                }
                //==============================================================

            if($obTurma->valormatricula > 0) {
		
	            //configura a transação do curso e define a primeira parcela como matrícula
	            $obCreditoM = new TTransacao();
	            $obUnidade = new TUnidade();
	
	            $obCreditoM->setPessoa($obInscricao->pessseq);
	            $obCreditoM->setValorNominal($obTurma->valormatricula);
	            $obCreditoM->setAcrescimo('0.00');
	            $obCreditoM->setParcelas($obTurma->parcelas,$obUnidade->getParametro('financeiro_intervalo_parcela'));
	            $obCreditoM->setPlanoConta($obTurma->plcoseq);
	            $obCreditoM->setVencimento($vencimentomatricula,$obUnidade->getParametro('financeiro_intervalo_parcela'));
	            //$obCreditoM->setInstrincoesPagamento($infoDesconto);
	
	                //retorna produto taxa de inscrição=========
	                $prodMatricula = new TProduto();
	                $obProdMatricula = $prodMatricula->getProduto('seq', $obTurma->prodseq);
	                //==========================================
	
	            $obCreditoM->addProduto($obProdMatricula);
	            $obCreditoM->setObs("Primeira parcela (Matrícula) do curso :".$obTurma->nomecurso." turma: ".$obTurma->titulo);
	            $obCreditoM->setNumContas(1);
	
	            $codigotransacao = $obCreditoM->run();
	            if($codigotransacao) {
	                $codigoContaM = $obCreditoM->getCodigoContas();
	                $codigoContaM = $codigoContaM[0];
	                //echo 'Conta Credito Matricula gerados com sucesso<bR>';
	
	                $obTDbo = new TDbo(TConstantes::DBINSCRICAO);
	                    $criteriaUpInscricao = new TCriteria();
	                    $criteriaUpInscricao->add(new TFilter('seq','=',$codigoinscricao));
	                $obTDbo->update(array('transeq'=>$codigotransacao), $criteriaUpInscricao);
	
	                $dados['transeq'] = $codigotransacao;
	                $dados['parcseq']    = $codigoContaM;
	
	                return $dados;
	            }
	            else {
	                $obTDbo->rollback();
	                new setException('O código da transação não foi retornado.');
	            }
	        }

        }catch (Exception $e){
            $obTDbo->rollback();
            new setException($e);
        }

    }

    /**
     * Gera transação da taxa de inscrição
     * param <type> $codigoinscricao
     * param <type> $vencimento = data do vencimento da taxa de inscrição
     * return <type>
     */
    private function setTransacaoTaxa($codigoinscricao,$vencimentoTaxa = null){

        try{
        	$TSetControl = new TSetControl();
        	if($vencimentoTaxa){
        		$vencimentoTaxa = $TSetControl->setDataDB($vencimentoTaxa);
        	}else{
        		$vencimentoTaxa = $obInscricao->vencimentotaxa;
        	}

            $obInscricao = $this->getInsncricao($codigoinscricao);
            $obTurma     = $obInscricao->turma;

            //verifica a exitencia da taxa de inscrição e gera Transação da taxa
            if($obTurma->valortaxa > 0) {

                //configura conta credito da taxa de inscrição
                $obCredito = new TTransacao();

                $obCredito->setPessoa($obInscricao->pessseq);
                $obCredito->setValorNominal($obTurma->valortaxa);
                $obCredito->setDesconto('0.00');
                $obCredito->setAcrescimo('0.00');
                $obCredito->setParcelas('1');
                $obCredito->setPlanoConta($obTurma->plcoseq);
                $obCredito->setVencimento($vencimentoTaxa);

                //retorna produto taxa de inscrição=========
                $prodTaxa = new TProduto();
                $obProdTaxa = $prodTaxa->getProduto('tabela', $obTurma->seq);
                //==========================================

                if($obProdTaxa) {
                    $obCredito->addProduto($obProdTaxa);
                    $obCredito->setObs("Taxa de inscrição do curso :".$obTurma->nomecurso." turma: ".$obTurma->titulo);
                }

                $codigotransacao = $obCredito->run();
                if($codigotransacao) {
                    $codigoconta = $obCredito->getCodigoContas();
                    $codigoconta = $codigoconta[0];
                    //echo 'Conta Credito taxa de inscrição gerados com sucesso<bR>';

                    $dados['transeq'] = $codigotransacao;
                    $dados['parcseq']    = $codigoconta;

                    return $dados;
                }
            }

        }catch (Exception $e){
            new setException($e);
        }
    }

    
    public function setInscricao($pessseq,$turmseq,$vencimentoMatricula,$vencimentoTaxa){
    	try {
    		$obTDbo = new TDbo(TConstantes::DBINSCRICAO);
    		
    		$criteria = new TCriteria();
    		$criteria->add(new TFilter('pessseq','=',$pessseq));
    		$criteria->add(new TFilter('turmseq','=',$turmseq));
    		$criteria->add(new TFilter('statseq','=',1));
    		
    		$obExistente = $obTDbo->select('seq',$criteria)->fetchObject()->seq;
    		if($obExistente){
    			return $obExistente->seq;
    		}else{
    			$TSetControl = new TSetControl();
    			$insert = $obTDbo->insert(array('pessseq'=>$pessseq,
    								  'turmseq'=>$turmseq,
    								  'vencimentomatricula'=>$TSetControl->setDataDB($vencimentoMatricula),
    								  'vencimentotaxa'=>$TSetControl->setDataDB($vencimentoTaxa)));
    			return $insert['seq'];
    		}
    		
    		
    	}catch (Exception $e){
            new setException($e);
        }
    }
    
    /**
    * 
    */
    public function setConfirmar($pessseq,$cursseq,$turmseq,$vencimentoMatricula,$vencimentoTaxa){

        try{

            $TUnidade = new TUnidade();
            $inscseq = $this->setInscricao($pessseq, $turmseq, $vencimentoMatricula, $vencimentoTaxa);
            $dadosTransacaoMatricula = $this->setTransacaoMatricula($inscseq,$vencimentoMatricula);
            if($dadosTransacaoMatricula){
                $botMatricula = "<input class=\"ui-state-default ui-corner-all ui-state-hover\" type=\"button\" name=\"impBoleto\" id=\"impBoleto\" value=\"Gerar Boleto\"  onClick=\"showBoleto('".$dadosTransacaoMatricula['parcseq']."')\" >";
            }
            //configura conta credito da taxa de inscrição
            $dadosTransacaoTaxa = $this->setTransacaoTaxa($inscseq,$vencimentoTaxa);
            if($dadosTransacaoTaxa){
                $botTaxa = "<input class=\"ui-state-default ui-corner-all ui-state-hover\" type=\"button\" name=\"impBoleto\" id=\"impBoleto\" value=\"Gerar Boleto\" onClick=\"showBoleto('".$dadosTransacaoTaxa['parcseq']."')\" >";

            }

            $this->setRetorno($botMatricula, $botTaxa);

        }catch (Exception $e){
            new setException($e);
        }
    }

    /**
     *
     */
    private function setRetorno($botMatricula, $botTaxa = " - "){

        $obRetorno = new TTable();
        $obRetorno->width = "100%";
        $obRetorno->cellpadding = "1";
        $obRetorno->cellspacing = "2";

        $rowMsg = $obRetorno->addRow();
        $cellMsg = $rowMsg->addCell('');
        $cellMsg->colspan = 2;
        $cellMsg->align   = 'center';
        $cellMsg->class = "sucesso ui-state-highlight";
        $cellMsg->add(TMensagem::MSG_CONF_INSCRICAO);
        
        $rowMatricula = $obRetorno->addRow();
        $cellMatricula = $rowMatricula->addCell('');
        $cellMatricula->class="tlabel";
        $cellMatricula->add("Matrícula:");
            $cellMatriculaBot = $rowMatricula->addCell('');
            $cellMatriculaBot->add($botMatricula);

        $rowTaxa = $obRetorno->addRow();
        $cellTaxa = $rowTaxa->addCell('');
        $cellTaxa->class="tlabel";
        $cellTaxa->add("Taxa de inscrição:");
            $cellTaxaBot = $rowTaxa->addCell('');
            $cellTaxaBot->add($botTaxa);

       $obRetorno->show();

    }

     /**
     * Gere e imprime um conjuto de dados especificos da turma
     * para o formulário de inscrição do aluno
     * param <type> $codigoturma
     */
    public function getDadosTurmaInscricao($turmseq){
        try{

            $turma = new TTurma();
            $obTurma = $turma->getTurma($turmseq, false);
            
              $model = new TSetModel();
              $dataInicio = $model->setDataPT($obTurma->datainicio);

              $obSetData = new TSetData();
              $dataMatricula = $model->setDataPT($obSetData->calcData(date("Y-m-d"), 30, '-'));
              $dataIncricao = $model->setDataPT($obSetData->calcData(date("Y-m-d"), 5, '-'));

            //monta ação com os valores dos campos dependentes
            $valores = 'valortaxa=>'.$obTurma->valortaxa.'(sp)';
            $valores .= 'valormatricula=>'.$obTurma->valormatricula.'(sp)';
            $valores .= 'parcelas=>'.$obTurma->parcelas.'(sp)';
            $valores .= 'valorparcelas=>'.$obTurma->valormensal.'(sp)';
            $valores .= 'valordescontado=>'.$obTurma->valordescontado.'(sp)';
            $valores .= 'datainicio=>'.$dataInicio.'(sp)';
            $valores .= 'vencimentomatricula=>'.$dataMatricula.'(sp)';
            $valores .= 'vencimentotaxa=>'.$dataIncricao;

            echo $valores;

        }catch (Exception $e) {
            new setException($e);
        }

    }


    
}