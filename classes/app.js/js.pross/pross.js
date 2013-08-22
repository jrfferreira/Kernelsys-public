function setExcecao(formseq,view,metodo,retorno){
	
	//alert(retorno);
				
	 var erro = getErro(retorno);
     if(erro == 'erro'){
         setRertonoControl(formseq, retorno);
     }else{
    	 
         if(jQuery('#'+view).length > 0){
             jQuery('#'+view).html(retorno);
         }
         if(metodo == 'close' ){
        	 jQuery('#'+formseq+'-window').dialog('close');
         }

         atribuicao();
     }
	
}

// executa interface Principal \\
function prossInter(ob, seq){

    var labelMd = document.getElementById('obLabelModulo');
    labelMd.innerHTML = ob.innerHTML;

    $(".modulobot").removeClass("modulobotClick");
    $(ob).addClass('modulobotClick');
    exe('bodyDisplay', getPath()+'/app.view/TMenu.class.php?seq='+seq, '', 'GET', 'Sucesso');
}

// executa interface Secundária \\
function prossInterSec(mod, url){

    var labelMdSec = document.getElementById('obLabelSec');
    labelMdSec.innerHTML = mod;
    
    exe('displaySys', getPath()+'/app.view/'+url, '', 'GET', 'Sucesso');
}

// Executa o logout do sistema
function onLogout(occupant){
    if($('.TWindow').length > 0){
        alertPetrus('Existem janelas abertas no sistema.\nFeche-as antes de prosseguir.');
    }else{
        if(occupant) {
            logoutOccupant = '&occupant=' + occupant;
        }else{
            logoutOccupant = '';
        }
        exe('tpage', getPath()+'/app.access/TLogout.class.php?hash=9kk32' + logoutOccupant, '', 'GET', 'Sucesso');
    }
}


//mantendo funções Originais
//Recupera os campos da tela e armazena envia ao servidor
function onSave(formseq, nomeform, tipoRetorno, obRetorno){
	
	var metodo    = 'onSave';
	var value     = '';
	var fieldSend = '';	
	
	
	var fieldSend = $("#"+nomeform).find('[manter=true]').serialize();
			
		//====================================
		var retorno = exe('', getPath()+'/app.view/TMain.class.php?method='+metodo+'&tipoRetorno='+tipoRetorno+'&formseq='+formseq, fieldSend, 'POST', 'Sucesso');
		
		setExcecao(formseq,obRetorno,'close',retorno);		 
}


//interface do metodo onClose
function onClose(tipoRetorno, formseq, obRetorno, confirme){

  var metodo = 'onClose';
  var condiction = true;

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
                      var view = obRetorno;
                  }

                  //compAction(metodo, key);
                  var retorno = exe('', getPath()+'/app.view/TMain.class.php?method='+metodo+'&tipoRetorno='+tipoRetorno+'&formseq='+formseq, '', 'GET', 'Sucesso');

                  setExcecao(formseq, view, 'close', retorno);
              }
          }
      });
  }else{
	  
      if(typeof(obRetorno) == "string"){
          var view = obRetorno;
      }

      //compAction(metodo, key);
      var retorno = exe('', getPath()+'/app.view/TMain.class.php?method='+metodo+'&tipoRetorno='+tipoRetorno+'&formseq='+formseq, '', 'GET', 'Sucesso');

      setExcecao(formseq, view, 'close', retorno);
  }
  
  return true;
}

//interface do metodo onCancel
function onCancel(tipoRetorno, formseq, key, obRetorno, confirme){

  var metodo = 'onCancel';
  var condiction = true;

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
                      var view = obRetorno;
                  }

                  //compAction(metodo, key);
                  var retorno = exe('', getPath()+'/app.view/TMain.class.php?method='+metodo+'&tipoRetorno='+tipoRetorno+'&formseq='+formseq+'&key='+key, '', 'GET', 'Sucesso');

                  
                  setExcecao(formseq, view, 'close', retorno);
              }
          }
      });
  }else{
      if(typeof(obRetorno) == "string"){
          var view = obRetorno;
      }

      //compAction(metodo, key);
      var retorno = exe('', getPath()+'/app.view/TMain.class.php?method='+metodo+'&tipoRetorno='+tipoRetorno+'&formseq='+formseq+'&key='+key, '', 'GET', 'Sucesso');

      setExcecao(formseq, view, 'close', retorno);
  }
}


//mantendo funções Originais
//Recupera os campos da tela e armazena envia ao servidor
function onFilter(metodo, tipoRetorno, formseq, key, obRetorno, confirme){
	
	var metodo    = 'onFilter';
	var value     = '';
	var fieldSend = '';	
	
	
	var fieldSend = $("#filtro"+formseq).find('[view]').serialize();
	
	 //var valField = setFiltro(formseq);
			
		//====================================
		var retorno = exe('', getPath()+'/app.view/TMain.class.php?method='+metodo+'&tipoRetorno='+tipoRetorno+'&formseq='+formseq, fieldSend, 'POST', 'Sucesso');
		
		setExcecao(formseq,obRetorno,'open',retorno);		 
}

// executa funções das funcionalidades [formulários / listas]

function prossExe(metodo, tipoObjeto, formseq, key, obRetorno, confirme){
	
    //var condiction = true;
    //configura os dados do filtro
    var valField = setFiltro(formseq);
    
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
                        var view = obRetorno;
                    }
                    //compAction(metodo, key);                    
                    var retorno = exe('', getPath()+'/app.view/TMain.class.php?method='+metodo+'&tipoRetorno='+tipoObjeto+'&formseq='+formseq+'&key='+key+'&ret='+obRetorno, valField, 'POST', 'Sucesso');
                    
                    setExcecao(formseq, view, 'open', retorno);

                }
            }
        });

    }else{
    	    	
        if(typeof(obRetorno) == "string"){
            var view = obRetorno;
        }
        //compAction(metodo, key);
        var retorno = exe('', getPath()+'/app.view/TMain.class.php?method='+metodo+'&tipoRetorno='+tipoObjeto+'&formseq='+formseq+'&key='+key+'&ret='+obRetorno, valField, 'POST', 'Sucesso');
        
        setExcecao(formseq, view, 'open', retorno);
        
    }
}

/*
 * Controle visual da seleção de campos na lista.
 */
function onSelecao(ob, listseq, seqRegistro){
	
    if(ob.checked){
        var acSelecao = '1';
    }else{
        var acSelecao = '2';
    }
    
    var registro = ob.parentNode.parentNode;
    var campos = registro.getElementsByTagName('input');
    var dados = new Array();
    
    var x = 0;
    while(campos.length > x){
    	dados[x] = campos[x].value;
    	x=x+1;
    }
    dados = JSON.stringify(dados);
    
    var metodo = 'onSelecao';
    var resp = seqRegistro == 'all' ? 'contLista'+listseq : 'winRet';
    var retorno = exe(resp, getPath()+'/app.view/TMain.class.php?method='+metodo+'&acselecao='+acSelecao+'&dados='+dados+'&formseq='+listseq, '', 'GET', 'Sucesso');
}

/*
 * Abre formulário independente
 */
function onFormOpen(formseq, obj){

    if(obj){
        var obRetorno = obj.parentNode;
        var view = obRetorno.id;
    }


    var retorno = exe('', getPath()+'/app.view/TMain.class.php?method=onFormOpen&formseq='+formseq, '', 'GET', 'Sucesso');

    var erro = getErro(retorno);
    if(erro == 'erro'){
        setRertonoControl(formseq, retorno);
    }else{
        jQuery('#'+view).append(retorno);
        atribuicao();
    }
}


//INICIO - funções referentes a Impressão de listas
function printDataGrid(formseq, pane){
    var metodo = 'onPrint';
    var retorno = exe('', getPath()+'/app.view/TMain.class.php?method='+metodo+'&tipoRetorno=list&formseq='+formseq, '', 'GET', 'Sucesso');

    var innerHtml = '<div id="truePrint" style="width: 100%; height: 100%; background-color: #fff; text-align: center;">'+retorno+'</div>';
    $('<div id="modalPrint">'+innerHtml+'</div>').appendTo('body');
    $('#modalPrint').dialog({
        modal: true,
        autoOpen: true,
        width: '1050',
        height: 550,
        buttons: {
            "Imprimir": function(){
                $('#truePrint').jqprint();
            },
            "Fechar": function(){
                $(this).dialog("close");
            }
        },

        close: function() {
            $('#modalPrint').remove();
        }
    });
}


//gerencia os dados do filtro na tela
function setFiltro(listseq){

    var vfiltro = document.getElementById('expre'+listseq);
    if(vfiltro!=null && vfiltro.value!=""){
        var col = document.getElementById('cols'+listseq);
        var mfilt = document.getElementById('Manterfilt'+listseq);
        vfiltro.value = vfiltro.value;
        var valField = vfiltro.name+'='+vfiltro.value+'&'+col.name+'='+col.value+'&'+mfilt.name+'='+mfilt.checked;
    }else{
        valField = null;
    }

    return valField;
}


/*
*
*/
function inRun(arg){
    var url = getPath()+'/app.view/TActionIn.class.php?act='+arg;
    setTimeout("run('"+url+"')", 3000);
}

/*
 *
 */
function compAction(act, key){
	
    var labelMdSec = document.getElementById('obLabelSec');
    var labelMd = document.getElementById('obLabelModulo');
    var action = labelMd.innerHTML+' -> '+labelMdSec.innerHTML;
	
    if(act == "onNew"){
        action += " -> Novo Registro - ID = "+key;
        inRun(action);
    }
    else if(act == "onEdit"){
        action += " -> Edição de Registro - ID = "+key;
        inRun(action);
    }
    else if(act == "onDelete"){
        action += " -> Exclusão de Registro - ID = "+key;
        inRun(action);
    }
}

//==================================================================================================================================

/**
 * Atualiza objetos DOM
 * @param lista = nome da lista que vai ser atualizada
 * @param formseq = Id fo formulário representado pela lista
 */
function listaRefresh(listseq){
    var obRetorno = 'contLista'+listseq;
    var metodo = 'onRefresh';
    exe(obRetorno,getPath()+'/app.view/TMain.class.php?method='+metodo+'&tipoRetorno=lista&formseq='+listseq+'&ret='+obRetorno, '', 'POST','Sucesso');
}


/*
 * manipula ativação e desativação dos campos padrões das abas
 */
function setBotAbas(id, act){
	
    var obBot = document.getElementById(id);
	
}



//////////////////////////////////////////////////////////////
// Executa escripte para alocar dados em sessão
/////////////////////////////////////////////////////////////
function alocaDado(obj){
    exe('obRet', getPath()+'/app.util/alocaDados.php?alValor='+obj.value+'&idc='+obj.id, '', 'GET','Sucesso');
}

//////////////////////////////////////////////////////////////
// Executa sistema de envio de dados via pesquisa
//////////////////////////////////////////////////////////////
function setDadosPesquisa(listseq, tipoRetorno, dados, seq){

    if(dados != ""){

        var vDados = dados.split("(sp)");		
        for(var x=0; x<vDados.length; x++){
            
            var vd = vDados[x].split("=>");
            var field = document.getElementById(vd[0]);


            if(field){
                var lb = vd[1].split('/',2);
                if(field.options){
                    if(lb[1]){
                        var newOption = document.createElement("OPTION");
                        newOption.text = lb[1];
                        newOption.value = lb[0];
                        newOption.selected = "selected";
                        var i;
                        for(i=field.options.length-1;i>=0;i--){
                            field.remove(i);
                        }
                        field.options.add(newOption);
                    //field.innerHTML = '<option value="'+lb[0]+'" selected>'+lb[1]+'</option>';
                    }else{
                        for(var i=0; i<field.options.length;i++){
                            if(field.options[i].value == lb[0]){
                                field.selectedIndex = i;
                            }
                        }
                    }
                }else{
                    field.value = vd[1];
                }

                if(field.onblur){
                    field.onblur();
                }
                if(field.onchange){
                    field.onchange();
                }
            }
        }

        jQuery('#'+listseq+'-window').dialog('close');
    }else{
        alertPetrus("Nenhum dado foi transferido - ERROR");
    }
}


/*
* Marcador nas linhas da lista
*/
function onMarcador(ob){
	
    var obPai = ob.parentNode;
    var obAvo = obPai.parentNode;
	
    if(ob.checked == true){
        obAvo.onmouseout = null;
    }else{
        //obAvo.createEvent("MouseEvents");
        obAvo.event(function anonymous(){
            this.className = 'tdatagrid_row_over'
        });
    }
}

/**
* Executa e injeta valores em campos predefinidos Ex: Autopreecher no select
*/
function onLoadSelect(obj, alvo, classe, metodo){

    if(obj){
        var valores = 'classe='+classe+'&metodo='+metodo+'&seq='+obj.value;
        var retorno = exe('', getPath()+'/app.util/TSec.php',  valores, 'POST','Sucesso');

        alvo = document.getElementById(alvo);
        alvo.innerHTML = retorno;
    }
}

/*
* Configura e exibe o relogio recursivamente
*/
function showTime(){
	
    var now = new Date();
    var hours = now.getHours();
    var minutes = now.getMinutes();
    var seconds = now.getSeconds();
    var timeValue = "" + ((hours < 10) ? "0" + hours: hours);
    timeValue  += ((minutes < 10) ? ":0" : ":") + minutes;
    timeValue  += ((seconds < 10) ? ":0" : ":") + seconds;
    // timeValue  += (hours >= 12) ? " P.M." : " A.M.";
	
    var box = document.getElementById('obTempo');
    box.innerHTML = timeValue;
    setTimeout("showTime()",1000);
	
}

// gera janelas de alertas
function setAlert(mensagem){
    $('<div id="alertaMensagem" title="Alerta">'+ mensagem +'</div>').appendTo('body');
    $('#alertaMensagem').dialog({
        modal : false,
        closeOnEscape: true,
        autoOpen : true,
        resizable: true,
        draggable: true,
        position: 'center',
        width: '480',
        height: '300',
        close : function() {
            $(this).remove()
        }
    });
}



/*
 * Clona um formulario
 */
function cloneForm(form,seq,lista,qtde){
    var valores = 'classe=TCloneForm&metodo=run&form='+form+'&cod='+seq+'&quantidade='+qtde;
    var retorno = exe('', getPath()+'/app.util/TSec.php',  valores, 'POST','Sucesso');
    $('#bodyDisplay').append(retorno);
    $('#confirmReplicacao').remove();

    listaRefresh(lista);
}


//Função para mudar de campo com a tecla enter
function checkForEnter (event) {
	
    if (event.keyCode == 13) {
        currentBoxNumber = textboxes.index(this);

        if (textboxes[currentBoxNumber + 1] != null) {
            nextBox = textboxes[currentBoxNumber + 1]
            nextBox.focus();
            event.preventDefault();
            return false;
        }
    }
}


function _GET(param){
	
	var wl = window.location.href;
	var params = urlDecode(wl.substring(wl.indexOf("?")+1));
	return(params[param]);
	
}

function pesqModulo(){
  alertPetrus('Em breve');
}


function alertPetrus(mensagem){
	
	//alert(titulo+'\n\n'+mensagem);
	alert(mensagem);
	
/*    if((!titulo) || (titulo == '')) titulo = 'Alerta';
    id = 'alert-' + $('.alerta').length;
    jQuery('<div id=\''+id+'\' title=\'' +titulo + '\' style="padding:15px" class=alerta></div>').html(mensagem).appendTo('body');

    jQuery( '#'+ id).dialog({
        resizable: false,
        modal: true,
        close : function() {
            $(this).remove()
        },
        buttons: {
            "Fechar": function() {
                $(this).remove();
            }
        }
    });*/
}
