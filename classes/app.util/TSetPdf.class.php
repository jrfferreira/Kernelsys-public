<?php
/**
 * Description of TSetPdf
 *
 * author Wagner
 */


    //inclui FPDF
    require("fpdf/fpdf.php");

class TSetPdf extends FPDF{
    
    /**
     * configura o cabe�alho do pdf
     */
    public function Header(){
        //Logo
        $this->Image('../app.view/app.images/Logtops.jpg',10,8,33);
        //Arial bold 15
        $this->SetFont('Arial','B',15);
        //Move to the right
        $this->Cell(80);
        //Title
        $this->Cell(80,10,'Este � o verdadeiro titulo',1,0,'C');
        //Line break
        $this->Ln(20);
    }

    //Define o rodap� da pagina
    function Footer(){
        //Position at 1.5 cm from bottom
        $this->SetY(-15);
        //Arial italic 8
        $this->SetFont('Arial','I',8);
        //Page number
        $this->Cell(0,10,'Page '.$this->PageNo().'/{nb}',0,0,'C');
    }


    public function setConteudo($conteudo){
        $this->MultiCell(0,5,$conteudo,0,1,'J');
    }


}

$pdf = new TSetPdf();
$pdf->AliasNbPages();
$pdf->AddPage();
$pdf->SetFont('Arial','',12);

//$pdf->setTitulo('Estou � testar o pdf');
//$pdf->setConteudo('ds fadsfd dsfasdfasd fadsf asdfkjahd fadsjfh asdklshf jdsfh alsdkj hsdkjf sdlfj hasdfjkahdslfkjhdsfk jsdhflkajshflaj');

for($i=1;$i<=40;$i++){
  $pdf->Cell(0,10,'Printing line number '.$i,0,1);
}
$pdf->Output();
?>