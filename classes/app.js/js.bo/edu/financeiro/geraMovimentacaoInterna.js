function geraMovimentacaoInterna(){
        var dados = 'classe=TCaixa&metodo=gerarMovimentacaoInterna&contaorigem='+$('#seqcontacaixa_origem').val()+'&contadestino='+$('#seqcontacaixa_destino').val()+'&valorreal='+$('#valorreal').val();
        exe('buttonMovcell', getPath()+'/app.util/TSec.php', dados, 'POST', 'Sucesso');
}