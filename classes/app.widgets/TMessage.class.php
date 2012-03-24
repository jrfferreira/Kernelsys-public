<?php
/**
 * classe TMessage
 * Exibe mensagens ao usu�rio
 */
class TMessage{
    /**
     * método construtor
     * exibe a mensagem final
     * param  $type    = tipo de mensagem (info, error)
     * param  $message = mensagem ao usu�rio
     *
     */

	

    public function __construct($type, $message){
                        
        // instancia o painel para exibir o di�logo
        $painel = new TElement('div');
        $painel->class = "ui-widget";
        $painel->id    = "tmessage";
        
        // cria um bot�o que vai fechar o di�logo
        $button = new TElement('input');
        $button->type = 'button';
        $button->value = 'Fechar';
        $button->onclick="document.getElementById('tmessage').style.display='none'";
        
        $div = new TElement('div');
        $div->class = "ui-state-alert ui-corner-all";
        $div->style = "padding: 0 .7em;";

        $content = new TElement('p');

        $strong = new TElement('strong');
        $strong->add($message);

        $span = new TElement('span');
        $span->class = "ui-icon ui-icon-alert";
        $span->style = "float: left; margin-right: .3em;";


        $content->add($span);
        $content->add($strong);

        $div->add($content);
        //$div->add($button);

        // adiciona a tabela ao pain�l
        $painel->add($div);
        // exibe o painel
        //$painel->show();

        //gera janela
        $window = new TWindow($type, "windowAlert_model");
        $window->setAutoOpen();
        $window->setModal(true);
        $window->setSize(600, 200);
        $window->add($painel);

        $window->show();

    }
}