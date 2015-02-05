
//菜单下拉
$(function(){ //	
		
		$(".nav ul>li").hoverIntent({
			sensitivity: 3,   //滑鼠滑動的敏感度,最少要設定為1    
			interval: 100,   //滑鼠滑過後要延遲的秒數    
			over: function(){				
				
				
				$(this).find(".xiala").stop(true,true).fadeIn();

				},  //滑鼠滑過要執行的函式   
			timeout: 0,    //滑鼠滑出前要延遲的秒數    
			out: function(){
				
				$(this).find(".xiala").stop(true,true).hide(); 
				
		
				}  //滑鼠滑出要執行的函式  
			});
});