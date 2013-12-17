function setSelectConta(ob, confirme, seq, obRet){

    if(ob.checked == true){
        if(!confirm(confirme)){
            ob.checked = false;
        }else{
            $(document).ready(function(){
                $(ob).parent().parent().css('background-color', "#09F");
            });
        }
    }
}