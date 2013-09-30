<?php

function __autoload($classe){

    include_once('../../app.util/autoload.class.php');
    $autoload = new autoload('../../',$classe);
}


//Retorna Usuario logado===================================
$obUser = new TCheckLogin();
$obUser = $obUser->getUser();
//=========================================================	

$obsession = new TSession();

// Rertona movimento do caixa
$criteriaMCAixa = new TCriteria();
$criteriaMCAixa->add(new TFilter('unidade','=',$obUser->unidade->seq));
$criteriaMCAixa->add(new TFilter('statseq','=','1'));
$criteriaMCAixa->add(new TFilter('statusmovimento','=','0'));

$dboMCaixa = new TDbo(TConstantes::DBCAIXA);
$MCaixa  =  $dboMCaixa->select('*',$criteriaMCAixa);

if($MCaixa){

    while($resMCaixa = @$MCaixa->fetchObject()){

        $movCaixa[$resMCaixa->seq] =  $resMCaixa->seq;

        if($resMCaixa->tipo == "C"){
            $totalReceita = $totalReceita + $resMCaixa->valorpago;
        }
        else{
            $totalDespesa = $totalDespesa + $resMCaixa->valorpago;
        }

    }

    if(count($movCaixa) == 0){
        echo '<div style="border:10px solid #CCCCCC; font-family:Verdana; font-size:16px; color:#333333; text-align:center; margin:80px; margin-top:130px; padding:20px;">
                 O caixa de '.date("Y-m-d").' já foi fechado <br><bR>
                 <input type="button" name="botConcluiCaixa" id="botConcluiCaixa" value=" Voltar " onclick="prossExe(\'onClose\',\'listaMovimentoCaixa\',\'\',\'49\',\'\',\'displaySys\')" class="tButton"  style="font-size:18px;" />
              </div>';
        exit();
    }

    $args["usuario"] = $obUser->seq;
    $args["valorPrevisto"]  = "";
    $args["receitaTotal"] = $totalReceita;
    $args["despesaTotal"] = $totalDespesa;
    $args["statseq"]= "1";

    //gera registro de fechamento de caixa
    $dboInCaixa = new TDbo(TConstantes::DBFECHA_CAIXA);
    $retornoFxCaixa = $dboInCaixa->insert($args);

    if($retornoFxCaixa){

        //atualiza estatus do movimento de caixa
        $criteriaMovCaixa = new TCriteria();
        $criteriaMovCaixa->add(new TFilter('statusmovimento','=','0'));
        $dadosMovCx['statusmovimento'] = '1';
        $dboUpMovCaixa = new TDbo(TConstantes::DBCAIXA);
        $runMovCaixa = $dboUpMovCaixa->update($dadosMovCx, $criteriaMovCaixa);

           //atualiza historico de contas caixa ================================
                //atualiza anteriores
                $critAtualizaHist01 = new TCriteria();
                $critAtualizaHist01->add(new TFilter('statseq','=','2'));
            $dboAtualizaHist01 = new TDbo(TConstantes::DBCONTA_FINANCEIRA_HISTORICO);
            $dboAtualizaHist01->update(array("statseq"=>"3"), $critAtualizaHist01);
                //atualiza atual
                $critAtualizaHist02 = new TCriteria();
                $critAtualizaHist02->add(new TFilter('statseq','=','1'));
            $dboAtualizaHist02 = new TDbo(TConstantes::DBCONTA_FINANCEIRA_HISTORICO);
            $dboAtualizaHist02->update(array("statseq"=>"2"), $critAtualizaHist02);
          //====================================================================

        if(!$runMovCaixa){
            exit('erro ao atualizar a situação do movimento do caixa');
        }

        // emite retorno de operação relaizada com sucesso
        
        echo '<div style="border:10px solid #CCCCCC; font-family:Verdana; font-size:16px; color:#333333; text-align:center; margin:80px; margin-top:130px; padding:20px;">';
        echo 'O caixa de '.date("Y-m-d").' foi fechado com sucesso<br><hr>';
        echo '<input type="button" name="botConcluiCaixa" id="botConcluiCaixa" value=" Voltar " onclick="prossExe(\'onClose\',\'listaMovimentoCaixa\',\'\',\'49\',\'\',\'displaySys\')" class="tButton"  style="font-size:18px;" />';
        echo '</div>';
        
        $bp = new viewBPatrimonial();
        $bp = $bp->armazenaBP();
        //Comando para registro patrimonial
        
    }

    //TTransaction::close();

}