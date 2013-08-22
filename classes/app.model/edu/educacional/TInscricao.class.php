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
    private function setTransacaoMatricula($codigoinscricao){

        try{
            

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

            if(!$obTurma->valormensal > 0) {
                new setException('Valor da matricula não esta definido.');
            }

            //configura a transação do curso e define a primeira parcela como matrícula
            $obCreditoM = new TTransacao();

            $obCreditoM->setPessoa($obInscricao->pessseq);
            $obCreditoM->setValorNominal($obTurma->valortotal);
            $obCreditoM->setTipoMovimento('C');
            $obCreditoM->setDesconto($obTurma->valordescontado, "2");
            $obCreditoM->setAcrescimo('0.00');
            $obCreditoM->setParcelas($obTurma->numparcelas);
            $obCreditoM->setPlanoConta($obTurma->plcoseq);
            $obCreditoM->setVencimento($obInscricao->vencimentomatricula);
            $obCreditoM->setInstrincoesPagamento($infoDesconto);

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
    private function setTransacaoTaxa($codigoinscricao){

        try{

            $obInscricao = $this->getInsncricao($codigoinscricao);
            $obTurma     = $obInscricao->turma;

            //verifica a exitencia da taxa de inscrição e gera Transação da taxa
            if($obTurma->valortaxa > 0) {

                //configura conta credito da taxa de inscrição
                $obCredito = new TTransacao();

                $obCredito->setPessoa($obInscricao->pessseq);
                $obCredito->setValorNominal($obTurma->valortaxa);
                $obCredito->setTipoMovimento('C');
                $obCredito->setDesconto('0.00');
                $obCredito->setAcrescimo('0.00');
                $obCredito->setParcelas('1');
                $obCredito->setPlanoConta($obTurma->plcoseq);
                $obCredito->setVencimento($obInscricao->vencimentotaxa, "3");

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
            $obTDbo->rollback();
            new setException($e);
        }
    }

    /**
    * 
    */
    public function setConfirmar($codigoinscricao){

        try{

            if(!$codigoinscricao){
                throw new Exception(TMensagem::ERRO_CODIGO_INSCRICAO);
            }

            $TUnidade = new TUnidade();
            $matricula_independente = $TUnidade->getParametro('matricula_independente');
            //configura transação da matrícula
	            if($matricula_independente == '1'){
	            $dadosTransacaoMatricula = $this->setTransacaoMatricula($codigoinscricao);
	            if($dadosTransacaoMatricula){
	                $botMatricula = "<input class=\"ui-state-default ui-corner-all ui-state-hover\" type=\"button\" name=\"impBoleto\" id=\"impBoleto\" value=\"Gerar Boleto\"  onClick=\"showBoleto('".$dadosTransacaoMatricula['parcseq']."')\" >";
	            }
            }
            //configura conta credito da taxa de inscrição
            $dadosTransacaoTaxa = $this->setTransacaoTaxa($codigoinscricao);
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
    public function getDadosTurmaInscricao($codigoturma){
        try{

            $turma = new TTurma();
            $obTurma = $turma->getTurma($codigoturma, false);
            
              $model = new TSetModel();
              $dataInicio = $model->setDataPT($obTurma->datainicio);
              $dataMatricula = $model->setDataPT($obTurma->datavencimento);

              $obSetData = new TSetData();
              $dataIncricao = $model->setDataPT($obSetData->calcData(date("Y-m-d"), 5, '-'));

            //monta ação com os valores dos campos dependentes
            $valores = 'valortaxa=>'.$obTurma->valortaxa.'(sp)';
            $valores .= 'valormatricula=>'.$obTurma->valormensal.'(sp)';
            $valores .= 'numparcelas=>'.$obTurma->numparcelas.'(sp)';
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