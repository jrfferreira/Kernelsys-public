<?php
/**
 * Classe que provê todos os métodos necessario para manipulação de produtos
 * Autor : João Felix.
 * Atualizada: João Felix - 22/03/2010
 */
class TProduto{

    private $dados = array();
    private $valida = false;

    /*
     * Configura as propriedades do produto (coluna = valor)
     */
    public function setValue($col, $valor){
        $this->dados[$col] = $valor;
    }

    /*
     * Adiciona produto na tabela dbprodutos
     */
    public function addProduto() {
        try{
            $sqlInsert = new TDbo(TConstantes::DBPRODUTOS);
            $retInsert = $sqlInsert->insert($this->dados);
            $codigoproduto = $retInsert['codigo'];

            return $codigoproduto;

        }catch (Exception $e){
            new setException($e);
        }
    }

    /*
     * Atualiza informações do produto
     */
    public function setProduto($codigoproduto){

        $sqlUpdateProduto = new TDbo(TConstantes::DBPRODUTOS);
            $critUpdateProduto = new TCriteria();
            $critUpdateProduto->add(new TFilter("codigo","=",$codigoproduto));
        $retUpdateProduto = $sqlUpdateProduto->update($this->dados, $critUpdateProduto);

        return $codigoproduto;
    }

    /*
     * Retorna o objeto produto com seus atributos
     */
    public function getProduto($col, $value){

        $prod = new TDbo(TConstantes::DBPRODUTOS);
            $criteriaProd = new TCriteria();
            $criteriaProd->add(new TFilter($col,'=',$value));
        $retProd = $prod->select('*', $criteriaProd);
        $obProd = $retProd->fetchObject();

        return $obProd;
    }

    /**
    * Gera um produto baseado no banco de paramentros de especialização
    */
    public function setProdutoParametro($idForm){

        try{

            if(!$idForm){
                throw new ErrorException("Ouve um problema na geração o produto. Entre em contato com o suporte.", 1);
            }

           $obHeader = new TSetHeader();
           $headerForm = $obHeader->getHead($idForm);
           $codigo    = $headerForm['codigo'];
           $parametro = $headerForm['entidade'];

             //Monta vetor de informações do produto=============================================
            $sqlParametros  = new TDbo(TConstantes::DBPRODUTOS_PARAMETROS);
                $critParametros = new TCriteria();
                $critParametros->add(new TFilter("tabela", "=", $parametro));
            $retParametros = $sqlParametros->select("*", $critParametros);
            $obParametros = $retParametros->fetchObject();

            //retorna informações da especialização
            $sqlSelect = new TDbo($parametro);
               $critSelect = new TCriteria();
               $critSelect->add(new TFilter("codigo","=",$codigo));
            $retSelect = $sqlSelect->select("*", $critSelect);
            $obEspecializacao = $retSelect->fetchObject();

            //seta Label via função ou valor real
            $colLabel = explode(";",$obParametros->collabel);

            if(count($colLabel) > 1){

                $classe = $colLabel[0];
                $metodo = $colLabel[1];
                $coluna = $colLabel[2];

                $classeOut = new $classe();
                $get = $classeOut->$metodo($obEspecializacao->$coluna);
                $this->setValue('label', $get);

            }else{
                $colunaLabel = $colLabel[0];
                $this->setValue('label', $obEspecializacao->$colunaLabel);
            }

            //seta Valor via função ou valor real
            $colValor = explode(";",$obParametros->colvalor);
            if(count($colValor) > 1){

                $classe =  $colValor[0];
                $metodo =  $colValor[1];
                $coluna =  $colValor[2];

                $classeOut = new $classe();
                $get = $classeOut->$metodo($obEspecializacao->$coluna);
                $this->setValue('valor', $get);

            }else{
                if($colValor){
                   $colunaValor = $colValor[0];
                   $this->setValue('valor', $obEspecializacao->$colunaValor);
                }else{
                   $this->setValue('valor', "0");
                }
            }

            //seta descrição via função ou valor real
            $colDesc = explode(";",$obParametros->coldesc);

            if(count($colDesc) > 1){

                $classe = $colDesc[0];
                $metodo = $colDesc[1];
                $coluna = $colDesc[2];

                $classeOut = new $classe();
                $get = $classeOut->$metodo($obEspecializacao->$coluna);
                $this->setValue('descricao', $get);

            }else{
                if($colDesc){
                    $colunaDescricao = $colDesc[0];
                    $this->setValue('descricao', $obEspecializacao->$colunaDescricao);
                }else{
                    $this->setValue('descricao', "0");
                }
            }

            $this->setValue('valorAlteravel', 0);
            $this->setValue('tabela', $parametro);
            $this->setValue('codigotipoproduto', $obParametros->codigotipoproduto);
            $this->setValue('ativo', 1);


            if($obEspecializacao->codigoproduto){
                $codigoproduto = $this->setProduto($obEspecializacao->codigoproduto);
            }else{
                $codigoproduto = $this->addProduto();
            }

                $sqlUpdate = new TDbo($parametro);
                $critUpdate = new TCriteria();
                $critUpdate->add(new TFilter("codigo","=",$codigo));
                $retUpdate = $sqlUpdate->update(array('codigoproduto' => $codigoproduto), $critUpdate);


            return $codigoproduto;

        }catch (Exception $e){
            new setException($e);
        }
    }

    /**
    * Comentarrrrrr
    * @param <type> $codigo
    * @param <type> $entidade
    * @return <type>
    */
    public function createProduto($codigo,$entidade){
        try{
             //Monta vetor de informações do produto=============================================
            $sqlParametros  = new TDbo(TConstantes::DBPRODUTOS_PARAMETROS);
                $critParametros = new TCriteria();
                $critParametros->add(new TFilter("tabela", "=", $entidade));
            $retParametros = $sqlParametros->select("*", $critParametros);
            $obParametros = $retParametros->fetchObject();

            //retorna informações da especialização
            $sqlSelect = new TDbo($entidade);
               $critSelect = new TCriteria();
               $critSelect->add(new TFilter("codigo","=",$codigo));
            $retSelect = $sqlSelect->select("*", $critSelect);
            $obEspecializacao = $retSelect->fetchObject();

            //seta Label via função ou valor real
            $colLabel = explode(";",$obParametros->collabel);

            if(count($colLabel) > 1){

                $classe = $colLabel[0];
                $metodo = $colLabel[1];
                $coluna = $colLabel[2];

                $classeOut = new $classe();
                $get = $classeOut->$metodo($obEspecializacao->$coluna);
                $produto['label'] =  $get;

            }else{
                $colunaLabel = $colLabel[0];
                $produto['label'] = $obEspecializacao->$colunaLabel;
            }

            //seta Valor via função ou valor real
            $colValor = explode(";",$obParametros->colvalor);
            if(count($colValor) > 1){

                $classe =  $colValor[0];
                $metodo =  $colValor[1];
                $coluna =  $colValor[2];

                $classeOut = new $classe();
                $get = $classeOut->$metodo($obEspecializacao->$coluna);
                $produto['valor'] = $get;

            }else{
                if($colValor){
                   $colunaValor = $colValor[0];
                   $produto['valor'] = $obEspecializacao->$colunaValor;
                }else{
                   $produto['valor'] = "0";
                }
            }

            //seta descrição via função ou valor real
            $colDesc = explode(";",$obParametros->coldesc);

            if(count($colDesc) > 1){

                $classe = $colDesc[0];
                $metodo = $colDesc[1];
                $coluna = $colDesc[2];

                $classeOut = new $classe();
                $get = $classeOut->$metodo($obEspecializacao->$coluna);
                $produto['descricao'] = $get;

            }else{
                if($colDesc){
                    $colunaDescricao = $colDesc[0];
                    $produto['descricao'] = $obEspecializacao->$colunaDescricao;
                }else{
                    $produto['descricao'] = "0";
                }
            }

             $produto['valorAlteravel'] = 0;
             $produto['tabela'] = $entidade;
             $produto['codigotipoproduto'] = $obParametros->codigotipoproduto;
             $produto['ativo'] = 1;

             $dbo = new TDbo('dbprodutos');
             $retprod = $dbo->insert($produto);

            $produto['codigo'] = $retprod['codigo'];
            return $produto;

        }catch (Exception $e){
            new setException($e);
        }
    }

    /*
     * Função para gerar produto a partir do formulário
     *
     */

    public function formOutFunction(){

    }


    public function reservaProduto(){

    }

    /**
     *
     * @param <type> $codigoproduto
     * @param <type> $idForm
     * @return <type>
     */
    public function apendiceSetValor($codigoproduto, $idForm){

    	$div = new TElement('div');
    	$div->class = "ui-widget-content";


    	$obHeader = new TSetHeader();
        $headerForm = $obHeader->getHead($idForm);

        $codigoproduto = $headerForm['codigoPai'];

    	$dbo = new TDbo('view_produtos');
    	$crit = new TCriteria();
    	$crit->add(new TFilter('codigo','=',$codigoproduto));
    	$ret = $dbo->select('valormedio',$crit);

    	$produto = $ret->fetchObject();
    	$valormedio = $produto->valormedio ? $produto->valormedio : '0,00';

    	$table = new TTable();
    	$table->cellspacing = 10;
    	$table->style = "font-size: 11px; width: 100%; text-align: center;";
    	$col0 = $table->addRow();

    	$row0 = $col0->addCell('Valor de Entrada');
    	$row0->class = "ui-corner-all ui-state-default";
    	//$row1 = $col0->addCell('Valor das Taxas e Margem');
    	//$row1->class = "ui-corner-all ui-state-default";
    	$row2 = $col0->addCell('Valor Final');
    	$row2->class = "ui-corner-all ui-state-default";

    	$col1 = $table->addRow();

    	$row0 = $col1->addCell('<span class=\'ui-h2\' style=\'text-align: center;\'>R$ </span><span id=\'valorEntrada\' class=\'ui-h2\' style=\'text-align: center;\'>'.number_format($valormedio,2,',','').'</span>');
    	$row0->class = "ui-state-default ui-corner-all ui-widget-content";
    	//$row1 = $col1->addCell('<div id=\'valorAcrecimos\' class=\'ui-h2\' style=\'text-align: center;\'>0,00</div>');
    	//$row1->class = "ui-state-default ui-corner-all ui-widget-content";
    	$row2 = $col1->addCell('<span class=\'ui-h2\' style=\'text-align: center;\'>R$ </span><span id=\'valorFinal\' class=\'ui-h2\' style=\'text-align: center;\'>0,00</span>');
    	$row2->class = "ui-state-default ui-corner-all ui-widget-content";

    	$div->add($table);

    	return $div;
    }

    /**
     *
     * @return <type>
     */
    public function viewValorProdutoDG(){
            $div = new TELement('div');
            $div->class = "ui-state-default";
            $div->id = "viewValorProduto";
            $div->style = "height: 140px; border: 1px solid #fff; vertical-align: top; overflow: auto; width: 100%;";
            $div->add("<div style=\"font-weight: bolder; font-size: 15px; text-align: center; width: 100%; height: 100%; vertica-align: center\"><br/><br/>Escolha um produto para visualizar o valor de venda.</div>");

            return $div;
    }

    public function showValorProduto($codigoProduto){

        try{
            $TSetModel = new TSetModel();

            $dboProduto = new TDbo('tab_produto');
            $critProduto = new TCriteria();
            $critProduto->add(new TFilter('codigo','=',$codigoProduto));
            $retProduto = $dboProduto->select('codigo,descricao,preco',$critProduto);

            $obProduto = $retProduto->fetchObject();

            $dboCondicoes = new TDbo('dbcondicoes_pagamento');
            $crit = new TCriteria();
            $crit->setProperty("order", "descricao");
            $retCondicoes = $dboCondicoes->select('descricao,indice');

            $prod = new TTable();
            $prod->style = "border: 1px solid #c3c3c3;";

			$titulo = $prod->addRow();
            while($obCondicoes = $retCondicoes->fetchObject()){
                if($count == 3) {
                    $titulo = $prod->addRow();
                    $count = 0;
                }
                $r1 = $titulo->addCell($obCondicoes->descricao,'th');
                $r1->class = 'tdatagrid_col';
                $r1->style = 'width: 180; border: 1px solid #c3c3c3; text-align: left;  padding-left: 10px;';
                $r2 = $titulo->addCell($TSetModel->setValorMonetario(($obCondicoes->indice) * $obProduto->preco));
                $r2->class = 'tdatagrid_row';
                $r2->style = 'width: 180; border: 1px solid #c3c3c3; text-align: right; padding-right: 10px;';

                    $count++;
            }

            $tabela = new TTable();
            $tabela->style = "width: 100%;";
            $tabela->cellspacing = 0;
            $tabela->cellpadding = 0;

            $row = $tabela->addRow();
            $col = $row->addCell($obProduto->descricao . " (Cod.:" . $obProduto->codigo . ")" );
            $col->style = "font-weight: bolder; font-size: 14px; padding: 2px;";

            $row = $tabela->addRow();
            $col = $row->addCell($preco);
            $row = $tabela->addRow();
            $col = $row->addCell($prod);

            $tabela->show();

        }catch(Exception $e){

        }
    }

    /**
     * Gera um Relatório simples do estoque atual do produto
     * Autor: Wagner Borba
     * Data: 22/01/2011
     */
    public function viewEstoqueProduto(){

        //Monta tabela do estoque dos produtos.
    	$table = new TTable();
    	$table->cellspacing = 0;
        $table->colspacing = 3;
        $table->border = 1;
    	$table->style = "font-family:vardana; font-size: 12px; width: 100%; text-align: center;";

        //Heade da tabela
    	$row0 = $table->addRow();
    	$col01 = $row0->addCell('Código');
    	$col01->style = "background-color:#F0F0F0; font-size:14px; font-weight:bold;";
        $col02 = $row0->addCell('Código SIT');
    	$col02->style = "background-color:#F0F0F0; font-size:14px; font-weight:bold;";
        $col03 = $row0->addCell('Produto');
    	$col03->style = "background-color:#F0F0F0; font-size:14px; font-weight:bold;";
        $col04 = $row0->addCell('Marca');
    	$col04->style = "background-color:#F0F0F0; font-size:14px; font-weight:bold;";
        $col08 = $row0->addCell('Endereço');
    	$col08->style = "background-color:#F0F0F0; font-size:14px; font-weight:bold;";
        $col05 = $row0->addCell('Qtd. Total');
    	$col05->style = "background-color:#F0F0F0; font-size:14px; font-weight:bold;";
        $col06 = $row0->addCell('Qtd. Resevada');
    	$col06->style = "background-color:#F0F0F0; font-size:14px; font-weight:bold;";
        $col07 = $row0->addCell('Qtd. Disponivel');
    	$col07->style = "background-color:#F0F0F0; font-size:14px; font-weight:bold;";

            //Monta vetor de informações do produto =============================
            $sqlEstoque  = new TDbo('view_tab_produto');
            
                $critEstoque = new TCriteria();
                $critEstoque->add(new TFilter("ativo", "=", '1'));
                $critEstoque->setProperty('order', 'endereco,descricao,marca');
                $colunas = "codigo,codigosit,descricao as produto,marca,endereco,quantidadedisponivel,quantidadereservada, (quantidadedisponivel::numeric + quantidadereservada::numeric) as quantidadetotal";
            $retEstoque = $sqlEstoque->select($colunas, $critEstoque);

            //Percorre lista de produtos
            while($obEstoques = $retEstoque->fetchObject()){

                $row1 = $table->addRow();

                $cell11 = $row1->addCell($obEstoques->codigo);
                $cell11->class = "ui-corner-all ui-state-default";
                $cell12 = $row1->addCell($obEstoques->codigosit);
                $cell12->class = "ui-corner-all ui-state-default";
                $cell13 = $row1->addCell($obEstoques->produto);
                $cell13->style = "text-align:left;";
                $cell17 = $row1->addCell($obEstoques->marca);
                $cell17->style = "text-align:left;";
                $cell18 = $row1->addCell($obEstoques->endereco);
                $cell18->style = "text-align:left;";
                $cell14 = $row1->addCell($obEstoques->quantidadetotal);
                $cell14->class = "ui-corner-all ui-state-default";
                $cell15 = $row1->addCell($obEstoques->quantidadereservada);
                $cell15->class = "ui-corner-all ui-state-default";
                $cell16 = $row1->addCell($obEstoques->quantidadedisponivel);
                $cell16->class = "ui-corner-all ui-state-default";

                $qtdTotal = $qtdTotal+$obEstoques->quantidadetotal;
                $qtdReservada = $qtdReservada+$obEstoques->quantidadereservada;
                $qtdDisponivel = $qtdDisponivel+$obEstoques->quantidadedisponivel;

            }

            //Totais da tabela
            $row2 = $table->addRow();
            $col021 = $row2->addCell('Totais:');
            $col021->style = "text-align:left; background-color:#F0F0F0; font-size:14px; font-weight:bold;";
            $col021->colspan = '5';

            $col022 = $row2->addCell($qtdTotal);
            $col022->style = "background-color:#F0F0F0; font-size:14px; font-weight:bold;";

            $col023 = $row2->addCell($qtdReservada);
            $col023->style = "background-color:#F0F0F0; font-size:14px; font-weight:bold;";

            $col024 = $row2->addCell($qtdDisponivel);
            $col024->style = "background-color:#F0F0F0; font-size:14px; font-weight:bold;";


            return $table;

    }


}