/*
 * function Ajax.JQuery para execuÃ§Ãµes mult-threads
*/

function exe(alvo, setUrl, dados, tipoReq, msg, callback){
	
    retorno = false;
    
    if(typeof(callback) == 'function'){
    	asyncRequest = true;
    }else{
    	asyncRequest = false;
    }
          
      //executa se o alvo de retorno for verdadeiro
        if(alvo != ''){
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
               },
               error: function(XMLHttpRequest, textStatus, erro){
            	   $('#loading-status').removeClass().addClass('ui-ajax-error');
            	   alertPetrus("Ouve uma falhar ao executar a ação.\n\nERRO\n["+erro+"]", 'Falha na requisição');                   
               }
          }).responseText;
        }else if(asyncRequest){
        	//Executa se o alvo de retorno for vazio rentornado o valor da solicitacao ajax mas ainda sim for Assíncrono

        	$.ajax({
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
	            	   return retorno;
	               },
	               error: function(XMLHttpRequest, textStatus, erro){
	                   $('#loading-status').removeClass().addClass('ui-ajax-error');
	            	   alertPetrus("Ouve uma falhar inesperada na conexão com a internet e o sistema parou temporariamente de responder - Por favor verifique sua conexão.\n\nERRO - ["+e.getMessage+"]");
	               }
        	}).then(function(ajaxArgs){
        		callback(ajaxArgs);
        	});
        }else{
        	//Executa se o alvo de retorno for vazio e não for do tipo Assíncrono

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
	            	   return retorno;
	               },
	               error: function(XMLHttpRequest, textStatus, erro){
	                   $('#loading-status').removeClass().addClass('ui-ajax-error');
	            	   alertPetrus("Ouve uma falhar inesperada na conexão com a internet e o sistema parou temporariamente de responder - Por favor verifique sua conexão.\n\nERRO - ["+e.getMessage+"]");
	               }
        	}).responseText;
        }
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

