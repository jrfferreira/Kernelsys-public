<?php
/**
 * percorre diretorios
 * para realizar a auto inclus�o das classes solicitadas
 *
*/

class loadJs{

        function read($diretorio){
            $ponteiro  = opendir($diretorio);
            while ($nome_itens = readdir($ponteiro)) {
               $xtens = substr($nome_itens, -3,3);
                if($xtens == '.js'){
                    $pross = new TElement('script');
                    $pross->type="text/javascript";
                    $pross->charset="utf-8";
                    $pross->src= $diretorio.$nome_itens;
                    $pross->add('');
                    $itens[] = $pross;
                }elseif(is_dir($diretorio."/".$nome_itens) && $nome_itens != '../' && $nome_itens != $diretorio && $nome_itens != '.' && $nome_itens != '..'){
                    
                   $newItens = $this->read($diretorio . $nome_itens . '/');

                   if($newItens && $itens){
                       $itens = array_merge($itens,$newItens);
                   }elseif($newItens && !$itens){
                       $itens = $newItens;
                   }
                }
            }
            return $itens;
        }
}