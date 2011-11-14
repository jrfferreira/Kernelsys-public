function setValorTotalProduto(){
    var quantidade   = document.getElementById('quantidadeproduto');
    var valornominal = document.getElementById('valornominalproduto');

    valortotal = parseFloat(valornominal.value.replace(',','.')) * parseFloat(quantidade.value.replace(',','.'));
    $('#valortotalproduto').val(valortotal);
}