<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->

<%
if request("act")="1" then

	if supportHtml <>1 then
		response.write "如果要启用生成静态功能，请先到网站配置里面开启该功能"
	else
	
		issuccess=	C_htm(SiteUrl&"index.asp","/index.html")
		if issuccess then
			response.write "生成首页成功！"
		else
			response.write "生成首页失败！"
		end if
	end if




else
%>
<form id="form1" name="form1" method="get" action="?" target="Loadinfo">
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
   
    
    
    
    <tr>
    <td height="25" class="tr_southidc"><input type="hidden" value="1" name="act"><input type="submit" value="开始生成"></td>
    </tr>
    <tr><td class="tr_southidc">
    <iframe frameborder="0" name="Loadinfo" id="Loadinfo" width="100%" height="150"></iframe>
    </td></tr>
    </table>
   </form>
   <%end if%>