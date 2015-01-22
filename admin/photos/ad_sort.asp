<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%

dim sql,rsClass,rsSmallClass,ErrMsg
set rsClass=server.CreateObject("adodb.recordset")
rsClass.open "Select * From product_c Order By id",conn,1,3
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
    <td align="left" bgcolor="#F2F8FF" class="tr_southidc" style="padding-right:10">&nbsp;<a href="ad_add.asp?mid=0&t=0&ID=<%=rsClass("ID")%>">添加楼盘视界图</a> | <a href="ad_add.asp?mid=1&t=0&Id=<%=rsClass("ID")%>" ">添加户型图</a> | <a href="ad_add.asp?mid=0&t=1&Id=<%=rsClass("ID")%>" >上传视频</a> | <a href="ad_manage.asp?sortid=<%=rsClass("ID")%>">维护信息</a></td>
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

<!-- #include file="../Inc/Foot.asp" -->