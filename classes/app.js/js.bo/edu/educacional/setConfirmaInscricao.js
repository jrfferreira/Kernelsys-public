function setConfirmaInscricao(tipo, form){

    var dados = $('#'+form+'-window [manter=true]').serialize(),
    	tcliente = $('#pessseq');
    
    if(tcliente.val() == "0"){
        alertPetrus('Selecione o cliente antes de definir uma turma');
    }
    else{
       var valField = 'classe=TInscricao&metodo=setConfirmar&'+dados;
       exe('bloc_gerenciarTurmaInscricao', getPath()+'/app.util/TSec.php', valField, 'POST', 'Sucesso');

       	$('#confirmar8').remove();
       setCancelar('8', '1', 'Fechar');

    }

}