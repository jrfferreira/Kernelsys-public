function viewDocumento(id){
    var ob = document.getElementById(id);
    var seq = ob.value;
    window.open('../app.control/app.util/showDocumento.php?documento='+seq, 'Documento', 'scrollbars=yes,toolbar=yes,menubar=no,resizable=yes,width=700,height=600,top=50,left=200');

}