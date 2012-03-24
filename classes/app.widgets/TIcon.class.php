<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

class TIcon{


    public function __construct($tipo, $id = "Icon_",$class = null){
       $this->tipo = $tipo;
       $this->id = $id;
       $this->editable = true;
       $this->classBox = "ui-state-default";
       $this->extraClass = $class;
    }

     /*
     * configura ação do icone
     */
    public function setAction($action, $func = NULL){

        if(is_object($action) && get_class($action) == "TSetAction"){
            $action = $action->getAction();
        }

        if(is_object($action) and get_class($action) == "TAction"){
            $this->action = $action->serialize();
        }else{
            $this->action = $action;

            if($func){
                $this->action = $this->action.'="'.$this->func = $func.'"';
            }
        }
    }
    
    /*
     * configura titulo (alt)
     */
    public function setTitle($title){
        $this->title = $title;
    }

    /*
     * desabilita icon
     */
    public function setEditable($editable = true){
        $this->editable = $editable;
        if($this->editable == false){
            $this->classDisabled = "ui-widget-content";//"ui_campo_disabled";//"iconDisabled";
        }
    }

    /*
     * configura box padrão
     */
     public function setBox($classBox = "ui-state-active"){
         $this->classBox = $classBox;
     }

    /*
     * retorna icone formatado
     */
    public function show(){

             $bot1 = new TElement('span');
             $bot1->id = "bot".$this->id;
             $bot1->class = "ui-icon ".$this->tipo;
             $bot1->add('');

             $bot = new TElement('span');
             $bot->ligado = 'true';
             $bot->id = $this->id;
             if($this->editable){
                if($this->action){
                    if($this->func){
                        $bot->$this->action;
                    }else{
                        $bot->onclick = $this->action;
                    }
                }
             }
             else{
                $this->classBox = "";
             }
             $bot->title = $this->title;
             $bot->class = "button icons ui-corner-all ".$this->classBox." ".$this->classDisabled.' '.$this->extraClass;
             $bot->add($bot1);

         $bot->show();
    }


    public function setConst(){

		$tipo[] = "ui-icon-carat-1-n";
        $tipo[] = "ui-icon-carat-1-ne";
        $tipo[] = "ui-icon-carat-1-e" ;
        $tipo[] = "ui-icon-carat-1-se" ;
        $tipo[] = "ui-icon-carat-1-s" ;
        $tipo[] = "ui-icon-carat-1-sw" ;
        $tipo[] = "ui-icon-carat-1-w" ;
        $tipo[] = "ui-icon-carat-1-nw" ;
        $tipo[] = "ui-icon-carat-2-n-s" ;
        $tipo[] = "ui-icon-carat-2-e-w" ;
        $tipo[] = "ui-icon-triangle-1-n" ;
        $tipo[] = "ui-icon-triangle-1-ne" ;
        $tipo[] = "ui-icon-triangle-1-e" ;
        $tipo[] = "ui-icon-triangle-1-se" ;
        $tipo[] = "ui-icon-triangle-1-s" ;
        $tipo[] = "ui-icon-triangle-1-sw" ;
        $tipo[] = "ui-icon-triangle-1-w" ;
        $tipo[] = "ui-icon-triangle-1-nw" ;
        $tipo[] = "ui-icon-triangle-2-n-s" ;
        $tipo[] = "ui-icon-triangle-2-e-w" ;
        $tipo[] = "ui-icon-arrow-1-n" ;
        $tipo[] = "ui-icon-arrow-1-ne" ;
        $tipo[] = "ui-icon-arrow-1-e" ;
        $tipo[] = "ui-icon-arrow-1-se" ;
        $tipo[] = "ui-icon-arrow-1-s" ;
        $tipo[] = "ui-icon-arrow-1-sw" ;
        $tipo[] = "ui-icon-arrow-1-w" ;
        $tipo[] = "ui-icon-arrow-1-nw" ;
        $tipo[] = "ui-icon-arrow-2-n-s" ;
        $tipo[] = "ui-icon-arrow-2-ne-sw";
        $tipo[] = "ui-icon-arrow-2-e-w" ;
        $tipo[] = "ui-icon-arrow-2-se-nw";
        $tipo[] = "ui-icon-arrowstop-1-n" ;
        $tipo[] = "ui-icon-arrowstop-1-e" ;
        $tipo[] = "ui-icon-arrowstop-1-s" ;
        $tipo[] = "ui-icon-arrowstop-1-w" ;
        $tipo[] = "ui-icon-arrowthick-1-n" ;
        $tipo[] = "ui-icon-arrowthick-1-ne" ;
        $tipo[] = "ui-icon-arrowthick-1-e" ;
        $tipo[] = "ui-icon-arrowthick-1-se" ;
        $tipo[] = "ui-icon-arrowthick-1-s" ;
        $tipo[] = "ui-icon-arrowthick-1-sw" ;
        $tipo[] = "ui-icon-arrowthick-1-w" ;
        $tipo[] = "ui-icon-arrowthick-1-nw" ;
        $tipo[] = "ui-icon-arrowthick-2-n-s" ;
        $tipo[] = "ui-icon-arrowthick-2-ne-sw";
        $tipo[] = "ui-icon-arrowthick-2-e-w" ;
        $tipo[] = "ui-icon-arrowthick-2-se-nw";
        $tipo[] = "ui-icon-arrowthickstop-1-n" ;
        $tipo[] = "ui-icon-arrowthickstop-1-e" ;
        $tipo[] = "ui-icon-arrowthickstop-1-s" ;
        $tipo[] = "ui-icon-arrowthickstop-1-w" ;
        $tipo[] = "ui-icon-arrowreturnthick-1-w";
        $tipo[] = "ui-icon-arrowreturnthick-1-n" ;
        $tipo[] = "ui-icon-arrowreturnthick-1-e" ;
        $tipo[] = "ui-icon-arrowreturnthick-1-s" ;
        $tipo[] = "ui-icon-arrowreturn-1-w" ;
        $tipo[] = "ui-icon-arrowreturn-1-n" ;
        $tipo[] = "ui-icon-arrowreturn-1-e" ;
        $tipo[] = "ui-icon-arrowreturn-1-s" ;
        $tipo[] = "ui-icon-arrowrefresh-1-w" ;
        $tipo[] = "ui-icon-arrowrefresh-1-n" ;
        $tipo[] = "ui-icon-arrowrefresh-1-e" ;
        $tipo[] = "ui-icon-arrowrefresh-1-s" ;
        $tipo[] = "ui-icon-arrow-4" ;
        $tipo[] = "ui-icon-arrow-4-diag";
        $tipo[] = "ui-icon-extlink" ;
        $tipo[] = "ui-icon-newwin" ;
        $tipo[] = "ui-icon-refresh" ;
        $tipo[] = "ui-icon-shuffle" ;
        $tipo[] = "ui-icon-transfer-e-w";
        $tipo[] = "ui-icon-transferthick-e-w" ;
        $tipo[] = "ui-icon-folder-collapsed" ;
        $tipo[] = "ui-icon-folder-open" ;
        $tipo[] = "ui-icon-document" ;
        $tipo[] = "ui-icon-document-b";
        $tipo[] = "ui-icon-note" ;
        $tipo[] = "ui-icon-mail-closed";
        $tipo[] = "ui-icon-mail-open" ;
        $tipo[] = "ui-icon-suitcase" ;
        $tipo[] = "ui-icon-comment" ;
        $tipo[] = "ui-icon-person" ;
        $tipo[] = "ui-icon-print" ;
        $tipo[] = "ui-icon-trash" ;
        $tipo[] = "ui-icon-locked" ;
        $tipo[] = "ui-icon-unlocked";
        $tipo[] = "ui-icon-bookmark" ;
        $tipo[] = "ui-icon-tag" ;
        $tipo[] = "ui-icon-home" ;
        $tipo[] = "ui-icon-flag" ;
        $tipo[] = "ui-icon-calculator";
        $tipo[] = "ui-icon-cart" ;
        $tipo[] = "ui-icon-pencil";
        $tipo[] = "ui-icon-clock" ;
        $tipo[] = "ui-icon-disk" ;
        $tipo[] = "ui-icon-calendar";
        $tipo[] = "ui-icon-zoomin" ;
        $tipo[] = "ui-icon-zoomout" ;
        $tipo[] = "ui-icon-search" ;
        $tipo[] = "ui-icon-wrench" ;
        $tipo[] = "ui-icon-gear" ;
        $tipo[] = "ui-icon-heart" ;
        $tipo[] = "ui-icon-star" ;
        $tipo[] = "ui-icon-link" ;
        $tipo[] = "ui-icon-cancel";
        $tipo[] = "ui-icon-plus" ;
        $tipo[] = "ui-icon-plusthick";
        $tipo[] = "ui-icon-minus" ;
        $tipo[] = "ui-icon-minusthick";
        $tipo[] = "ui-icon-close" ;
        $tipo[] = "ui-icon-closethick";
        $tipo[] = "ui-icon-key" ;
        $tipo[] = "ui-icon-lightbulb";
        $tipo[] = "ui-icon-scissors" ;
        $tipo[] = "ui-icon-clipboard" ;
        $tipo[] = "ui-icon-copy" ;
        $tipo[] = "ui-icon-contact";
        $tipo[] = "ui-icon-image" ;
        $tipo[] = "ui-icon-video" ;
        $tipo[] = "ui-icon-script" ;
        $tipo[] = "ui-icon-alert" ;
        $tipo[] = "ui-icon-info" ;
        $tipo[] = "ui-icon-notice";
        $tipo[] = "ui-icon-help" ;
        $tipo[] = "ui-icon-check" ;
        $tipo[] = "ui-icon-bullet" ;
        $tipo[] = "ui-icon-radio-off";
        $tipo[] = "ui-icon-radio-on" ;
        $tipo[] = "ui-icon-pin-w" ;
        $tipo[] = "ui-icon-pin-s" ;
        $tipo[] = "ui-icon-play" ;
        $tipo[] = "ui-icon-pause" ;
        $tipo[] = "ui-icon-seek-next";
        $tipo[] = "ui-icon-seek-prev" ;
        $tipo[] = "ui-icon-seek-end" ;
        $tipo[] = "ui-icon-seek-first";
        $tipo[] = "ui-icon-stop" ;
        $tipo[] = "ui-icon-eject" ;
        $tipo[] = "ui-icon-volume-off";
        $tipo[] = "ui-icon-volume-on" ;
        $tipo[] = "ui-icon-power" ;
        $tipo[] = "ui-icon-signal-diag";
        $tipo[] = "ui-icon-signal" ;
        $tipo[] = "ui-icon-battery-0" ;
        $tipo[] = "ui-icon-battery-1" ;
        $tipo[] = "ui-icon-battery-2" ;
        $tipo[] = "ui-icon-battery-3" ;
        $tipo[] = "ui-icon-circle-plus" ;
        $tipo[] = "ui-icon-circle-minus" ;
        $tipo[] = "ui-icon-circle-close" ;
        $tipo[] = "ui-icon-circle-triangle-e" ;
        $tipo[] = "ui-icon-circle-triangle-s" ;
        $tipo[] = "ui-icon-circle-triangle-w" ;
        $tipo[] = "ui-icon-circle-triangle-n";
        $tipo[] = "ui-icon-circle-arrow-e" ;
        $tipo[] = "ui-icon-circle-arrow-s" ;
        $tipo[] = "ui-icon-circle-arrow-w" ;
        $tipo[] = "ui-icon-circle-arrow-n" ;
        $tipo[] = "ui-icon-circle-zoomin" ;
        $tipo[] = "ui-icon-circle-zoomout";
        $tipo[] = "ui-icon-circle-check" ;
        $tipo[] = "ui-icon-circlesmall-plus" ;
        $tipo[] = "ui-icon-circlesmall-minus" ;
        $tipo[] = "ui-icon-circlesmall-close" ;
        $tipo[] = "ui-icon-squaresmall-plus" ;
        $tipo[] = "ui-icon-squaresmall-minus" ;
        $tipo[] = "ui-icon-squaresmall-close" ;
        $tipo[] = "ui-icon-grip-dotted-vertical" ;
        $tipo[] = "ui-icon-grip-dotted-horizontal" ;
        $tipo[] = "ui-icon-grip-solid-vertical" ;
        $tipo[] = "ui-icon-grip-solid-horizontal" ;
        $tipo[] = "ui-icon-gripsmall-diagonal-se";
        $tipo[] = "ui-icon-grip-diagonal-se";
    }
}
?>
