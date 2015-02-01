<%
	Response.Cookies("mx_UserName")=""
	Response.Cookies("userName")=""
	Response.Cookies("userid")=""
	Response.Cookies("mx_password")=""
	
	Response.Cookies("mx_istj")=""
	if request("gourl")<>"" then
	Response.Redirect request("gourl")
	else
	Response.Redirect "user_login.asp"
	end if
%>