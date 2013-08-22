

function getErro(retorno){
	if(retorno && typeof(retorno) == 'string'){
	    var erro = retorno.slice(0,5);
	    if(erro == 'erro#'){
	        erro = 'erro';
	    }else{
	        erro = '';
	    }
	    return erro;
	}
}
/*
 * 
 */
function setTipoPessoa($obj){	
	if($obj.checked & $obj.value == '1' ){
		$('#bloc_blocoPessoaFisica').show();
		$('#bloc_blocoPessoaJuridica').hide();
		
		$('#bloc_blocoPessoaFisica').find('[manter]').attr('manter', true);
		$('#bloc_blocoPessoaJuridica').find('[manter]').attr('manter', false);
		
	}else if($obj.checked & $obj.value == '2'){
		$('#bloc_blocoPessoaJuridica').show();
		$('#bloc_blocoPessoaFisica').hide();
		
		$('#bloc_blocoPessoaJuridica').find('[manter]').attr('manter', true);
		$('#bloc_blocoPessoaFisica').find('[manter]').attr('manter', false);
		
	}
	
}



// executa a função de armazenamento [pross] de um campo tercerizado
function triggerPross(id){
    var ob = document.getElementById(id);
    ob.onblur();
}


//Esconde ou exibe bloco (altera a situação atual)
function toggleBlock(id){
    $('#'+id).toggle('blind');
}


function calcula(campo,string){
    var conta = string;
    str.match('$');


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


function populaCampo(campoRet,campoFk,colunaFk,tabela,coluna){

    var valores = '&campoFk='+ $('#'+campoFk).val() +'&colunaFk='+colunaFk+'&tabela='+tabela+'&coluna='+coluna;
    var dados = 'classe=TPopulaCampo&metodo=commit'+valores;

    var resposta = exe('', getPath()+'/app.util/TSec.php',dados,'POST','Sucesso');

    if(resposta){
        $('#'+campoRet).val(resposta);
    }
}

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
