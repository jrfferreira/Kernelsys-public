function showBoleto(conta){

    if(conta || conta.alt){

        if(conta.alt){
            conta = conta.alt;
        }

        window.open('../app.pagina/showBoleto.php?cod='+conta+'&tipo=p&or=cl', 'boleto', 'scrollbars=yes,toolbar=yes,menubar=no,resizable=yes,width=700,height=600,top=50,left=200');
    }
    else{
        alertPetrus('Conta inválido');
    }
}

function showBoletoLst(ob, confirme, seq, obRet){

    if(seq){
        window.open('../app.pagina/showBoleto.php?cod='+seq+'&tipo=p&or=cl', 'boleto', 'scrollbars=yes,toolbar=yes,menubar=no,resizable=yes,width=700,height=600,top=50,left=200');
    }
    else{
        alertPetrus('Conta inválida');
    }
}