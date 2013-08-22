function showValorProduto(metodo, produto){
    Valores = '&seqProduto='+produto;
    dados = 'classe=TProduto&metodo=showValorProduto'+Valores;
    exe('viewValorProduto',getPath()+'/app.util/TSec.php?'+dados,'','GET','Sucesso');
}

