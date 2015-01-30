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



nid=4
rs.open "select * from category where cateid="&nid,conn,1,1
if not rs.eof then
	parentid=rs("parentid")
	sonid=rs("sonid")
	followid=rs("followid")	
	catetype=rs("catetype")
	modeltype=rs("modeltype")
	catename= rs("catename")		
	title=rs("title")
	Com_Content=rs("content")
	defaultpicurl=rs("defaultpicurl")

else
	response.write "网址传递参数有误"
	response.End()

end if
rs.close

%>


<!--#include virtual="/lmenu.asp"-->
<!--#include virtual="/top.asp"-->
<div class="greybg">
<div class="nmain-t"></div>
<div class="nmain-m">

<div class="main">
  
  <div class="dymain">
  
    <div class="tit"><img src="<%=defaultpicurl%>" height="50" />
    </div>
    
    <div class="maincontent" > 
    	<!--<div class="tit"><%=com_title%></div>     -->
        

      <div class="mcontent login-form">
	  <form action='User_Login.asp' method='post' name='UserLogin' id="UserLogin">
        <dl>        
          <dt>用户名：</dt>
          <dd>
            <input name="mx_username" class="ipt_text_l" value="<%=mx_username%>"   maxlength="20"/>
          </dd>
        </dl>
        <dl>
          <dt>密码：</dt>
          <dd>
            <input  type="password" maxlength="16" name="mx_password" class="ipt_text_l"/>
          </dd>
        </dl>
        
        <dl>
          <dt>&nbsp;</dt>
          <dd style="text-align:center">
            <%If FoundErr=true then%>
<%=ErrMsg%>
<%else%>
*所有信息，不能为空！
<%end if%>
          </dd>
        </dl>
        <!--<dl>
          <dt>验证码：</dt>
          <dd>
            <input name="CheckCode" type="text" class="ipt_text_y" id="VerifyCode3" size="9" maxlength="4" autocomplete="off" />
            <img src="../FiveInc/GetCode_zh.asp" alt="验证码,看不清楚?请点击刷新验证码" height="15" style="cursor : pointer;" onclick="this.src='../FiveInc/getcode_zh.asp?t='+(new Date().getTime());" /> </dd>
        </dl>-->
            <div class="s_l"> 
            <input name="RanNumber" type="hidden" id="Act" value="<%=Session("RandomNumber")%>" />
                        <input id="work" type="hidden" value="add" name="work" />
     
        <input type="submit" name="imageField2" class="bg_b" value="" />        
        
      
        
   
    </form>
      
      </div>
    </div>
  </div>
  <div class="clear"></div>
</div>
</div>

</div>
<div class="nmain-b"></div>




<!--#include virtual="/foot.asp"-->




    
  

