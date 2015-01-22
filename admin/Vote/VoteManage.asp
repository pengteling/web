<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../Admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%
dim sql,rs,Action,ID
Action=Trim(Request("Action"))
ID=Trim(Request("VoteID"))
if Action="Set" and ID<>"" then
	conn.execute "Update Vote set IsSelected=False where IsSelected=True"
	conn.execute "Update Vote set IsSelected=True Where ID=" & ID
	response.Write "<script language='JavaScript' type='text/JavaScript'>alert('设置成功！');</script>"
end if
sql="select * from Vote order by id desc"
set rs=server.createobject("adodb.recordset")
rs.open sql,conn,1,1
%>

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td align="center" valign="top"><strong>
      <form method="POST" action="VoteManage.asp">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" Class="table_southidc">
          <tr bgcolor="#A4B6D7" class="title"> 
            <td width="37" height="25" align="center">选择</td>
            <td width="37" align="center">ID</td>
            <td width="328" align="center" bgcolor="#A4B6D7">主题</td>
            <td width="88" align="center">操作</td>
          </tr>
          <%
if not (rs.bof and rs.eof) then
	do while not rs.eof
%>
          <tr bgcolor="#ECF5FF" class="tdbg"> 
            <td width="37" height="22" align="center"> 
              <input type="radio" value=<%=rs("ID")%><%if rs("IsSelected")=true then%> checked<%end if%> name="VoteID"></td>
            <td width="37" height="22" align="center"><%=rs("ID")%></td>
            <td height="22">&nbsp;<%=rs("Title")%></td>
            <td width="88" height="22" align="center"><a href="VoteModify.asp?ID=<%=rs("ID")%>">修改</a> 
              <a href="VoteDel.asp?ID=<%=rs("ID")%>">删除</a></td>
          </tr>
          <%
rs.movenext
loop
%>
          <tr class="tr_southidc"> 
            <td height="30" colspan=4 align=center><input name="Action" type="hidden" id="Action" value="Set"> 
            <input type="submit" value="将选定的调查设为最新调查" name="submit"> </td>
          </tr>
          <% end if%>
        </table>
      </form>
    </strong></p> </td>
  </tr>
</table>
<!-- #include file="../Inc/Foot.asp" -->
<%
rs.close
set rs=nothing
conn.close
set conn=nothing
%>