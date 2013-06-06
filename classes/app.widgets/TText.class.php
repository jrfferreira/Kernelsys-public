<?php
/**
 * classe TText
 * Classe para construção de caixas de texto
 */
class TText extends TField
{
    private $width;
    private $height;
    
    /**
     * método construtor
     * instancia um novo objeto
     * param  $name    = nome interno do campo
     */
    public function __construct($name)
    {
        // executa o método construtor da classe pai.
        parent::__construct($name);
        
        // cria uma tag HTML do tipo <textarea>
        $this->tag = new TElement('textarea');
        $this->tag->class = 'ui-state-default';       // classe CSS
        // define a altura padr�o da caixa de texto
        $this->height= 100;
    }
    
    /**
     * método setSize()
     * define o tamanho de um campo de texto
     * param  $width   = largura
     * param  $height  = altura
     */
    public function setSize($width, $height)
    {
        $this->size   = $width;
        $this->height = $height;
    }
    
    /* método show() 
     * exibe o widget na tela
     */ 
    public function show()
    {
        $this->tag->name  = $this->name;    // nome da TAG
        $this->tag->style = "width:{$this->size};height:{$this->height}"; // tamanho em pixels
        
        // se o campo não � edit�vel
        if (!parent::getEditable())
        {
            // desabilita a TAG input
            $this->tag->readonly = "1";
            $this->tag->class = 'tfield_disabled'; // classe CSS
        }
        
        // adiciona conte�do ao textarea
        $this->tag->add(htmlspecialchars($this->value));
        // exibe a tag
        $this->tag->show();
    }
}