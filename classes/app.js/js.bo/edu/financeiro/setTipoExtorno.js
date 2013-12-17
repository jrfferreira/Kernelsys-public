function setTipoExtorno(ob){

    var lancD = document.getElementById('bloc_LancaExtornoDebito');
    var lancC = document.getElementById('bloc_LancaExtornoCredito');

    if(typeof(ob) == "string"){
        var ob = document.getElementById(ob);
    }

    if(ob.value == "D" & ob.checked == true){

        lancD.style.display = "block";
        lancC.style.display  = "none";
    }
    else{

        lancD.style.display = "none";
        lancC.style.display  = "block";
    }

}