function fechaCaixaFuncionario(){
    if(confirm('A ação de fechamento de caixa desabilitará novas movimentações até que seja autorizado por um superior, \r\n\r\nDeseja continuar?')){

        var dados = 'classe=TCaixa&metodo=fechaCaixaFuncionario';

        exe('retfecharCaixa', getPath()+'/app.util/TSec.php', dados, 'POST', 'Sucesso');
        document.getElementById('fecharCaixa').disabled = 1;
        // $().disabled('1');
    }
}



function fechaCaixa(){
    if(confirm('Esta ação será armazenada em histórico e liberará a movimentação de caixas futuros,\r\n\r\nDeseja continuar?')){
        var dados = 'classe=TCaixa&metodo=fechaCaixa';
        exe('fechaCaixaRetorno', getPath()+'/app.util/TSec.php', dados, 'POST', 'Sucesso');
    }
}