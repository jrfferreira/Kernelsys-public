function setBaixaMultipla(ob,formseq){
    Valores = '&formseq='+formseq;
    var dados = 'classe=TCaixa&metodo=setBaixaMultipla'+Valores;
    if(exe(ob,getPath()+'/app.util/TSec.php?'+dados,'','GET','Sucesso')){
    	onClose('form','484','contLista','');
        prossInterSec('Movimento de Caixa', 'TExecs.class.php?method=getList&formseq=144&nivel=1');
    }
}