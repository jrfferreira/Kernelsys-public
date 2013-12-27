
function checkedItens(){		
	
	
	
						$('#truePrint').html($(':checked').map(function(i,v,m){
						return $('#'+v.value).html();
						}).get().join('<br><br> ') );
						
						
						$('#truePrint *').css({'border' : '0px solid #fff' , 'font-family' : 'Verdana, Geneva, Arial, Helvetica, sans-serif' , 'font-size': '12px' , 'max-height': '500px' , 'backgroun-color': '#FFF'});
                                                
												
    			};
			

				//$(document).ready(function(){
				//	$(':checkbox').blur(function(){
				//		var checkedElements = '';
				//			$(':checkbox').each(
				//				function(i,v,m){
				//					if(v.checked == 'checked'){
				//						checkedElements = checkedElements+$('#'+v.id).html()+'<br>';
				//					}
				//				}															
				//			)
				//	}
				//)});

			function printScreen(impressao,titulo){
				
				var truePrint = '<div id="truePrint"></div>';
				
				
														
				var resultado = 'Selecione:<br>';
				$('div').each(function(i,v,m){
					$("."+impressao+i).each(function(x,v,m){
								
						resultado = resultado+"<input type='checkbox' name='#"+v.id+"' value='"+v.id+"' onclick='checkedItens()'/>"+$("."+titulo+i).html()+"<br>"
					
					});
				});
			
			
				var temp = {
					state0: {
						html: '<div id="elementos">'+resultado+'</div>',
						buttons: { Cancelar: false, Visualizar: true },
						focus: 1,
						submit:function(v,m,f){ 
							if(!v)
								return true;
							else $.prompt.goToState('state1');//go forward
							return false; 
						}
					},
					
					
					
					state1: {
																	
						html: truePrint,
						buttons: { Voltar: -1, Fechar: 0, Imprimir: 1 },
						focus: 2,
						submit:function(v,m,f){ 
							if(v==0)
								$.prompt.close()
							else if(v==1)
								$('#truePrint').jqprint();//go forward
							else if(v=-1)
								$.prompt.goToState('state0');//go back
							return false; 
						}
					},
					state2: {
						html:'Imprimindo...',
						buttons: { Finalizar: false },
						submit:function(v,m,f){ 
							if(!v)
								
								return false; 
						}
					}
				}
				
				$.prompt(temp);
                                
			}