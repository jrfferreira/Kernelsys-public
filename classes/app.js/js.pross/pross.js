//window.history.forward(1);
//ELIMINA CARACTERES EM BRANCO
function trim(str){
    return str.replace(/^\s+|\s+$/g,"");
}

function replaceAll(string, search, newstring) {
    if(!newstring) newstring = '';
    while (string.indexOf(search) != -1) {
        string = string.replace(search, newstring);
    }
    return string;
}

function pesqModulo(){
    alertPetrus('Em breve');
}

function alertPetrus(mensagem){	
	alert(mensagem);	
}

function setExcecao(idForm,view,retorno){
		
	 var erro = getErro(retorno);
     if(erro == 'erro'){
         setRertonoControl(idForm, retorno);
     }else{
         if(view && jQuery('#'+view).length > 0){
             jQuery('#'+view).html(retorno);
         }

         atribuicao();
     }
	
}

// executa interface Principal \\
function prossInter(ob, codigo){

    var labelMd = document.getElementById('obLabelModulo');
    labelMd.innerHTML = ob.innerHTML;

    $(".modulobot").removeClass("modulobotClick");
    $(ob).addClass('modulobotClick');
    exe('bodyDisplay', getPath()+'/app.view/TMenu.class.php?id='+codigo, '', 'GET', 'Sucesso');
}

// executa interface Secundária \\
function prossInterSec(mod, url){

    var labelMdSec = document.getElementById('obLabelSec');
    labelMdSec.innerHTML = mod;
    exe('displaySys', getPath()+'/app.view/'+url, '', 'GET', 'Sucesso');
}

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
//Recupera os camos da tela e armazena envia ao servidor
function onSave(idForm, nomeform, tipoRetorno, alvo, notClose){
	
	var metodo    = 'onSave';
	var valor     = '';
	var campos    = '';
	var formCampo = document.getElementById(nomeform);
	var elementos = formCampo.getElementsByTagName('*');
	

	for(var i = 0; i < elementos.length; i++) {
		
		if (elementos[i].getAttribute('manter')) {
			
//			    if(elementos[i].type=="select-one" && elementos[i].value==0){
//			        valor = "";
//			    }else 
			    if(elementos[i].type=="checkbox" && elementos[i].checked==false){
			        valor = "0";
			    }
			    else if(elementos[i].type=="radio" && elementos[i].checked == false){
			        continue;
			    }else{
			        valor = elementos[i].value;
			    }	    
			campos = campos+'&'+elementos[i].name+'='+valor;
		}
	}
	
	//====================================
	var retorno = exe('', getPath()+'/app.view/TExecs.class.php?method='+metodo+'&tipoRetorno='+tipoRetorno+'&idForm='+idForm, campos, 'POST', 'Sucesso');
	
	setExcecao(idForm,alvo,retorno); 
    if(!notClose) jQuery('#'+idForm+'-window').dialog('close'); 
    
}


//interface do metodo onClose
function onClose(tipoRetorno, idForm, alvo, confirme){

  var metodo = 'onClose';

  if(confirme!=""){

      jQuery('<div id=\'confirmation' + idForm + '\' title=\'Confirmação\' style="padding:15px"></div>').html(confirme).appendTo('body');

      jQuery( '#confirmation' + idForm ).dialog({
          resizable: false,
          modal: true,
          close : function() {
              $(this).remove();
          },
          buttons: {
              "Cancelar": function() {
                  $(this).remove();
              },
              "Confirmar": function() {
                  $(this).remove();
                  
                  // executa ação de salvar campo a campo
                  execSaveAction(idForm,'false');
                  
                    	

                  var retorno = exe('', getPath()+'/app.view/TExecs.class.php?method='+metodo+'&tipoRetorno='+tipoRetorno+'&idForm='+idForm, '', 'GET', 'Sucesso');
                  setExcecao(idForm, alvo, retorno);
                  jQuery('#'+idForm+'-window').dialog('close');
                  
              }
          }
      });
  }else{
	  
      //compAction(metodo, key);
      var retorno = exe('', getPath()+'/app.view/TExecs.class.php?method='+metodo+'&tipoRetorno='+tipoRetorno+'&idForm='+idForm, '', 'GET', 'Sucesso');
  	
      setExcecao(idForm, alvo, retorno);
      jQuery('#'+idForm+'-window').dialog('close');
  }
  
  return true;
}

//interface do metodo onCancel
function onCancel(tipoRetorno, idForm, key, alvo, confirme){

  var metodo = 'onCancel';

  if(confirme!=""){

      jQuery('<div id=\'confirmation' + idForm + '\' title=\'Confirmação\' style="padding:15px"></div>').html(confirme).appendTo('body');

      jQuery( '#confirmation' + idForm ).dialog({
          resizable: false,
          modal: true,
          close : function() {
              $(this).remove();
          },
          buttons: {
              "Cancelar": function() {
                  $(this).remove();
              },
              "Confirmar": function() {
                  $(this).remove();
                  
                  var retorno = exe('', getPath()+'/app.view/TExecs.class.php?method='+metodo+'&tipoRetorno='+tipoRetorno+'&idForm='+idForm+'&key='+key, '', 'GET', 'Sucesso');

                  setExcecao(idForm, alvo, retorno);
                  jQuery('#'+idForm+'-window').dialog('close');
              }
          }
      });
  }else{
      var retorno = exe('', getPath()+'/app.view/TExecs.class.php?method='+metodo+'&tipoRetorno='+tipoRetorno+'&idForm='+idForm+'&key='+key, '', 'GET', 'Sucesso');
    	setExcecao(idForm, alvo, retorno);
        jQuery('#'+idForm+'-window').dialog('close');
  }
}



// executa funções das funcionalidades [formulários / listas]

function prossExe(metodo, tipoObjeto, idForm, key, obRetorno, confirme){
	
    //var condiction = true;
    //configura os dados do filtro
    var valField = setFiltro(idForm);
    if(confirme!=""){
        jQuery('<div id=\'confirmation' + idForm + '\' title=\'Confirmação\' style="padding:15px"></div>').html(confirme).appendTo('body');

        jQuery( '#confirmation' + idForm ).dialog({
            resizable: false,
            modal: true,
            close : function() {
                $(this).remove();
            },
            buttons: {
                "Cancelar": function() {
                    $(this).remove();
                },
                "Confirmar": function() {
                    $(this).remove();    
                    
                    callback = function(ajaxArgs){
                     	setExcecao(idForm, obRetorno, ajaxArgs);
                     }
                    var url = getPath()+'/app.view/TExecs.class.php?method='+metodo+'&tipoRetorno='+tipoObjeto+'&idForm='+idForm+'&key='+key+'&ret='+obRetorno;
                    exe('', url, valField, 'POST', 'Sucesso',callback);     

                    
                }
            }
        });


    }else{
    	var url = getPath()+'/app.view/TExecs.class.php?method='+metodo+'&tipoRetorno='+tipoObjeto+'&idForm='+idForm+'&key='+key+'&ret='+obRetorno;
    	callback = function(ajaxArgs){
         	setExcecao(idForm, obRetorno, ajaxArgs);
         }

         exe('', url, valField, 'POST', 'Sucesso',callback);

    }
}

/*
 * Controle visual da seleção de campos na lista.
 */
function onSelecao(ob, idLista, codigoRegistro){
	
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
    var resp = codigoRegistro == 'all' ? 'contLista'+idLista : 'winRet';
    var retorno = exe(resp, getPath()+'/app.view/TExecs.class.php?method='+metodo+'&acselecao='+acSelecao+'&dados='+dados+'&idForm='+idLista, '', 'GET', 'Sucesso');
}

/*
 * Abre formulário independente
 */
function onFormOpen(idForm, obj){

    if(obj){
        var obRetorno = obj.parentNode;
        var view = obRetorno.id;
    }


    var retorno = exe('', getPath()+'/app.view/TExecs.class.php?method=onFormOpen&idForm='+idForm, '', 'GET', 'Sucesso');

    var erro = getErro(retorno);
    if(erro == 'erro'){
        setRertonoControl(idForm, retorno);
    }else{
        jQuery('#'+view).append(retorno);
        atribuicao();
    }
}


//INICIO - funções referentes a Impressão de listas
function printDataGrid(idForm, pane){
    var metodo = 'onPrint';
    var retorno = exe('', getPath()+'/app.view/TExecs.class.php?method='+metodo+'&tipoRetorno=list&idForm='+idForm, '', 'GET', 'Sucesso');

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
function setFiltro(idLista){

    var vfiltro = document.getElementById('expre'+idLista);
    if(vfiltro!=null && vfiltro.value!=""){
        var col = document.getElementById('cols'+idLista);
        var mfilt = document.getElementById('Manterfilt'+idLista);
        vfiltro.value = vfiltro.value;
        var valField = vfiltro.name+'='+vfiltro.value+'&'+col.name+'='+col.value+'&'+mfilt.name+'='+mfilt.checked;
    }else{
        valField = null;
    }

    return valField;
}

// executa a função de armazenamento [pross] de um campo tercerizado
function triggerPross(id){
    var ob = document.getElementById(id);
    ob.onblur();
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
 * @param idForm = Id fo formulário representado pela lista
 */
function listaRefresh(idLista){
    var obRetorno = 'contLista'+idLista;
    var metodo = 'onRefresh';
    exe(obRetorno,getPath()+'/app.view/TExecs.class.php?method='+metodo+'&tipoRetorno=lista&idForm='+idLista+'&ret='+obRetorno, '', 'POST','Sucesso');
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
function setDadosPesquisa(idLista, tipoRetorno, dados, codigo){

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

        jQuery('#'+idLista+'-window').dialog('close');
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
            this.className = 'tdatagrid_row_over';
        });
    }
}

/**
* Executa e injeta valores em campos predefinidos Ex: Autopreecher no select
*/
function onLoadSelect(obj, alvo, classe, metodo){

    if(obj){
        var valores = 'classe='+classe+'&metodo='+metodo+'&codigo='+obj.value;
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

//Esconde ou exibe bloco (altera a situação atual)
function toggleBlock(id){
    $('#'+id).toggle('blind');
}


function calcula(campo,string){
    var conta = string;
    str.match('$');


}


function cloneForm(form,codigo,lista,qtde){
    var valores = 'classe=TCloneForm&metodo=run&form='+form+'&cod='+codigo+'&quantidade='+qtde;
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


function addAllReg(ob){
    var attrOb = $(ob).attr('checked') == true ? true : false;
    $(ob).parent().parent().parent().find('input:checkbox[checked!='+attrOb+'][id!='+$(ob).attr('id')+']').attr('checked',attrOb).click().attr('checked',attrOb);
}

function urlDecode(string, overwrite){
    if(!string || !string.length){
        return {};
    }
    var obj = {};
    var pairs = string.split('&');
    var pair, name, value;
    var lsRegExp = /\+/g;
    for(var i = 0, len = pairs.length; i < len; i++){
        pair = pairs[i].split('=');
        name = unescape(pair[0]);
        value = unescape(pair[1]).replace(lsRegExp, " ");
        //value = decodeURIComponent(pair[1]).replace(lsRegExp, " ");
        if(overwrite !== true){
            if(typeof obj[name] == "undefined"){
                obj[name] = value;
            }else if(typeof obj[name] == "string"){
                obj[name] = [obj[name]];
                obj[name].push(value);
            }else{
                obj[name].push(value);
            }
        }else{
            obj[name] = value;
        }
    }
    return obj;
}


function _GET(param){
	
	var wl = window.location.href;
	var params = urlDecode(wl.substring(wl.indexOf("?")+1));
	return(params[param]);
	
}


function populaCampo(campoRet,campoFk,colunaFk,tabela,coluna){

    var valores = '&campoFk='+ $('#'+campoFk).val() +'&colunaFk='+colunaFk+'&tabela='+tabela+'&coluna='+coluna;
    var dados = 'classe=TPopulaCampo&metodo=commit'+valores;

    var resposta = exe('', getPath()+'/app.util/TSec.php',dados,'POST','Sucesso');

    if(resposta){
        $('#'+campoRet).val(resposta);
    }
}