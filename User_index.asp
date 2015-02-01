<!--#include virtual="/fiveinc/conn.asp"-->
<!--#include virtual="/User_Config.asp"-->



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/css/base.css" rel="stylesheet" type="text/css">
<link href="/css/cart.css" rel="stylesheet" type="text/css">
<script src="/js/jquery.min.js" type="text/javascript"></script>
<script src="/js/base.js" type="text/javascript"></script>
<script src="/js/cart.js" type="text/javascript"></script>
<title>我的订单</title>
</head>
<script>
$(function(){
	$(".ico01").addClass("hover ico01_");
	$(".user_title_more li").eq(<%=clng(request("v"))%>).addClass("hover");
})
</script>
<script>
$(function(){	
	$(".paynow").click(function(){
		var id=$(this).attr("id");
		var payway=$(this).attr("payway");
		var total=$(this).attr("total");
		if(confirm("确定要支付"+total+"元？"))
		{
			switch (payway)
			{
				case "-1":
					var url,data;
					url="../cart.asp?act=pay";
					data="id="+encodeURIComponent(id);
					$.ajax({
					type:"post",
					cache:false,
					url:url,
					data:data,
					error:function(){alert("\u670d\u52a1\u5668\u9519\u8bef\uff0c\u64cd\u4f5c\u5931\u8d25");},
					success:function(_)
					{
						var act=_.substring(0,1);
						var info=_.substring(1);
						switch(act)
						{
							case "0":
								$.message({content:info});
								break;
							case "1":
							$.dialog({title:"\u0053\u0044\u0043\u004d\u0053\u63d0\u793a",icon:"face-sad",content:info,lock:true,opacity:"0.5",okVal:"登录",ok:function(){location.href='/user/login.asp?url=http://localhost:1688/cart.asp?act=show%26newid='},cancelVal:'\u53d6\u6d88',cancel:function(){}});
								break;
							case "2":
							$.dialog({title:"\u0053\u0044\u0043\u004d\u0053\u63d0\u793a",icon:"face-sad",content:info,lock:true,opacity:"0.5",okVal:"充值",ok:function(){location.href='/user/pay.asp'},cancelVal:'\u53d6\u6d88',cancel:function(){}});
								break;
							case "3":
								$.message({type:"ok",content:info,time:2500});
								setTimeout(function(){location.href="?"},3500);
								break;
							default:
								alert(_);
								break;
						}
					}});
					break;
				case "-2":
					alert("请线下汇款后联系客服为您处理！");
					break;
				default:
				window.open("order.asp?act=pay&id="+id+"");
				break;
			}
		}
	});

	$(".ispost").click(function(){
		var id=$(this).attr("id");
		if(confirm("您确定已收到货了吗？"))
		{
			var url,data;
			url="?act=ispost";
			data="id="+encodeURIComponent(id);
			$.ajax({
			type:"post",
			cache:false,
			url:url,
			data:data,
			error:function(){alert("\u670d\u52a1\u5668\u9519\u8bef\uff0c\u64cd\u4f5c\u5931\u8d25");},
			success:function(_)
			{
				var act=_.substring(0,1);
				var info=_.substring(1);
				switch(act)
				{
					case "0":
						$.message({content:info});
						break;
					case "1":
						$.message({type:"ok",content:info,time:2000});
						setTimeout(function(){location.href="?"},1500);
						break;
					default:
						alert(_);
						break;
				}
			}});
		}

	})

})
</script>

<body>




<div class="width">
        <div class="user_bg">
            <div id="uleft">
    <!--#include virtual="/uleft.asp"-->
</div>
            <!--左侧结束-->
            <div id="uright">
                
                 
                <div class="page_content"></div>
            </div>
            <!--右侧结束-->
            <div class="clear"></div>
        </div>
    </div>
