<?php
/**
* Classe setDataBP
* comment : Classe destinada a definir a data de exibição do Balan�o Patrimonial.
* version : 29/04/2009 - 15:40
* author : Jo�o Felix
*/

class setDataBP{

    /**
    * método setParam()
    * author : Wagner Borba
    * Configura o atributo vindo do objeto pai(registro responsavel pela visualização do ap�ndice)
    * param Codigo = recebe codigo do objeto pai
    */
    public function setParam($param){
        $this->param = $param;
    }

    /**
    * método get()
    * Autor: Jo�o Felix
    ****************************************************************************
    */
    public function get(){

        //Retorna Usuario logado===================================
        $obUser = new TCheckLogin();
        $obUser = $obUser->getUser();
        //=========================================================

        $dt = new TSetData();
        $dt = $dt->dataPadraoPT($dt->getData());


        //Cria bloco para definições
        $obBloco = new TElement("fieldset");
        //Cria legenda para o bloco
        $obBlocoLegend = new TElement("legend");
        $obBlocoLegend->add("Selecione a data a ser visualizada");
        $obBloco->add($obBlocoLegend);
        // campos ================================

        $obFieds = new TSetfields();
        $obFieds->geraCampo("Data:", 'data', "TEntry", '');

        $obFieds->setProperty('data', 'onkeypress', "mask(this,'99/99/9999',1,this)");
        $obFieds->setProperty('data', 'onkeyup', "mask(this,'99/99/9999',1,this)");
        $obFieds->setProperty('data', 'setSize', '100');
        $obFieds->setProperty('data', 'setValue', $dt);

        $obButton = new TButton('gerar');
        $obButton->id = "gerar";
        $obButton->value = "Visualizar";
        $obButton->setProperty("onclick","runBP('app.control/app.financeiro/viewBP.php','bl_BP')");
        $obButton->setAction(new TAction(""), "Visualizar");

        //intancia formulario
        $obBloco->add($obFieds->getConteiner());
        $obBloco->add($obButton);



        $obBloco2 = new TElement("fieldset");
        $obBloco2->id = 'bl_BP';
        $obBloco2->class = '';
        //Cria legenda para o bloco
        $obBloco2Legend = new TElement("legend");
        $obBloco2Legend->add("Balan�o patrimonial");
        $obBloco2->add($obBloco2Legend);
        $obBloco2->add("");

        $this->ob = new TElement('div');
        $this->ob->class = "";
        $this->ob->id = "captaDataBP";
        $this->ob->add($obBloco);
        $this->ob->add($obBloco2);


        return $this->ob;

    }
}
?>