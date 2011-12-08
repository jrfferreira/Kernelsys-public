<?php
//===============================================
//
//
//===============================================

function __autoload($classe){

    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}

class TActionIn{

    public function __construct($action){

        $this->obsession = new TSession();
        $pathDB = $this->obsession->getValue('pathDB');

        //TTransaction::open(constant('OCCUPANT').$pathDB);

        //if($conn = TTransaction::get()){
            //configura nome da sessão
            $setcodigo = new TSetControl();
            $idSessao = $setcodigo->setPass($setcodigo->getSessionPass('portaCopo'));
            //armazena usuario em sessão
            $obUser = $this->obsession->getValue($idSessao);

            //dados
            $data = date(d."/".m."/".Y);
            $hora = date(H.":".i.":".s);
            
            
            $dados['codigo'] = $obUser->id;
            $dados['dataAc'] = $data;
            $dados['horaAc'] = $hora;
            $dados['acao'] = $action;


            $sqlIn = new TDbo(TConstantes::DBUSER_HISTORICO);
            $exeSql = $sqlIn->insert($dados);

        }

    //}
}

// instancia e executa objeto
$action = $_GET['act'];
$atctionIn = new TActionIn($action);
?>
