<?php


//classe de conex�o
include_once("../app.dbo/geraCodigo.class.php");
include_once("../app.dbo/TDbo.class.php");
include_once("../app.dbo/TExpression.class.php");
include_once("../app.dbo/TFilter.class.php");
include_once("../app.dbo/TSqlInstruction.class.php");
include_once("../app.dbo/TSqlUpdate.class.php");
include_once("../app.dbo/TSqlInsert.class.php");
include_once("../app.dbo/TSqlSelect.class.php");
include_once("../app.dbo/TCriteria.class.php");
include_once("../app.widgets/TSession.class.php");
include_once("../app.dbo/TConnection.class.php");
include_once("../app.dbo/TTransaction.class.php");
include_once("../app.util/TSetData.class.php");
include_once("../app.dbo/TConstantes.class.php");

$obsession = new TSession();
$obsession->setValue('pathDB', '../app.config/my_dbpetrus');

$dados = $_POST;

$dt = new TSetData();
$dataCad = $dt->getData();


//executa formulário
if($_POST['continuar'] != ""){

    //Valida duplicação de clientes já cadastrados
    $sqlValidaCurriculo = new TDbo(TConstantes::DBCURRICULOS,'bitup');
    $critValidaCurriculo = new TCriteria();
    $critValidaCurriculo->add(new TFilter("cpf","=",$dados['cpf']));
    $getCurriculo = $sqlValidaCurriculo->select("*", $critValidaCurriculo);

    if($getCurriculo->codigo){
        // monta vetor dados com informações do cliente já cadastrado
        foreach($getCurriculo as $keyCol=>$valorCol){
            if(!is_numeric($keyCol) and $valorCol != ""){
                $dados[$keyCol] = $valorCol;
            }
        }
        //guarda codigo do cliente em sessão
        $_SESSION['rcod'] = $dados['codigo'];
    }


    // Pega dados do formulário e valida
    foreach($dados as $n=>$v){

        if($n != "continuar"){
            //valida campos
            if($v != "" and $v != "UF"){
                if($n == "dataNasc") {
                    $valores[$n] = $dt->dataPadrao($v);
                }else{
                    $valores[$n] = $v;
                }
            }
            //Validadação dos Campos
            #else{
            #    echo '<script> alertPetrus("O campo '.$n.' está vazio."); document.getElementById("'.$n.'").focus(); </script>';
            #    exit ();
            #
            #}
        }
    }
    $valores["unidade"] = "x";


    $args = rtrim($valores, ", ");

    if($_SESSION['rcod']){

        $sql  = new TDbo(TConstantes::DBCURRICULOS,'bitup');
        $critSQL = new TCriteria();
        $critSQL->add(new TFilter("codigo","=",$_SESSION['rcod']));
        $runSqlCurriculo = $sql->update($valores, $critSQL);

    }else{
        $sql = new TDbo(TConstantes::DBCURRICULOS,'bitup');
        $runSqlCurriculo = $sql->insert($valores);
    }

    if($runSqlCurriculo){

        if(!isset($_SESSION['rcod'])){

            include_once('../app.dbo/geraCodigo.class.php');

            $idReg = $runSqlCurriculo["id"];
            $codigoRegistro = $runSqlCurriculo["codigo"];

            //guarda codigo do cliente em sessão
            $_SESSION['rcod'] = $codigoRegistro;
        }

        echo "Dados armazenados com sucesso!";
        exit();

    }
    //===========================================
}


//TTransaction::close();

?>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>formulário de Inscrição</title>
    <link href="estilos/principal.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div class="tituloBox"><b>formulário para cadastro de curriculos.</b></div>
<div class="conteudoBox">
<form name="formInscricao" id="formCurriculo" method="post" action="">
<table width="98%" border="0" cellspacing="2" cellpadding="0" class="geral" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size:12px;" align="center"">
        <tr>
        <td align="right">�rea de Interesse (1�):</td>
        <td>
            <select class="bloco_formulario"  name="areaInteresse" id="areaInteresse">
                <?php
                if($_POST['areaInteresse']!= "Selecione"){
                    echo '<option value="'.$_POST['areaInteresse'].'">'.$_POST['areaInteresse'].'</option>';
                }
                else{
                    echo '<option value="">Selecione</option>';
                }
                ?>
                <option value='Administrativa'>Administrativa</option>
                <option value='Administrativo Comercial'>Administrativo Comercial</option>
                <option value='Administrativo/ Operacional'>Administrativo/ Operacional</option>
                <option value='Agron�mica/ Engenharia Agron�mica/ Agribusiness'>Agron�mica/ Engenharia Agron�mica/ Agribusiness</option>
                <option value='Agropecu�ria/ Veterin�ria/ Agrobusiness'>Agropecu�ria/ Veterin�ria/ Agrobusiness</option>
                <option value='Arquitetura/ Decoração/ Urbanismo'>Arquitetura/ Decoração/ Urbanismo</option>
                <option value='Artes'>Artes</option>
                <option value='Artes Gr�ficas'>Artes Gr�ficas</option>
                <option value='Atendimento ao Cliente/ Call Center/ Telemarketing'>Atendimento ao Cliente/ Call Center/ Telemarketing</option>
                <option value='Automação Industrial/ Comercial'>Automação Industrial/ Comercial</option>
                <option value='Aviação/ Aeron�utica'>Aviação/ Aeron�utica</option>
                <option value='Banc�ria/ Private Corporate Bank'>Banc�ria/ Private Corporate Bank</option>
                <option value='Biblioteconomia'>Biblioteconomia</option>
                <option value='Biologia'>Biologia</option>
                <option value='Biotecnologia/ Biom�dicas/ Bioqu�mica'>Biotecnologia/ Biom�dicas/ Bioqu�mica</option>
                <option value='Comercial/ Vendas'>Comercial/ Vendas</option>
                <option value='Com�rcio Exterior/ Trade/ Importação/ Exportação'>Com�rcio Exterior/ Trade/ Importação/ Exportação</option>
                <option value='Compras'>Compras</option>
                <option value='Contabilidade'>Contabilidade</option>
                <option value='Departamento Pessoal'>Departamento Pessoal</option>
                <option value='Desenho Industrial'>Desenho Industrial</option>
                <option value='Economia'>Economia</option>
                <option value='Educação/ Ensino/ Idiomas'>Educação/ Ensino/ Idiomas</option>
                <option value='Enfermagem'>Enfermagem</option>
                <option value='Engenharia Civil/Construção Civil'>Engenharia Civil/Construção Civil</option>
                <option value='Engenharia de Alimentos'>Engenharia de Alimentos</option>
                <option value='Engenharia de Materiais'>Engenharia de Materiais</option>
                <option value='Engenharia de Minas'>Engenharia de Minas</option>
                <option value='Engenharia de Produção/ Industrial'>Engenharia de Produção/ Industrial</option>
                <option value='Engenharia El�trica/ Eletr�nica'>Engenharia El�trica/ Eletr�nica</option>
                <option value='Engenharia mecânica/ Mecatr�nica'>Engenharia mecânica/ Mecatr�nica</option>
                <option value='Esportes/ Educação F�sica'>Esportes/ Educação F�sica</option>
                <option value='Estat�stica /Matem�tica /Atu�ria'>Estat�stica /Matem�tica /Atu�ria</option>
                <option value='Est�tica Corporal'>Est�tica Corporal</option>
                <option value='Farm�cia'>Farm�cia</option>
                <option value='Financeira/ Administrativa'>Financeira/ Administrativa</option>
                <option value='Fisioterapia'>Fisioterapia</option>
                <option value='Fonoaudiologia'>Fonoaudiologia</option>
                <option value='Geologia /Engenharia Agrimensura'>Geologia /Engenharia Agrimensura</option>
                <option value='Hotelaria/ Turismo'>Hotelaria/ Turismo</option>
                <option value='Industrial'>Industrial</option>
                <option value='Inform�tica /TI / Engenharia da Computação'>Inform�tica /TI / Engenharia da Computação</option>
                <option value='Internet/ E-Commerce/ E-Business/ Web/ Web Designer'>Internet/ E-Commerce/ E-Business/ Web/ Web Designer</option>
                <option value='Jornalismo'>Jornalismo</option>
                <option value='Jur�dica'>Jur�dica</option>
                <option value='Log�stica/ Suprimentos'>Log�stica/ Suprimentos</option>
                <option value='Manutenção'>Manutenção</option>
                <option value='Marketing'>Marketing</option>
                <option value='M�dico/ Hospitalar'>M�dico/ Hospitalar</option>
                <option value='Meio Ambiente/ Ecologia/ Engenharia de Meio Ambiente'>Meio Ambiente/ Ecologia/ Engenharia de Meio Ambiente</option>
                <option value='Moda'>Moda</option>
                <option value='Nutrição'>Nutrição</option>
                <option value='Odontologia'>Odontologia</option>
                <option value='Psicologia Cl�nica/ Hospitalar'>Psicologia Cl�nica/ Hospitalar</option>
                <option value='Publicidade e Propaganda'>Publicidade e Propaganda</option>
                <option value='Qualidade'>Qualidade</option>
                <option value='Qu�mica/ Engenharia Qu�mica'>Qu�mica/ Engenharia Qu�mica</option>
                <option value='Recursos Humanos'>Recursos Humanos</option>
                <option value='Relações Internacionais'>Relações Internacionais</option>
                <option value='Relações P�blicas'>Relações P�blicas</option>
                <option value='Restaurante'>Restaurante</option>
                <option value='Secretariado'>Secretariado</option>
                <option value='Seguran�a do Trabalho'>Seguran�a do Trabalho</option>
                <option value='Seguran�a Patrimonial'>Seguran�a Patrimonial</option>
                <option value='Seguros'>Seguros</option>
                <option value='Servi�o Social'>Servi�o Social</option>
                <option value='T�cnica'>T�cnica</option>
                <option value='T�cnico-Comercial'>T�cnico-Comercial</option>
                <option value='Telecomunicações/ Engenharia de Telecomunicações'>Telecomunicações/ Engenharia de Telecomunicações</option>
                <option value='Terapia Ocupacional'>Terapia Ocupacional</option>
                <option value='T�xtil/ Engenharia T�xtil'>T�xtil/ Engenharia T�xtil</option>
                <option value='Tradutor/ Int�rprete'>Tradutor/ Int�rprete</option>
                <option value='Transportes'>Transportes</option>
                <option value='Zootecnia'>Zootecnia</option>

            </select>
        </td>
    </tr>
    <tr>
        <td align="right">�rea de Interesse (2�):</td>
        <td>
            <select class="bloco_formulario"  name="areaInteresse2" id="areaInteresse2">
                <?php
                if($_POST['areaInteresse2']!= "Selecione"){
                    echo '<option value="'.$_POST['areaInteresse2'].'">'.$_POST['areaInteresse2'].'</option>';
                }
                else{
                    echo '<option value="">Selecione</option>';
                }
                ?>
                 <option value='Administrativa'>Administrativa</option>
                <option value='Administrativo Comercial'>Administrativo Comercial</option>
                <option value='Administrativo/ Operacional'>Administrativo/ Operacional</option>
                <option value='Agron�mica/ Engenharia Agron�mica/ Agribusiness'>Agron�mica/ Engenharia Agron�mica/ Agribusiness</option>
                <option value='Agropecu�ria/ Veterin�ria/ Agrobusiness'>Agropecu�ria/ Veterin�ria/ Agrobusiness</option>
                <option value='Arquitetura/ Decoração/ Urbanismo'>Arquitetura/ Decoração/ Urbanismo</option>
                <option value='Artes'>Artes</option>
                <option value='Artes Gr�ficas'>Artes Gr�ficas</option>
                <option value='Atendimento ao Cliente/ Call Center/ Telemarketing'>Atendimento ao Cliente/ Call Center/ Telemarketing</option>
                <option value='Automação Industrial/ Comercial'>Automação Industrial/ Comercial</option>
                <option value='Aviação/ Aeron�utica'>Aviação/ Aeron�utica</option>
                <option value='Banc�ria/ Private Corporate Bank'>Banc�ria/ Private Corporate Bank</option>
                <option value='Biblioteconomia'>Biblioteconomia</option>
                <option value='Biologia'>Biologia</option>
                <option value='Biotecnologia/ Biom�dicas/ Bioqu�mica'>Biotecnologia/ Biom�dicas/ Bioqu�mica</option>
                <option value='Comercial/ Vendas'>Comercial/ Vendas</option>
                <option value='Com�rcio Exterior/ Trade/ Importação/ Exportação'>Com�rcio Exterior/ Trade/ Importação/ Exportação</option>
                <option value='Compras'>Compras</option>
                <option value='Contabilidade'>Contabilidade</option>
                <option value='Departamento Pessoal'>Departamento Pessoal</option>
                <option value='Desenho Industrial'>Desenho Industrial</option>
                <option value='Economia'>Economia</option>
                <option value='Educação/ Ensino/ Idiomas'>Educação/ Ensino/ Idiomas</option>
                <option value='Enfermagem'>Enfermagem</option>
                <option value='Engenharia Civil/Construção Civil'>Engenharia Civil/Construção Civil</option>
                <option value='Engenharia de Alimentos'>Engenharia de Alimentos</option>
                <option value='Engenharia de Materiais'>Engenharia de Materiais</option>
                <option value='Engenharia de Minas'>Engenharia de Minas</option>
                <option value='Engenharia de Produção/ Industrial'>Engenharia de Produção/ Industrial</option>
                <option value='Engenharia El�trica/ Eletr�nica'>Engenharia El�trica/ Eletr�nica</option>
                <option value='Engenharia mecânica/ Mecatr�nica'>Engenharia mecânica/ Mecatr�nica</option>
                <option value='Esportes/ Educação F�sica'>Esportes/ Educação F�sica</option>
                <option value='Estat�stica /Matem�tica /Atu�ria'>Estat�stica /Matem�tica /Atu�ria</option>
                <option value='Est�tica Corporal'>Est�tica Corporal</option>
                <option value='Farm�cia'>Farm�cia</option>
                <option value='Financeira/ Administrativa'>Financeira/ Administrativa</option>
                <option value='Fisioterapia'>Fisioterapia</option>
                <option value='Fonoaudiologia'>Fonoaudiologia</option>
                <option value='Geologia /Engenharia Agrimensura'>Geologia /Engenharia Agrimensura</option>
                <option value='Hotelaria/ Turismo'>Hotelaria/ Turismo</option>
                <option value='Industrial'>Industrial</option>
                <option value='Inform�tica /TI / Engenharia da Computação'>Inform�tica /TI / Engenharia da Computação</option>
                <option value='Internet/ E-Commerce/ E-Business/ Web/ Web Designer'>Internet/ E-Commerce/ E-Business/ Web/ Web Designer</option>
                <option value='Jornalismo'>Jornalismo</option>
                <option value='Jur�dica'>Jur�dica</option>
                <option value='Log�stica/ Suprimentos'>Log�stica/ Suprimentos</option>
                <option value='Manutenção'>Manutenção</option>
                <option value='Marketing'>Marketing</option>
                <option value='M�dico/ Hospitalar'>M�dico/ Hospitalar</option>
                <option value='Meio Ambiente/ Ecologia/ Engenharia de Meio Ambiente'>Meio Ambiente/ Ecologia/ Engenharia de Meio Ambiente</option>
                <option value='Moda'>Moda</option>
                <option value='Nutrição'>Nutrição</option>
                <option value='Odontologia'>Odontologia</option>
                <option value='Psicologia Cl�nica/ Hospitalar'>Psicologia Cl�nica/ Hospitalar</option>
                <option value='Publicidade e Propaganda'>Publicidade e Propaganda</option>
                <option value='Qualidade'>Qualidade</option>
                <option value='Qu�mica/ Engenharia Qu�mica'>Qu�mica/ Engenharia Qu�mica</option>
                <option value='Recursos Humanos'>Recursos Humanos</option>
                <option value='Relações Internacionais'>Relações Internacionais</option>
                <option value='Relações P�blicas'>Relações P�blicas</option>
                <option value='Restaurante'>Restaurante</option>
                <option value='Secretariado'>Secretariado</option>
                <option value='Seguran�a do Trabalho'>Seguran�a do Trabalho</option>
                <option value='Seguran�a Patrimonial'>Seguran�a Patrimonial</option>
                <option value='Seguros'>Seguros</option>
                <option value='Servi�o Social'>Servi�o Social</option>
                <option value='T�cnica'>T�cnica</option>
                <option value='T�cnico-Comercial'>T�cnico-Comercial</option>
                <option value='Telecomunicações/ Engenharia de Telecomunicações'>Telecomunicações/ Engenharia de Telecomunicações</option>
                <option value='Terapia Ocupacional'>Terapia Ocupacional</option>
                <option value='T�xtil/ Engenharia T�xtil'>T�xtil/ Engenharia T�xtil</option>
                <option value='Tradutor/ Int�rprete'>Tradutor/ Int�rprete</option>
                <option value='Transportes'>Transportes</option>
                <option value='Zootecnia'>Zootecnia</option>

            </select>
        </td>
    </tr>
    <tr>
        <td align="right">�rea de Interesse (3�):</td>
        <td>
            <select class="bloco_formulario"  name="areaInteresse3" id="areaInteresse3">
                <?php
                if($_POST['areaInteresse3']!= "Selecione"){
                    echo '<option value="'.$_POST['areaInteresse3'].'">'.$_POST['areaInteresse3'].'</option>';
                }
                else{
                    echo '<option value="">Selecione</option>';
                }
                ?>
                 <option value='Administrativa'>Administrativa</option>
                <option value='Administrativo Comercial'>Administrativo Comercial</option>
                <option value='Administrativo/ Operacional'>Administrativo/ Operacional</option>
                <option value='Agron�mica/ Engenharia Agron�mica/ Agribusiness'>Agron�mica/ Engenharia Agron�mica/ Agribusiness</option>
                <option value='Agropecu�ria/ Veterin�ria/ Agrobusiness'>Agropecu�ria/ Veterin�ria/ Agrobusiness</option>
                <option value='Arquitetura/ Decoração/ Urbanismo'>Arquitetura/ Decoração/ Urbanismo</option>
                <option value='Artes'>Artes</option>
                <option value='Artes Gr�ficas'>Artes Gr�ficas</option>
                <option value='Atendimento ao Cliente/ Call Center/ Telemarketing'>Atendimento ao Cliente/ Call Center/ Telemarketing</option>
                <option value='Automação Industrial/ Comercial'>Automação Industrial/ Comercial</option>
                <option value='Aviação/ Aeron�utica'>Aviação/ Aeron�utica</option>
                <option value='Banc�ria/ Private Corporate Bank'>Banc�ria/ Private Corporate Bank</option>
                <option value='Biblioteconomia'>Biblioteconomia</option>
                <option value='Biologia'>Biologia</option>
                <option value='Biotecnologia/ Biom�dicas/ Bioqu�mica'>Biotecnologia/ Biom�dicas/ Bioqu�mica</option>
                <option value='Comercial/ Vendas'>Comercial/ Vendas</option>
                <option value='Com�rcio Exterior/ Trade/ Importação/ Exportação'>Com�rcio Exterior/ Trade/ Importação/ Exportação</option>
                <option value='Compras'>Compras</option>
                <option value='Contabilidade'>Contabilidade</option>
                <option value='Departamento Pessoal'>Departamento Pessoal</option>
                <option value='Desenho Industrial'>Desenho Industrial</option>
                <option value='Economia'>Economia</option>
                <option value='Educação/ Ensino/ Idiomas'>Educação/ Ensino/ Idiomas</option>
                <option value='Enfermagem'>Enfermagem</option>
                <option value='Engenharia Civil/Construção Civil'>Engenharia Civil/Construção Civil</option>
                <option value='Engenharia de Alimentos'>Engenharia de Alimentos</option>
                <option value='Engenharia de Materiais'>Engenharia de Materiais</option>
                <option value='Engenharia de Minas'>Engenharia de Minas</option>
                <option value='Engenharia de Produção/ Industrial'>Engenharia de Produção/ Industrial</option>
                <option value='Engenharia El�trica/ Eletr�nica'>Engenharia El�trica/ Eletr�nica</option>
                <option value='Engenharia mecânica/ Mecatr�nica'>Engenharia mecânica/ Mecatr�nica</option>
                <option value='Esportes/ Educação F�sica'>Esportes/ Educação F�sica</option>
                <option value='Estat�stica /Matem�tica /Atu�ria'>Estat�stica /Matem�tica /Atu�ria</option>
                <option value='Est�tica Corporal'>Est�tica Corporal</option>
                <option value='Farm�cia'>Farm�cia</option>
                <option value='Financeira/ Administrativa'>Financeira/ Administrativa</option>
                <option value='Fisioterapia'>Fisioterapia</option>
                <option value='Fonoaudiologia'>Fonoaudiologia</option>
                <option value='Geologia /Engenharia Agrimensura'>Geologia /Engenharia Agrimensura</option>
                <option value='Hotelaria/ Turismo'>Hotelaria/ Turismo</option>
                <option value='Industrial'>Industrial</option>
                <option value='Inform�tica /TI / Engenharia da Computação'>Inform�tica /TI / Engenharia da Computação</option>
                <option value='Internet/ E-Commerce/ E-Business/ Web/ Web Designer'>Internet/ E-Commerce/ E-Business/ Web/ Web Designer</option>
                <option value='Jornalismo'>Jornalismo</option>
                <option value='Jur�dica'>Jur�dica</option>
                <option value='Log�stica/ Suprimentos'>Log�stica/ Suprimentos</option>
                <option value='Manutenção'>Manutenção</option>
                <option value='Marketing'>Marketing</option>
                <option value='M�dico/ Hospitalar'>M�dico/ Hospitalar</option>
                <option value='Meio Ambiente/ Ecologia/ Engenharia de Meio Ambiente'>Meio Ambiente/ Ecologia/ Engenharia de Meio Ambiente</option>
                <option value='Moda'>Moda</option>
                <option value='Nutrição'>Nutrição</option>
                <option value='Odontologia'>Odontologia</option>
                <option value='Psicologia Cl�nica/ Hospitalar'>Psicologia Cl�nica/ Hospitalar</option>
                <option value='Publicidade e Propaganda'>Publicidade e Propaganda</option>
                <option value='Qualidade'>Qualidade</option>
                <option value='Qu�mica/ Engenharia Qu�mica'>Qu�mica/ Engenharia Qu�mica</option>
                <option value='Recursos Humanos'>Recursos Humanos</option>
                <option value='Relações Internacionais'>Relações Internacionais</option>
                <option value='Relações P�blicas'>Relações P�blicas</option>
                <option value='Restaurante'>Restaurante</option>
                <option value='Secretariado'>Secretariado</option>
                <option value='Seguran�a do Trabalho'>Seguran�a do Trabalho</option>
                <option value='Seguran�a Patrimonial'>Seguran�a Patrimonial</option>
                <option value='Seguros'>Seguros</option>
                <option value='Servi�o Social'>Servi�o Social</option>
                <option value='T�cnica'>T�cnica</option>
                <option value='T�cnico-Comercial'>T�cnico-Comercial</option>
                <option value='Telecomunicações/ Engenharia de Telecomunicações'>Telecomunicações/ Engenharia de Telecomunicações</option>
                <option value='Terapia Ocupacional'>Terapia Ocupacional</option>
                <option value='T�xtil/ Engenharia T�xtil'>T�xtil/ Engenharia T�xtil</option>
                <option value='Tradutor/ Int�rprete'>Tradutor/ Int�rprete</option>
                <option value='Transportes'>Transportes</option>
                <option value='Zootecnia'>Zootecnia</option>
            </select>
        </td>
    </tr>
    <tr><td><br></td></tr>
    <tr>
        <td align="right">Nome:</td>
        <td><input class="bloco_formulario" name="nome" id="nome" type="text" value="<?php echo $_POST['nome'];?>" size="50" maxlength="100" class="fields" /></td>
    </tr>
    <tr>
        <td align="right">Sexo:</td>
        <td>
            <select class="bloco_formulario"  class="bloco_formulario" name="sexo" id="sexo">
                <?php
                if($_POST['sexo']!= "Selecione"){
                    echo '<option value="'.$_POST['sexo'].'">'.$_POST['sexo'].'</option>';
                }
                else{
                    echo '<option value="">Selecione</option>';
                }
                ?>
                <option value="Masculino">Masculino</option>
                <option value="Feminino">Feminino</option>

            </select>
        </td>
    </tr>
    <tr>
    <td align="right">Data de nascimento:</td>
    <td><input class="bloco_formulario"  type="text" name="dataNasc" id="dataNasc" value="<?php echo $_POST['dataNasc'];?>" size="10" maxlength="11" class="fields" /></td>
    </tr>
    <tr>
    <td align="right">CPF:</td>
    <td><input class="bloco_formulario"  type="text" name="cpf" id="cpf" value="<?php echo $_POST['cpf'];?>" size="15" maxlength="11" class="fields" /></td>
    </tr>
    <tr>
        <td align="right">Estado Civil:</td>
        <td>
            <select class="bloco_formulario"  name="estadoCivil" id="estadoCivil">
                <?php
                if($_POST['estadoCivil']!= "Selecione"){
                    echo '<option value="'.$_POST['estadoCivil'].'">'.$_POST['estadoCivil'].'</option>';
                }
                else{
                    echo '<option value="">Selecione</option>';
                }
                ?>
                <option value="Solteiro">Solteiro</option>
                <option value="Casado">Casado</option>
                <option value="Divorciado">Divorciado</option>
                <option value="Outros">Outros</option>
                
            </select>
        </td>
    </tr>
    <tr>
        <td align="right">Endere&ccedil;o:</td>
        <td><input class="bloco_formulario"  type="text" name="logadouro" id="logadouro" value="<?php echo $_POST['logadouro'];?>" size="60" class="fields"/></td>
    </tr>
    <tr>
        <td align="right">Bairro:</td>
        <td><input class="bloco_formulario"  type="text" name="bairro" id="bairro" value="<?php echo $_POST['bairro'];?>" size="60" class="fields"/></td>
    </tr>
    <tr>
        <td align="right">Cidade/Estado:</td>
        <td><input class="bloco_formulario"  type="text" name="cidade" id="cidade" value="<?php echo $_POST['cidade'];?>" size="30" class="fields"/>
            <select class="bloco_formulario"  name="estado" id="estado" class="fields">
                <?php
                if($_POST['estado']!= "estado"){
                    echo '<option value="'.$_POST['estado'].'">'.$_POST['estado'].'</option>';
                }
                else{
                    echo '<option value="">UF</option>';
                }
                ?>
                <option >AC</option>
                <option >AL</option>
                <option >AM</option>
                <option >AP</option>
                <option >BA</option>
                <option >CE</option>
                <option >DF</option>
                <option >ES</option>
                <option >GO</option>
                <option >MA</option>
                <option >MG</option>
                <option >MS</option>
                <option >MT</option>
                <option >PA</option>
                <option >PB</option>
                <option >PE</option>
                <option >PI</option>
                <option >PR</option>
                <option >RJ</option>
                <option >RN</option>
                <option >RO</option>
                <option >RR</option>
                <option >RS</option>
                <option >SC</option>
                <option >SE</option>
                <option >SP</option>
                <option >TO</option>
            </select>
        </td>
    </tr>
    <tr>
        <td align="right">Telefone:</td>
        <td><input class="bloco_formulario"  type="text" name="telefone" id="telefone" value="<?php echo $_POST['telefone'];?>" size="18" maxlength="20" class="fields" />
        <span style="font-size:10px; color:#333333;">Ex.:(62-3210 4567)</span>	  </td>
    </tr>
    <tr>
        <td align="right">Celular:</td>
        <td><input class="bloco_formulario"  type="text" name="celular" id="celular" value="<?php echo $_POST['celular'];?>" size="18" maxlength="20" class="fields" />
        <span style="font-size:10px; color:#333333;">Ex.:(62-9876 6780)</span>	</td>
    </tr>
    <tr>
        <td align="right">E-mail:</td>
        <td><input class="bloco_formulario"  name="email" id="email" type="text" value="<?php echo $_POST['email'];?>" size="40" maxlength="100" class="fields" /></td>
    </tr>
    <tr>
        <td align="right">Carteira de Habilitação:</td>
        <td>
            <select class="bloco_formulario"  name="cnh" id="cnh">
                <?php
                if($_POST['cnh']!= "Selecione"){
                    echo '<option value="'.$_POST['cnh'].'">'.$_POST['cnh'].'</option>';
                }
                else{
                    echo '<option value="">Selecione</option>';
                }
                ?>
                <option value="Nenhuma">Nenhuma</option>
                <option value="A">A</option>
                <option value="B">B</option>
                <option value="C">C</option>
                <option value="D">D</option>
                <option value="AB">AB</option>
                <option value="AC">AC</option>
                <option value="AD">AD</option>

            </select>
        </td>
    </tr>
    <tr>
        <td align="right">N� de Dependentes:</td>
        <td><input class="bloco_formulario"  type="text" name="dependentes" id="dependentes" value="<?php echo $_POST['dependentes'];?>" size="5" class="fields"/></td>
    </tr>
    <tr>
        <td align="right">Idiomas:</td>
        <td valign="top"><textarea class="bloco_formulario"  name="idiomas" id="idiomas" type="text" value="<?php echo $_POST['idiomas'];?>" rows="8" cols="60" class="fields">L�ngua - Nivel(B�sico,Intermediario,Fluente)</textarea></td></tr><tr><td></td><td><span style="font-size:10px; color:#333333;">* Exemplo: Alem�o - Fluente</span></td>


    </tr>

    <tr>
        <td colspan="2" align="right"><br /></td>
    </tr>
    <tr>
        <td align="right">Escolaridade:</td>
        <td valign="top"><textarea class="bloco_formulario"  name="escolaridade" id="escolaridade" type="text" value="<?php echo $_POST['escolaridade'];?>" rows="8" cols="60" class="fields">Curso - Nivel - Instituição</textarea></td></tr><tr><td></td><td><span style="font-size:10px; color:#333333;">* Exemplo: MBA em Gest�o Estrat�gica - Especialização - GAP</span></td>


    </tr>
    <tr>
        <td colspan="2" align="right"><br /></td>
    </tr>
    <tr>
        <td align="right">Cursos extra curriculares:</td>
        <td><textarea class="bloco_formulario"  name="cursos" id="cursos" type="text" value="<?php echo $_POST['cursos'];?>" rows="8" cols="60" class="fields">Curso - Carga Hor�ria - Instituição</textarea></td></tr><tr><td></td><td><span style="font-size:10px; color:#333333;">* Exemplo: Atendimento ao Cliente - 20 hs - GAP</span></td>

    </tr>
    <tr>
        <td colspan="2" align="right"><br /></td>
    </tr>
    <tr>
        <td align="right">Experi�ncia Profissional:</td>
        <td><textarea class="bloco_formulario"  name="experiencia" id="experiencia" type="text" value="<?php echo $_POST['experiencia'];?>" rows="8" cols="60" class="fields">Empresa - Cargo - Tempo de Empresa</textarea></td></tr><tr><td></td><td><span style="font-size:10px; color:#333333;">* Exemplo: GAP - Professor - 3 anos</span></td>

    </tr>
            <tr>
        <td align="right">Resumo do curr�culo:</td>
        <td valign="top"><textarea class="bloco_formulario"  name="resumo" id="resumo" type="text" value="<?php echo $_POST['resumo'];?>" rows="8" cols="60" class="fields">-</textarea></td></tr><tr><td></td><td><span style="font-size:10px; color:#333333;">* Escreva informações adicionais sobre o seu curr�culo</span></td>


    </tr>
    <tr>
        <td colspan="2" align="right"></td>
    </tr>
    <tr>
        <td align="right">&nbsp;</td>
        <td align="right"><input class="bloco_formulario"  type="submit" name="continuar" value="Concluir �"></td>
    </tr>

</table>

</form>
</div>
</body>
</html>

