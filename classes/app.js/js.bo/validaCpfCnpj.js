function validaCpfCnpj(obj,tipo){

        var valores = 'classe=TPessoa&metodo=validaCpfCnpj&pessnmrf='+obj.value+"&tipo="+tipo;
        var retorno = exe('', getPath()+'/app.util/TSec.php',  valores, 'POST','Sucesso');

        if(retorno != true){
            alert(retorno);
        }
}