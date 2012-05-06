<?php
/**
 * Classe viewBPatrimonial
 * method __construct(): Gera informações pela seleção de banco de dados.
 * method armazenaBP(): Insere registro patrimonial em dbpetrus.dbbalanco_patrimonial em função da data atual.
 * method get($dataBP): Exibe o registro em função da data ($dataBP).
 * version : 29/04/2009 - 15:40
 * author : Jo�o Felix
 */
class viewBPatrimonial {

    public $varTotCaixa = NULL;
    public $varTotContaC = NULL;
    public $Circulante = NULL;


    public function setParam($param) {

    //Retorna Usuario logado===================================
        $obUser = new TCheckLogin();
        $obUser = $obUser->getUser();
        //=========================================================

        $this->param = $param;
    }

    public function  __construct() {
    //-----------------------------------Inicio das Informações Principais-------------------------------------

    //retorna Conta D�bito
        $obTDboCD = new TDbo(TConstantes::DBPLANO_CONTAS);
        $critCD = new TCriteria();
        $critCD->add(new TFilter("tipoConta","=","D"));
        $obContaD = $obTDboCD->select("*",$critCD);

        //retorna Contas a Receber
        $obTDboCC = new TDbo(TConstantes::DBTRANSACOES_CONTAS);
        $obContaC = $obTDboCC->select("*");

        //retorna Caixa
        $obTDboCaixa = new TDbo(TConstantes::DBCAIXA);
        $critCaixa = new TCriteria();
        $critCaixa->add(new TFilter("tipomovimentacao","=","C"));
        $obCaixa = $obTDboCaixa->select("*",$critCaixa);

        //retorna Contas a Pagar
        $obTDboC = new TDbo(TConstantes::DBTRANSACOES_CONTAS);
        $obContas = $obTDboC->select("*");

        //retorna Patrimonio
        $obTDboPatr = new TDbo(TConstantes::DBPATRIMONIOS);
        $obContaPatr = $obTDboPatr->select("*");

        //retorna Parametros
        $obTDboParam = new TDbo(TConstantes::DBPARAMETROS);
        $critParam = new TCriteria();
        $critParam->add(new TFilter("id","=","1"));
        $obParametros = $obTDboParam->select("*",$critParam);


        //Gera datas para Realizavel a curto prazo

        $this->dataHoje = date(d."/".m."/".Y);
        $this->novadata = substr($this->dataHoje, -4)+2;
        $this->datafinal = "31/12/".$this->novadata;

        $this->obdata_ = new TSetData();
        $this->dtPadHoje = $this->obdata_->dataPadrao($this->dataHoje);
        $this->dtPadFinal = $this->obdata_->dataPadrao($this->datafinal);


        //------------------------------------Fim das Informações Principais--------------------------------------


        //Total caixa
        while($idCaixa = $obCaixa->fetchObject()) {
            $this->varTotCaixa = $this->varTotCaixa + $idCaixa->valorpago;


        }


        //Contas a Receber
        while($idContaC = $obContaC->fetchObject()) {
            if ($this->obdata_->dataPadrao($idContaC->vencimento) > $this->dtPadFinal) {
                $this->ValorRealizavel = $this->ValorRealizavel + $idContaC->valornominal;
            }
            else {
                $this->varTotContaC = $this->varTotContaC + $idContaC->valornominal;
            }
        }


        //Circulante
        $this->Circulante = $this->varTotContaC + $this->varTotCaixa;


        //Patrimonios
        while($idPatrimonio = $obContaPatr->fetchObject()) {

            if ($idPatrimonio->tipo == "1") {
                $this->PatrimonioT1 = $this->PatrimonioT1 + $idPatrimonio->valor;
            }
            elseif ($idPatrimonio->tipo == "2") {
                $this->PatrimonioT2 = $this->PatrimonioT2 + $idPatrimonio->valor;
            }
            elseif ($idPatrimonio->tipo == "3") {
                $this->PatrimonioT3 = $this->PatrimonioT3 + $idPatrimonio->valor;
            }
            elseif ($idPatrimonio->tipo == "4") {
                $this->PatrimonioT4 = $this->PatrimonioT4 + $idPatrimonio->valor;
            }

        }

        while($idContaD = $obContaD->fetchObject()) {
            $this->vetConta[$idContaD->categoria] = 0;
            $vetCategorias[$idContaD->codigo] = $idContaD->categoria;
        }

        $this->vetContaLabel[1] = "Funcion�rios";
        $this->vetContaLabel[2] = "Tributos";
        $this->vetContaLabel[3] = "Fornecedores";


        while($idContas = $obContas->fetchObject()) {

            if ($this->obdata_->dataPadrao($idContas->vencimento) > $this->dtPadFinal) {
                $this->ValorExigivel = $this->ValorExigivel + $idContas->valornominal;
            }else {
                $this->vetConta[$vetCategorias[$idContas->contaDebito]] = $this->vetConta[$vetCategorias[$idContas->contaDebito]]  + $idContas->valornominal;
            }
        }

        foreach($this->vetConta as $chave=>$TotContaD) {
            $this->vetConta[$chave]= $TotContaD;
            $this->TotGeralContaD = $this->TotGeralContaD + $TotContaD;
        }

        //Permanete
        $this->Permanente = $this->PatrimonioT1 + $this->PatrimonioT2 + $this->PatrimonioT3 + $this->PatrimonioT4;

        //Total Ativo
        $this->TotalAtivo = $this->Circulante + $this->Permanente + $obParametros->capitalSocial + $this->ValorRealizavel - $this->TotGeralContaD - $this->ValorExigivel;

        //Total Lucro/Prejuizo
        $this->LucroPrejuizo = $this->Circulante + $this->Permanente + $this->ValorRealizavel-  $this->ValorExigivel - $this->TotGeralContaD - $obParametros->capitalSocial;

        //Total Geral
        $this->TotalGeral = $this->TotalAtivo - $this->TotGeralContaD;

    }

    public function armazenaBP() {

        $vetInsert["totCirculanteAtivo"] = $this->Circulante;
        $vetInsert["totCaixaAtivo"] = $this->varTotCaixa;
        $vetInsert["totReceberAtivo"] = $this->varTotContaC;
        $vetInsert["realizavelAtivo"] = $this->valorRealizavel;
        $vetInsert["totPermaneteAtivo"] = $this->Permanente;
        $vetInsert["maquinarioAtivo"] = $this->PatrimonioT1;
        $vetInsert["prediosAtivo"] = $this->PatrimonioT2;
        $vetInsert["moveisAtivo"] =$this->PatrimonioT3;
        $vetInsert["veiculosAtivo"] = $this->PatrimonioT4;
        $vetInsert["totalAtivo"] = $this->TotalAtivo;
        $vetInsert["totPermanentePassivo"] = $this->TotGeralContaD;
        $vetInsert["funcionariosPassivo"] = $this->vetConta[1] ;
        $vetInsert["tributosPassivo"] = $this->vetConta[2];
        $vetInsert["fornecedoresPassivo"] = $this->vetConta[3];
        $vetInsert["exigivelPassivo"] = $this->ValorExigivel;
        $vetInsert["totCirculantePassivo"] = $this->TotGeralContaD;
        $vetInsert["patrimonioLiquidoPassivo"] = $this->TotalGeral;
        $vetInsert["capitalSocialPassivo"] = $obParametros->capitalSocial;
        $vetInsert["lucroPrejuizoPassivo"] = $this->LucroPrejuizo;
        $vetInsert["totalPassivo"] = $this->TotalAtivo;
        $vetInsert["ativo"] = 1;



        $dtComparacao = new TSetData();
        $dtComparacao = $dtComparacao->getData();


        $obComparacaoInsert = new TDbo(TConstantes::DBBALANCO_PATRIMONIAL);
        $critComparacaoInsert = new TCriteria();
        $critComparacaoInsert->add(new TFilter("datacad","=",$dtComparacao));
        $obComparacaoInsert = $obComparacaoInsert->select("*",$critComparacaoInsert);

        if($obComparacaoInsert->fetchObject()) {
            echo '<div id="retRegistro" style="margin:3px; padding:8px; border:1px solid #0066FF; text-align:center; font-family:Verdana; font-size:12px;" >Registro patrimonial de '.$dtComparacao.' já gerado anteriormente.</div>';
            exit();
        }else {
            $insert = new TDbo(TConstantes::DBBALANCO_PATRIMONIAL);
            $obInsert = $insert->insert($vetInsert);
            if ($obInsert) {
                echo '<div id="retRegistro" style="margin:3px; padding:8px; border:1px solid #0066FF; text-align:center; font-family:Verdana; font-size:12px;" >Registro patrimonial gerado com sucesso.</div>';
            }

        }
    }


    public function get($dataBP) {

        $dataBP = $this->obdata_->dataPadrao($dataBP);

        if ($dataBP != NULL) {

            if($dataBP != $this->dtPadHoje) {

                $QueryobRetSQL = new TDbo(TConstantes::DBBALANCO_PATRIMONIAL);
                $critRetSQL = new TCriteria();
                $critRetSQL->add(new TFilter("datacad","=",$dataBP));
                $QueryobRetSQL = $QueryobRetSQL->select("*",$critRetSQL);

                $obRetSQL = $QueryobRetSQL->fetchObject();

                if($obRetSQL == NULL) {
                    echo "<BR /><BR /><BR /><center>não existe relat�rio patrimonial para esta data.</center><BR /><BR />";
                    exit;
                }

                $this->Circulante = $obRetSQL->totCirculanteAtivo;
                $this->varTotCaixa = $obRetSQL->totCaixaAtivo;
                $this->varTotContaC = $obRetSQL->totReceberAtivo;
                $this->valorRealizavel = $obRetSQL->realizavelAtivo;
                $this->Permanente = $obRetSQL->totPermaneteAtivo;
                $this->PatrimonioT1 = $obRetSQL->maquinarioAtivo;
                $this->PatrimonioT2 = $obRetSQL->prediosAtivo;
                $this->PatrimonioT3 = $obRetSQL->moveisAtivo;
                $this->PatrimonioT4 = $obRetSQL->veiculosAtivo;
                $this->TotalAtivo = $obRetSQL->totalAtivo;
                $this->TotGeralContaD = $obRetSQL->totPermanentePassivo;
                $this->vetConta[1] = $obRetSQL->funcionariosPassivo;
                $this->vetConta[2] = $obRetSQL->tributosPassivo;
                $this->vetConta[3] = $obRetSQL->fornecedoresPassivo;
                $this->ValorExigivel = $obRetSQL->exigivelPassivo;
                $this->TotGeralContaD = $obRetSQL->totCirculantePassivo;
                $this->TotalGeral = $obRetSQL->patrimonioLiquidoPassivo;
                $obParametros->capitalSocial = $obRetSQL->capitalSocialPassivo;
                $this->LucroPrejuizo = $obRetSQL->lucroPrejuizoPassivo;
                $this->TotalAtivo = $obRetSQL->totalPassivo;
                $this->dtPadHoje = $obRetSQL->datacad;



            }

            $this->TotalGeralV = 'R$ '.number_format($this->TotalGeral, 2, ',', '.');


            $this->varTotCaixaV = 'R$ '.number_format($this->varTotCaixa, 2, ',', '.');
            $this->varTotContaCV = 'R$ '.number_format($this->varTotContaC, 2, ',', '.');

            $this->CirculanteV = 'R$ '.number_format($this->Circulante, 2, ',', '.');
            $this->PermanenteV = 'R$ '.number_format($this->Permanente, 2, ',', '.');
            $this->TotalAtivoV = 'R$ '.number_format($this->TotalAtivo, 2, ',', '.');
            $this->PatrimonioT1V = 'R$ '.number_format($this->PatrimonioT1, 2, ',', '.');
            $this->PatrimonioT2V = 'R$ '.number_format($this->PatrimonioT2, 2, ',', '.');
            $this->PatrimonioT3V = 'R$ '.number_format($this->PatrimonioT3, 2, ',', '.');
            $this->PatrimonioT4V = 'R$ '.number_format($this->PatrimonioT4, 2, ',', '.');
            $this->TotGeralContaDV = 'R$ '.number_format($this->TotGeralContaD, 2, ',', '.');
            $this->CapitalSocialV = 'R$ '.number_format($obParametros->capitalSocial, 2, ',', '.');
            $this->LucroPrejuizoV = 'R$ '.number_format($this->LucroPrejuizo, 2, ',', '.');
            $this->ValorRealizavelV = 'R$ '.number_format($this->ValorRealizavel, 2, ',', '.');
            $this->ValorExigivelV = 'R$ '.number_format($this->ValorExigivel, 2, ',', '.');
            $this->TotConta1V = 'R$ '.number_format($this->vetConta[1], 2, ',', '.');
            $this->TotConta2V = 'R$ '.number_format($this->vetConta[2], 2, ',', '.');
            $this->TotConta3V = 'R$ '.number_format($this->vetConta[3], 2, ',', '.');


            //Inicio Container

            $tabBPatrimonial = new TTable();
            $tabBPatrimonial->class = "tdatagrid_table";
            $tabBPatrimonial->width = "100%";

            //Inicio  (Titulos)
            $row = $tabBPatrimonial->addRow();

            $cell = $row->addCell("Ativo");
            $cell->height = "25px";
            $cell->align = "center";
            $cell->class = "tdatagrid_col";

            $cell = $row->addCell("Passivo");
            $cell->height = "25px";
            $cell->align = "center";
            $cell->class = "tdatagrid_col";

            //            //Inicio  (Titulos)
            //            $tabBPatrimonial .= '<tr><td height="25px" align="center" class="tdatagrid_col">Ativo</td><td height="25px" align="center" class="tdatagrid_col">Passivo</td></tr>';

            //Escopo Circulante
            //$tabBPatrimonial .= '<tr><td class="tdatagrid_row1" style="vertical-align:top">';


            $tempTab = new TTable();
            $tempTab->width = "100%";

            $tempRow = $tempTab->addRow();

            $tempCell = $tempRow->addCell("Total Circulante:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->CirculanteV);
            $tempCell->width = "30%";
            $tempCell->align = "right";

            //$tabBPatrimonial .= '<table width="100%"><tr><td width="70%" align="left"><b>Total Circulante:</b></td><td width="30%" align="right"><b>'.$this->CirculanteV.'</b></td></tr>';

            $tempRow = $tempTab->addRow();

            $tempCell = $tempRow->addCell("Total em Caixa:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->varTotCaixaV);
            $tempCell->width = "30%";
            $tempCell->align = "right";
            //$tabBPatrimonial .= '<tr><td width="70%" align="left">Total em Caixa:</td><td width="30%" align="right">'.$this->varTotCaixaV.'</td></tr>';

            $tempRow = $tempTab->addRow();

            $tempCell = $tempRow->addCell("Total a receber:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->varTotContaCV);
            $tempCell->width = "30%";
            $tempCell->align = "right";
            //$tabBPatrimonial .= '<tr><td width="70%" align="left">Total a Receber:</td><td width="30%" align="right">'.$this->varTotContaCV.'</td></tr>';

            $tempRow = $tempTab->addRow();

            $tempCell = $tempRow->addCell("Estoque:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell("R$ 0,00");
            $tempCell->width = "30%";
            $tempCell->align = "right";
            //$tabBPatrimonial .= '<tr><td width="70%" align="left">Estoque:</td><td width="30%" align="right">R$ 0,00</td></tr>';

            $tempRow = $tempTab->addRow();

            $tempCell = $tempRow->addCell("Cr�ditos Diversos:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell("R$ 0,00");
            $tempCell->width = "30%";
            $tempCell->align = "right";
            //$tabBPatrimonial .= '<tr><td width="70%" align="left">Cr�ditos Diversos:</td><td width="30%" align="right">R$ 0,00</td></tr>';

            $tempRow = $tempTab->addRow();

            $tempCell = $tempRow->addCell("Despesas Antecipadas:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell("R$ 0,00");
            $tempCell->width = "30%";
            $tempCell->align = "right";

            $row = $tabBPatrimonial->addRow();

            $cell = $row->addCell($tempTab);
            $cell->style = "vertical-align:top;";
            $cell->class = "tdatagrid_row1";


            $tempTab = new TTable();
            $tempTab->width = "100%";
            //$tabBPatrimonial .= '<tr><td width="70%" align="left">Despesas Antecipadas</td><td width="30%" align="right">R$ 0,00</td></tr></table><br></td>';


            $tempRow = $tempTab->addRow();

            $tempCell = $tempRow->addCell("Total Passivo:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->TotGeralContaDV);
            $tempCell->width = "30%";
            $tempCell->align = "right";
            //$tabBPatrimonial .= '<td class="tdatagrid_row1" style="vertical-align:top"><table width="100%"><tr><td width="70%" align="left"><b>Total Passivo:</b></td><td width="30%" align="right"><b>'.$this->TotGeralContaDV.'</b></td></tr><tr><td>';


            $tempRow = $tempTab->addRow();

            $tempCell = $tempRow->addCell("Funcion�rios:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->TotConta1V);
            $tempCell->width = "30%";
            $tempCell->align = "right";
            //$tabBPatrimonial .= '<tr><td width="70%" align="left">Funcion�rios</td><td width="30%" align="right">'.$this->TotConta1V.'</td></tr>';

            $tempRow = $tempTab->addRow();

            $tempCell = $tempRow->addCell("Tributos:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->TotConta2V);
            $tempCell->width = "30%";
            $tempCell->align = "right";
            //$tabBPatrimonial .= '<tr><td width="70%" align="left">Tributos</td><td width="30%" align="right">'.$this->TotConta2V.'</td></tr>';

            $tempRow = $tempTab->addRow();

            $tempCell = $tempRow->addCell("Fornecedores:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->TotConta3V);
            $tempCell->width = "30%";
            $tempCell->align = "right";
            //$tabBPatrimonial .= '<tr><td width="70%" align="left">Fornecedores</td><td width="30%" align="right">'.$this->TotConta3V.'</td></tr>';


            //$row = $tabBPatrimonial->addRow();

            $cell = $row->addCell($tempTab);
            $cell->style = "vertical-align:top;";
            $cell->class = "tdatagrid_row1";
            //$tabBPatrimonial .= '</table><br></td></tr>';



            //Realizavel Exigivel
            $row = $tabBPatrimonial->addRow();

            //            $tabBPatrimonial .= '<tr>';
            //            $tabBPatrimonial .= '<td class="tdatagrid_table"" style="vertical-align:top">';
            //            $tabBPatrimonial .= '<table width="100%" border="0">';
            //            $tabBPatrimonial .= '<tr><td width="70%"><b>Realiz�vel a Longo Prazo:</b></td><td width="30%" align="right"><b>'.$this->ValorRealizavelV.'</b></td></tr>';
            //            $tabBPatrimonial .= '</table>';
            //            $tabBPatrimonial .= '</td>';
            //            $tabBPatrimonial .= '<td class="tdatagrid_table">';
            //            $tabBPatrimonial .= '<table width="100%" border="0">';
            //            $tabBPatrimonial .= '<tr><td width="70%"><b>Exig�vel a Longo Prazo:</b></td><td width="30%" align="right"><b>'.$this->ValorExigivelV.'</b></td></tr>';
            //            $tabBPatrimonial .= '</table>';
            //            $tabBPatrimonial .= '</td>';
            //            $tabBPatrimonial .= '</tr>';

            $tempTab = new TTable();
            $tempTab->width = "100%";

            $tempRow = $tempTab->addRow();

            $tempCell = $tempRow->addCell("Realiz�vel a Longo Prazo:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->ValorRealizavelV);
            $tempCell->width = "30%";
            $tempCell->align = "right";

            $cell = $row->addCell($tempTab);
            $cell->style = "vertical-align:top;";
            $cell->class = "tdatagrid_table";

            $tempTab = new TTable();
            $tempTab->width = "100%";

            $tempRow = $tempTab->addRow();

            $tempCell = $tempRow->addCell("Exig�vel a Longo Prazo:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->ValorExigivelV);
            $tempCell->width = "30%";
            $tempCell->align = "right";

            $cell = $row->addCell($tempTab);
            $cell->style = "vertical-align:top;";
            $cell->class = "tdatagrid_table";

            //Escopo Permanente
            $row = $tabBPatrimonial->addRow();

            $tempTab = new TTable();
            $tempTab->width = "100%";

            $tempRow = $tempTab->addRow();
            $tempCell = $tempRow->addCell("Total Permanente:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->PermanenteV);
            $tempCell->width = "30%";
            $tempCell->align = "right";

            //            $tabBPatrimonial .= '<tr><td class="tdatagrid_row1" style="vertical-align:top"><br>';
            //            $tabBPatrimonial .= '<table width="100%" border="0" height="100">';
            //            $tabBPatrimonial .= '<tr><td width="70%" align="left"><b>Total Permanente:</b></td><td width="30%" align="right"><b>'.$this->PermanenteV.'</b></td></tr>';

            $tempRow = $tempTab->addRow();
            $tempCell = $tempRow->addCell("Maquin�rio:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->PatrimonioT1V);
            $tempCell->width = "30%";
            $tempCell->align = "right";

            //            $tabBPatrimonial .= '<tr><td width="70%" align="left">Maquin�rio</td><td width="30%" align="right">'.$this->PatrimonioT1V.'</td></tr>';

            $tempRow = $tempTab->addRow();
            $tempCell = $tempRow->addCell("Pr�dios:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->PatrimonioT2V);
            $tempCell->width = "30%";
            $tempCell->align = "right";

            //            $tabBPatrimonial .= '<tr><td width="70%" align="left">Pr�dios</td><td width="30%" align="right">'.$this->PatrimonioT2V.'</td></tr>';

            $tempRow = $tempTab->addRow();
            $tempCell = $tempRow->addCell("M�veis e Ut.:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->PatrimonioT3V);
            $tempCell->width = "30%";
            $tempCell->align = "right";

            //            $tabBPatrimonial .= '<tr><td width="70%" align="left">M�veis e Ut.</td><td width="30%" align="right">'.$this->PatrimonioT3V.'</td></tr>';

            $tempRow = $tempTab->addRow();
            $tempCell = $tempRow->addCell("Ve�culos:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->PatrimonioT42V);
            $tempCell->width = "30%";
            $tempCell->align = "right";

            //            $tabBPatrimonial .= '<tr><td width="70%" align="left">Ve�culos</td><td width="30%" align="right">'.$this->PatrimonioT4V.'</td></tr>';
            //            $tabBPatrimonial .= '</table></td>';

            $cell = $row->addCell($tempTab);
            $cell->style = "vertical-align:top;";
            $cell->class = "tdatagrid_row1";

            //-------------------------------------------------------------------------------------



            $tempTab = new TTable();
            $tempTab->width = "100%";

            $tempRow = $tempTab->addRow();
            $tempCell = $tempRow->addCell("Total Circulante:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->TotGeralContaDV);
            $tempCell->width = "30%";
            $tempCell->align = "right";

            $tempRow = $tempTab->addRow();
            $tempCell = $tempRow->addCell("Patrimonio L�quido:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->TotalGeralV);
            $tempCell->width = "30%";
            $tempCell->align = "right";

            $tempRow = $tempTab->addRow();
            $tempCell = $tempRow->addCell("Capital Social:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->CapitalSocialV);
            $tempCell->width = "30%";
            $tempCell->align = "right";

            $tempRow = $tempTab->addRow();
            $tempCell = $tempRow->addCell("Lucro/Prejuizo:");
            $tempCell->width = "70%";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->LucroPrejuizoV);
            $tempCell->width = "30%";
            $tempCell->align = "right";

            $cell = $row->addCell($tempTab);
            $cell->style = "vertical-align:top;";
            $cell->class = "tdatagrid_row1";

            //            $tabBPatrimonial .= '<td class="tdatagrid_row1" style="vertical-align:top"><br>';
            //            $tabBPatrimonial .= '<table width="100%" border="0" height="100">';
            //            $tabBPatrimonial .= '<tr><td width="70%" align="left"><b>Total Circulante:</b></td><td width="30%" align="right"><b>'.$this->TotGeralContaDV.'</b></td></tr>';
            //            $tabBPatrimonial .= '<tr><td width="70%" align="left"><br><b>Patrimonio L�quido:</b></td><td width="30%" align="right"><br><b>'.$this->TotalGeralV.'</b></td></tr>';
            //            $tabBPatrimonial .= '<tr><td width="70%" align="left">Capital Social:</td><td width="30%" align="right">'.$this->CapitalSocialV.'</td></tr>';
            //            $tabBPatrimonial .= '<tr><td width="70%" align="left">Lucro/Prejuizo:</td><td width="30%" align="right">'.$this->LucroPrejuizoV.'</td></tr>';
            //
            //            $tabBPatrimonial .= '</table></td></tr>';


            // total
            $row = $tabBPatrimonial->addRow();

            //            $tabBPatrimonial .= '<tr><td><table width="100%" border="0">';
            //            $tabBPatrimonial .= '<tr><td width="70%" height="25px" align="left" class="tdatagrid_col">Total Ativo</td><td width="30%" height="25px" align="right" class="tdatagrid_col">'.$this->TotalAtivoV.'</td></tr>';
            //            $tabBPatrimonial .= '</table></td>';

            $tempTab = new TTable();
            $tempTab->width = "100%";

            $tempRow = $tempTab->addRow();
            $tempCell = $tempRow->addCell("Total Ativo:");
            $tempCell->width = "70%";
            $tempCell->height = "25px";
            $tempCell->class = "tdatagrid_col";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->TotalAtivoV);
            $tempCell->width = "30%";
            $tempCell->height = "25px";
            $tempCell->class = "tdatagrid_col";
            $tempCell->align = "right";

            $cell = $row->addCell($tempTab);
            $cell->style = "vertical-align:top;";


            //            $tabBPatrimonial .= '<td><table width="100%" border="0">';
            //            $tabBPatrimonial .= '<tr><td width="70%" height="25px" align="left" class="tdatagrid_col">Total Passivo</td><td width="30%" height="25px" align="right" class="tdatagrid_col">'.$this->TotalAtivoV.'</td></tr>';
            //            $tabBPatrimonial .= '</table></td>';
            //            $tabBPatrimonial .= '</tr>';

            $tempTab = new TTable();
            $tempTab->width = "100%";

            $tempRow = $tempTab->addRow();
            $tempCell = $tempRow->addCell("Total Passivo:");
            $tempCell->width = "70%";
            $tempCell->height = "25px";
            $tempCell->class = "tdatagrid_col";
            $tempCell->align = "left";

            $tempCell = $tempRow->addCell($this->TotalAtivoV);
            $tempCell->width = "30%";
            $tempCell->height = "25px";
            $tempCell->class = "tdatagrid_col";
            $tempCell->align = "right";

            $cell = $row->addCell($tempTab);
            $cell->style = "vertical-align:top;";
            
            //            $tabBPatrimonial .= '</table>';


            //Exibe Container

            $tabBPatrimonial->show();
        }
    }



}