function setCampoTurmaDisabled(){
	if($('#codigopessoa option:selected').val() != '' && $('#codigopessoa option:selected').val() != 0){
		$('#codigoturma').removeAttr('disabled');
	} else{
		$('#codigoturma').atter('disabled','disabled');
	}
}