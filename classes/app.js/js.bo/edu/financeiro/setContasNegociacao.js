/**
 * 
 * @param ob
 * @param formseq
 * @return
 */
function setContasNegociacao(ob,formseq){
    if(confirm('É necessário confirmar a inclusão das contas selecionadas.\r\nApós este passo, uma nova transação será gerada.\r\n\r\nDeseja continuar?')){
       
        var ret = new String(exe('',getPath()+'/app.util/TSec.php?classe=TTransacao&metodo=setContasNegociacao&formseq='+formseq,'','GET','Sucesso'));
        
        ret = escape(ret.replace("\r","").replace("\n","").replace("/r","").replace("/n","").replace(/^\s+|\s+$/g,"").toString()).replace("%uFEFF","");
      
        if(ret){
        	if(onClose('form','29','contLista163','')){
            	prossExe('onEdit','form','67',ret,'contLista163','');                
        	}
        }
    }
}


