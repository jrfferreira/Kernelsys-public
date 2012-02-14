<?php
/*
 * Classe especifica para replicação de registros.
 */
class TCloneForm {

    /*
     *
     * Classe para clonagem de formularios
     *
     * @author      João Felix
     * @package     PetrusEDU
     * @name        TCloneForm.class.php
     * @version     1.0.0
     *
     * @todo Mudar a clonagem para referenciar a hierarquia de formulario e não de tabelas
     */

    private $form = null;
    private $codigo = null;
    private $clones = 1;

    function __construct() {
        $this->dbok = new TKrs();
    }


    /*
     * Função de clonagem
     *
     * @param string $id Id do Formulario
     * @param string $cod Codigo do Elemento
     * @param string $clon Quantidade de clones
     */
    public function run($id, $cod, $clon) {
        $this->form = $id;
        $this->codigo = $cod;
        $this->clones = $clon;

        try {
            $this->dbok->setEntidade('forms');
            $critForm = new TCriteria();
            $critForm->add(new TFilter('id', '=', $this->form));
            $retForm = $this->dbok->select('*', $critForm);
            $obForm = $retForm->fetchObject();

            $this->dbok->setEntidade('form_x_tabelas');
            $critTab = new TCriteria();
            $critTab->add(new TFilter('formid', '=', $this->form));
            $critTab->add(new TFilter('ativo', '=', '1'));
            $retTab = $this->dbok->select('tabelaid', $critTab);


            $this->dbok->setEntidade('tabelas');
            $critTabela = new TCriteria();
            while ($obTab = $retTab->fetchObject()) {
                $critTabela->add(new TFilter('id', '=', $obTab->tabelaid), 'OR');
            }
            $retTabela = $this->dbok->select('*', $critTabela);


            $this->dbo = new TDbo();

            while ($obTabela = $retTabela->fetchObject()) {
                if ($obTabela->id == $obForm->entidade) {
                    $tabelas['p'] = $obTabela;
                } else {
                    $tabelas['c'][$obTabela->id] = $obTabela;
                }
            }

            $this->dbo->setEntidade($tabelas['p']->tabela);
            $critRegistro = new TCriteria();
            $critRegistro->add(new TFilter('codigo', '=', $this->codigo));
            $retRegistro = $this->dbo->select('*', $critRegistro);

            $obRegistro = $retRegistro->fetchObject();

            foreach ($obRegistro as $ch => $vl) {
                if (($ch != 'id') and ($ch != 'codigo') and ($ch != 'unidade') and ($ch != 'codigoautor') and ($ch != 'datacad') and ($ch != 'ativo')) {
                    $obNovoRegistro[$ch] = $vl;
                }
            }
            $obNovoRegistro['ativo'] = '8';
            if ($obNovoRegistro) {
                $n = $this->clones;
                while($n > 0) {
                    $this->dbo->setEntidade($tabelas['p']->tabela);
                    $novoRegistro = $this->dbo->insert($obNovoRegistro);
                    if ($novoRegistro['codigo']) {
                        if ($colunafilho = $tabelas['p']->colunafilho) {
                            foreach ($tabelas['c'] as $children) {
                                $this->dbo->setEntidade($children->tabela);
                                $critRegistroFilho = new TCriteria();
                                $critRegistroFilho->add(new TFilter("$colunafilho", '=', "$this->codigo"));
                                $retRegistroFilho = $this->dbo->select('*', $critRegistroFilho);

                                while ($obRegistroFilho = $retRegistroFilho->fetchObject()) {
                                    foreach ($obRegistroFilho as $ch => $vl) {
                                        if (($ch != 'id') and ($ch != 'codigo') and ($ch != 'unidade') and ($ch != 'codigoautor') and ($ch != 'datacad') and ($ch != 'ativo')) {
                                            $obNovoRegistroFilho[$ch] = $vl;
                                        }

                                        $obNovoRegistroFilho['ativo'] = '8';
                                    }

                                    $obNovoRegistroFilho[$tabelas['p']->colunafilho] = $novoRegistro['codigo'];

                                    $this->dbo->setEntidade($children->tabela);
                                    $ret = $this->dbo->insert($obNovoRegistroFilho);

                                    unset($obNovoRegistroFilho);
                                    if (!$ret) {
                                        throw new ErrorException("Erro durante a replicação dos registros dependentes.");
                                    }
                                }
                            }
                        }
                    } else {
                        throw new ErrorException("Erro na replicação do registro principal");
                    }
                    $n = $n-1;
                }

                        $this->dbo->commit();
            } else {
                throw new ErrorException("O registro indicado para a replicação não existe.");
            }
        } catch (Exception $e) {
            $this->dbo->rollback();
            new setException($e);
        }
    }

    public function confirm($id, $cod, $lista) {
        $this->form = $id;
        $this->codigo = $cod;
        $this->lista = $lista;

        $texto = "<p><b>Atenção,<br/> as alterações feitas pela replicação não poderam ser revertidas.</b></p>";
        $texto .= "<p>Você deseja realmente continuar?</p>";

        $alerta = new TElement("fieldset");
        $alerta->class = " ui_bloco_fieldset ui-corner-all ui-widget-content ui-state-highlight";
        $alerta->add($texto);

        $clonagem = new TElement("fieldset");
        $clonagem->class = "ui_bloco_fieldset ui-corner-all ui-widget-content";
        $clonagem->add("Quantidade de replicações:");

        $campo = new TEntry('quantidadeReplicacoes');
        $campo->id = 'quantidadeReplicacoes';
        $campo->value = 1;
        $clonagem->add($campo);
        $alerta->add($clonagem);

        $cont = new TElement('div');
        $cont->add($alerta);

        $button = new TElement('input');
        $button->type = "button";
        $button->onclick = "cloneForm('" . $this->form . "','" . $this->codigo . "','".$this->lista."',$('#quantidadeReplicacoes').val());";
        $button->name = "replicarForm";
        $button->id = "replicarForm";
        $button->class = "ui-corner-all ui-widget ui-state-default";
        $button->style = "font-weight:bold; font-size: 30px;";
        $button->value = "Replicar";

        $cancelar = new TElement('input');
        $cancelar->type = "button";
        $cancelar->onclick = "$('#confirmReplicacao').remove()";
        $cancelar->name = "cancelar";
        $cancelar->id = "cancelar";
        $cancelar->class = "ui-corner-all ui-widget ui-state-default";
        $cancelar->style = "font-weight:bold; font-size: 30px;";
        $cancelar->value = "Cancelar";
        // $cont_botoes = new TElement('div');
        // $cont_botoes->add($button);

        $window = new TWindow('Confirmação', 'confirmReplicacao');
        $window->setModal();
        $window->setAutoOpen();
        $window->setSize('450', '170');
        $window->add($cont);
        $window->addButton($button);
        $window->addButton($cancelar);

        $window->show();
    }

}
?>
