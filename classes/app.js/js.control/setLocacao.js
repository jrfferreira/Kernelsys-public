function setLocacao(ob,campolivro,campopessoa,botao){
    var livro = $("#"+campolivro).val();
    var pessoa = $("#"+campopessoa).val();
    var retorno = ob;
    Valores = '&codigolivro='+livro+'&codigopessoa='+pessoa;
    var dados = 'classe=TBiblioteca&metodo=viewSetLocacao'+Valores;
    if(confirm("Deseja realmente incluir este livro?")){
        exe(retorno,getPath()+'/app.util/TSec.php?'+dados,'','GET','Sucesso');
        $('#'+botao).hide();
        $("#"+campolivro+'> option[value="0"]').attr("selected","1");
    }

}