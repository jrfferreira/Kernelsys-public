
function checkedItens(){	
	
	
    $('#truePrint').html($(':checked').map(function(i,v,m){
        return $('#'+v.value).html();
    }).get().join('<br><br> ') );


    $('#truePrint').css({
        'overflow-y' : 'scroll',
        'height' : '450'

    });
    $('#truePrint *').css({
        'border' : '0px solid #fff' ,
        'font-family' : 'Verdana, Geneva, Arial, Helvetica, sans-serif' ,
        'font-size': '12px',
        'backgroun-color': '#FFF'
    });
											
}

function printScreen(impressao,titulo){

    $('<span id="state0" position="position: relative; display:none;" title="Impressão"></span>').prependTo('#winRet');
    $('<span id="state1"  position="position: relative; display:none;" title="Visualização"></span>').prependTo('#winRet');
    $('<div id="truePrint"></div>').appendTo('#state1');

        //Cria CheckBox
    $('div').each(function(i,v,m){
        $("."+impressao+i).each(function(x,v,m){

            $("<input type='checkbox' name='#"+v.id+"' value='"+v.id+"' onclick='checkedItens()'/>"+$("."+titulo+i).html()+"<br>").appendTo('#state0');

        });
    });

    $('#state0').dialog({
        modal: true,
        autoOpen: true,
        width: 600,
        buttons: {
            "Visualizar": function(){
                $(this).dialog("close");
                $('#state1').dialog('open');

            },
            "Cancelar": function(){
                $(this).dialog("close");
                
            }
        },
        close: function() {
            $('#state0').remove();
        }

    });

     $('#state1').dialog({
         modal: true,
        autoOpen: false,
        width: 700,
        height: 500,
        buttons: {
            "Imprimir": function(){
                $('#truePrint > *').jqprint();
            },
            "Cancelar": function(){
                $(this).dialog("close");
            }
         },

        close: function() {
            $('#state0').remove();
            $('#state1').remove();
        }
    });
    

				
														
				
			
				
                                
}