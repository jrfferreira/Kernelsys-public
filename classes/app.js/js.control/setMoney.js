function setMoney(valor,ob){
    valor = String(valor);
    valor = valor.replace(',','.');
    valor = ((Math.round(parseFloat(valor)*100))/100);
    valor = String(valor);
    valor = valor.replace('.',',');

    if(ob){
        ob.value = valor;
    }else{
        return valor;
    }
}