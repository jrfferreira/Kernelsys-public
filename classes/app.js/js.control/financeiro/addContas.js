function addContas(ob,codigotransacao, idLista){

        if(confirm("Você deseja realmente executar esta ação?")){
            campotransacao = document.getElementById(codigotransacao);

            codigotransacao = campotransacao ? campotransacao.value : codigotransacao;

            var dados = "classe=TTransacao&metodo=addContas&codigotransacao="+codigotransacao;
            var resultado = exe('' , getPath()+'/app.util/TSec.php', dados, 'POST', 'Sucesso');
            if(resultado.replace('\r','').replace('\n','') == 'Sucesso'){
                ob.disabled = true;
            }else{
            $('#contLista'+idLista).append(resultado);
            }
            listaRefresh(idLista);
        }
    }