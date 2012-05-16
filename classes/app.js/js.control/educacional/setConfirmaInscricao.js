function setConfirmaInscricao(obj){

    var codigo = $(obj).attr('codigo');

    var tcliente = $('#codigopessoa');
    if(tcliente.val() == "0"){
        alertPetrus('Selecione o cliente antes de definir uma turma');
    }
    else{
       var valField = 'classe=TInscricao&metodo=setConfirmar&codigoinscricao='+codigo;
       exe('bloc_gerenciarTurmaInscricao', getPath()+'/app.util/TSec.php', valField, 'POST', 'Sucesso');

       setCancelar('8', '2');
       setConcluir('8', '1');

    }

}