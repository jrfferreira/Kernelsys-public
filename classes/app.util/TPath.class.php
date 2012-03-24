<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of TGetPath
 *
 * @author João Felix
 */
class TPath {
    public function getPath($occuant){
            $session = new TSession();
            $pathSystem = $session->getValue('pathSystem');

            if(!$pathSystem){
                $tm = parse_ini_file('../app.config/dataset.ini');
                $pathSystem = $tm['pathSystem'];
            }

            return $pathSystem;
    }
}