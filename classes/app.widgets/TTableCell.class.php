<?php
/**
 * classe TTableCell
 * Repons�vel pela exibição de uma célula de uma tabela
 */
class TTableCell extends TElement{
    /**
     * método construtor
     * Instancia uma nova célula
     * param  $value = conte�do da célula
     */
    public function __construct($value,$tipo = 'td'){
	
        parent::__construct($tipo);
        parent::add($value);
    }
}
?>