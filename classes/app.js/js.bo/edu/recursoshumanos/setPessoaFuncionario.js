function setPessoaFuncionario(method,type,seq){
	var valores = 'classe=TFuncionario&metodo=transformaPessoaFuncionario&seq='+seq;
    var retorno = exe('', getPath()+'/app.util/TSec.php',  valores, 'POST','Sucesso');
    
	if(retorno == true){
		prossExe(method,type,6,seq,'contLista7','');
	}else{
		alert('Não foi possível concluir a solicitação.');
	}
}