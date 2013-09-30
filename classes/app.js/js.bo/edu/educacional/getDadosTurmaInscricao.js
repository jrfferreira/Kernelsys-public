function getDadosTurmaInscricao(obj, classe, metodo){

        var valores = 'classe='+classe+'&metodo='+metodo+'&turmseq='+obj.value;
        var retorno = exe('', getPath()+'/app.util/TSec.php',  valores, 'POST','Sucesso');

        if(retorno){
            var vDados = retorno.split("(sp)");
            for(var x=0; x < vDados.length; x++){

                var vd = vDados[x].split("=>");
                var field = document.getElementById(vd[0]);

                if(field){
                    field.value = vd[1];
                    if(field.onblur){
                        field.onblur();
                    }
                }
            }
        }
}