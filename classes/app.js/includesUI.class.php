<?php


class includesUI{

    private $includes = array();

    public function __construct($dir = ''){

            $getPath = new TElement('script');
            $getPath->type="text/javascript";
            $getPath->charset="utf-8";
            $getPath->src= '../'.$dir.'app.config/getPath.js';
            $getPath->add('');


            $loadJs = new loadJs();
            
            $pross = new TElement('script');
            $pross->type="text/javascript";
            $pross->charset="utf-8";
            $pross->src= '../'.$dir.'app.js/js.pross/pross.js';
            $pross->add('');

            $jquery = new TElement('script');
            $jquery->type="text/javascript";
            $jquery->charset="utf-8";
            $jquery->src= '../'.$dir.'app.js/js.pross/jquery.js';
            $jquery->add('');

            $ui_lib = $loadJs->read($dir.'app.ui/js/lib/');

            $ajax = new TElement('script');
            $ajax->type="text/javascript";
            $ajax->charset="utf-8";
            $ajax->src= '../'.$dir.'app.js/js.pross/ajax.js';
            $ajax->add('');

            $plugins = $loadJs->read('../'.$dir.'app.js/js.plugins/');

            $control = $loadJs->read('../'.$dir.'app.js/js.control/');

            $ui_attr = new TElement('script');
            $ui_attr->type="text/javascript";
            $ui_attr->charset="utf-8";
            $ui_attr->src= $dir.'app.ui/js/ui.attr.js';
            $ui_attr->add('');

            $this->includes[] = $getPath;
            $this->includes[] = $jquery;
            sort($ui_lib);
            foreach ($ui_lib as $vl){
                $this->includes[] = $vl;
            }
            $this->includes[] = $ajax;
            foreach ($plugins as $vl){
                $this->includes[] = $vl;
            }
            $this->includes[] = $pross;
            foreach ($control as $vl){
                $this->includes[] = $vl;
            }
            $this->includes[] = $ui_attr;

            $this->obsession = new TSession();
            $versao = $this->obsession->getValue('versionSystem');
            $empresa = $this->obsession->getValue('empresa');
            
            $obUser = new TCheckLogin();
        	$obUser = $obUser->getUser();

        	$codigotema = $obUser->codigotema;

	        	//lista de temas
	        	$t[1] = "custom_petrus";      	
	        	$t[2] = "eggplant";
	        	$t[3] = "redmond";
	        	$t[4] = "ui-lightness";
	        	$t[5] = "black-tie";
	        	$t[6] = "sunny";
	        	$t[7] = "pepper-grinder";
	        	$t[8] = "dot-luv";
	        	$t[9] = "ui-tolook";	        	
	        	$t[10] = "blitzer";
	        	$t[11] = "petrusedu";
	        	$t[12] = "petrusedu_alternate";
	        	$t[13] = "bluestyle";
	        	$t[14] = "flick";	        	
	        	$t[15] = "humanity";	        	
	        	$t[16] = "overcast";	        		        	
	        	$t[17] = "bluetzer";	        		        	
	        	$t[18] = "fibratec";	        		        	
	        	$t[19] = "remake_bluetzer";	      		        	
	        	$t[20] = "south-street";
	        	$t[21] = "cupertino";
	        	$t[22] = "petrus";

	        	$t[0] = $t[array_rand($t)];
	        	$theme = $t[$codigotema];

            //CSS            
            $css2 = new TElement('link');
            $css2->type = "text/css";
            $css2->href = $dir."app.ui/css/default_style.css";
            $css2->rel = "Stylesheet";

            $css3 = new TElement('link');
            $css3->type = "text/css";
            $css3->href = $dir."app.ui/css/".$theme."/jquery-ui-theme.custom.css";
            $css3->rel = "Stylesheet";

            $css4 = new TElement('link');
            $css4->href= $dir."styles/datePicker.css";
            $css4->type="text/css";
            $css4->rel="stylesheet";
            
            $css5 = new TElement('link');
            $css5->type = "text/css";
            $css5->href = $dir."app.ui/css/jquery.jgrowl.css";
            $css5->rel = "Stylesheet";

            $css6 = new TElement('link');
            $css6->type = "text/css";
            $css6->href = $dir."app.ui/css/ui.multiselect.css";
            $css6->rel = "Stylesheet";

            $css7 = new TElement('link');
            $css7->href= $dir."styles/fullcalendar.css";
            $css7->type="text/css";
            $css7->rel="stylesheet";

            $css8 = new TElement('link');
            $css8->href= $dir."styles/fullcalendar.print.css";
            $css8->type="text/css";
            $css8->rel="stylesheet";


            $icon = new TElement('link');
            $icon->rel="shortcut icon";
            $icon->href="favicon.ico";
            
            
            $titulo = new TElement('title');
            $titulo->add("Sistema Petrus - ".$empresa." - v.: ".$versao." (Tema: ".ucwords($theme).")");
            
            $scriptJGrowl = new TElement("script");            
            $scriptJGrowl->type="text/javascript";
            $scriptJGrowl->add("$(document).ready(function() {\$.jGrowl('<br />Novo módulo de <b>Questionários</b> implantado no sistema.',{header:'versão 1.1.8'});\$.jGrowl('<br /> No momento você usa<br />o tema <b>\"".$theme."\"</b>.<br /> Você pode altera-lo em Administrativo > Usuário',{header:'Theme Roller'})})");
                       
  
 //       $this->includes[] = $css;
        $this->includes[] = $css2;
        $this->includes[] = $css3;
        $this->includes[] = $css4;        
        $this->includes[] = $css5;
        $this->includes[] = $css6;
        $this->includes[] = $icon;
        $this->includes[] = $titulo;        
        //$this->includes[] = $scriptJGrowl;
    }

     public function get(){
         return $this->includes;
     }
}