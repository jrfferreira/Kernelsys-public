function setEmpTerc(esse){
    var ob = document.getElementById('regimecontrato');
    var pF = document.getElementById('empTerc');

    if(ob.value == "2"){

        pF.disabled = false;
    }
    else if(ob.value != "2"){

        pF.disabled = true;
    }

}