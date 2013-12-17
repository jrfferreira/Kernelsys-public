<?php

session_start();

function __autoload($classe) {

    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}
//Retorna Usuario logado===================================

     $obUser = new TCheckLogin();
     $obUser = $obUser->getUser();
//=========================================================	
     
$dbo = new TDbo(TConstantes::VIEW_ALUNO);
$crit = new TCriteria();
$crit->add(new TFilter('seqpessoa','not in','(select seqpessoa from dbusuario)'));
$ret = $dbo->select('nomepessoa,seq,seqpessoa',$crit);

while($aluno = $ret->fetchObject()){

                    //Gera usuario e privilegios do aluno.
                    $TUsuario = new TUsuario();
                    $provSenha = substr($aluno->seqpessoa, 0,-4);
                    $retUsuario = $TUsuario->setUsuario($aluno->seqpessoa, $aluno->seq, $provSenha);

                    if($retUsuario){
                            $priv = array();

                            $priv[] = array("0 ","10 ","0");
                            $priv[] = array("10 ","25 ","1");
                            $priv[] = array("10 ","26 ","1");
                            $priv[] = array("10 ","27 ","1");
                            $priv[] = array("76 ","1 ","2");
                            $priv[] = array("76 ","2 ","2");
                            $priv[] = array("222 ","459 ","3");
                            $priv[] = array("222 ","460 ","3");
                            $priv[] = array("222 ","461 ","3");
                            $priv[] = array("222 ","462 ","3");
                            $priv[] = array("76 ","230 ","5");
                            $priv[] = array("230 ","158 ","6");
                            $priv[] = array("158 ","682 ","7");
                            $priv[] = array("682 ","682 ","8");
                            $priv[] = array("158 ","683 ","7");
                            $priv[] = array("683 ","683 ","8");
                            $priv[] = array("158 ","684 ","7");
                            $priv[] = array("684 ","684 ","8");
                            $priv[] = array("158 ","685 ","7");
                            $priv[] = array("685 ","685 ","8");
                            $priv[] = array("158 ","686 ","7");
                            $priv[] = array("686 ","686 ","8");
                            $priv[] = array("10 ","86 ","1");
                            $priv[] = array("10 ","92 ","1");
                            $priv[] = array("331 ","717 ","3");

                            foreach($priv as $vl){
                                $TUsuario->setPrivilegio($retUsuario["seq"], $vl[2], $vl[0],$vl[1],'1');
                            }

                        echo '<p><b>Aluno: '.$aluno->nomepessoa.'</b><br/> Usuario '.$aluno->seq.' gerado com sucesso.<br/> Senha provisória: '.$provSenha.'</p>';
                    }
}

?>