<!--#include file="../FiveInc/Conn.asp"-->
<!--#include file="../FiveInc/Check_Sql.asp"-->
<!--#include file="inc/md5.asp"-->

<%
	Dim server_b1,server_b2
	server_b1=Cstr(Request.ServerVariables("HTTP_REFERER"))
	server_b2=Cstr(Request.ServerVariables("SERVER_NAME"))
	If mid(server_b1,8,len(server_b2))<>server_b2 Then
		'Call ShowErr("<li>本页面禁止由外部链接<li>请从本站首页进入！",0,"default.asp")
		'Response.Write("<li>本页面禁止由外部链接<li>请从本站首页进入！")
		response.write"<SCRIPT language=JavaScript>alert('本页面禁止由外部链接！');"
		response.write"location.href=""../index.asp"";</SCRIPT>"
		response.End
	End If

dim username,password,CheckCode
username=CheckSQL(Request.Form("username"))
password=CheckSQL(Request.Form("password"))
CheckCode=CheckSQL(Request.Form("CheckCode"))

'Response.Write(CheckCode)
'Response.Write(Session("getcode"))
'Response.Write md5(password)
'Response.End

FoundErr=false
if UserName="" or IsEmpty(UserName)=True or IsNull(UserName) then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>用户名不能为空！</li>"
end if
if Password="" or IsEmpty(Password)=True or IsNull(Password) then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>密码不能为空！</li>"
end if
If CheckCode="" or isempty(CheckCode)=true or isnull(CheckCode) Then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>请输入验证码!</li>"
ElseIf Session("getcode")="" or isempty(Session("getcode")) or isnull(Session("getcode")) then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>你登录时间过长,请重新返回登录页面进行登录!</li>"
ElseIf Session("getcode") = "9999" Then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>请不要重复提交!</li>"
ElseIf CStr(Session("getcode"))<>CStr(Trim(Request("CheckCode"))) Then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>您输入的确认码和系统产生的不一致，请重新输入!</li>"
	Session("getcode") = ""
End If

if FoundErr<>True then
	sql="select * from zh_Admin where Password='"&md5(password)&"' and UserName='"&username&"'"
'	Response.Write sql
'	Response.end
    Set LoginRs=server.CreateObject("adodb.recordset")
	LoginRs.open sql,conn,1,3
	if LoginRs.bof or LoginRs.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>用户名或密码错误！！！</li>"
	else
		    RndPassword=GetRndPassword(16)
			LoginRs("LastLoginIP")=Request.ServerVariables("REMOTE_ADDR")
			LoginRs("LastLoginTime")=now()
			LoginRs("LoginTimes")=LoginRs("LoginTimes")+1
			LoginRs("RndPassword")=RndPassword
			
			LoginRs.update
			session.Timeout=SessionTimeout
			session("AdminID")=LoginRs("id")
			session("AdminName")=LoginRs("username")
			session("AdminPassword")=LoginRs("Password")		
			session("RndPassword")=RndPassword
			LoginRs.close
			set LoginRs=nothing
			
			Response.Redirect "default.asp"
			
	end if
	LoginRs.close
	set LoginRs=nothing
end if
if FoundErr=True then
	call WriteErrMsg()
end if
call CloseConn()

'****************************************************
'过程名：WriteErrMsg
'作  用：显示错误提示信息
'参  数：无
'****************************************************
sub WriteErrMsg()
	dim strErr
	strErr=strErr & "<html><head><title>错误信息</title><meta http-equiv='Content-Type' content='text/html; charset=gb2312'>" & vbcrlf
	strErr=strErr & "<link href='Inc/Admin.css' rel='stylesheet' type='text/css'></head><body>" & vbcrlf
	strErr=strErr & "<table cellpadding=2 cellspacing=1 border=0 width=400 class='border' align=center>" & vbcrlf
	strErr=strErr & "  <tr align='center'><td height='22' class='title'><strong>错误信息</strong></td></tr>" & vbcrlf
	strErr=strErr & "  <tr><td height='100' class='tdbg' valign='top'><b>产生错误的可能原因：</b><br>" & errmsg &"</td></tr>" & vbcrlf
	strErr=strErr & "  <tr align='center'><td class='tdbg'><a href='Login.asp'>&lt;&lt; 返回登录页面</a></td></tr>" & vbcrlf
	strErr=strErr & "</table>" & vbcrlf
	strErr=strErr & "</body></html>" & vbcrlf
	response.write strErr
end sub

Function GetRndPassword(PasswordLen)
	Dim Ran,i,strPassword
	strPassword=""
	For i=1 To PasswordLen
		Randomize
		Ran = CInt(Rnd * 2)
		Randomize
		If Ran = 0 Then
			Ran = CInt(Rnd * 25) + 97
			strPassword =strPassword & UCase(Chr(Ran))
		ElseIf Ran = 1 Then
			Ran = CInt(Rnd * 9)
			strPassword = strPassword & Ran
		ElseIf Ran = 2 Then
			Ran = CInt(Rnd * 25) + 97
			strPassword =strPassword & Chr(Ran)
		End If
	Next
	GetRndPassword=strPassword
End Function
%>