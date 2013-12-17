function setMatricula(obj, confirme){

    var codigoInscricao = $('#seq').val();
    var datainiciovencimentos   = $('#datainiciovencimentos').val();
    var padraovencimento   = $('#padraovencimento').val();

    if(codigoInscricao && confirm(confirme)){

        var dados = 'classe=TMatricula&metodo=setMatricula&inscseq='+codigoInscricao+'&datainiciovencimentos='+datainiciovencimentos+'&padraovencimento='+padraovencimento;
        var retorno = exe('', getPath()+'/app.util/TSec.php',dados,'POST','Sucesso');

        var conteiner = document.getElementById('bloc_dadosCursoMatricula');
        conteiner.innerHTML = retorno;
    }
}