<?php
/**
 *
 */

function __autoload($classe) {
    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}
//Retorna Usuario logado===================================
$obUser = new TCheckLogin();
$obUser = $obUser->getUser();
$unidade = $obUser->unidade->codigo;
//=========================================================

$getDados = NULL;
$getDados = $_POST;

$idForm        = $getDados['idForm'];
$valor         = $getDados['valor'];
$campo         = $getDados['campo'];

    //retorna o cabeçalho do formulário
    $obHeaderForm = new TSetHeader();
    $headerForm = $obHeaderForm->getHead($idForm);

    $camposSession = $headerForm['camposSession'];
    if($camposSession){
        $campoAtual = $camposSession[$campo];
        $campoAtual['valor']  = $valor;
        $campoAtual['status'] = 0;

        //atualiza a auteração na sessão
        $camposSession[$campo] = $campoAtual;
        $obHeaderForm->addHeader($idForm, 'camposSession',  $camposSession);
    }

//    $codigoPai = $headerForm['codigoPai'];
//    // recupera campo de destino do codigo armazenado em sessão
//    $destinoCodigo = $headerForm['destinocodigo'];//"codigo";
//
////Instancia manipulador de sessão
//$obsession 	   = new TSession();
//$statusEdition = $obsession->getValue('statusFormEdition');
//
//
//    //monta lista de campos abrigatorios
//    if($headerForm['camposObrigatorios'] and $valor){
//
//        $listaCamposObrigatorios = $headerForm['camposObrigatorios'];
//        $listaCamposObrigatorios[$campo] = $valor;
//        $obHeaderForm->addHeader($idForm, 'camposObrigatorios', $listaCamposObrigatorios);
//    }
//   //**************************************************************************
//
//
//
////Objeto TDbo ==================================================================
//$obTDbo = new TDbo();
//
//    //verifica tipo de formulário
//    if($tipoForm == "form") {
//
//        // Checa a existencia do registro
//        $obTDbo->setEntidade($entidade);
//            $criterioValReg = new TCriteria();
//            $criterioValReg->add(new TFilter($colunafilho, '=',$codigo));
//            $Check = $obTDbo->select('codigo', $criterioValReg);
//        $resCheck = $Check->fetch();
//
//        if($resCheck['codigo']) {
//
//            $dados[$campo] = $valor;
//            $obTDbo->setEntidade($entidade);
//               $criteriaUpCampo = new TCriteria();
//               $criteriaUpCampo->add(new TFilter($colunafilho, '=', $codigo));
//            $Query = $obTDbo->update($dados, $criteriaUpCampo);
//        }
//        else {
//            //valores padrões
//            if($codigo){
//                $dados[$colunafilho]   = $codigo;
//            }
//            if($codigoPai){
//                $dados[$destinoCodigo]  = $codigoPai;
//            }
//            $dados['unidade']      = $unidade;
//            $dados['codigoautor']  = $obUser->codigo;
//            $dados['datacad']      = date("Y-m-d");
//            $dados['ativo']        = '1';
//            $dados[$campo] = $valor;
//
//                $obTDbo->setEntidade($entidade);
//                $Query = $obTDbo->insert($dados);
//
//                print_r($Query);
//        }
//
//    }
//    elseif($tipoForm == "lista") {
//
//        // Checa a existencia do registro
//        $obTDbo->setEntidade($entidade);
//            $criterioValReg = new TCriteria();
//            $criterioValReg->add(new TFilter('codigo', '=',$codigo));
//            $criterioValReg->add(new TFilter($destinoCodigo, '=', $codigoPai));
//        $Check = $obTDbo->select('codigo', $criterioValReg);
//        $resCheck = $Check->fetch();
//
//        if($resCheck['codigo']) {
//
//            $dados[$campo] = $valor;
//            $obTDbo->setEntidade($entidade);
//                $criteriaUpCampo = new TCriteria();
//                $criteriaUpCampo->add(new TFilter('codigo', '=', $codigo));
//                $criteriaUpCampo->add(new TFilter($destinoCodigo, '=', $codigoPai));
//            $Query = $obTDbo->update($dados, $criteriaUpCampo);
//
//        }
//        else {
//
//            //valores padrões
//            $dados['unidade']       = $unidade;
//            $dados['codigoautor']   = $obUser->codigo;
//            $dados[$destinoCodigo]  = $codigoPai;
//            $dados['datacad']       = date("Y-m-d");
//            $dados['ativo']         = '1';
//            $dados[$campo]          = $valor;
//
//                $obTDbo->setEntidade($entidade);
//                $Query = $obTDbo->insert($dados);
//
//             //add codigo ao cabeçalho
//             if($Query['codigo']){
//                $obHeaderForm->addHeader($idForm, "codigo", $Query['codigo']);
//             }
//        }
//    }
//
//    // close transação =========================================================
//    $obTDbo->close();
//
//    if($Query){
//       $retorno = true;
//    }else{
//       $retorno = false;
//       $codigoRetorno = '1';
//    }
//
//    if($retorno){
//    	echo $codigoRetorno.'#<span class="ui-icon ui-icon-circle-check" style="display: inline; padding-left:20px; font-size: 9px; padding-top: 3px; padding-bottom: 3px;">&nbsp;&nbsp;&nbsp;</span>';
//        //echo $codigoRetorno.'#gravado com sucesso';
//    }else{
//        echo $codigoRetorno.'#<span class="ui-icon ui-icon-circle-close" style="display: inline; padding-left:20px; font-size: 9px; padding-top: 3px; padding-bottom: 3px;">&nbsp;&nbsp;&nbsp;</span>';
//        //echo $codigoRetorno.'#ouve um problema ao tentar gravar a informação';
//    }

?>
