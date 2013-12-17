function setValorParcelaTurma(vTotal, nParcela, vMensal, event){
		
	var total = document.getElementById(vTotal),
		numero = document.getElementById(nParcela),
		parcela = document.getElementById(vMensal),
		valorParcela = parseFloat(parcela.value.replace('R$ ', '')) || 0.00,
	    valorTotal = parseFloat(total.value.replace('R$ ', '')) || 0.00,
	    numParcela = parseInt(numero.value) || 1;
	
    if(event.target == total) {
    	parcela.value = valorTotal/numParcela;
    } 
    else if(event.target == numero) {
    	total.value = (valorParcela * numParcela);
    }
    else if(event.target == parcela) {
    	total.value = (valorParcela * numParcela);
    }
}