function changePassword(usuario,ob_old_pass,ob_new_pass,ob_confirm){
    ob_old_pass = document.getElementById(ob_old_pass).value;
    ob_new_pass = document.getElementById(ob_new_pass).value;
    ob_confirm = document.getElementById(ob_confirm).value;

    Valores = '&aluno='+usuario+'&old_pass='+ob_old_pass+'&new_pass='+ob_new_pass+'&confirm='+ob_confirm;
    dados = 'classe=TUsuario&metodo=execChangePassword'+Valores;
    exe('password_return',getPath()+'/app.util/TSec.php?'+dados,'','GET','Sucesso');
}

function createPassword(usuario,ob_pass,ob_confirm){
    ob_pass = document.getElementById(ob_pass).value;
    ob_confirm = document.getElementById(ob_confirm).value;

    if(ob_pass && ob_confirm){
        Valores = '&aluno='+usuario+'&pass='+ob_pass+'&confirm='+ob_confirm;
        dados = 'classe=TUsuario&metodo=execCreatePassword'+Valores;
        exe('password_return',getPath()+'/app.util/TSec.php?'+dados,'','GET','Sucesso');
    }
}

