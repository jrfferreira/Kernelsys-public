function setAlunoNota(ob,tudiseq,alunseq,avalseq){
    var nota = $('#'+ob).val();
    nota = parseFloat(nota.replace(',','.'));
    
    if(nota > 10  && nota < 100){
    	nota = parseFloat(nota/10);
    }
    
    $('#'+ob).val(nota);
    
    Valores = '&tudiseq='+tudiseq+'&avalseq='+avalseq+'&alunseq='+alunseq+'&nota='+nota;
    var dados = 'classe=TTurmaDisciplinas&metodo=setNota'+Valores;
    exe(ob,getPath()+'/app.util/TSec.php?'+dados,'','GET','Sucesso');
}