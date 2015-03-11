<!--#include virtual="/fiveinc/conn.asp"-->
<!--#include virtual="/User_Config.asp"-->
<%

curpageTitle = "我的订单"

 if Easp.var("act") ="ispost" then
 
' response.write "0"&Easp.var("id")

	Easp.Db.Begin '开始事务
	result = Easp.Db.Upd("orderList","refund_status='TRADE_FINISHED',confirmISuser=1,confirmTime='"&now()&"'","orderNum={id}")

	
	set rs=Easp.Db.Sel("select floatmoney , totalmoney  from orderList where ordernum={id}")
	if not rs.eof then
		totalpoints = clng(rs(0)+rs(1))
	end if
	
	result2= Easp.Db.Upd("User","points=points+"&totalpoints&"","userId={userid}")
		
	if result>0 and result2>0 then
	Easp.Db.Commit '提交事务	  
	
	response.write "1确认收货成功！"
	else
	response.Write "0确认收货失败，请刷新后再试！"
	
	end if

 response.end()
 end if
%>
<!--#include virtual="/top.asp"-->
<script>
$(function(){
	$(".ico02").addClass("hover ico02_");
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



<div class="width">
        <div class="user_bg">
            <div id="uleft">
<!--#include virtual="/uleft.asp"-->
</div>
            <!--左侧结束-->
            <div id="uright">
                
                 <div class="user_title_more">
                    <ul>
                        <li><a href="?">全部订单</a></li>
                        <li><a href="?v=1">等待买家付款</a></li>
                        <li><a href="?v=2">已付款未发货</a></li>
                        <li><a href="?v=3">已发货待确认</a></li>
                        <li><a href="?v=4">交易完成</a></li>
                    </ul>
                </div>
                <div class="page_content">
                    <div class="mt10"></div>
                     <table id="tablelist">
                        <tr>
                            <th>订单编号</th>
                            <th width="80">收货人</th>
                            <th width="100">订单总金额</th>
                            <th width="100">下单日期</th>
                            <th width="100">支付方式</th>
                            <th width="100">状态</th>
                            <th width="80">操作</th>
                        </tr>
    <%
	if request("v")<>"" then
		select case Easp.var("v")
		
		case 1
			sql_where = " and refund_status='WAIT_BUYER_PAY'"
		case 2
			sql_where = " and refund_status='WAIT_SELLER_SEND_GOODS'"
		case 3
			sql_where = " and refund_status='WAIT_BUYER_CONFIRM_GOODS'"
		case 4
			sql_where = " and refund_status='TRADE_FINISHED'"
		
		
		
			
			
		end select
    else
		sql_where =""
	end if
	
	Easp.Db.PageSize = 10
	sql = "select * from orderList_c where userid={userid}" & sql_where &" order by id desc"
	Set rs = Easp.Db.GetRS(sql)
	

	while not rs.eof

	%>                    
                        
                        <tr>
                            <td class="item"><a href="orderDetail.asp?id=<%=rs("orderNum")%>"><%=rs("orderNum")%></a></td>
                            <td align="center"><%=rs("xm")%></td>
                            <td align="center">¥<%=rs("totalmoney") + rs("floatmoney")%> 元</td>
                            <td align="center"><%=rs("addtime")%></td>
                            <td align="center">线下汇款</td>
                            <td align="center"><span><%=Easp.Var(trim(rs("refund_status")))%></span></td>
                            <td align="center">
                            <%
							if trim(rs("refund_status"))="WAIT_BUYER_PAY" then
							%>
                            <a href="javascript:;" class="paynow" id="<%=rs("orderNum")%>" payway="-2" total="¥<%=rs("totalmoney") + rs("floatmoney")%>">现在付款</a><br />
                            <%elseif trim(rs("refund_status"))="WAIT_BUYER_CONFIRM_GOODS" then%>
                            <a class="ispost" id="<%=rs("orderNum")%>" href="javascript:;">确认收货</a><br />
                            <%end if%>
                            
                            <a href="orderDetail.asp?id=<%=rs("orderNum")%>"><span>订单详情</span></a></td>
                        </tr>
           <%
		   rs.movenext
		   wend
		   rs.close
		   
Easp.Db.SetPager "default2", "{first}{prev}{liststart}{list}{listend}{next}{last} ", Array()
%>             
                        
        
                    </table>
                    <div class="list_page"><%
					  if Easp.Db.PageRecordCount>0 then
					  Easp.Print Easp.Db.GetPager("default2")
					  end if
					  
					  %></div>
                </div>
            </div>
            <!--右侧结束-->
            <div class="clear"></div>
        </div>
    </div>
<!--#include virtual="/foot.asp"-->