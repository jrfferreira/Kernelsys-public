/**
**manipula o botão comcluir dos formul�rios padrões
*action =  1 = ativo / 2 = inativo
*/
function setConcluir(idForm, action){
    var bot = $('#concluir_botform'+idForm+',#salvar_botform'+idForm);

    if(action == '1'){
    	bot.attr('disabled', false);
    }
    else if(action == '2'){
    	bot.attr('disabled', true);
    }
}
