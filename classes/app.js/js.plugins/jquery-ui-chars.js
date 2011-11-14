function jquerybarChar(vals,titulos){

    $('<div id="char0" title="Gr�fico" style="text-align:center"></div>').appendTo('html');
    $('<div id="charView"></div>').appendTo('#char0');

    line = vals.split(";");
    tits = titulos.split(";");

line1 = [];

    var i = 0;
    while(i<line.length){
        line1.push([ tits[i] , parseFloat(line[i]) ]);
        //alertPetrus(i+' - '+[tits[i],line[i]]);
        i += 1;
    }

    $.jqplot('charView', [line1], {
        legend: {
            show: true
        },
        title: 'Gr�fico',
        seriesDefaults: {
            renderer: $.jqplot.BarRenderer,
            rendererOptions: {
                barPadding: 10,
                barMargin: 10
            }
        },

        axes: {
            xaxis: {
                renderer: $.jqplot.CategoryAxisRenderer
            },
            yaxis: {
                min:0,
                tickOptions: {
                    formatString: '%d'
                }
            }
        }
    });

    $('#char0').dialog({
        modal: true,
        autoOpen: true,
        width: 650,
        close: function() {
            $('#char0').remove();
        }

    });

}

function jqueryPieChar(vals,titulos){

    $('<div id="char0" title="Gr�fico" style="text-align:center"></div>').appendTo('html');
    $('<div id="charView"></div>').appendTo('#char0');


    var line = vals.split(";");
    var tits = titulos.split(";");


    var line1 = [];
    var i = 0;
    while(i<line.length){
        line1.push([ tits[i] , parseFloat(line[i]) ]);
        //alertPetrus(i+' - '+[tits[i],line[i]]);
        i += 1;
    }



    $.jqplot('charView', [line1], {
        title: 'Gr�fico',
        seriesDefaults:{
            renderer:$.jqplot.PieRenderer,
            rendererOptions:{
                sliceMargin:5
            }
        },
        legend:{
            show:true
        }
    });

    $('#char0').dialog({
        modal: true,
        autoOpen: true,
        width: 450,
        close: function() {
            $('#char0').remove();
        }

    });

}
