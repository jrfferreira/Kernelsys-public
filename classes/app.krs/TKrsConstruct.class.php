<?php
set_time_limit(0);
function __autoload($classe) {
	include_once('../app.util/autoload.class.php');
	$autoload = new autoload('../',$classe);
}

class TKrsConstruct {
	public $tableNames = array();
	public $tableSchemas = array();
	public $tableEstructures = array();
	public $tableReferences = array();
	
	private $krsTables =  array('abas',
								'blocos',
								'blocos_x_abas',
								'campos',
								'campos_x_blocos',
								'campos_x_propriedades',
								'dbpessoa',
								'dbunidade',
								'dbunidade_parametro',
								'dbusuario',
								'dbusuario_privilegio',
								'form_button',
								'form_validacao',
								'form_x_abas',
								'form_x_tabelas',
								'forms',
								'lista_actions',
								'lista_bnav',
								'coluna',
								'lista_fields',
								'lista',
								'menu',
								'modulo',
								'tabelas',
								'tipo_campo');
	
	private $dbo;
	private $dboKrs;
	
	private $defaultUser = "admin";
	private $defaultPassword = "123098";
	
	public $idUnidadePetrus = false;
	public $idUnidadeKrs = false;

	public $idPersonPetrus = false;
	public $idPersonKrs = false;
	
	public $idUserPetrus = false;
	public $idUserKrs = false;
	
	public $entidades = array();
	
	public function __construct(){

		$this->dbo = new TDbo_out();
		$this->dboKrs = new TDbo_kernelsys();
	}
	
	public function main(){
		$this->disableAllTriggers();
		$this->createDefaultData();
		if($this->getTables()){
			if($this->getTablesColumns()){
				$this->createUnidade();
				if($this->idUnidadePetrus && $this->idUnidadeKrs){
					$this->createPessoa();
					if($this->idPersonKrs && $this->idPersonPetrus){
						$this->createUser();
						if($this->idUserKrs && $this->idUserPetrus){
							$this->createEntidades();
							
							$this->createForm();
							$this->createList();
							$this->createModule();
							
							$this->updateAllTables();
							
							echo 'Informações iniciais geradas com sucesso.';
						}
					}
				}
			}
		}
		$this->enableAllTriggers();
		$this->dbo->commit();
		$this->dboKrs->commit();
	}

	// Gerar uma unidade
	public function createUnidade(){
		$info = parse_ini_file('../app.config/dataset.ini');
		
		$unidade = array();
		$unidade["nomeunidade"] = $info["empresa"];
		$unidade["razaosocial"] = $info["empresa"];
		$unidade["cnpj"] = preg_replace("/[^0-9]/", "", $info["cnpj"]);
		$unidade["inscestadual"] = preg_replace("/[^0-9]/", "", $info["ie"]);
		$unidade["statseq"] = 1;
		
		$retUnidade = $this->insertPetrus("dbunidade",$unidade);
		$this->idUnidadePetrus = $retUnidade['seq'];

		$retUnidade = $this->insertKrs("dbunidade",$unidade);
		$this->idUnidadeKrs = $retUnidade['seq'];
		
	}
	
	// Gerar uma pessoa
	public function createPessoa(){
		$info = parse_ini_file('../app.config/dataset.ini');
		
		$pessoa= array();
		$pessoa["pessnmrz"] = $info["empresa"];
		$pessoa["pessnmrf"] = preg_replace("/[^0-9]/", "", $info["cnpj"]);
		$pessoa["pessrgie"] = preg_replace("/[^0-9]/", "", $info["ie"]);
		$pessoa["statseq"] = 1;
		
		$retPessoa = $this->insertPetrus("dbpessoa",$pessoa);
		$this->idPersonPetrus = $retPessoa['seq'];
		
		$retPessoa = $this->insertKrs("dbpessoa",$pessoa);
		$this->idPersonKrs = $retPessoa['seq'];
	}
	
	// Gerar um usuario e senha
	public function createUser(){
		// filtra usuario
		$this->defaultUser = str_replace("'","bxd",$this->defaultUser);
		$this->defaultUser = str_replace("=","bxd",$this->defaultUser);
		$this->defaultUser = str_replace("/","bxd",$this->defaultUser);
		$this->defaultUser = str_replace(",","bxd",$this->defaultUser);
		$this->defaultUser = str_replace("(","bxd",$this->defaultUser);
		$this->defaultUser = addslashes($this->defaultUser);
		
		//filtra senha
		$this->defaultPassword = str_replace("'","bxd",$this->defaultPassword);
		$this->defaultPassword = str_replace("=","bxd",$this->defaultPassword);
		$this->defaultPassword = str_replace("/","bxd",$this->defaultPassword);
		$this->defaultPassword = str_replace(",","bxd",$this->defaultPassword);
		$this->defaultPassword = str_replace("(","bxd",$this->defaultPassword);
		$this->defaultPassword = addslashes($this->defaultPassword);
		
		$setControl = new TSetControl();
		$this->defaultPassword = $setControl->setPass($this->defaultPassword);
		
		$user = array();
		$user["classeuser"] = 1;
		$user["temaseq"] = "17";
		$user["usuario"] = $this->defaultUser;
		$user["senha"] = $this->defaultPassword;
		$user["statseq"] = 1;
		
		
		$user['pessseq'] = $this->idPersonPetrus;
		$retUser = $this->insertPetrus("dbusuario", $user);
		
		$this->idUserPetrus = $retUser['seq'];

		$user['pessseq'] = $this->idPersonKrs;
		$retUser = $this->insertKrs("dbusuario", $user);
		
		$this->idUserKrs = $retUser['seq'];
		
	}
	//Obter lista de Foreign Keys
	public function getForeignKeys($table){
		
		$this->dbo->setEntidade('information_schema.table_constraints AS tc
		JOIN information_schema.key_column_usage AS kcu ON tc.constraint_name = kcu.constraint_name
		JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_name = tc.constraint_name');
		
		$crit = new TCriteria();
		$crit->add(new TFilter('constraint_type', '=', 'FOREIGN KEY'));
		$crit->add(new TFilter('tc.table_name', '=', $table));
		$crit->add(new TFilter('kcu.column_name', 'not in', '(\'datacad\',\'statseq\',\'unidseq\',\'usuaseq\',\'seq\')'));
		
		$retFks = $this->dbo->select('tc.constraint_name AS name, 
										ccu.table_name AS tabela,
										kcu.column_name AS colunafilha,
										ccu.column_name AS colunapai',$crit);
		
		$list = array();
		while($obFk = $retFks->fetchObject()){
			$list[$obFk->colunafilha] = $obFk;
		}

		
		return $list;
		
	}
	// Percorrer todas as tabelas
	public function getTables(){
		$criteria = new TCriteria();
		$criteria->add(new TFilter('table_type','=','BASE TABLE'),'AND');
		$criteria->add(new TFilter('table_schema','!=','pg_catalog'));
		$criteria->add(new TFilter('table_schema','!=','information_schema'));
		
		$this->dbo->setEntidade('information_schema.tables');
		$tableList = $this->dbo->select('table_name,table_schema',$criteria);
		
		while($tables = $tableList->fetchObject()){
			$this->tableNames[$tables->table_schema.".".$tables->table_name] = $tables->table_name;
			if(!$this->tableSchemas[$tables->table_schema])
				$this->tableSchemas[$tables->table_schema] = array();
			$this->tableSchemas[$tables->table_schema][] = $tables->table_name;
			$this->tableReferences[$tables->table_name] = $tables->table_schema.".".$tables->table_name;
		}
		
		return true;
	}
	public function getTablesColumns(){
		foreach($this->tableNames as $tableSchema => $table){
			$criteria = new TCriteria();
			$criteria->add(new TFilter('pg_class.relname','=',$table));
			$this->dbo->setEntidade('pg_attribute
			INNER JOIN pg_class ON (pg_class.oid = pg_attribute.attrelid AND
			pg_class.relkind = \'r\')
			INNER JOIN pg_type ON (pg_type.oid = pg_attribute.atttypid AND
			pg_type.typname NOT IN (\'oid\', \'tid\', \'xid\', \'cid\'))
			LEFT JOIN pg_attrdef ON (pg_attrdef.adrelid = pg_attribute.attrelid AND
			pg_attrdef.adnum = pg_attribute.attnum)
			LEFT JOIN pg_constraint ON (pg_constraint.conrelid = pg_attribute.attrelid
			AND (pg_constraint.conkey[1] = pg_attribute.attnum OR
			pg_constraint.conkey[2] = pg_attribute.attnum OR pg_constraint.conkey[3] =
			pg_attribute.attnum OR pg_constraint.conkey[4] = pg_attribute.attnum OR
			pg_constraint.conkey[5] = pg_attribute.attnum OR pg_constraint.conkey[6] =
			pg_attribute.attnum) OR pg_constraint.conkey[7] = pg_attribute.attnum OR
			pg_constraint.conkey[8] = pg_attribute.attnum)');
			
			$estructureList = $this->dbo->select('pg_attribute.attname AS col, pg_attribute.attnotnull AS required,
			pg_attribute.atthasdef, pg_type.typname AS type, pg_attrdef.adsrc AS
			default_value, pg_constraint.contype, pg_constraint.conname, pg_attribute.atttypmod-4 as length',$criteria);
			
			while($estructure = $estructureList->fetchObject()){
				$this->tableEstructures[$tableSchema][$estructure->col] = $estructure;
			}
		}
		return true;
	}
	
	// Cadastrar na tabela de entidades
	public function createEntidades(){
		foreach($this->tableNames as $tableSchema => $table){
			$entidade = array();
			
			$entidade["tabela"] = $tableSchema;
			$entidade["tabela_view"] = $tableSchema;
			$entidade["tabseq"] = null;
			$entidade["colunafilho"] = substr($tableSchema,0,3)."seq";
			
			$retInsert = $this->insertKrs("tabelas", $entidade);
			
			$this->entidades[$tableSchema] = array("tabseq"=>$retInsert['seq']);
		}
		
	}
	
	// Gerar um formulario (Gerar Privilegio)
	public function createForm(){

		//Inserção dos tipos de Campos
		$this->dboKrs->sqlExec('TRUNCATE tipo_campo CASCADE');
		$this->insertKrs('tipo_campo',array('seq'=>'1','tpcadesc'=>"TEntry"));
		$this->insertKrs('tipo_campo',array('seq'=>'2','tpcadesc'=>"TCombo"));
		$this->insertKrs('tipo_campo',array('seq'=>'3','tpcadesc'=>"TRadioGroup"));
		$this->insertKrs('tipo_campo',array('seq'=>'4','tpcadesc'=>"TMultiSelect"));
		$this->insertKrs('tipo_campo',array('seq'=>'5','tpcadesc'=>"TButton"));
		$this->insertKrs('tipo_campo',array('seq'=>'6','tpcadesc'=>"TPassword"));
		$this->insertKrs('tipo_campo',array('seq'=>'7','tpcadesc'=>"THidden"));
		$this->insertKrs('tipo_campo',array('seq'=>'8','tpcadesc'=>"TFrameFile"));
		$this->insertKrs('tipo_campo',array('seq'=>'9','tpcadesc'=>"TText"));
		
		foreach($this->entidades as $table=>$entidade){
			$form = array();
			$form["formid"] = substr('form_'.$table,0,30);
			$form["nomeform"] = $table;
			$form["tabseq"] = $entidade["tabseq"];
			$form["formainclude"] = "one";
			$form["botconcluir"] = "1";
			$form["botcancelar"] = "1";
			$form["formoutcontrol"] = "0";
			$form["autosave"] = "0";
			$form["nivel"] = "1";
			
			
			
			$retInsert = $this->insertKrs("forms", $form);
			$this->entidades[$table]['formseq'] = $retInsert['seq'];
			
			//Vincula form à tabela
			$formTabela = array();
			$formTabela['formseq'] = $retInsert['seq'];
			$formTabela['tabseq'] = $entidade['tabseq'];
			$this->insertKrs('form_x_tabelas', $formTabela);

			// Gerar uma aba (Gerar Privilegio)
			$aba = array();
			$aba['abaid'] = substr('aba_'.$table,0,30);
			$aba['nomeaba'] = $table;
			$aba['obapendice'] = '-';
			$aba['action'] = '-';
			$aba['impressao'] = '1';
			$aba['ordem'] = '1';
			
			$retInsertAba = $this->insertKrs('abas', $aba);

			$formAba = array();
			$formAba['formseq'] = $retInsert['seq'];
			$formAba['abaseq'] = $retInsertAba['seq'];
			$formAba['ordem'] = '1';
			$this->insertKrs('form_x_abas', $formAba);
			
			
			// Gerar um bloco (Gerar Privilegio)
			$bloco = array();
			$bloco['blocoid'] = substr('bloco_'.$table,0,30);
			$bloco['nomebloco'] = $table;
			$bloco['formato'] = 'frm';
			$bloco['tabseq'] = $entidade["tabseq"];
			$bloco['blocoheight'] = '200px';
			$bloco['frmpseq'] = $retInsert['seq'];
			
			$retInsertBloco = $this->insertKrs('blocos', $bloco);
			$blocoSeq = $retInsertBloco['seq'];
			
			$blocoAba = array();
			$blocoAba['abaseq'] = $retInsertAba['seq'];
			$blocoAba['blocseq'] = $retInsertBloco['seq'];
			$blocoAba['ordem'] = '1';
			$this->insertKrs('blocos_x_abas', $blocoAba);
			
			//Obtem Foregin Keys para criação de lista de pesquisas
			$listFks = $this->getForeignKeys($this->tableNames[$table]);
			
			// Gerar todos os campos (Gerar Privilegio)
			$count = 1;
			foreach($this->tableEstructures[$table] as $col => $dataCol){
				$campo = array();
				$campo['colunadb'] = $col;
				$campo['campo'] = 'campo_'.$col;
				$campo['label'] = $col.":";
 				$campo['tpcaseq'] = '1';
				$campo['tabseq'] = $entidade["tabseq"];
				$campo['ativafunction'] = '1';
				$campo['ativapesquisa'] = '0';
				$campo['valorpadrao'] = '-';
				$campo['outcontrol'] = '-';
				$campo['incontrol'] = '0';
				$campo['trigger'] = '0';
				$campo['help'] = '';
				$campo['valornull'] = $dataCol->required ? '1':'0';
				$campo['alteravel'] = $col == 'seq'? '0':'1';
				$campo['autosave'] = '0';
				$campo['manter'] =  $col == 'seq'?  false:true;
				if($col == "unidseq" || $col == "usuaseq"){
					$campo['statseq'] == 9;
				}
				
				if($dataCol->type == 'date'){
					$campo['mascara'] = '\'\'99/99/9999\'\',1';
					$campo['seletor'] = "CLASS_CALENDARIO";
					$campoPropriedade = array();
					$campoPropriedade['metodo'] = "setSize";
					$campoPropriedade['valor'] = "80";
				}else if(strpos($dataCol->type, 'varchar') !== false && $dataCol->length > 0){
					$campoPropriedade = array();
					$campoPropriedade['metodo'] = "maxlength";
					$campoPropriedade['valor'] = $dataCol->length;
				}else if(strpos($dataCol->type, 'int') !== false && $col != 'statseq'){
					$campo['seletor'] = "CLASS_MASCARA_NUMERICO";
					$campoPropriedade = array();
					$campoPropriedade = array();
					$campoPropriedade['metodo'] = "setSize";
					$campoPropriedade['valor'] = "60";
				}else if(strpos($dataCol->type, 'bool') !== false){
					$campo['tpcaseq'] = "3";
					$campoPropriedade = array();
					$campoPropriedade['metodo'] = "addItems";
					$campoPropriedade['valor'] = "1=>Verdadeiro;0=>Falso";
				}else if(strpos($dataCol->type, 'float') !== false){
					$campo['seletor'] = "CLASS_MASCARA_VALOR";
				}else if(strpos($dataCol->type, 'text') !== false){
					$campo['tpcaseq'] = "9";
					$campoPropriedade = array();
					$campoPropriedade['metodo'] = "setSize";
					$campoPropriedade['valor'] = "400;80";
				}
				
				if($col == 'statseq'){
					$campo['tpcaseq'] = "3";
					$campoPropriedade = array();
					$campoPropriedade['metodo'] = "addItems";
					$campoPropriedade['valor'] = "select seq,statdesc from ".$this->tableReferences['dbstatus']." where statseq = 1 order by seq";
				}
				
				if($listFks[$col]){
					$searchListSeq = $this->createSearchList('campo_'.$col,$table,$listFks[$col]);
					$campo['ativapesquisa'] = $searchListSeq;
				}

				$retInsertCampo = $this->insertKrs('campos', $campo);
				
				if($campoPropriedade) {
					$campoPropriedade['campseq'] = $retInsertCampo['seq'];

					$this->insertKrs('campos_x_propriedades', $campoPropriedade);
					
					unset($campoPropriedade);
				}
				
				$campoBloco = array();
				$campoBloco['blocseq'] = $blocoSeq;
				$campoBloco['campseq'] = $retInsertCampo['seq'];
				$campoBloco['mostrarcampo'] = 'S';
				$campoBloco['ordem'] = $col == 'seq'? 1 : ++$count;
				
				$this->insertKrs('campos_x_blocos', $campoBloco);
			}
			
			unset($blocoSeq);
		}
	}
	
	//Gera Lista de Pesquisa
	public function createSearchList($campo,$table,$fk){
				$list = array();
				
				$entidade = $this->entidades[$this->tableReferences[$fk->tabela]];
					
				$list['tipo'] = "pesq";
				$list['formseq'] = $this->entidades[$table]["formseq"];
				$list['filtropai'] = "seq";
				$list['pesquisa'] = $campo."=".$fk->colunapai.','.$campo."Label=".$fk->colunapai;
				$list['lista'] = substr("list_pesq_".$table,0,40);
				$list['label'] = substr("Lista ".$table,0,40);
				$list['tabseq'] = $entidade['tabseq'];
				$list['obapendice'] = "-";
				$list['acfiltro'] = '1';
				$list['acincluir'] = '0';
				$list['nivel'] = '1';
				$list['acdeletar'] = '0';
				$list['aceditar'] = '0';
				$list['acviews'] = '0';
				$list['acenviar'] = '1';
				$list['formainclude'] = 'one';
				$list['acreplicar'] = '1';
				$list['acselecao'] = '0';
				$list['ordem'] = 'seq/desc';
				$list['aclimite'] = '1';
		
				$retInsert = $this->insertKrs("lista", $list);
				$this->entidades[$table]['listseq'] = $codigoLista = $retInsert['seq'];
					
				$this->updateKrs("forms",$entidade["formseq"],array('listseq'=>$retInsert['seq']));
		
				$this->updateKrs("lista",$retInsert['seq'],array('listseq'=>$retInsert['seq']));
					
				// Gerar colunas (Gerar Privilegio)
					
				foreach($this->tableEstructures[$this->tableReferences[$fk->tabela]] as $col => $dataCol){
					$count = 0;
					$width = 1000/count($this->tableEstructures[$this->tableReferences[$fk->tabela]]);
					$column = array();
					$column['listseq'] = $retInsert['seq'];
					$column['coluna'] = $col;
					$column['label'] = $col;
					$column['alinhalabel'] = 'left';
					$column['alinhadados'] = 'left';
					$column['largura'] = $dataCol->length > 0 ? $dataCol->length*15 : $width;
					$column['colfunction'] = '-';
					$column['valorpadrao'] = '0';
					$column['tipocoluna'] = '1';
					$column['tabseq'] = $this->entidades[$this->tableReferences[$fk->tabela]]['tabseq'];
					$column['colunaaux'] = '-';
					$column['link'] = '0';
					$column['ordem'] = ++$count;
		
					$this->insertKrs('coluna', $column);
				}

		
			return $codigoLista;
	}
	
	// Gerar uma lista (Gerar Privilegio)
	public function createList(){
		foreach($this->entidades as $table=>$entidade){
			$list = array();
			
			$list['tipo'] = "form";
			$list['formseq'] = $entidade["formseq"];
			$list['filtropai'] = "seq";
			$list['pesquisa'] = "0";
			$list['lista'] = substr("list_form_".$table,0,40);
			$list['label'] = substr("Lista ".$table,0,40);
			$list['tabseq'] = $entidade['tabseq'];
			$list['obapendice'] = "-";
			$list['acfiltro'] = '1';
			$list['acincluir'] = '1';
			$list['nivel'] = '1';
			$list['acdeletar'] = '1';
			$list['aceditar'] = '1';
			$list['acviews'] = '1';
			$list['acenviar'] = '0';
			$list['formainclude'] = 'one';
			$list['acreplicar'] = '1';
			$list['acselecao'] = '0';
			$list['ordem'] = 'seq/desc';
			$list['aclimite'] = '1';
				
			$retInsert = $this->insertKrs("lista", $list);
			$this->entidades[$table]['listseq'] = $retInsert['seq'];
			
			$this->updateKrs("forms",$entidade["formseq"],array('listseq'=>$retInsert['seq']));

			$this->updateKrs("lista",$retInsert['seq'],array('listseq'=>$retInsert['seq']));
			
			// Gerar colunas (Gerar Privilegio)
			
			foreach($this->tableEstructures[$table] as $col => $dataCol){
				$count = 0;
				$column = array();
				$column['listseq'] = $retInsert['seq'];
				$column['coluna'] = $col;
				$column['label'] = $col;
				$column['alinhalabel'] = 'left';
				$column['alinhadados'] = 'left';
				$column['largura'] = $dataCol->length > 0 ? $dataCol->length*15 : 100;
				$column['colfunction'] = '-';
				$column['valorpadrao'] = '0';
				$column['tipocoluna'] = '1';
				$column['tabseq'] = $this->entidades[$table]['tabseq'];
				$column['colunaaux'] = '-';
				$column['link'] = '0';
				$column['ordem'] = ++$count;
				
				$this->insertKrs('coluna', $column);
			}
			
			$this->setPrivilegio(2, $entidade["formseq"], 1);
			$this->setPrivilegio(2, $entidade["formseq"], 2);
			$this->setPrivilegio(2, $entidade["formseq"], 3);
			
		}
	}
	
	// Gerar um modulo e menu(Gerar Privilegio)
	public function createModule(){
		foreach($this->tableSchemas as $schema=>$tables){
			$moduloPrincipal = array();
			$moduloPrincipal['modulo'] = $schema;
			$moduloPrincipal['labelmodulo'] = $schema;
			$moduloPrincipal['nivel'] = '1';
			$moduloPrincipal['ordem'] = '0';
			
			$retSchemaInsert = $this->insertKrs('modulo', $moduloPrincipal);
			
			$this->setPrivilegio(0, 0, $retSchemaInsert['seq'] );
			
			
			foreach($tables as $tableName){
				$modulo = array();
				$modulo['modulo'] = $schema.$tableName;
				$modulo['labelmodulo'] = $tableName;
				$modulo['metodo'] = 'getList';
				$modulo['argumento'] = $this->entidades[$schema.'.'.$tableName]['listseq'];
				$modulo['formseq'] = $this->entidades[$schema.'.'.$tableName]['formseq'];
				$modulo['nivel'] = '2';
				$modulo['modseq'] = $retSchemaInsert['seq'];
				$modulo['ordem'] = '0';

				$retSchemaInsertMenu = $this->insertKrs('menu', $modulo);
				$this->setPrivilegio(1, $retSchemaInsert['seq'], $retSchemaInsertMenu['seq'] );
			}
		}
	}
	
	
	
	public function insertKrs($table, $data){

		$this->dboKrs->setEntidade($table);
		$data["usuaseq"] = $this->idUserKrs ? (int) $this->idUserKrs : null;
		$data["unidseq"] = $this->idUnidadeKrs ? (int) $this->idUnidadeKrs : null;
		if(!$data["statseq"])
			$data["statseq"] = 1;
		return $this->dboKrs->insert($data);
	}
	
	public function updateKrs($table,$seq,$data){
		$this->dboKrs->setEntidade($table);
		$crit = new TCriteria();
		$crit->add(new TFilter('seq','=',$seq));
		$this->dboKrs->update($data,$crit);
	}
	
	public function insertPetrus($table, $data){
		$this->dbo->setEntidade($table);
		$data["usuaseq"] = $this->idUserPetrus ? (int) $this->idUserPetrus : null;
		$data["unidseq"] = $this->idUnidadePetrus ? (int) $this->idUnidadePetrus : null;
		if(!$data["statseq"])
			$data["statseq"] = 1;
		return $this->dbo->insert($data);
	}
	
	public function setPrivilegio($nivel, $funcionalidade, $modulo) {
		try {
				if ($funcionalidade >= 0) {
					if ($modulo >= 0) {
						if ($nivel >= 0) {
							
								$dtModulo = array();
								$dtModulo["nivel"] = $nivel;
								$dtModulo["funcionalidade"] = $funcionalidade;
								$dtModulo["modulo"] = $modulo;
								$dtModulo['statseq'] = '1';
								
								$this->insertKrs('dbusuario_privilegio', $dtModulo);
								$this->insertPetrus('dbusuario_privilegio', $dtModulo);
								
						}
					}
				}
		} catch (Exception $e) {
			new setException($e);
		}
	}
	
	public function updateAllTables(){
		$crit = new TCriteria();
		$crit->add(new TFilter('seq','is not','null'));
		
		$dados = array();
		$dados['unidseq'] = $this->idUnidadePetrus;
		$dados['usuaseq'] = $this->idUserPetrus;
		$dados['datacad'] = date('Y-m-d');
		$dados['statseq'] = 1;
		foreach($this->tableNames as $key => $name){
			$this->dbo->setEntidade($key);
			$this->dbo->update($dados, $crit);
		}
		
		$dados = array();
		$dados['unidseq'] = $this->idUnidadeKrs;
		$dados['usuaseq'] = $this->idUserKrs;
		$dados['datacad'] = date('Y-m-d');
		$dados['statseq'] = 1;
		foreach($this->krsTables as $key){
			$this->dboKrs->setEntidade($key);
			$this->dboKrs->update($dados, $crit);
		}
	}
	
	public function disableAllTriggers(){
		foreach($this->tableNames as $table => $tableName){
			$this->dbo->sqlExec('ALTER TABLE '.$table.' DISABLE TRIGGER ALL');
		}
		foreach($this->krsTables as $table){
			$this->dboKrs->sqlExec('ALTER TABLE '.$table.' DISABLE TRIGGER ALL');
		}
		
	}
	
	public function enableAllTriggers(){
		foreach($this->tableNames as $table => $tableName){
			$this->dbo->sqlExec('ALTER TABLE '.$table.' ENABLE TRIGGER ALL');
		}
		
		foreach($this->krsTables as $table){
			$this->dboKrs->sqlExec('ALTER TABLE '.$table.' ENABLE TRIGGER ALL');
		}
	}
	
	public function createDefaultData(){
		
		$this->dbo->sqlExec('TRUNCATE dbstatus CASCADE');
		$this->insertPetrus('dbstatus',array('seq'=>'1','statdesc'=>"Ativo"));
		$this->insertPetrus('dbstatus',array('seq'=>'8','statdesc'=>"Inativo"));
		$this->insertPetrus('dbstatus',array('seq'=>'9','statdesc'=>"Inconsistente"));

		$this->dboKrs->sqlExec('TRUNCATE dbstatus CASCADE');
		$this->insertKrs('dbstatus',array('seq'=>'1','statdesc'=>"Ativo"));
		$this->insertKrs('dbstatus',array('seq'=>'8','statdesc'=>"Inativo"));
		$this->insertKrs('dbstatus',array('seq'=>'9','statdesc'=>"Inconsistente"));
		
	}
}


$run = new TKrsConstruct();
$run->main();