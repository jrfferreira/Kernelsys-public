function addAllDisciplinasCurso(ob,formseq){
    Valores = '&formseq='+formseq;
    var dados = 'classe=TCurso&metodo=addCursoDisciplina'+Valores;
    exe(ob,getPath()+'/app.util/TSec.php?'+dados,'','GET','Sucesso');
}