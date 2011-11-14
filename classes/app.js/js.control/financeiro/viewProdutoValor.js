function viewProdutoValor(){
	
	var valorEntrada = $('#valorEntrada').html() ? $('#valorEntrada').html() : '0,00';
    var taxas = $('#taxaadministrativa').val() ? $('#taxaadministrativa').val() : '0,00';
    var margem = $('#margem').val() ? $('#margem').val() : '0,00';
	

    valorEntrada = parseFloat(valorEntrada.replace(',','.').replace('%',''));
    taxas = parseFloat(taxas.replace(',','.').replace('%',''));
    margem = parseFloat(margem.replace(',','.').replace('%',''));

    totalTaxas = (valorEntrada*taxas/100) + (valorEntrada*margem/100);
    valorTotal = valorEntrada + totalTaxas;
    
    //$('#valorAcrecimos').html(setMoney(totalTaxas));
    $('#valorFinal').html(setMoney(valorTotal));
	
}