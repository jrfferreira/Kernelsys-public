function viewLegenda(obRet,titulo,conteudo){

    var dados = "titulo="+titulo+"&conteudo="+conteudo;
    exe(obRet,getPath()+'/app.control/app.academico/windowLegenda.php?'+dados,'','GET','Sucesso');
}