<%
session("AdminName")=""
Response.Cookies("xd_urljilunew")=""
Response.Cookies("xd_urljilu")=""
session.abandon()
Response.Redirect "Login.asp"
%>