<?php

/**
 * percorre diretorios
 * para realizar a auto inclusão das classes solicitadas
 *
 */
class autoload {
	
	public $nivelatual = 1;
	public $niveis = 10;
	public $mapfile = '../app.tmp/mapfile.php';
	

    public function __construct($nvl, $classe, $raiz = NULL) {

        date_default_timezone_set('America/Sao_Paulo');
        
        try {
        	
        		include_once($this->mapfile);
        		$ObExec = new fileMap();
   				if(!method_exists($ObExec, 'getClasses')){   		
        			$this->mapClass($nvl, $classe, $raiz = NULL);
        		}
        	       	
        	
            if(!$find){
                $find = $this->findClass($classe);
            }
        } catch (Exception $e) {
            new setException('Ouve um erro carregar a classe ' . $classe . ' [' . $find . ']');
        }
    }

    public function fileIn($pastas, $classe) {
        $find = false;

        if (count($pastas) > 0) {
            foreach ($pastas as $pasta) {
                if (is_dir("{$pasta}")) {

                    if (file_exists("{$pasta}/{$classe}.class.php")) {

                        include_once("{$pasta}/{$classe}.class.php");
                        $find = true;
                        break;
                    } elseif (file_exists("{$classe}.class.php")) {
                        include_once("{$classe}.class.php");
                        $find = true;
                        break;
                    } else {
                        $find = false;
                    }
                }
            }
        }
        return $find;
    }
    
    public function findClass($classe) {
        
    	
    	require_once($this->mapfile);

    	$classMap = new fileMap();
    	
	    if( is_array( $classMap->getClasses() ) ){ 
	        foreach( $classMap->getClasses() as $key=> $val ) 
	        { 
	           if( preg_match( '/'. $classe .'(.class)/i', $val ) ){
	               include_once($val);
	               return true;
	           }
	        } 
	    }else{
	    	return false;
	    } 
    }

    private function foreach_dir($dir,$class){
            $nivel1 = scandir($dir);
            foreach($nivel1 as $sub_dir){
                    $this->nivelatual++;
                    
                    if(preg_match('/(.class.php)$/i',$sub_dir)){
                		$array[] = $dir."/".$sub_dir;
                    }
                if(is_dir($dir."/".$sub_dir) && $sub_dir != '../' && $sub_dir != $dir && $sub_dir != '.' && $sub_dir != '..' && $sub_dir != 'autoload.class.php'){
                    $new_dir = $this->foreach_dir($dir."/".$sub_dir,$class);

                    if($new_dir && $array){
                        $array = array_merge($new_dir,$array);
                    }elseif($new_dir && !$array){
                        $array = $new_dir;
                    }
                }
                /*if( $sub_dir == "{$class}.class.php" or $this->nivelatual == $this->niveis){
                	$this->nivelatual = 1;
                    break;
                }

                 * 
                 */
            }

            return $array;

    }
    
    private function mapClass($nvl, $classe, $raiz = NULL){
    	try{

	        $this->nvl = $nvl;
	
	        if (!$raiz) {
	            $raiz = "../classes";
	        }   		
        	
            $raiz = $this->nvl . $raiz;
            $nivel1 = $this->foreach_dir($raiz, $classe);
            
            $file  = '<?php ';
            $file .= ' class fileMap{';            
            $file .= 'public $classes = array();';    
            $file .= 'public function __construct(){';    
            foreach($nivel1 as $ch => $vl){
            	$file .= '$this->classes['.$ch.'] = \''.$vl.'\';';
            }
                
            $file .= '}';
            $file .= 'public function getClasses(){ return $this->classes; }';
            $file .= '}';
            $file .= '?>';
    		            
            file_put_contents($this->mapfile,$file,LOCK_EX);
    		
            
    	}catch(Exception $e){
    		
    	}
    }
}

?>
