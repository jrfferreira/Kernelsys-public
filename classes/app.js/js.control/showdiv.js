function showdiv(id1){

    var divfoco=document.getElementById(id1);
    var img = this;
    if(divfoco.style.display == 'block'){
        divfoco.style.display = 'none';
        img.src = "../app.view/app.images/expandDiv.png";
    }
    else if(divfoco.style.display == 'none'){
        divfoco.style.display = 'block';
        img.src = "../app.view/app.images/ocultDiv.png";

    }
}