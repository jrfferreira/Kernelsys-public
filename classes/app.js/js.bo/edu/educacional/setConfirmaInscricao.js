function setConfirmaInscricao(obj){

    var dados = $(obj).parents('.TWindow').find('[manter=true]').serialize(),
    	tcliente = $('#pessseq');
    
    if(tcliente.val() == "0"){
        alertPetrus('Selecione o cliente antes de definir uma turma');
    }
    else{
       var valField = 'classe=TInscricao&metodo=setConfirmar&'+dados;
       exe('bloc_gerenciarTurmaInscricao', getPath()+'/app.util/TSec.php', valField, 'POST', 'Sucesso');

       setCancelar('8', '1', 'Concluir');

    }

}