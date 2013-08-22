function setTipoForm(ob, flag){
	if(!flag){
		flag = 0;
	}
    var pF = document.getElementById('bloc_pessoaFisica');
    var pJ = document.getElementById('bloc_pessoaJuridica');
    
    if(typeof(ob) == "string"){
        ob = document.getElementById(ob);
        
        if(flag == 1){
        	ob.checked = true;
        }
    }
    
    if(ob.id == 'tipo1'){
        if(ob.value == "F" & ob.checked == true){
            pF.style.display = "block";
            pJ.style.display  = "none";
        }else{
            pF.style.display = "none";
            pJ.style.display  = "block";
        }
    }else{
        if(ob.value == "J" & ob.checked == true){
            pF.style.display = "none";
            pJ.style.display  = "block";
        }else{
            pF.style.display = "block";
            pJ.style.display  = "none";
        }
    }
}