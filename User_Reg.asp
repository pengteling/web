<!--#include file="FiveInc/Inc.asp"-->
<!--#include file="FiveInc/Check_Sql.asp"-->
<!--#include file="FiveInc/md5.asp"-->
<%
if CheckRequest(Request.Form(("work")))="add" then
ChkPost
dim UserName,Password,PwdConfirm,Email,CheckCode
UserName=trim(request.Form("UserName"))
Password=trim(request.Form("Password"))
PwdConfirm=trim(request.Form("PwdConfirm"))
Email=trim(request.Form("Email"))
CheckCode=CheckSQL(Request.Form("CheckCode"))
sex=trim(request.Form("sex"))
job=trim(request.Form("job"))
Comane=trim(request.Form("Comane"))
Add=trim(request.Form("Add"))
Phone=trim(request.Form("Phone"))
UserDemo=trim(request.Form("UserDemo"))
isRecive=trim(request.Form("isRecive"))
'birthday=trim(request.Form("birthday"))

if isRecive<>"" then 
	isRecive=1
else
	isRecive=0
end if
founderr=false
if UserName="" or strLength(UserName)>14 or strLength(UserName)<4 then
	founderr=true
	errmsg=errmsg & "<br>·请输入用户名(不能大于14小于4)"
else
  	if Instr(UserName,"=")>0 or Instr(UserName,"%")>0 or Instr(UserName,chr(32))>0 or Instr(UserName,"?")>0 or Instr(UserName,"&")>0 or Instr(UserName,";")>0 or Instr(UserName,",")>0 or Instr(UserName,"'")>0 or Instr(UserName,",")>0 or Instr(UserName,chr(34))>0 or Instr(UserName,chr(9))>0 or Instr(UserName,"")>0 or Instr(UserName,"$")>0 then
		errmsg=errmsg+"<br>·用户名中含有非法字符"
		founderr=true
	end if
end if
if Password="" or strLength(Password)>12 or strLength(Password)<6 then
	founderr=true
	errmsg=errmsg & "<br>·请输入密码(不能大于12小于6)"
else
	if Instr(Password,"=")>0 or Instr(Password,"%")>0 or Instr(Password,chr(32))>0 or Instr(Password,"?")>0 or Instr(Password,"&")>0 or Instr(Password,";")>0 or Instr(Password,",")>0 or Instr(Password,"'")>0 or Instr(Password,",")>0 or Instr(Password,chr(34))>0 or Instr(Password,chr(9))>0 or Instr(Password,"")>0 or Instr(Password,"$")>0 then
		errmsg=errmsg+"<br>·密码中含有非法字符"
		founderr=true
	end if
end if
if PwdConfirm="" then
	founderr=true
	errmsg=errmsg & "<br>·请输入确认密码(不能大于12小于6)"
else
	if Password<>PwdConfirm then
		founderr=true
		errmsg=errmsg & "<br>·密码和确认密码不一致"
	end if
end if
if Email="" then
	founderr=true
	errmsg=errmsg & "<br>·Email不能为空"
else
	if IsValidEmail(Email)=false then
		errmsg=errmsg & "<br>·您的Email有错误"
   		founderr=true
	end if
end if

if phone<>"" then
		Set re=new RegExp
		re.IgnoreCase =True
		re.Global=True
		
		re.Pattern = "((\(\d{3}\))|(\d{3}\-))?13\d{9}|(15\d{1}\d{8})|(18\d{1}\d{8})"
		If re.test(phone) Then
		
		else
		FoundErr=true
		ErrMsg=ErrMsg & "<br><li>·您输入的手机号码格式错误！</li>"
		end if
end if

'if birthday="" then
'	founderr=true
'	errmsg=errmsg & "<br>·生日不能为空"
'else
'	if isdate(birthday)=false then
'		errmsg=errmsg & "<br>·您的生日格式有错误"
'   		founderr=true
'	end if
'end if


If CheckCode="" or isempty(CheckCode)=true or isnull(CheckCode) Then
	FoundErr=True
	ErrMsg=ErrMsg & "<br>·请输入验证码!"
ElseIf CStr(Session("getcode"))<>CStr(Trim(Request("CheckCode"))) Then
	FoundErr=True
	ErrMsg=ErrMsg & "<br>·您输入的确认码和系统产生的不一致，请重新输入!"
	Session("getcode") = ""
End If

if founderr=false then
	dim sqlReg,rsReg
	sqlReg="select * from [User] where UserName='" & Username & "' or Email='"&Email&"'"
	set rsReg=server.createobject("adodb.recordset")
	rsReg.open sqlReg,conn,1,3
	if not(rsReg.bof and rsReg.eof) then
		founderr=true
		errmsg=errmsg & "<br>·你注册的用户或邮箱已经存在！请换一个用户名再试试！"
	else
		rsReg.addnew
		rsReg("UserName")=UserName
		rsReg("Password")=md5(Password)
		rsReg("Email")=Email
		rsReg("logins")=1
		rsReg("sex")=sex
		rsReg("add")=add
		rsReg("phone")=phone
		rsReg("sex")=sex
		rsReg("isRecive")=isRecive
		rsReg("job")=job
		rsReg("Comane")=Comane
		rsReg("UserDemo")=UserDemo
		rsReg("LoginIP")=GetIP()
		'rsReg("birthday")=birthday
		
		rsReg.update
		founderr=false
		Response.Cookies("mx_UserName")=UserName
		Response.Cookies("mx_password")=md5(Password)
		Response.Redirect("user.asp")
	end if
	rsReg.close
	set rsReg=nothing
	Session("RandomNumber")=""
End If
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

else
	response.write "网址传递参数有误"
	response.End()

end if
rs.close

%>

<!--#include virtual="/lmenu.asp"-->
<!--#include virtual="/top.asp"-->

<div class="main">
<div class="cleft"> 
  <!--#include virtual="/cleft.asp"--> 
</div>
<div class="cright">
  <div class="curlocation clearfix">
    <div class="fr"><img src="/images/home.jpg" /> 您当前位置：<%=menustr%></div>
  </div>
  <div class="maincontent" >
    <div class="tit"><%=catename%></div>
    <div class="newszy">1.以下信息务必填写正确、清楚 (<span class="blue">信息完全保密，不对外公开。带红色 <span class="red">*</span> 必需填写</span>)。 2.注册并登录后，可以使用会员的众多功能，如免
      费使用SCI写作宝典,论文上传等。 3.下载一些重要的资料和信息</div>
    <%If FoundErr=true then%>
    <div class="error"><%=ErrMsg%></div>
    <%end if%>
    <div class="regform">
    <form action='User_Reg.asp' method='post' name='UserReg' id="UserReg">
      <dl>
        <dt>用户名：<span class="red">*</span></dt>
        <dd>
          <input name="UserName" value="<%=UserName%>"   maxlength="14" class="txtinput"/>
        </dd>
      </dl>
      <dl>
        <dt>密码：<span class="red">*</span></dt>
        <dd>
          <input  type="password" maxlength="16" name="Password"  class="txtinput"/>
          &nbsp;密码必须为6~16位</dd>
      </dl>
      <dl>
        <dt>确认密码：<span class="red">*</span></dt>
        <dd>
          <input  type="password" maxlength="16" name="PwdConfirm"  class="txtinput"/>
          &nbsp;两次输入的密码必须相同</dd>
      </dl>
      <dl>
        <dt>手机号码：<span class="red">*</span></dt>
        <dd>
          <input name="phone" value="<%=phone%>"   class="txtinput"/>
        </dd>
      </dl>
      <dl>
        <dt>E-mail：<span class="red">*</span></dt>
        <dd>
          <input name="Email" value="<%=Email%>"   class="txtinput"/>
        </dd>
      </dl>
      <dl>
        <dt>称谓：<span class="red">*</span></dt>
        <dd>
          <input type="radio" name="sex" value="0" checked/>
          女士/小姐
          <input type="radio" name="sex" value="1" />
          先生</dd>
      </dl>
      <!--   <dl> 
    <dt>生日：<span class="red">*</span></dt>
    <dd> <input  type="text" maxlength="16" name="birthday"  class="txtinput Wdate" style="width:100px;"  onClick="WdatePicker();"/>&nbsp;点击选择你的生日</dd>
    </dl>-->
      
      <dl>
        <dt>单位名称及科室：</dt>
        <dd>
          <input name="Comane" value="<%=Comane%>"   class="txtinput"/>
        </dd>
      </dl>
      <dl>
        <dt>联系地址：</dt>
        <dd>
          <input name="add" value="<%=add%>"   class="txtinput"/>
        </dd>
      </dl>
      <dl>
        <dt>验证码：<span class="red">*</span></dt>
        <dd>
          <input name="CheckCode" type="text" class="ipt_text_y" id="VerifyCode3" size="9" maxlength="4" autocomplete="off" />
          <img src="../FiveInc/GetCode_zh.asp" alt="验证码,看不清楚?请点击刷新验证码" height="10" style="cursor : pointer;" onclick="this.src='../FiveInc/getcode_zh.asp?t='+(new Date().getTime());" /> </dd>
      </dl>
      <!-- <dl>
      <dt>&nbsp;</dt>
      <dd>
        <input type="checkbox" name="isrecive" value="1"/>
        我希望收到活动信息和电子期刊
       
      </dd>
    </dl>-->
      
      <input name="RanNumber" type="hidden" id="Act" value="<%=Session("RandomNumber")%>" />
      <input id="work" type="hidden" value="add" name="work" />
      <div class="s_l"> <a class="btn_r">
        <input type="submit" name="imageField2" class="bg_b" value="提交注册" />
        </a><a class="btn_l">
        <input type="button" class="bg_b" value="重新填写" onclick="javascript:document.forms['UserReg'].reset(); return false;" />
        </a> </div>
      </div>
    </form>
  </div>
</div>
<div class="clear"></div>
</div>
<!--#include file="foot.asp"-->