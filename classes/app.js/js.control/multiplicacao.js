function multiplicacao(campo1,campo2,resposta){
    var valor1 = $('#'+campo1).val();
    var valor2 = $('#'+campo2).val();

    valor1 = valor1.replace(",",".");
    valor2 = valor2.replace(",",".");

    var total = parseFloat(valor1) * parseFloat(valor2);

    $('#'+resposta).val(total);
}


