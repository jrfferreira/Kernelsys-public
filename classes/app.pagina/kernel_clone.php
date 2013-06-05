<?php
header ('Content-type: text/html; charset=utf-8');
date_default_timezone_set('America/Sao_Paulo');
set_time_limit(0);
session_start();

function __autoload($classe) {
	include_once('../app.util/autoload.class.php');
	$autoload = new autoload('../',$classe);
}
//Retorna Usuario logado===================================

$obUser = new TCheckLogin();
$obUser = $obUser->getUser();
//=========================================================

function imprimi($string,$end = "<br/>"){
	echo $string.$end;
}

Class execClonage {
function carregaModulo($id){
    imprimi('-- Inicio');


	if($id){
        //-------------
		$idForm = $id;


           // imprimi('INSERT INTO session_var (var,val) VALUES(\''.$var.'\',\''..'\');');

            
        
        imprimi('-- Formulário');
		$dboForm = new TKrs('forms');
		$dCritForm = new TCriteria();
		$dCritForm->add(new TFilter('id','=',$idForm));
		$retForm = $dboForm->select('*',$dCritForm);

		$obForm = $retForm->fetchObject();

/*
		if($obForm->formpai && $obForm->formpai != $obForm->id && $obForm->formpai != '0'){
            $fPai = $obForm->formpai;
			$$fPai = new execClonage();
            $$fPai->carregaModulo($obForm->formpai);
			$chavepai = "idForm{$obForm->formpai}";
		}
*/
		imprimi('-- Form x Tabela');
		$dboform_x_tabelas = new TKrs('form_x_tabelas');
		$dCritform_x_tabelas = new TCriteria();
		$dCritform_x_tabelas->add(new TFilter('formid','=',$obForm->id));
		$dCritform_x_tabelas->add(new TFilter('ativo','=','1'));
		$retform_x_tabelas = $dboform_x_tabelas->select('*',$dCritform_x_tabelas);


		imprimi('-- Tabelas');
		while($obform_x_tabelas= $retform_x_tabelas->fetchObject()){
            
			$dboTabelas = new TKrs('tabelas');
			$dCritTabelas = new TCriteria();
			$dCritTabelas->add(new TFilter('id','=',$obform_x_tabelas->tabelaid));
			$retTabelas = $dboTabelas->select('*',$dCritTabelas);

			$obTabela = $retTabelas->fetchObject();

			$inserttabelas = "INSERT INTO tabelas (";
            $valuestabelas = null;
			foreach($obTabela as $ch=>$vl){

				if($ch != 'id'){
					$inserttabelas .= $ch.", ";
					$valuestabelas .= "'".$vl."', ";
				}
			}
			$inserttabelas = preg_replace('@\,.$@i','',$inserttabelas);
			$valuestabelas = preg_replace('@\,.$@i','',$valuestabelas);

			$inserttabelas .= ") VALUES (".$valuestabelas.");";
				
			imprimi($inserttabelas);

        imprimi('');
        imprimi('INSERT INTO session_var (var,val) VALUES (\'tabelas'.$obTabela->id.'\', currval(\'tabelas_id_seq\'::regclass));');
        //imprimi("set tabelas{$obTabela->id} = currval(\"tabelas_id_seq\");");
         
         $form_x_tabelas[$obTabela->id] = $obTabela;
        imprimi('');
				

		}
        
        if(!$form_x_tabelas[$obForm->entidade]){
            			$dboTabelas = new TKrs('tabelas');
			$dCritTabelas = new TCriteria();
			$dCritTabelas->add(new TFilter('id','=',$obForm->entidade));
			$retTabelas = $dboTabelas->select('*',$dCritTabelas);

			$obTabela = $retTabelas->fetchObject();

			$inserttabelas = "INSERT INTO tabelas (";
            $valuestabelas = null;

			foreach($obTabela as $ch=>$vl){

				if($ch != 'id'){
					$inserttabelas .= $ch.", ";
					$valuestabelas .= "'".$vl."', ";
				}
			}
			$inserttabelas = preg_replace('@\,.$@i','',$inserttabelas);
			$valuestabelas = preg_replace('@\,.$@i','',$valuestabelas);

			$inserttabelas .= ") VALUES (".$valuestabelas.");";
				
			imprimi($inserttabelas);

            imprimi('');
			//imprimi("declare tabelas{$obTabela->id} int;");
        imprimi('INSERT INTO session_var (var,val) VALUES (\'tabelas'.$obTabela->id.'\', currval(\'tabelas_id_seq\'::regclass));');
		//imprimi("tabelas{$obTabela->id} = currval(\"tabelas_id_seq\");");
         
            $form_x_tabelas[$obTabela->id] = $obTabela;
        
        }
		
		imprimi('-- Forms');
		$insertforms = "INSERT INTO forms (";
        $valuesforms = null;

		foreach($obForm as $ch=>$vl){
			if($ch != 'id' && $ch != 'idlista'){
				$insertforms .= $ch.", ";
				if($ch == 'formpai' && $vl && $vl != '0' && $vl != ($obForm->id)){
					$valuesforms .= "(select val from session_var where var = 'idForm{$vl}' limit 1), ";
				}else if($ch == 'entidade'){
					$valuesforms .= "(select val from session_var where var = 'tabelas{$vl}' limit 1), ";
				}else{
					$valuesforms .= "'".$vl."', ";
				}
			}
		}

		$insertforms = preg_replace('@\,.$@i','',$insertforms);
		$valuesforms = preg_replace('@\,.$@i','',$valuesforms);

		$insertforms .= ") VALUES (".$valuesforms.");";
			
		imprimi($insertforms);

        imprimi('');
		//imprimi("declare idForm{$idForm} int;");
        imprimi('INSERT INTO session_var (var,val) VALUES (\'idForm'.$idForm.'\', currval(\'forms_id_seq\'::regclass));');
		//imprimi("set idForm{$idForm} = currval(\"forms_id_seq\");");
        imprimi('');
        
        foreach($form_x_tabelas as $x){               
            imprimi("INSERT INTO form_x_tabelas (formid,tabelaid,ativo) VALUES ((select val from session_var where var = 'idForm{$idForm}' limit 1), (select val from session_var where var = 'tabelas{$x->id}' limit 1),'{$x->ativo}');");
      
        }    
        
		imprimi('-- Lista Form');
        //Lista Form	
		$dboListas = new TKrs('lista_form');
		$dCritLista = new TCriteria();
		$dCritLista->add(new TFilter('id','=',"({$obForm->idlista})"));

		$retListas = $dboListas->select('*',$dCritLista);

		$obListas = $retListas->fetchObject();

		$insertlista_form = "INSERT INTO lista_form (";
        $valueslista_form = null;

		foreach($obListas as $ch=>$vl){
			if($ch != 'id'){
				$insertlista_form .= $ch.", ";
                               
				if($ch == 'forms_id'){
					$valueslista_form .= "(select val from session_var where var = 'idForm{$obForm->id}' limit 1), ";
				}else if($ch == 'entidade'){
					$valueslista_form .= "(select val from session_var where var = 'tabelas{$vl}' limit 1), ";
				}else if($ch == 'listapai'){
					if($vl != $obListas->id){
                        $valueslista_form .= "(select val from session_var where var = 'idListaForm{$vl}' limit 1), ";
                    }else{
                        $valueslista_form .= "currval('forms_id_seq'::regclass), ";                        
                     }   
				}else{
					$valueslista_form .= "'".$vl."', ";
				}
			}
		}

		$insertlista_form = preg_replace('@\,.$@i','',$insertlista_form);
		$valueslista_form = preg_replace('@\,.$@i','',$valueslista_form);

		$insertlista_form .= ") VALUES (".$valueslista_form.");";

		imprimi($insertlista_form);

        imprimi('');
		//imprimi("declare idListaForm{$obListas->id} int;");
        imprimi('INSERT INTO session_var (var,val) VALUES (\'idListaForm'.$obListas->id.'\', currval(\'forms_id_seq\'::regclass));');
		//imprimi("set idListaForm{$obListas->id} = currval(\"forms_id_seq\");");
        imprimi('');
		
		//Lista-colunas
		
		imprimi('-- Lista Colunas');
		$dboListaCol = new TKrs('lista_colunas');
		$dCritListaCol = new TCriteria();
		$dCritListaCol->add(new TFilter('lista_form_id','=',$obForm->idlista));
		$dCritListaCol->add(new TFilter('ativo','=','1'));

		$retListasCol = $dboListaCol->select('*',$dCritListaCol);

		while($dboListasCol = $retListasCol->fetchObject()){


		$insertlista_colunas  = "INSERT INTO lista_colunas (";
        $valueslista_colunas = null;
        
		foreach($dboListasCol as $ch=>$vl){
				
			if($ch != 'id'){
				$insertlista_colunas .= $ch.", ";
				if($ch == 'lista_form_id'){
					$valueslista_colunas .= "(select val from session_var where var = 'idListaForm{$obListas->id}' limit 1), ";
				}else{
					$valueslista_colunas .= "'".$vl."', ";
				}
			}
		}

		$insertlista_colunas = preg_replace('@\,.$@i','',$insertlista_colunas);
		$valueslista_colunas = preg_replace('@\,.$@i','',$valueslista_colunas);

		$insertlista_colunas .= ") VALUES (".$valueslista_colunas.");";
        
		imprimi($insertlista_colunas);
		
		}
        
        //form_x_abas
        

        $dboFormAbas = new TKrs('form_x_abas');
		$dCritFormAbas = new TCriteria();
		$dCritFormAbas->add(new TFilter('formid','=',$idForm));
        $dCritFormAbas->add(new TFilter('ativo','=','1'));

		$retFormAbas = $dboFormAbas->select('*',$dCritFormAbas);
          $obFormAbas_ = null;
          while($obFormAbas__ = $retFormAbas->fetchObject()){
               $obFormAbas_[] = $obFormAbas__;
          }
      
      if($obFormAbas_){
       foreach($obFormAbas_ as $obFormAbas){
            
        $dboAbas = new TKrs('abas');
		$dCritAbas = new TCriteria();
		$dCritAbas->add(new TFilter('id','=',"({$obFormAbas->abaid})"));
        
        $retAbas = $dboAbas->select('*',$dCritAbas);

        $obAba = $retAbas->fetchObject();

		imprimi('-- Abas');
		$insert = "INSERT INTO abas (";
        $values = null;

		foreach($obAba as $ch=>$vl){
				
			if($ch != 'id'){
				$insert .= $ch.", ";
				$values .= "'".$vl."', ";
			}
		}

		$insert = preg_replace('@\,.$@i','',$insert);
		$values = preg_replace('@\,.$@i','',$values);

		$insert .= ") VALUES (".$values.");";

		imprimi($insert);

        imprimi('');
		//imprimi("declare idAba{$obAba->id} int;");
        imprimi('INSERT INTO session_var (var,val) VALUES (\'idAba'.$obAba->id.'\', currval(\'abas_id_seq\'::regclass));');
		//imprimi("set idAba{$obAba->id} = currval(\"abas_id_seq\");");        
        imprimi('');
        		imprimi('-- Form x Abas');
        imprimi("INSERT INTO form_x_abas (formid,abaid,ordem,ativo) VALUES ((select val from session_var where var = 'idForm{$idForm}' limit 1), (select val from session_var where var = 'idAba{$obAba->id}' limit 1),'{$obFormAbas->ordem}','{$obFormAbas->ativo}');");
        
        //bloco_x_abas
        
        $dboBlocoAbas = new TKrs('blocos_x_abas');
		$dCritBlocoAbas = new TCriteria();
		$dCritBlocoAbas->add(new TFilter('abaid','=',$obAba->id));
        $retBlocoAbas = $dboBlocoAbas->select('*',$dCritBlocoAbas);
      
      $obBlocoAba_ = null;
      while($obBlocoAba__ = $retBlocoAbas->fetchObject()){
           $obBlocoAba_[] = $obBlocoAba__;
      }
      
      
      if($obBlocoAba_ ){
      foreach($obBlocoAba_ as $obBlocoAba){
          
            $dboBloco = new TKrs('blocos');
            $dCritBloco = new TCriteria();
            $dCritBloco->add(new TFilter('id','=',$obBlocoAba->blocoid));
            
       $retBloco= $dboBloco->select('*',$dCritBloco);

        $obBloco = $retBloco->fetchObject();

		imprimi('-- Blocos');
		$insert = "INSERT INTO blocos (";
        $values = null;

		foreach($obBloco as $ch=>$vl){
				
			if($ch != 'id'){
				$insert .= $ch.", ";
                if($ch == 'formpai'){
					$values .= "(select val from session_var where var = 'idForm{$idForm}' limit 1), ";
				}else if($ch == 'entidade' && $vl != '0'){
					$values .= "(select val from session_var where var = 'tabelas{$vl}' limit 1), ";
				}else if($ch == 'idform'){
                    if($vl != 0 && $vl != $obBloco->id) {
                        
                        imprimi('');
                        imprimi('-- Este bloco possui um formulário independente ('.$obBloco->blocoid.")");
                        $bPForm = $obBloco->blocoid;
                        $$bPForm = new execClonage();
                        $$bPForm->carregaModulo($vl);
                        imprimi('------------------------------------------------'.$obBloco->blocoid.'---------------------------------------------------');
                        imprimi('');
                        $values .=  "(select val from session_var where var = 'idForm{$vl}' limit 1), ";
                    }else{
                        $values .= "'".$vl."', ";
                    }    
				}else{
                    $values .= "'".$vl."', ";
                }
			}
		}

		$insert = preg_replace('@\,.$@i','',$insert);
		$values = preg_replace('@\,.$@i','',$values);

		$insert .= ") VALUES (".$values.");";

		imprimi($insert);

        imprimi('');
		//imprimi("declare idBloco{$obBloco->id} int;");
        imprimi('INSERT INTO session_var (var,val) VALUES (\'idBloco'.$obBloco->id.'\', currval(\'blocos_id_seq\'::regclass));');
		//imprimi("set idBloco{$obBloco->id} = currval(\"blocos_id_seq\");");        
        imprimi('');
        
        imprimi('-- Blocos x Abas');
        imprimi("INSERT INTO blocos_x_abas (blocoid,abaid,ordem) VALUES ((select val from session_var where var = 'idBloco{$obBloco->id}' limit 1), (select val from session_var where var = 'idAba{$obAba->id}' limit 1),'{$obFormAbas->ordem}');");
        
        
        //campos_x_blocos
        
        $dboCampoBloco = new TKrs('campos_x_blocos');
		$dCritCampoBloco = new TCriteria();
		$dCritCampoBloco->add(new TFilter('blocoid','=',$obBloco->id));
        $dCritCampoBloco->add(new TFilter('mostrarcampo','=','S'));
        $retCampoBloco = $dboCampoBloco->select('*',$dCritCampoBloco);
      
      $obCampoBloco_ = null;
      while($obCampoBloco__ = $retCampoBloco->fetchObject()){
           $obCampoBloco_[] = $obCampoBloco__;
      }
      
      if($obCampoBloco_ ){
      foreach($obCampoBloco_ as $obCampoBloco){
            $dboCampo = new TKrs('campos');
            $dCritCampo = new TCriteria();
            $dCritCampo->add(new TFilter('id','=',$obCampoBloco->campoid));
            
       $retCampo= $dboCampo->select('*',$dCritCampo);

        $obCampo = $retCampo->fetchObject();

        if($obCampo){
		imprimi('-- Campos');
		$insert = "INSERT INTO campos (";
        $values = null;

		foreach($obCampo as $ch=>$vl){
				
			if($ch != 'id'){
				$insert .= $ch.", ";
                if($ch == 'ativapesquisa'){
					$values .= "0, ";
				}else if($ch == 'entidade'){
					$values .= "(select val from session_var where var = 'tabelas{$vl}' limit 1), ";
				}else{
                    if(preg_match('/\'/i',$vl)){
                    $values .= "'".str_replace("'","''",$vl)."', ";                        
                    }else{    
                    $values .= "'".$vl."', ";
                    }
                }
			}
		}

		$insert = preg_replace('@\,.$@i','',$insert);
		$values = preg_replace('@\,.$@i','',$values);

		$insert .= ") VALUES (".$values.");";

		imprimi($insert);

        imprimi('');
		//imprimi("declare idCampo{$obCampo->id} int;");
        imprimi('INSERT INTO session_var (var,val) VALUES (\'idCampo'.$obCampo->id.'\', currval(\'campos_id_seq\'::regclass));');
		//imprimi("set idCampo{$obCampo->id} = currval(\"campos_id_seq\");");        
        imprimi('');
        
		imprimi('-- Campos x Blocos');
        imprimi("INSERT INTO campos_x_blocos (campoid,blocoid,mostrarcampo,formato,ordem) VALUES ((select val from session_var where var = 'idCampo{$obCampo->id}' limit 1), (select val from session_var where var = 'idBloco{$obBloco->id}' limit 1),'{$obCampoBloco->mostrarcampo}','{$obCampoBloco->formato}','{$obCampoBloco->ordem}');");
        
        
        $dboCamposPropriedades = new TKrs('campos_x_propriedades');
        $dCritCamposPropriedades = new TCriteria();
        $dCritCamposPropriedades->add(new TFilter('campoid','=',$obCampo->id));
        $dCritCamposPropriedades->add(new TFilter('ativo','=','1'));
        
        $retCamposPropriedades = $dboCamposPropriedades->select('*',$dCritCamposPropriedades);
        
        while($obCProp = $retCamposPropriedades->fetchObject()){
            imprimi('-- Campos x Propriedades');
            imprimi("INSERT INTO campos_x_propriedades (campoid,metodo,valor,ativo) VALUES ((select val from session_var where var = 'idCampo{$obCampo->id}' limit 1), '{$obCProp->metodo}','".str_replace("'","''",$obCProp->valor)."','{$obCProp->ativo}');");
        
        }
        
        }
        
        }    
        }
        
        
        }    
        }
        }
        }
		
        
    //-------------------
	}
}

}
	//Inicio

	$dbo = new TKrs('menu_modulos');
	$dCrit = new TCriteria();
	$dCrit->add(new TFilter('id','=',$_GET['id']));
	$ret = $dbo->select('*',$dCrit);

	$obModulo = $ret->fetchObject();
        
        
        imprimi('CREATE OR REPLACE TABLE session_var');
            imprimi('(');
            imprimi('sessid serial,');
            imprimi('var varchar,');
            imprimi('val int,');
            imprimi('tmsp    time default current_timestamp');
            imprimi(');');
            
    $t = new execClonage();
	$t->carregaModulo($obModulo->form);
	?>