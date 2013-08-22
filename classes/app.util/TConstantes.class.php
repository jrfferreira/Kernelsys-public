<?php
/**
 * Classe TConstantes
 *
 * author Joao Felix
 */
class TConstantes{
	

    //Nomes das tabelas dbpetrus com intuito validstatseq e repositório.
    const DBPESSOA                          = "dbpessoa";
    const DBPLANO_CONTA                    = "dbplano_conta";
    const DBCAIXA                           = "dbcaixa";
    const DBCAIXA_FUNCIONARIO              = "dbcaixa_funcionario";
    const DBALUNOS_TRANSACOES               = "dbaluno_transacao";
    const DBALUNO_REQUISITO               = "dbaluno_requisito";
    const DBTURMA_REQUISITO               = "dbrequisito_turma";
    const DBCONTA_FINANCEIRA                    = "dbconta_financeira";
    const DBCONTA_FINANCEIRA_HISTORICO          = "dbconta_financeira_historico";
    const DBFALTA                   		= "dbfalta";
    const DBUSUARIO                        = "dbusuario";
    const DBCARGOS                          = "dbcargo";
    const DBCURRICULOS                      = "dbcurriculo";
    const DBPATRIMONIOS                     = "dbpatrimonio";
    const DBTREINAMENTOS                    = "dbtreinamento";
    const DBFUNCIONARIOS_TREINAMENTOS       = "dbfuncionario_treinamento";
    const DBUNIDADE							= "dbunidade";
    const DBINSUMOS                         = "dbinsumo";
    const DBCOTACOES                        = "dbcotacao";
    const DBCONTRATOS                       = "dbcontrato";
    const DBUSUARIO_PRIVILEGIO              = "dbusuario_privilegio";
    const DBFUNCIONARIOS_FERIAS             = "dbfuncionario_feria";
    const DBCHEQUES                         = "dbcheque";
    const DBSALA                           = "dbsala";
    const DBCURSO_AREAS                    = "dbarea_curso";
    const DBSOLICITACOES                    = "dbaluno_solicitacao";
    const DBCOMPRAS                         = "dbcompra";
    const DBUNIDADE_PARAMETRO             = "dbunidade_parametro";
    const DBCAIXA_FECHAMENTOS               = "dbfechamento_caixa";
    const DBFUNCIONARIOS_FOLHAPAGAMENTO     = "dbfuncionario_folhapagamento";
    const DBUSUARIO_HISTORICO              = "dbusuario_historico";
    const DBPRODUTO                        = "dbproduto";
    const DBTRANSACAO_PRODUTO             = "dbtransacao_produto";
    const DBTRANSACAO                      = "dbtransacao";
    const DBPARCELA							= "dbparcela";
    const DBBOLETO							= "dbboleto";
    const DBCURSO_TIPOS                    = "dbtipo_curso";
    const DBUSUARIO_ERROS                  = "dbusuario_erro";
    const DBUSUARIO_SENHAS_RECUPERACAO     = "dbusuario_senha_recuperacao";
    const DBDEPARTAMENTOS                   = "dbdepartamento";
    const DBDOCUMENTOPAGARRECEBER           = "dbdocumentopagarreceber";
    const DBDOCUMENTOPARCELA				= "dbdocumentoparcela";
    const DBMOVIMENTOCAIXA					= "dbmovimentocaixa";
    const DBDOCUMENTOS                      = "dbdocumento";
    const DBTURMA_DESCONTOS					= "dbturma_desconto";
    const DBCURSO_AVALIACOES				= "dbcurso_avaliacao";
    const DBTURMA_CONVENIO					= "dbturma_convenio";
    const DBTRANSACAO_CONVENIO				= "dbtransacao_convenio";
    const DBAVALIACAO                       = "dbavaliacao";
    const DBNOTA                            = "dbnota";
    const DBLIVRO							= "dblivro";
    const DBLOCACAO_LIVRO                   = "dblocacao_livro";
    const DBPROFESSOR						= "dbprofessor";
    const DBFUNCIONARIO						= "dbfuncionario";
    const DBALUNO							= "dbaluno";
    const DBSITUACAO_MOVIMENTO				= "dbsituacao_movimento";
    const DBTURMA_DISCIPLINA				= "dbturma_disciplina";
    const DBTURMA							= "dbturma";
    const DBCURSO							= "dbcurso";
    const DBDISCIPLINA						= "dbdisciplina";
    const DBINSCRICAO						= "dbinscricao";
   
   
     //Visualizações
    const VIEW_UNIDADES                     = "view_unidade";
    const VIEW_ALUNO_SOLICITACAO			= "view_aluno_solicitacao";
    const VIEW_CONTA_FINANCEIRA_HISTORICO	= "view_conta_financeira_historico";
    const VIEW_TURMA_DISCIPLINA				= "view_turma_disciplina";
    const VIEW_CAIXA                        = "view_caixa";
    const VIEW_TURMAS                       = "view_turma";
    const VIEW_PESSOAS_DEMANDAS             = "view_demanda";
    const VIEW_PESSOAS_FUNCIONARIOS         = "view_funcionario";
    const VIEW_PESSOAS_FORMACOES            = "view_pessoa_titularidade";
    const VIEW_PRODUTOS_TURMAS              = "view_produto_turma";
    const VIEW_TRANSACOES                   = "view_transacao";
    const VIEW_PARCELA						= "view_parcela";
    const VIEW_TRANSACAO_PRODUTO			= "view_transacao_produto";
    const VIEW_ALUNO_DISCIPLINA             = "view_aluno_disciplina";
    const VIEW_NOTA			                = "view_nota";
    const VIEW_ALUNO               			= "view_aluno";
    const VIEW_LOCACAO_LIVRO                = "view_locacao_livro";
    const VIEW_LIVRO						= "view_livro";
    const VIEW_PROFESSOR					= "view_professor";
    const VIEW_CAIXA_FUNCIONARIO			= "view_caixa_funcionario";
    const VIEW_CURSO_DISCIPLINA				= "view_curso_disciplina";
    const VIEW_INSCRICAO					= "view_inscricao";	
    
    //Relatorios
    const RELATORIO_ALUNOS_NOTAS_FREQUENCIAS = "aluno_nota_frequencia";
    
    //Identificadores
    const SEQUENCIAL						= "seq";
    const FORM								= "formseq";
    const NOMEFORM							= "form_";
    const LISTA								= "listseq";
    const ENTIDADE							= "entidade";
    const CONTEINER_LISTA					= "contLista";
    const CONTEINER_PESQUISA				= "contPesquisa";
    const LIST_OBJECT						= "list_object";
    const LIST_REQUIRED						= "lista_required";
    const LIST_COUNT						= "listCount";
    const LIST_SELECAO						= "listaSelecao";
    
    //informações do campo
    const FIELD_COLUMN						= "colunadb";
    const FIELD_ID							= "campo";
    const FIELD_TIPO						= "tipodado";
    const FIELD_LABEL						= "label";
    const FIELD_INCONTROL					= "incontrol";
    const FIELD_TIPOFORM					= "tipoform";
    const FIELD_NOTNULL						= "obrigatorio";
    const FIELD_VALOR						= "valor";
    const FIELD_STATUS						= "status";
    const FIELD_SEQUENCIAL					= "campseq";
    
    
    //Constantes de nomes de sessão
    const TRANSACTION			= "transacao";
    const DATA_FORM				= "data_form";
    const CAMPOS_FORMULARIO     = "camposFormulario";
    const STATUS_VIEWFORM		= "statusViewForm";
    const STATUS_EDITIONFORM	= "statusFormEdition";
    const STATUS_FORM			= "status";
    const FORMULARIOPAI			= "frmpseq";   
    
    
    //dados do Head
    const HEAD_SEQUENCIALPAI		= 'seqPai'; // Sequêncial do head pai
    const HEAD_COLUNAFK				= 'colunafilho'; //coluna que é transposta nos filhos do relacionamento
    const HEAD_TITULO 				= 'titulo';//titulo do formulário
    const HEAD_FORMPAI 				= 'frmpseq';//id do formulário (pai se ouver)
    const HEAD_FORMAINCLUSAO 		= 'formainclude';//define a forma de inclusão da lista
    const HEAD_IDENTIFICADORLISTA 	= 'listseqLabel';
    const HEAD_TITULOLISTA 			= 'tituloLista';
    const HEAD_TIPOFORM 			= 'tipo';
    const HEAD_LISTAPAI 			= 'listapai';
    const HEAD_DESTINOSEQ 			= 'destinoseq';
    const HEAD_SEQPAI 				= 'seqPai';
    const HEAD_NOTNULLS 			= 'camposObrigatorios';
    const HEAD_OUTCONTROL 			= 'formOutControl';
    const HEAD_HEADCHILDS 			= 'headChilds'; //armazena um vetor com as chaves dos filhos do mesmo
    const HEAD_CONTEINERRETORNO		= 'conteinerRetorno';
    const HEAD_NIVEL				= 'nivel';
    
    //Conteiner de tela
    const VIEW_DISPLAYSYS 			= 'displaySys';
    
	//Constantes de controle de exceção
	const ERRO_0							= 'erro#0'; //
	const ERRO_OBRIGATORIEDADE 				= 'erro#2'; //Levanta exec�ão de obrigatoriedade de campo
	const ERRO_OBRIGATORIEDADELISTA			= 'erro#3'; // Levanta a execção de obrigatóriedade da lista
    const ERRO_VALIDACAO					= 'erro#4'; //Levanta exce�ão de valida�ão de valores
    const ERRO_BANCODADOS					= 'erro#5'; //Levanta exce�ão de valida�ão de banco de dados
    
    
    //Documentos pagar/receber
    const BAIXA_PARCELA			= 'baixar';
    const EXTORNA_PARCELA		= 'extornar';
    const CANCELA_PARCELA		= 'cancelar';
    
    

     
}