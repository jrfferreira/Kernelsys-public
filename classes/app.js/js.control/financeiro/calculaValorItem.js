function calculaValorItem(){

    var valorUnitario = $('#valorunitario').val() ? $('#valorunitario').val() : '0,00';
    var quantidade    = $('#quantidadeproduto').val() ? $('#quantidadeproduto').val()    : '0,00';
    var valordesconto = $('#valordescontoproduto').val() ? $('#valordescontoproduto').val() : '0,00';

    valorUnitario = parseFloat(valorUnitario.replace(',','.'));

    quantidade = parseInt(quantidade.replace(',','.'));

    valordesconto = valordesconto.replace(',','.');
    if(valordesconto.search('%') > -1){
        valordesconto = valordesconto.replace('%','');
        valordesconto = valorUnitario * ((parseFloat(valordesconto) / 100));
        valordesconto = ((Math.round(valordesconto*100))/100);
    }

    valordesconto = parseFloat(valordesconto.replace(',','.'));
    
    var valorTotal = (parseFloat(valorUnitario) - parseFloat(valordesconto)) * quantidade;
    var valorDescontoTotal = parseFloat(valordesconto) * quantidade;


    if($('#valordescontototalitem').length > 0) $('#valordescontototalitem').val(valorDescontoTotal).blur();
    if($('#valortotalitem').length > 0) $('#valortotalitem').val(setMoney(valorTotal)).blur();

}
