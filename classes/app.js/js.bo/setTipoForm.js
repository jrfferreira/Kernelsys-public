function setTipoForm(ob, flag){
	if(!flag){
		flag = 0;
	}
    var pF = $('#bloc_pessoaFisica');
    var pJ = $('#bloc_pessoaJuridica');
    
    if(typeof(ob) == "string"){
        ob = document.getElementById(ob);
        
        if(flag == 1){
        	ob.checked = true;
        }
    }
    
    if(ob.id == 'tipo1'){
        if(ob.value == "F" & ob.checked == true){
            pF.show().find('[manter]').attr('manter', true);
            pJ.hide().find('[manter]').attr('manter', false);
        }else{
            pF.hide().find('[manter]').attr('manter', false);
            pJ.show().find('[manter]').attr('manter', true);
        }
    }else{
        if(ob.value == "J" & ob.checked == true){
            pF.hide().find('[manter]').attr('manter', false);
            pJ.show().find('[manter]').attr('manter', true);
        }else{
            pF.show().find('[manter]').attr('manter', true);
            pJ.hide().find('[manter]').attr('manter', false);
        }
    }
}