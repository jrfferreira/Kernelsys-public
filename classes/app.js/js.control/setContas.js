function setContas(codigotransacao, desconto, acrescimo, dataBase, numparcelas, intervaloparcelas){

    if(confirm("Você deseja realmente aplicar as mudanças e substituir as contas da atual transação?")){

        var obCodigoTransacao   = document.getElementById(codigotransacao);
        var obDesconto          = document.getElementById(desconto);
        var obAcrescimo         = document.getElementById(acrescimo);
        var obDataBase          = document.getElementById(dataBase);
        var obNumParcelas       = document.getElementById(numparcelas);
        var obIntervalo         = document.getElementById(intervaloparcelas);

        if(obCodigoTransacao.value != '' & obDesconto.value != '' & obAcrescimo.value != ''){
            var selections = '';
            $(document).ready(function(){
                $('input[type = "checkbox"][id ^= "onSelectConta_"]').each(function(){
                    if(this.checked == true){
                        selections = selections+';'+this.value;
                    }
                });
            });

            var dados = "classe=TTransacao&metodo=setContas&codigotransacao="+obCodigoTransacao.value;
            dados += "&desconto="+obDesconto.value;
            dados += "&acrescimo="+obAcrescimo.value;

            if(resultado == 'sucesso'){
                listaRefresh('144');
            }
        }
    }
}