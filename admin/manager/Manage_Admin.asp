<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!--#include file="../Inc/md5.asp"-->
<!-- #include file="../Inc/Head.asp" -->
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
sqltext="select a.*,g.title as groupname from zh_Admin a left join zh_adminGroup g on a.groupid=g.id order  by a.orderid "
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
                  <input type="text" name="pwd" size="16">所属分组：
                  <select name="groupid" >
                  <%
				  set rs2=server.CreateObject("adodb.recordset")
				  rs2.open "Select * from zh_adminGroup order by orderid",conn,1,1
				  while not rs2.eof 
				  response.write "<option value="""&rs2("id")&""">"&rs2("title")&"</option>"
				  rs2.movenext
				  wend
				  
				  rs2.close
				  %>
                  </select>
                  序号：<input name="orderid" type="text" size="2" maxlength="10" value="0">
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
              	<td align="center" class="tr_southidc">序号</td>
                <td width="28%" height="25" align="center" class="tr_southidc"> 管理员帐号</td>
                <td align="center" class="tr_southidc">所属管理员组</td>
                <td align="center" class="tr_southidc">最后登陆IP</td>
                <td align="center" class="tr_southidc">最后登陆时间</td>
                <td align="center" class="tr_southidc">总登陆次数</td>
                <td width="20%" align="center" class="tr_southidc"> 操作</td>
              </tr>
              <%
if not rs.eof then
do while not rs.eof
%>
              <tr>
              <td  align="center" class="tr_southidc"><%=rs("orderid")%></td>
                <td height="22" align="center" class="tr_southidc"><%=rs("UserName")%></td>
                <td align="center" class="tr_southidc"><%=rs("groupname")%></td>
                <td align="center" class="tr_southidc"><%=rs("lastloginIP")%>
                </td>
                <td align="center" class="tr_southidc"><%=rs("lastloginTime")%>
                </td>
                <td align="center" class="tr_southidc"><%=rs("logintimes")%>
                </td>
                <td align="center" class="tr_southidc"><%response.write "<a href='Manage_Admin.asp?Act=Modify&ID="&rs("Id")&"'  >修改</a>   " 
				
				%><%response.write " <a href='javascript:confirmdel(" & rs("Id") & ")'>删除</a>"%>
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
                  <td height="22" align="right"> 管理员角色：</td>
                  <td><select name="groupid" >
                  <%
				  set rs2=server.CreateObject("adodb.recordset")
				  rs2.open "Select * from zh_adminGroup order by orderid",conn,1,1
				  while not rs2.eof 
				  response.write "<option value="""&rs2("id")&""""
				  if rs2("id")=rs("groupid") then response.Write " selected"
					response.write 	  ">"&rs2("title")&"</option>"
				  rs2.movenext
				  wend
				  
				  rs2.close
				  %>
                  </select>
                  </td>
                </tr>
                <tr>
                <td align="right">序号：</td>
                <td><input name="orderid" type="text" size="2" maxlength="10" value="<%=rs("orderid")%>"></td>
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
	rs("groupid")=request.form("groupid")
	rs("orderid")=request.form("orderid")
	
	rs.update
	rs.close
	response.redirect "Manage_Admin.asp"
End Sub
Sub AddManage()
	password=replace(trim(Request("pwd")),"'","")
	uid=replace(trim(Request("uid")),"'","")
	password=md5(password)
	groupid=strToNum(Request("groupid"))
	orderID=strToNum(Request("orderID"))
	
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
	rs("groupid")=groupid
	rs("orderid")=orderid
	rs.update
	rs.close
		response.write"<SCRIPT language=JavaScript>alert('帐号添加成功！');"
		response.write"location.href=""Manage_Admin.asp"";</SCRIPT>"
		response.End()
End Sub


%>
<!-- #include file="../Inc/Foot.asp" -->