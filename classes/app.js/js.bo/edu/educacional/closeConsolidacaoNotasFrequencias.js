function closeConsolidacaoNotasFrequencias(confirme,rformseq,key,obRetorno){
	if(obRetorno && confirm(obRetorno)){
		consolidaNotasFrequencias(confirme,rformseq,key,obRetorno);
	}else if(!obRetorno){
		consolidaNotasFrequencias(confirme,rformseq,key,obRetorno);
	}

}

function consolidaNotasFrequencias(confirme,rformseq,key,obRetorno){

    var dados = 'classe=TTurmaDisciplinas&metodo=consolidaNotasFrequencias';
	$.each($('#consolidacaoNotasFrequencias .check-disc:checked'),function(i,el){
		if($(el).val())
			dados += '&disc[]='+$(el).val();
	});


	exe('consolidacaoNotasFrequencias', getPath()+'/app.util/TSec.php', dados, 'POST', 'Sucesso');
        document.getElementById('fecharCaixa').disabled = 1;
}