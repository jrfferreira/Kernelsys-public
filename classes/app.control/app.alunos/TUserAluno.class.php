<?php 

/**
 * Classe  TUserAluno()
 * Gera conta de usuario a partir do cadastro como cliente.
 * Autor : Jo�o Felix
 */
class TUserAluno {
/**
 * método setParam()
 * Configura o atributo vindo do objeto pai(registro responsavel pela visualização do ap�ndice)
 * Autor : Wagner Borba
 * param Codigo = recebe codigo do objeto pai
 */
    public function setParam($param) {
        $this->param = $param;

    }

    /**
     * método get()
     *===========================================================
     * Autor: Jo�o Felix
     */
    public function get() {

    	//Retorna Usuario logado===================================
        $obUser = new TCheckLogin();
        //=========================================================

        //Importação dos dados do Cliente
//        $sqlAluno = new TDbo(TConstantes::DBALUNO);
//        $critAluno = new TCriteria();
//        $critAluno->add(new TFilter("codigo", "=", $this->param));
//        $AlunoQuery = $sqlAluno->select("*",$critAluno);
//
//        $obAluno = $AlunoQuery->fetchObject();

        //Importação dos dados do Cliente
        $sqlCliente = new TDbo(TConstantes::DBPESSOAS);
        $critCliente = new TCriteria();
        $critCliente->add(new TFilter("codigo", "=", $this->param));
        $ClienteQuery = $sqlCliente->select("codigo,unidade,nome_razaosocial,email1",$critCliente);

        $obCliente = $ClienteQuery->fetchObject();

        //gera senha
        $geraSenha = new TSetControl();
        $senha = $geraSenha->SetPass($obCliente->codigo);

        //configura argumentos
        if($obCliente->email1) {

            $argsC["codigopessoa"] = $obCliente->codigo;
            $argsC["classeuser"] = "a";
            $argsC["usuario"] = $obCliente->email1;
            $argsC["entidadePai"] = '1';
            $argsC["senha"] = $senha;

            if($obCliente->email1) {
            	
            //atualiza exportação para a tabela 'dbusuarios'
                $sqlInsert_usuario = new TDbo(TConstantes::DBUSUARIOS);
                $QueryInsert_usuario = $sqlInsert_usuario->insert($argsC);

                //Valida Exportação
                if($QueryInsert_usuario['codigo']) {
                    echo '<div id="retConta" style="margin:3px; padding:8px; border:1px solid #0066FF; text-align:center; font-family:Verdana; font-size:12px;" >Usuario '.$obCliente->email1.' gerado com sucesso.</div>';

                }
                
             //lista de privilegios padrões para alunos.   
             $priv = array("26","23","24","28","27","25","86");
             
                foreach ($priv as $vl) {

                    $insertVet['codigousuario'] = $QueryInsert_usuario['codigo'];

                    $insertVet['nivel'] = "10";
                    $insertVet['modulo'] = $vl;

                    $insercao_privilegios = new TDbo(TConstantes::DBUSUARIOS_PRIVILEGIOS);
                    $insercao_privilegios = $insercao_privilegios->insert($insertVet);

                    unset($insertVet);
                }
                $insertVet['codigousuario'] = $QueryInsert_usuario['codigo'];

                    $insertVet['nivel'] = 0;
                    $insertVet['modulo'] = 10;

                    $insercao_privilegios = new TDbo(TConstantes::DBUSUARIOS_PRIVILEGIOS);
                    $insercao_privilegios = $insercao_privilegios->insert($insertVet);

                //Valida Exportação
                if($insercao_privilegios) {
                    echo '<div id="retConta" style="margin:3px; padding:8px; border:1px solid #0066FF; text-align:center; font-family:Verdana; font-size:12px;" >Privilegios adicionados com sucesso ao usuario '.$obCliente->email1.'.</div>';

                    //Gera mensagem a ser enviada por email
                    $mensagem = "Seu cadastro foi efetivado no sistema.<BR />Um login e senha foram gerados automaticamente para seu acesso:<BR /><BR />Login: ".$obCliente->email1."<BR />Senha: ".$obCliente->codigo;
                    
                    //Envia E-mail
                    $email = new TEmail();
                    if($email->enviar($obCliente->email1,"Efetivação de cadastro",$mensagem)){
                        echo '<div id="retConta" style="margin:3px; padding:8px; border:1px solid #0066FF; text-align:center; font-family:Verdana; font-size:12px;" >E-mail enviado com sucesso ao usuario '.$obCliente->email1.'.</div>';
                    }

                }
            //}
            //}
            }else {
                echo '<div id="retConta" style="margin:3px; padding:8px; border:1px solid #0066FF; text-align:center; font-family:Verdana; font-size:12px;" >O usuario não pode ser gerado.</div>';

            }

        }
    }
}