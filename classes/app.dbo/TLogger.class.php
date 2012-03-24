<?php
/*
 * classe TLogger
 *  Esta classe prov� uma interface abstrata
 *  para definição de algoritmos de LOG
 */
abstract class TLogger
{
    protected $filename; // local do arquivo de LOG
    
    /*
     * método __construct()
     *  instancia um logger
     * param  $filename = local do arquivo de LOG
     */
    public function __construct($filename)
    {
        $this->filename = $filename;
        // reseta o conte�do do arquivo
        file_put_contents($filename, '');
    }
    
    // define o método write como obrigat�rio
    abstract function write($message);
}
?>