<!--#include file="../FiveInc/conn.asp"-->
<!--#include file="admin.asp"-->
<!--#include file="Inc/md5.asp"-->
<!-- #include file="Inc/Head.asp" -->
<%
Act=Trim(Request.QueryString("Act"))
Select Case Act
	Case "Save"
		AddManage
	Case "Modify"
		ModiManage
	Case "Update"
		UpdateManage
	Case "Del"
		DelManage
	Case "permission"
		'response.Redirect(
	Case Else
		Main
End Select
Sub Main
set rs=server.createobject("adodb.recordset")
'sqltext="select * from zh_Admin Where IsHide=False"
sqltext="select * from zh_Admin "
rs.open sqltext,conn,1,1
%>
<script language="javascript">
function confirmdel(id){
if (confirm("真的要删除此管理员帐号?"))
window.location.href="Manage_Admin.asp?Act=Del&id="+id+"  "   }
</script>
<script type="text/javascript">
<!--
function form1_onsubmit()
{
	if (document.form1.uid.value==''){
		alert ("用户名不能为空。");
		document.form1.uid.focus();
		return false;
	}
	if (document.form1.pwd.value==''){
		alert ("用户密码不能为空。");
		document.form1.pwd.focus();
		return false;
	}
}
//-->
</SCRIPT>
<table width="100%" height="100" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td align="center" valign="top"><table width="100%" border="0" cellpadding="2" cellspacing="1" class="table_southidc">
        <tr> 
          <td height="25" align="center" class="blod" > 添加系统管理员</td>
        </tr>
        <tr class="tr_southidc"> 
          <form  name="form1"  onsubmit="return form1_onsubmit()" action="Manage_Admin.asp?Act=Save" method="post">
            <td><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" >
                
                <tr> 
                  <td height="22" align="center"> 管理员帐号：
                  <input type="text" name="uid" size="16" maxlength="20"> 
                  管理员密码：
                  <input type="text" name="pwd" size="16">
                  <input type="radio" name="issuper" value="0" checked>普通管理员<input type="radio" name="issuper" value="1">超级管理员
                  <input type="submit" value='确认添加' name="Submit2"></td>
                </tr>
                
            </table></td>
          </form>
        </tr>
      </table>
      <br> 
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table_southidc">
        <tr> 
          <td height="25" align="center" class="blod"> 管理员帐号管理</td>
        </tr>
        <tr> 
            <td><table width="100%" border="0" align="center" cellpadding="0" cellspacing="1">
              <tr>
                <td width="28%" height="25" align="center" class="tr_southidc"> 管理员帐号</td>
                <td width="24%" align="center" class="tr_southidc"> 操作</td>
                <td width="20%" align="center" class="tr_southidc"> 删除</td>
              </tr>
              <%
if not rs.eof then
do while not rs.eof
%>
              <tr>
                <td height="22" align="center" class="tr_southidc"><%=rs("UserName")%></td>
                <td align="center" class="tr_southidc"><%response.write "<a href='Manage_Admin.asp?Act=Modify&ID="&rs("Id")&"'  >修改密码和等级</a>" 
				if not rs("issuper") then
				response.write "&nbsp;&nbsp;<a href='Manage_Admin_permission.asp?Act=permission&ID="&rs("Id")&"'  >设置栏目权限</a>" 
				end if
				%>
                </td>
                <td align="center" class="tr_southidc"><%response.write "<a href='javascript:confirmdel(" & rs("Id") & ")'>删除</a>"%>
                </td>
              </tr>
              <%
rs.movenext
loop
end if
%>
              <%
rs.close
conn.close
%>
            </table></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%
End Sub




Sub ModiManage()
id=request("id")
set rs=server.createobject("adodb.recordset")
sqltext="select * from zh_Admin where Id=" & id
rs.open sqltext,conn,1,1
%>
<script type="text/javascript">
<!--
function form1_onsubmit()
{
	if (document.form1.pwd1.value==''){
		//alert ("新密码不能为空!");
		//document.form1.pwd1.focus();
		//return false;
	}
	if (document.form1.pwd2.value==''){
		//alert ("密码确认不能为空!");
		//document.form1.pwd2.focus();
		//return false;
	}
	if (document.form1.pwd1.value!=document.form1.pwd2.value){
		alert ("两次密码不相同!");
		document.form1.pwd1.focus();
		return false;
	}
}
//-->
</SCRIPT>
<table width="100%" border="0" cellpadding="2" cellspacing="1" class="table_southidc">
        <tr> 
          <td height="25" align="center" class="back_southidc"><strong>管理员密码修改</strong></td>
        </tr>
        <tr class="tr_southidc"> 
          <form name="form1"  onsubmit="return form1_onsubmit()" action="Manage_Admin.asp?Act=Update&uid=<%=rs("Id")%>" method="post">
            <input type="hidden" value="<%=rs("UserName")%>" name="uid">
            <td><table width="50%" border="0" align="center" cellpadding="0" cellspacing="2">
                <tr> 
                  <td height="25" colspan="2">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="29%" height="22" align="right"> 管理帐号：</td>
                  <td width="71%"><%=rs("UserName")%></td>
                </tr>
                <tr> 
                  <td height="22" align="right"> 管理密码：</td>
                  <td><input name="pwd1" type="text" size="16" maxlength="20"> 不修改密码请留空</td>
                </tr>
                <tr> 
                  <td height="22" align="right"> 密码确认：</td>
                  <td><input name="pwd2" type="text" size="16" maxlength="20"></td>
                </tr>
                <tr> 
                  <td height="22" align="right"> 是否超级管理员：</td>
                  <td><input type="radio" name="issuper" value="0" <%if not rs("issuper") then response.write "checked"%> >普通管理员<input type="radio" name="issuper" value="1" <%if  rs("issuper") then response.write "checked"%>>超级管理员</td>
                </tr>
                <tr> 
                  <td height="22" colspan="2"><div align="center">
                      <INPUT  type="submit" value="确认修改" name="Submit2">
                    &nbsp;
                    <input type="button" name="Submit" value="返回上一页" onClick="history.go(-1);">
                  </div></td>
                </tr>
              </table></td>
          </form>
        </tr>
</table>
<%
End Sub
Sub DelManage()
	contentID=request("ID")
	set rs=server.createobject("adodb.recordset")
	sqltext="delete from zh_Admin where Id="& contentID
	rs.open sqltext,conn,3,3
	set rs=nothing
	response.redirect "Manage_Admin.asp"
End Sub
Sub UpdateManage()
	set rs=server.createobject("adodb.recordset")
	sqltext="select * from zh_Admin where Id=" & request.querystring("uid")
	rs.open sqltext,conn,3,3
	'更新管理员密码到数据库
	rs("UserName")=request.form("uid")
	if request.form("pwd1")<>"" then
		rs("PassWord")=md5(request.form("pwd1"))
	end if
	rs("issuper")=request.Form("issuper")
	rs.update
	rs.close
	response.redirect "Manage_Admin.asp"
End Sub
Sub AddManage()
	password=replace(trim(Request("pwd")),"'","")
	uid=replace(trim(Request("uid")),"'","")
	password=md5(password)
	
	set rs=server.createobject("adodb.recordset")
	sqltext="select * from zh_Admin where UserName='" & uid & "'"
	rs.open sqltext,conn,1,1

	'查找数据库，检查此管理员是否已经存在
	if rs.recordcount >= 1 then
	if rs("UserName")=uid then
		response.write"<SCRIPT language=JavaScript>alert('此管理员帐号已经存在，请选用其它名称！');"
		response.write"history.back(-1);</SCRIPT>"
		response.End()
	rs.close
	end if
	end if

	set rs=server.createobject("adodb.recordset")
	sqltext="select * from zh_Admin"
	rs.open sqltext,conn,3,3

	'添加一个管理员帐号到数据库
	rs.addnew
	rs("UserName")=uid
	rs("PassWord")=password
	if request.Form("issuper")=1 then
		rs("issuper")=True
	else
		rs("issuper")=false
	end if
	rs.update
	rs.close
		response.write"<SCRIPT language=JavaScript>alert('帐号添加成功！');"
		response.write"location.href=""Manage_Admin.asp"";</SCRIPT>"
		response.End()
End Sub


%>
<!-- #include file="Inc/Foot.asp" -->