<?php
//=====================================================
// Calcula datas
//
//=====================================================


final class TSetData{

    /**
     * soma data com n dias
     * param $arg = data base do calculo no formato padrão do DB
     * param $fat = Se a data for fixa o fator sera somado ao mês, se não sera somado ao dia
     * param $sp = Separador usado na data no campo base
     * param $dfix = boleano - define dia do vencimento fixo
     * return $RetData = Retorna a data formatada no padrão do banco [0000-00-00]
     */

	static public function calcData($arg, $fat, $sp, $dfix = NULL){
		
		$pts = explode($sp,$arg);
		if($dfix){
			$tp = mktime(0,0,0,($pts[1]+$fat),$dfix,$pts[0]);
		}else{
			$tp = mktime(0,0,0,$pts[1],($pts[2]+$fat),$pts[0]);
		}
		$RetData = strftime("%Y-%m-%d",$tp);
		
		return $RetData;
	}
	
    /**
     * subtrai data com n dias
     * param <type> $arg
     * param <type> $fat
     * param <type> $sp
     * return <type> 
     */
	static public function subData($arg,$fat,$sp){
		
		$pts = explode($sp,$arg);
			$tp = mktime(0,0,0,$pts[1],$pts[2]-$fat,$pts[0]);
		$RetData = strftime("%Y-%m-%d",$tp);
		
		return $RetData;
	}
	
	/*
	 * retorna data atual padrão internacional.
	 */
	static public function getData(){
		$data = date(Y."-".m."-".d);
		return $data;
	}
	
	/*
	 * retorna data atual padrão brasileiro.
	 */
	static public function getDataPT(){
		$data = date(d."/".m."/".Y);
		return $data;
	}

	//retorna mes/ano Atual
	static public function getMesAnoSeguinte(){
		$data = date(m."/".Y);
		return $data;
	}
	
	// Valida data em formato e data anteiro a atual \\
	static public function ValData($arg,$sp,$msg,$nv){
		if($pts = explode($sp,$arg) and $arg!=""){
		
			if(!checkdate($pts[1],$pts[2],$pts[0])){
				echo '<script> alertPetrus("'.$msg.' ('.$arg.')"); </script>';
			}
			if($nv==1){
				$cDat=($pts[2].$pts[1].$pts[0])-(date(Y.''.m.''.d));
				if($cDat<0){
					echo '<script> alertPetrus("Data menor que a data atual não permitida para este campo. ('.$arg.')"); </script>';
				}
			}
		}	
		
	}
	
	//calcula intervalo entre datas
	// param1 = data inicial
	// param2 = data final
	public function setIntervalo($data1, $data2){
		if($data1 != "" and $data2 != ""){
			
			$vd1 = explode('/', $data1);
			$vd2 = explode('/', $data2);
			$tp1 = mktime(0, 0, 0, $vd1[1], $vd1[0], $vd1[2]);
			$tp2 = mktime(0, 0, 0, $vd2[1], $vd2[0], $vd2[2]);
			
			$dias = ($tp2 - $tp1)/86400;

            //Valida data a ser amazenada na base de dados e converte para o padrão ====
            if(preg_match("/(([0-2])?(0-9)|(3)([0-1]))\/(([0-9])|10|11|12)\/([0-9]{4})/", $data1)){
                $newData = explode('/',$data1);
                $data1 =  "$newData[2]-$newData[1]-$newData[0]";
            }
            //==========================================================================
			
			$retData[0] = $data1;
			$x = 1;
			for($dias = $dias-1; $dias > 0 ; $dias--){
				
				$retData[$x] = $this->calcData($retData[$x-1], 1, '-');
				$x++;
			}
			
			return $retData;
		}
		else{
			exit('Datas inválidas!');
		}
	}
			//retorna data atual sem o ano
	static public function getDataSemAno(){
		$dataSemAno = date(m."-".d);
		return $dataSemAno;
	}
	//retorna data sem o ano
	static public function getAniverSemAno($dt){
		$ano = substr($dt, -4);
		$mes = substr($dt,3,2);
		$dia = substr($dt,0,2);
		$data = $dia."/".$mes;

		if ($data == "/"){
			$dataS = "-- / --";
			return $dataS;
		}else{
			return $data;
		}
	}
	static public function getDataSemDiaAno(){
		$dataSemAno = date("-".m."-");
		return $dataSemAno;
	}
	
	//retorna data em formato global
	public function dataPadrao($data){
		
		$ano = substr($data, -4);
		$mes = substr($data,3,2);
		$dia = substr($data,0,2);
		
		$dataFormatPadrao = $ano."-".$mes."-".$dia;
		
		return $dataFormatPadrao;
	
	}

    //retorna data no pad�o portugues
	public function dataPadraoPT($data){

		$dia = substr($data, -2);
		$mes = substr($data,5,2);
		$ano = substr($data,0,4);

		$dataFormatPadrao = $dia."/".$mes."/".$ano;

		return $dataFormatPadrao;

	}
	//retorna o nome do mes em portugues
	public function setMes($n, $tipo = NULL){
		
		if($tipo){
			switch($n){
				case 1: $nmes = "Jan";
				break;
				case 2: $nmes = "Fev";
				break;
				case 3: $nmes = "Mar";
				break;
				case 4: $nmes = "Abr";
				break;
				case 5: $nmes = "Mai";
				break;
				case 6: $nmes = "Jun";
				break;
				case 7: $nmes = "Jul";
				break;
				case 8: $nmes = "Ago";
				break;
				case 9: $nmes = "Set";
				break;
				case 10: $nmes = "Out";
				break;
				case 11: $nmes = "Nov";
				break;
				case 12: $nmes = "Dez";
				break;
			}
		}else{
			switch($n){
				case 1: $nmes = "Janeiro";
				break;
				case 2: $nmes = "Fevereiro";
				break;
				case 3: $nmes = "Março";
				break;
				case 4: $nmes = "Abril";
				break;
				case 5: $nmes = "Maio";
				break;
				case 6: $nmes = "Junho";
				break;
				case 7: $nmes = "Julho";
				break;
				case 8: $nmes = "Agosto";
				break;
				case 9: $nmes = "Setembro";
				break;
				case 10: $nmes = "Outubro";
				break;
				case 11: $nmes = "Novembro";
				break;
				case 12: $nmes = "Dezembro";
				break;
			}
		}
		
		return $nmes;
	}

        static public function getDiaSemana($arg){

		$pts = explode("-",$arg);
			$tp = mktime(0,0,0,$pts[1],$pts[2],$pts[0]);
		$RetData = strftime("%w",$tp);

		return $RetData;
	}

   function setUltimoDiaMes($data = null){
    if (!$data) {
       $dia = date("d");
       $mes = date("m");
       $ano = date("Y");
    } else {
       $dia = date("d",$data);
       $mes = date("m",$data);
       $ano = date("Y",$data);
    }
    $data = mktime(0, 0, 0, $mes, 1, $ano);
    return date("d",$data-1);
  }

}

//$ob = new TSetData();
//print_r($ob->setIntervalo('20/03/2009', '20/04/2009'));

?>