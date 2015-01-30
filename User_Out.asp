<%
	Response.Cookies("mx_UserName")=""
	Response.Cookies("userName")=""
	Response.Cookies("mx_password")=""
	
	Response.Cookies("mx_istj")=""
	Response.Redirect "user_login.asp"
%>