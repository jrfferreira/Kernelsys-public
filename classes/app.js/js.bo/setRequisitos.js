function setRequisitos(ob, seqAluno, seqAlunoRequisito){

    var situacao = ($(ob).attr('checked')) ? "1" : "2";

    var valores = '&seqaluno='+seqAluno+'&seqrequisito='+seqAlunoRequisito+'&situacao='+situacao;
    var dados = 'classe=TAluno&metodo=setRequisitos'+valores;

    var retorno = exe('', getPath()+'/app.util/TSec.php',dados,'POST','Sucesso');
}