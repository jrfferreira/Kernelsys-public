<?php

class TUpload {
    function __construct(){
        $this->dir = "../".TOccupant::getPath()."app.files/";
    }

    public function uploadFile($name,$new_name,$extension = array('jpg','jpeg','gif','png','doc','docx','txt','rtf','pdf','xls','xlsx','ppt','ppt','zip','rar','xml','sql')){
        try{
            if(!empty($_FILES[$name]['error'])){
		switch($_FILES[$name]['error']){

			case '1':
				$error = 'O arquivo carregado excede a directiva upload_max_filesize em php.ini.';
				break;
			case '2':
				$error = 'O arquivo carregado excede o tamanho em MAX_FILE_SIZE que foi especificado no formulário HTML.';
				break;
			case '3':
				$error = 'O arquivo foi apenas parcialmente carregado.';
				break;
			case '4':
				$error = 'Não há arquivo para upload.';
				break;
			case '6':
				$error = 'A pasta temporária foi perdida.';
				break;
			case '7':
				$error = 'Falha ao escrever o arquivo em disco.';
				break;
			case '8':
				$error = 'Arquivo parado pela extensão';
				break;
			case '999':
			default:
				$error = 'O codigo de erro não é valido';
		}
                throw new ErrorException("<span style='font-family:verdana; font-size: 12px;'>{$error}</span>");

	}elseif(empty($_FILES[$name]['tmp_name']) || $_FILES[$name]['tmp_name'] == 'none'){
                throw new ErrorException("<span style='font-family:verdana; font-size: 12px;'>Não há arquivo para upload.</span>");

	}else{            
            $arquivo = basename($_FILES[$name]['name']);
            $arquivo_info = pathinfo($arquivo);
            if(preg_match('/('.implode('|',$extension).')/i', strtolower($arquivo_info['extension']))){
                $archive_name = $this->dir . strtolower($new_name) . "." . $arquivo_info['extension'];

                move_uploaded_file($_FILES[$name]['tmp_name'], $archive_name);
            
                return $archive_name;

            }else{
                throw new ErrorException("<span style='font-family:verdana; font-size: 12px;'>O arquivo carregado não condiz com uma das extensões autorizadas.</span>");
            }
        }


        }catch (Exception $e) {
            new setException($e);
        }
    }    
}

function __autoload($classe) {
    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}

new TCheckLogin();

if($_POST['upload_form'] && $_POST['upload_codigo'] && $_POST['upload_campo']){

        $idCampo = $_POST['upload_campo'];
        $idForm = $_POST['upload_form'];
        $codigo = $_POST['upload_codigo'];
        $file = 'reg'.$_POST['upload_codigo'].'arquivo'.$_POST['upload_campo'].'_'. date("YmdHms");

        $TUpload = new TUpload();
        $upFile = $TUpload->uploadFile($idCampo,$file);
        if($upFile){

            $dbo_kernelsys = new TDbo_kernelsys('forms');
            $critForm = new TCriteria();
            $critForm->add(new TFilter('id','=',$idForm));
            $retForm = $dbo_kernelsys->select('entidade',$critForm);
            $form = $retForm->fetchObject();

            $dbo_kernelsys = new TDbo_kernelsys('tabelas');
            $critEntidade = new TCriteria();
            $critEntidade->add(new TFilter('id','=',$form->entidade));
            $retEntidade = $dbo_kernelsys->select('tabela',$critEntidade);
            $entidade = $retEntidade->fetchObject();

            $dataUp[$idCampo] = $upFile;
            $dbo = new TDbo($entidade->tabela);
            $crit = new TCriteria();
            $crit->add(new TFilter('codigo','=',$codigo));
            $update = $dbo->update($dataUp,$crit);

            if($update){
                $fileFrame = new TFrame();
                $fileFrame->show($idCampo,$idForm,$codigo,'1',$upFile);
            }
        }
}

?>
