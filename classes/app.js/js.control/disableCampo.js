function disableCampo(ob,id){

    var campo = document.getElementById(id);

    if(campo.disabled == "NULL"){
        campo.disabled = "DISABLED";
    }else{
        campo.disabled = "NULL";
    }

}