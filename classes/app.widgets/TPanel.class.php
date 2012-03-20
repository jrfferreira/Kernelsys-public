<?php
/**
 * classe TPanel
 * Painel de posições fixas
 */
class TPanel extends TElement{
    /**
     * método __construct()
     * instancia objeto TPanel.
     * param  $titulo   = titulo da painel
     */
    public function __construct($titulo){
	
        // instancia objeto TStyle
        // para definir as características do painel
        //$painel_style = new TStyle('tpanel');
        
        //$painel_style->width            = '100%';
        //$painel_style->height           = '100%';
        
        // exibe o estilo na tela
        //$painel_style->show();
        
        parent::__construct('span');
        $this->class = 'tpanel';
    }
}