<?php

function __autoload($classe) {
    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}

/**
 * Classe TSetlogin
 * configura os campos do formulario em tabelas
 * Autor: Wagne Borba
 * 07/04/2008
 */

class TSetlogin {

    private $dbase = NULL;
    private $usuario = NULL;
    private $senha   = NULL;
    private $conn    = NULL;

    public function __construct($dados) {
       

        // zera possivel tentativas de acesso via get
        $_GET = NULL;
        $_GET = array();

        $this->obsession = new TSession();

        $dados['usuario'] = trim($dados['usuario']);
        $dados['senha']   = trim($dados['senha']);

        if($dados['usuario'] == '' or $dados['senha'] == '') {
            $this->retorno = "erro1";
        }
        else {

            // filtra usuario
            $this->usuario = str_replace("'","bxd",$dados['usuario']);
            $this->usuario = str_replace("=","bxd",$this->usuario);
            $this->usuario = str_replace("/","bxd",$this->usuario);
            $this->usuario = str_replace(",","bxd",$this->usuario);
            $this->usuario = str_replace("(","bxd",$this->usuario);
            $this->usuario = addslashes($this->usuario);

            //filtra senha
            $this->senha = str_replace("'","bxd",$dados['senha']);
            $this->senha = str_replace("=","bxd",$this->senha);
            $this->senha = str_replace("/","bxd",$this->senha);
            $this->senha = str_replace(",","bxd",$this->senha);
            $this->senha = str_replace("(","bxd",$this->senha);
            $this->senha = addslashes($this->senha);


            $setControl = new TSetControl();
            $this->senha = $setControl->setPass($this->senha);
            $this->obsession->setValue("occupant", $dados['occupant']);
            if ($dados['occupant'] != null) $ch = 'occupant/'.$dados['occupant'].'/';
            $this->obsession->setValue("pathDB", '../'.$ch.'app.config/my_dbpetrus');

            $criteriaUs = new TCriteria();
            $criteriaUs->add(new TFilter("usuario","=",$this->usuario));
            $criteriaUs->add(new TFilter("senha","=",$this->senha));
            $criteriaUs->add(new TFilter("ativo","=","1"));
            $sql = new TDbo(TConstantes::DBUSUARIOS, 'bitup');
            $qrUs = $sql->select("codigo,classeuser,codigopessoa,unidade,codigotema", $criteriaUs);
            $retUser = $qrUs->fetchObject();

            if($retUser->codigo) {
                    //reconhece unidade de acesso do usuario
                    $sqlUnid = new TDbo(TConstantes::DBUNIDADES, 'bitup');
                    $criteriaUnid = new TCriteria();
                    $criteriaUnid->add(new TFilter("codigo","=",$retUser->unidade));
                    $queryUnid = $sqlUnid->select("*", $criteriaUnid);
                    $obUnidade = $queryUnid->fetchObject();

                        //redireciona para pagina de manutenção quando status ativo for = 2
                        if($obUnidade->ativo == "2") {
                            header('Location: '.$this->dataset['pathSystem'].'/app.util/TRedirection.class.php?cod=002');
                            exit();
                        }
                        //=====================================

                        //valida Unidade do usuario
                        if(!$obUnidade->codigo) {
                            $this->obsession->freeSession();
                            $this->retorno = "erro4";
                        }
                    //inicia aquivo de configuração com a camada de dados
                    $this->dataset = parse_ini_file('../'.TOccupant::getPath().'app.config/dataset.ini');

                    $obUser =  new stdClass();
                    $obUser->codigo         = $retUser->codigo;
                    $obUser->codigopessoa   = $retUser->codigopessoa;
                    $obUser->codigouser     = $retUser->codigo;
                    $obUser->classeuser     = $retUser->classeuser;
                    $obUser->unidade        = $obUnidade;
                    $obUser->datalog        = date(d."/".m."/".Y);
                    $obUser->horalog        = date(H.":".i.":".s);
                    $obUser->codigotema     = $retUser->codigotema;
                    $obUser->server_addr     = $_SERVER['SERVER_ADDR'];
                    $obUser->remote_addr     = $_SERVER['REMOTE_ADDR'];

                    // Valida se e versao de desenvolvimento
                    $developer = (preg_match('/(dev|test)/i',$this->dataset['versionSystem'])) ? true : false;
                    $this->obsession->setValue('developer',$developer);

                    $this->obsession->setValue('pathSystem',$this->dataset['pathSystem']);

                    //configura nome da sessão
                    $idSessao = $setControl->getSessionPass('portaCopo');
                    
                    //armazena usuario em sessão
                    $this->obsession->setValue($idSessao, $obUser);
                    
                    //armazena codigo mestre
                    $this->obsession->setValue('codigoMestra',$obUser->codigouser);
                    
                    //Armazena informações da camada de dados
                    foreach($this->dataset as $ch=>$val) {
                        $this->obsession->setValue($ch, $val);
                    }
                    $date = getdate();

                    //Atualiza login do usuário
                    $sqlUserUp = new TDbo(TConstantes::DBUSUARIOS,'bitup');
	                    $critUpUser = new TCriteria();
	                    $critUpUser->add(new TFilter('codigo','=',$retUser->codigo));
                    $updateUser = $sqlUserUp->update(array('lastip'=>$obUser->remote_addr, 'lastaccess'=>$date[0]),$critUpUser);
                    //==========================================================
                    //Carrega informações da PESSOA
                    if($retUser->codigopessoa) {

                        $pessoa = new TPessoa();
                        $obPessoa = $pessoa->getPessoa($retUser->codigopessoa);

                        $obUser->nome = $obPessoa->nome_razaosocial;
                        $obUser->cpf  = $obPessoa->cpf_cnpj;

                        //associa especialidades da pessoa
                        if($obPessoa->funcionario){
                            $obFuncionario = $obPessoa->funcionario;
                            $obUser->codigofuncionario = $obFuncionario->codigo;
                        }
                        if($obPessoa->aluno){
                            $obAluno = $obPessoa->aluno;
                            $obUser->codigoaluno = $obAluno->codigo;
                        }
                        if($obPessoa->professor){
                            $obProfessor = $obPessoa->professor;
                            $obUser->codigoprofessor = $obProfessor->codigo;
                        }
                        //atualiza sessão do usuario com informações da pessoa
                        $this->obsession->setValue($idSessao, $obUser);
                        
                        
                    }else {
                        TTransaction::close();
                        if($this->retorno == "") {
                            $this->retorno = "erro2";
                        }
                    }
                    //==========================================================

                    //Gerencia opção de visualização da janela
                    //1 opção - FullScree
                    if($dados['opOpen'] == "fullscree") {
                        echo "<script>
                                function openBrWindow(){
                                        var sX = (screen.width)-1;
                                        var sY = (screen.height)-1;
                                        window.open('".$this->dataset['pathSystem']."/app.view/TInterface.class.php','sistemPetrus','channelmode, scrollbars=yes, fullscreen=yes,resizable=no');
                                }
                                eval('openBrWindow();');
                                </script>";
                    }
                    elseif($dados['opOpen'] == "maximizado") {
                        echo "<script>
                                function openBrWindow(){
                                        var sX = (screen.width)-1;
                                        var sY = (screen.height)-1;
                                        window.open('".$this->dataset['pathSystem']."/app.view/TInterface.class.php','sistemPetrus','channelmode,scrollbars=yes,resizable=yes');
                                }
                                eval('openBrWindow();');
                                </script>";

                    }
                    elseif($dados['opOpen'] == "self") {                    	
                        header('Location: '.$this->dataset['pathSystem'].'/app.view/TInterface.class.php');
                    }
                    $this->retorno = "logado";

            }else {
                TTransaction::close();
                if($this->retorno == "") {
                    $this->retorno = "erro3";
                }
            }
            //}
        }//fim validação de campos vazios
        
        TTransaction::close();
}

    public function getRetorno() {
        return $this->retorno;
    }

}