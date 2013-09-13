


/*
 *Executa filtro de acordo com os dados definidos na tela 
 */
function consultarParcela(formseq, obj){	
	
	//var fieldSend = document.getElementsByName('dcpcdtvc');
	var fieldSend = $("#"+obj).find('[view=true]');
	var campos = null;
	
	for(var i = 0; i < fieldSend.length; i++) {	
		  if(fieldSend[i].type=="checkbox" && fieldSend[i].checked==false){
		    valor = "0";
		  }
		  else{
		    valor = fieldSend[i].value;
		  }	    
		campos = campos+'&'+fieldSend[i].name+'__'+fieldSend[i].getAttribute('tipodado')+'='+valor;
	}
	
	var metodo = 'onFilter';
	var tipoObjeto = 'lista';
	var obRetorno = 'contLista'+formseq;
		
    //compAction(metodo, key);                    
    var retorno = exe(obRetorno, getPath()+'/app.view/TMain.class.php?method='+metodo+'&tipoRetorno='+tipoObjeto+'&formseq='+formseq+'&key=&ret='+obRetorno, campos, 'POST', 'Sucesso');
    setExcecao(formseq, obRetorno, retorno);
}


//Executa baixa de parcelas selecionadas
function baixaParcela(tipoRetorno, formseq, obRetorno, confirme, listaParcela){
	
	if(confirme!=""){

	      jQuery('<div id=\'confirmation' + formseq + '\' title=\'Confirmação\' style="padding:15px"></div>').html(confirme).appendTo('body');

	      jQuery( '#confirmation' + formseq ).dialog({
	          resizable: false,
	          modal: true,
	          close : function() {
	              $(this).remove()
	          },
	          buttons: {
	              "Cancelar": function() {
	                  $(this).remove();
	              },
	              "Confirmar": function() {	            	  
	                  $(this).remove();
	                  if(typeof(obRetorno) == "string"){
	                      var view = 'winRet';
	                  }
	                  
	                  
	                  var fieldSend = $("#"+formseq+'-window').find('input').serialize();

	                  var metodo = 'onMain';
	                  var dados = 'class=DocumentoBO&method=baixaParcela';
	                  
	                  dados = dados+'&'+fieldSend;
	                  
	                  var retorno = exe('', getPath()+'/app.view/TMain.class.php?method='+metodo+'&tipoRetorno='+tipoRetorno+'&formseq='+formseq, dados, 'POST', 'Sucesso');

	                  setExcecao(formseq, view, 'open', retorno);
	                  
	             	 var erro = getErro(retorno);
	                 if(erro != 'erro'){
	                	 listaRefresh(listaParcela);
	                 }
	              }
	          }
	      });
	  }
}



