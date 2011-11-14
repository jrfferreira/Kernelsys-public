<?php
/**
 * classe TTableRow
 * Repons�vel pela exibição de uma linha de uma tabela
 */
class TTableRow extends TElement{
    /**
     * método construtor
     * Instancia uma nova linha
     */
    public function __construct(){
        parent::__construct('tr');
    }

    /**
     * método addCell
     * Agrega um novo objeto célula (TTableCell) � linha
     * param  $value = conte�do da célula
     */
    public function addCell($value,$tipo = 'td'){
        // instancia objeto célula
        $cell = new TTableCell($value,$tipo);
        parent::add($cell);
        // retorna o objeto instanciado
        return $cell;
    }
}
?>