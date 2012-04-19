function setTipoForm(ob){

    var pF = $('#bloc_pessoaFisica');
    var pJ = $('#bloc_pessoaJuridica');

    if(typeof(ob) == "string"){
        ob = $('#'+ob);
    }

    if($(ob).val() == "F" && $(ob).attr('checked') == 'checked'){
        pF.css('display','block').find(':input').attr('manter',true);        
        pJ.css('display','none').find(':input').removeAttr('manter');
    }
    else{
        pF.css('display','none').find(':input').removeAttr('manter');
        pJ.css('display','block').find(':input').attr('manter',true); 
    }
}