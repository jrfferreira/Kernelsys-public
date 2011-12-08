<?php
/**
 * classe TTranslation
 * Classe utilit�ria para tradução de textos
 */
class TTranslation
{
	private static $instance; // inst�ncia de TTranslation
    private $lang;            // linguagem destino
    
    /**
     * método __construct()
     * Instancia um objeto TTranslation
     */
	private function __construct()
	{
		$this->messages['en'][] = 'Function';
        $this->messages['en'][] = 'Table';
        $this->messages['en'][] = 'Tool';
        
        $this->messages['pt'][] = 'Função';
        $this->messages['pt'][] = 'Tabela';
        $this->messages['pt'][] = 'Ferramenta';
        
        $this->messages['it'][] = 'Funzione';
        $this->messages['it'][] = 'Tabelle';
        $this->messages['it'][] = 'Strumento';
	}

    /**
     * método getInstance()
     * Retorna a �nica inst�ncia de TTranslation
     */
	public static function getInstance()
	{
        // se não existe inst�ncia ainda
		if (empty(self::$instance))
		{
            //instancia um objeto
			self::$instance = new TTranslation;
		}
        // retorna a inst�ncia
		return self::$instance;
	}
    
    /**
     * método setLanguage()
     * Define a linguagem a ser utilizada
     * param  $lang = linguagem (en,pt,it)
     */
	public static function setLanguage($lang)
    {
        $instance = self::getInstance();
        $instance->lang = $lang;
    }
    
    /**
     * método getLanguage()
     * Retorna a linguagem atual
     */
	public static function getLanguage()
    {
        $instance = self::getInstance();
        return $instance->lang;
    }
    
    /**
     * método Translate()
     * Traduz uma palavra para a linguagem definida
     * param  $word = Palavra a ser traduzida
     */
	public function Translate($word)
    {
        // obt�m a inst�ncia atual
        $instance = self::getInstance();
        // busca o �ndice num�rico da palavra dentro do vetor
        $key = array_search($word, $instance->messages['en']);
        
        // obt�m a linguagem para tradução
        $language = self::getLanguage();
        // retorna a palavra traduzida
        // vetor indexado pela linguagem e pela codigo
        return $instance->messages[$language][$key];
    }
}

/**
 * método _t()
 * Fachada para o método Translate da classe Translation
 * param  $word = Palavra a ser traduzida
 */
function _t($word)
{
	return TTranslation::Translate($word);
}
?>