
<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%
'定义变量
dim id,tabname,newsUrl,isoutlink
id=Clng(request.QueryString("id"))
'tabname=trim(request.QueryString("table"))
tabname="photos"
%>
<meta http-equiv="refresh" content="1;URL=<%=request.ServerVariables("HTTP_REFERER")%>">
<%
if(tabname="news") then
 	newsUrl=conn.execute("select pagepath from "&tabname&" where id="&id)(0)
 	isoutlink=Cint(conn.execute("select isoutlink from "&tabname&" where id="&id)(0))
 	if(isoutlink=0) then
 	Set fso = Server.CreateObject(xiaodaofso)
 	if not fso.FileExists(server.MapPath("../"&newsUrl)) then  
 		Response.Write("<h1>Error:</h1>" & server.MapPath("../"&newsUrl)&" does not exist<p>")
 		conn.execute("delete from "&tabname&" where id="&id)		
 	else
 		fso.DeleteFile(server.MapPath("../"&newsUrl))
 		Response.Write("<h1>成功删除文件:</h1>" & server.MapPath("../"&newsUrl))
 	end if
 	set fso=nothing
 	end if
else
	
end if
conn.execute("delete from "&tabname&" where id="&id)
call closeconn()
%>
<div align="center">
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p class="style1">
  <%response.Write("delete success!")%></p>
</div>
<!-- #include file="../Inc/Foot.asp" -->
