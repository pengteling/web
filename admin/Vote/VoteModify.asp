<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../Admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%
dim ID,Title,VoteTime,IsSelected
dim rs,sql
ID=int(request("id"))   ' 也可用ID=request("id")
Title=trim(request.form("Title"))
VoteTime=trim(request.form("VoteTime"))
VoteType=trim(request("VoteType"))
if VoteTime="" then VoteTime=now()
IsSelected=trim(request("IsSelected"))
if IsSelected="True" then
	conn.execute "Update Vote set IsSelected=False where IsSelected=True"
end if
dim i
if ID="" then
	Response.Redirect "VoteManage.asp"
end if
sql="select * from Vote where ID="&Cint(ID)
Set rs= Server.CreateObject("ADODB.Recordset")
rs.open sql,conn,1,3
if not rs.eof then
	if Title<>"" then
		rs("Title")=Title
		for i=1 to 8
			if trim(request("select"&i))<>"" then
				rs("select"&i)=trim(request("select"&i))
				if request("answer"&i)="" then
					rs("answer"&i)=0
				else
					rs("answer"&i)=clng(request("answer"&i))
				end if
			else
				rs("select"&i)=""
				rs("answer"&i)=0
			end if
		next
		rs("VoteTime")=VoteTime
		rs("VoteType")=VoteType
		if IsSelected="" then IsSelected=false
		rs("IsSelected")=IsSelected
		rs.update
		rs.close
		set rs=nothing
		call CloseConn()
		Response.Redirect "VoteManage.asp"
	end if
%>

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="862" align="center" valign="top"><form method="POST" action="VoteModify.asp">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#ECF5FF" Class="table_southidc">
          <tr class="tdbg">
            <td height="30" colspan="4" align="center" bgcolor="#A4B6D7" class="table_southidc"><strong><b>修 改</b> 调 查</strong></td>
          </tr>
          <tr class="tdbg"> 
            <td width="15%" align="right" bgcolor="#A4B6D7" class="tr_southidc">主题：</td>
            <td width="85%" colspan="3" class="tr_southidc"><input name="Title" type="text" value="<%=rs("Title")%>" size="52"></td>
          </tr>
          <%
for i=1 to 8%>
          <tr class="tdbg"> 
            <td align="right" bgcolor="#A4B6D7" class="tr_southidc">选项<%=i%>：</td>
            <td class="tr_southidc"><input name="select<%=i%>" type="text" value="<%=rs("select"& i)%>" size="36">            </td>
            <td align="right" class="tr_southidc">票数：</td>
            <td width="80" class="tr_southidc"><input name="answer<%=i%>" type="text" value="<%=rs("answer"&i)%>" size="5"></td>
          </tr>
          <%next%>
          <tr class="tdbg"> 
            <td align="right" bgcolor="#A4B6D7" class="tr_southidc">调查类型：</td>
            <td colspan="3" class="tr_southidc"><select name="VoteType" id="VoteType">
                <option value="Single" <% if rs("VoteType")="Single" then %>selected<% end if%>>单选</option>
                <option value="Multi" <% if rs("VoteType")="Multi" then %>selected<% end if%>>多选</option>
            </select></td>
          </tr>
          <tr class="tdbg"> 
            <td align="right" bgcolor="#A4B6D7" class="tr_southidc">&nbsp;</td>
            <td colspan="3" class="tr_southidc"><input name="IsSelected" type="checkbox" id="IsSelected" value="True" <% if rs("IsSelected")=true then response.write "checked"%>>
            设为最新调查</td>
          </tr>
          <tr bgcolor="#A4B6D7" class="tdbg"> 
            <td colspan=4 align=center class="tr_southidc"> 
              <input name="ID" type="hidden" id="ID" value="<%=rs("ID")%>"> 
            <input name="Submit" type="submit" id="Submit" value="保存修改结果"> </td>
          </tr>
        </table>
      </form></strong></p>
    </td>
  </tr>
</table>
<!-- #include file="../Inc/Foot.asp" -->
<%
end if
rs.close
set rs=nothing
conn.close
set conn=nothing
%>