function efetivaPedido(tipoRet,form,obRet,confirme){

    if($('#codigocondicaopagamento').val() == 0 || $('#codigocondicaopagamento').val() == '' || $('#codigocondicaopagamento').val() == '0'){
        alertPetrus('É necessario escolher uma condição de pagamento.', 'Alerta');
    }else{
        if(confirm(confirme)){
            var dados = 'classe=TTransacao&metodo=efetivaPedido&idForm='+form;
            exe('', getPath()+'/app.util/TSec.php', dados, 'POST', 'Sucesso');

            onClose(tipoRet,form,obRet,'');

        }
    }
}
