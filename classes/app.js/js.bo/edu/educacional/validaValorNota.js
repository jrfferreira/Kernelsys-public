function validaValorNota(obj){
	if(event.type == "keypress"){
		var key = event.charCode,
			accepted = [44,46,48,49,50,51,52,53,54,55,56,57];
		if(accepted.indexOf(key) == -1){
			event.stopPropagation();
			event.preventDefault();
		}
	}else{
		var value = Number($(obj).val().replace(/[^0123456789,.]/gi,'').replace(',','.'));
		if(value > 10){
			value = 10;
		}else if(value < 0){
			value = 0;
		}
		$(obj).val(parseInt(value*100)/100);
		
	}
}