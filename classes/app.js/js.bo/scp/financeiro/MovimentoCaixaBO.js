
//Executa o formulário de conferencia de movimento de caixa
function conferenciaMovimentoCaixa(ob, metodo, metodoarg, tipoObjeto, seq){
	
    var view = 'winRet';
    var retorno = exe('', getPath()+'/app.view/TMain.class.php?method='+metodo+'&tipoRetorno='+tipoObjeto+'&formseq='+metodoarg+'&key='+seq+'&ret='+view, '', 'POST', 'Sucesso');
    
    setExcecao(metodoarg, view, 'close', retorno);
}