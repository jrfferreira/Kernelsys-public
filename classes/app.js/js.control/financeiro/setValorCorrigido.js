function setValorCorrigido(valortotal, desconto, acrescimo, valorCorrigido){

    var obValorTotal        = document.getElementById(valortotal);
    var obDesconto          = document.getElementById(desconto);
    var obAcrescimo         = document.getElementById(acrescimo);
    var obValorCorrigido    = document.getElementById(valorCorrigido);

    if(obValorTotal.value > 0){
        var dados = "classe=TTransacao&metodo=setValorCorrigido&valortotal="+obValorTotal.value+"&desconto="+obDesconto.value+"&acrescimo="+obAcrescimo.value;
        var resultado = exe('', getPath()+'/app.util/TSec.php', dados, 'POST', 'Sucesso');
        obValorCorrigido.value = resultado;
        obValorCorrigido.onblur();
    }
}