<script language="javascript">
    ///////////////////////////////////////////////////////
    //passa paramentos
    function showBoleto(conta,unidade){

        if(conta){
            window.open('../app.pagina/showBoleto.php?cod='+conta+'&unidade='+unidade+'&tipo=p&or=cl', 'boleto', 'scrollbars=yes,resizable=yes,width=700,height=600,top=50,left=200');
        }
        else{
            alertPetrus('Conta inválido');
        }
    }

    function atribuicao(){
		return null;
    }
</script>
<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
*/

class TSetInscricao {

    private $dbo = NULL;
    private $form;
    private $label = array();
    private $dados = NULL;
    private $divMsg;
    private $valida = true;
    private $editable = true;

    public function  __construct($codigoProduto, $tipo, $dados = NULL) {

        $this->unidade = "14303-1";
        $this->codigoUser = "010101-11";
        $this->dbo = new TDbo_out($this->unidade);

        $this->dados = $dados;
        $this->form = new TForm('formInscricao');
        $this->setProduto($codigoProduto, $tipo);

        $this->obSession = new TSession();

        //instancia label dos campos do furmul�rio
        $this->label['pessnmrz'] = "Nome";
        $this->label['pessnmrf'] = "CPF";
        $this->label['logradouro'] = "Endereço";
        $this->label['bairro'] = "Bairro";
        $this->label['cidade'] = "Cidade";
        $this->label['estado'] = "Estado";
        $this->label['tel1'] = "Telefone";
        $this->label['cel1'] = "Celular";
        $this->label['email1'] = "E-Mail";
        $this->label['codigotitularidade'] = "Escolaridade";

            //instancia itens do campo codigotitularidade
            $this->itensEsc['10000328-428'] = 'Pós-Doutorado';
            $this->itensEsc['10000327-427'] = 'Doutorado';
            $this->itensEsc['10000326-426'] = 'Mestrado';
            $this->itensEsc['10000325-425'] = 'Especialização';
            $this->itensEsc['10000324-424'] = 'Graduação';
            $this->itensEsc['10000320-420'] = 'Ensino Fundamental';
            $this->itensEsc['10000323-423'] = 'Ensino 2º Grau';
            $this->itensEsc['10000322-422'] = 'Ensino Segunda Fase (1º Grau)';
            $this->itensEsc['10000321-421'] = 'Ensino Primeira Fase (1º Grau)';

        if($this->dados['bot_continue']) {
            $this->setDados($this->dados);
        }
        elseif($this->dados['bot_voltar']) {

            $this->dados = $this->obSession->getValue('dados_inscricao');
            $this->setFields($this->dados);
        }
        elseif($this->dados['bot_gravar'] and count($this->dados['bot_gravar']) == 1) {

            $this->dados = $this->obSession->getValue('dados_inscricao');
            $this->store($this->dados);
            $this->setView($this->dados);
        }
        else {
            $this->setFields();
        }
    }

    /**
     *
     */
    public function setDados($dados) {

        try {

            $this->obSession->setValue('dados_inscricao', $dados);

            foreach($dados as $campo=>$valor) {
                if($valor == "") {
                    $this->valida = false;
                    $this->setMsg("O campo (".$this->label[$campo].") não pode ser vazio.");
                    continue;
                }

                if($campo == 'pessnmrf'){
                        $TSetControl = new TSetControl();
                        $retCpf = $TSetControl->setTrueCpf($valor);

                        if($retCpf != false){
                            $dados[$campo] = $retCpf;
                        }else{
                            $this->valida = false;
                            $this->setMsg("CPF Inválido.");
                        }
                 }
            }

            if($this->valida) {
                $this->setView($dados);
            }
            else {
                $this->setFields($dados);
            }
        }catch (Exception $e) {
            echo $e;
        }
    }

    /**
     *
     * param <type> $msg
     */
    private function setMsg($msg) {
        //display de mensagens
        $div = new TElement('div');
        $div->class = "msg";
        $div->add($msg);

        if(!$this->divMsg) {
            $this->divMsg = new TElement('div');
            $this->divMsg->class = "display_msg";
        }
        $this->divMsg->add($div);
    }

    /**
     *
     * param <type> $dados
     */
    private function setView($dados) {

        foreach($dados as $campo=>$valor) {

            if($campo == "codigotitularidade"){
                $valor = $this->itensEsc[$valor];
            }

            $this->campos[$campo] = new TElement('span');
            $this->campos[$campo]->class = "campos_view";
            $this->campos[$campo]->add($valor);

        }

        if(!$this->sucesso){
            $this->bots['bot_voltar'] = new TElement('input');
            $this->bots['bot_voltar']->type = "submit";
            $this->bots['bot_voltar']->name = "bot_voltar";
            $this->bots['bot_voltar']->class = "campos_bot";
            $this->bots['bot_voltar']->value = "Voltar";

            $this->bots['bot_gravar'] = new TElement('input');
            $this->bots['bot_gravar']->type = "submit";
            $this->bots['bot_gravar']->name = "bot_gravar";
            $this->bots['bot_gravar']->class = "campos_bot";
            $this->bots['bot_gravar']->value = "Gravar";
        }
    }

    /**
     *
     */
    private function setFields($dados = NULL) {

        //campos do formulario
        $this->campos['pessnmrz'] = new TEntry('pessnmrz');
        $this->campos['pessnmrz']->class = "campos";
        $this->campos['pessnmrz']->setSize("280");
        $this->campos['pessnmrz']->setEditable($this->editable);

        $this->campos['pessnmrf'] = new TEntry('pessnmrf');
        $this->campos['pessnmrf']->class = "campos";
        $this->campos['pessnmrf']->setSize("100");
        $this->campos['pessnmrf']->setEditable($this->editable);
        $this->campos['pessnmrf']->maxlength = '11';

        $this->campos['logradouro'] = new TEntry('logradouro');
        $this->campos['logradouro']->class = "campos";
        $this->campos['logradouro']->setSize("280");
        $this->campos['logradouro']->setEditable($this->editable);

        $this->campos['bairro'] = new TEntry('bairro');
        $this->campos['bairro']->class = "campos";
        $this->campos['bairro']->setSize("200");
        $this->campos['bairro']->setEditable($this->editable);

        $this->campos['cidade'] = new TEntry('cidade');
        $this->campos['cidade']->class = "campos";
        $this->campos['cidade']->setSize("200");
        $this->campos['cidade']->setEditable($this->editable);

        $this->campos['estado'] = new TCombo('estado');
        $this->campos['estado']->class = "campos";
        $this->campos['estado']->setSize("50");
        $this->campos['estado']->setEditable($this->editable);
        $itensUF[''] = 'UF';
        $itensUF['AC'] = 'AC';
        $itensUF['AL'] = 'AL';
        $itensUF['AM'] = 'AM';
        $itensUF['AP'] = 'AP';
        $itensUF['BA'] = 'BA';
        $itensUF['CE'] = 'CE';
        $itensUF['DF'] = 'DF';
        $itensUF['ES'] = 'ES';
        $itensUF['GO'] = 'GO';
        $itensUF['MA'] = 'MA';
        $itensUF['MG'] = 'MG';
        $itensUF['MS'] = 'MS';
        $itensUF['MT'] = 'MT';
        $itensUF['PA'] = 'PA';
        $itensUF['PB'] = 'PB';
        $itensUF['PE'] = 'PE';
        $itensUF['PI'] = 'PI';
        $itensUF['PR'] = 'PR';
        $itensUF['RJ'] = 'RJ';
        $itensUF['RN'] = 'RN';
        $itensUF['RO'] = 'RO';
        $itensUF['RR'] = 'RR';
        $itensUF['RS'] = 'RS';
        $itensUF['SC'] = 'SC';
        $itensUF['SE'] = 'SE';
        $itensUF['SP'] = 'SP';
        $itensUF['TO'] = 'TO';
        $this->campos['estado']->addItems($itensUF);

        $this->campos['tel1'] = new TEntry('tel1');
        $this->campos['tel1']->class = "campos";
        $this->campos['tel1']->setSize("100");
        $this->campos['pessnmrz']->setEditable($this->editable);

        $this->campos['cel1'] = new TEntry('cel1');
        $this->campos['cel1']->class = "campos";
        $this->campos['cel1']->setSize("100");
        $this->campos['cel1']->setEditable($this->editable);

        $this->campos['email1'] = new TEntry('email1');
        $this->campos['email1']->class = "campos";
        $this->campos['email1']->setSize("280");
        $this->campos['email1']->setEditable($this->editable);

        $this->campos['codigotitularidade'] = new TCombo('codigotitularidade');
        $this->campos['codigotitularidade']->class = "campos";
        $this->campos['codigotitularidade']->setSize("200");
        $this->campos['codigotitularidade']->setEditable($this->editable);
        $this->campos['codigotitularidade']->addItems($this->itensEsc);

        $this->bots['continuar'] = new TElement('input');
        $this->bots['continuar']->type = "submit";
        $this->bots['continuar']->name = "bot_continue";
        $this->bots['continuar']->class = "campos_bot";
        $this->bots['continuar']->value = "Continuar";
        if(!$this->editable) {
            $this->bots['continuar']->disabled = "disabled";
        }

        $this->form->setFields($this->campos);
        if($dados) {
            $this->form->setData($dados);
        }
    }

    /**
     *
     */
    private function setConteiner() {

        //conteiner
        $this->conteiner = new TTable();
        $this->conteiner->class = "conteiner_inscricao";
        $this->conteiner->cellspacing = "5px";
        $this->conteiner->cellpadding = "5px";

        $row0 = $this->conteiner->addRow();
        $this->box = $row0->addCell('');
        $this->box->colspan = '2';

        $row1 = $this->conteiner->addRow();
        $cellLabel1 = $row1->addCell($this->label['pessnmrz'].':* ');
        $cellLabel1->class = 'titulo_campo';
        $cellCampo1 = $row1->addCell($this->campos['pessnmrz']);
        $cellCampo1->class = 'conteiner_campo';

        $row2 = $this->conteiner->addRow();
        $cellLabel2 = $row2->addCell($this->label['pessnmrf'].':* ');
        $cellLabel2->class = 'titulo_campo';
        $cellCampo2 = $row2->addCell($this->campos['pessnmrf']);
        $cellCampo2->class = 'conteiner_campo';

        $row3 = $this->conteiner->addRow();
        $cellLabel3 = $row3->addCell($this->label['logradouro'].':* ');
        $cellLabel3->class = 'titulo_campo';
        $cellCampo3 = $row3->addCell($this->campos['logradouro']);
        $cellCampo3->class = 'conteiner_campo';

        $row4 = $this->conteiner->addRow();
        $cellLabel4 = $row4->addCell($this->label['bairro'].':* ');
        $cellLabel4->class = 'titulo_campo';
        $cellCampo4 = $row4->addCell($this->campos['bairro']);
        $cellCampo4->class = 'conteiner_campo';

        $row5 = $this->conteiner->addRow();
        $cellLabel5 = $row5->addCell($this->label['cidade'].'/'.$this->label['estado'].':* ');
        $cellLabel5->class = 'titulo_campo';
        $cellCampo5 = $row5->addCell($this->campos['cidade']);
        $cellCampo5->add($this->campos['estado']);
        $cellCampo5->class = 'conteiner_campo';

        $row6 = $this->conteiner->addRow();
        $cellLabel6 = $row6->addCell($this->label['tel1'].':* ');
        $cellLabel6->class = 'titulo_campo';
        $cellCampo6 = $row6->addCell($this->campos['tel1']);
        $cellCampo6->class = 'conteiner_campo';

        $row7 = $this->conteiner->addRow();
        $cellLabel7 = $row7->addCell($this->label['cel1'].':* ');
        $cellLabel7->class = 'titulo_campo';
        $cellCampo7 = $row7->addCell($this->campos['cel1']);
        $cellCampo7->class = 'conteiner_campo';

        $row8 = $this->conteiner->addRow();
        $cellLabel8 = $row8->addCell($this->label['email1'].':* ');
        $cellLabel8->class = 'titulo_campo';
        $cellCampo8 = $row8->addCell($this->campos['email1']);
        $cellCampo8->class = 'conteiner_campo';

        $row9 = $this->conteiner->addRow();
        $cellLabel9 = $row9->addCell($this->label['codigotitularidade'].':* ');
        $cellLabel9->class = 'titulo_campo';
        $cellCampo9 = $row9->addCell($this->campos['codigotitularidade']);
        $cellCampo9->class = 'conteiner_campo';

        //bot�o
        $row10 = $this->conteiner->addRow();
        $cellCampo10 = $row10->addCell("");
        if($this->bots and count($this->bots) > 0){
            foreach($this->bots as $bot=>$ob) {
                $cellCampo10->add($ob);
            }
        }
        $cellCampo10->class = 'conteiner_bot';
        $cellCampo10->colspan = '2';
    }

    /**
     *
     * param <type> $escProduto
     */
    private function setProduto($codigoProduto, $tipo) {
        try {
                $label['nome'] = "Curso: ";
                $label['nometurma'] = "Turma: ";
                $label['local'] = "Local das Aulas: ";
                $label['valor'] = "Valor do curso: ";

                $label['descontos'] = "Descontos por Pontualidade:";

                $contProd = new TTable();
                $contProd->class = "conteiner_produto";
                $contProd->cellspacing = "5px";
                $contProd->cellpadding = "5px";

            if(isset($codigoProduto) and $tipo == "i") {

                //retorna inform�ções do produto
                $this->dbo->setEntidade("dbprodutos");
                    $criteriaProd = new TCriteria();
                    $criteriaProd->add(new TFilter('codigo','=',$codigoProduto));
                    $criteriaProd->add(new TFilter('ativo','=','1'));
                $retProd = $this->dbo->select("*", $criteriaProd);
                $obProd = $retProd->fetch(PDO::FETCH_ASSOC);
                               
                $this->dbo->setEntidade($obProd['tabela']);
                    $criteriaEspec = new TCriteria();
                    $criteriaEspec->add(new TFilter('codigoproduto','=',$obProd['codigo']));
                $retEspec = $this->dbo->select('*', $criteriaEspec);
                $obEspec = $retEspec->fetch(PDO::FETCH_ASSOC);
                
                $this->dbo->setEntidade("dbcursos");
                    $criteriaCurso = new TCriteria();
                    $criteriaCurso->add(new TFilter('codigo','=',$obEspec['codigocurso']));
                $retCurso = $this->dbo->select('*', $criteriaCurso);
                $obCurso = $retCurso->fetch(PDO::FETCH_ASSOC);

                $this->produto = $obEspec + $obCurso + $obProd;

                $this->produto["tipo"] = "i";

                $this->dbo->setEntidade("dbturmas_convenios");
                $criteriaDescontos = new TCriteria();
                $criteriaDescontos->add(new TFilter('codigoturma','=',$obEspec['codigo']));
                $retDescontos = $this->dbo->select('codigoconvenio', $criteriaDescontos);
                while($obDescontos = $retDescontos->fetch(PDO::FETCH_ASSOC)){
                    $arrayConvenios[] = $obDescontos['codigoconvenio'];
                }

                $tConvenios = new TConvenios();
                $descontosPontualidade = $tConvenios->getTextoConvenios($arrayConvenios,$this->produto['valormensal']);

                if($descontosPontualidade == '') $descontosPontualidade = "Não Informado.";
                $row1 = $contProd->addRow();
                $cellLabel1 = $row1->addCell($label['nome']);
                $cellLabel1->class = 'titulo_info';
                $cellCampo1 = $row1->addCell($this->produto['nome']);
                $cellCampo1->class = 'conteiner_info';

                $row2 = $contProd->addRow();
                $cellLabel2 = $row2->addCell($label['nometurma']);
                $cellLabel2->class = 'titulo_info';
                $cellCampo2 = $row2->addCell($this->produto['titulo']);
                $cellCampo2->class = 'conteiner_info';

                $row2 = $contProd->addRow();
                $cellLabel2 = $row2->addCell($label['local']);
                $cellLabel2->class = 'titulo_info';
                $cellCampo2 = $row2->addCell($this->produto['localaulas']);
                $cellCampo2->class = 'conteiner_info';

                $row2 = $contProd->addRow();
                $cellLabel2 = $row2->addCell($label['valor']);
                $cellLabel2->class = 'titulo_info';
                $cellCampo2 = $row2->addCell('R$ '.number_format($this->produto['valortotal'], 2, ',','.') . " (".$this->produto['numparcelas']."x de R$ ".number_format($this->produto['valormensal'], 2, ',','.').")");
                $cellCampo2->class = 'conteiner_info';

                $row2 = $contProd->addRow();
                $cellLabel2 = $row2->addCell($label['descontos']);
                $cellLabel2->class = 'titulo_info';
                $cellCampo2 = $row2->addCell($descontosPontualidade);
                $cellCampo2->class = 'conteiner_info';

            }
            elseif($tipo == "d"){

                 $this->dbo->setEntidade("dbcursos");
                    $criteriaCurso = new TCriteria();
                    $criteriaCurso->add(new TFilter('codigo','=',$codigoProduto));
                    $criteriaCurso->add(new TFilter('ativo','=','1'));
                $retCurso = $this->dbo->select('*', $criteriaCurso);
                $obCurso = $retCurso->fetch(PDO::FETCH_ASSOC);

                $this->produto = $obCurso;
                $this->produto['codigocurso'] = $obCurso['codigo'];
                $this->produto['tipo'] = "d";

                $row1 = $contProd->addRow();
                $cellLabel1 = $row1->addCell($label['nome']);
                $cellLabel1->class = 'titulo_info';
                $cellCampo1 = $row1->addCell($this->produto['nome']);
                $cellCampo1->class = 'conteiner_info';

            }
            else {

                $contProd = new TElement('div');
                $contProd->class = "conteiner_produto";
                $contProd->add("Nenhuma Turma Foi definida.<br> Por favor selecione uma turma para se inscrever.");

                $this->editable = false;
            }

            $this->contProd = $contProd;

        }catch (Exception $e) {
            echo $e;
        }
    }

    /**
     *
     * param <type> $codigopessoa = Codigo da pessoa associada a transação
     * param array $dadosProduto = vetor com os dados do produto (curso - turma)
     */
    private function setTransacao($codigopessoa, array $dadosProduto) {

        $DadosTransac['codigopessoa'] = $codigopessoa;
        $DadosTransac['tipomovimentacao'] = 'C';
        $DadosTransac['valortotal'] = $dadosProduto['valortotal'];
        $DadosTransac['valorcorrigido'] = $dadosProduto['valortotal'];
        $DadosTransac['codigoplanoconta'] = $dadosProduto['codigoplanoconta'];
        $DadosTransac['numparcelas'] = $dadosProduto['numparcelas'];
        $DadosTransac['datafixavencimento'] = 0;
        $DadosTransac['vencimento'] = $dadosProduto['datainicio'];
        $DadosTransac['efetivada'] = $dadosProduto['efetivada'];

        $this->dbo->setEntidade("dbtransacoes");
        $obTransac = $this->dbo->insert($DadosTransac);

        //Gera primeira parcela
        $transacConta['codigotransacao'] = $obTransac['codigo'];
        $transacConta['codigopessoa'] = $codigopessoa;
        $transacConta['codigoplanoconta'] = $dadosProduto['codigoplanoconta'];
        $transacConta['tipomovimentacao'] = 'C';
        $transacConta['valornominal'] = $dadosProduto['valormensal'];
        $transacConta['numparcela'] = '1';
        $transacConta['desconto'] = $dadosProduto['valordescontado'];
        $transacConta['vencimento'] = $dadosProduto['datainicio'];
        $transacConta['obs'] = $dadosProduto['obs'];
        $transacConta['statusconta'] = '1';

        $this->dbo->setEntidade("dbtransacoes_contas");
        $obTransacConta = $this->dbo->insert($transacConta);

        //Gera relacionamento da trasação com produtos
        $transac_produto['codigotransacao'] = $obTransac['codigo'];
        $transac_produto['codigoproduto']   = $dadosProduto['codigoproduto'];
        $transac_produto['tabelaproduto']   = $dadosProduto['tabela'];
        $transac_produto['valornominal']    = $dadosProduto['valortotal'];
        $transac_produto['obs']             = $dadosProduto['obs'];

        $this->dbo->setEntidade("dbtransacoes_produtos");
        $obTransacProduto = $this->dbo->insert($transac_produto);

        return $obTransac['codigo'];

    }

        /**
     *
     * param <type> $codigopessoa = codigo da pessoa relacionada
     * param <type> $codigoTurma  = codigo da turma relacionada a taxa
     */
    private function setTaxaInscricao($codigopessoa, $codigoTurma){
        try{

            $this->dbo->setEntidade("dbprodutos");
                $criteriaProduto = new TCriteria();
                $criteriaProduto->add(new TFilter('tabela','=',$codigoTurma));
                $criteriaProduto->add(new TFilter('ativo','=','1'));
            $retTaxaProd = $this->dbo->select("*", $criteriaProduto);
            $taxaProd = $retTaxaProd->fetch(PDO::FETCH_ASSOC);

            $dadosTaxa['codigoproduto'] = $taxaProd['codigo'];
            $dadosTaxa['valortotal'] = $taxaProd['valor'];
            $dadosTaxa['valorcorrigido'] = $taxaProd['valor'];
            $dadosTaxa['valormensal']  = $taxaProd['valor'];
            $dadosTaxa['tipomovimentacao'] = 'C';
            $dadosTaxa['codigoplanoconta'] = $this->produto['codigoplanoconta'];
            $dadosTaxa['numparcelas'] = '1';
            $dadosTaxa['datainicio'] = $this->produto['datainicio'];
            $dadosTaxa['datavencimento'] = $this->produto['datainicio'];
            $dadosTaxa['efetivada'] = '1';
            $dadosTaxa['valordescontado'] = 0;
            $dadosTaxa['obs'] = "Taxa de inscrição - Turma - ".$this->produto['nometurma'];
            $dadosTaxa['tabela'] = $codigoTurma;

            $codigoTransacTaxa = $this->setTransacao($codigopessoa, $dadosTaxa);

            return $codigoTransacTaxa;

        }catch(Exception $e){
            echo $e;
        }
    }

    /**
     *
     * param <type> $dados
     */
    private function store($dados) {
        try {

            if($dados) {

                //dados formação
                $dadosFormacao['codigotitularidade'] = $dados['codigotitularidade'];

                    //prepara vetor de dados
                    unset($dados['bot_continue']);
                    unset($dados['bot_voltar']);
                    unset($dados['bot_gravar']);
                    unset($dados['codigotitularidade']);


                    

                    $dados['tipo']    = 'F';
                    $dados['cliente'] = true;
                    $dados['ativo']   = '1';

                //valida pessoa
                $pessoa = $this->validaPessoa($dados);
                $this->dbo->setEntidade("dbpessoas");

                if($pessoa === false){
                    $dboPessoa = $this->dbo->insert($dados);
                }else{
                    $criteriaPessoa = new TCriteria();
                    $criteriaPessoa->add(new TFilter('codigo','=',$pessoa));
                    $upDatePessoa = $this->dbo->update($dados, $criteriaPessoa);

                    $dboPessoa['codigo'] = $pessoa;
                }

                if($dboPessoa) {

                    //grava formação academica
                    if($pessoa === false){
                        $dadosFormacao['codigopessoa'] = $dboPessoa['codigo'];
                        $this->dbo->setEntidade("dbpessoas_formacoes");
                        $dboPessoaFormacao = $this->dbo->insert($dadosFormacao);
                    }

                    //valida inscrição
                    $inscricao = $this->validaInscricao($dboPessoa['codigo'], $this->produto['codigo']);


                   if($this->produto['tipo'] == "i"){
                    if($inscricao === false){
                            //transação da 1 parcela
                            $this->produto['efetivada'] = '2';
                            $codigoTransacao = $this->setTransacao($dboPessoa['codigo'], $this->produto);

                            //transação taxa de inscrição
                            if($this->produto['valortaxa'] > 0){
                                $codigoTransacaoTaxa = $this->setTaxaInscricao($dboPessoa['codigo'], $this->produto['codigo']);
                            }
                            
                            

                        //instancia dados da inscricao
                        $this->inscricao['codigopessoa'] = $dboPessoa['codigo'];
                        $this->inscricao['codigotransacao'] = $codigoTransacao;
                        $this->inscricao['codigoturma'] = $this->produto['codigo'];
                        $this->inscricao['codigocurso'] = $this->produto['codigocurso'];
                       // $this->inscricao['tipo'] = $this->produto['tipo'];
                       // $this->inscricao['tipocurso'] = $this->produto['tipocurso'];
                        $this->inscricao['opcobranca'] = '1';
                        $this->inscricao['ativo'] = '1';
             			$this->inscricao['vencimentomatricula'] = $this->produto['datainicio'];
             			$this->inscricao['vencimentotaxa'] = date('d/m/Y',strtotime('+5 days'));

                        $this->dbo->setEntidade("dbpessoas_inscricoes");
                        $obInscricao = $this->dbo->insert($this->inscricao);

                        $this->setSucesso($codigoTransacao, $codigoTransacaoTaxa);

                     }else{
                        $this->setMsg("Você já está inscrito nesta turma. <br> O número da inscrição referente é ".$inscricao);
                    }
                    }else{
                         $this->demanda['codigopessoa'] = $dboPessoa['codigo'];
                        $this->demanda['codigocurso'] = $this->produto['codigocurso'];
                        $this->demanda['ativo'] = '1';

                        $this->dbo->setEntidade("dbpessoas_demandas");
                        $obDemanda = $this->dbo->insert($this->demanda);

                        $this->setSucesso($this->produto['tipo'],$codigoTransacao, $codigoTransacaoTaxa);
                    }
                    $this->sucesso = true;
                }

            }else {
                throw new ErrorException("Os dados não são válidos");
            }

        }catch (Exception $e) {
            echo $e;
        }
    }

    private function validaPessoa($dados){
        try {

            $TDbo = new TDbo_out('14303-1','dbpessoas');
                $criteriaPessoa = new TCriteria();
                $criteriaPessoa->add(new TFilter('pessnmrf','=',$dados['pessnmrf']));
            $retPessoa = $TDbo->select('codigo', $criteriaPessoa);
            $obPessoa = $retPessoa->fetch(PDO::FETCH_ASSOC);

            if($obPessoa['codigo']){
                return $obPessoa['codigo'];
            }else{
                return false;
            }

        }catch (Exception $e) {
            echo $e;
        }
    }

    private function validaInscricao($codigopessoa, $codigoTurma){
        try {

            $this->dbo->setEntidade('dbpessoas_inscricoes');
                $criteriaInscricao = new TCriteria();
                $criteriaInscricao->add(new TFilter('codigopessoa','=',$codigopessoa));
                $criteriaInscricao->add(new TFilter('codigoturma','=',$codigoTurma));
            $retInscricao = $this->dbo->select('codigo', $criteriaInscricao);
            $obInscricao = $retInscricao->fetch(PDO::FETCH_ASSOC);

            if($obInscricao['codigo']){
                return $obInscricao['codigo'];
            }
            else{
                return false;
            }

        }catch (Exception $e) {
            echo $e;
        }
    }

    /**
     *
     */
    public function setSucesso($tipo,$codigoTransacao, $codigoTransacaoTaxa = NULL) {
        try {
            //==================================================================
            //aloca usuario padrao sem privilegios para Impressão dos boletos
            $setId = new TSetControl();
            $idSessao = $setId->setPass($setId->getSessionPass('portaCopo'));

                $obUnidade = new stdClass();
                $obUnidade->codigo = $this->unidade;

                $obUser =  new stdClass();
                $obUser->codigouser  = $this->codigoUser;
                $obUser->codigo  = $this->codigoUser;
                $obUser->codigopessoa  = $this->codigoUser;
                $obUser->nomepessoa = "usuario externo";
                $obUser->cpf = "000.000.000-11";
                $obUser->unidade = $obUnidade;
                $obUser->datalog = date(d."/".m."/".Y);
                $obUser->horalog = date(H.":".i.":".s);
                $obUser->codigoTema = "";

                $this->obSession->setValue($idSessao, $obUser);
                $this->obSession->setValue('pathDB', '../app.config/my_dbpetrus');
            //==================================================================

            $this->divSucesso = new TElement('div');
            $this->divSucesso->class = "conteiner_sucesso";
            $this->divSucesso->add("Sua inscrição foi efetivada com sucesso<br><br>");
            //$this->divSucesso->add("Obrigado por se juntar a nos.<br><br>");
if($tipo == 'i'){
            $this->divSucesso->add("- Se desejar você já pode imprimir o boleto da taxa de inscrição <br>");
            $this->divSucesso->add("e da matrícula clicando nos botões correspondentes.<br><br>");

            $this->dbo->setEntidade("dbtransacoes_contas");
                $criteriaConta = new TCriteria();
                $criteriaConta->add(new TFilter('codigotransacao','=',$codigoTransacao));
                $criteriaConta->add(new TFilter('numparcela','=','1'));
             $retConta = $this->dbo->select("codigo", $criteriaConta);
             $obConta = $retConta->fetch(PDO::FETCH_ASSOC);

            $this->bots_boleto['bot_matricula'] = new TElement("input");
            $this->bots_boleto['bot_matricula']->type="button";
            $this->bots_boleto['bot_matricula']->name="botMatricula";
            $this->bots_boleto['bot_matricula']->id="botMatricula";
            $this->bots_boleto['bot_matricula']->onClick="showBoleto('".$obConta['codigo']."','".$this->unidade."')";
            $this->bots_boleto['bot_matricula']->value=" Imprimir boleto da matrícula ";

            //$this->divSucesso->add($this->bots_boleto['bot_matricula']);

            if($codigoTransacaoTaxa){

                 $this->dbo->setEntidade("dbtransacoes_contas");
                    $criteriaContaTaxa = new TCriteria();
                    $criteriaContaTaxa->add(new TFilter('codigotransacao','=',$codigoTransacaoTaxa));
                    $criteriaContaTaxa->add(new TFilter('numparcela','=','1'));
                 $retContaTaxa = $this->dbo->select("codigo", $criteriaContaTaxa);
                 $obContaTaxa = $retContaTaxa->fetch(PDO::FETCH_ASSOC);

                $this->bots_boleto['bot_Taxa'] = new TElement("input");
                $this->bots_boleto['bot_Taxa']->type="button";
                $this->bots_boleto['bot_Taxa']->name="botTaxa";
                $this->bots_boleto['bot_Taxa']->id="botTaxa";
                $this->bots_boleto['bot_Taxa']->onClick="showBoleto('".$obContaTaxa['codigo']."','".$this->unidade."')";
                $this->bots_boleto['bot_Taxa']->value=" Imprimir boleto da Taxa ";

                //$this->divSucesso->add($this->bots_boleto['bot_Taxa']);
            }
}

        }catch (Exception $e) {
            echo $e;
        }
    }

    public function show($estilo = null) {

        $this->setConteiner();
        $this->box->add($this->contProd);

        if($this->divMsg) {
            $this->box->add($this->divMsg);
        }

        $this->dbo->close();

        $this->form->add($this->conteiner);

        $obCss = new TElement('link');
        $obCss->type = "text/css";
        if($estilo == null){
        	$obCss->href="estilo_gap/estilo.css";
        }else{
        	$obCss->href="{$estilo}/estilo.css";
        }
        $obCss->rel="Stylesheet";

        if($this->divSucesso){
            $this->box->add($this->divSucesso);
        }

        $page = new TPage('Formulário de Inscrição');
        $page->addHead($obCss);
        $page->add($this->form);
        $page->show();
    }

}



function __autoload($classe) {
    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}

$form = new TSetInscricao($_GET['prod'], $_GET['tipo'], $_POST);
$form->show($_GET['estilo']);
?>
