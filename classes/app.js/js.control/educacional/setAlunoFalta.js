function setAlunoFalta(ob,codigoturma,aluno,codigoaula,numeroaula){

    var situacao = ($('#'+ob).attr('checked')) ? "F" : "P";
    Valores = '&codigoturmadisciplina='+codigoturma+'&codigoaluno='+aluno+'&codigoaula='+codigoaula+'&aula='+numeroaula+'&situacao='+situacao;
    var dados = 'classe=TTurmaDisciplinas&metodo=setFalta'+Valores;
    exe(ob,getPath()+'/app.util/TSec.php?'+dados,'','GET','Sucesso');
}

function setJustificativa(ob,codigoturma,aluno,codigoaula){

    if(document.getElementById(ob).value != null || document.getElementById(ob).value != '') var justificativa = document.getElementById(ob).value;
    if(justificativa && justificativa != '' && justificativa != null){
    Valores = '&codigoturmadisciplina='+codigoturma+'&codigoaluno='+aluno+'&codigoaula='+codigoaula+'&just='+justificativa;
    var dados = 'classe=TTurmaDisciplinas&metodo=setJustificativaFalta'+Valores;
    exe(ob,getPath()+'/app.util/TSec.php?'+dados,'','GET','Sucesso');
    }
}

