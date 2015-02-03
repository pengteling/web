<%
mx_UserName=request.Cookies("username")
mx_password=request.Cookies("mx_password")
userid=request.Cookies("userid")
'response.write request.Cookies("mx_username")
'response.write request.Cookies("mx_password")
'response.End()
If mx_UserName="" or Isnull(mx_UserName) or IsEmpty(mx_UserName) or mx_password="" or Isnull(mx_password) or IsEmpty(mx_password) then
	Response.Cookies("mx_UserName")=""
	Response.Cookies("mx_password")=""	
	Response.Redirect("User_login.asp")
	Response.End()
Else
	ChkSql="select * from [User_c] where LockUser=0 and username='" & mx_UserName & "' and password='" & mx_password &"'"
	set CheckRs=conn.execute(ChkSql)
	If CheckRs.eof and CheckRs.bof then
		Response.Cookies("mx_UserName")=""
		Response.Cookies("mx_password")=""
		Response.Redirect("User_login.asp")
		Response.End()
	Else
		'RegDate=CheckRs("RegDate")
		UserID=CheckRs("UserID")
		'UserDownClass=CheckRs("IsTJ")
		UserPoints=CheckRs("Points")
		username=CheckRs("username")
		userlogins=CheckRs("logins")
		usergroupname=CheckRs("usergroupname")
	End If
	CheckRs.close:Set CheckRs=Nothing
End If


'response.Cookies("userid")=20
'response.cookies("username")="user01"
if request.Cookies("userid")="" or request.Cookies("username")="" then

	Easp.str.JsAlertUrl "请先登陆！","/user_login.asp"	  
else
	userid = clng(request.Cookies("userid"))
	username=request.Cookies("username")
end if
Easp.var("userid")=userid
Easp.var("username")=username
Easp.var("userPoints")=UserPoints
Easp.var("userlogins")=userlogins
Easp.var("usergroupname") =usergroupname
%>