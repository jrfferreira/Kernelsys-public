function setPrivilegio(ob,codigousuario,nivel,funcionalidade,modulo){

    var situacao = ($(ob).attr('checked')) ? "1" : "0";

    var valores = '&codigousuario='+codigousuario+'&nivel='+nivel+'&funcionalidade='+funcionalidade+'&modulo='+modulo+'&situacao='+situacao;
    var dados = 'classe=TUsuario&metodo=setPrivilegio'+valores;
    var retorno = exe('', getPath()+'/app.util/TSec.php',dados,'POST','Sucesso');


    getOpcoesPrivilegios(codigousuario,nivel,funcionalidade,modulo,situacao);

}
