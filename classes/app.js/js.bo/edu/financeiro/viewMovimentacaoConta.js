function viewMovimentacaoConta(ob,retorno){
    var conta = ob.value;
    Valores = '&seqconta='+conta;
    var dados = 'classe=TTransacao&metodo=viewMovimentacaoConta'+Valores;
        exe(retorno,getPath()+'/app.util/TSec.php?'+dados,'','GET','Sucesso');

}