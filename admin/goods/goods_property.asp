<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%
Action=ChkFormStr(Request("Act"))
propertyName=ChkFormStr(request("propertyName"))
ID=strToNum(Request("ID"))
orderID=strToNum(Request("orderID"))
cateid = strToNum(Request("cateid"))
if Action="Add" then
	if propertyName="" then
		Response.Write("<script language=JavaScript>alert(""请填写属性名称!"");location.href=""javascript:history.back(-1);"";</script>")
		Response.End()
	end if
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.open "Select * From goods_property Where propertyName='" & propertyName & "'",conn,1,3
	if not (rs.bof and rs.EOF) then
		Response.Write("<script language=JavaScript>alert(""此属性已存在!"");location.href=""javascript:history.back(-1);"";</script>")
		Response.End()
	else
    	rs.addnew
     	rs("propertyName")=propertyName
		rs("orderid")=orderid
		rs("cateid")=cateid
    	rs.update
     	rs.Close
	    set rs=Nothing
    	call CloseConn()
		Response.Redirect "goods_property.asp"  
	end if
ElseIf Action="Del" Then
	Conn.Execute("Delete from goods_property Where ID="&ID&"")
	Response.Redirect "goods_property.asp"
ElseIf Action="Update" Then
	if propertyName="" then
		Response.Write("<script language=JavaScript>alert(""请填写属性名称!"");location.href=""javascript:history.back(-1);"";</script>")
		Response.End()
	end if
	If ID=0 Then
		Response.Write("<script language=JavaScript>alert(""请正常选择!"");location.href=""javascript:history.back(-1);"";</script>")
		Response.End()
	End If
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.open "Select * From goods_property Where propertyName='" & propertyName & "' and ID<>"&ID&"",conn,1,3
	if not (rs.bof and rs.EOF) then
		Response.Write("<script language=JavaScript>alert(""此属性已存在!"");location.href=""javascript:history.back(-1);"";</script>")
		Response.End()
	else
     	Conn.Execute("Update goods_property Set propertyName='"&propertyName&"',cateid="&cateid&",orderid="&orderid&" Where ID="&ID&"")
    	call CloseConn()
		Response.Redirect "goods_property.asp"  
	end if
end if


dim sql,rsClass,rsSmallClass,ErrMsg
set rsClass=server.CreateObject("adodb.recordset")
rsClass.open "Select * From goods_property Order By orderid,id ",conn,1,3
%>
<script language="JavaScript" type="text/JavaScript">
function checkBig()
{
  if (document.form1.propertyName.value=="")
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
  	<td width="40" align="center"><strong>序号</strong></td>
    <td width="378" height="30" align="center"><strong>产品属性名称</strong></td>
    <td width="368" height="30" align="center"><strong>操作选项</strong></td>
  </tr>
<%
do while not rsClass.eof
%>
  <tr bgcolor="#F2F8FF" class="tdbg">
  <td bgcolor="#F2F8FF" class="tr_southidc" align="center"><%=rsClass("orderid")%></td>
    <td width="378" height="22" bgcolor="#F2F8FF" class="tr_southidc"><img src="../Images/tree_folder4.gif" width="19" height="18"><%=rsClass("propertyName")%></td>
    <td align="left" bgcolor="#F2F8FF" class="tr_southidc" style="padding-right:10">&nbsp;
 
    <a href="goods_property.asp?Act=Modi&ID=<%=rsClass("ID")%>">修改</a> | <a href="goods_property.asp?Act=Del&Id=<%=rsClass("ID")%>" onClick="return ConfirmDelBig();">删除</a>
    
    </td>
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
<form name="form1" method="post" action="goods_property.asp?Act=Add" onSubmit="return checkBig()">
   <table width="100%" border="0" align="center" cellspacing="1" class="table_southidc">
       <tr bgcolor="#E3E3E3" class="tdbg">
           <td width="13%" align="right" bgcolor="#E3E3E3" class="tr_southidc" style="font-weight: bold">添加新属性</td>
           <td width="15%" align="right" bgcolor="#E3E3E3" class="tr_southidc"><strong>属性名称：</strong></td>
           <td width="18%" bgcolor="#E3E3E3" class="tr_southidc"><input name="propertyName" type="text" size="20" maxlength="30"></td>
          <td width="8%" align="right" bgcolor="#E3E3E3" class="tr_southidc"><strong>关联类别：</strong></td>
           <td width="8%" bgcolor="#E3E3E3" class="tr_southidc"><input name="cateid" type="text" size="2" maxlength="10"></td>
           
            <td width="8%" align="right" bgcolor="#E3E3E3" class="tr_southidc"><strong>序号：</strong></td>
           <td width="8%" bgcolor="#E3E3E3" class="tr_southidc"><input name="orderid" type="text" size="2" maxlength="10"></td>
           
           <td width="54%" bgcolor="#E3E3E3" class="tr_southidc"><input name="Add" type="submit" value="确认添加"></td>
       </tr>
   </table>
</form>
<%End If%>
<%
If Action="Modi" Then
Set Rs=Conn.Execute("select * from goods_property Where ID="&ID&"")
	if not rs.eof then
		propertyName=rs("propertyName")
		orderId=rs("orderid")
		cateid=rs("cateid")
		ID=rs("id")
	else
		Response.Write("<script language=JavaScript>alert(""此属性不存在或已被删除!"");location.href=""goods_property.asp"";</script>")
		Response.End()
	end if
	rs.close
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">   
   <tr>
     <td height="5"></td>
   </tr>
</table>
<form name="form1" method="post" action="goods_property.asp?Act=Update&ID=<%=ID%>" onSubmit="return checkBig()">
   <table width="100%" border="0" align="center" cellspacing="1" class="table_southidc">
       <tr bgcolor="#E3E3E3" class="tdbg">
           <td width="13%" align="right" bgcolor="#E3E3E3" class="tr_southidc" style="font-weight: bold">属性修改</td>
           <td width="15%" align="right" bgcolor="#E3E3E3" class="tr_southidc"><strong>属性名称：</strong></td>
           <td width="18%" bgcolor="#E3E3E3" class="tr_southidc"><input name="propertyName" value="<%=propertyName%>" type="text" size="20" maxlength="30"></td>
           <td width="8%" align="right" bgcolor="#E3E3E3" class="tr_southidc"><strong>关联类别：</strong></td>
           <td width="8%" bgcolor="#E3E3E3" class="tr_southidc"><input name="cateid" type="text" size="2" maxlength="10" value="<%=cateid%>"></td>
           
            <td width="8%" align="right" bgcolor="#E3E3E3" class="tr_southidc"><strong>属性序号：</strong></td>
           <td width="8%" bgcolor="#E3E3E3" class="tr_southidc"><input name="orderid" type="text" size="2" maxlength="10" value="<%=orderID%>"></td>
           <td width="54%" bgcolor="#E3E3E3" class="tr_southidc"><input name="Add" type="submit" value="确认修改"><a href="goods_property.asp">取消修改并返回</a></td>
       </tr>
   </table>
</form>
<%End If%>
<!-- #include file="../Inc/Foot.asp" -->