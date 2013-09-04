<?php
class setDocumento{
    public function __construct($contrato){

        $this->consCont = new TDbo(TConstantes::DBCONTRATOS);
        $this->consCritC = new TCriteria();
        $this->consCritC->add(new TFilter("seq","=",$contrato));
        $this->retCont = $this->consCont->select("*",$this->consCritC);

        $this->obCont = $this->retCont->fetchObject();

        $this->consDoc = new TDbo(TConstantes::DBDOCUMENTOS);
        $this->consCritD = new TCriteria();
        $this->consCritD->add(new TFilter("seq","=",$this->obCont->tipoDocumento));
        $this->retDoc = $this->consDoc->select("titulo,modeloDocumento,modeloAssinaturaDigital,modeloAssinaturaReal",$this->consCritD);

        $this->obDoc = $this->retDoc->fetchObject();

        $this->consUnidade = new TDbo(TConstantes::DBUNIDADE);
        $this->unidadeCrit = new TCriteria();
        $this->unidadeCrit->add(new TFilter("seq","=",$this->obCont->unidade));
        $this->retUnidade = $this->consUnidade->select("*",$this->unidadeCrit);

        $this->obUnidade = $this->retUnidade->fetchObject();

        $this->pessoa = new TDbo(TConstantes::DBPESSOA);
        $this->pessoaCrit = new TCriteria();
        $this->pessoaCrit->add(new TFilter("seq","=",$this->obCont->seqpessoa));
        $this->retPessoa = $this->pessoa->select("*",$this->pessoaCrit);

        $this->obPessoa = $this->retPessoa->fetchObject();

        $this->produto = new TDbo(TConstantes::DBPRODUTO);
        $this->produtoCrit = new TCriteria();
        $this->produtoCrit->add(new TFilter("seq","=",$this->obCont->seqproduto));
        $this->retProduto = $this->produto->select("*",$this->produtoCrit);

        $this->obProduto = $this->retProduto->fetchObject();

        if($this->obProduto->tabela == "dbturma"){
        $this->consEspecializacao = new TDbo(TConstantes::VIEW_TURMAS);
        $this->critEspecializacao = new TCriteria();
        $this->critEspecializacao->add(new TFilter("seqproduto","=",$this->obProduto->seq));
        $this->retEspecializacao = $this->consEspecializacao->select("*",$this->critEspecializacao);

        $this->obEspecializacao = $this->retEspecializacao->fetchObject();
        }else{
                $this->consEspecializacao = new TDbo(constant("TConstantes::".strtoupper($this->obProduto->tabela)));
            $this->critEspecializacao = new TCriteria();
            $this->critEspecializacao->add(new TFilter("seqproduto","=",$this->obProduto->seq));
            $this->retEspecializacao = $this->consEspecializacao->select("*",$this->critEspecializacao);

            $this->obEspecializacao = $this->retEspecializacao->fetchObject();
        }
        $this->contrato = $this->obCont;
        $this->contrato->pessoa = $this->obPessoa;
        $this->contrato->produto = $this->obProduto;
        $this->contrato->especializacao = $this->obEspecializacao;
        $this->contrato->documento = $this->obDoc;
        $this->contrato->documento->titulo = "<center><h2>".$this->contrato->documento->titulo."</h2></center><br /><br />";
        $this->contrato->unidade = $this->obUnidade;
        


        $data = new TSetData();
        $this->contrato->dataAtual = $data->getDataPT();
        if($this->contrato->tipoAssinatura == 1){
            $this->contrato->documento->modeloAssinaturaReal = null;
        }
        else if ($this->contrato->tipoAssinatura == 2){
            $this->contrato->documento->modeloAssinaturaDigital = null;
        }

        foreach($this->contrato->documento as $ch => $vl){
            $html[$ch] = str_replace("\r\n", "<BR>", $vl);
        }

        $this->contrato->html = join("<BR>", $html);
        
        $this->contrato->html = str_replace("[pessoa_pessnmrz]", $this->contrato->pessoa->pessnmrz, $this->contrato->html);
        $this->contrato->html = str_replace("[pessoa_pessnmrf]", $this->contrato->pessoa->pessnmrf, $this->contrato->html);
        $this->contrato->html = str_replace("[pessoa_endereco]", $this->contrato->pessoa->pessnmrz, $this->contrato->html);
        $this->contrato->html = str_replace("[documento_seq]", $this->contrato->seq, $this->contrato->html);
        $this->contrato->html = str_replace("[produto_nome]", $this->contrato->produto->label, $this->contrato->html);
        $this->contrato->html = str_replace("[unidade_razaoSocial]", $this->contrato->unidade->razaoSocial, $this->contrato->html);
        $this->contrato->html = str_replace("[unidade_cidade]", $this->contrato->unidade->cidade, $this->contrato->html);
        $this->contrato->html = str_replace("[unidade_logradouro]", $this->contrato->unidade->logradouro, $this->contrato->html);
        $this->contrato->html = str_replace("[unidade_bairro]", $this->contrato->unidade->bairro, $this->contrato->html);
        $this->contrato->html = str_replace("[unidade_cidade]", $this->contrato->unidade->cidade, $this->contrato->html);
        $this->contrato->html = str_replace("[unidade_estado]", $this->contrato->unidade->estado, $this->contrato->html);
        $this->contrato->html = str_replace("[unidade_cnpj]", $this->contrato->unidade->cnpj, $this->contrato->html);
        $this->contrato->html = str_replace("[data_atual]", $this->contrato->dataAtual, $this->contrato->html);
        $this->contrato->html = str_replace("[conta_valor]", $this->contrato->pessoa->valorpago, $this->contrato->html);
        $this->contrato->html = str_replace("[conta_parcela]", $this->contrato->pessoa->pessnmrz, $this->contrato->html);
        $this->contrato->html = str_replace("[turma_dataTermino]", $this->contrato->especializacao->pessnmrz, $this->contrato->html);
        $this->contrato->html = str_replace("[turma_tipoCurso]", $this->contrato->especializacao->pessnmrz, $this->contrato->html);
        $this->contrato->html = str_replace("[turma_nomeCurso]", $this->contrato->especializacao->nome, $this->contrato->html);
        $this->contrato->html = str_replace("[turma_nomeTurma]", $this->contrato->especializacao->nometurma, $this->contrato->html);
        $this->contrato->html = str_replace("[turma_cargaHoraria]", $this->contrato->especializacao->cargahoraria, $this->contrato->html);

    }
    function html(){
        return $this->contrato->html;
    }

}