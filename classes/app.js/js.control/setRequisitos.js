function setRequisitos(ob, codigoAluno, codigoAlunoRequisito){

    var situacao = ($(ob).attr('checked')) ? "1" : "2";

    var valores = '&codigoaluno='+codigoAluno+'&codigorequisito='+codigoAlunoRequisito+'&situacao='+situacao;
    var dados = 'classe=TAluno&metodo=setRequisitos'+valores;

    var retorno = exe('', getPath()+'/app.util/TSec.php',dados,'POST','Sucesso');
}