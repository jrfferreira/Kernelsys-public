function calculaMovimentacao(c_valorreal,c_multa,c_desconto,c_juros,c_convenios,c_caixatroco,c_valorentrada,c_valorpago,c_valorcalculado,c_vencimento){

    c_valorreal = (c_valorreal == null) ? '#valorreal' :'#'+ c_valorreal;
    c_multa = (c_multa == null) ? '#acrescimo' : '#'+ c_multa;
    c_desconto = (c_desconto == null) ? '#desconto' : '#'+ c_desconto;
    c_juros = (c_juros == null) ? '#juros' : '#'+ c_juros;
    c_convenios = (c_convenios == null) ? '#convenios' : '#'+ c_convenios;
    c_caixatroco = (c_caixatroco == null) ? '#caixatroco' : '#'+ c_caixatroco;
    c_valorentrada = (c_valorentrada == null) ? '#valorentrada' : '#'+ c_valorentrada;
    c_valorpago = (c_valorpago == null) ? '#valorfinal' : '#'+ c_valorpago;
    c_valorcalculado = (c_valorcalculado == null) ? '#valorcalculado' : '#'+ c_valorcalculado;

    c_vencimento = (c_vencimento == null) ? '#vencimento' :'#'+ c_vencimento;

    if($(c_valorreal).length == 0){
    	c_valorreal = c_valorpago;
    }

    var valorReal = $(c_valorreal).val() ? $(c_valorreal).val() : '0,00';
    var multaAcrecimo = $(c_multa).val() ? $(c_multa).val() : '0,00';
    var desconto = $(c_desconto).val() ? $(c_desconto).val() : '0,00';
    var juros = $(c_juros).val() ? $(c_juros).val() : '0,00';
    var convenios = $(c_convenios).val() ? $(c_convenios).val() : '0,00';
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
    juros = parseFloat(juros.replace(',','.'));
    
    if(valorReal && $(c_vencimento).val()){
        vetDt = $(c_vencimento).val().split('/');
        f = new Date();
        i = new Date(vetDt[2],vetDt[1]-1,vetDt[0],23,59,59);
        if(f-i > 0){
            juros = (valorReal*parseInt((f-i)/86400000)*0.33/100) + (valorReal*2/100);
        }else{
            juros = 0.00;  
        }
    } else {
        juros = 0.00;        
    }

    var valorTotal = parseFloat(valorReal) + parseFloat(multaAcrecimo) - parseFloat(desconto) + parseFloat(juros) - parseFloat(convenios);
    valorRecebido = (valorRecebido == 0) ? valorTotal : valorRecebido;
    
    caixaTroco = parseFloat(valorRecebido) - parseFloat(valorTotal);
    caixaTroco = (caixaTroco < 0) ? 0 : caixaTroco;

    valorPago = parseFloat(valorRecebido) - parseFloat(caixaTroco);

    $(c_valorcalculado).val(setMoney(valorTotal));
    $(c_valorreal).val(setMoney(valorReal));
    $(c_multa).val(setMoney(multaAcrecimo));
    $(c_desconto).val(setMoney(desconto));
    $(c_juros).val(setMoney(juros));
    $(c_convenios).val(setMoney(convenios));
    $(c_caixatroco).val(setMoney(caixaTroco));
    $(c_valorpago).val(setMoney(valorPago));
    
    calculaMultas();
	
    
    button = $(c_valorpago).parents('.ui-dialog').find('.botaosalvar');
    
    if(valorTotal > 0 
		&& valorReal > 0 
		&& valorPago > 0 ){
    	button.removeAttr('disabled');
	}else{
		button.attr('disabled',true);
	}
    
    
}