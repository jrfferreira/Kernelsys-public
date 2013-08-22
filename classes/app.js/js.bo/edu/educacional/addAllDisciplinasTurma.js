function addAllDisciplinasTurma(ob,formseq){
    Valores = '&formseq='+formseq;
    var dados = 'classe=TTurma&metodo=addTurmaDisciplina'+Valores;
    exe(ob,getPath()+'/app.util/TSec.php?'+dados,'','GET','Sucesso');
}