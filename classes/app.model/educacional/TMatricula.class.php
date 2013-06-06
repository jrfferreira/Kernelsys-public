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
    public function setMatricula($codigoinscricao, $datacad){
        try{

            if(!$codigoinscricao){
                throw new Exception(TMensagem::ERRO_VALOR_NULL);
            }

            $inscricao = new TInscricao();
            $obInscricao = $inscricao->getInsncricao($codigoinscricao);

            $obCurso = new TCurso();
            $curso = $obCurso->getCurso($obInscricao->codigocurso);

            $obTurma = new TTurma();
            $turma  = $obTurma->getTurma($obInscricao->codigoturma,true,false);
            $descontos = $obTurma->getTurmaDescontos($obInscricao->codigoturma);
            $convenios = $obTurma->getTurmaConvenios($obInscricao->codigoturma);

                //compões instroções de pagamento da conta =====================
                if(is_array($descontos)){
                    foreach($descontos as $desc){
                        if($desc->tipodesconto == '1'){
                            $valorDesconto = $desc->valordescontado."%";
                        }else{
                            $model = new TSetModel();
                            $valorDesconto = $model->setValorMonetario($desc->valordescontado);
                        }
                        $infoDescontos .= "Pagamento até o dia ".$desc->dialimite.", desconto não acumulado de ".$valorDesconto." <br>";
                    }
                }
                //==============================================================

            if(count($turma->disciplinas) > 0){
	            foreach($turma->disciplinas as $codTD=>$turmaDisciplina){
	                $listaTurmaDisicplinas[$turmaDisciplina->codigodisciplina] = $turmaDisciplina;
	            }
            }

            
            
             //=========================================================
             // Gera contas na transação da turma

			if(!$obInscricao->vencimentomatricula){
                throw new Exception('A inscrição está incompleta, a data de vencimento da matricula não existe.');				
			}
            $vetorData = explode('-', $obInscricao->vencimentomatricula);

            $dataFixa = $vetorData[2];

             $codigotransacao = $obInscricao->codigotransacao;
                  
             $trasacao = new TTransacao();
             //$trasacao->setDataFixa($dataFixa);
             $trasacao->setVencimento($obInscricao->vencimentomatricula);
             $trasacao->setInstrincoesPagamento($infoDescontos);

             if($turma->padraovencimento == '1'){
                 $trasacao->setPadraoVencimento();
             }
        	$TUnidade = new TUnidade();
            $matricula_independente = $TUnidade->getParametro('matricula_independente');
            //configura transação da matrícula
	            if($matricula_independente == '1'){
		             $trasacao->setNumContas($turma->numparcelas, 2);
		             $trasacao->addContas($codigotransacao);
            	}else{
            		$trasacao->setPessoa($obInscricao->codigopessoa);
		            $trasacao->setValorNominal($turma->valortotal);
		            $trasacao->setTipoMovimento('C');
		            $trasacao->setDesconto($turma->valordescontado, "2");
		            $trasacao->setAcrescimo('0.00');
		            $trasacao->setParcelas($turma->numparcelas);
		            $trasacao->setPlanoConta($turma->codigoplanoconta);
		            $codigotransacao = $trasacao->run($turma->numparcelas);         		
            	}
             //=================================================================

             
             //Gera aluno
             $obDbo = new TDbo();
             $TSetControl = new TSetControl();


                //Gera aluno no banco
                $dadosAluno['codigopessoa'] = $obInscricao->codigopessoa;
                $dadosAluno['codigocurso']  = $obInscricao->codigocurso;
                $dadosAluno['codigoturma']  = $obInscricao->codigoturma;
                $dadosAluno['datacad']  = $TSetControl->setDataDB($datacad);
                $dadosAluno['ativo']        = '1';

                
                $obDbo->setEntidade(TConstantes::DBPESSOAS_ALUNOS);
                $inAluno = $obDbo->insert($dadosAluno);



            if($inAluno){

                //Gera relacionamento aluno disciplinas
                if(count($curso->disciplinas) > 0){
	                foreach($curso->disciplinas as $codDisciplina=>$obDisciplina){
	
	                        //define se a disciplina está associada a atual turma
	                        if($listaTurmaDisicplinas[$codDisciplina]){
	                            $codigoturmadisciplina = $listaTurmaDisicplinas[$codDisciplina]->codigo;
	                            $dadosDisciplina['codigoturmadisciplina'] = $codigoturmadisciplina;
	                            $situação = '2';
	                        }else{
	                            $situação = '1';
	                        }
	
	                        $dadosDisciplina['codigoaluno']      = $inAluno['codigo'];
	                        $dadosDisciplina['codigodisciplina'] = $obDisciplina->codigo;
	                        $dadosDisciplina['ativo']            = '1';
	                        $dadosDisciplina['situacao']         = $situação;
	
	                     $obDbo->setEntidade(TConstantes::DBALUNOS_DISCIPLINAS);
	                     $inDisciplinas = $obDbo->insert($dadosDisciplina);
	
	                     if(!$inDisciplinas){
	                         throw new Exception(TMensagem::ERRO_GERAL_MATRICULA);
	                     }
	                }
                }
                //associa a transação da turma com os aluno
                $dadosAlunoTransacoes['codigoaluno'] = $inAluno['codigo'];
                $dadosAlunoTransacoes['codigotransacao'] = $codigotransacao;
                $dadosAlunoTransacoes['ativo'] = '1';

                $obDbo->setEntidade(TConstantes::DBALUNOS_TRANSACOES);
                $obDbo->insert($dadosAlunoTransacoes);
                
                $dadosAlunoConvenio['codigotransacao'] = $codigotransacao;
                $dadosAlunoConvenio['ativo'] = '1';
                
                if($convenios){
	                foreach($convenios as $ch => $vl){
	                	$dadosAlunoConvenio['codigoconvenio'] = $vl->codigoconvenio;
	                	$obDbo->setEntidade(TConstantes::DBTRANSACOES_CONVENIOS);
	                	$obDbo->insert($dadosAlunoConvenio);
	                }
                }
                //atualisa codigo do aluno nos pré-requisitos
                $dadosRequisitos['codigoaluno'] = $inAluno['codigo'];
                $obDbo->setEntidade(TConstantes::DBALUNOS_REQUISITOS);
                    $criteriaAlunoRequisito = new TCriteria();
                    $criteriaAlunoRequisito->add(new TFilter('codigoaluno', '=', $inAluno['codigo']));
                $upRequisitos = $obDbo->update($dadosRequisitos, $criteriaAlunoRequisito);

                //exclui registra da inscrição
                $obDbo->setEntidade(TConstantes::DBPESSOAS_INSCRICOES);
                $obDbo->delete($codigoinscricao, 'codigo');

                $obDbo->close();

                //retorna mensagem de sucesso


                    $pessoa = new TPessoa();
                    $obPessoa = $pessoa->getPessoa($obInscricao->codigopessoa);
                    //Gera usuario e privilegios do aluno.
                    $TUsuario = new TUsuario();
                    
                    $TUnidade = new TUnidade();
                    $parametros = $TUnidade->getParametro('senhainicial');
                    
                    
                    if(strlen($parametros->senhainicial)){
                    	$provSenha = $parametros->senhainicial;
                    }else{
                    	$provSenha = substr($obInscricao->codigopessoa, 0,-4);
                    }
                    $retUsuario = $TUsuario->setUsuario($obInscricao->codigopessoa, $inAluno["codigo"], $provSenha);

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
                                $TUsuario->setPrivilegio($retUsuario["codigo"], $vl[2], $vl[0],$vl[1],'1');
                            }

                        $mensagemUsuario = '<h2><br/> Usuario '.$inAluno["codigo"].' gerado com sucesso. Senha provisória: '.$provSenha . '</h2>';
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
        $requisitos = $obTurma->getRequisitos($obInscricao->turma->codigo);

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
            $campoReq->setId("req_".$requisito->codigo);
            $campoReq->setProperty('onclick','setRequisitos(this, \''.$codigoaluno.'\', \''.$requisito->codigo.'\')');

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