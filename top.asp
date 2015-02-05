<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh">
<head>
<meta charset="UTF-8">
<title><%=curpageTitle&"-"&SiteTitle %></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="<%=SiteKey%>" />
<meta name="description" content="<%=SiteDescription%>" />
<link rel="stylesheet" href="/css/style.css">
<link href="/css/base.css" rel="stylesheet" type="text/css">
<link href="/css/cart.css" rel="stylesheet" type="text/css">
<link href="/css/xiaohucss.css" rel="stylesheet" type="text/css">
<script src="/js/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="js/jquery.hoverIntent.minified.js"></script>
<script src="/js/base.js" type="text/javascript"></script>
<script src="/js/cart.js" type="text/javascript"></script>
<script src="/js/comm.js" type="text/javascript"></script>
<script src="/js/dialog/jquery.artDialog.js?skin=default" language="javascript"></script>
<script type="text/javascript" src="/js/jquery.SuperSlide.2.1.1.js"></script>
</head>
<body>

<div class="head main">
  <%if request.Cookies("username")<>"" then%>
  <div class="loginin">
    <div class="rt-cart"><a href="cart.asp">购物车<span id="cartnum">0</span>件</a></div>
    <div class="rt-user"><%=request.Cookies("username")%>，欢迎您！<a href="user_index.asp">[会员中心]</a> <a href="user_out.asp">[退出登陆]</a></div>
  </div>
  <%else%>
  <div class="login">
    <div>
      <div class="i-btnbg log-jxs"><a href="">English</a></div>
    </div>
    <div>
      <div class="i-btnbg "><a href="user_login.asp">经销商登陆</a></div>
    </div>
  </div>
  <%end if%>
  <div class="logo"> <a href="/" ><img src="images/logo_03.png" alt=""/></a> </div>
  <div class="nav">
    <ul>
      <%
	  
	  k=1
	  set rs2=server.CreateObject("adodb.recordset")
	  rs.open "select top 10 * from category where followid=0 and ishome=1 order by orderid",conn,1,1
	  while not rs.eof
	  if cateid_d1=rs("Cateid") then
	  		response.write "<li class=""select"">"
	  else
	  		response.write "<li>"
	  end if
			response.write "<a href="""&companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("dirpath"),supporthtml)&"""><span class=""zh"">"&rs("catename")&"</span><span class=""en"">"&rs("catename_en")&"</span></a>"
	 if instr(rs("sonid"),",")>0 then
				response.write "<div class=""xiala""><ul>"
				
				rs2.open "select * from category where depth=2 and ishome=1 and followid="&rs("cateid")&" order by orderid",conn,1,1
				while not rs2.eof 
					response.write "<li><a href="""&companyURL(rs2("cateid"),rs2("catetype"),rs2("outlinkurl"),rs2("modeltype"),rs2("dirpath"),supporthtml)&""" >"&left(rs2("catename"),27)&"</a></li>"
				rs2.movenext
				wend
				rs2.close
				response.write "</ul></div>"
		end if 
			
			response.write "</li>"
	  rs.movenext
	  k=k+1
	  wend
	  rs.close
	  
	  %>
    </ul>
  </div>
</div>


<%if isindex<>1 then%>
<div class="nbanner" style="background:url(../images/nbanner.jpg) center top no-repeat; height:210px;"></div>

<%end if%>


