<!--#include file="FiveInc/Inc.asp"-->
<!--#include file="FiveInc/Check_Sql.asp"-->
<!--#include file="FiveInc/md5.asp"-->
<!--#include file="User_Config.asp"-->
<!--#include file="User_CheckSession.asp"-->
<%
dim Action,UserName,FoundErr,ErrMsg
dim rsUser,sqlUser
Action=trim(request("Action"))
if Action="Modify" then
	Set rsUser=Server.CreateObject("Adodb.RecordSet")
	sqlUser="select * from [User] where UserName='" & UserName & "'"
	rsUser.Open sqlUser,conn,1,3
	if rsUser.bof and rsUser.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>找不到指定的用户！</li>"
	else
		dim OldPassword,Password,PwdConfirm
		OldPassword=trim(request("OldPassword"))
		Password=trim(request("Password"))
		PwdConfirm=trim(request("PwdConfirm"))
		if OldPassword="" then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>请输入旧密码！</li>"
		else
			if Instr(OldPassword,"=")>0 or Instr(OldPassword,"%")>0 or Instr(OldPassword,chr(32))>0 or Instr(OldPassword,"?")>0 or Instr(OldPassword,"&")>0 or Instr(OldPassword,";")>0 or Instr(OldPassword,",")>0 or Instr(OldPassword,"'")>0 or Instr(OldPassword,",")>0 or Instr(OldPassword,chr(34))>0 or Instr(OldPassword,chr(9))>0 or Instr(OldPassword,"")>0 or Instr(OldPassword,"$")>0 then
				errmsg=errmsg+"<br><li>旧密码中含有非法字符</li>"
				founderr=true
			else
				if md5(OldPassword)<>rsUser("Password") then
					FoundErr=True
					ErrMsg=ErrMsg & "<br><li>你输入的旧密码不对，没有权限修改！</li>"
				end if
			end if
		end if
		if strLength(Password)>12 or strLength(Password)<6 then
			founderr=true
			errmsg=errmsg & "<br><li>请输入新密码(不能大于12小于6)。</li>"
		else
			if Instr(Password,"=")>0 or Instr(Password,"%")>0 or Instr(Password,chr(32))>0 or Instr(Password,"?")>0 or Instr(Password,"&")>0 or Instr(Password,";")>0 or Instr(Password,",")>0 or Instr(Password,"'")>0 or Instr(Password,",")>0 or Instr(Password,chr(34))>0 or Instr(Password,chr(9))>0 or Instr(Password,"")>0 or Instr(Password,"$")>0 then
				errmsg=errmsg+"<br><li>新密码中含有非法字符</li>"
				founderr=true
			end if
		end if
		if PwdConfirm="" then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>请输入确认密码！</li>"
		else
			if PwdConfirm<>Password then
				FoundErr=True
				ErrMsg=ErrMsg & "<br><li>确认密码与新密码不一致！</li>"
			end if
		end if
		if FoundErr<>true then
			rsUser("Password")=md5(Password)
			rsUser.update
		end if
	end if
	rsUser.close
	set rsUser=nothing
	if FoundErr=True then
		call WriteErrMsg()
	else
	    response.write"<SCRIPT language=JavaScript>alert('成功修改密码！');"
        response.write"javascript:history.go(-1)</SCRIPT>"
		'call WriteSuccessMsg("成功修改密码！")
	end if
else
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="zh-CN" />
<title>修改密码 - <%=SiteTitle%></title>
<link rel="stylesheet" href="css/neiye.css">
<%
nidtt=2

if nidtt<>0 then 
nidt=nidtt
else
nidt=strToNum(nid)
end if
if xxxddd=1 then

nidt=1
end if
if nidt=0 then
nidt=1
end if
xxsql="select * from Company where IsHome=1 and id="&nidt
set cb=conn.execute(xxsql)
if cb.eof then response.Write("没有此栏目"):response.End()
if cb("ParentID")=0 then

ttis=cb("ComName")
ttid=cb("id")
else

ersql="select * from Company where IsHome=1 and id="&cb("ParentID")
set cbt=conn.execute(ersql)
ttis=cbt("ComName")
ttid=cbt("id")

MenuBar = "&nbsp;&gt;&nbsp;<a href='Company.asp?id="&ttid&"'>" &ttis & "</a>"&MenuBar
cbt.close
set cbt=nothing
end if
cb.close
set cb=nothing

nidt=45

set xds=conn.execute("select * from Company where ParentID="&ttid&"")
			if xds.eof then
			ttid=1
			ttis="走进蓝迪斯"
			end if
			xds.close
			set xds=nothing
	II="select * from Company where ParentID="&ttid&" order by OrderID,id"
			set xdII=conn.execute(II)
			do While not xdII.Eof
			
			menustr=menustr&"<li><a "
			if nidt=xdII("id") then  menustr=menustr&"class=""nlm_select"""
			if xdII("IsOutLink")=0 then 
				menustr=menustr&" href=""Company.asp?id="&xdII("id")&""">"&xdII("ComName")&"</a>"
			else
				menustr=menustr&" href="""&xdII("OutLinkUrl")&""">"&xdII("ComName")&"</a>"
			end if
			menustr=menustr&"</li>"
			
		  xdII.moveNext
		  Loop
		  xdII.Close
		  Set xdII = nothing
		%>
<!--#include file="top.asp"-->
<div class="n_left">
  <div class="nl_menu"> <a href=#>首页</a> &nbsp;&gt;&nbsp;<a href='Company.asp?id=2'>会员专区</a>&nbsp;&gt;&nbsp;<a href='user_reg.asp'>会员信息</a></div>
  <ul>
    <%=menustr%>
  </ul>
  <div class="nl_ad"> <a href=#><img src="images/list_ad2.jpg" /></a> <a href=#><img src="images/list_ad1.jpg" /></a> </div>
  <div class="nl_tel"></div>
</div>
 <div class="n_right">
    <div class="nr_main_m">
<!--#include file="user_submenu.asp"-->

        <div class="m_title margin20">修改密码</div>
<div class="m_content m_userinfo">

<table Class=border width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="206" valign="top" background="images/t3.jpg"><FORM name="Form1" action="User_Pwd.asp" method="post">
                  <table width=400 border=0 align="center" cellpadding=2 cellspacing=2 class='border'>
                    <TR align=center class='title'> 
                      <TD height=20 colSpan=2><font color="#FF6600" class=font14><b>修改用户密码</b></font></TD>
                    </TR>
                    <TR> 
                      <TD width="120" align="right"><b>用 户 名：</b></TD>
                      <TD align="left"><%=mx_username%> <input name="UserName" type="hidden" value="<%=session("UserName")%>"></TD>
                    </TR>
                    <TR> 
                      <TD width="120" align="right"><B>旧 密 码：</B></TD>
                      <TD align="left"> <INPUT   type=password maxLength=16 size=30 name=OldPassword class="ipt_text_l">                      </TD>
                    </TR>
                    <TR> 
                      <TD width="120" align="right"><B>新 密 码：</B></TD>
                      <TD align="left"> <INPUT   type=password maxLength=16 size=30 name=Password class="ipt_text_l">                      </TD>
                    </TR>
                    <TR> 
                      <TD width="120" align="right"><strong>确认密码：</strong></TD>
                      <TD align="left"><INPUT name=PwdConfirm   type=password id="PwdConfirm" size=30 maxLength=16 class="ipt_text_l">                      </TD>
                    </TR>
                    <TR align="center"> 
                     <td></td> <TD height="40" align="center"><a class="btn_r"><input name="Action" type="hidden" id="Action" value="Modify"> 
                        <input name=Submit   type=submit id="Submit" value=" 保 存 " class="bg_b1"></a>                      </TD>
                    </TR>
                  </TABLE>
			    </form>			    </td>
              </tr>
            </table>
	  </div></div>
</div>
</div>
<div class="clear"></div>


<!--#include file="foot.asp"-->

</body>
</html>
<%
end if
'call CloseConn()
%>