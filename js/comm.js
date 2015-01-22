//alert("加载成功！");

require.config({
	   baseUrl: "./js",
　　　　paths: {
　　　　　　"jquery": "jquery.min",
			"fullpage":"jquery.fullPage.min",
			"easing":"jquery.easing.1.3",
			"jqueryui":"http://cdn.staticfile.org/jqueryui/1.10.3/jquery-ui.min",
			"movebox":"jquery.movingboxes"
			
　　　　},
shim: {
　　　//　'jquery.onepage-scroll.min': {
//　　　　　　deps: ['jquery'],
//　　　　　　exports: 'jQuery.fn.fullpage'
		'easing':['jquery'],
		//'fullpage' : ['jquery']
		'jqueryui':['jquery'],
		'fullpage':{
			　deps: ['jquery'],
　　　　　exports: '$.fn.Fullpage'
			},
		'movebox':['jquery'],
		'slider':['jquery']
		
		
　　　
　　}
});

require(['jquery','easing','fullpage','slider'], function ($){
//　　　　alert(math.add(1,1));

$(function(){
	$("#ip4-btn1").click(function(){
		
		$(".section4")
		.animate({opacity:"0"},500)
		.queue( function(next) {
			$(this).css({"background-image":"url(images/index-bg4-2.jpg)","opacity":0});
			next();
        })
		.animate({opacity:"1"},500);
		
		$(".ip4-tab1").addClass("select");
		$(".ip4-tab2").removeClass("select");
		
		//$(".section4").animate({opacity:"0"},500,function(){		
//		
//			$(this).delay(1).css({"background-image":"url(images/index-bg3.jpg)","opacity":0}).animate({opacity:"1"},500);
//			
//			
//		});
	});
	$("#ip4-btn2").click(function(){
		$(".section4").animate({opacity:"0"},500,function(){
		
			$(this).delay(1).css({"background-image":"url(images/index-bg4.jpg)","opacity":0}).animate({opacity:"1"},500);
			
		});
		
		$(".ip4-tab2").addClass("select");
		$(".ip4-tab1").removeClass("select");
	});
});

$(function(){
		$(".videoimg").on("click",function(){
			$(".videobox").show();
			$(this).hide();
		});
	});

$(function(){
	$(".ip4-box1-tit").addClass("select");
	$(".ip4-box1-tit").on("click",function(){
		$(".ip4-f3-box").animate({"left":"930px"},1500,function(){
			$(".ip4-box1-tit").addClass("select");
			$(".ip4-box2-tit").removeClass("select");
			} );
	});
	
	$(".ip4-box2-tit").on("click",function(){
		$(".ip4-f3-box").animate({"left":"70px"},1500,function(){
			$(".ip4-box2-tit").addClass("select");
			$(".ip4-box1-tit").removeClass("select");
			} );
	});
	
});	
$(function(){
	$("#superContainer").fullpage({
	
		slidesColor: ['#fff', '#fff', '#fff', '#fff', '#fff'],
		anchors: ['page1', 'page2', 'page3', 'page4','page5'],
		//menu: '#menu',
		loopBottom:true,
		scrollingSpeed:1200,
		easing:"linear",
		navigation:true,
		navigationPosition:"right",
		navigationColor:"#f58220",
		'afterLoad': function(anchorLink, index){
				if(index==1){
					$(".section1").addClass("active3");
					}
				if(index == 2){
					$(".videobox").fadeIn();
					$(".videoimg").hide();
				}
			},
			
			'onLeave': function(index, direction){
				if (index == 1) {
					$(".section1").removeClass("active2").removeClass("active3");
					}
				if (index == 2 ){
					$(".videobox").hide();
					$(".videoimg").fadeIn();
				}
				
			},
			
			afterRender: function(){
				$(".section1").addClass("active2");
			}


	});
	
	
	//setInterval(function(){
//        $.fn.fullpage.moveSectionDown();
//    }, 3000);


	//alert($("body").html());
});
});

require(['jquery'], function ($){
//页面加载时的 Loading 效果
	//$(window).load(function(){
	$(function(){
		window.setTimeout(function(){
			$('body').removeClass('loading');
		}, 2000);
	});



　　});

