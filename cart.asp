<!--#include virtual="/fiveinc/conn.asp"-->
<!--#include virtual="/User_Config.asp"-->
<%  
select case Easp.var("act")
	case "addcart":addcart()
	case "editcart":editcart()
	case "delcart":delcart()
	case "clearcart":clearcart()
	case "cartnum":cartnum()
	case "loadcart":loadcart()
	case "order":order()
	case "orderdb":orderdb()
	case "pay":paydb()
	case "chanagepayway":chanagepayway()
	
	case else
		
end select

sub loadcart()
	%>
<table>
  <tbody>
    <tr>
      <th width="60">图片</th>
      <th>商品</th>
      <th width="80">价格</th>

      <th width="90">数量</th>
      <th width="80">小计</th>
      <th width="50">操作</th>
    </tr>
    <%
	  dim cart_num,cart_totalprice
	  cart_num=0
	   cart_totalprice=0
		  Set rs = Easp.Db.Sel("Select  * From user_cart_c  where userid = {userid} ")
		  if rs.eof then
		  cartIsempty=1
		  %>
          <td colspan="7"><a href="/">购物车中还没有商品，赶紧选购吧！</a></td>
          <%else
		  while not rs.eof 
		  %>
			  
    <tr>
      <td><a href="/show.asp?id=<%=rs("shopid")%>" target="_blank"><img class="pro" src="<%=rs("pimg")%>" border="0"></a></td>
      <td><a href="/show.asp?id=1" target="_blank"><%=rs("pname")%></a></td>
     
      <td>¥<%=rs("price")%></td>
      <td><a title="减少" class="min" productid="<%=rs("shopid")%>" old="<%=rs("shopnum")%>">-</a>
        <input name="quantity" class="quantity" onBlur="editcard(this,this.value)" type="text" maxlength="4" value="<%=rs("shopnum")%>" productid="<%=rs("shopid")%>">
        <a title="增加" class="max" productid="<%=rs("shopid")%>" old="<%=rs("shopnum")%>">+</a></td>
      <td class="price">¥<%=rs("shopnum")*rs("price")%></td>
      <td><a class="del" onClick="delcart(<%=rs("id")%>)" href="javascript:">删除</a></td>
    </tr>
      
		  <%
		  cart_num=cart_num+rs("shopnum")
		  cart_totalprice = cart_totalprice + rs("shopnum")*rs("price")
		  rs.movenext
		  wend
		  rs.close
		  
		  %>
	
    
    
    <tr>
      <td class="info" colspan="7">商品共计：<span><%=cart_num%></span>件　商品总金额：<span>¥<%=cart_totalprice%></span>元</td>
    </tr>
    <%end if%>
  </tbody>
</table>
<%if cartIsempty<>1 then '清空购物车后不显示%>
<div id="cart_action"><span><a href="order.asp">去结算</a></span><a class="goon" href="/">继续购物</a>　<a class="clear" id="clearcart" href="javascript:;">清空购物车</a></div>
<%
end if
	response.End()
end sub


sub editcart()

	if Easp.var("id")<>"" and Easp.var("shopnum")<>"" then
		
		result = Easp.Db.Upd("user_cart", "shopnum={shopnum}", "userid={userid} and shopid={id}")
		response.write "1"
	else
		response.write "0"
		
	end if
	
	response.End()
end sub

sub delcart()
	if Easp.var("id")<>"" then
		result = Easp.Db.Del("user_cart", "userid={userid} and shopid={id}")
		response.write "1"
	else
		response.write "0"
	end if
	response.End()
end sub

sub clearcart()
	result = Easp.Db.Del("user_cart", "userid={userid}")
	response.write "清空购物车成功"
	response.End()
end sub

sub cartnum()
	
	set rs=Easp.Db.Sel("Select sum(shopnum) from user_cart where userid={userid}")
	if not rs.eof then
		response.write rs(0)
	else
		response.write "0"
	end if
end sub

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
<title>购物车</title>
</head>


<body>
<div class="width">
  <div id="cart_div" class="mt10">
    <div class="cart_quick">
      <div class="cart_ico">我的购物车</div>
      <div class="cart_step">
        <ul>
          <li class="step1"><span class="active"><span><span>1.查看购物车</span></span></span></li>
          <li class="step2"><span><span><span>2.填写购物信息</span></span></span></li>
          <li class="step3"><span><span><span>3.完成订单</span></span></span></li>
        </ul>
      </div>
    </div>
    <%
		
		  Set rs = Easp.Db.Sel("Select top 1 * From user_cart  where userid = {userid} ")
		  if not rs.eof then
		  %>
    <div id="cartlist">loading</div>
    <%else%>
    <div class="cart_none"><img src="/images/cart_search.gif" />
      <p>亲，您的购物车还是空的，您可以：</p>
      <a href="./">● 去首页挑选喜欢的商品 </a>
      <div class="clear"></div>
    </div>
    <%end if
		  rs.close
		  %>
  </div>
</div>
</body>
</html>
