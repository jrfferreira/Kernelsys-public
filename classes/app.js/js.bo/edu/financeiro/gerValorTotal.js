function gerValorTotal(ob){

    var vUnit = document.getElementById('valorUnitario');
    var vTot = document.getElementById('valornominal');

    vTot.value = parseInt(vUnit.value) * parseInt(ob.value);
    vTot.onblur();
}