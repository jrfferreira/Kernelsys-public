<?php
/* 
//======================= MENSAGENS DO SISTEMA ===========================\\
*/

class TMensagem{

     ///////////////////////////////////////////////////////////////////////////
     //Mensagem em geral

     const MSG_CONF_PADRAO              = "Você deseja realmente executar esta ação?";
     const MSG_CONF_ANUNAR_MATRICULA    = "Você deseja realmente ANULAR esta matricula e envia-la para a lista de demanda?";
     
     //Inscriçãoes
     const MSG_CONF_INSCRICAO           = "A inscrição foi concluída com sucesso.";

     //Mensagem de sucesso
     const SUC_MATRICULA                = "Matrícula confirmada com sucesso";

     ///////////////////////////////////////////////////////////////////////////
     //Mensagens ERRO GERAL do sistema

     const ERRO_GERAL                   = "Ouve um erro no sitema, por favor entre em contato com o suporte.";
     const ERRO_GRAVAR                  = "O sistema não pode gavar a informação na base de dados.";
     const ERRO_VALOR_DUPLICADO         = "O valor já existe na base de dados e não pode ser duplicado.";
     const ERRO_VALOR_INVALIDO          = "O valor fornecido é inválido.";
     const ERRO_VALOR_NULL              = "O campo <campo> deve ser preenchido.";
     const ERRO_SEM_REGISTRO            = "registro não encontrado.";

    //Mensagem ERRO DE ACESSO ao sistema
    const ERRO_ACESSO_PRIVILEGIOS       = "Problema ao tentar carregar o perfil do usuario.";
    const ERRO_PRIVILEGIOS              = 'Usuario sem privilégios definidos.';

    //Mensagens ERRO referentes ao academico
     const ERRO_TURMA_DISCIPLINA        = "não há disciplinas associadas a turma.";
     const ERRO_GERAL_MATRICULA         = "A matrícula do aluno não pode ser efetivada.";
     const ERRO_REQUISITOS_CURSO        = 'Erro ao gravar o requisto do curso';

     //Mensagem gerais do Caixa
     const MSG_CONTA_BAIXADA            = "A conta já foi baixada";
     const MSG_SUCESSO_FECHA_CAIXA      = "O caixa foi fechado com sucesso.";
     const ERRO_FECHAR_CAIXA            = "Ouve um problema ao fechar o caixa - Entre em contato com o administrador.";

     //Mensagem gerais do Sistema de Email
     const ERRO_MAIL_ACESSO             = "Falha ao acessar o servidor de e-mail.";

     //Mensagem Transferencia de aquivos
     const ERRO_ARQUIVO_NULL            = "Nenhum arquivo foi selecionado, por favor selecione um aquivo válido.";
     const ERRO_MOVER_ARQUIVO           = "Impossível mover o arquivo, verifique o caminho(path) de destino.";

     //Mensagem de ERRO referente a conexão com o banco
     const ERRO_GERAL_CONEXAO           = "Ouve um erro ao tentar se conectar com a base de dados. Entre em contato com o suporte.";

     const ERRO_GERAL_SISTEMA           = "Erro geral do sistema";

     //Codigos dos alerta
     const ERRO_VALIDACAO               = "Erro de Validação";
     const ERRO_DUPLICACAO              = "Duplicação de dados";
     const ERRO_ACESSO_SISTEMA          = "Erro ao acessar o sitema";
     const ERRO_TRANSACAO_INATIVA       = "Não há transação ativa";
     const ERRO_TRANSACAO_CONTAS        = "Não é possivel adicionar mais parcelas a esta transação.";
     const ERRO_ENTIDADE_NULA           = "A entidade não foi definida";

     //Mensagens do financeiro
     const ERRO_CODIGO_TRANSACAO_FINAN  =  "Não foi possivel retornar a transação com o código fornecido.";


     //Erro do banco
     const ERRO_RESTRICAO_DELETE        = "Desculpe!<br> Este registro não pode ser excluido porque está sendo utilizando pelo sistema.";
     const ERRO_TIPODADOS_PESQUISA      = "Desculpe!<br> A pesquisa não pode ser executada pois exitem campos não compativeis com o valor fornecido. Defina a coluna para a pesquisa e tente novamente por favor.";

     //Inscrição de alunos
     const ERRO_CODIGO_INSCRICAO        = "O codigo da inscrição não é válido";
     
     //TDados
     const ERRO_VINCULO_TABELA_NAO_ENCONTRADO = "Não foi encontrado nenhum vínculo de tabela para este formulário.";

}
?>
