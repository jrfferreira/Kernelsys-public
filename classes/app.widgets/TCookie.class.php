<?php
/***************************************************************************
Classe que gerencia cookies
Vers�o: v001
Data: 05/05/2008
Data de altualização: --/--/----
Programador: Wagner Borba
****************************************************************************/

final class TCookie{

	/*
	*Adiciona cookies
	*paran		$nome = nome do cookie
	*paran 		$valor = valor a ser armazenado no cookie
	*/
	public function addCookie($nome, $value){
		setcookie($nome, $value, time()+43200);
	}
	
	/*
	*
	*
	*/
	public function delCookie($nome){
		setcookie($nome, '', time()-43200);
	}

}