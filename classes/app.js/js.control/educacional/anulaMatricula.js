function anulaMatricula(cod, confirme){

    if(confirm(confirme) && cod){

        var dados = 'rcod='+cod;
        exe('contMatricula',getPath()+'/app.control/app.academico/anulaMatricula.php?rcod='+cod,'','GET','Sucesso');
        //petrus('contMatricula',getPath()+'/app.control/app.academico/anulaMatricula.php?rcod='+cod, 'GET', '', '','sub');
    }

}