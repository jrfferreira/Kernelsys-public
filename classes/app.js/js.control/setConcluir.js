/**
**manipula o botão comcluir dos formulários padrões
*action =  1 = ativo / 2 = inativo
*/
function setConcluir(idForm, action){

    var bot = $("#concluir_botform"+idForm);

    if(action == '1'){
        bot.removeAttr('disabled');
    }
    else if(action == '2'){
    	bot.attr('disabled','disabled');
    }
}
