function addAllDisciplinasCurso(ob,idForm){
    Valores = '&idForm='+idForm;
    var dados = 'classe=TCurso&metodo=addCursoDisciplina'+Valores;
    exe(ob,getPath()+'/app.util/TSec.php?'+dados,'','GET','Sucesso');
}