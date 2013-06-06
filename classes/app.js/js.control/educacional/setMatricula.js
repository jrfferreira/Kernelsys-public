function setMatricula(obj, confirme){

    var codigoInscricao = $(obj).attr('codigo');
    var datacad   = document.getElementById('datacad').value;

    if(confirm(confirme) && codigoInscricao){

        var dados = 'classe=TMatricula&metodo=setMatricula&codigoinscricao='+codigoInscricao+'&datacad='+datacad;
        var retorno = exe('', getPath()+'/app.util/TSec.php',dados,'POST','Sucesso');

        var conteiner = document.getElementById('bloc_dadosCursoMatricula');
        conteiner.innerHTML = retorno;
    }
}