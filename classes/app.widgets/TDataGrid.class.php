<?php
/**php
 * classe TDataGrid
 * Classe para construção de Listagens
 */
class TDataGrid extends TTable {

    public  $columns = array();
    private $colsAction = true;
    private $actions;
    private $rowcount;

    /**
     * método __construct()
     * instancia uma nova DataGrid
     */
    public function __construct() {

        //$this->border = '1';
        $this->bgcolor = '#B8C7DC';
        $this->cellpadding = "0";
        $this->cellspacing = "0";
        $this->align = "inherit";
        $this->style = "position: static;";

        parent::__construct();
        $this->class = 'tdatagrid_table';

    }

    /**
     * método addColumn()
     * Adiciona uma coluna � listagem
     * param $object = objeto do tipo TDataGridColumn
     */
    public function addColumn(TDataGridColumn $object) {

        if($object->getVisibilidade() == true or $object->getVisibilidade == "") {
            //valida se a coluna já foi adicionada
            if(in_array($object, $this->columns) === false) {
                $this->columns[] = $object;
            }
        }
    }

    /**
     * método addAction()
     * Adiciona uma ação � listagem
     * param $object = objeto do tipo TDataGridAction
     * param $label = Informativo da coluna
     */
    public function addAction(TAction $object) {
        $this->actions[] = $object;
    }

    /**
     * método clear()
     * Elimina todas linhas de dados da DataGrid
     */
    function clear() {
        // faz uma cópia do cabe�alho
        $copy = $this->children[0];
        // inicializa o vetor de linhas
        $this->children = array();
        // acrescenta novamente o cabe�alho
        $this->children[] = $copy;
        // zera a contagem de linhas
        $this->rowcount = 0;
    }

    /**
     * método createModel()
     * Cria a estrutura da Grid, com seu cabeçalho
     */
    public function createModel($totalWidth, $colsAction = true) {

        $this->colsAction = $colsAction;

        //tamanho total do grid
        $this->width = $totalWidth;

        // adiciona uma linha à tabela
        $row = parent::addRow('thead');

        // adiciona células para as ações (Celulas vazias no início da lista)
        if($this->actions and $this->colsAction == true) {

            foreach($this->actions as $ch =>$action) {

                $celula = $row->addCell($action->label,'th');
                //$celula = $row->addCell(( is_object($action->label) ? $action->label->show() : $action->label ),'th');
                $celula->width = '20';
                $celula->align = 'center';
                $celula->class = 'tdatagrid_col';
            }
        }

        // adiciona as células para os dados
        if ($this->columns) {

            // percorre as colunas da listagem
            foreach ($this->columns as $column) {

                // obtém as propriedades da coluna
                $name  = $column->getName();
                $label = $column->getLabel();
                $align = $column->getAlign();
                $width = $column->getWidth();

                //adiciona a célula com a coluna
                $celula = $row->addCell($label,'th');
                
                $celula->class = 'tdatagrid_col';
                $celula->align = $align;
                $celula->style = "text-align: $align; padding-$align: 5px;";
                $celula->width = $width;
                $celula->coluna = $name;
                $celula->title = "Reordenar pela coluna $label";

                // verifica se a coluna tem uma ação
                if ($column->getAction()) {

                    $act = $column->getAction();
                   // $celula->onmouseover = "this.className='tdatagrid_col_over';";
                   // $celula->onmouseout  = "this.className='tdatagrid_col'";
                    $celula->onclick     = "$act";
                }
            }
        }
    }

    /**
     * método addItem()
     * Adiciona um objeto na grid
     * param $object = Objeto que contem os dados
     * param $array / string = um vetor contendo na primeira posição
     * a classe que configura a marcação e na segunda a mensagem ou apenas a classe como string
     */
    public function addItem($object, $markup = NULL) {
        // cria um estilo com cor variável
        //$classe = ($this->rowcount % 2) == 0 ? 'tdatagrid_row1 remarkable' : 'tdatagrid_row2 remarkable';

        // adiciona uma linha na DataGrid
        $row = parent::addRow('tbody');

        $classe =  'tdatagrid_row remarkable';
        //configura linha com marcação
        if($markup) {
            if(is_array($markup)) {
                $row->title = $markup[1];
                if($markup[0] == "1") {
                    $row->situacao = '9';
                    //$classe = $classe.' ui-state-error';
                }
                elseif($markup[0] == "2") {

                    $row->situacao = '8';
                    //$classe = $classe.' ui-state-highlight ';
                }
                else {
                    $row->situacao = '1';
                    //$classe = $markup[0];
                }
            }else {
                if($markup == "1") {
                    $row->situacao = '9';
                }
                elseif($markup == "2") {
                    $row->situacao = '8';
                }
                else {
                    $row->situacao = '1';
                    $classe = $markup;
                }
            }
        }

        $row->class = $classe;

        // verifica se a listagem possui ações
        if ($this->actions and $this->colsAction == true) {

            // percorre as ações
            foreach ($this->actions as $keyAct=>$action) {

                // obtém as propriedades da ação
                $nomeCampo  = $action->nome;
                $label      = $action->title;
                $image      = $action->img;
                $tipoCampo  = $action->tipoCampo;

                if($action->field) {
                    $field  = $action->field;
                    $key    = $object->$field;
                    $action->setParameter('key',$key);
                }
                $acao   = $action->serialize();


                // cria um link
                // verifica se a ação é representada por um campo e compila o campo caso seja verdadeiro
                if($tipoCampo) {

                    $btAcao = new $tipoCampo($nomeCampo);
                    $btAcao->setId($nomeCampo.'_'.$this->rowcount);
                    $btAcao->setValue($key);
                    $btAcao->alt = $action->title;
                    $btAcao->title = $action->title;
                    if($action->value){$btAcao->value = $action->value;}

                    //aplica o checked se ouver.
                    if($action->checked){
                        $btAcao->checked = $action->checked;
                        $btAcao->class   = $action->class;
                    }
                    
                    //verifica a existencia de uma ação JS associanda ao campo
                    $testaAcao = explode('(', $acao);
                    if($testaAcao[0] != "-" and $testaAcao[0] != "" and $testaAcao[0] != "0") {
                        $btAcao->onClick = $acao;
                    }
                    
                }else {

                    $btAcao = new TElement('div');
                    $btAcao->class = "datagrid-icon";
                    $btAcao->onClick = $acao;
                    $btAcao->alt = $action->title;
                    $btAcao->title = $action->title;

                    // verifica se o link será com imagem ou com texto
                    if ($image) {
                        // adiciona a imagem ao link
                        $image = new TImage("../app.view/app.images/petrus/$image");
                        $image->style = "width: 17px; height: 17px";
                        $btAcao->add($image);
                    }
                    else {
                        // adiciona o rótulo de texto ao link
                        $btAcao->add($label);
                    }
                }
                //print_r($action->metodo);
                //if($action->label == "Visualizar"){
                    $row->ondblclick = $acao;
                //}
                // adiciona a célula á linha
                $row->addCell($btAcao);
            }
        }
        if ($this->columns) {
            // percorre as colunas da DataGrid
            foreach ($this->columns as $column) {

                // obtém as propriedades da coluna
                $name     = $column->getName();
                $align    = $column->getAlign();
                $width    = $column->getWidth();
                $function = $column->getTransformer();
                if(is_object($object)) {
                    $data     = $object->$name;
                }
                else {
                    $data     = $object[$name];
                }
                // verifica se há função para transformar os dados
                if ($function) {
                    $func = explode(",",$function);
                    $classe = $func[0];
                    $method = $func[1];
                    // aplica a função sobre os dados

                    $ObExec = new $classe();
                    if(method_exists($ObExec, $method)){
                        $data = call_user_func_array(array($ObExec, $method), array($data));
                    }
                }

                if(substr($width,-1) != "%"){
                    $max = ($width/6);
                    if((is_string($data)) and (strlen($data) >= $max ) and ($max > 3 )){
                        $title = $data;
                        $data_temp = substr($data,0,$max-2);
                        $data = trim($data_temp) . "...";
                    }
                }
                if(!$data){
                    $data = " - ";
                }
                // adiciona a colula na linha
                $celula = $row->addCell($data);
                $celula->style = "padding-{$align}:4px; border-left:1px solid #B8C7DC; border-bottom:1px solid #B8C7DC; text-align: {$align};";
                $celula->reference = $name;
                $celula->align = $align;
                if($title){ $celula->title = $title; }
                $celula->width = $width;

            }
        }
        // incrementa o contador de linhas
        $this->rowcount ++;
    }

}