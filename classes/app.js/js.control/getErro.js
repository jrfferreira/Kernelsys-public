function getErro(retorno){
if(retorno){
    var erro = retorno.slice(0,5);
    if(erro == 'erro#'){
        erro = 'erro';
    }else{
        erro = '';
    }
    return erro;
}
}