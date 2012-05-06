<?PHP
class TScoreCard {

    public function setParam($param) {
        $this->param = $param;

        $obUser = new TCheckLogin();
        $obUser = $obUser->getUser();
        //=========================================================

        $this->obsession = new TSession();
        $this->idLista 	 = $this->obsession->getValue('idListaPrimaria');
        $this->scorecard = $this->obsession->getValue('codigoatual'.$this->idLista);
    }

    function get() {

    //INICIO - Criação de vetores

        $sqlScorecard = new TDbo(TConstantes::DBSCORECARD);
        $critScorecard = new TCriteria();
        $critScorecard->add(new TFilter("codigo","=",$this->scorecard));
        $retScorecard = $sqlScorecard->select("*");
        $obScorecard = $retScorecard->fetchObject();

        $sqlSentencas = new TDbo(TConstantes::DBSCORECARD_SENTENCA);
        $critSentencas = new TCriteria();
        $critSentencas->add(new TFilter("codigoScorecard","=",$this->scorecard));
        $retSentencas = $sqlSentencas->select("*",$critSentencas);

        $this->obCont = new TElement('div');
        $fieldset = new TElement("fieldset");
        $legenda = new TElement("legend");
        $legenda->add($obScorecard->titulo);
        $fieldset->add($legenda);

        while($obSentencas = $retSentencas->fetchObject()) {
            $colunaX = $obSentencas->colunaX;
            $colunaY = $obSentencas->colunaY;
            $tabela = strtoupper($obSentencas->tabela);


            $sqlX = new TDbo(constant("TConstantes::".$tabela));
            $retX = $sqlX->select("$colunaX,$colunaY,datacad");

            //Gera vetores sem agrupamento por datas.
            if($obScorecard->agrupamentoPeriodico == null) {
                while($obX = $retX->fetchObject()) {

                    if($obSentencas->agrupamentoY == 1) {
                        $ret[$obX->$colunaX]++;

                    }elseif($obSentencas->agrupamentoY == 2) {
                        $ret[$obX->$colunaX] += $obX->$colunaY;

                    }

                }


            }
            //Gera vetores com agrupamento por datas.
            else {
                switch($obScorecard->agrupamentoPeriodico) {
                    case 1:
                        $agrupamentoPeriodico = "Di�rio";
                        $dataDivisor = "Dia %j de 2009";
                        break;
                    case 2:
                        $agrupamentoPeriodico = "Semanal";
                        $dataDivisor = "Semana %V de %b %Y";
                        break;
                    case 3:
                        $agrupamentoPeriodico = "Mensal";
                        $dataDivisor = "%b de %Y";
                        break;
                    case 4:
                        $agrupamentoPeriodico = "Bimestral";
                        $dataDivisor = "%b de %Y";
                        break;
                    case 5:
                        $agrupamentoPeriodico = "Trimestral";
                        $dataDivisor = "%b de %Y";
                        break;
                    case 6:
                        $agrupamentoPeriodico = "Semestral";
                        $dataDivisor = "%b de %Y";
                        break;
                    case 7:
                        $agrupamentoPeriodico = "Anual";
                        $dataDivisor = "%Y";
                        break;
                }
                while($obX = $retX->fetchObject()) {

                    $data = strftime($dataDivisor, strtotime($obX->datacad));
                    if($obSentencas->agrupamentoY == 1) {
                        $ret[$obX->$colunaX][$data]++;

                    }elseif($obSentencas->agrupamentoY == 2) {
                        $ret[$obX->$colunaX][$data] += $obX->$colunaY;

                    }

                }

            }

            //FIM - Criação de vetores

            $catChart=$valsChart=$vals=$col=$valores=$cols = null;

            $lista = new TDataGrid();
            $cols[] = new TDataGridColumn($colunaX, $colunaX, "left", "100");

            foreach($ret as $ch=>$vl) {

                $valores->$colunaX = $ch;

                if(is_array($vl)) {
                    foreach($vl as $ch_=>$vl_) {

                        $catChart .= $ch_.",";
                        $valsChart .= $vl_.",";

                        $valores->periodo = $ch_;
                        $cols[] = new TDataGridColumn($ch_, $ch_, "left", "100");

                        $valores->$ch_ = $vl_;
                    }
                }else {
                    $valsChart .= $vl.",";

                    $cols[] = new TDataGridColumn($colunaY, $colunaY, "left", "100");
                    $valores->$colunaY = $vl;
                }

                $vals[] = $valores;

                $montaSentenca[] = "montaSentenca('".$ch."','".substr($valsChart,0,-1)."'); ";

                if($catChart){
                    $montaCategorias[] = "montaCategorias('".substr($catChart,0,-1)."'); ";
                }
            }

            foreach ($cols as $vl) {
                $lista->addColumn($vl);

            }
            $lista->createModel('90%');
            foreach ($vals as $vl) {
                $lista->addItem($vl);

            }

            $div = new TElement("div");
            $div->style = "padding:4px;";

            $div->add($lista);
            $div->add("<BR>");

            $fieldset->add($div);
        }

        $this->obCont->add($fieldset);

        $this->obChart = new TElement("fieldset");

        $this->divChart = new TElement("div");
        $this->divChart->id = "divChart";
        $this->divChart->style = "border:2px solid #ff0000";
        $this->divChart->add("<BR>");


        $botaoEdit = new TButton('editar');
        $botaoEdit->id = "editar";
        $botaoEdit->value = "Lan�ar Notas";

        $geraChart = "";
        foreach($montaSentenca as $vl){
            $geraChart .= $vl;
        }
        if($montaCategorias){
        foreach($montaCategorias as $vl_){
            $geraChart .= $vl_;
        }
        }
        $geraChart .= "jquerybarMultiChar('divChart','".$obScorecard->titulo."')";

        $botaoEdit->setProperty("onclick", $geraChart);
        $botaoEdit->setAction(new TAction(""), "Visualizar gr�ficos");

        $this->obChart->add($this->divChart);
        $this->obChart->add($botaoEdit);

        $this->obCont->add($this->obChart);
        return $this->obCont;
    }
}