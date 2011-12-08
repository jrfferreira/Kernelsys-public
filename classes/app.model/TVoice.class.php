<?php


class TVoice {
    private $obTDbo;
    private $obPessoa;

    //Endere�o para enviar audio   http://vox01.velip.com/vox/GetAudioFile.php

    public function __construct() {
        $this->obTDbo = new TDbo();
    }

    public function uploadFile($file) {

    }

    public function uploadText($text,$ttswrt = 0,$rate = 0) {
        $request = new TRequest('http://vox01.velip.com/vox/GetAudioFile.php','POST');
        $request->setData(array('text'=>utf8_decode($text),'rate'=>$rate,'ttswrt'=>$ttswrt));
        $request->requestResult();
        $obUpload = $request->XmlObject();

        $toDb['cdw_id'] = $obUpload['attributes']['cdw_id'];//Identificação da requisição
        $toDb['cdw_url'] = $obUpload['cdw_url_mp3'];//URL para ouvir via download em formato wav cdw_url_mp3 = URL para ouvir via download em formato mp3
        $toDb['cdw_file'] = $obUpload['cdw_file'];//Identificador do arquivo armazenado na Velip. Este par�metro ser� utilizado quando do envio do torpedo.
        $toDb['cdw_sec'] = $obUpload['cdw_sec'];//tempo em segundos do wav
        $toDb['cdw_expires'] = $obUpload['cdw_expires'];//Data em que o arquivo ser� apagado na Velip (Formato YYYY-MM-DD)
        $toDb['cdw_status'] = $obUpload['cdw_status'];//OK , No audio or text, IP xxx.xxx.xxx.xxx is not valid

        return $toDb;


    }

    public function getAudioDir($_data) {
        $request = new TRequest('http://vox01.velip.com/vox/GetAudioDir.php','POST');
        $request->setData($_data);
        $request->requestResult();
        $obUpload = $request->XmlObject();

        $toDb['cdwd_dir'] = $obUpload['cdwd_dir'];
        $toDb['cdw_expires'] = $obUpload['cdw_expires'];//Data em que o arquivo ser� apagado na Velip (Formato YYYY-MM-DD)
        $toDb['cdw_status'] = $obUpload['cdw_status'];//OK , No audio or text, IP xxx.xxx.xxx.xxx is not valid

        return $toDb;
    }

    public function makeCall($file,$cel) {
        foreach($file as $ch=>$vl) {
            $data[$ch] = $vl;
        }
        $data['dest'] = $cel; // ( n�mero telef�nico do destino no formato DDI+DDD+N�MERO , exemplo: 551138424299 )
        $data['priority'] = '10'; // ( Se -1, o envio � na modalidade Imediata, qualquer outro valor acima de -1 ( 0, 1, 10, 100 at� 9999) ser� alocado na Fila de envios e ter� a prioridade dada pelo seu valor, sendo que ser�o enviados primeiro os de valores mais altos. )
        //$data['return'] = 0; // ( OPCIONAL : Veja detalhe abaixo em �Inform On-line sobre momento do atendimento�)
        //$data['ctid']  = 0;( OPCIONAL : ID fornecido por quem envia para referencia extra � qualquer valor alfa-num�rico at� 15 caracteres)

        $request = new TRequest('http://vox04.velip.com.br/pop/torpedo/MakeCall.php','POST');
        $request->setData($data);
        $request->requestResult();
        $obCall = $request->XmlObject();

        $data['cd_id'] = $obCall['attributes']['cd_id'];// = identificação do envio, ser� utilizada para fazer verifica��es do status do envio caso n�o tenha recebido a confirma��o autom�tica ou para verifica��o futura.
        $data['cd_table'] = $obCall['attributes']['cd_table'];// = tabela de registro da chamada. Parte integrante para busca , o envio tem duas componentes para busca, a tabela e o id.
        $data['cd_status'] = $obCall['cd_status'];// = OK, incorrect type, no destination, no content, error Tel.

        foreach($data as $ch=>$vl) {
            $_data['call_'.$ch] = $vl;
        }
        return $_data;
    }

    public function exeCall($mensagem,$dest = 'all') {
        $this->obTDbo->setEntidade('dbvoice_mensagem');
        $criteria = new TCriteria();
        $criteria->add(new TFilter('codigo','=',$mensagem));
        $select = $this->obTDbo->select('*',$criteria);

        $obMsg = $select->fetchObject();

        if($obMsg->call_type == 'P') {
            for ($index = 0; $index <= 9; $index++) {
                $ch = 'cont'.$index;
                $_dataDir[$ch] = $this->getAudioID($obMsg->$ch);
            }
            $ret_dataDir = $this->getAudioDir($_dataDir);
            if($ret_dataDir) {
                $critUpdate = new TCriteria();
                $critUpdate->add(new TFilter('codigo','=',$audio));
                $update = $this->obTDbo->update($ret_dataDir, $critUpdate);
                $this->obTDbo->commit();
            }

            $data['contentno'] = $this->getAudioID($obMsg->contno);
            $data['contentdtmf'] = $ret_dataDir['cdwd_dir'];
        }

        switch($obMsg->call_type) {
            case 'S': $data['type'] = '0';
                break;
            case 'P': $data['type'] = '4';
                break;
        }
        $data['content'] = $this->getAudioID($obMsg->cont);

        if($dest == 'all') {
            $this->obTDbo->setEntidade('dbvoice_ligacao');
            $criteria = new TCriteria();
            $criteria->add(new TFilter('codigomensagem','=',$mensagem),'AND');
            $criteria->add(new TFilter('call_cd_status', 'IS DISTINCT FROM', 'OK'),'AND');
            $select = $this->obTDbo->select('id,call_dest',$criteria);
            while($ret = $select->fetchObject()) {
                $_dests[$ret->id] = $ret->call_dest;
            }
        }else {
            $_dests['teste'] = $dest;
        }

        if($_dests){
        foreach($_dests as $ch=>$dest) {

            $dest = str_replace('(', '', $dest);
            $dest = str_replace(')', '', $dest);
            $dest = str_replace('-', '', $dest);
            $dest = str_replace(' ', '', $dest);

            if(count($dest) <= 12) {
                $prefix = substr($dest, 0, 2);
                if($prefix != '55') {
                    $dest = '55'.$dest;
                }
                if(count($dest) <= 12) {
                    $_dests[$ch] = $this->makeCall($data,$dest);
                }else {
                    $_dests[$ch] = null;
                }
            }else {
                $_dests[$ch] = null;
            }
        }

        $blocks = array_chunk($_dests,40,true);
        if($dest != 'teste') {
            foreach ($blocks as $ch=>$vl) {
                $Dbo = new TDbo('dbvoice_ligacao');
                foreach($vl as $ch2=>$send) {
                    $send['dest_type'] = substr($send['call_dest'],4,1) < 5 ? 'F' : 'C';
                    $criteria = null;
                    $criteria = new TCriteria();
                    $criteria->add(new TFilter('id','=',$ch2));
                    $select = $Dbo->update($send,$criteria);

                }
                sleep(20);
            }
        }
            $_dests['data'] = $data;
    }else{
        $_dests = 0;
    }
        return $_dests;

    }

    public function sendTeste($mensagem,$telefone) {

        $ret = $this->exeCall($mensagem,$telefone);

        if($ret) {
            echo "Sucesso: ".(count($ret) -1).' envio(s)';
        }

    }

    public function sendAudio($audio,$ttswrt = 0) {
        $this->obTDbo->setEntidade('dbvoice_audio');
        $criteria = new TCriteria();
        $criteria->add(new TFilter('codigo','=',$audio));
        $select = $this->obTDbo->select('*',$criteria);

        $obMsg = $select->fetchObject();

        $ret = $obMsg->file_type == 'T' ? $this->uploadText($obMsg->local_text,$ttswrt) : $this->uploadText($obMsg->local_file,$ttswrt);

        if($ret) {
            $critUpdate = new TCriteria();
            $critUpdate->add(new TFilter('codigo','=',$audio));
            $update = $this->obTDbo->update($ret, $criteria);
            $this->obTDbo->commit();
        }

        /*
        */
        //echo '<object height="27" width="320"><embed src="http://img404.imageshack.us/img404/7740/audiouq4.swf?audioUrl='.$ret['cdw_url'].'" height="27" width="320"></object>';
        echo '<object type="application/x-shockwave-flash" data="../app.view/app.images/voz.swf" id="voiceplayer" width="290" height="24">
		<param name="movie" value="../app.view/app.images/voz.swf">
		<param name="FlashVars" value="playerID=1&amp;autostart=yes&amp;righticon=0x0000AA&amp;soundFile='.$ret['cdw_url'].'">
		<param name="quality" value="high">
		<param name="menu" value="false">
		<param name="wmode" value="transparent">
		</object>';

    }

    public function apendTest() {

        $this->obTDbo->setEntidade('dbvoice_audio');
        $criteria = new TCriteria();
        $criteria->add(new TFilter('codigo','=',$mensagem));
        $select = $this->obTDbo->select('*',$criteria);

        $obMsg = $select->fetchObject();

        if($obMsg->cdw_file == 'NO' or $obMsg->cdw_file == null) {

            $div = new TElement('div');

            $button = new TElement('input');
            $button->type = "button";
            $button->onclick = "$('#respostaAudio').html('Gerando audio... Aguarde...');sendAudio('codigo','0');";
            $button->name = "testaAudio";
            $button->id = "testaAudio";
            $button->class = "ui-corner-all ui-widget ui-state-default";
            $button->style = "font-weight:bold; font-size: 30px;";
            $button->value = "Testar Audio";

            $div->add($button);

            $button1 = new TElement('input');
            $button1->type = "button";
            $button1->onclick = "$('#respostaAudio').html('Gerando audio... Aguarde...');sendAudio('codigo','1');";
            $button1->name = "gravarAudio";
            $button1->id = "gravarAudio";
            $button1->class = "ui-corner-all ui-widget ui-state-default";
            $button1->style = "font-weight:bold; font-size: 30px;";
            $button1->value = "Gravar Audio";

            $div->add($button1);

            $divREsposta = new TElement('div');
            $divREsposta->id = "respostaAudio";
            $divREsposta->style = 'display: inline-block;margin-top: 5px;';
            $divREsposta->add('');
            $div->add($divREsposta);
        }else {
            $div = new TElement('div');

            $ob_embed = '<object type="application/x-shockwave-flash" data="../app.view/app.images/voz.swf" id="voiceplayer" width="290" height="24">
		<param name="movie" value="../app.view/app.images/voz.swf">
		<param name="FlashVars" value="playerID=1&amp;autostart=yes&amp;righticon=0x0000AA&amp;soundFile='.$obMsg->cdw_url.'">
		<param name="quality" value="high">
		<param name="menu" value="false">
		<param name="wmode" value="transparent">
		</object>';
            $div->add($ob_embed);
        }


        return $div;

    }

    public function apendSend($mensagem) {

        $this->obTDbo->setEntidade('dbvoice_audio');
        $criteria = new TCriteria();
        $criteria->add(new TFilter('codigo','=',$mensagem));
        //      $select = $this->obTDbo->select('*',$crit);

        //      $obMsg = $select->fetchObject();

        $div = new TElement('div');

        /*
        $button = new TElement('input');
        $button->type = "button";
        $button->onclick = "$('#respostaAudio').html('Enviando... Aguarde...');sendTest('codigo','telefoneTeste');";
        $button->name = "enviarMensagem";
        $button->id = "enviarMensagem";
        $button->class = "ui-corner-all ui-widget ui-state-default";
        $button->value = "Enviar";
       $div->add($button);
        */
        $button1 = new TElement('input');
        $button1->type = "button";
        $button1->onclick = "$('#respostaAudio').html('Enviando... Aguarde...');sendTest('codigo','telefoneTeste');";
        $button1->name = "enviarTeste";
        $button1->id = "enviarTeste";
        $button1->class = "ui-corner-all ui-widget ui-state-default";
        $button1->value = "Enviar Teste para:";

        $div->add($button1);

        $field = new TElement('input');
        $field->type = "text";
        $field->id = "telefoneTeste";
        $field->name = "telefoneTeste";
        $field->class = "ui-state-default ui_mascara_telefone";

        $div->add($field);

        $divREsposta = new TElement('div');
        $divREsposta->id = "respostaAudio";
        $divREsposta->style = 'display: inline-block;margin-top: 5px;';
        /*
        $ob_embed = '<object type="application/x-shockwave-flash" data="../app.view/app.images/voz.swf" id="voiceplayer" width="290" height="24">
		<param name="movie" value="../app.view/app.images/voz.swf">
		<param name="FlashVars" value="playerID=1&amp;autostart=yes&amp;righticon=0x0000AA&amp;soundFile='.$obMsg->cdw_url.'">
		<param name="quality" value="high">
		<param name="menu" value="false">
		<param name="wmode" value="transparent">
		</object>';
        $divREsposta->add($ob_embed); */
        $div->add($divREsposta);

        return $div;

    }

    public function apendSendAll() {

        $div = new TElement('div');

        /*
        $button = new TElement('input');
        $button->type = "button";
        $button->onclick = "$('#respostaAudio').html('Enviando... Aguarde...');sendTest('codigo','telefoneTeste');";
        $button->name = "enviarMensagem";
        $button->id = "enviarMensagem";
        $button->class = "ui-corner-all ui-widget ui-state-default";
        $button->value = "Enviar";
       $div->add($button);
        */
        $button1 = new TElement('input');
        $button1->type = "button";
        $button1->onclick = "$('#respostaAudioAll').html('Enviando... Aguarde...');sendTest('codigo','all');";
        $button1->name = "enviarTeste";
        $button1->id = "enviarTeste";
        $button1->class = "ui-corner-all ui-widget ui-state-default";
        $button1->value = "Enviar para todos.";

        $div->add($button1);


        $divREsposta = new TElement('div');
        $divREsposta->id = "respostaAudioAll";
        $divREsposta->style = 'display: inline-block;margin-top: 5px;';
        /*
        $ob_embed = '<object type="application/x-shockwave-flash" data="../app.view/app.images/voz.swf" id="voiceplayer" width="290" height="24">
		<param name="movie" value="../app.view/app.images/voz.swf">
		<param name="FlashVars" value="playerID=1&amp;autostart=yes&amp;righticon=0x0000AA&amp;soundFile='.$obMsg->cdw_url.'">
		<param name="quality" value="high">
		<param name="menu" value="false">
		<param name="wmode" value="transparent">
		</object>';
        $divREsposta->add($ob_embed); */
        $div->add($divREsposta);

        return $div;

    }

    public function getAudioID($codigo) {
        $dbo = new TDbo('dbvoice_audio');
        $crit = new TCriteria();
        $crit->add(new TFilter('codigo','=',$codigo));
        $ret = $dbo->select('cdw_file',$crit);
        $ob = $ret->fetchObject();
        return $ob->cdw_file;
    }

    public function addDest($codigoMensagem,$telefone) {
        $dbo = new TDbo('dbvoice_ligacao');
        $data = array('codigomensagem'=>$codigoMensagem,'ativo'=>'1');
        $count = 0;
        if(is_array($telefone)) {
            foreach($telefone as $vl) {
                $data['call_dest'] = $vl;
                $ret = $dbo->insert($data);
                if($ret) {
                    $count++;
                }
            }
        }else {
            $data['call_dest'] = $telefone;
            $ret = $dbo->insert($data);
            if($ret) {
                $count++;
            }
        }

        return $count;

    }

    public function addAllDest($codigoMensagem,$telefones) {
        $data = array('codigomensagem'=>$codigoMensagem,'ativo'=>'1');
        $count = 0;

        $telefones = substr($telefones, 1, -1);

        $telefones = explode('||', $telefones);

        foreach($telefones as $ch=>$vl){
           $n = explode('=',$vl);           
           $_data[$n[0]] = $n[1];
        }
        
        $coluna = $_data['tipoTel'];

        unset($_data['tipoTel']);


        if(is_array($_data)) {

            $dbo_find = new TDbo('view_pessoas');
            $TCrit = new TCriteria();
            foreach($_data as $col => $filt){
                $filtro = new TFilter("$col","like","%$filt%");
                $TCrit->add($filtro,'AND');
                $filtro = new TFilter("$col","!=","");
                $TCrit->add($filtro,'AND');
            }
                $filtro = new TFilter("$coluna","!=","(__)____-____");
                $TCrit->add($filtro,'AND');


            $lista = $TCrit ? $dbo_find->select("codigo,$coluna", $TCrit) : $dbo_find->select("codigo,$coluna");


            $dbo = new TDbo();
            $dbo->setEntidade('dbvoice_ligacao');
            while($telefone = $lista->fetchObject()){
                $data['codigopessoa'] = $telefone->codigo;
                $data['call_dest'] = $telefone->$coluna;
                $ret = $dbo->insert($data);

                    $count++;
            }
            $dbo->commit();
            
        }
        return $count;
    }

    public function appendAddAll($idLista) {
        $div = new TElement('div');
        $div->add($idLista);

        return $div;
    }

    public function appendAddTel($argumento) {
        $header = new TSetHeader();
        $cabecalho = $header->getHead('21');

        $div = new TElement('div');
        $div->id = "singleDest_block";
        $input = new TElement('input');
        $input->id="add_dest_single";
        $input->class="ui-state-default ui_mascara_telefone";
        $input->name="add_dest_single";
        $input->value="";
        $input->type="text";
        $input->style="margin-top: 2px; margin-right: 2px; margin-bottom: 2px; margin-left: 4px; font-size: 12px;";

        $button = new TElement('input');
        $button->id="buttonSingleDest";
        $button->style="padding-left: 10px; padding-right: 10px; padding-top: 2px; padding-bottom: 2px; margin-top: 2px; margin-right: 2px; margin-bottom: 2px; margin-left: 4px; font-size: 12px; ";
        $button->name="buttonSingleDest";
        $button->type="button";
        $button->value="Adicionar";
        $button->class="ui-state-default ui-corner-all";
        $button->onclick = 'addSingleDest(\''.$cabecalho['codigoPai'].'\')';

        $div->add($input);
        $div->add($button);
        $div2 = new TElement('div');
        $div2->id = "singleDest_block_ret";
        $div2->add('');
        $div->add($div2);

        return $div;
    }

    public function appendAddListaPessoas($codigopai) {

        $div = new TElement('div');
        $header = new TSetHeader();
        $cabecalho = $header->getHead('21');

        $table = new TTable();
        $table->style = "font-size: 11px; text-align: left;";

        $parametros = array('nome' => array('name'=>'Nome'),
                'apelido' =>  array('name'=>'Apelido'),
                'tipo' =>  array('name'=>'Tipo'),
                'sexo' =>  array('name'=>'Sexo'),
                'endereco' =>  array('name'=>'Endereço'),
                'referencia' =>  array('name'=>'Referência'),
                'cidade' =>  array('name'=>'Cidade'),
                'estado' =>  array('name'=>'Estado'),
                'email' =>  array('name'=>'E-mail'),
                'profissao' =>  array('name'=>'Profissão'),
                'filhos' =>  array('name'=>'Filhos'),
                'ligacao' =>  array('name'=>'Ligação'),
                'casado' =>  array('name'=>'Casado'));

        $parametros['estado']['opt'] = array(
                'AC'=>'Acre',
                'AL'=>'Alagoas',
                'AP'=>'Amapá',
                'AM'=>'Amazonas',
                'BA'=>'Bahia',
                'CE'=>'Ceará',
                'DF'=>'Distrito Federal',
                'ES'=>'Espírito Santo',
                'GO'=>'Goiás',
                'MA'=>'Maranhão',
                'MT'=>'Mato Grosso',
                'MS'=>'Mato Grosso do Sul',
                'MG'=>'Minas Gerais',
                'PA'=>'Pará',
                'PB'=>'Paraíba',
                'PR'=>'Paraná',
                'PE'=>'Pernambuco',
                'PI'=>'Piauí',
                'RJ'=>'Rio de Janeiro',
                'RN'=>'Rio Grande do Norte',
                'RS'=>'Rio Grande do Sul',
                'RO'=>'Rondônia',
                'RR'=>'Roraima',
                'SC'=>'Santa Catarina',
                'SP'=>'São Paulo',
                'SE'=>'Sergipe',
                'TO'=>'Tocantins');

        $parametros['tipo']['opt'] = array(
            '1'=>'Eleitor',
            '2'=>'Líder',
            '3'=>'Autoridade'
        );

        $parametros['sexo']['opt'] = array(
            'F'=>'Feminino',
            'M'=>'Masculino'
        );

        $row = $table->addRow();


        $radio = new TRadioGroup('tipoTel');
        $radio->addItems(array('telefone_res' => 'Telefone Residencial','telefone_com' => 'Telefone Comercial','telefone_cel' => 'Telefone Celular'));


        $cell2 = $row->addCell();
        $cell2->colspan = "2";
        $cell2->add($radio);


        foreach($parametros as $ch=>$vl) {
            $row = $table->addRow();

            $campoReqMenu = new TCheckButton($ch.'_check');
            $campoReqMenu->setValue($ch);
            $campoReqMenu->setId($ch.'_check');
            $campoReqMenu->setProperty('onclick',"$('#".$ch."_filter').toggle()");

            $cell = $row->addCell();
            $cell->add($campoReqMenu);
            $cell->add($vl['name']);

            $input = new TElement('input');
            $input->type = 'text';
            $input->style = 'display: none;';
            $input->id = $ch."_filter";

            if(($ch == 'estado') or ($ch == 'tipo') or ($ch == 'sexo')) {
                $input = new TElement('select');
                $input->style = 'display: none;';
                $input->id = $ch."_filter";              

                    $option = new TElement('option');
                    $option->value = "0";
                    $option->add(' ');
                    $input->add($option);

                foreach($vl['opt'] as $ch4=>$vl4) {
                    $option = new TElement('option');
                    $option->value = "$ch4";
                    $option->add($vl4);
                    $input->add($option);
                }
            }

            $cell2 = $row->addCell();
            $cell2->add($input);
        }

        $button = new TElement('input');
        $button->id="buttonAllDest";
        $button->style="padding-left: 10px; padding-right: 10px; padding-top: 2px; padding-bottom: 2px; margin-top: 2px; margin-right: 2px; margin-bottom: 2px; margin-left: 4px; font-size: 12px; ";
        $button->name="buttonAllDest";
        $button->type="button";
        $button->value="Adicionar";
        $button->class="ui-state-default ui-corner-all";
        $button->onclick = 'addAllDest(\''.$cabecalho['codigoPai'].'\')';

        $div = new TElement('div');
        $div->id = "allDestForm";
        $div->add($table);
        $div->add($button);
        $div2 = new TElement('div');
        $div2->id = "allDest_block_ret";
        $div2->add('');
        $div->add($div2);

        return $div;
    }


    public function getSaldo(){
        $dbo = new TDbo('dbvoice_ligacao');
        $crit = new TCriteria();
        $crit->add(new TFilter('paid','!=','1'));
        $ret = $dbo->select('call_dest,call_cd_time_sec',$crit);

        $Unidade = new TUnidade();
        $parametros = $Unidade->getParametro();
        if($ret){
        $saldo = $parametros->voice_saldo;
        while($ob = $ret->fetchObject()){
            if(substr($ob->call_dest,4,1) < 5){
                $saldo = $saldo - ceil($ob->call_cd_time_sec/$parametros->voice_sectarifa) * $parametros->voice_tarifafixo;
            }else{
                $saldo = $saldo - ceil($ob->call_cd_time_sec/$parametros->voice_sectarifa) * $parametros->voice_tarifacel;
            }


        }
        $dbo = new TDbo('dbvoice_ligacao');
        $crit = new TCriteria();
        $crit->add(new TFilter('paid','!=','1'));
        $ret = $dbo->update(array('paid'=>'1'),$crit);
        $Unidade->setParametro('voice_saldo', $saldo);
        }
        return $saldo;

    }

    public function getEstatisticas(){
        $Unidade = new TUnidade();
        $parametros = $Unidade->getParametro();

        $ret->saldo = $this->getSaldo();
        
        $ret->enviosFixo = ceil($ret->saldo/$parametros->voice_tarifafixo);
        $ret->enviosCel = ceil($ret->saldo/$parametros->voice_tarifacel);

        $dbo = new TDbo('view_voice_mensagem');
        $crit = new TCriteria();
        $crit->add(new TFilter('ativo','=','1'));
        $crit->setProperty('limit', '5');
        $crit->setProperty('order by', 'datacad desc');
        $retOb = $dbo->select('*',$crit);

        while($ob = $retOb->fetchObject()){
            $ret->mensagem[$ob->codigo]['label'] = $ob->label;
            $ret->mensagem[$ob->codigo]['envios'] = $ob->count_envios;
            $ret->mensagem[$ob->codigo]['atendimentos'] = $ob->count_atendimentos;
            $ret->mensagem[$ob->codigo]['aproveitamento'] = number_format((round((100 * $ob->count_atendimentos / $ob->count_envios) * 100) / 100),2,',','') . '%';
            $ret->mensagem[$ob->codigo]['media'] = $ob->avg_time;
            $ret->mensagem[$ob->codigo]['fixos'] = $ob->count_destfixo;
            $ret->mensagem[$ob->codigo]['celulares'] = $ob->count_destcel;
            $ret->mensagem[$ob->codigo]['fixos_porcentagem'] = number_format((round(((100 *  $ob->count_destfixo)/($ob->count_destfixo + $ob->count_destcel)) * 100) / 100),2,',','') . '%';;
            $ret->mensagem[$ob->codigo]['celulares_porcentagem'] = number_format((round(((100 *  $ob->count_destcel)/($ob->count_destfixo + $ob->count_destcel)) * 100) / 100),2,',','') . '%';




        }

        return $ret;


    }

    public function dashBoard($item){
        $model = new TSetModel();

        $infos = $this->getEstatisticas();

        $div = new TElement('div');

        $campanhas = new TElement("fieldset");
        $campanhas->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
        $campanhas->style = "height: 100%; text-align: left;";
        $campanhasLegenda = new TElement("legend");
        $campanhasLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
        $campanhasLegenda->add("Ultimas Campanhas");
        $campanhas->add($campanhasLegenda);

        $divCampanhas = new TElement('div');


            $spanMsg = new TElement('span');
            $spanMsg->style = "display: block;";
            $spanMsg->add('<table border=0 width="100%" rowspacin=5 >');
        foreach($infos->mensagem as $msg){

            $spanMsg->add('<tr><td style="font-size: 20px; text-align: left; font-weight: bolder; vertical-align: bottom; margin-bottom: 5px;"><span style="font-size: 10px; font-weight: normal;">Mensagem</span><br/>'.$msg['label'].'<td/><td style="font-size: 14px; text-align: right; font-weight: bolder; vertical-align: bottom; margin-bottom: 5px"><span style="margin-bottom: 4px; font-size: 10px; font-weight: normal;">Envios/Atend.</span><br/>'.$msg['envios'].'/'.$msg['atendimentos'].'</td><td style="font-size: 14px; text-align: right; font-weight: bolder; vertical-align: bottom; margin-bottom: 5px"><span style="margin-bottom: 4px; font-size: 10px; font-weight: normal;">Aproveitamento</span><br/>'.$msg['aproveitamento'].'</td><td style="font-size: 14px; text-align: right; font-weight: bolder; vertical-align: bottom; margin-bottom: 5px"><span style="margin-bottom: 4px; font-size: 10px; font-weight: normal;">Celulares</span><br/>'.$msg['celulares'].' ('.$msg['celulares_porcentagem'].')</td><td style="font-size: 14px; text-align: right; font-weight: bolder; vertical-align: bottom; margin-bottom: 5px"><span style="margin-bottom: 4px; font-size: 10px; font-weight: normal;">Fixos</span><br/>'.$msg['fixos'].' ('.$msg['fixos_porcentagem'].')</td></tr><tr><td colspan="5" style="font-size: 11px; height: 10px"> </td></tr>');

        }
        $spanMsg->add('</table>');
            $divCampanhas->add($spanMsg);
        $campanhas->add($divCampanhas);

        $saldo_valor = 'R$ ' . $model->setMoney($infos->saldo);

        $saldo = new TElement("fieldset");
        $saldo->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
        $saldo->style = "height: 100%;";
        $saldoLegenda = new TElement("legend");
        $saldoLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
        $saldoLegenda->add("Saldo");
        $saldo->add($saldoLegenda);

        $divSaldo = new TElement('div');
        $divSaldo->style = "text-align: center; font-size: 12px; margin-top: 20px";
        $divSaldo->add("<b>Valor em créditos: </b><br/><span style = 'display:inline; font-size: 30px; font-weight: bolder;'>$saldo_valor</span><br/>");
        $divSaldo->add("<table border=0><tr><td style='padding: 10px; text-align: left; font-size: 11px'>Aprox. <b>".$infos->enviosFixo."</b><br/> envios para telefones fixos.</td><td style='padding: 10px; text-align: right; font-size: 11px'>Aprox. <b>".$infos->enviosCel."</b><br/> envios para telefones celulares.</td></tr></table>");
        $saldo->add($divSaldo);

        $dicas = new TElement("fieldset");
        $dicas->class = " ui_bloco_fieldset ui-corner-all ui-widget-content";
        $dicas->style = "height: 100%;";
        $dicasLegenda = new TElement("legend");
        $dicasLegenda->class = "ui_bloco_legendas ui-widget-content ui-corner-all";
        $dicasLegenda->add("Dicas");
        $dicas->add($dicasLegenda);
        $dicasDiv = new TElement('div');
        $dicasDiv->style = "text-align: center; font-size: 11px; text-align:justify";
        $dicasDiv->add('<b>Qualidade de Som: </b> As mensagens gravadas sem o uso de TSS devem contem o minimo de elementos, pois a conversão necessita trabalhar no limite de <i>8 Hrz</i>.');

        $dicas->add($dicasDiv);


        $table = new TTable();
        $table->width = "100%";
        $table->height = "400px";

        $row = $table->addRow();
        $cell = $row->addCell($campanhas,'th');
        $cell->rowspan = "2";
        $cell->width = "70%";
        $cell->style = "vertical-align: top;";

        $cell2 = $row->addCell($saldo);
        $cell2->style = "vertical-align: top;";

        $row->height = '200px';

        $row2 = $table->addRow();
        $cell1 = $row2->addCell($dicas);
        $cell1->colspan = 2;
        $cell1->style = "vertical-align: top;";

        $div->add($table);
        return $div;
    }

}


?>
