<?php


/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class TUsuario {

	public $user = null;

	public function __construct() {
		$check = new TCheckLogin();
		$this->user = $check->getUser();
	}

	public function getUser($codigo = null) {
		try {
			if ($codigo && $codigo != '') {

				$TDbo_user = new TDbo(TConstantes :: DBUSUARIOS);
				$crit_user = new TCriteria();
				$crit_user->add(new TFilter('codigo', '=', $codigo));
				$retUser = $TDbo_user->select("*", $crit_user);
				$obUser = $retUser->fetchObject();

				if ($obUser->id) {
					return $obUser;
				} else {
					throw new ErrorException("Usuário $codigo inexistente.");
				}
			} else {
				return $this->user;
			}
		} catch (Exception $e) {
			$TDbo_user->rollback();
			new setException($e);
		}
	}

	/**
	 *
	 * return <type>
	 */
	public function getCodigoUsuario() {
		$usuario = $this->user;
		$codigo = $usuario->codigouser;
		return $codigo;
	}

	/**
	 *
	 * return <type>
	 */
	public function getCodigoPessoa() {
		$usuario = $this->user;
		$codigo = $usuario->codigopessoa;
		return $codigo;
	}

	/**
	 *
	 * return <type>
	 */
	public function getCodigoFuncionario() {

		$usuario = $this->user;
		$codigo = $usuario->codigofuncionario;
		return $codigo;
	}

	/**
	 *
	 * return <type>
	 */
	public function getCodigoProfessor() {

		$usuario = $this->user;
		$codigo = $usuario->codigoprofessor;
		return $codigo;
	}

	/**
	 *
	 * return <type>
	 */
	public function getCodigoAluno() {

		$usuario = $this->user;
		$codigo = $usuario->codigoaluno;
		return $codigo;
	}

	/**
	 *
	 * param <type> $codigopessoa
	 * param <type> $login
	 * param <type> $senha
	 * param <type> $codigotema
	 * return <type>
	 */
	public function setUsuario($codigopessoa, $login, $senha, $codigotema = null) {
		try {
			if ($codigotema == null) {
				$codigotema = 17;
			}
			if ($codigopessoa) {

				$TDbo = new TDbo(TConstantes :: DBUSUARIOS);
				$TPessoa = new TPessoa();
				$obPessoa = $TPessoa->getPessoa($codigopessoa);
				if ($obPessoa->codigo) {

					$crit = new TCriteria();
					$crit->add(new TFilter('codigopessoa', '=', $codigopessoa));
					$TDbo = new TDbo(TConstantes :: DBUSUARIOS);
					$retUser = $TDbo->select("usuario", $crit);
					$obUser = $retUser->fetchObject();

					//if($obUser->usuario) {
					//    throw new ErrorException("Já existe um usuário cadastrado para esta pessoa. Usuário: ".$obUser->usuario);
					//}else {
					if ($obUser->usuario == null) {
						$login = trim($login);
						$critUserName = new TCriteria();
						$critUserName->add(new TFilter('usuario', '=', $login));
						$TDbo = new TDbo(TConstantes :: DBUSUARIOS);
						$retUserUserName = $TDbo->select("usuario", $critUserName);
						$obCheckUserName = $retUserUserName->fetchObject();

						if ($obCheckUserName->usuario) {
							throw new ErrorException("Já existe um cadastro com este nome de usuário.");
						}
						elseif (stripos($login, " ")) {
							throw new ErrorException("Não é permitido o uso de espaços em branco no nome de usuário.");
						}
						elseif (strlen($login) < 5) {
							throw new ErrorException("O nome de usuário deve conter no mínimo 5 (cinco) caracteres.");
						}
						elseif (strlen($senha) < 5) {
							throw new ErrorException("A senha deve conter no mínimo 5 (cinco) caracteres.");
						}
						$setControl = new TSetControl();
						$senha = $setControl->setPass($senha);

						$dt['codigopessoa'] = $codigopessoa;
						$dt['classeuser'] = 'a';
						$dt['usuario'] = $login;
						$dt['senha'] = $senha;
						$dt['entidadepai'] = '1';
						$dt['ativo'] = '1';
						$dt['codigotema'] = $codigotema;

						$TDbo = new TDbo(TConstantes :: DBUSUARIOS);
						$insert = $TDbo->insert($dt);
						$insert['usuario'] = $login;
						return $insert;
					}
				} else {
					throw new ErrorException("O codigo de pessoa $codigopessoa é inexistente.");
				}
			} else {
				throw new ErrorException("O codigo de pessoa $codigopessoa é invalido.");
			}
		} catch (Exception $e) {
			$TDbo->rollback();
			new setException($e);
		}
	}

	/*
	 * 
	 */
	public function setPrivilegio($usuario, $nivel, $funcionalidade, $modulo, $situacao) {
		try {
			if ($usuario) {
				$rt = $this->getUser($usuario);
				if ($funcionalidade >= 0) {
					if ($modulo >= 0) {
						if ($nivel >= 0) {
							$critCheck3 = new TCriteria();
							$critCheck3->add(new TFilter("funcionalidade", "=", $funcionalidade));
							$critCheck3->add(new TFilter("nivel", "=", $nivel));
							$critCheck3->add(new TFilter("modulo", "=", $modulo));
							$critCheck3->add(new TFilter("codigousuario", "=", $usuario));
							$TDbo_privilegio = new TDbo(TConstantes :: DBUSUARIOS_PRIVILEGIOS);
							$retHierarquia = $TDbo_privilegio->select("id", $critCheck3);
							$obHierarquia = $retHierarquia->fetchObject();

							if ($obHierarquia->id == null) {

								$dtModulo["nivel"] = $nivel;
								$dtModulo["funcionalidade"] = $funcionalidade;
								$dtModulo["modulo"] = $modulo;
								$dtModulo["codigousuario"] = $usuario;
								$dtModulo['ativo'] = '1';

								$TDbo_privilegio = new TDbo(TConstantes :: DBUSUARIOS_PRIVILEGIOS);

								$retorno = $TDbo_privilegio->insert($dtModulo);
							}
							$retorno["nivel"] = $nivel;
							$retorno["funcionalidade"] = $funcionalidade;
							$retorno["modulo"] = $modulo;
							$retorno["codigousuario"] = $usuario;

							$dSituacao['ativo'] = $situacao;

							$dSituacaoCrit = new TCriteria();
							$dSituacaoCrit->add(new TFilter("funcionalidade", "=", $funcionalidade));
							$dSituacaoCrit->add(new TFilter("nivel", "=", $nivel));
							$dSituacaoCrit->add(new TFilter("modulo", "=", $modulo));
							$dSituacaoCrit->add(new TFilter("codigousuario", "=", $usuario));

							$TDbo_Situacao = new TDbo(TConstantes :: DBUSUARIOS_PRIVILEGIOS);
							$retornoSituacao = $TDbo_Situacao->update($dSituacao, $dSituacaoCrit);

							return $retorno;
						} else {
							throw new ErrorException("O modulo $modulo é invalido.");
						}
					} else {
						throw new ErrorException("O menu $menu é invalido.");
					}
				} else {
					throw new ErrorException("O codigo de usuario $usuario é invalido.");
				}
			} else {
				throw new ErrorException("O codigo de usuario $usuario é invalido.");
			}
		} catch (Exception $e) {
			new setException($e);
		}
	}

	public function getPrivilegios($usuario) {
		try {
			if ($usuario) {
				$rt = $this->getUser($usuario);
				if ($rt) {
					$crit = new TCriteria();
					$crit->add(new TFilter("codigousuario", "=", $usuario));
					$TDbo_privilegio = new TDbo(TConstantes :: DBUSUARIOS_PRIVILEGIOS);
					$retPrivilegio = $TDbo_privilegio->select("*", $crit);

					while ($obPrivilegio = $retPrivilegio->fetchObject()) {
						$ob[$obPrivilegio->nivel][$obPrivilegio->funcionalidade][$obPrivilegio->modulo][$obPrivilegio->ativo] = $obPrivilegio;
					}
					return $ob;
				} else {
					throw new ErrorException("O codigo de usuario $usuario é invalido.");
				}
			} else {
				throw new ErrorException("O codigo de usuario $usuario é invalido.");
			}
		} catch (Exception $e) {
			$TDbo->rollback();
			new setException($e);
		}
	}

	//Função para mudança de password
	public function changePassword($usuario, $old_pass, $new_pass, $confirm) {

		$TSetControl = new TSetControl();
		$old_pass = $TSetControl->setPass($old_pass);
		$new_pass = $TSetControl->setPass($new_pass);
		$confirm = $TSetControl->setPass($confirm);

		if ($new_pass === $confirm) {
			$dbo = new TDbo(TConstantes :: DBUSUARIOS);
			$crit = new TCriteria();
			$crit->add(new TFilter('codigo', '=', $usuario));
			$ret = $dbo->select('senha', $crit);
			$obSenha = $ret->fetchObject();

			if ($obSenha->senha === $old_pass) {
				$update = $dbo->update(array (
					'senha' => $new_pass
				), $crit);

				if ($update) {
					return true;
				} else {
					return false;
				}
			} else {
				return false;
			}
		} else {
			return false;
		}
	}

	//Função para recuperação de password
	public function recoverPassword($chave, $new_pass, $confirm) {

		$dbo = new TDbo(TConstantes :: DBUSUARIOS_SENHAS_RECUPERACAO);
		$crit = new TCriteria();
		$crit->add(new TFilter('chave', '=', $chave));
		$ret = $dbo->select('codigousuario,senhaantiga', $crit);
		$obChave = $ret->fetchObject();

		$TSetControl = new TSetControl();
		$new_pass = $TSetControl->setPass($new_pass);
		$confirm = $TSetControl->setPass($confirm);

		if ($new_pass === $confirm) {
			$dbo = new TDbo(TConstantes :: DBUSUARIOS);
			$crit = new TCriteria();
			$crit->add(new TFilter('codigo', '=', $obChave->codigousuario));
			$ret = $dbo->select('senha', $crit);
			$obSenha = $ret->fetchObject();

			if ($obSenha->senha === $obChave->senhaantiga) {
				$update = $dbo->update(array (
					'senha' => $new_pass
				), $crit);

				if ($update) {
					return true;
				} else {
					return false;
				}
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	
	//Função para solicitação de recuperação de Senha
	public function requestRecoverPassword($codigoUsuario){
		
		$dbo = new TDbo(TConstantes :: DBUSUARIOS);
		$crit = new TCriteria();
		$crit->add(new TFilter('codigo', '=', $codigoUsuario));
		$ret = $dbo->select('senha', $crit);
		$obSenha = $ret->fetchObject();
		
		$old_pass = $obSenha->senha;
	
		if(!empty($old_pass)){
			$TSetControl = new TSetControl();
			$chave = $TSetControl->setPass(md5(rand(1,99) . $codigoUsuario . time() . 'recoverPass'));
		
			$dbo = new TDbo(TConstantes :: DBUSUARIOS_SENHAS_RECUPERACAO);
		
			$retorno = $dbo->insert(array('senhaantiga'=>$old_pass,
							   'codigousuario'=>$codigoUsuario,
							   'chave'=>$chave));
							   
			if(is_array($retorno) && $retorno['codigo']){
				return $chave;
			}
		}else{
			return false;
		}
		
	}

	//Função criação de Password
	public function createPassword($usuario, $pass, $confirm) {

		$TSetControl = new TSetControl();
		$pass = $TSetControl->setPass($pass);
		$confirm = $TSetControl->setPass($confirm);

		if ($pass === $confirm) {

			$dbo = new TDbo(TConstantes :: DBUSUARIOS);
			$crit = new TCriteria();
			$crit->add(new TFilter('codigo', '=', $usuario));
			$update = $dbo->update(array (
				'senha' => $pass
			), $crit);

			return true;
		} else {
			return false;
		}
	}

	//Executa a criação de senha
	public function execCreatePassword($usuario, $new_pass, $confirm) {
		if ($this->createPassword($usuario, $new_pass, $confirm)) {
			$div = new TElement('div');
			$div->class = 'ui-widget-content ui-state-highlight ui-corner-all';
			$div->style = "text-align: center; vertical-align: middle; padding: 10px; font-size: 25px";
			$div->add('<h3>Senha alterada com sucesso.</h3>');
			return $div;
		} else {
			$div = new TElement('div');
			$div->class = 'ui-widget-content ui-state-error ui-corner-all';
			$div->style = "text-align: center; vertical-align: middle; padding: 10px; font-size: 25px";
			$div->add('<h3>Erro na alteração, verifique as senhas passadas.</h3>');
			return $div;
		}
	}

	//Executa a mudança de senha
	public function execChangePassword($usuario, $old_pass, $new_pass, $confirm) {
		if ($this->changePassword($usuario, $old_pass, $new_pass, $confirm)) {
			$div = new TElement('div');
			$div->class = 'ui-widget-content ui-state-highlight ui-corner-all';
			$div->style = "text-align: center; vertical-align: middle; padding: 10px; font-size: 25px";
			$div->add('<h3>Senha alterada com sucesso.</h3>');
			return $div;
		} else {
			$div = new TElement('div');
			$div->class = 'ui-widget-content ui-state-error ui-corner-all';
			$div->style = "text-align: center; vertical-align: middle; padding: 10px; font-size: 25px";
			$div->add('<h3>Erro na alteração, verifique as senhas passadas.</h3>');
			return $div;
		}
	}

	// Interface de mudança de senha
	public function apendicePassword($codigo, $idForm) {
		$dbo = new TDbo(TConstantes :: DBUSUARIOS);
		$crit = new TCriteria();
		$crit->add(new TFilter('codigo', '=', $codigo));
		$ret = $dbo->select('senha', $crit);
		$obSenha = $ret->fetchObject();

		$obFieds = new TSetfields();
		$content = new TElement('div');
		$content->class = "ui_bl_content";

		if ($obSenha->senha) {
			$obFieds->geraCampo("Senha antiga:", 'old_Password', "TPassword", '');
			$obFieds->setProperty('old_Password', 'size', '20');
			$obFieds->setProperty('old_Password', 'id', 'old_Password');
			$obFieds->setValue("old_Password", "");

			$obFieds->geraCampo("Nova Senha:", 'new_Password', "TPassword", '');
			$obFieds->setProperty('new_Password', 'size', '20');
			$obFieds->setProperty('new_Password', 'id', 'new_Password');
			$obFieds->setValue("new_Password", "");

			$obFieds->geraCampo("Confirmação:", 'confirm_Password', "TPassword", '');
			$obFieds->setProperty('confirm_Password', 'size', '20');
			$obFieds->setProperty('confirm_Password', 'id', 'confirm_Password');
			$obFieds->setValue("confirm_Password", "");

			$obButton = new TButton('change_Password');
			$obButton->id = "change_Password";
			$obButton->value = "Atualizar";
			$obButton->setProperty("onclick", "changePassword('{$codigo}','old_Password','new_Password','confirm_Password')");
			$obButton->setAction(new TAction(""), "Atualizar");

			$obFieds->addObjeto($obButton);
		} else {
			$obFieds->geraCampo("Nova Senha:", 'new_Password', "TPassword", '');
			$obFieds->setProperty('new_Password', 'size', '20');
			$obFieds->setProperty('new_Password', 'id', 'new_Password');
			$obFieds->setProperty('new_Password', 'onchange', "createPassword('{$codigo}','new_Password','confirm_Password')");
			$obFieds->setValue("new_Password", "");

			$obFieds->geraCampo("Confirmação:", 'confirm_Password', "TPassword", '');
			$obFieds->setProperty('confirm_Password', 'size', '20');
			$obFieds->setProperty('confirm_Password', 'id', 'confirm_Password');
			$obFieds->setProperty('confirm_Password', 'onchange', "createPassword('{$codigo}','new_Password','confirm_Password')");
			$obFieds->setValue("confirm_Password", "");
		}

		$content->add($obFieds->getConteiner());

		$resposta = new TElement('div');
		$resposta->id = 'password_return';
		$resposta->add('');
		$content->add($resposta);

		return $content;
	}

}