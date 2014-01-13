/*
 * function Ajax.JQuery para execuções mult-threads
*/

function exe(alvo, setUrl, dados, tipoReq, msg, callback){
	
    retorno = false;
    
    if(typeof(callback) == 'function'){
    	asyncRequest = true;
    }else{
    	asyncRequest = false;
    }
    
   // alert(alvo);
    
      //executa se o alvo de retorno for verdadeiro
        if(alvo){
        	
        	if(typeof(callback) == 'function'){
        		jQuery.data(jQuery('#'+alvo),'callbackFunction',callback);
     	    }
        	
          retorno = $.ajax({
               type: tipoReq,
               url: setUrl,
               context: jQuery('#'+alvo),
               data:dados,
               dataType: 'html',
               cache: false,
               async: true,
               beforeSend: function(){
                    $('#loading-status').removeClass().addClass('ui-ajax-loading');
               },
               success: function(ret){
             	    $(this).html(ret);
             	    callback = jQuery.data(jQuery('#'+alvo),'callbackFunction');
	             	   if(typeof(callback) == 'function'){
	             		 callback(ret);  
	             	   }      	   
	             	   
               },
               error: function(XMLHttpRequest, textStatus, erro){
            	   $('#loading-status').removeClass().addClass('ui-ajax-error');
            	   alertPetrus("Ouve uma falhar ao executar a ação.\n\nERRO\n["+erro+"]", 'Falha na requisição');                   
               }
          }).responseText;
          
        }
        
        
        
        else{//Executa se o alvo de retorno for null rentornado o valor da solicitacao ajax
        	
        	if(typeof(callback) == 'function'){
     	    	callbackFunction = callback;
     	    }else{
     	    	callbackFunction = function(ret){
					            	   return ret;
					               };
     	    }
        	retorno = $.ajax({
	               type: tipoReq,
	               url: setUrl,
	               data:dados,
	               cache: false,
	               async: asyncRequest,
	               dataType: 'html',
	               beforeSend: function(){
	                    $('#loading-status').removeClass().addClass('ui-ajax-loading');
	               },
	               success: function(ret){
	            	   var retorno = callbackFunction(ret);
	            	   return retorno;
	               },
	               error: function(XMLHttpRequest, textStatus, erro){
	                   $('#loading-status').removeClass().addClass('ui-ajax-error');
	            	   alertPetrus("Ouve uma falhar inesperada na conexão com a internet e o sistema parou temporariamente de responder - Por favor verifique sua conexão.\n\n"+(erro?"ERRO: \n ["+erro.getMessage+"]":""));
	               }
        	}).responseText;
        }
        
       //alert(retorno);
        
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
       
       atribuicao();
       
       
}).ajaxStop(function(){
       document.body.style.cursor = 'auto';
       $('#loading-status').removeClass().addClass('ui-ajax-stop');
       window.setTimeout('$(\'#loading-status\').removeClass()','300');
       
       
        atribuicao();
});

