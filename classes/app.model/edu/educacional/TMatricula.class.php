<?php
/* 
 * Gerencia todos as funcionalidades necessárias para manipulação
 * de matriculas
 * Autor: Wagner Borba
*/

class TMatricula {

    /**
    * Executa primeira matrícula do aluno
    * param <type> $codigoinscricao
    */
    public function setMatricula($codigoinscricao, $datainiciovencimentos, $padraovencimento, $cofiseq){
        try{

            if(!$codigoinscricao){
                throw new Exception(TMensagem::ERRO_VALOR_NULL);
            }

            $inscricao = new TInscricao();
            $obInscricao = $inscricao->getInsncricao($codigoinscricao);

            $obCurso = new TCurso();
            $curso = $obCurso->getCurso($obInscricao->cursseq);

            $obTurma = new TTurma();
            $turma  = $obTurma->getTurma($obInscricao->turmseq,true,false);
            
            $TSetControl = new TSetControl();
            
            if(is_null($padraovencimento) && $padraovencimento !== 0){
            	$padraovencimento = $turma->padraovencimento;
            }
            if(!$datainiciovencimentos){
            	$datainiciovencimentos = $turma->datainiciovencimentos;
            }else{
            	$datainiciovencimentos = $TSetControl->setDataDB($datainiciovencimentos);
            }
            
            $descontos = $obTurma->getTurmaDescontos($obInscricao->turmseq);
            $convenios = $obTurma->getTurmaConvenios($obInscricao->turmseq);

                //compões instroções de pagamento da conta =====================
                if(is_array($descontos)){
                    foreach($descontos as $desc){
                        if($desc->tconseq == '1'){
                            $valorDesconto = $desc->valordescontado."%";
                        }else{
                            $model = new TSetModel();
                            $valorDesconto = $model->setValorMonetario($desc->valordescontado);
                        }
                        $infoDescontos .= "Pagamento até o dia ".$desc->dialimite.", desconto não acumulado de ".$valorDesconto." <br>";
                    }
                }
                //==============================================================

            if(count($turma->disciplinas) > 0 && is_array($turma->disciplinas)){
	            foreach($turma->disciplinas as $codTD=>$turmaDisciplina){
	                $listaTurmaDisicplinas[$turmaDisciplina->discseq] = $turmaDisciplina;
	            }
            }

            
            
             //=========================================================
             // Gera contas na transação da turma

			if(!$datainiciovencimentos){
                throw new Exception('A inscrição está incompleta, a data de vencimento da matricula não existe.');				
			}
            $vetorData = explode('-', $datainiciovencimentos);

            $dataFixa = $vetorData[2];

             $codigotransacao = $obInscricao->transeq;
                  
             $trasacao = new TTransacao();
             //$trasacao->setDataFixa($dataFixa);
             $trasacao->setVencimento($datainiciovencimentos);
             $trasacao->setInstrincoesPagamento($infoDescontos);
             $trasacao->setContaFinanceira($cofiseq);
             $dias = null;
             if($padraovencimento == 0){
                 $trasacao->setPadraoVencimento();
                 $trasacao->setDataFixa($dataFixa);
             }else{
             	$dias = $padraovencimento;
             }
        	$TUnidade = new TUnidade();
            $matricula_independente = $TUnidade->getParametro('matricula_independente');
            //configura transação da matrícula
	            if($matricula_independente == '1' && $codigotransacao){
		             $trasacao->setNumContas($turma->parcelas, 2);
		             $trasacao->addContas($codigotransacao);
            	}else{
            		$trasacao->setPessoa($obInscricao->pessseq);
		            $trasacao->setValorNominal($turma->valortotal);
		            //$trasacao->setTipoMovimento('C');
		            //$trasacao->setDesconto($turma->valordescontado, "2");
		            $trasacao->setAcrescimo('0.00');
		            $trasacao->setParcelas($turma->parcelas, $dias);
		            $trasacao->setPlanoConta($turma->plcoseq);
		            $codigotransacao = $trasacao->run($turma->parcelas);         		
            	}
             //=================================================================

             
             //Gera aluno
             $obDbo = new TDbo();
             $TSetControl = new TSetControl();


                //Gera aluno no banco
                $dadosAluno['pessseq'] = $obInscricao->pessseq;
                $dadosAluno['cursseq']  = $obInscricao->cursseq;
                $dadosAluno['turmseq']  = $obInscricao->turmseq;
                $dadosAluno['datacad']  = $TSetControl->setDataDB($datacad);
                $dadosAluno['transeq']  = $codigotransacao;
                $dadosAluno['statseq']        = '1';

                
                $obDbo->setEntidade(TConstantes::DBALUNO);
                $inAluno = $obDbo->insert($dadosAluno);



            if($inAluno){

                //Gera relacionamento aluno disciplinas
                if(count($curso->disciplinas) > 0){
	                foreach($curso->disciplinas as $codDisciplina=>$obDisciplina){
	                	$obDisciplina = $obDisciplina->obDisciplina;
	                        //define se a disciplina está associada a atual turma
	                        if($listaTurmaDisicplinas[$codDisciplina]){
	                            $tudiseq = $listaTurmaDisicplinas[$codDisciplina]->seq;
	                            $dadosDisciplina['tudiseq'] = $tudiseq;
	                            $situação = '2';
	                        }else{
	                            $situação = '1';
	                        }
	
	                        $dadosDisciplina['alunseq']      = $inAluno['seq'];
	                        $dadosDisciplina['discseq'] = $obDisciplina->seq;
	                        $dadosDisciplina['statseq']            = '1';
	                        $dadosDisciplina['stadseq']         = $situação;
	
	                     $obDbo->setEntidade(TConstantes::DBALUNO_DISCIPLINA);
	                     $inDisciplinas = $obDbo->insert($dadosDisciplina);
	
	                     if(!$inDisciplinas){
	                         throw new Exception(TMensagem::ERRO_GERAL_MATRICULA);
	                     }
	                }
                }
                //associa a transação da turma com os aluno
                $dadosAlunoConvenio['transeq'] = $codigotransacao;
                $dadosAlunoConvenio['statseq'] = '1';
                
                if($convenios){
	                foreach($convenios as $ch => $vl){
	                	$dadosAlunoConvenio['convseq'] = $vl->convseq;
	                	$obDbo->setEntidade(TConstantes::DBTRANSACAO_CONVENIO);
	                	$obDbo->insert($dadosAlunoConvenio);
	                }
                }
                //atualisa codigo do aluno nos pré-requisitos
                $dadosRequisitos['alunseq'] = $inAluno['seq'];
                $obDbo->setEntidade(TConstantes::DBALUNO_REQUISITO);
                    $criteriaAlunoRequisito = new TCriteria();
                    $criteriaAlunoRequisito->add(new TFilter('alunseq', '=', $inAluno['seq']));
                $upRequisitos = $obDbo->update($dadosRequisitos, $criteriaAlunoRequisito);

                //exclui registra da inscrição
                $obDbo->setEntidade(TConstantes::DBINSCRICAO);
                $obDbo->delete($codigoinscricao, 'seq');

                $obDbo->close();

                //retorna mensagem de sucesso


                    $pessoa = new TPessoa();
                    $obPessoa = $pessoa->getPessoa($obInscricao->pessseq);
                    //Gera usuario e privilegios do aluno.
                    $TUsuario = new TUsuario();
                    
                    $TUnidade = new TUnidade();
                    $senhainicial = $TUnidade->getParametro('senhainicial');
                    
                    $nomeUsuario = sprintf('%06s', $inAluno["seq"]); 
                    
                    if(strlen($senhainicial)){
                    	$provSenha = $senhainicial;
                    }else{
                    	$provSenha = sprintf('%08s', $obInscricao->pessseq);
                    }
                    $retUsuario = $TUsuario->setUsuario($obInscricao->pessseq, $nomeUsuario, $provSenha);

                    if($retUsuario){
                            $priv = array();

                            $priv[] = array("0","10","0");
                            $priv[] = array("10","25","1");
                            $priv[] = array("10","26","1");
                            $priv[] = array("10","27","1");
                            $priv[] = array("76","1","2");
                            $priv[] = array("76","2","2");
                            $priv[] = array("222","459","3");
                            $priv[] = array("222","460","3");
                            $priv[] = array("222","461","3");
                            $priv[] = array("222","462","3");
                            $priv[] = array("76","230","5");
                            $priv[] = array("230","158","6");
                            $priv[] = array("158","682","7");
                            $priv[] = array("682","682","8");
                            $priv[] = array("158","683","7");
                            $priv[] = array("683","683","8");
                            $priv[] = array("158","684","7");
                            $priv[] = array("684","684","8");
                            $priv[] = array("158","685","7");
                            $priv[] = array("685","685","8");
                            $priv[] = array("158","686","7");
                            $priv[] = array("686","686","8");
                            $priv[] = array("10","86","1");
                            $priv[] = array("10","92","1");
                            $priv[] = array("331","717","3");
                      /*    $priv[] = array("10","115","1");
                            $priv[] = array("274","516","3");
                            $priv[] = array("274","616","3");
                            $priv[] = array("274","615","3");
                            $priv[] = array("274","614","3");
                            $priv[] = array("274","613","3");
                            $priv[] = array("274","612","3");
                            $priv[] = array("274","611","3");
                            $priv[] = array("274","610","3");
                            $priv[] = array("274","609","3");
                            $priv[] = array("274","608","3");
                            $priv[] = array("274","607","3");
                            $priv[] = array("274","606","3");
                            $priv[] = array("274","605","3");
                            $priv[] = array("274","517","3");
                            $priv[] = array("274","515","3"); */

                            foreach($priv as $vl){
                                $TUsuario->setPrivilegio($retUsuario["seq"], $vl[2], $vl[0],$vl[1],'1');
                            }

                        $mensagemUsuario = '<h2><br/> Usuario '.$nomeUsuario.' gerado com sucesso. Senha provisória: '.$provSenha . '</h2>';
                    }else{
                    	$mensagemUsuario = '<h2>Não foi possível criar um usuário de acesso para o Aluno.</h2>';
                    }

                $divSucesso = new TElement('div');
                $divSucesso->class = 'sucesso ui-state-highlight';
                $divSucesso->add('A  matrícula foi confirmada com sucesso.'.$mensagemUsuario);
                $divSucesso->show();

            }else{
                throw new Exception(TMensagem::ERRO_GERAL_MATRICULA);
            }

        }catch (Exception $e) {
            $obDbo->rollback();
            new setException($e);
        }

    }

    /**
     * Retorna um objeto element com as informações da matricula
     * return <type>
     */
    public function viewSetRequisitos($codigoaluno){

        $inscricao = new TInscricao();
        $obInscricao = $inscricao->getInsncricao($codigoaluno);

        //retorna requisitos do turmas
        $obTurma = new TTurma();
        $requisitos = $obTurma->getRequisitos($obInscricao->turma->seq);

        $fieldReq = new TElement("fieldset");
        $legendaReq = new TElement("legend");
        $legendaReq->add("Pré-requisitos");
        $fieldReq->add($legendaReq);

        $blocReq = new TTable();
        $blocReq->border = 0;

            //Retorna requisitos baseado no código da inscrição pois o aluno ainda não existe
            $aluno = new TAluno();
            $requisitosAluno = $aluno->getRequisitos($codigoaluno);
        if($requisitos){
        foreach($requisitos as $codKey=>$requisito) {

            $campoReq = new TCheckButton("idrequisito");
            $campoReq->setValue("1");
            $campoReq->setId("req_".$requisito->seq);
            $campoReq->setProperty('onclick','setRequisitos(this, \''.$codigoaluno.'\', \''.$requisito->seq.'\')');

            if($requisitosAluno[$requisito->codigo]->situacao == '1'){
                $campoReq->checked = "checked";
            }

            $rowReq = $blocReq->addRow();
            $cellRet = $rowReq->addCell($campoReq);
            $cellRet->width = "235px";
            $cellRet->align = "right";
            $cellReqLabel = $rowReq->addCell($requisito->requisito);
            $cellReqLabel->style = "TEXT-ALIGN: left; FONT-FAMILY: Arial; COLOR: black; FONT-SIZE: 14px";

        }
        }
        $fieldReq->add($blocReq);

        $this->ob = new TElement('div');
        $this->ob->id = "contMatricula";
        $this->ob->add($fieldAluno);
        $this->ob->add($fieldTurma);
        $this->ob->add($fieldValor);
        $this->ob->add($fieldReq);

        return $this->ob;
    }

    /**
     * 
     */
    public function setBotMatricula(){
        try{
            $confirmacao = TMensagem::MSG_CONF_PADRAO;
            $confirmacaoAnular = TMensagem::MSG_CONF_ANUNAR_MATRICULA;

            $tabBot  = '<table border="0" width="100%" cellpadding="3" cellpadding="0">';
            $tabBot .= '<tr><td class="ui-state-default" align="center">
                                    <input type="button" name="confMat" id="confMat" class="ui-state-default" onclick="setMatricula(\''.$obAluno->codigo.'\',\''.$confirmacao.'\')" value="Efetivar Matrícula">
                    <input type="button" name="anulaMat" id="anulaMat" class="ui-state-default" onclick="anulaMatricula(\''.$obCliente->codigo.'\',\''.$confirmacaoAnular.'\')" value="Anular Matrícula">
                                    </td></tr>';
            $tabBot .= '</table>';
            
        }catch (Exception $e) {
            new setException($e);
        }
    }


}