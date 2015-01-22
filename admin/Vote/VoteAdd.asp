<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../Admin.asp"-->
<%
dim Title,VoteTime,Action,IsSelected
dim rs,sql
Title=trim(request.form("Title"))
VoteTime=trim(request.form("VoteTime"))
if VoteTime="" then VoteTime=now()
Action=trim(request("Action"))
IsSelected=trim(request("IsSelected"))

dim i
if Title<>"" then
	sql="select top 1 * from Vote"
	Set rs= Server.CreateObject("ADODB.Recordset")
	rs.open sql,conn,1,3
	rs.addnew
	rs("Title")=Title
	for i=1 to 8
		if trim(request("select"&i))<>"" then
			rs("select"&i)=trim(request("select"&i))
			if request("answer"&i)="" then
				rs("answer"&i)=0
			else
				rs("answer"&i)=clng(request("answer"&i))
			end if
		end if
	next
	rs("VoteTime")=VoteTime
	rs("VoteType")=request("VoteType")
	if IsSelected="" then IsSelected=false
	if IsSelected="True" then conn.execute "Update Vote set IsSelected=False where IsSelected=True"
	rs("IsSelected")=IsSelected
	rs.update
	rs.close
	set rs=nothing
	call CloseConn()
	Response.Redirect "VoteManage.asp"
end if
%>
<!-- #include file="../Inc/Head.asp" -->
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  
  <tr>
    <td height="125" align="center" valign="top" class="table_southidc"><form method="POST" action="VoteAdd.asp" style="margin:0">
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" Class="border">
        <tr class="tdbg">
          <td height="40" colspan="4" align="center" bgcolor="#A4B6D7"><strong>添 加 调 查</strong></td>
          </tr>
        <tr class="tdbg">
          <td width="151" height="22" align="right" bgcolor="#A4B6D7" class="tr_southidc">主题：</td>
          <td colspan="3" bgcolor="#E3E3E3" class="tr_southidc"><input name="Title" type="text" size="45" maxlength="50"></td>
        </tr>
        <%
	for i=1 to 8%>
        <tr class="tdbg">
          <td height="22" align="right" bgcolor="#A4B6D7" class="tr_southidc">选项<%=i%>：</td>
          <td width="406" bgcolor="#E3E3E3" class="tr_southidc"><input type="text" name="select<%=i%>" size="36">          </td>
          <td width="49" align="right" bgcolor="#E3E3E3" class="tr_southidc">票数：</td>
          <td width="304" bgcolor="#E3E3E3" class="tr_southidc"><input type="text" name="answer<%=i%>" size="5"></td>
        </tr>
        <%next%>
        <tr class="tdbg">
          <td height="22" align="right" bgcolor="#A4B6D7" class="tr_southidc">调查类型：</td>
          <td colspan="3" bgcolor="#E3E3E3" class="tr_southidc"><select name="VoteType" id="VoteType">
              <option value="Single" selected>单选</option>
              <option value="Multi">多选</option>
          </select></td>
        </tr>
        <tr class="tdbg">
          <td height="22" align="right" bgcolor="#A4B6D7" class="tr_southidc">&nbsp;</td>
          <td colspan="3" bgcolor="#E3E3E3" class="tr_southidc"><input name="IsSelected" type="checkbox" id="IsSelected" value="True" checked>
            设为最新调查</td>
        </tr>
        <tr class="tdbg">
          <td height="25" colspan=4 align=center valign="bottom"><input name="Submit" type="submit" id="Submit" value=" 添 加 ">
            &nbsp;
            <input  name="Reset2" type="reset" id="Reset2" value=" 清 除 ">          </td>
        </tr>
      </table>
    </form></td>
  </tr>
</table>
<!-- #include file="../Inc/Foot.asp" -->