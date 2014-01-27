function setMatricula(obj, confirme){

    var codigoInscricao = $('#seq').val(),
    	datainiciovencimentos   = $('#datainiciovencimentos').val(),
    	padraovencimento   = $('#padraovencimento').val(),
    	cofiseq				= $('#cofiseq').val();
    
    if(codigoInscricao && confirm(confirme)){

        var dados = 'classe=TMatricula&metodo=setMatricula&inscseq='+codigoInscricao+'&datainiciovencimentos='+datainiciovencimentos+'&padraovencimento='+padraovencimento+'&cofiseq='+cofiseq,
        	retorno = exe('', getPath()+'/app.util/TSec.php',dados,'POST','Sucesso'),
        	conteiner = document.getElementById('bloc_dadosCursoMatricula');
        
        conteiner.innerHTML = retorno;
    }
}