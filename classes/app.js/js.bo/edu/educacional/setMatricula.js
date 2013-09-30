function setMatricula(obj, confirme){

    var codigoInscricao = $('#seq').val();
    var datacad   = $('#datacad').val();

    if(codigoInscricao && confirm(confirme)){

        var dados = 'classe=TMatricula&metodo=setMatricula&codigoinscricao='+codigoInscricao+'&datacad='+datacad;
        var retorno = exe('', getPath()+'/app.util/TSec.php',dados,'POST','Sucesso');

        var conteiner = document.getElementById('bloc_dadosCursoMatricula');
        conteiner.innerHTML = retorno;
    }
}