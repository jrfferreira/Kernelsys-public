/**
 * Executa ação via ajax da funcinalidade de 
 * baixas Multiplas de contas a receber.
 * @param ob
 * @param idForm
 * @return
 */
function setBaixaContasMultiplas(ob,idForm){
	
    if(confirm('É necessário confirmar a baixa das contas selecionadas.\r\n\r\nDeseja continuar?')){
       
        var ret = new String(exe('',getPath()+'/app.util/TSec.php?classe=TTransacao&metodo=baixaContasMultiplas&idForm='+idForm,'','GET','Sucesso'));
        ret = escape(ret.replace("\r","").replace("\n","").replace("/r","").replace("/n","").replace(/^\s+|\s+$/g,"").toString()).replace("%uFEFF","");
        
        if(ret > 0){
        	alert('Foram Baixadas '+ret+' contas com sucesso.');
        	listaRefresh('477');
        }
    }
}


