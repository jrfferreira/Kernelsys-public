function setContas(seqtransacao, desconto, acrescimo, dataBase, numparcelas, intervaloparcelas){

    if(confirm("Voc� deseja realmente aplicar as mudanças e substituir as contas da atual transa�ão?")){

        var obseqTransacao   = document.getElementById(seqtransacao);
        var obDesconto          = document.getElementById(desconto);
        var obAcrescimo         = document.getElementById(acrescimo);
        var obDataBase          = document.getElementById(dataBase);
        var obNumParcelas       = document.getElementById(numparcelas);
        var obIntervalo         = document.getElementById(intervaloparcelas);

        if(obseqTransacao.value != '' & obDesconto.value != '' & obAcrescimo.value != ''){
            var selections = '';
            $(document).ready(function(){
                $('input[type = "checkbox"][id ^= "onSelectConta_"]').each(function(){
                    if(this.checked == true){
                        selections = selections+';'+this.value;
                    }
                });
            });

            var dados = "classe=TTransacao&metodo=setContas&seqtransacao="+obseqTransacao.value;
            dados += "&desconto="+obDesconto.value;
            dados += "&acrescimo="+obAcrescimo.value;

            if(resultado == 'sucesso'){
                listaRefresh('144');
            }
        }
    }
}