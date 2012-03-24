function setTipoForm(ob){

    var pF = document.getElementById('bloc_pessoaFisica');
    var pJ = document.getElementById('bloc_pessoaJuridica');

    if(typeof(ob) == "string"){
        ob = document.getElementById(ob);
    }

    if(ob.value == "F" & ob.checked == true){

        pF.style.display = "block";
        pJ.style.display  = "none";
    }
    else{

        pF.style.display = "none";
        pJ.style.display  = "block";
    }

}