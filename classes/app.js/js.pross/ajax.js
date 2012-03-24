/*
 * function Ajax.JQuery para execuÃ§Ãµes mult-threads
*/

function exe(alvo, setUrl, dados, tipoReq, msg){
	
/*    if(tipoReq == 'GET'){
        var rand = "&rand="+new Date().getTime();
    }else{
        var rand = "?rand="+new Date().getTime();
    }
    setUrl = setUrl+rand;*/
    
    retorno = false;

    if(arguments[5]){
        var async = arguments[5];
    }else{
        var async = false;
    }
    
    
    //alert(setUrl);
    
    $(document).ready(function(){
       
      //executa se o alvo de retorno for verdadeiro
        if(alvo != ''){

          $.ajax({

               type: tipoReq,
               url: setUrl,
               //context: document.element,
               data:dados,
               cache: false,
               async: true,
               beforeSend: function(){
                    $('#loading-status').removeClass().addClass('ui-ajax-loading');
               },
               success: function(ret){
             	       	  
            	   //document.getElementById(alvo).innerHTML = ret;
                   jQuery('#'+alvo).html(ret);
               },
               error: function(XMLHttpRequest, textStatus, erro){

            	   $('#loading-status').removeClass().addClass('ui-ajax-error');
            	   alertPetrus("Ouve uma falhar ao executar a ação.\n\nERRO\n["+erro+"]", 'Falha na requisição');
                   
               }
          });

        }else{//Executa se o alvo de retorno for vasio rentornado o valor da solicitacao ajax

        	retorno = $.ajax({

	               type: tipoReq,
	               url: setUrl,
	               //context: document.element,
	               data:dados,
	               cache: false,
	               async: false,
	               beforeSend: function(){
	                    $('#loading-status').removeClass().addClass('ui-ajax-loading');
	               },
	               success: function(ret){},
	               error: function(XMLHttpRequest, textStatus, erro){
	                   $('#loading-status').removeClass().addClass('ui-ajax-error');
	            	   alertPetrus("Ouve uma falhar inesperada na conexão com a internet e o sistema parou temporariamente de responder - Por favor verifique sua conexÃ£o.\n\nERRO - ["+e.getMessage+"]");
	               }

        	}).responseText;
        }

    });
    if(retorno){
        return retorno;
    }
}

//Executa ações nos campos do formulario
function exeCampo(setUrl, dados, tipoReq){
    var rand = null;
    if(tipoReq == 'GET'){
        rand = "&rand="+new Date().getTime();
    }else{
        rand = "?rand="+new Date().getTime();
    }
    //setUrl = setUrl+rand;
    
       retCampo = $.ajax({
               type: tipoReq,
               url: setUrl,
               data:dados,
               cache: false,
               async: false,
               success: function(ret){}

       }).responseText;

       return retCampo;
}

jQuery(document).ajaxStart(function(){
       $('#loading-status').removeClass().addClass('ui-ajax-loading');
       document.body.style.cursor = 'wait';
}).ajaxStop(function(){
       document.body.style.cursor = 'auto';
       $('#loading-status').removeClass().addClass('ui-ajax-stop');
       window.setTimeout('$(\'#loading-status\').removeClass()','300');
        atribuicao();
});

