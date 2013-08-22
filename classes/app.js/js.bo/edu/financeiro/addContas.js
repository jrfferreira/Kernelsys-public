function addContas(ob,seqtransacao, listseq){

        if(confirm("Você deseja realmente executar esta ação?")){
            campotransacao = document.getElementById(seqtransacao);

            seqtransacao = campotransacao ? campotransacao.value : seqtransacao;

            var dados = "classe=TTransacao&metodo=addContas&seqtransacao="+seqtransacao;
            var resultado = exe('' , getPath()+'/app.util/TSec.php', dados, 'POST', 'Sucesso');
            if(resultado.replace('\r','').replace('\n','') == 'Sucesso'){
                ob.disabled = true;
            }else{
            $('#contLista'+listseq).append(resultado);
            }
            listaRefresh(listseq);
        }
    }