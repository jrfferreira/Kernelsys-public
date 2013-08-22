
/**
**manipula o botão comcluir dos formul�rios padrões
*action =  1 = ativo / 2 = inativo
*/
function setCancelar(idForm, action){

    var bot = document.getElementById("cancelar_botform"+idForm);

    if(action == '1'){
        bot.disabled = false;
    }
    else if(action == '2'){
        bot.disabled = true;
    }
}
