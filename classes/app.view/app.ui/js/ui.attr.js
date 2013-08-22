


function atribuicao() {

	var attrStatus = true;
	$('body').find('#addAll:checkbox').parent().parent().parent().find('input:checkbox[checked!=true][id!=addAll]').each(function(){
	   if($(this).attr('checked') == false){
	       attrStatus = false;
	   }
	})
	
	//$('.tabs').css({'border':'1px solid #ff0000'});
	
	
	   $('body').find('#addAll:checkbox').attr('checked',attrStatus);
	
    $('body').find('.tdatagrid_col').each(function() {
        $(this).hover(function() {
            $(this).addClass('tdatagrid_col_over');
        }, function() {
            $(this).removeClass('tdatagrid_col_over');
        });
    });
    // *********************************************************************
    // INICIO - jQuery - Atribuição de Padronização CSS
    // *********************************************************************
   /* $('body').find('.remarkable').each(function() {
        $(this).click(function(e){
            if(e.ctrlKey) {
                var mark = $(this).attr('marked') == 'true' ? 'false' : 'true';
                $(this).attr('marked',mark).toggleClass('ui-widget-header');
            }else{
                $('.remarkable').attr('marked','false').removeClass('ui-widget-header');
            }
        })
    });
    */


    $('body').find('.tdatagrid_row').each(function() {
        $('.tdatagrid_row:odd').addClass('tdatagrid_row1');
        $('.tdatagrid_row:even').addClass('tdatagrid_row2');

        $('.tdatagrid_row[situacao=1]').addClass('');
        $('.tdatagrid_row[situacao=8]').addClass('ui-state-highlight');
        $('.tdatagrid_row[situacao=9]').addClass('ui-state-error');

        $(this).hover(function() {
            $(this).addClass('ui-state-hover');
        }, function() {
            $(this).removeClass('ui-state-hover');
        });
    });

    $('body').find('div').css('font-size', '11');

    $('.ui_bloco_legendas').click(function(){
        $(this).parent().children('.ui_bloco_conteudo').toggle()
    });

        

    //Função para enter avançar campo

   // $('body').find('.ui-tabs-panel').each(function(){

   //     textboxes = $("input, select, textarea");

   //     if ($.browser.mozilla) {
   //         $(textboxes).keypress (checkForEnter);
   //     } else {
   //         $(textboxes).keydown (checkForEnter);
   //     }
   // });
    $('body').find("input, textarea, input:text, input:checkbox, select").each(function() {

        $(this).css( {
            'margin' : '2',
            'margin-left':'4px',
            'font-size' : '11',
            '-moz-border-radius': '3px',
            '-webkit-border-radius': '3px'
        });
        if($(this).attr("[view]") == true){
            if($(this).attr("type") != 'hidden'){
                var valor = '<span style="padding-left: 5px;padding-top:5px; font-size: 13px; font-weight: bold;">'+$(this).val()+'</span>';

                var style = $(this).attr('style');
                var element = $('<div class="ui-widget-content ui-corner-all" style="' + style + '"></div>').html(valor);
                $(this).parent().html(element);
                $(this).remove();
            }
        }else{
            if($(this).attr("trigger")){
                var string = $(this).attr("trigger");
                $(this).removeAttr("trigger");
                eval (string);                
            }
            $(this).addClass('ui-state-default');
            $(this).hover(function() {
                $(this).addClass('ui-state-hover');
            }, function() {
                $(this).removeClass('ui-state-hover');
            });
        }

    });


$('body').find("input:button, .button, .ui-button-text").each(function() {
    $(this).css({
    'margin-top': '2px',
    'padding-left': '10px',
    'padding-right': '10px',
    'padding-top': '2px',
    'padding-bottom': '2px',
    'margin-right': '2px',
    'margin-bottom': '2px',
    'margin-left': '4px',
    'font-size': '11px',
    '-moz-border-radius': '3px',
    '-webkit-border-radius': '3px',
    'border-radius': '3px',
    'cursor': 'pointer'
    })
});


    $('body').find('select').each(function() {

        $(this).css( {
            'margin' : '2',
            'font-size' : '11'
        });
        if ($(this).attr("readonly") == "true") {
            if($(this).attr("type") != 'hidden'){
                var valor = '<span style="padding-left: 5px;padding-top:5px; font-size: 13px; font-weight: bold;">'+$("#" + $(this).attr('id') + " > option:selected").html()+'</span>';

                var style = $(this).attr('style');
                var element = $('<div class="ui-widget-content ui-corner-all" style="' + style + '"></div>').html(valor);

                $(this).parent().html(element);
                $(this).remove();
            }
        }else{
            $(this).addClass('ui-state-default');
            $(this).hover(function() {
                $(this).addClass('ui-state-hover');
            }, function() {
                $(this).removeClass('ui-state-hover');
            });
        }

    });


    // FIM - jQuery - Atribuição de Padronização CSS
    // *********************************************************************


    $('body').find(".ui_calendario:enabled").datePicker( {
        startDate : '01/01/1900',
        displayedMonth	: true,
        displayedYear	: true
    }).bind('dpClosed', function() {
        $(this).focus();
    });


    // Campo desabilitado
    $('body').find('.ui_campo_disabled').disabled = true;

    // FIM - jQuery - Atribuição de campo desabilitado
    // *********************************************************************

    // *********************************************************************
    // INICIO - jQuery - Atribuição de plugin "Abas"
    // *********************************************************************



    $('body').find('.tabs').tabs( {
        fxAutoHeight : false,
        collapsible : true
    });//.find(".ui-tabs-nav").sortable({axis:'x'});

    $('body').find('#bodyDisplay').css({
        'height' : ($('body').height()-($('#barraPrincipal').height()+1.3*$('#infoRodape').height())),
        'max-height' : ($('body').height()-($('#barraPrincipal').height()+1.3*$('#infoRodape').height())),
        // 'width' : ($('body').width()),
        // 'max-width' : ($('body').width()),
        'overflow-y': 'hidden',
        'overflow-x': 'hidden',
        'position' : 'static'
    }); 


    // FIM - jQuery - Atribuição de plugin "Abas"
    // *********************************************************************

    // *********************************************************************
    // INICIO - jQuery - Atribuição de plugin "Mascara"
    // *********************************************************************
    $('body').find('.ui_mascara_telefone[masked!=masked]').attr('masked','masked').mask("9999-9999");
    $('body').find('.ui_mascara_data[masked!=masked]').attr('masked','masked').mask("99/99/9999");
    $('body').find('.ui_mascara_cep[masked!=masked]').attr('masked','masked').mask("77.777-777");
    $('body').find('.ui_mascara_cpf[masked!=masked]').attr('masked','masked').mask("777.777.777-77");
    $('body').find('.ui_mascara_dinheiro[masked!=masked]').attr('masked','masked').maskMoney({
        symbol:"R$",
        decimal:",",
        thousands:""
    });
    $('body').find('.ui_mascara_valor[masked!=masked]').attr('masked','masked').maskMoney({
        symbol:"",
        decimal:",",
        thousands:""
    });

    $('body').find('.icons').hover(function() {
        $(this).toggleClass('ui-state-hover');
    });
        $('body').find('.datagrid-icon').hover(function() {
        $(this).toggleClass('ui-state-hover');
    });



    // FIM - jQuery - Atribuição de plugin "janela Dialog"
    // *********************************************************************

    // *********************************************************************
    // INICIO - jQuery - Atribuição de Padronização do Menu
    // *********************************************************************


    // Menu Topo
    $('body').find(".modulobot").hover(function() {
        $(this).addClass('modulobotoff');
    }, function() {
        $(this).removeClass('modulobotoff');
    });


    // Menu Lateral
    $('body').find(".botActionOff").hover(function() {
        $(this).addClass('ui-state-hover');
        $(this).removeClass('ui-state-default');
    }, function() {
        $(this).addClass('ui-state-default');
        $(this).removeClass('ui-state-hover');
    });

    $('body').find(".botActionOff").click(function(){
        $(".botActionOff").removeClass("botActionClick ui-state-active");
        $(this).addClass("botActionClick ui-state-active");
    });
    // FIM - jQuery - Atribuição de Padronização do Menu
    // *********************************************************************


    // *********************************************************************
    // INICIO - jQuery - Atribuição de help Span
    // *********************************************************************

    $('body').find('.ui-icon-help').each(
        function() {

            $('#' + $(this).attr('id') + '_conteudo').addClass(
                "icons ui-state-highlight ui-corner-all").css( {
                'font-size' : '11px',
                'width' : '250px',
                'margin' : '3px'
            }).hide();

            $('#' + $(this).attr('id')).hover(function() {
                $('#' + $(this).attr('id') + '_conteudo').show('slow')
            }, function() {
                $('#' + $(this).attr('id') + '_conteudo').hide('slow')
            })
        }


        );

    // FIM - jQuery - Atribuição de help Span
    // *********************************************************************
    $('body').find('.TWindow').each(function(){
        if( $("#ui-dialog-title-" + $(this).attr('id')).length == 0 ){

            var Window = "#"+$(this).attr('id');
            var WinDrag = $(Window).attr('draggable') == 'true' ? true : false;
            var WinResize = $(Window).attr('resizable') == 'true' ? true : false;
            var winZindex = $(Window).attr('index');
            var winModal = $(Window).attr('modal') == 'true' ? true : false;
            var winAutoOpen =$(Window).attr('autoOpen') == 'true' ? true : false;
            var winEscFunction = $(Window).attr('closeOnEscape') == 'true' ? true : false;

            if($(Window).attr('win_width') > 100){
                WinWidth = $(Window).attr('win_width');
            }else{
                WinWidth = ($('body').width()-30);
            }
            if($(Window).attr('win_height') > 100){
                WinHeight = $(Window).attr('win_height');
            }else{
                WinHeight = ($('body').height()-120);
            }

            $(this).css("vertical-align", "top");
            $(this).dialog( {
                modal : winModal,
                closeOnEscape: winEscFunction,
                autoOpen : winAutoOpen,
                resizable: WinResize,
                draggable: WinDrag,
                position: [($('body').width()-WinWidth)/2,($('body').height()-WinHeight-60)/2],
                height: WinHeight,
                width: WinWidth,
                close : function() {
                    $(this).remove();
                }
            });

            $('body').find(Window+"-buttonpane").each(function(){
                $(Window).parent().append($(this));
                $(this).addClass(' ui-dialog-buttonpane ui-widget-content ui-helper-clearfix ');
                if($(this).html()){
                    $(Window).parent().children('.ui-dialog-titlebar').children('.ui-dialog-titlebar-close').remove();
                }
            });
        }

    });
    $('body').find('.ui-jquery-multiselect').multiselect();

    $('body').find('.conteinerList').each(function(){
        // $(this).height(($('body').height()-($('#barraPrincipal').height()+4*$('#infoRodape').height()+$(".obApendice").height())));
        if($(this).attr("trigger")){
            var string = $(this).attr("trigger");
            $(this).attr("trigged","trigged");
            eval (string);
        }
    });

    $('body').find("#barraNav > input").removeClass().addClass('ui-widget-content ui-corner-all icons');

    $('body').find('.ui-h2').each(function(){

        //  $(this).removeClass().addClass('ui-state-default');
        $(this).css('font-size','30px').css('width',+100);

    });
    var delay = window.setTimeout('delay_atribuicao()','1');

}


function delay_atribuicao(){

    //função para execução de funÃ§Ãµes gatilho.
    $('body').find('*[trigger]').each(function(){
        eval($(this).attr('trigger'));
        $(this).removeAttr('trigger').attr('triggered','triggered');
    });



    $('body').find(".listaBody").each(function(){
        obPai = $(this).parent().parent().parent().parent();
        altura = obPai.height() - obPai.children('tbody').children('.tr1').height() - obPai.children('tbody').children('.tr5').height() - 2;
        largura = obPai.width() - 2;
        if((altura  == '-2') || (altura == null) || (altura == -2)){
            altura = '100%';
        }
     
        if((largura  == '-2') || (largura == null) || (largura == -2)){
            largura = '100%';
        }
     
        $(this).css({
            'height': altura,
            'width': largura
        });
    });

    $('form.ajaxForm').live('submit',function(){
    	this.onsubmit = null;
        return false;
    });
}

