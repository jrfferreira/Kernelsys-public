function addAllDisciplinasTurma(ob,idForm){
    Valores = '&idForm='+idForm;
    var dados = 'classe=TTurma&metodo=addTurmaDisciplina'+Valores;
    exe(ob,getPath()+'/app.util/TSec.php?'+dados,'','GET','Sucesso');
}