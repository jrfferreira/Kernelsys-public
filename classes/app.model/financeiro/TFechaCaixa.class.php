<?php
//==========================================================================================
// Sistema de fechamento de caixa
// Lista todas as contas  e possibilita a visualização do hist�rico de contas fechadas
//==========================================================================================


class TFechaCaixa{

    public function setParam($param){
        $this->param = $param;
    }

    public function get(){
        
        //percorre contas caixa
        $contData = new TElement('fieldset');
        $contData->style = "padding:10px; width:100%;";
            $leg = new TElement('legend');
            $leg->add('');
        $contData->add($leg);
        $contData->add('<br>');
        
         $obCaixa = new TCaixa();
         $ob = $obCaixa->viewsCaixa();
         
         return $ob;
    }

}	

?>