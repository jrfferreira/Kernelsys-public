function closeCaixaDia(confirme,rformseq,key,obRetorno){

    if(confirm('Você deseja realmente executar esta ação?')){

        var dados = 'classe=TCaixa&metodo=fechaCaixa';

        exe('allCaixaRetorno', getPath()+'/app.util/TSec.php', dados, 'POST', 'Sucesso');
        document.getElementById('fecharCaixa').disabled = 1;
        // $().disabled('1');
    }
}
