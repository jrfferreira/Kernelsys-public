function imprimiOrcamento(codigo){    
    window.open('../app.pagina/showPedidoDG.php?cod='+codigo+'&juros='+ $('#jurosOrcamento').val(), 'Orcamento', 'scrollbars=yes,toolbar=yes,menubar=no,resizable=yes,width=680,height=340,top=50,left=200');
}

function imprimiOrcamentoList(onset,codigo){
    window.open('../app.pagina/showPedidoDG.php?cod='+codigo, 'Orcamento', 'scrollbars=yes,toolbar=yes,menubar=no,resizable=yes,width=680,height=340,top=50,left=200');
}
