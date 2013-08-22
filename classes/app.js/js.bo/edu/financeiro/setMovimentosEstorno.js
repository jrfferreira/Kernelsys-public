/**
 * 
 * @param ob
 * @param formseq
 * @return
 */
function setMovimentosEstorno(ob,formseq){
    if(confirm('É necessário confirmar a inclusão dos movimentos selecionados.\r\nApós este passo, uma nova movimentação será gerada.\r\n\r\nDeseja continuar?')){
       
        var ret = new String(exe('',getPath()+'/app.util/TSec.php?classe=TCaixa&metodo=setMovimentosEstorno&formseq='+formseq,'','GET','Sucesso'));
        
        ret = escape(ret.replace("\r","").replace("\n","").replace("/r","").replace("/n","").replace(/^\s+|\s+$/g,"").toString()).replace("%uFEFF","");
      
        if(ret){
        	if(onClose('form','478','contLista','')){
        		prossExe('onEdit','form','482',ret,'contLista479','');                
        	}
        }
    }
}


