<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%
Action=ChkFormStr(Request("Act"))
title=ChkFormStr(request("title"))
ID=strToNum(Request("ID"))
if Action="Add" then
	if title="" then
		Response.Write("<script language=JavaScript>alert(""请填写类别名称!"");location.href=""javascript:history.back(-1);"";</script>")
		Response.End()
	end if
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.open "Select * From Catalogs_link Where title='" & title & "'",conn,1,3
	if not (rs.bof and rs.EOF) then
		Response.Write("<script language=JavaScript>alert(""此类别已存在!"");location.href=""javascript:history.back(-1);"";</script>")
		Response.End()
	else
    	rs.addnew
     	rs("title")=title
    	rs.update
     	rs.Close
	    set rs=Nothing
    	call CloseConn()
		Response.Redirect "ad_sort.asp"  
	end if
ElseIf Action="Del" Then
	Conn.Execute("Delete from Catalogs_link Where ID="&ID&"")
	Response.Redirect "ad_sort.asp"
ElseIf Action="Update" Then
	if title="" then
		Response.Write("<script language=JavaScript>alert(""请填写类别名称!"");location.href=""javascript:history.back(-1);"";</script>")
		Response.End()
	end if
	If ID=0 Then
		Response.Write("<script language=JavaScript>alert(""请正常选择!"");location.href=""javascript:history.back(-1);"";</script>")
		Response.End()
	End If
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.open "Select * From Catalogs_link Where title='" & title & "' and ID<>"&ID&"",conn,1,3
	if not (rs.bof and rs.EOF) then
		Response.Write("<script language=JavaScript>alert(""此类别已存在!"");location.href=""javascript:history.back(-1);"";</script>")
		Response.End()
	else
     	Conn.Execute("Update Catalogs_link Set title='"&title&"' Where ID="&ID&"")
    	call CloseConn()
		Response.Redirect "ad_sort.asp"  
	end if
end if


dim sql,rsClass,rsSmallClass,ErrMsg
set rsClass=server.CreateObject("adodb.recordset")
rsClass.open "Select * From Catalogs_link Order By id",conn,1,3
%>
<script language="JavaScript" type="text/JavaScript">
function checkBig()
{
  if (document.form1.title.value=="")
  {
    alert("名称不能为空！");
    document.form1.title.focus();
    return false;
  }
}
function ConfirmDelBig()
{
   if(confirm("确定要删除吗？"))
     return true;
   else
     return false;
	 
}
</script>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#000000" class="table_southidc">
  <tr>
    <td width="378" height="30" align="center"><strong>栏目名称</strong></td>
    <td width="368" height="30" align="center"><strong>操作选项</strong></td>
  </tr>
<%
do while not rsClass.eof
%>
  <tr bgcolor="#F2F8FF" class="tdbg">
    <td width="378" height="22" bgcolor="#F2F8FF" class="tr_southidc"><img src="../Images/tree_folder4.gif" width="19" height="18"><a href="ad_manage.asp?sortid=<%=rsClass("ID")%>"><%=rsClass("title")%></a></td>
    <td align="left" bgcolor="#F2F8FF" class="tr_southidc" style="padding-right:10">&nbsp;<a href="ad_sort.asp?Act=Modi&ID=<%=rsClass("ID")%>">修改</a> | <a href="ad_sort.asp?Act=Del&Id=<%=rsClass("ID")%>" onClick="return ConfirmDelBig();">删除</a></td>
  </tr>
<%
rsClass.MoveNext
Loop
%>
</table>
<%
rsClass.close
set rsClass=nothing
%>
<%If Action<>"Modi" Then%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">   
   <tr>
     <td height="5"></td>
   </tr>
</table>
<form name="form1" method="post" action="ad_sort.asp?Act=Add" onSubmit="return checkBig()">
   <table width="100%" border="0" align="center" cellspacing="1" class="table_southidc">
       <tr bgcolor="#E3E3E3" class="tdbg">
           <td width="13%" align="right" bgcolor="#E3E3E3" class="tr_southidc" style="font-weight: bold">添加新类别</td>
           <td width="15%" align="right" bgcolor="#E3E3E3" class="tr_southidc"><strong>栏目名称：</strong></td>
           <td width="18%" bgcolor="#E3E3E3" class="tr_southidc"><input name="title" type="text" size="20" maxlength="30"></td>
           <td width="54%" bgcolor="#E3E3E3" class="tr_southidc"><input name="Add" type="submit" value="确认添加"></td>
       </tr>
   </table>
</form>
<%End If%>
<%
If Action="Modi" Then
Set Rs=Conn.Execute("select * from Catalogs_link Where ID="&ID&"")
	if not rs.eof then
		title=rs("title")
		ID=rs("id")
	else
		Response.Write("<script language=JavaScript>alert(""此类别不存在或已被删除!"");location.href=""ad_sort.asp"";</script>")
		Response.End()
	end if
	rs.close
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">   
   <tr>
     <td height="5"></td>
   </tr>
</table>
<form name="form1" method="post" action="ad_sort.asp?Act=Update&ID=<%=ID%>" onSubmit="return checkBig()">
   <table width="100%" border="0" align="center" cellspacing="1" class="table_southidc">
       <tr bgcolor="#E3E3E3" class="tdbg">
           <td width="13%" align="right" bgcolor="#E3E3E3" class="tr_southidc" style="font-weight: bold">类别修改</td>
           <td width="15%" align="right" bgcolor="#E3E3E3" class="tr_southidc"><strong>栏目名称：</strong></td>
           <td width="18%" bgcolor="#E3E3E3" class="tr_southidc"><input name="title" value="<%=title%>" type="text" size="20" maxlength="30"></td>
           <td width="54%" bgcolor="#E3E3E3" class="tr_southidc"><input name="Add" type="submit" value="确认修改"></td>
       </tr>
   </table>
</form>
<%End If%>
<!-- #include file="../Inc/Foot.asp" -->