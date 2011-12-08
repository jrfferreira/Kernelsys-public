function runIntervalo(url, obRet){

    var dataDre1 = document.getElementById('dataDre1');
    var dataDre2 = document.getElementById('dataDre2');

    if (dataDre1.value != "" & dataDre2.value != "") {
        var Valores = 'dt1='+dataDre1.value+'&dt2='+dataDre2.value;


        exe(obRet,getPath()+'/'+url,Valores,'POST','Sucesso');
        //petrus(obRet,getPath()+'/'+url+'?x=1','POST',Valores,'','sub');
    }
    else {
        alertPetrus("Os argumentos são invalidos");
    }
}