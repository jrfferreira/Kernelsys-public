function atualizaDataCampo(id){
    var ob = document.getElementById(id);
    ob.value = getDataAtual();
    ob.onblur();
}