function setProdutoInsumo(ob){

    var bloco = document.getElementById('bloc_blocInformacoesProdInsumo');

    if(typeof(ob) == "string"){
        ob = document.getElementById(ob);
    }

    if(ob.value == "1" & ob.checked == true){

        bloco.style.display = "block";
    }
    else{
        bloco.style.display = "none";
    }

}