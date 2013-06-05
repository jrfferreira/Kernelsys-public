function geraMovimentacaoInterna(){
        var dados = 'classe=TCaixa&metodo=gerarMovimentacaoInterna&contaorigem='+$('#codigocontacaixa_origem').val()+'&contadestino='+$('#codigocontacaixa_destino').val()+'&valorreal='+$('#valorreal').val();
        exe('buttonMovcell', getPath()+'/app.util/TSec.php', dados, 'POST', 'Sucesso');
}