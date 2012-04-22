function setConfirmaInscricao(obj){
	
	onSave('8','8-window','form', '', true);
    var codigo = $(obj).attr('codigo');

    var tcliente = document.getElementById('codigopessoa');
    if(tcliente.value == "0"){
        alertPetrus('Selecione o cliente antes de definir uma turma');
    }
    else{
       var valField = 'classe=TInscricao&metodo=setConfirmar&codigoinscricao='+codigo;
       var retorno = exe('', getPath()+'/app.util/TSec.php', valField, 'POST', 'Sucesso');

       setCancelar('8', '2');
       setConcluir('8', '1');

       //var conteiner = obj.parentNode;
       var conteiner = document.getElementById('bloc_gerenciarTurmaInscricao');
       conteiner.innerHTML = retorno;
    }

}