/**
**manipula o botão comcluir dos formulários padrões
*action =  1 = ativo / 2 = inativo
*/
function setConcluir(idForm, action){
	var id = "#concluir_botform"+idForm;
    if($(id).length > 0){
        if(action == '1'){
        	$(id).removeAttr('disabled');
        }
        else if(action == '2'){
        	$(id).attr('disabled','disabled');
        }
    }
}
