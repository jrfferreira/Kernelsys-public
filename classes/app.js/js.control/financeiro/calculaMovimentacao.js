function calculaMovimentacao(c_valorreal,c_multa,c_desconto,c_caixatroco,c_valorentrada,c_valorpago,c_valorcalculado){

    c_valorreal = (c_valorreal == null) ? '#valorreal' :'#'+ c_valorreal;
    c_multa = (c_multa == null) ? '#multaacrecimo' : '#'+ c_multa;
    c_desconto = (c_desconto == null) ? '#desconto' : '#'+ c_desconto;
    c_caixatroco = (c_caixatroco == null) ? '#caixatroco' : '#'+ c_caixatroco;
    c_valorentrada = (c_valorentrada == null) ? '#valorentrada' : '#'+ c_valorentrada;
    c_valorpago = (c_valorpago == null) ? '#valorpago' : '#'+ c_valorpago;
    c_valorcalculado = (c_valorcalculado == null) ? '#valorcalculado' : '#'+ c_valorcalculado;


    var valorReal = $(c_valorreal).val() ? $(c_valorreal).val() : '0,00';
    var multaAcrecimo = $(c_multa).val() ? $(c_multa).val() : '0,00';
    var desconto = $(c_desconto).val() ? $(c_desconto).val() : '0,00';
    var caixaTroco = $(c_caixatroco).val() ? $(c_caixatroco).val() : '0,00';
    var valorRecebido = $(c_valorentrada).val() ? $(c_valorentrada).val() : '0,00';
    var valorPago = $(c_valorpago).val() ? $(c_valorpago).val() : '0,00';


    valorReal = parseFloat(valorReal.replace(',','.'));

    multaAcrecimo = multaAcrecimo.replace(',','.');
    if(multaAcrecimo.search('%') > -1){
        multaAcrecimo = multaAcrecimo.replace('%','');
        multaAcrecimo = valorReal * ((parseFloat(multaAcrecimo) / 100));
        multaAcrecimo = ((Math.round(multaAcrecimo*100))/100);
    }

    desconto = desconto.replace(',','.');
    if(desconto.search('%') > -1){
        desconto = desconto.replace('%','');
        desconto = valorReal * ((parseFloat(desconto) / 100));
        desconto = ((Math.round(desconto*100))/100);
    }

    caixaTroco = parseFloat(caixaTroco.replace(',','.'));
    valorRecebido = parseFloat(valorRecebido.replace(',','.'));
    valorPago = parseFloat(valorPago.replace(',','.'));

    var valorTotal = parseFloat(valorReal) + parseFloat(multaAcrecimo) - parseFloat(desconto);
    valorRecebido = (valorRecebido == 0) ? valorTotal : valorRecebido;
    
    caixaTroco = parseFloat(valorRecebido) - parseFloat(valorTotal);
    caixaTroco = (caixaTroco < 0) ? 0 : caixaTroco;

    valorPago = parseFloat(valorRecebido) - parseFloat(caixaTroco);

    $(c_valorcalculado).val(setMoney(valorTotal));
    $(c_valorreal).val(setMoney(valorReal)).blur();
    $(c_multa).val(setMoney(multaAcrecimo)).blur();
    $(c_desconto).val(setMoney(desconto)).blur();
    $(c_caixatroco).val(setMoney(caixaTroco)).blur();
    $(c_valorpago).val(setMoney(valorPago)).blur();

}