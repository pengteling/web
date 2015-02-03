<!--#include file="FiveInc/Inc.asp"-->
<!--#include file="FiveInc/Check_Sql.asp"-->
<!--#include file="FiveInc/md5.asp"-->
<%
if CheckRequest(Request.Form(("work")))="add" then

ChkPost

dim mx_username,mx_password,CheckCode
mx_username=trim(request.Form("mx_username"))
mx_password=trim(request.Form("mx_password"))
CheckCode=CheckSQL(Request.Form("CheckCode"))
founderr=false

if Instr(mx_username,"=")>0 or Instr(mx_username,"%")>0 or Instr(mx_username,chr(32))>0 or Instr(mx_username,"?")>0 or Instr(mx_username,"&")>0 or Instr(mx_username,";")>0 or Instr(mx_username,",")>0 or Instr(mx_username,"'")>0 or Instr(mx_username,",")>0 or Instr(mx_username,chr(34))>0 or Instr(mx_username,chr(9))>0 or Instr(mx_username,"")>0 or Instr(mx_username,"$")>0 then
	errmsg=errmsg+"<br><li>·用户名中含有非法字符</li>"
	founderr=true
end if
if Instr(mx_password,"=")>0 or Instr(mx_password,"%")>0 or Instr(mx_password,chr(32))>0 or Instr(mx_password,"?")>0 or Instr(mx_password,"&")>0 or Instr(mx_password,";")>0 or Instr(mx_password,",")>0 or Instr(mx_password,"'")>0 or Instr(mx_password,",")>0 or Instr(mx_password,chr(34))>0 or Instr(mx_password,chr(9))>0 or Instr(mx_password,"")>0 or Instr(mx_password,"$")>0 then
	errmsg=errmsg+"<br><li>·密码中含有非法字符</li>"
	founderr=true
end if
'if CheckCode<>"" then
'If CheckCode="" or isempty(CheckCode)=true or isnull(CheckCode) Then
'	FoundErr=True
'	ErrMsg=ErrMsg & "<br><li>·请输入验证码!</li>"
'ElseIf CStr(Session("getcode"))<>CStr(Trim(Request("CheckCode"))) Then
'	FoundErr=True
'	ErrMsg=ErrMsg & "<br><li>·您输入的确认码和系统产生的不一致，请重新输入!</li>"
'	Session("getcode") = ""
'End If
'end if

if founderr=false then
	
	password=md5(mx_password)
	sql="select * from [User] where username='" & mx_username & "' and password='" & password &"'"
	rs.open sql,conn,1,3
	if not(rs.bof and rs.eof) then
		if rs("LockUser")=true then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>·用户名已被锁定，请与管理员联系!</li>"
		else
			rs("logins")=rs("logins")+1
			rs("LastLoginTime")=now()
			rs("LoginIP")=GetIP()
			rs.update
			'response.write rs("username")
			
			Response.Cookies("mx_password")=rs("password")
			if rs("istj") then
			response.cookies("mx_istj")="1"
			else
			response.cookies("mx_istj")="0"
			end if		
	
			Response.Cookies("mx_username")=rs("username")
			Response.Cookies("username")=rs("username")
			Response.Cookies("userid")=rs("userid")
			Response.Redirect "User_index.asp"
			response.write request.Cookies("mx_UserName")
			'response.write request.cookies("mx%5Fusername")
			response.write request.Cookies("mx_password")
			Response.End()
		end if
	else
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>·用户名或密码错误!</li>"
	end if
	rs.close
End If

End If
If Request.Cookies("mx_password")<>"" and Request.Cookies("mx_UserName")="" Then
	FoundErr=true
	'ErrMsg="<font class=red>修改成功，请重新登录！<font>"
	Response.Cookies("mx_password")=""
	Response.Cookies("mx_istj")=""
	Response.Cookies("userid")=""
End If
Session("RandomNumber")=GetRndPassword(16)





%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/css/base.css" rel="stylesheet" type="text/css">
<link href="/css/cart.css" rel="stylesheet" type="text/css">
<script src="/js/jquery.min.js" type="text/javascript"></script>
<script src="/js/base.js" type="text/javascript"></script>
<script src="/js/cart.js" type="text/javascript"></script>
<title>会员登陆</title>
</head>
<script>
$(function(){
	$(".ico01").addClass("hover ico01_");
	$(".user_title_more li").eq(<%=clng(request("v"))%>).addClass("hover");
})
</script>


<body>

<div class="width">
        <div class="user_bg">
            <div id="uleft">
    <!--#include virtual="/uleft.asp"-->
</div>
            <!--左侧结束-->
            <div id="uright">
                
                 
                 <div class="user_title_more">
                    <ul>
                        <li><a href="user_login.asp">用户登录</a></li>                      
                       <li><a href="user_reg.asp">用户注册</a></li>                 
                  
                    </ul>
                </div>
                <div class="page_content">
                
                <%If FoundErr=true then%>
<%=ErrMsg%>
<%else%>

<%end if%>
                    <form method="post">
                    <ul id="login">
                        <li class="msg">请先登录</li>
                        <li>账户：<input type="text" name="mx_username" class="ip" /></li>
                        <li>密码：<input type="password" name="mx_password" class="ip" /></li>
                        <li class="p42"><input type="hidden" name="gourl" value="<%=request("gourl")%>" /><input type="hidden" value="add" name="work"/><input type="submit" value="登录" class="bnt" /> <input type="button" value="注册用户" onClick="location.href='user_reg.asp'" class="bnt" /></li>
                    </ul>
                    </form>  
                </div>

            </div>
            <!--右侧结束-->
            <div class="clear"></div>
        </div>
    </div>
    
