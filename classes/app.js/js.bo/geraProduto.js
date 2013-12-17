function geraProduto(seq,tabela,obRet){

    var turma = document.getElementById('nometurma');
    var parcelas = document.getElementById('numparcelas');
    var valorParc = document.getElementById('valorDescontado');

    if (valorParc.value != "" & turma.value != "") {

        //petrus(obRet,getPath()+'/app.Control/app.financeiro/setProduto.class.php?x=1','POST',Valores,'','sub');

        var Valores = 'label='+turma.value+'&valor='+valorParc.value*parcelas.value+'&seqPai='+seq+'&tabela='+tabela;
        exe(obRet,getPath()+'/app.Control/app.financeiro/setProduto.class.php', Valores, 'POST', 'Sucesso');
    }
    else {
        alertPetrus("O campo \"Nome\" ou \"Valor Descontado\" não est� preenchido corretamente.");
    }
}