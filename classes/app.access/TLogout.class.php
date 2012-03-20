<?php

class TLogout{

	public function __construct($occupant = null){
		
		include_once('../app.widgets/TSession.class.php');

                //$occupant = TOccupant::getPath();

		$this->obsession = new TSession();
		$this->obsession->freeSession();
		/*
		echo '<div align="center" style=" margin:60px; border:10px double #0033CC; padding:10px; color:#FFFFFF; font-size:24px; text-align:center;">
				Sess&atilde;o encerrada com sucesso em '.date(d."/".m."/".Y).' as '.date(H.":".i.":".s).'
			</div>
			<div align="center">
			<input type="button" name="log" id="log" onClick="location.href=\'../app.view/index.php?occupant='.$occupant.'\'" value="Voltar a tela de login" style="font-size:14px; padding:8px;">
			</div>';

*/
                if($occupant) $occupant = '?occupant=' . $occupant;
		echo '<script language="JavaScript">location.href="../app.view/'.$occupant.'";</script>';
	
	}
}

new TLogout($_GET['occupant']);