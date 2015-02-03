<!--#include virtual="/fiveinc/conn.asp"-->
<!--#include virtual="/User_Config.asp"-->
<%


user_rate=1 '默认折扣为1 即不打折
set rs=Easp.Db.sel("select * from [User_rate_c] where userid={userid}")

if not rs.eof then
	user_rate=rs("rate") '折扣
end if
rs.close

  

if Easp.var("act") ="orderdb" then '提交订单的处理函数

	'response.write "地址ID"&Easp.var("t0")
	if Easp.var("t0")=0 then '表示新增添地址
	
		xm=easp.var("a0")
		tel=easp.var("a1")
		zip=Easp.var("a3")
		addr=Easp.var("a4")
		'isdefault=Easp.var("a5")
		
		result = Easp.Db.Ins("user_address","username:{a0},tel:{a1},zipcode:{a3},address:{a4},isdefault:{a5},userid:{userid}")		
	
	else
		
		set rs=Easp.Db.sel("select * from user_address where id={t0}")
		if not rs.eof then
			xm=rs("username")
			tel=rs("tel")
			zip=rs("zipcode")
			addr=rs("address")		
		else
			response.write "0地址出错哦"			
		end if
	
	end if
	
	if xm<>"" and tel<>"" and zip<>"" and addr<>"" then '如果提交数据完全的话


 Easp.Db.Begin '开始事务  增加订单和订单明显表 事务处理  
 
 
	'折扣、浮动金额计算
	
	 dim cart_num,cart_totalprice,floatmoney
	 
	  cart_num=0
	  cart_totalprice=0
	  floatmeony=0
	  '随机产生订单号 
	  
	   RANDOMIZE
	  	ranNum=int(999*rnd)+1000
		'iddata=year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&ranNum
		iddata = GetYYYYMMDDHHIISS(now(),now()) & ranNum
		Easp.Var("OrderNum") ="RC"&iddata
	  
	  'response.write "0"&Easp.Var("OrderNum")
	  
	 'response.End()
		' Easp.Console rs("shopid")
		  Set rs = Easp.Db.Sel("Select  * From user_cart_c  where userid = {userid} ")
		  if rs.eof then
		  	 response.write "0购物车为空,提交订单出错"
		  else			
			
			
			 while not rs.eof
			 
				 '将购物车的物品插入到订单明细表中
				 result = Easp.Db.Ins("OrderDetail","orderNum:{OrderNum},userId:{userid},goodsid:'"&rs("shopid")&"',goodsname:'"&rs("Pname")&"',price:"&rs("price")&",count:"&rs("shopnum")&",totalprice:"& rs("shopnum")*rs("price") )
				 
				 'Easp.Console rs("shopid")
				 cart_num=cart_num+rs("shopnum")
				 cart_totalprice = cart_totalprice + rs("shopnum")*rs("price")
				 
				 
				 if result<=0 then
				  Easp.Db.RollBack '回滚事务
					response.write "0订单事务处理出错"
					response.End()
				 end if			  
				 
			  rs.movenext
			  wend
			  
			  if user_rate<>1 then
			 
			  		floatmoney = -cart_totalprice + round( cart_totalprice* cdbl(user_rate),2)
			  end if
			  
			 
			'增加订单
			  result2 =Easp.Db.Ins("OrderList","orderNum:{orderNum},userid:{userid},totalmoney:"&cart_totalprice&",floatmoney:"&floatmoney&",xm:'"&xm&"',tel:'"&tel&"',zipcode:'"&zip&"',addr:'"&addr&"',payway:{t1},remark:'"&remark&"',refund_status:'WAIT_BUYER_PAY'")
			  
			 '清除购物车
			 result = Easp.Db.Del("user_cart", "userid={userid}")
			 
			 
			  
			
			  
			  			  
		  end if
		  rs.close
		  
		  
		    if result2>0 then
			  	Easp.Db.Commit '提交事务	  
				response.write "1"&Easp.Var("orderNum")
			  else
			  	Easp.Db.RollBack '回滚事务
				response.write "0订单事务处理出错"
			end if			  
	
	end if



	response.End()


end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/css/base.css" rel="stylesheet" type="text/css">
<link href="/css/cart.css" rel="stylesheet" type="text/css">
<script src="/js/jquery.min.js" type="text/javascript"></script>
<script src="/js/base.js" type="text/javascript"></script>
<script src="/js/cart.js" type="text/javascript"></script>
<title>填写购物信息</title>
</head>
<script>
$(function(){
	$(".is_address").click(function(){$("#address").css("display","block");});
	$(".no_address").click(function(){$("#address").css("display","none");});
	$("textarea").hover(function(){$(this).stop(true,true).animate({height:"100px"});},function(){$(this).stop(true,true).animate({height:"30px"});});
});
function checkdb(the)
{
	the.send.disabled=true;
	var t0="";
	for(i=0;i<the.t0.length;i++)
	{
		if(the.t0[i].checked){t0=the.t0[i].value;}
	}
	if(t0=="")
	{
		the.send.disabled=false;
		$.message({content:"\u8bf7\u9009\u62e9\u6216\u586b\u5199\u4e00\u4e2a\u6536\u8d27\u5730\u5740"});
		return false
	}
	if(t0==0)
	{
		if(strlen(the.a0.value)==0)
		{
			the.send.disabled=false;
			$.message({content:"\u6536\u8d27\u4eba\u59d3\u540d\u4e0d\u80fd\u4e3a\u7a7a"});
			the.a0.focus();
			return false
		}
		if(strlen(the.a1.value)==0)
		{
			the.send.disabled=false;
			$.message({content:"电话不能为空！"});
			the.a1.focus();
			return false
		}
		if(!valid_tel(the.a1.value)){
			the.send.disabled=false;
			$.message({content:"电话格式不对，请输入座机或手机号码！"});
			the.a1.focus();
			return false
		}

		if(strlen(the.a3.value)==0)
		{
			the.send.disabled=false;
			$.message({content:"\u90ae\u653f\u7f16\u7801\u4e0d\u80fd\u4e3a\u7a7a"});
			the.a3.focus();
			return false
		}
		if(strlen(the.a4.value)==0)
		{
			the.send.disabled=false;
			$.message({content:"\u6536\u8d27\u5730\u5740\u4e0d\u80fd\u4e3a\u7a7a"});
			the.a4.focus();
			return false
		}
	}
	var a5=0;
	if(the.a5.checked){a5=1;}
	var t1="";	
	for(i=0;i<the.t1.length;i++)
	{
		if(the.t1[i].checked){t1=the.t1[i].value;}
	}
	if(t1=="")
	{
		the.send.disabled=false;
		$.message({content:"\u8bf7\u9009\u62e9\u4ed8\u6b3e\u65b9\u5f0f"});
		return false
	}
	var url,data;
	url="?act=orderdb";
	data="t0="+encodeURIComponent(t0);
	data+="&t1="+encodeURIComponent(t1);
	data+="&t2="+encodeURIComponent($.trim(the.t2.value));
	data+="&a0="+encodeURIComponent($.trim(the.a0.value));
	data+="&a1="+encodeURIComponent($.trim(the.a1.value));
	//data+="&a2="+encodeURIComponent($.trim(the.a2.value));
	data+="&a3="+encodeURIComponent($.trim(the.a3.value));
	data+="&a4="+encodeURIComponent($.trim(the.a4.value));
	data+="&a5="+encodeURIComponent(a5);
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
				the.send.disabled=false;
				break;
			case "1":
				$.message({type:"ok",content:"\u8ba2\u5355\u63d0\u4ea4\u6210\u529f",time:2500});
				setTimeout(function(){location.href="orderShow.asp?act=show&newid="+info+""},3500);
				break;
			default:
				alert("提交订单出错，请检查后重新提交订单")
				break;
		}
	}});
	return false
}
</script>

<body>
<div class="width">
  <div id="cart_div" class="mt10">
    <div class="cart_quick">
      <div class="cart_ico">我的购物车</div>
      <div class="cart_step">
        <ul>
          <li class="step1"><span class="active"><span><span>1.查看购物车</span></span></span></li>
          <li class="step2"><span class="active"><span><span>2.填写购物信息</span></span></span></li>
          <li class="step3"><span><span><span>3.完成订单</span></span></span></li>
        </ul>
      </div>
    </div>
    <!--a-->
    <div id="cart_order">
      <form onSubmit="return checkdb(this)">
        <div class="title">确认收货地址　<a href="user/address.asp">[管理收货地址]</a></div>
        <div class="radio">
          <input name="t0" value="" type="hidden" />
          <ul>
            <%
				   		   '读取记录集
Set rs = Easp.Db.Sel("Select * From user_address where userid = {userid} order by isdefault desc,id desc")
while not rs.eof
				   
                   response.write "<li><input "
				   
				   if rs("isdefault") then
				   		response.write "checked=""checked"""
				   end if
				   response.write " type=""radio"" name=""t0"" value="""&rs("id")&""" id=""t0_"&rs("id")&""" class=""no_address"" /><label for=""t0_"&rs("id")&""">"&rs("address")&" ("&rs("username")&" 收)  "&rs("tel")&"</label></li>"
       
       rs.movenext
       wend
       rs.close
       
       %>
            <li>
              <input type="radio" name="t0" value="0" id="t0_0" class="is_address"  />
              <label for="t0_0">填写其他收货地址</label>
            </li>
          </ul>
          <div class="dis" id="address">
            <dl>
              <dt><span><u>*</u>收货人姓名：</span>
                <input type="text" name="a0" maxlength="10" />
              </dt>
              <dt><span><u>*</u>联系电话：</span>
                <input type="text" name="a1" maxlength="20" />
              </dt>
              <!--<dt><span><u>*</u>手机号码：</span><input type="text" name="a2" maxlength="11" />　<u>电话或手机至少写一项</u></dt>-->
              <dt><span><u>*</u>邮政编码：</span>
                <input type="text" name="a3" maxlength="6" />
              </dt>
              <dt><span><u>*</u>收货地址：</span>
                <input type="text" name="a4" maxlength="255" />
              </dt>
              <dt><span>设为默认：</span>
                <input type="checkbox" name="a5" value="1" class="c" id="a5" checked="checked" />
                <label for="a5">是</label>
              </dt>
            </dl>
          </div>
        </div>
        <div class="title">确认付款方式</div>
        <div class="radio">
          <ul>
            <li>
              <input type="radio" name="t1" value="0" id="t1_1" checked="checked" />
              <label for="t1_1">线下汇款</label>
            </li>
            <li style="display:none;">
              <input type="radio" name="t1" value="1" id="t1_2" />
              <label for="t1_2">在线支付</label>
            </li>
          </ul>
        </div>
        <div class="title">订单备注</div>
        <div class="radio">
          <dl>
            <dt><span>订单附言：</span>
              <textarea name="t2" onKeyUp="strlen_verify(this,'remark_len',255)"></textarea>还可输入<u id="remark_len">255</u> 个字符
            </dt>
          </dl>
        </div>
        <div class="title">确认订单信息</div>
        <div id="shophtml">
          <table>
            <tr>
              <th>商品</th>
              <th width="80">市场价</th>            
              <th width="60">数量</th>
              <th width="80">小计</th>
            </tr>
            
            
          <%
		  
	  cart_num=0
	   cart_totalprice=0
		  Set rs = Easp.Db.Sel("Select  * From user_cart_c  where userid = {userid} ")
		  if rs.eof then
		  
		  	response.Redirect("cart.asp") '如果没有商品则跳转
		  
		  %>
          <td colspan="7"><a href="/">购物车中还没有商品，赶紧选购吧！</a></td>
          <%else
		  while not rs.eof 
		  %>
			  
    <tr>
      <td><a href="/show.asp?id=<%=rs("shopid")%>" target="_blank"><%=rs("pname")%></a></td>
    
       <td>¥<%=rs("price")%></td>
        <td>¥<%=rs("shopnum")%></td>
        <td class="price">¥<%=rs("shopnum")*rs("price")%></td>
      </tr>
      
      <%
	  
	  cart_num=cart_num+rs("shopnum")
		  cart_totalprice = cart_totalprice + rs("shopnum")*rs("price")
	  rs.movenext
	  wend
	  rs.close
	  end if
	  
	  
	  %>
            <tr>
              <td colspan="5" class="info">商品共计：<span><%=cart_num%></span>件　商品总金额：<span>¥<%=cart_totalprice%></span>元
              <%if user_rate<>1 then
			 
			  	floatmoney =cart_totalprice-round( cart_totalprice* cdbl(user_rate),2)
			  	response.write "　会员折扣金额：<span>"& formatnumber(floatmoney,2,-1)&"</span>元"
				response.Write "　实际付款金额： <span>"& formatnumber(cart_totalprice-floatmoney,2,-1)&"</span>元"
				
			  end if
			  %>
              </td>
            </tr>
          </table>
        </div>
        <div class="action_bnt"><span>
          <input type="submit" name="send" value="提交订单" class="bnt" />
          </span>
          <input type="button" value="返回" class="bnt" onClick="location.href='?'" />
        </div>
      </form>
    </div>
    <!----> 
  </div>
</div>
</body>
</html>
