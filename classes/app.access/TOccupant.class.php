<?php
/**
 * Gerencia a identificação e direcionamento dos ocupantes do sistema.
 * @author Jão Felix
 */

class TOccupant {
	
	/**
	 * 
	 * @param unknown_type $occupant
	 */
    private function setPath($occupant){
        $session = new TSession();
        $session->setValue("occupant", $occupant);
        if(!defined('OCCUPANT')) define('OCCUPANT',$occupant);
    }
    
    /**
     * 
     */
    static function getPath(){
        $session = new TSession();
        $occupant = $session->getValue('occupant');
        if(!defined('OCCUPANT')) define('OCCUPANT',$occupant);

        if($occupant){
            return 'occupant/'.$occupant.'/';
            
        }else{
            return null;
        }
    }
	
    /**
     * 
     */
    static function getOccupant(){
        $session = new TSession();
        $occupant = $session->getValue('occupant');
        if(!defined('OCCUPANT')) define('OCCUPANT',$occupant);

        return $occupant;
    }
}
?>
