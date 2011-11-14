<?php
/**
 * classe TTable
 * respons�vel pela exibição de tabelas
 */
class TTable extends TElement{

    public $tbody;
    public $thead;
    public $countChild;
    /**
     * método construtor
     * Instancia uma nova tabela
     */
    public function __construct(){
        $this->countChild = 0;
        parent::__construct('table');
        //$this->thead = new TElement('thead');
        //$this->tbody = new TElement('tbody');

        //parent::add($this->thead);
        //parent::add($this->tbody);
    }

    /**
     * método addRow
     * Agrega um novo objeto linha (TTableRow) na tabela
     */
    public function addRow($context = 'tbody'){
        $row = new TTableRow;
        /*
        if(!$this->countChild){
         $this->$context->add($row);
        }else{
         $this->$context->add($row);
        }
         
        $this->countChild++;
         */
        $row->context = $context;
        parent::add($row);
        return $row;
    }
}
?>