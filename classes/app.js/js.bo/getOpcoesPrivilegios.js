function getOpcoesPrivilegios(usuaseq,nivel,funcionalidade,modulo,situacao){
    if(situacao == "1"){
        switch (nivel.toString()) {
            case "0":
                var valoresApendice = '&usuaseq='+usuaseq+'&funcionalidade='+modulo;
                var dadosApendice = 'classe=TPrivilegios&metodo=viewGetMenu'+valoresApendice;
                break;
            case "1":
                var valoresApendice = '&usuaseq='+usuaseq+'&funcionalidade='+modulo;
                var dadosApendice = 'classe=TPrivilegios&metodo=viewGetOpcoesLista'+valoresApendice;
                break;
            case "3":

                break;
            case "4":

                break;
            case "5":
                var valoresApendice = '&usuaseq='+usuaseq+'&funcionalidade='+modulo;
                var dadosApendice = 'classe=TPrivilegios&metodo=viewGetAbasBlocos'+valoresApendice;
                break;
            case "6":
                var valoresApendice = '&usuaseq='+usuaseq+'&funcionalidade='+modulo;
                var dadosApendice = 'classe=TPrivilegios&metodo=viewGetBlocosCampos'+valoresApendice;
                break;
            case "7":
                var valoresApendice = '&usuaseq='+usuaseq+'&funcionalidade='+modulo;
                var dadosApendice = 'classe=TPrivilegios&metodo=viewGetCampoEdicao'+valoresApendice;
                break;
            case "8":

                break;
            case "9":

                break;
        }

        if(dadosApendice){
            var apendice = exe(nivel+"-"+funcionalidade+modulo, getPath()+'/app.util/TSec.php',dadosApendice,'POST','Sucesso');
        }
    }else{
        $("#"+nivel+"-"+funcionalidade+modulo).html("");
    }
}
