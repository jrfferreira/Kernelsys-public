<html>
    <body style ="background-color: #f2f4f6">
<?php

function __autoload($classe) {
    include_once('../app.util/autoload.class.php');
    $autoload = new autoload('../',$classe);
}
        $chartEntrada = new TChart('Gráfico de Entradas', '1000', '500');
        $chartEntrada->addLabel(array('Jan','Fev','Mar','Abr','Mai','Jun'));
        $chartEntrada->addPoint(array(785,55777,887557,786,577489,85157),'Caixa');
        $chartEntrada->setAxisName("Saldo (R$)");
        $imgChart = $chartEntrada->show('line');
        $imgChart->show();

?>
    </body>
</html>