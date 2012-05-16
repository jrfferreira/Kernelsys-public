<?php
/**
 * Declaração da classe para tratamento de erros
 * A classe deve ser extendida da classe Exception do PHP
 */

class setException extends Exception {

	private $msg = "";

	/**
	 * Metodo construtor para tratamento de erro
	 * param <type> $Exeption = mensagem ou objeto Exeption
	 * param <type> $severidade = se o erro vai parar a execução ou não
	 */
	public function __construct($Exeption, $severidade = 1) {

		// Retorna Usuario logado===================================
		// $this->obUser = new TCheckLogin();
		// $this->obUser = $this->obUser->getUser();
		// =========================================================

		// Sobreescrevo as propiedades da classe passando os parametros
		// $this->cod = $cod;

		// trata a exeção
		if (is_object($Exeption) && get_class ( $Exeption ) == "ErrorException") {
			if ($Exeption->getCode ()) {
				$severidade = $Exeption->getCode ();
			}
		}

		$mensagemTratada = is_string ( $Exeption ) ? $Exeption : $this->trataMensagem ( $Exeption );

		// grava o log do erro em um arquivo txt
		$retLog = $this->setLog ( $mensagemTratada );

		// retorna a mensagem de erro
		$corpoMsg = new TElement ( 'span' );
		$corpoMsg->style = "font-size:11px; margin:5px;";
		$corpoMsg->add ( $mensagemTratada );
		// if($retLog) $corpoMsg->add("<br>O sistema <b>PetrusCOM</b> enviou uma
		// mensagem de erro para a equipe técnica da <b>BitUP</b>.<br/>");

		// $corpoMsg->add($Exeption->getFile().' -
		// '.$Exeption->getLine().$Exeption);

		$showMsg = new TMessage ( 'Alerta', $corpoMsg );

		if ($severidade == 1) {
			exit ();
		}
	}

	private function trataMensagem($Exeption) {

		$trace = $Exeption->getTrace ();

		$mensagem = '<p><strong>Erro no sistema</strong><br/>';
		$mensagem .= '<br/><b>Data/Hora</b>: ' . date ( "d/m/Y H:i:s" );
		$mensagem .= '<br/><b>IP</b>: ' . $_SERVER ['REMOTE_ADDR'];

		if ($Exeption->getMessage ())
			$mensagem .= '<br/><b>Mensagem informada pelo Sistema</b>: "' . $Exeption->getMessage () . '";<br/>';

		if ($Exeption->code)
			$mensagem .= '<br/><b>Código</b>: ' . $Exeption->code;
		if ($Exeption->file)
			$mensagem .= '<br/><b>Arquivo</b>: ' . $Exeption->file;
		if ($Exeption->line)
			$mensagem .= '<br/><b>Linha</b>: ' . $Exeption->line;

		$traceList = $Exeption->getTrace ();

		$mensagem .= "<br/><br/><b>Rastreamento</b>:<p><ul>";

		foreach ( $traceList as $ch => $trace ) {
			$mensagem .= "<li> {$ch}) ";
			$start = true;
			if ($trace ['file']){
				if($start){
					$start = false;
				}else{
					$mensagem .= '<br/>';
				}
				$mensagem .= '<b>Arquivo</b>: ' . $trace ['file'];
			}
			if ($trace ['line']){
				if($start){
					$start = false;
				}else{
					$mensagem .= '<br/>';
				}
				$mensagem .= '<b>Linha</b>: ' . $trace ['line'];
			}
			if ($trace ['class']){
				if($start){
					$start = false;
				}else{
					$mensagem .= '<br/>';
				}
				$mensagem .= '<b>Classe</b>: ' . $trace ['class'];
			}
			if ($trace ['function']){
				if($start){
					$start = false;
				}else{
					$mensagem .= '<br/>';
				}
				$mensagem .= '<b>type</b>: ' . $trace ['function'];
			}
			if ($trace ['type']){
				if($start){
					$start = false;
				}else{
					$mensagem .= '<br/>';
				}
				$mensagem .= '<b>type</b>: ' . $trace ['type'];
			}

			if (is_array ( $trace ['args'] ) && count ( $trace ['args'] ) > 0) {
				$mensagem .= '<br/><b>Argumentos</b>: <ul>';
				foreach ( $trace ['args'] as $chave => $valor ) {								
					$mensagem .= $this->trataArgumentoExcessao ( $valor, $chave );

				}
				$mensagem .= '</ul>';
			}

			$mensagem .= "</li>";
		}

		$mensagem .= '<ul></p>';

		return $mensagem;
	}

	protected function trataArgumentoExcessao($argumento, $chave = null) {
		if(is_string($argumento)){
			$msg = '(string) ' . (!empty($chave) ? $chave.' => ' : '') . $argumento;
		}else if(is_bool($argumento)){
			$msg = '(bool) ' . (!empty($chave) ? $chave.' => ' : '') .$argumento;
		}else if(is_bool($argumento)){
			$msg = '(bool) ' . (!empty($chave) ? $chave.' => ' : '') .$argumento;
		}else if(is_numeric($argumento)){
			$msg = '(numeric) ' . (!empty($chave) ? $chave.' => ' : '') .$argumento;
		}else if(is_array($argumento)){
			$msg = '(array) ';
			foreach($argumento as $k => $v){
				$msg .= '    ' . (!empty($chave) ? $chave.' => ' : '') ."<ul>".$this->trataArgumentoExcessao($v,$k)."</ul>";
			}
		}

		return "<li>{$msg}</li>";
	}

	/**
	 * Método grava num log o erro gerado
	 */
	private function setLog($mensagem) {

		// Define o arquivo que será criado ou gravado caso exista
		// Coloco como nome o nome da classe seguido de log e da data de criação
		// do mesmo

		TTransaction::close ();

		$dadosErro ['codigoUser'] = $this->obUser->codigo;
		$dadosErro ['classe'] = $this->file;
		$dadosErro ['msg'] = "" . $this->msg . " - Line: [" . $this->getLine () . "] " . $this->getMessage ();
		$dadosErro ['horaCad'] = date ( "H:i:s" );

		//$TEmail = new TEmail();
		//$TEmail->enviar('jrffer@gmail.com', 'Erro no sistema', $mensagem, false);

		return true;
		// $dboLog = new TDbo(TConstantes::DBUSUARIOS_ERROS);
		// $dboLog->insert($dadosErro);
	}

}