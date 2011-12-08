function calculaDebitoProfessor(){

	cargahoraria = $('#cargahoraria :selected').text() ? (parseFloat($('#cargahoraria :selected').text().replace(',','.'))*100)/100 : 0;
	
	
	custohospedagem = $('#custohospedagem').val() ? (parseFloat($('#custohospedagem').val().replace(',','.'))*100)/100 : 0;
	custohora = $('#custohoraaula').val() ? (parseFloat($('#custohoraaula').val().replace(',','.'))*100)/100 : 0;
	custodeslocamento = $('#custodeslocamento').val() ? (parseFloat($('#custodeslocamento').val().replace(',','.'))*100)/100 : 0;
	custoalimentacao = $('#custoalimentacao').val() ? (parseFloat($('#custoalimentacao').val().replace(',','.'))*100)/100 : 0;
	custoextra = $('#custoextra').val() ? (parseFloat($('#custoextra').val().replace(',','.'))*100)/100 : 0;
	
	insspatrono = 20/100;
	inssprofessor = 11/100;
	
	totalcargahoraria = cargahoraria * custohora;
	totalinsspatrono = totalcargahoraria * insspatrono;
	totalinssprofessor = totalcargahoraria * inssprofessor;
	totalencargos = totalcargahoraria + totalinsspatrono - totalinssprofessor;
	totalgeral = totalencargos + custohospedagem + custodeslocamento + custoalimentacao + custoextra;
	
	
	 $('#totalcargahoraria').val(totalcargahoraria);
	 $('#totalinsspatronal').val(totalinsspatrono);
	 $('#totalinssprofessor').val(totalinssprofessor);
	 $('#totalgeralencargos').val(totalencargos);
	 $('#totalgeral').val(totalgeral);
	
}