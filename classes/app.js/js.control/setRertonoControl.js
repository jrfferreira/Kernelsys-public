function setRertonoControl(idForm, retorno){

    var dados = retorno.split('#');
    var ret = null;

    if(dados[1] == '0'){
        ret = dados[2];
        return ret;
    }
    else if(dados[1] == '1' || dados[1] == '3' || dados[1] == '4' || dados[1] == '5'){

         ret = dados[2];
         //setalertPetrus(ret);
         alertPetrus(ret);
    }
    //codigo erro 2 = validação de valores nulos
    else if(dados[1] == '2'){
        //setalertPetrus(dados[2]);
        alertPetrus(dados[2]);
        //setConcluir(idForm, '2');
    }
}