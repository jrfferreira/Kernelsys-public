<?php
//-------------------------------------------------------------------------
//
//
//-------------------------------------------------------------------------

class TSetPesquisa {

    private $obWindow = NULL;
    private $obLista = NULL;

    public function __construct($listseq) {

        $this->obsession = new TSession();

        $this->obWindow = new TWindow('Pesquisa', $listseq.'-window');
        //$this->obWindow->setPosition(250, 15);
        $this->obWindow->setAutoOpen();
        $this->obWindow->setDraggable();
        $this->obWindow->setSize(900, 500);

        $conteiner = new TElement("div");
        $conteiner->id = TConstantes::CONTEINER_PESQUISA.$listseq;

        $this->obLista = new TCompLista($listseq);
        $lista = $this->obLista->get();

        $listDados = $this->obLista->getListDados();

        $conteiner->add($lista->getLista());
        $this->obWindow->add($conteiner);

    }
    
    /**
     * 
     */
    public function show() {
        $this->obWindow->show();
    }

}