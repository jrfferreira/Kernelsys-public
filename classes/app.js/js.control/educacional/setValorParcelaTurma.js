function setValorParcelaTurma(vTotal, nParcela, cAlvo){

       var total = document.getElementById(vTotal);
       var parcela = document.getElementById(nParcela);
       var alvo = document.getElementById(cAlvo);

       var valorParcela = alvo.value.replace('R$ ', '');

       if(parseFloat(valorParcela) > 0 && parseInt(parcela.value) > 0){
            total.value = (parseFloat(valorParcela) * parseInt(parcela.value));
            total.onblur();
       }
}