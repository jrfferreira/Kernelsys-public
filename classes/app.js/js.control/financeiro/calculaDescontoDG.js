function calculaDescontoDG(campoDescontoMax,campoDesconto){
    var descontoMax = $("#"+campoDescontoMax).val() ? $("#"+campoDescontoMax).val() : '0,00';
    var desconto = $("#" + campoDesconto).val() ? $("#" + campoDesconto).val() : '0,00';
    descontoMax = parseFloat(descontoMax.replace(',','.'));
    desconto = parseFloat(desconto.replace(',','.'));

    if(descontoMax < desconto){
        alertPetrus('O desconto ultrapassa o valor limite','Cuidado');
        $("#"+campoDesconto).val('0');
    }

}