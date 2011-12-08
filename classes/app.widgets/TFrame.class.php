<?php

class TFrame {

public function show($idCampo,$idForm,$codigo,$edit,$file = null){
        $HTML = new TElement('html');
        //$HTML->xmlns="http://www.w3.org/1999/xhtml";
        //$HTML->__set('xml:lang',"en");
        $head = new TElement('head');
         $head->add('<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />');
         $head->add('<title>File Upload</title>');
         $HTML->add($head);
        $BODY = new TElement('body');
        $BODY->style = "text-align: center; vertical-align: middle; font-family:verdana;";
        $body->valign = 'middle';
        $form = new TElement('form');
        $form->action = "../app.util/TUpload.class.php";
        $form->method = 'POST';
        $form->id = 'form'.$idCampo.$idForm.'cod'.$codigo;
        $form->enctype = "multipart/form-data";

        if($file){
            $file = file_exists($file) ? $file : '../app.view/app.images/imgnotfound.jpg';

        $ext = explode('.', $file);
        $ext = $ext[(count($ext) -1)];

        $file_name = explode('/', $file);
        $file_name = $file_name[(count($file_name) -1)];

        if(preg_match("/(jpg|jpeg|gif|png)/i", $ext)){
            $img = new TElement('img');
            $img->style = 'max-height: 150px; max-width: 250px;';
            $img->src = $file;
            $img->alt =$file_name;
            $img->title =$file_name;
            $form->add($img);
            //$form->add('<br/><span style="font-size: 10px;">'.$file_name."</span>");
        }else{
            $imagem_file = "../app.view/app.images/file_icons/{$ext}.png";
            $imagem_file = file_exists($imagem_file) ? $imagem_file : "../app.view/app.images/file_icons/blank.png";

            $ahref = new TElement('a');
            $ahref->href = $file;
            $ahref->target = "_blank";
            $img = new TElement('img');
            $img->style = 'max-height: 70px; max-width: 70px;';
            $img->src = $imagem_file;
            $img->alt =$file_name;
            $img->title =$file_name;
            $ahref->add($img);
            $ahref->add('<br/><span style="font-size: 10px;">'.$file_name."</span>");
            $form->add($ahref);
        }
            $form->add('<br/>');
        }
        $campo_form = new TElement('input');
        $campo_form->type = 'hidden';
        $campo_form->name = 'upload_form';
        $campo_form->value = $idForm;

        $campo_codigo = new TElement('input');
        $campo_codigo->type = 'hidden';
        $campo_codigo->name = 'upload_codigo';
        $campo_codigo->value = $codigo;

        $campo_id = new TElement('input');
        $campo_id->type = 'hidden';
        $campo_id->name = 'upload_campo';
        $campo_id->value = $idCampo;

        $campo_file = new TElement('input');
        $campo_file->type = 'file';
        $campo_file->name = $idCampo;
        $button = new TElement('input');
        $button->type = 'submit';
        $button->class = "ui-state-default ui-corner-all";
        $button->value = "Enviar";

        $form->add($campo_form);
        $form->add($campo_codigo);
        $form->add($campo_id);
        if($edit == '1'){
            $form->add($campo_file);
            $form->add($button);
        }
        $BODY->add($form);
        $HTML->add($BODY);
        $HTML->show();
    }
    }
?>
