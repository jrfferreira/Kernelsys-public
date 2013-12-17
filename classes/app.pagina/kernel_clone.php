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
function carregaModulo($seq){
    imprimi('-- Inicio');


	if($seq){
        //-------------
		$formseq = $seq;


           // imprimi('INSERT INTO session_var (var,val) VALUES(\''.$var.'\',\''..'\');');

            
        
        imprimi('-- Formulário');
		$dboForm = new TKrs('forms');
		$dCritForm = new TCriteria();
		$dCritForm->add(new TFilter('id','=',$formseq));
		$retForm = $dboForm->select('*',$dCritForm);

		$obForm = $retForm->fetchObject();

/*
		if($obForm->frmpseq && $obForm->frmpseq != $obForm->seq && $obForm->frmpseq != '0'){
            $fPai = $obForm->frmpseq;
			$$fPai = new execClonage();
            $$fPai->carregaModulo($obForm->frmpseq);
			$chavepai = "formseq{$obForm->frmpseq}";
		}
*/
		imprimi('-- Form x Tabela');
		$dboform_x_tabelas = new TKrs('form_x_tabelas');
		$dCritform_x_tabelas = new TCriteria();
		$dCritform_x_tabelas->add(new TFilter('formseq','=',$obForm->seq));
		$dCritform_x_tabelas->add(new TFilter('statseq','=','1'));
		$retform_x_tabelas = $dboform_x_tabelas->select('*',$dCritform_x_tabelas);


		imprimi('-- Tabelas');
		while($obform_x_tabelas= $retform_x_tabelas->fetchObject()){
            
			$dboTabelas = new TKrs('tabelas');
			$dCritTabelas = new TCriteria();
			$dCritTabelas->add(new TFilter('seq','=',$obform_x_tabelas->tabseq));
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
        imprimi('INSERT INTO session_var (var,val) VALUES (\'tabelas'.$obTabela->seq.'\', currval(\'tabelas_id_seq\'::regclass));');
        //imprimi("set tabelas{$obTabela->seq} = currval(\"tabelas_id_seq\");");
         
         $form_x_tabelas[$obTabela->seq] = $obTabela;
        imprimi('');
				

		}
        
        if(!$form_x_tabelas[$obForm->tabseq]){
            			$dboTabelas = new TKrs('tabelas');
			$dCritTabelas = new TCriteria();
			$dCritTabelas->add(new TFilter('seq','=',$obForm->tabseq));
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
			//imprimi("declare tabelas{$obTabela->seq} int;");
        imprimi('INSERT INTO session_var (var,val) VALUES (\'tabelas'.$obTabela->seq.'\', currval(\'tabelas_id_seq\'::regclass));');
		//imprimi("tabelas{$obTabela->seq} = currval(\"tabelas_id_seq\");");
         
            $form_x_tabelas[$obTabela->seq] = $obTabela;
        
        }
		
		imprimi('-- Forms');
		$insertforms = "INSERT INTO forms (";
        $valuesforms = null;

		foreach($obForm as $ch=>$vl){
			if($ch != 'id' && $ch != TConstantes::LISTA){
				$insertforms .= $ch.", ";
				if($ch == 'frmpseq' && $vl && $vl != '0' && $vl != ($obForm->seq)){
					$valuesforms .= "(select val from session_var where var = 'formseq{$vl}' limit 1), ";
				}else if($ch == TConstantes::ENTIDADE){
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
		//imprimi("declare formseq{$formseq} int;");
        imprimi('INSERT INTO session_var (var,val) VALUES (\TConstantes::FORM'.$formseq.'\', currval(\'formseq_seq\'::regclass));');
		//imprimi("set formseq{$formseq} = currval(\"formseq_seq\");");
        imprimi('');
        
        foreach($form_x_tabelas as $x){               
            imprimi("INSERT INTO form_x_tabelas (formseq,tabseq,statseq) VALUES ((select val from session_var where var = 'formseq{$formseq}' limit 1), (select val from session_var where var = 'tabelas{$x->seq}' limit 1),'{$x->statseq}');");
      
        }    
        
		imprimi('-- Lista Form');
        //Lista Form	
		$dboListas = new TKrs('lista');
		$dCritLista = new TCriteria();
		$dCritLista->add(new TFilter('id','=',"({$obForm->listseq})"));

		$retListas = $dboListas->select('*',$dCritLista);

		$obListas = $retListas->fetchObject();

		$insertlista = "INSERT INTO lista (";
        $valueslista = null;

		foreach($obListas as $ch=>$vl){
			if($ch != 'id'){
				$insertlista .= $ch.", ";
                               
				if($ch == 'formseq'){
					$valueslista .= "(select val from session_var where var = 'formseq{$obForm->seq}' limit 1), ";
				}else if($ch == TConstantes::ENTIDADE){
					$valueslista .= "(select val from session_var where var = 'tabelas{$vl}' limit 1), ";
				}else if($ch == 'listapai'){
					if($vl != $obListas->seq){
                        $valueslista .= "(select val from session_var where var = 'listseqForm{$vl}' limit 1), ";
                    }else{
                        $valueslista .= "currval('formseq_seq'::regclass), ";                        
                     }   
				}else{
					$valueslista .= "'".$vl."', ";
				}
			}
		}

		$insertlista = preg_replace('@\,.$@i','',$insertlista);
		$valueslista = preg_replace('@\,.$@i','',$valueslista);

		$insertlista .= ") VALUES (".$valueslista.");";

		imprimi($insertlista);

        imprimi('');
		//imprimi("declare listseqForm{$obListas->seq} int;");
        imprimi('INSERT INTO session_var (var,val) VALUES (\'listseqForm'.$obListas->seq.'\', currval(\'formseq_seq\'::regclass));');
		//imprimi("set listseqForm{$obListas->seq} = currval(\"formseq_seq\");");
        imprimi('');
		
		//Lista-colunas
		
		imprimi('-- Lista Colunas');
		$dboListaCol = new TKrs('coluna');
		$dCritListaCol = new TCriteria();
		$dCritListaCol->add(new TFilter('listseq','=',$obForm->listseq));
		$dCritListaCol->add(new TFilter('statseq','=','1'));

		$retListasCol = $dboListaCol->select('*',$dCritListaCol);

		while($dboListasCol = $retListasCol->fetchObject()){


		$insertcoluna  = "INSERT INTO coluna (";
        $valuescoluna = null;
        
		foreach($dboListasCol as $ch=>$vl){
				
			if($ch != 'id'){
				$insertcoluna .= $ch.", ";
				if($ch == 'listseq'){
					$valuescoluna .= "(select val from session_var where var = 'listseqForm{$obListas->seq}' limit 1), ";
				}else{
					$valuescoluna .= "'".$vl."', ";
				}
			}
		}

		$insertcoluna = preg_replace('@\,.$@i','',$insertcoluna);
		$valuescoluna = preg_replace('@\,.$@i','',$valuescoluna);

		$insertcoluna .= ") VALUES (".$valuescoluna.");";
        
		imprimi($insertcoluna);
		
		}
        
        //form_x_abas
        

        $dboFormAbas = new TKrs('form_x_abas');
		$dCritFormAbas = new TCriteria();
		$dCritFormAbas->add(new TFilter('formseq','=',$formseq));
        $dCritFormAbas->add(new TFilter('statseq','=','1'));

		$retFormAbas = $dboFormAbas->select('*',$dCritFormAbas);
          $obFormAbas_ = null;
          while($obFormAbas__ = $retFormAbas->fetchObject()){
               $obFormAbas_[] = $obFormAbas__;
          }
      
      if($obFormAbas_){
       foreach($obFormAbas_ as $obFormAbas){
            
        $dboAbas = new TKrs('abas');
		$dCritAbas = new TCriteria();
		$dCritAbas->add(new TFilter('seq','=',"({$obFormAbas->abaseq})"));
        
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
		//imprimi("declare abaseq{$obAba->seq} int;");
        imprimi('INSERT INTO session_var (var,val) VALUES (\'abaseq'.$obAba->seq.'\', currval(\'abas_id_seq\'::regclass));');
		//imprimi("set abaseq{$obAba->seq} = currval(\"abas_id_seq\");");        
        imprimi('');
        		imprimi('-- Form x Abas');
        imprimi("INSERT INTO form_x_abas (formseq,abaseq,ordem,statseq) VALUES ((select val from session_var where var = 'formseq{$formseq}' limit 1), (select val from session_var where var = 'abaseq{$obAba->seq}' limit 1),'{$obFormAbas->ordem}','{$obFormAbas->statseq}');");
        
        //bloco_x_abas
        
        $dboBlocoAbas = new TKrs('blocos_x_abas');
		$dCritBlocoAbas = new TCriteria();
		$dCritBlocoAbas->add(new TFilter('abaseq','=',$obAba->seq));
        $retBlocoAbas = $dboBlocoAbas->select('*',$dCritBlocoAbas);
      
      $obBlocoAba_ = null;
      while($obBlocoAba__ = $retBlocoAbas->fetchObject()){
           $obBlocoAba_[] = $obBlocoAba__;
      }
      
      
      if($obBlocoAba_ ){
      foreach($obBlocoAba_ as $obBlocoAba){
          
            $dboBloco = new TKrs('blocos');
            $dCritBloco = new TCriteria();
            $dCritBloco->add(new TFilter('seq','=',$obBlocoAba->blocseq));
            
       $retBloco= $dboBloco->select('*',$dCritBloco);

        $obBloco = $retBloco->fetchObject();

		imprimi('-- Blocos');
		$insert = "INSERT INTO blocos (";
        $values = null;

		foreach($obBloco as $ch=>$vl){
				
			if($ch != 'id'){
				$insert .= $ch.", ";
                if($ch == 'frmpseq'){
					$values .= "(select val from session_var where var = 'formseq{$formseq}' limit 1), ";
				}else if($ch == TConstantes::ENTIDADE && $vl != '0'){
					$values .= "(select val from session_var where var = 'tabelas{$vl}' limit 1), ";
				}else if($ch == TConstantes::FORM){
                    if($vl != 0 && $vl != $obBloco->seq) {
                        
                        imprimi('');
                        imprimi('-- Este bloco possui um formulário independente ('.$obBloco->blocseq.")");
                        $bPForm = $obBloco->blocseq;
                        $$bPForm = new execClonage();
                        $$bPForm->carregaModulo($vl);
                        imprimi('------------------------------------------------'.$obBloco->blocseq.'---------------------------------------------------');
                        imprimi('');
                        $values .=  "(select val from session_var where var = 'formseq{$vl}' limit 1), ";
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
		//imprimi("declare blocseq{$obBloco->seq} int;");
        imprimi('INSERT INTO session_var (var,val) VALUES (\'blocseq'.$obBloco->seq.'\', currval(\'blocos_id_seq\'::regclass));');
		//imprimi("set blocseq{$obBloco->seq} = currval(\"blocos_id_seq\");");        
        imprimi('');
        
        imprimi('-- Blocos x Abas');
        imprimi("INSERT INTO blocos_x_abas (blocseq,abaseq,ordem) VALUES ((select val from session_var where var = 'blocseq{$obBloco->seq}' limit 1), (select val from session_var where var = 'abaseq{$obAba->seq}' limit 1),'{$obFormAbas->ordem}');");
        
        
        //campos_x_blocos
        
        $dboCampoBloco = new TKrs('campos_x_blocos');
		$dCritCampoBloco = new TCriteria();
		$dCritCampoBloco->add(new TFilter('blocseq','=',$obBloco->seq));
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
            $dCritCampo->add(new TFilter('seq','=',$obCampoBloco->campseq));
            
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
				}else if($ch == TConstantes::ENTIDADE){
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
		//imprimi("declare idCampo{$obCampo->seq} int;");
        imprimi('INSERT INTO session_var (var,val) VALUES (\'idCampo'.$obCampo->seq.'\', currval(\'campos_id_seq\'::regclass));');
		//imprimi("set idCampo{$obCampo->seq} = currval(\"campos_id_seq\");");        
        imprimi('');
        
		imprimi('-- Campos x Blocos');
        imprimi("INSERT INTO campos_x_blocos (campseq,blocseq,mostrarcampo,formato,ordem) VALUES ((select val from session_var where var = 'idCampo{$obCampo->seq}' limit 1), (select val from session_var where var = 'blocseq{$obBloco->seq}' limit 1),'{$obCampoBloco->mostrarcampo}','{$obCampoBloco->formato}','{$obCampoBloco->ordem}');");
        
        
        $dboCamposPropriedades = new TKrs('campos_x_propriedades');
        $dCritCamposPropriedades = new TCriteria();
        $dCritCamposPropriedades->add(new TFilter('campseq','=',$obCampo->seq));
        $dCritCamposPropriedades->add(new TFilter('statseq','=','1'));
        
        $retCamposPropriedades = $dboCamposPropriedades->select('*',$dCritCamposPropriedades);
        
        while($obCProp = $retCamposPropriedades->fetchObject()){
            imprimi('-- Campos x Propriedades');
            imprimi("INSERT INTO campos_x_propriedades (campseq,metodo,valor,statseq) VALUES ((select val from session_var where var = 'idCampo{$obCampo->seq}' limit 1), '{$obCProp->metodo}','".str_replace("'","''",$obCProp->valor)."','{$obCProp->statseq}');");
        
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

	$dbo = new TKrs('menu');
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