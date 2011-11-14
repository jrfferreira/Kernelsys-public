function setValorTotalTransacao(){

    var somaTotalProdutos   = document.getElementById('somaTotalProdutos');
    var valorTotal          = document.getElementById('valortotal');
    var valorCorrigido      = document.getElementById('valorcorrigido');

    valorTotal.value = somaTotalProdutos.value;
    valorCorrigido.value = somaTotalProdutos.value;
    valorCorrigido.blur();
}

function setValorTotalTransacaoDG(){
    var valorprodutos = $("#valorprodutos").val() ? $('#valorprodutos').val() : '0,00';
    var valorfrete = $("#valorfrete").val() ? $('#valorfrete').val() : '0,00';
    var valordespesas = $("#valordespesas").val() ? $('#valordespesas').val() : '0,00';
    var valordesconto = $("#valordesconto").val() ? $('#valordesconto').val() : '0,00';
    var valortotal = $("#valortotal").val() ? $('#valortotal').val() : '0,00';
    var valorjuros = $("#valorjuros").val() ? $('#valorjuros').val() : '0,00';

    var valorindice = $("#valorindice").val() ? $('#valorindice').val() : '1,00';

    valorprodutos = parseFloat(valorprodutos.replace(',','.'));
    valorfrete = parseFloat(valorfrete.replace(',','.'));
    valordespesas = parseFloat(valordespesas.replace(',','.'));
    valordesconto = parseFloat(valordesconto.replace(',','.'));
    valortotal = parseFloat(valortotal.replace(',','.'));
    valorjuros = parseFloat(valorjuros.replace(',','.'));
    valorindice = parseFloat(valorindice.replace(',','.'));

    valortotal = (parseFloat(valorprodutos)) + (((parseFloat(valorprodutos)) *parseFloat(valorjuros))/100) + (parseFloat(valorfrete)) +  (parseFloat(valordespesas));

    valortotal = valortotal * valorindice  - (parseFloat(valordesconto));

    if($('#valortotal').length > 0) $('#valortotal').val(setMoney(valortotal)).blur();

}

function setValorTotalProdutosDG(){
    
    Valores = '&formulario=79';
    var dados = 'classe=TTransacao&metodo=getTotalProdutosDG'+Valores;
    var resposta = exe('',getPath()+'/app.util/TSec.php?'+dados,'','GET','Sucesso');

    resposta = resposta.split('@@');
    descontomax = resposta[1];
    total = resposta[0];

    if(descontomax == null || !descontomax) descontomax = '0.00';
    if(total == null || !total) total = '0.00';

    if($('#valormaxdesconto') && $('#valormaxdesconto').length > 0) $('#valormaxdesconto').val(setMoney(parseFloat(descontomax.replace(',','.')))).blur();
    if($('#valorprodutos') && $('#valorprodutos').length > 0) $('#valorprodutos').val(setMoney(parseFloat(total.replace(',','.')))).blur();

}

function setValorTotalProdutosVendasDG(){
    Valores = '&formulario=96';
    var dados = 'classe=TTransacao&metodo=getTotalProdutosDG'+Valores;
    var resposta = exe('',getPath()+'/app.util/TSec.php?'+dados,'','GET','Sucesso');

    resposta = resposta.split('@@');
    descontomax = resposta[1];
    total = resposta[0];

    if(descontomax == null || !descontomax) descontomax = '0.00';
    if(total == null || !total) total = '0.00';

    if($('#valormaxdesconto') && $('#valormaxdesconto').length > 0) $('#valormaxdesconto').val(setMoney(parseFloat(descontomax.replace(',','.')))).blur();
    if($('#valorprodutos') && $('#valorprodutos').length > 0) $('#valorprodutos').val(setMoney(parseFloat(total.replace(',','.')))).blur();

}