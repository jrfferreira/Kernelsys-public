function setXOR(campoA, campoB, value){
    if($('#'+campoB).val() != null){
        $('#'+campoB).val(value);
        $('#'+campoA).focus();
    }
}