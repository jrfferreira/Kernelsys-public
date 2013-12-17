<?php

/*
 * Classe TChart para Instanciação de Gráficos em forma de imagem
 */

class TChart {

    private $data;
    private $core;
    public $chartName;
    public $dir = "../app.tmp/";
    public $showLegend = true;

    public function __construct($name,$width = '500',$height = '300') {
        $this->dir = "../".TOccupant::getPath()."app.tmp/";

        //Retorna Usuario logado===================================
        $this->obUser = new TCheckLogin();
        $this->obUser = $this->obUser->getUser();
        //=========================================================

        $this->width = $width;
        $this->height = $height;

        $this->data = new TChartData();
        $this->core = new TChartCore($width,$height);
        $X1 = ($width *10/100) > 20 ? ($width *10/100) : 20;
        $Y1 = ($height *10/100) > 20 ? ($height *10/100) : 20;
        $X2 = $width - ($width *20/100);
        $Y2 = $height - ($height *20/100);

        $colors = array('bluetzer','bright','desert','gold_fish','green_soft','hard_blue','hard_tones','orange_soft','tropical');

        $this->core->loadColorPalette('../app.lib/pchart/styles/' . $colors[array_rand($colors)] . '.txt');
        $this->core->setGraphArea($X1, $Y1, $X2, $Y2);
        $this->core->drawGraphArea(255,255,255,TRUE);

        $this->chartName = $name;
        $date = getdate();
        $this->chartId = preg_replace('{\W}', '', preg_replace('{\s}', '',  strtr($name, "áàãâéêíóôõúüçÁÀÃÂÉÊÍÓÔÕÚÜÇ ", "aaaaeeiooouucAAAAEEIOOOUUC_"))) . $date[0];
        $this->serie = 0;
    }

    public function nextSerie(){
        $this->serie = $this->serie + 1;
        return $this->serie;
    }

    public function setAxisName($Y,$X = null){
        $this->data->SetYAxisName($Y);
        if($X) $this->data->SetXAxisName($X);
    }
    public function setAxisUnit($Y,$X = null){
        $this->data->SetYAxisUnit($Y);
        if($X) $this->data->SetXAxisUnit($X);
    }
    /*
     *  - number used by defaults
     *  - time amount of seconds will be displayed as HH:MM:SS
     *  - date unix timestamp will be displayed as a date
     *  - metric number that will be displayed with k/m/g units
     *  - currency currency with custom unit
     */
    public function setAxisFormat($Y = 'number',$X = 'number'){
        $this->data->SetYAxisFormat($Y);
        $this->data->SetXAxisFormat($X);
    }

    public function addLabel($array) {
        $serieid = "{$this->chartId}{$this->nextSerie()}";
        $this->data->AddPoint($array,$serieid);
        //$this->data->SetSerieName('',$serieid);
        $this->labelSerie = $serieid;
        
    }

    public function addPoint($array,$name = null) {
        if(is_array($array)){
        foreach($array as $ch=>$vl){
            $array_checked[$ch] = $array[$ch] ? $array[$ch] : 0 ;
        }
        }else{
             $array_checked[] = $array ? $array : 0 ;
        }
        $serieid = "{$this->chartId}{$this->nextSerie()}";
        $this->data->AddPoint($array_checked,$serieid);
        $this->series[] = $serieid;
        if($name) {
            $this->data->SetSerieName($name,$serieid);
        }
    }

    public function show($type) {
         foreach($this->series as $vl){
            $this->data->AddSerie($vl);
         }
         $this->data->SetAbsciseLabelSerie($this->labelSerie);
         $this->core->setFontProperties("../".TOccupant::getPath()."app.files/Fonts/tahoma.ttf",8);

         $type = strtolower($type);

        if ($type == '3dpie') {
            $this->core->drawPieGraph($this->data->GetData(), $this->data->GetDataDescription(), ($this->width * 45/100), ($this->height * 45/100), ($this->height * 30/100), PIE_PERCENTAGE_LABEL, FALSE,80,10,3);
            if($this->showLegend) $this->core->drawPieLegend(($this->width * 82/100), ($this->height * 10/100), $this->data->GetData(), $this->data->GetDataDescription(), 250, 250, 250);

        } elseif ($type == 'pie') {
            $this->core->drawBasicPieGraph($this->data->GetData(), $this->data->GetDataDescription(), ($this->width * 45/100), ($this->height * 45/100), ($this->height * 30/100), PIE_PERCENTAGE, FALSE);
            if($this->showLegend) $this->core->drawPieLegend(($this->width * 82/100), ($this->height * 10/100), $this->data->GetData(), $this->data->GetDataDescription(), 250, 250, 250);
  
        } elseif ($type == 'bar') {
             $this->core->drawScale($this->data->GetData(),$this->data->GetDataDescription(),SCALE_NORMAL,150,150,150,TRUE,0,2,TRUE);
             $this->core->drawGrid(4,TRUE,230,230,230,50);
             $this->core->setFontProperties("../".TOccupant::getPath()."app.files/Fonts/tahoma.ttf",6);
             $this->core->setShadowProperties();
             $this->core->drawBarGraph($this->data->GetData(),$this->data->GetDataDescription(),TRUE,80);
             $this->core->clearShadow();
             $this->core->setFontProperties("../".TOccupant::getPath()."app.files/Fonts/tahoma.ttf",10);
             $this->core->writeValues($this->data->GetData(),$this->data->GetDataDescription(),$this->series);
             if($this->showLegend) $this->core->drawLegend(($this->width * 82/100), ($this->height * 10/100),$this->data->GetDataDescription(),255,255,255);


        } elseif ($type == 'uniquebar') {
             $this->core->drawScale($this->data->GetData(),$this->data->GetDataDescription(),SCALE_ADDALL,150,150,150,TRUE,0,2,TRUE);
             $this->core->drawGrid(4,TRUE,230,230,230,50);
             $this->core->setFontProperties("../".TOccupant::getPath()."app.files/Fonts/tahoma.ttf",6);
             $this->core->setShadowProperties(3,3,0,0,0,10,4);
             $this->core->drawStackedBarGraph($this->data->GetData(),$this->data->GetDataDescription(),FALSE);
             $this->core->clearShadow();
             $this->core->setFontProperties("../".TOccupant::getPath()."app.files/Fonts/tahoma.ttf",10);
             $this->core->writeValues($this->data->GetData(),$this->data->GetDataDescription(),$this->series);
             if($this->showLegend) $this->core->drawLegend(($this->width * 82/100), ($this->height * 10/100),$this->data->GetDataDescription(),255,255,255);

        } elseif ($type == 'line') {
             $this->core->drawScale($this->data->GetData(),$this->data->GetDataDescription(),SCALE_NORMAL,150,150,150,TRUE,0,2,TRUE);
             $this->core->drawGrid(4,TRUE,230,230,230,50);
             $this->core->setFontProperties("../".TOccupant::getPath()."app.files/Fonts/tahoma.ttf",6);
             $this->core->setShadowProperties(3,3,0,0,0,10,4);
             $this->core->drawLineGraph($this->data->GetData(),$this->data->GetDataDescription(),TRUE,80);
             $this->core->clearShadow();
             $this->core->drawPlotGraph($this->data->GetData(),$this->data->GetDataDescription(),3,2,255,255,255);
             $this->core->setFontProperties("../".TOccupant::getPath()."app.files/Fonts/tahoma.ttf",10);
             $this->core->writeValues($this->data->GetData(),$this->data->GetDataDescription(),$this->series);
             if($this->showLegend) $this->core->drawLegend(($this->width * 82/100), ($this->height * 10/100),$this->data->GetDataDescription(),255,255,255);
            
        }
            $this->core->drawTreshold(0,143,55,72,TRUE,TRUE);
            $this->core->setFontProperties("../".TOccupant::getPath()."app.files/Fonts/tahoma.ttf",11);
            $xT = ($this->width * 10/100);
            $yT = ($this->height * 75/100) > 13 ? $this->height * 7/100 : 12;
            $this->core->drawTitle($xT, $yT, $this->chartName, 100, 100, 100);

        $archive = "{$this->dir}{$this->chartId}_{$this->obUser->seq}.png";
        $this->core->Render($archive);

        $img = new TElement('img');
        $img->src = $archive;

        return $img;
    }

}