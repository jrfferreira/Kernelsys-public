function efetivaPedido(tipoRet,form,obRet,confirme){

    if($('#seqcondicaopagamento').val() == 0 || $('#seqcondicaopagamento').val() == '' || $('#seqcondicaopagamento').val() == '0'){
        alertPetrus('É necessario escolher uma condição de pagamento.', 'Alerta');
    }else{
        if(confirm(confirme)){
            var dados = 'classe=TTransacao&metodo=efetivaPedido&formseq='+form;
            exe('', getPath()+'/app.util/TSec.php', dados, 'POST', 'Sucesso');

            onClose(tipoRet,form,obRet,'');

        }
    }
}
