/**
**manipula o botão comcluir dos formul�rios padrões
*action =  1 = ativo / 2 = inativo
*/
function setConcluir(idForm, action){

    var bot = document.getElementById("concluir_botform"+idForm);

    if(action == '1'){
        bot.disabled = false;
    }
    else if(action == '2'){
        bot.disabled = true;
    }
}
