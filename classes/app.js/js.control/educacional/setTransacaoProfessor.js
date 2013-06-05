function setTransacaoProfessor(idForm){
    Valores = '&idForm='+idForm;
    var dados = 'classe=TTurmaDisciplinas&metodo=setTransacaoProfessor'+Valores;
    var ret = exe('',getPath()+'/app.util/TSec.php?'+dados,'','GET','Sucesso');
	    
    ret = escape(ret.replace("\r","").replace("\n","").replace("/r","").replace("/n","").replace(/^\s+|\s+$/g,"").toString()).replace("%uFEFF","");
  
    if(ret){
    	if(onClose('form','59','contLista200','')){
        	prossExe('onEdit','form','72',ret,'contLista200','');                
    	}
    }
}