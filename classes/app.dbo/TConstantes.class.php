<?php
/**
 * Classe TConstantes
 *
 * author Joao Felix
 */
class TConstantes{
	

    //Nomes das tabelas dbpetrus com intuito validativo e reposit�rio.
    const DBPROCESSOS_ACADEMICOS            = "dbprocessos_academicos";
    const DBPESSOAS                         = "dbpessoas";
    const DBPESSOAS_ALUNOS                  = "dbpessoas_alunos";
    const DBPESSOAS_TITULARIDADES           = "dbpessoas_titularidades";
    const DBPESSOAS_COMPLEMENTO_PF          = "dbpessoas_complemento_pf";
    const DBPESSOAS_COMPLEMENTO_PJ          = "dbpessoas_complemento_pj";
    const DBPESSOAS_DEMANDA                 = "dbpessoas_demandas";
    const DBPESSOAS_ENDERECOSCOBRANCAS      = "dbpessoas_enderecoscobrancas";
    const DBPESSOAS_REFERENCIA              = "dbpessoas_referencias";
    const DBPESSOAS_FORMACOES               = "dbpessoas_formacoes";
    const DBPESSOAS_FUNCIONARIOS            = "dbpessoas_funcionarios";
    const DBPESSOAS_LIVROS                  = "dbpessoas_livros";
    const DBTURMAS_DISCIPLINAS_ARQUIVOS     = "dbturmas_disciplinas_arquivos";
    const DBPRODUTOS_PARAMETROS             = "dbprodutos_parametros";
    const DBSCORECARD                       = "dbscorecard";
    const DBSCORECARD_SENTENCAS             = "dbscorecard_sentencas";
    const DBDISCIPLINAS                     = "dbdisciplinas";
    const DBCURSOS                          = "dbcursos";
    const DBCURSOS_DISCIPLINAS              = "dbcursos_disciplinas";
    const DBTURMAS                          = "dbturmas";
    const DBTURMAS_DISCIPLINAS              = "dbturmas_disciplinas";
    const DBFUNCIONARIOS_PROFESSORES        = "dbfuncionarios_professores";
    const DBDADOS_BOLETO                    = "dbdados_boleto";
    const DBPLANO_CONTAS                    = "dbplano_contas";
    const DBCAIXA                           = "dbcaixa";
    const DBCAIXA_FUNCIONARIOS              = "dbcaixa_funcionarios";
    const DBALUNOS_TRANSACOES               = "dbalunos_transacoes";
    const DBALUNOS_REQUISITOS               = "dbalunos_requisitos";
    const DBTURMAS_REQUISITOS               = "dbturmas_requisitos";
    const DBCONTAS_CAIXA                    = "dbcontas_caixa";
    const DBCONTAS_CAIXA_HISTORICO          = "dbcontas_caixa_historico";
    const DBALUNOS_FALTAS                   = "dbalunos_faltas";
    const DBUSUARIOS                        = "dbusuario";
    const DBTURMAS_DISCIPLINAS_AVALIACOES   = "dbturmas_disciplinas_avaliacoes";
    const DBTURMAS_DISCIPLINAS_AULAS        = "dbturmas_disciplinas_aulas";
    const DBCARGOS                          = "dbcargos";
    const DBCURRICULOS                      = "dbcurriculos";
    const DBPATRIMONIOS                     = "dbpatrimonios";
    const DBTREINAMENTOS                    = "dbtreinamentos";
    const DBFUNCIONARIOS_TREINAMENTOS       = "dbfuncionarios_treinamentos";
    const DBUNIDADES                        = "dbunidade";
    const DBINSUMOS                         = "dbinsumos";
    const DBCOTACOES                        = "dbcotacoes";
    const DBCONTRATOS                       = "dbcontratos";
    const DBUSUARIO_PRIVILEGIO            = "dbusuario_privilegio";
    const DBFUNCIONARIOS_FERIAS             = "dbfuncionarios_ferias";
    const DBCHEQUES                         = "dbcheques";
    const DBSALAS                           = "dbsalas";
    const DBCURSOS_AREAS                    = "dbcursos_areas";
    const DBSOLICITACOES                    = "dbsolicitacoes";
    const DBCOMPRAS                         = "dbcompras";
    const DBUNIDADES_PARAMETROS             = "dbunidade_parametros";
    const DBTURMAS_DISCIPLINAS_MATERIAIS    = "dbturmas_disciplinas_materiais";
    const DBCAIXA_FECHAMENTOS               = "dbcaixa_fechamentos";
    const DBFUNCIONARIOS_FOLHAPAGAMENTO     = "dbfuncionarios_folhapagamento";
    const DBALUNOS_DISCIPLINAS              = "dbalunos_disciplinas";
    const DBALUNOS_DISCIPLINAS_APROVEITAMENTOS              = "dbalunos_disciplinas_aproveitamentos";
    const DBFUNCIONARIOS_OCORRENCIAS        = "dbfuncionarios_ocorrencias";
    const DBBALANCO_PATRIMONIAL             = "dbbalanco_patrimonial";
    const DBALUNOS_NOTAS                    = "dbalunos_notas";
    const DBTURMAS_DISCIPLINAS_PLANOAULAS   = "dbturmas_disciplinas_planoaulas";
    const DBUSUARIOS_HISTORICO              = "dbusuario_historico";
    const DBPRODUTOS                        = "dbprodutos";
    const DBTRANSACOES_PRODUTOS             = "dbtransacoes_produtos";
    const DBTRANSACOES                      = "dbtransacoes";
    const DBTRANSACOES_CONTAS               = "dbtransacoes_contas";
    const DBTRANSACOES_CONTAS_DUPLICATAS    = "dbtransacoes_contas_duplicatas";
    const DBCURSOS_TIPOS                    = "dbcursos_tipos";
    const DBUSUARIOS_ERROS                  = "dbusuario_erros";
    const DBUSUARIOS_SENHAS_RECUPERACAO     = "dbusuario_senhas_recuperacao";
    const DBDEPARTAMENTOS                   = "dbdepartamentos";
    const DBDOCUMENTOS                      = "dbdocumentos";
    const DBPESSOAS_INSCRICOES              = "dbpessoas_inscricoes";
    const DBPESSOAS_DEMANDAS                = "dbpessoas_demandas";
    const DBTURMAS_DESCONTOS                = "dbturmas_descontos";
    const DBCURSOS_AVALIACOES               = "dbcursos_avaliacoes";
    const DBTURMAS_CONVENIOS                = "dbturmas_convenios";
    const DBTRANSACOES_CONVENIOS		    = "dbtransacoes_convenios";

    //Relatorios
    const RELATORIO_ALUNOS_NOTAS_FREQUENCIAS= "relatorios.alunos_notas_frequencias";
   
     //Visualizações
    const VIEW_UNIDADES                     = "view_unidades";
    const VIEW_ALUNOS_SOLICITACOES          = "view_alunos_solicitacoes";
    const VIEW_CONTAS_CAIXA_HISTORICO       = "view_contas_caixa_historico";
    const VIEW_TURMAS_DISCIPLINAS           = "view_turmas_disciplinas";
    const VIEW_CAIXA                        = "view_caixa";
    const VIEW_TURMAS                       = "view_turmas";
    const VIEW_PESSOAS_DEMANDAS             = "view_pessoas_demandas";
    const VIEW_PESSOAS_FUNCIONARIOS         = "view_pessoas_funcionarios";
    const VIEW_PESSOAS_FORMACOES            = "view_pessoas_formacoes";
    const VIEW_PRODUTOS_TURMAS              = "view_produtos_turmas";
    const VIEW_TRANSACOES                   = "view_transacoes";
    const VIEW_TRANSACOES_CONTAS            = "view_transacoes_contas";
    const VIEW_TRANSACOES_PRODUTOS          = "view_transacoes_produtos";
    const VIEW_ALUNOS_DISCIPLINAS           = "view_alunos_disciplinas";
    const VIEW_ALUNOS_NOTAS			        = "view_alunos_notas";
    const VIEW_PESSOAS_ALUNOS               = "view_pessoas_alunos";
    const VIEW_PESSOAS_LIVROS               = "view_pessoas_livros";
    const VIEW_PATRIMONIOS_LIVROS           = "view_patrimonios_livros";
    const VIEW_FUNCIONARIOS_PROFESSORES     = "view_funcionarios_professores";

     
}