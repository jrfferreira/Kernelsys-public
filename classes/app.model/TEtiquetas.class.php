<?php
/*
class TEtiquetas {

    public $line = array();

    public function __construct($espHorizontal, $espVertical, $largura, $altura, $margemEsq, $margemSup, $colunas, $linhas) {
        $this->espHorizontal = $espHorizontal;
        $this->espVertical = $espVertical;
        $this->largura = $largura;
        $this->altura = $altura;
        $this->margemEsq = $margemEsq;
        $this->margemSup = $margemSup;
        $this->colunas = $colunas;
        $this->linhas = $linhas;
    }

    public function addLine($etiqueta1, $etiqueta2 = null) {
        $this->line[] = array($etiqueta1, $etiqueta2);
    }

    public function show() {

        $model = '<?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1 plus MathML 2.0//EN" "http://www.w3.org/TR/MathML2/dtd/xhtml-math11-f.dtd">
        <html xmlns="http://www.w3.org/1999/xhtml">
        <head profile="http://dublincore.org/documents/dcmi-terms/">
        <meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8"/>
        <title xml:lang="en-US">Etiquetas</title><meta name="DCTERMS.title" content="" xml:lang="en-US"/><meta name="DCTERMS.language" content="en-US" scheme="DCTERMS.RFC4646"/><meta name="DCTERMS.source" content="http://xml.openoffice.org/odf2xhtml"/><meta name="DCTERMS.creator" content="João Felix"/><meta name="DCTERMS.issued" content="2010-08-05T20:30:04" scheme="DCTERMS.W3CDTF"/><meta name="DCTERMS.contributor" content="João Felix"/><meta name="DCTERMS.modified" content="2010-08-05T20:31:16" scheme="DCTERMS.W3CDTF"/><meta name="DCTERMS.provenance" content="" xml:lang="en-US"/><meta name="DCTERMS.subject" content="," xml:lang="en-US"/><link rel="schema.DC" href="http://purl.org/dc/elements/1.1/" hreflang="en"/><link rel="schema.DCTERMS" href="http://purl.org/dc/terms/" hreflang="en"/><link rel="schema.DCTYPE" href="http://purl.org/dc/dcmitype/" hreflang="en"/><link rel="schema.DCAM" href="http://purl.org/dc/dcam/" hreflang="en"/><base href="."/><style type="text/css">
	@page {  }
	table { border-collapse:collapse; border-spacing:0; empty-cells:show }
	td, th { vertical-align:top; font-size:12pt;}
	h1, h2, h3, h4, h5, h6 { clear:both }
	ol, ul { margin:0; padding:0;}
	li { list-style: none; margin:0; padding:0;}
	<!-- "li span.odfLiEnd" - IE 7 issue-->
	li span. { clear: both; line-height:0; width:0; height:0; margin:0; padding:0; }
	span.footnodeNumber { padding-right:1em; }
	span.annotation_style_by_filter { font-size:95%; font-family:Arial; background-color:#fff000;  margin:0; border:0; padding:0;  }
	* { margin:0;}
        .etiq {width: ' . $this->largura . 'cm; height: ' . $this->altura . 'cm; vertical-align:middle; padding: 0.5cm;}
	.P1 {font-size:11pt; font-family: arial,verdana,Times New Roman; writing-mode:lr-tb; margin-left:0.27cm; margin-right:0.27cm; text-indent:0cm; }
	.Standard { font-size:12pt; font-family:Times New Roman; writing-mode:lr-tb; }
	.Table1 { width:20.796cm; margin-left:-0.026cm; writing-mode:lr-tb; }
	.Table1_A1 { vertical-align:middle; padding-left:0.026cm; padding-right:0.026cm; padding-top:0cm; padding-bottom:0cm; border-style:none; }
	.Table1_A { width:10.16cm; }
	.Table1_B { width:0.476cm; }
	.Table1_1 { height:3.387cm; }
	<!-- ODF styles with no properties representable as CSS -->
	.Endnote_20_Symbol .Footnote_20_Symbol { }
	</style>
        </head>
        <body dir="ltr" style="max-width:21.59cm;margin-top:2.117cm; margin-bottom:0cm; margin-left:0.397cm; margin-right:0.397cm; ">
        <table border="0" cellspacing="0" cellpadding="0" class="Table1">
            <colgroup>
                <col width="444"/>
                <col width="21"/>
                <col width="444"/>
           </colgroup>';

        foreach ($this->line as $vl) {
            $model .= '<tr class="Table11">
            <td style="text-align:left;width:10.16cm; " class="Table1_A1">
                <p class="P1 etiq">' . $vl[0] . '</p>
            </td>
            <td style="text-align:left;width:0.476cm; " class="Table1_A1">
                <p class="P1"> </p>
            </td>
            <td style="text-align:left;width:10.16cm; " class="Table1_A1">
                <p class="P1 etiq">' . $vl[1] . '</p>
            </td>
           </tr>';
        }
        $model .= '</table><p class="Standard"></p></body></html>';

        return $model;
    }

    public function apendiceImprimir($idForm) {
        $div = new TElement('div');
        $button1 = new TElement('input');
        $button1->type = "button";
        $button1->onclick = "showEtiquetas(" . $idForm . ")";
        $button1->name = "showEtiquetas-8062";
        $button1->id = "showEtiquetas-8062";
        $button1->class = "ui-corner-all ui-widget ui-state-default";
        $button1->value = "Imprimir Etiquetas\r(Padrão 8062).";

        $div->add($button1);

        $divREsposta = new TElement('div');
        $divREsposta->id = "respostashowEtiquetas";
        $divREsposta->style = 'display: inline-block;margin-top: 5px;';
        $div->add($divREsposta);

        return $div;
    }

}
 * */
?>


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
 public function apendiceEtiquetasLivros($idForm) {
        $div = new TElement('div');
        $button1 = new TElement('input');
        $button1->type = "button";
        $button1->onclick = "showEtiquetas(" . $idForm . ")";
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
?>