<!--#include file="Conn.asp"-->
<%
If SiteStatus=0 Then
Response.Write("<html><head><title>"&SiteName&"- 网站升级更新中</title></head><body>")
	Response.Write(SiteInfo)
	Response.Write("</body></html>")
	Response.End()
end if
%>
<!--#include file="Const.asp"-->