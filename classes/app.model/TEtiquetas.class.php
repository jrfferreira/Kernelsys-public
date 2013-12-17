<?php

class TEtiquetas {

    public $line = array();

    public function setDiagramacao($espHorizontal, $espVertical, $largura, $altura, $margemEsq, $margemSup, $colunas, $linhas) {
        
        $this->espHorizontal = number_format(preg_replace('/[,.]/i','.',$espHorizontal), 2, '.', '');
        $this->espVertical = number_format(preg_replace('/[,.]/i','.',$espVertical), 2, '.', '');
        $this->largura = number_format(preg_replace('/[,.]/i','.',$largura), 2, '.', '');
        $this->altura = number_format(preg_replace('/[,.]/i','.',$altura), 2, '.', '');
        $this->margemEsq = number_format(preg_replace('/[,.]/i','.',$margemEsq), 2, '.', '');
        $this->margemSup = number_format(preg_replace('/[,.]/i','.',$margemSup), 2, '.', '');
        $this->colunas = number_format(preg_replace('/[,.]/i','.',$colunas), 2, '.', '');
        $this->linhas = number_format(preg_replace('/[,.]/i','.',$linhas), 2, '.', '');
    }

// Variaveis de Tamanho

    public function addDados($array){
        $this->array = $array;
    }

    public function geraPDF() {
        $mesq = $this->margemEsq; // Margem Esquerda (mm)
        //$mdir = "5"; // Margem Direita (mm)
        $msup = $this->margemSup; // Margem Superior (mm)
        $leti = $this->largura; // Largura da Etiqueta (mm)
        $aeti = $this->altura; // Altura da Etiqueta (mm)
        $esph = $this->espHorizontal; // Espaço horizontal entre as Etiquetas (mm)
        $espv = $this->espVertical; // Espaço horizontal entre as Etiquetas (mm)
        $pdf = new PDF_Code128('P', 'cm', 'Letter'); // Cria um arquivo novo tipo carta, na vertical.
        $pdf->Open(); // inicia documento
        $pdf->AddPage(); // adiciona a primeira pagina
        $pdf->SetMargins($mesq, $msup); // Define as margens do documento
        $pdf->SetAuthor("PetrusCOM"); // Define o autor
        $pdf->SetFont('helvetica', '', 7); // Define a fonte
        $pdf->SetDisplayMode('fullpage');

        $coluna = 0;
        $linha = 0;
        
        foreach($this->array as $ch => $vl) {

            if ($coluna >= $this->colunas) { // Se for a ultima coluna
                $coluna = 0; // $coluna volta para o valor inicial
                $linha = $linha + 1; // $linha é igual ela mesma +1
            }

            if ($linha >= $this->linhas) { // Se for a última linha da página
                $pdf->AddPage(); // Adiciona uma nova página
                $linha = 0; // $linha volta ao seu valor inicial
            }

            $posicaoV = $linha * $aeti;
            $posicaoH = $coluna * $leti;

            if ($coluna == "0") { // Se a coluna for 0
                $somaH = $mesq; // Soma Horizontal é apenas a margem da esquerda inicial
            } else { // Senão
                $somaH = $mesq + $posicaoH; // Soma Horizontal é a margem inicial mais a posiçãoH
            }

            if ($linha == "0") { // Se a linha for 0
                $somaV = $msup; // Soma Vertical é apenas a margem superior inicial
            } else { // Senão
                $somaV = $msup + $posicaoV; // Soma Vertical é a margem superior inicial mais a posiçãoV
            }

            $vetInfo = $somaV;
            foreach($vl as $dado){
                if(preg_match('|(BarCode)\/|i',$dado)){
                 $pdf->Code128(($somaH + 4),($vetInfo - 2.2),preg_replace('|(BarCode)\/|i','',$dado),'6','2');
                }else{
                 $pdf->Text(($somaH + 0.2), $vetInfo, utf8_decode($dado));
                 $vetInfo = $vetInfo + 0.4;
                }
            }
            $coluna = $coluna + 1;
        }
        ob_clean();
        $pdf->Output(md5(date('Y-m-d H:i:s')).'.pdf','I');
    }
 public function apendiceEtiquetasLivros($formseq) {
        $div = new TElement('div');
        $button1 = new TElement('input');
        $button1->type = "button";
        $button1->onclick = "showEtiquetas(" . $formseq . ")";
        $button1->name = "showEtiquetas-6181";
        $button1->id = "showEtiquetas-6181";
        $button1->class = "ui-corner-all ui-widget ui-state-default";
        $button1->value = "Imprimir Etiquetas\r(Padrão 6181).";

        $div->add($button1);

        $divREsposta = new TElement('div');
        $divREsposta->id = "respostashowEtiquetas";
        $divREsposta->style = 'display: inline-block;margin-top: 5px;';
        $div->add($divREsposta);

        return $div;
    }
}