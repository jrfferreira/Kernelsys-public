function execProcessoAcademico(aluno,op){
        var dados = 'classe=TProcessoAcademico&metodo=execProcessoAcademico&codigoaluno=' + aluno + '&opcao=' + op;
        exe('respProcessoAcademico', getPath()+'/app.util/TSec.php', dados, 'POST', 'Sucesso');
}

function confirmaProcessoAcademico(aluno,op){
        var dados = 'classe=TProcessoAcademico&metodo=confirmaProcessoAcademico&codigoaluno=' + aluno + '&opcao=' + op;
        exe('respProcessoAcademico', getPath()+'/app.util/TSec.php', dados, 'POST', 'Sucesso');
}

function alteraDisciplinaAlunoEspecial(codigodisciplinaantiga,codigodisciplinanova,tudiseq){
	
	coddisciplinaantiga = $('#' + codigodisciplinaantiga).val();
	coddisciplinanova = $('#' + codigodisciplinanova).val();
	codturmadisciplina = $('#' + tudiseq).val();
		
	if((coddisciplinaantiga != 0 || coddisciplinanova != 0) && codturmadisciplina != 0){	
		var dados = 'classe=TProcessoAcademico&metodo=setRegularizacaoAlunoEspecial&codigodisciplinaantiga=' + coddisciplinaantiga + '&codigodisciplinanova=' + coddisciplinanova + '&tudiseq=' + codturmadisciplina;
    	exe('retornoProcessoAcademico', getPath()+'/app.util/TSec.php', dados, 'POST', 'Sucesso');
    	
    	$('#' + codigodisciplinaantiga).val(0);
    	$('#' + codigodisciplinanova).val(0);
    	$('#' + tudiseq).val(0);
    	
	}else{
		alertPetrus('Existem campos não preenchidos.<br/>Tente Novamente','Erro no Processo Acadêmico');
	}	
	
}

function setAbandonoCurso(codigoaluno){
			
		var dados = 'classe=TProcessoAcademico&metodo=setAbandonoCurso&codigaluno=' + codigoaluno;
		alert(dados);
    	exe('retornoProcessoAcademico', getPath()+'/app.util/TSec.php', dados, 'POST', 'Sucesso');
	
}

function setTrancamentoCurso(codigoaluno){
	
	var dados = 'classe=TProcessoAcademico&metodo=setTrancamentoCurso&codigaluno=' + codigoaluno;
	alert(dados);
	exe('retornoProcessoAcademico', getPath()+'/app.util/TSec.php', dados, 'POST', 'Sucesso');

}

function setDestrancamentoMatricula(codigoaluno){
	
	var dados = 'classe=TProcessoAcademico&metodo=setDestrancamentoMatricula&codigaluno=' + codigoaluno;
	alert(dados);
	exe('retornoProcessoAcademico', getPath()+'/app.util/TSec.php', dados, 'POST', 'Sucesso');

}

