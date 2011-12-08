<?php
//-------------------------------------------------------------------------
//
//
//-------------------------------------------------------------------------

class TSetPesquisa {

    private $obWindow = NULL;
    private $obLista = NULL;

    public function __construct($idLista, $tipo) {

        $this->obsession = new TSession();

        $this->obWindow = new TWindow('Pesquisa', $idLista.'-window');
        //$this->obWindow->setPosition(250, 15);
        $this->obWindow->setAutoOpen();
        $this->obWindow->setDraggable();
        $this->obWindow->setSize(900, 500);

        $conteiner = new TElement("div");
        $conteiner->id = 'contPesquisa'.$idLista;

        $this->obLista = new TCompLista($idLista, 'contPesquisa'.$idLista);
        $lista = $this->obLista->get();

        $listDados = $this->obLista->getListDados();

        $conteiner->add($lista->getLista());
        $this->obWindow->add($conteiner);

    }
    
    public function show() {
        $this->obWindow->show();
    }

}
?>