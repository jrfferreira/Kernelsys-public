function showEtiquetas(lista){

    if(lista || lista.alt){

        if(lista.alt){
            lista = lista.alt;
        }

        window.open('../app.pagina/showEtiquetas.php?cod='+lista, 'etiquetas', 'scrollbars=yes,toolbar=yes,menubar=no,resizable=no,width=600,height=760,top=50,left=100');
    }
    else{
        alertPetrus('Lista inválida.','Erro');
    }
}