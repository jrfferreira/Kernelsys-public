function runEnter(ob, event){

     var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
     if(keyCode == 13){
            var obj = document.getElementById(ob);
            obj.onclick();
     }
}
