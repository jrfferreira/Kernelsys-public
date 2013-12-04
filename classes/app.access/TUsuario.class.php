<?php


/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class TUsuario {

	public $user = null;

	public function __construct() {
		$check = new TCheckLogin();
		$this->usuario = $check->getUser();
	}

	public function getUser($seq= null) {
		try {
			if ($seq&& $seq!= '') {

				$TDbo_user = new TDbo(TConstantes :: DBUSUARIO);
				$crit_user = new TCriteria();
				$crit_user->add(new TFilter(TConstantes::SEQUENCIAL, '=', $seq, 'numeric'));
				$retUser = $TDbo_user->select("*", $crit_user);
				$obUser = $retUser->fetchObject();

				if ($obUser->seq) {
					return $obUser;
				} else {
					throw new ErrorException("Usuário inexistente.");
				}
			} else {
				return $this->usuario;
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
	public function getSeqUsuario() {
		$usuario = $this->usuario;
		$seq= $usuario->usuaseq;
		return $seq;
	}

	/**
	 *
	 * return <type>
	 */
	public function getSeqPessoa() {
		$usuario = $this->usuario;
		$seq= $usuario->pessseq;
		return $seq;
	}

	/**
	 *
	 * return <type>
	 */
	public function getSeqFuncionario() {

		$usuario = $this->usuario;
		if($usuario && !$usuario->funcseq){
			$dbo = new TDbo(TConstantes::DBFUNCIONARIO);
			$criteria = new TCriteria();
			$criteria->add(new TFilter('pessseq', '=', $usuario->pessseq, 'numeric'));
			$ret = $dbo->select('seq',$criteria);
			$obRet = $ret->fetchObject();
			$this->usuario->funcseq = $obRet->seq;
		}
		$seq= $usuario->funcseq;
		return $seq;
	}

	/**
	 *
	 * return <type>
	 */
	public function getSeqProfessor() {

		$usuario = $this->usuario;
		if($usuario && !$usuario->profseq){
			$dbo = new TDbo(TConstantes::DBPROFESSOR);
			$criteria = new TCriteria();
			$criteria->add(new TFilter('pessseq', '=', $usuario->pessseq, 'numeric'));
			$ret = $dbo->select('seq',$criteria);
			$obRet = $ret->fetchObject();
			$this->usuario->profseq = $obRet->seq;
		}
		$seq = $usuario->profseq;
		return $seq;
	}

	/**
	 *
	 * return <type>
	 */
	public function getSeqAluno() {

		$usuario = $this->usuario;
		if($usuario && !$usuario->alunseq){
			$dbo = new TDbo(TConstantes::DBALUNO);
			$criteria = new TCriteria();
			$criteria->add(new TFilter('pessseq', '=', $usuario->pessseq, 'numeric'));
			$ret = $dbo->select('seq',$criteria);
			$obRet = $ret->fetchObject();
			$this->usuario->alunseq = $obRet->seq;
		}
		$seq= $usuario->alunseq;
		return $seq;
	}

	/**
	 *
	 * param <type> $pessseq
	 * param <type> $login
	 * param <type> $senha
	 * param <type> $temaseq
	 * return <type>
	 */
	public function setUsuario($pessseq, $login, $senha, $temaseq = null) {
		try {
			if ($temaseq == null) {
				$temaseq = 17;
			}
			if ($pessseq) {

				$TDbo = new TDbo(TConstantes :: DBUSUARIO);
				$TPessoa = new TPessoa();
				$obPessoa = $TPessoa->getPessoa($pessseq);
				if ($obPessoa->seq) {

					$crit = new TCriteria();
					$crit->add(new TFilter('pessseq', '=', $pessseq));
					$TDbo = new TDbo(TConstantes :: DBUSUARIO);
					$retUser = $TDbo->select("usuario", $crit);
					$obUser = $retUser->fetchObject();

					//if($obUser->usuario) {
					//    throw new ErrorException("Já existe um usuário cadastrado para esta pessoa. Usuário: ".$obUser->usuario);
					//}else {
					if ($obUser->usuario == null) {
						$login = trim($login);
						$critUserName = new TCriteria();
						$critUserName->add(new TFilter('usuario', '=', $login));
						$TDbo = new TDbo(TConstantes :: DBUSUARIO);
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

						$dt['pessseq'] = $pessseq;
						$dt['classeuser'] = 1;
						$dt['usuario'] = $login;
						$dt['senha'] = $senha;
						$dt['statseq'] = '1';
						$dt['temaseq'] = $temaseq;

						$TDbo = new TDbo(TConstantes :: DBUSUARIO);
						$insert = $TDbo->insert($dt);
						$insert['usuario'] = $login;
						return $insert;
					}
				} else {
					throw new ErrorException("O seq de pessoa $pessseq é inexistente.");
				}
			} else {
				throw new ErrorException("O seq de pessoa $pessseq é invalido.");
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
								$critCheck3->add(new TFilter("funcionalidade", "=", $funcionalidade, 'numeric'));
								$critCheck3->add(new TFilter("nivel", "=", $nivel, 'numeric'));
								$critCheck3->add(new TFilter("modulo", "=", $modulo, 'numeric'));
								$critCheck3->add(new TFilter("usuaseq", "=", $usuario, 'numeric'));
							$TDbo_privilegio = new TDbo(TConstantes :: DBUSUARIO_PRIVILEGIO);
							$retHierarquia = $TDbo_privilegio->select("seq", $critCheck3);
							$obHierarquia = $retHierarquia->fetchObject();
							
							if ($obHierarquia->seq == null) {

								$dtModulo["nivel"] = $nivel;
								$dtModulo["funcionalidade"] = $funcionalidade;
								$dtModulo["modulo"] = $modulo;
								$dtModulo["usuaseq"] = $usuario;
								$dtModulo['statseq'] = '1';

								$TDbo_privilegio = new TDbo(TConstantes :: DBUSUARIO_PRIVILEGIO);

								$retorno = $TDbo_privilegio->insert($dtModulo);
								
								$TDbo_privilegio->close();
							}
							$retorno["nivel"] = $nivel;
							$retorno["funcionalidade"] = $funcionalidade;
							$retorno["modulo"] = $modulo;
							$retorno["usuaseq"] = $usuario;

							$dSituacao['statseq'] = $situacao;

							$dSituacaoCrit = new TCriteria();
							$dSituacaoCrit->add(new TFilter("funcionalidade", "=", $funcionalidade, 'numeric'));
							$dSituacaoCrit->add(new TFilter("nivel", "=", $nivel, 'numeric'));
							$dSituacaoCrit->add(new TFilter("modulo", "=", $modulo, 'numeric'));
							$dSituacaoCrit->add(new TFilter("usuaseq", "=", $usuario, 'numeric'));

							$TDbo_Situacao = new TDbo(TConstantes :: DBUSUARIO_PRIVILEGIO);
							$retornoSituacao = $TDbo_Situacao->update($dSituacao, $dSituacaoCrit);
							
							$TDbo_Situacao->close();

							return $retorno;
						} else {
							throw new ErrorException("O modulo $modulo é invalido.");
						}
					} else {
						throw new ErrorException("O menu $menu é invalido.");
					}
				} else {
					throw new ErrorException("O seq do usuario $usuario é invalido.");
				}
			} else {
				throw new ErrorException("O seq do usuario $usuario é invalido.");
			}
		} catch (Exception $e) {
			new setException($e);
		}
	}

	/**
	 * 
	 * @param unknown_type $usuario
	 */
	public function getPrivilegios($usuario) {
		try {
			if ($usuario) {
				$rt = $this->getUser($usuario);
				if ($rt) {
					$crit = new TCriteria();
					$crit->add(new TFilter("usuaseq", "=", $usuario, 'numeric'));
					$TDbo_privilegio = new TDbo(TConstantes :: DBUSUARIO_PRIVILEGIO);
					$retPrivilegio = $TDbo_privilegio->select("*", $crit);

					while ($obPrivilegio = $retPrivilegio->fetchObject()) {
						$ob[$obPrivilegio->nivel][$obPrivilegio->funcionalidade][$obPrivilegio->modulo][$obPrivilegio->statseq] = $obPrivilegio;
					}
					return $ob;
				} else {
					throw new ErrorException("O seq do usuario $usuario é invalido.");
				}
			} else {
				throw new ErrorException("O seq do usuario $usuario é invalido.");
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
			$dbo = new TDbo(TConstantes :: DBUSUARIO);
			$crit = new TCriteria();
			$crit->add(new TFilter(TConstantes::SEQUENCIAL, '=', $usuario, 'numeric'));
			$ret = $dbo->select('senha', $crit);
			$obSenha = $ret->fetchObject();

			if ($obSenha->senha === $old_pass) {
				$update = $dbo->update(array (
					'senha' => $new_pass
				), $crit);

				if ($update) {
					$dbo->commit();
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

		$dbo = new TDbo(TConstantes :: DBUSUARIO_SENHAS_RECUPERACAO);
		$crit = new TCriteria();
		$crit->add(new TFilter('chave', '=', $chave, 'numeric'));
		$ret = $dbo->select('usuaseq,senhaantiga', $crit);
		$obChave = $ret->fetchObject();

		$TSetControl = new TSetControl();
		$new_pass = $TSetControl->setPass($new_pass);
		$confirm = $TSetControl->setPass($confirm);

		if ($new_pass === $confirm) {
			$dbo = new TDbo(TConstantes :: DBUSUARIO);
			$crit = new TCriteria();
			$crit->add(new TFilter(TConstantes::SEQUENCIAL, '=', $obChave->usuaseq, 'numeric'));
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
	public function requestRecoverPassword($seqUsuario){
		
		$dbo = new TDbo(TConstantes :: DBUSUARIO);
		$crit = new TCriteria();
		$crit->add(new TFilter(TConstantes::SEQUENCIAL, '=', $seqUsuario, 'numeric'));
		$ret = $dbo->select('senha', $crit);
		$obSenha = $ret->fetchObject();
		
		$old_pass = $obSenha->senha;
	
		if(!empty($old_pass)){
			$TSetControl = new TSetControl();
			$chave = $TSetControl->setPass(md5(rand(1,99) . $seqUsuario . time() . 'recoverPass'));
		
			$dbo = new TDbo(TConstantes :: DBUSUARIO_SENHAS_RECUPERACAO);
		
			$retorno = $dbo->insert(array('senhaantiga'=>$old_pass,
							   'usuaseq'=>$seqUsuario,
							   'chave'=>$chave));
							   
			if(is_array($retorno) && $retorno[TConstantes::SEQUENCIAL]){
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

			$dbo = new TDbo(TConstantes :: DBUSUARIO);
			$crit = new TCriteria();
			$crit->add(new TFilter(TConstantes::SEQUENCIAL, '=', $usuario, 'numeric'));
			$update = $dbo->update(array (
				'senha' => $pass
			), $crit);
			
			$dbo->commit();

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
	public function apendicePassword($seq, $formseq = null) {
		$dbo = new TDbo(TConstantes :: DBUSUARIO);
		$crit = new TCriteria();
		$crit->add(new TFilter(TConstantes::SEQUENCIAL, '=', $seq, 'numeric'));
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
			$obButton->setProperty("onclick", "changePassword('{$seq}','old_Password','new_Password','confirm_Password')");
			$obButton->setAction(new TAction(""), "Atualizar");

			$obFieds->addObjeto($obButton);
		} else {
			$obFieds->geraCampo("Nova Senha:", 'new_Password', "TPassword", '');
			$obFieds->setProperty('new_Password', 'size', '20');
			$obFieds->setProperty('new_Password', 'id', 'new_Password');
			$obFieds->setProperty('new_Password', 'onchange', "createPassword('{$seq}','new_Password','confirm_Password')");
			$obFieds->setValue("new_Password", "");

			$obFieds->geraCampo("Confirmação:", 'confirm_Password', "TPassword", '');
			$obFieds->setProperty('confirm_Password', 'size', '20');
			$obFieds->setProperty('confirm_Password', 'id', 'confirm_Password');
			$obFieds->setProperty('confirm_Password', 'onchange', "createPassword('{$seq}','new_Password','confirm_Password')");
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