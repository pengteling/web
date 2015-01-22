<!doctype html><!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<!-- #include file="news_config.asp" -->
<style>

#productimages li{
	list-style-image: none;
	list-style-type: none;
	text-align:center;
	width:126px;
	height:146px;
	float:left;
}
</style>
<%

ID=strToNum(Request("ID"))
Set NewsRs=Conn.execute("select * from "&news_table&" Where ID="&ID)
If NewsRs.Eof then
	Response.Write "户型不存在"
    Response.End
End If

uploadfiles=NewsRs("uploadfiles")
uploadfiles_title=NewsRs("uploadfiles_title")

imgs = split(uploadfiles,"|")
if not isnull(uploadfiles_title) then
titles =split(uploadfiles_title,"|")
else
titles=split("","|")
end if
ReDim Preserve titles(20)


if request.form("title")<>"" then
	'response.write request.form("title")
	
	'response.write request.form("orderNo")
	
	
	
	title= split(request.form("title"),",")
	orderNo=split(request.form("orderNo"),",")
	dim titlearr(20)
	dim imgarr(20)
	for i = 0 to ubound(title)
		if title(i)="" or not isnumeric(orderNo(i)) then
			Response.Write "名称不能为空，序号须为数字<a href='javascript:history.back()'>返回</a>"
    		Response.End
		end if
		titlearr(orderNo(i)) = trim(title(i)	)
		imgarr(orderNo(i)) = trim(imgs(i))
	next
	
	'response.write imgarr(1)
	uploadfiles=""
	uploadfiles_title=""
	for i =0 to 20
		
		if imgarr(i)<>"" then
			
		   uploadfiles = uploadfiles&"|"&imgarr(i)
		   uploadfiles_title =uploadfiles_title &"|"&titlearr(i) 
		 end if
	next
	
	
uploadfiles =mid(uploadfiles,2,len(uploadfiles)-1)&"|"

uploadfiles_title =mid(uploadfiles_title,2,len(uploadfiles_title)-1)&"|"
	'response.write uploadfiles
	'response.write uploadfiles_title
		
	imgs = split(uploadfiles,"|")
	titles = split(uploadfiles_title,"|")
	
	set rs=server.createobject("adodb.recordset")
	rs.open "Select * from  "&news_table&" Where ID="&ID,conn,1,3
	if not rs.eof then
	rs("uploadfiles")=uploadfiles
	rs("uploadfiles_title")=uploadfiles_title
	rs.update
	
	end if
	rs.close
	
end if










%>

<style type="text/css">
<!--
.tr_southidc {BACKGROUND-COLOR: ECF5FF;}
-->
</style>

<table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
  <form name="myform" method="post" action="" >
    <tr>
      <td height="30" colspan="3" align="center" class="blod">设置户型图标题</td>
    </tr>
    <% for i = 0 to ubound(imgs)-1%>
    <tr bgcolor="#ECF5FF">
      <td width="133" height="25" align="center">户型标题：</td>
      <td><img src="<%=imgs(i)%>" width="100" height="100"></td>
      <td colspan="1">名称：<input name="title" type="text" class="input" value="<%=titles(i)%>" size="30">
      排序号：<input name="orderNo" type="text" class="input" value="<%=i+1%>" size="2"> 填数字(1~10)
	 </td>
    </tr>
    <%next%>
    <tr bgcolor="#ECF5FF">
    <td colspan="3" headers="25" align="center">
    <input type="submit" value="保存">
    </td>
    </tr>
  </form>
</table>
<!-- #include file="../Inc/Foot.asp" -->