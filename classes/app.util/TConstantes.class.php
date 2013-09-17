<?php
/**
 * Classe TConstantes
 *
 * author Joao Felix
 */
class TConstantes {
	
	// Nomes das tabelas dbpetrus com intuito validstatseq e repositório.
	const ALUNO_NOTA_FREQUENCIA = "aluno_nota_frequencia";
	const DBALUNO = "dbaluno";
	const DBALUNO_DISCIPLINA = "dbaluno_disciplina";
	const DBALUNO_REQUISITO = "dbaluno_requisito";
	const DBALUNO_SOLICITACAO = "dbaluno_solicitacao";
	const DBAPROVEITAMENTO_DISCIPLINA = "dbaproveitamento_disciplina";
	const DBAREA_CURSO = "dbarea_curso";
	const DBAVALIACAO = "dbavaliacao";
	const DBBALANCO_PATRIMONIAL = "dbbalanco_patrimonial";
	const DBBOLETO = "dbboleto";
	const DBBOLETO_ESTRUTURA = "dbboleto_estrutura";
	const DBCAIXA = "dbcaixa";
	const DBCAIXA_FUNCIONARIO = "dbcaixa_funcionario";
	const DBCARGO = "dbcargo";
	const DBCDU = "dbcdu";
	const DBCHEQUE = "dbcheque";
	const DBCONTA_FINANCEIRA = "dbconta_financeira";
	const DBCONVENIO = "dbconvenio";
	const DBCONVENIO_DESCONTO = "dbconvenio_desconto";
	const DBCOTACAO = "dbcotacao";
	const DBCURRICULO = "dbcurriculo";
	const DBCURSO = "dbcurso";
	const DBDEMANDA = "dbdemanda";
	const DBDEPARTAMENTO = "dbdepartamento";
	const DBDISCIPLINA = "dbdisciplina";
	const DBDISCIPLINA_SIMILAR = "dbdisciplina_similar";
	const DBDOCUMENTOS = "dbdocumentos";
	const DBEMAIL = "dbemail";
	const DBENDERECO = "dbendereco";
	const DBFALTA = "dbfalta";
	const DBFECHAMENTO_CAIXA = "dbfechamento_caixa";
	const DBFECHAMENTO_CONTA_FINANCEIRA = "dbfechamento_conta_financeira";
	const DBFORMA_PAGAMENTO = "dbforma_pagamento";
	const DBFUNCIONARIO = "dbfuncionario";
	const DBFUNCIONARIO_OCORRENCIA = "dbfuncionario_ocorrencia";
	const DBFUNCIONARIO_TREINAMENTO = "dbfuncionario_treinamento";
	const DBGRADE_AVALIACAO = "dbgrade_avaliacao";
	const DBINSCRICAO = "dbinscricao";
	const DBLIVRO = "dblivro";
	const DBLOCACAO_LIVRO = "dblocacao_livro";
	const DBNOTA = "dbnota";
	const DBPARCELA = "dbparcela";
	const DBPARCELA_ESTORNO = "dbparcela_estorno";
	const DBPATRIMONIO = "dbpatrimonio";
	const DBPESSOA = "dbpessoa";
	const DBPESSOA_FISICA = "dbpessoa_fisica";
	const DBPESSOA_JURIDICA = "dbpessoa_juridica";
	const DBPESSOA_TITULARIDADE = "dbpessoa_titularidade";
	const DBPHA = "dbpha";
	const DBPLANO_CONTA = "dbplano_conta";
	const DBPROCESSO_ACADEMICO = "dbprocesso_academico";
	const DBPRODUTO = "dbproduto";
	const DBPROFESSOR = "dbprofessor";
	const DBPROFESSOR_AREA = "dbprofessor_area";
	const DBPROJETO_CURSO = "dbprojeto_curso";
	const DBPROJETO_CURSO_DISCIPLINA = "dbprojeto_curso_disciplina";
	const DBRECADO = "dbrecado";
	const DBREGRA_AVALIACAO = "dbregra_avaliacao";
	const DBREQUISITO_TURMA = "dbrequisito_turma";
	const DBSALA = "dbsala";
	const DBSITUACAO_BOLETO = "dbsituacao_boleto";
	const DBSITUACAO_CAIXA_FUNCIONARIO = "dbsituacao_caixa_funcionario";
	const DBSITUACAO_MOVIMENTO = "dbsituacao_movimento";
	const DBSITUACAO_PARCELA = "dbsituacao_parcela";
	const DBSITUACAO_TURMA = "dbsituacao_turma";
	const DBSTATUS = "dbstatus";
	const DBTELEFONE = "dbtelefone";
	const DBTIPO_CONVENIO = "dbtipo_convenio";
	const DBTIPO_CURSO = "dbtipo_curso";
	const DBTIPO_ESTORNO = "dbtipo_estorno";
	const DBTIPO_PRODUTO = "dbtipo_produto";
	const DBTIPO_TELEFONE = "dbtipo_telefone";
	const DBTITULARIDADE = "dbtitularidade";
	const DBTRANSACAO = "dbtransacao";
	const DBTRANSACAO_ALUNO = "dbtransacao_aluno";
	const DBTRANSACAO_CONVENIO = "dbtransacao_convenio";
	const DBTRANSACAO_PRODUTO = "dbtransacao_produto";
	const DBTREINAMENTO = "dbtreinamento";
	const DBTURMA = "dbturma";
	const DBTURMA_CONVENIO = "dbturma_convenio";
	const DBTURMA_DISCIPLINA = "dbturma_disciplina";
	const DBTURMA_DISCIPLINA_ARQUIVO = "dbturma_disciplina_arquivo";
	const DBTURMA_DISCIPLINA_AULA = "dbturma_disciplina_aula";
	const DBTURMA_DISCIPLINA_AVALIACAO = "dbturma_disciplina_avaliacao";
	const DBTURMA_DISCIPLINA_MATERIAL = "dbturma_disciplina_material";
	const DBTURMA_DISCIPLINA_PLANOAULA = "dbturma_disciplina_planoaula";
	const DBUNIDADE = "dbunidade";
	const DBUNIDADE_PARAMETRO = "dbunidade_parametro";
	const DBUSUARIO = "dbusuario";
	const DBUSUARIO_PRIVILEGIO = "dbusuario_privilegio";
	
	// Visualizações
	const VIEW_ALUNO = "view_aluno";
	const VIEW_ALUNO_SOLICITACAO = "view_aluno_solicitacao";
	const VIEW_AREA_CURSO = "view_area_curso";
	const VIEW_BOLETO = "view_boleto";
	const VIEW_CAIXA = "view_caixa";
	const VIEW_CAIXA_FUNCIONARIO = "view_caixa_funcionario";
	const VIEW_CARGO = "view_cargo";
	const VIEW_CDU = "view_cdu";
	const VIEW_CHEQUE = "view_cheque";
	const VIEW_COLUMN_USAGE = "view_column_usage";
	const VIEW_CONTA_FINANCEIRA = "view_conta_financeira";
	const VIEW_CONVENIO = "view_convenio";
	const VIEW_COTACAO = "view_cotacao";
	const VIEW_CURRICULO = "view_curriculo";
	const VIEW_CURSO = "view_curso";
	const VIEW_CURSO_DISCIPLINA = "view_curso_disciplina";
	const VIEW_DEMANDA = "view_demanda";
	const VIEW_DEPARTAMENTO = "view_departamento";
	const VIEW_DISCIPLINA = "view_disciplina";
	const VIEW_DISCIPLINA_SIMILAR = "view_disciplina_similar";
	const VIEW_FALTA = "view_falta";
	const VIEW_FCHAMENTO_CONTA_FINANCEIRA = "view_fchamento_conta_financeira";
	const VIEW_FECHAMENTO_CAIXA = "view_fechamento_caixa";
	const VIEW_FUNCIONARIO = "view_funcionario";
	const VIEW_FUNCIONARIO_OCORRENCIA = "view_funcionario_ocorrencia";
	const VIEW_FUNCIONARIO_TREINAMENTO = "view_funcionario_treinamento";
	const VIEW_INSCRICAO = "view_inscricao";
	const VIEW_LIVRO = "view_livro";
	const VIEW_PARCELA = "view_parcela";
	const VIEW_PATRIMONIO = "view_patrimonio";
	const VIEW_PESSOA = "view_pessoa";
	const VIEW_PESSOA_CONVENIO = "view_pessoa_convenio";
	const VIEW_PESSOA_FISICA = "view_pessoa_fisica";
	const VIEW_PESSOA_JURIDICA = "view_pessoa_juridica";
	const VIEW_PESSOA_TITULARIDADE = "view_pessoa_titularidade";
	const VIEW_PESSOAS_LIVROS = "view_pessoas_livros";
	const VIEW_PLANO_CONTA = "view_plano_conta";
	const VIEW_PRODUTO = "view_produto";
	const VIEW_PRODUTO_TURMA = "view_produto_turma";
	const VIEW_PROFESSOR = "view_professor";
	const VIEW_PROFESSOR_AREA = "view_professor_area";
	const VIEW_PROJETO_CURSO = "view_projeto_curso";
	const VIEW_PROJETO_CURSO_DISCIPLINA = "view_projeto_curso_disciplina";
	const VIEW_RECADO = "view_recado";
	const VIEW_REQUISITO_TURMA = "view_requisito_turma";
	const VIEW_ROUTINE_USAGE = "view_routine_usage";
	const VIEW_SALA = "view_sala";
	const VIEW_TABLE_USAGE = "view_table_usage";
	const VIEW_TIPO_CURSO = "view_tipo_curso";
	const VIEW_TRANSACAO = "view_transacao";
	const VIEW_TRANSACAO_CONVENIO = "view_transacao_convenio";
	const VIEW_TRANSACAO_PRODUTO = "view_transacao_produto";
	const VIEW_TREINAMENTO = "view_treinamento";
	const VIEW_TURMA = "view_turma";
	const VIEW_TURMA_CONVENIO = "view_turma_convenio";
	const VIEW_TURMA_CONVENIO_DESCONTO = "view_turma_convenio_desconto";
	const VIEW_TURMA_DISCIPLINA = "view_turma_disciplina";
	const VIEW_TURMA_DISCIPLINA_ARQUIVO = "view_turma_disciplina_arquivo";
	const VIEW_TURMA_DISCIPLINA_AULA = "view_turma_disciplina_aula";
	const VIEW_TURMA_DISCIPLINA_AVALIACAO = "view_turma_disciplina_avaliacao";
	const VIEW_TURMA_DISCIPLINA_MATERIAL = "view_turma_disciplina_material";
	const VIEW_TURMA_DISCIPLINA_PLANOAULA = "view_turma_disciplina_planoaula";
	const VIEW_UNIDADE = "view_unidade";
	const VIEW_USUARIO = "view_usuario";
	
	// Relatorios
	const RELATORIO_ALUNOS_NOTAS_FREQUENCIAS = "aluno_nota_frequencia";
	
	// Identificadores
	const SEQUENCIAL = "seq";
	const FORM = "formseq";
	const NOMEFORM = "form_";
	const LISTA = "listseq";
	const ENTIDADE = "entidade";
	const CONTEINER_LISTA = "contLista";
	const CONTEINER_PESQUISA = "contPesquisa";
	const LIST_OBJECT = "list_object";
	const LIST_REQUIRED = "lista_required";
	const LIST_COUNT = "listCount";
	const LIST_SELECAO = "listaSelecao";
	
	// informações do campo
	const FIELD_COLUMN = "colunadb";
	const FIELD_ID = "campo";
	const FIELD_TIPO = "tipodado";
	const FIELD_LABEL = "label";
	const FIELD_INCONTROL = "incontrol";
	const FIELD_TIPOFORM = "tipoform";
	const FIELD_NOTNULL = "required";
	const FIELD_VALOR = "valor";
	const FIELD_STATUS = "status";
	const FIELD_SEQUENCIAL = "campseq";
	
	// Constantes de nomes de sessão
	const TRANSACTION = "transacao";
	const DATA_FORM = "data_form";
	const CAMPOS_FORMULARIO = "camposFormulario";
	const STATUS_VIEWFORM = "statusViewForm";
	const STATUS_EDITIONFORM = "statusFormEdition";
	const STATUS_FORM = "status";
	const FORMULARIOPAI = "frmpseq";
	
	// dados do Head
	const HEAD_SEQUENCIALPAI = 'seqPai'; // Sequêncial do head pai
	const HEAD_COLUNAFK = 'colunafilho'; // coluna que é transposta nos filhos do relacionamento
	const HEAD_TITULO = 'titulo'; // titulo do formulário
	const HEAD_FORMPAI = 'frmpseq'; // id do formulário (pai se ouver)
	const HEAD_FORMAINCLUSAO = 'formainclude'; // define a forma de inclusão da lista
	const HEAD_IDENTIFICADORLISTA = 'listseqLabel';
	const HEAD_TITULOLISTA = 'tituloLista';
	const HEAD_TIPOFORM = 'tipo';
	const HEAD_LISTAPAI = 'listapai';
	const HEAD_DESTINOSEQ = 'destinoseq';
	const HEAD_SEQPAI = 'seqPai';
	const HEAD_NOTNULLS = 'camposObrigatorios';
	const HEAD_OUTCONTROL = 'formOutControl';
	const HEAD_HEADCHILDS = 'headChilds'; // armazena um vetor com as chaves dos filhos do mesmo
	const HEAD_CONTEINERRETORNO = 'conteinerRetorno';
	const HEAD_NIVEL = 'nivel';
	
	// Conteiner de tela
	const VIEW_DISPLAYSYS = 'displaySys';
	
	// Constantes de controle de exceção
	const ERRO_0 = 'erro#0'; //
	const ERRO_OBRIGATORIEDADE = 'erro#2'; // Levanta exec�ão de obrigatoriedade de campo
	const ERRO_OBRIGATORIEDADELISTA = 'erro#3'; // Levanta a execção de obrigatóriedade da lista
	const ERRO_VALIDACAO = 'erro#4'; // Levanta exce�ão de valida�ão de valores
	const ERRO_BANCODADOS = 'erro#5'; // Levanta exce�ão de valida�ão de banco de dados
	                                      
	// Documentos pagar/receber
	const BAIXA_PARCELA = 'baixar';
	const EXTORNA_PARCELA = 'extornar';
	const CANCELA_PARCELA = 'cancelar';
}