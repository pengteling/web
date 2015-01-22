<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%if Request.QueryString("mark")="southidc" then

dim SQL, Rs, contentID,CurrentPage
CurrentPage = request("Page")
contentID=request("ID")

set rs=server.createobject("adodb.recordset")
sqltext="delete from job where Id="& contentID
rs.open sqltext,conn,3,3
set rs=nothing
conn.close
response.redirect "Manage_Job.asp"
end if
%>
<%
set rs=server.createobject("adodb.recordset")
sqltext="select * from job order by id desc"
rs.open sqltext,conn,1,1

dim MaxPerPage
MaxPerPage=10

dim text,checkpage
text="0123456789"
Rs.PageSize=MaxPerPage
for i=1 to len(request("page"))
checkpage=instr(1,text,mid(request("page"),i,1))
if checkpage=0 then
exit for
end if
next

If checkpage<>0 then
If NOT IsEmpty(request("page")) Then
CurrentPage=Cint(request("page"))
If CurrentPage < 1 Then CurrentPage = 1
If CurrentPage > Rs.PageCount Then CurrentPage = Rs.PageCount
Else
CurrentPage= 1
End If
If not Rs.eof Then Rs.AbsolutePage = CurrentPage end if
Else
CurrentPage=1
End if

call list

'显示帖子的子程序
Sub list()%>

<table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
  <tr>
    <td height="25" colspan="7" align="center"><span style="font-weight: bold">招聘信息管理</span></td>
  </tr>
  <tr bgcolor="#ECF5FF">
    <td width="8%" height="25" align="center" bgcolor="#ECF5FF"> ID</td>
    <td width="11%" align="center" bgcolor="#ECF5FF"> 招聘类型</td>
    <td width="24%" align="center" bgcolor="#ECF5FF"> 职位</td>
    <td width="11%" align="center" bgcolor="#ECF5FF"> 招聘人数</td>
    <td width="11%" align="center" bgcolor="#ECF5FF"> 发布时间</td>
    <td width="11%" align="center" bgcolor="#ECF5FF"> 有效期限</td>
    <td width="10%" align="center" bgcolor="#ECF5FF"> 操作</td>
    <td width="14%" align="center" bgcolor="#ECF5FF"> 操作</td>
  </tr>
<%
i=0
If Rs.Eof Then
   Response.Write "<tr><td colspan=""7""  bgcolor=""#ECF5FF"" align=""center"">&nbsp;您没有发布招聘信息</td></tr>"
End If
do while not rs.eof
If Rs.Eof Then Exit Do
%>
  <tr bgcolor="#ECF5FF">
    <td height="22" align="center" bgcolor="#ECF5FF"><%=rs("id")%></td>
    <td align="center" bgcolor="#ECF5FF"><%if rs("isschool") then response.write "校园" else response.Write "社会" end if%>招聘</td>
    <td align="center" bgcolor="#ECF5FF">&nbsp;&nbsp;<%=rs("Duix")%></td>
    <td align="center" bgcolor="#ECF5FF"><%=rs("Rens")%>人</td>
    <td align="center" bgcolor="#ECF5FF"><%=rs("Time")%></td>
    <td align="center" bgcolor="#ECF5FF"><%=rs("Qix")%>天</td>
    <td align="center" bgcolor="#ECF5FF"><a href="Manage_editJob.asp?id=<%=rs("id")%>">修改</a></td>
    <td align="center" bgcolor="#ECF5FF"><a href="Manage_Job.asp?id=<%=rs("id")%>&amp;mark=southidc">删除</a></td>
  </tr>
<% 
i=i+1 
if i >= MaxPerpage then exit do 
rs.movenext 
loop 

%>
  <tr bgcolor="#A4B6D7">
    <td colspan="7" bgcolor="#A4B6D7">&nbsp;&nbsp;
        <%
Response.write "<strong><font color='#000000'>-> 全部-</font>"
Response.write "共</font>" & "<font color=#FF0000>" & Cstr(Rs.RecordCount) & "</font>" & "<font color='#000000'>条招聘信息</font></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
Response.write "<strong><font color='#000000'>第</font>" & "<font color=#FF0000>" & Cstr(CurrentPage) &  "</font>" & "<font color='#000000'>/" & Cstr(rs.pagecount) & "</font></strong>&nbsp;"
If currentpage > 1 Then
response.write "<strong><a href='Manage_job.asp?&page="+cstr(1)+"'><font color='#000000'>首页</font></a><font color='#ffffff'> </font></strong>"
Response.write "<strong><a href='Manage_job.asp?page="+Cstr(currentpage-1)+"'><font color='#000000'>上一页</font></a><font color='#ffffff'> </font></strong>"
Else
Response.write "<strong><font color='#000000'>上一页 </font></strong>"
End if
If currentpage < Rs.PageCount Then
Response.write "<strong><a href='Manage_job.asp?page="+Cstr(currentPage+1)+"'><font color='#000000'>下一页</font></a><font color='#ffffff'> </font>"
Response.write "<a href='Manage_job.asp?page="+Cstr(Rs.PageCount)+"'><font color='#000000'>尾页</font></a></strong>&nbsp;&nbsp;"
Else
Response.write ""
Response.write "<strong><font color='#000000'>下一页</font></strong>&nbsp;&nbsp;"
End if
%>    </td>
  </tr>
</table>
<%
End sub
rs.close

%>
</div>
<!-- #include file="../Inc/Foot.asp" -->