<?php
/**
 * class TDataGridAction
 * Representa uma ação de uma listagem
 */
class TDataGridAction{

    private $image;
    private $label;
    private $field;
	
	public function __construct($acao,$metodo){
	
		$this->acao   = $acao;
		$this->metodo = $metodo;
	}
	
	 /**
     * método getAcao()
     * retorna a função a ser executada no js
     */
    public function getAcao(){
       return $this->acao;
    }
	
	 /**
     * método setClasse()
     * atribui uma Classe  para a ação
     * param  $classe = classe m�e do objeto
     */
    public function setClasse($classe)
    {
        $this->classe = $classe;
    }
	
	/**
	*Retorna a classse
	*/
    public function getClasse(){
        return $this->classe;
    }
	
	/**
     * método getMetodo()
     * retorna o Metodo a ser executada no TMain
     */
    public function getMetodo()
    {
       return $this->metodo;
    }

    /**
     * método setImage()
     * atribui uma imagem � ação
     * param  $image = local do arquivo de imagem
     */
    public function setImage($image)
    {
        $this->image = $image;
    }
	
    
    /**
     * método getImage()
     * retorna a imagem da ação
     */
    public function getImage()
    {
        return $this->image;
    }
    
    /**
     * método setLabel()
     * define o r�tulo de texto da ação
     * param  $label = r�tulo de texto da ação
     */
    public function setLabel($label)
    {
        $this->label = $label;
    }
    
    /**
     * método getLabel()
     * retorna o r�tulo de texto da ação
     */
    public function getLabel()
    {
        return $this->label;
    }
    
    /**
     * método setField()
     * define o nome do campo do banco de dados
     * que ser� passado juntamente com a ação
     * param  $field = nome do campo do banco de dados
     */
    public function setField($field)
    {
        $this->field = $field;
    }
    
    /**
     * método getField()
     * retorna o nome do campo de dados
     * definido pelo método setField()
     */
    public function getField()
    {
        return $this->field;
    }
}