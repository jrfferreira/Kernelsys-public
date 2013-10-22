function calculaMultas(c_vencimento,c_valorreal,c_juros){
    
    c_vencimento = (c_vencimento == null) ? '#vencimento' :'#'+ c_vencimento;
    c_valorreal = (c_valorreal == null) ? '#valorreal' :'#'+ c_valorreal;
    c_juros = (c_juros == null) ? '#juros' :'#'+ c_juros;


    var valorReal = parseFloat(($(c_valorreal).val() ? $(c_valorreal).val() : '0,00').replace(',','.'));


    if($(c_valorreal).val() && $(c_vencimento).val()){
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

    $(c_juros).val(setMoney(juros));
}