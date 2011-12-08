function validaValorAlteravel(campo){
    var validacao = document.getElementById('valorAlteravel');
    var ob = document.getElementById(campo);
    if (validacao.value == '0'){
        ob.disabled = true;
    }else if(validacao.value == '1'){
        ob.disabled = false;
    }

}