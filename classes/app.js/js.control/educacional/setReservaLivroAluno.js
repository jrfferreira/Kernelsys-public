function setReservaLivroAluno(codigopessoa,codigolivro){
    Valores = '&codigopessoa='+codigopessoa+'&codigolivro='+codigolivro;
    var dados = 'classe=TBiblioteca&metodo=setReserva'+Valores;
    if(confirm("Deseja realmente reservar este livro?")){
        exe('retornoReservaLivroAluno',getPath()+'/app.util/TSec.php?'+dados,'','GET','Sucesso');
    }
}


