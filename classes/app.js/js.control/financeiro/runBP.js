function runBP(url, obRet){

    var dataBP = document.getElementById('data');

    if(dataBP.value.length != 10){
        alertPetrus("Esta data não é válida.\nO padrão é 01/01/2001");
    }
    else if (dataBP.value != "") {
        var Valores = 'id='+dataBP.value;
        exe(obRet,getPath()+'/'+url,Valores,'POST','Sucesso');
        //petrus(obRet,getPath()+'/'+url+'?x=1','POST',Valores,'','sub');
    }
    else {
        alertPetrus("não existe um relatório patrimonial para a data.");
    }
}