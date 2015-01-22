<!--#include file="../../FiveInc/conn.asp"-->
<% 
function showpage(totalnumber,maxperpage,filename)
dim n
if totalnumber mod maxperpage=0 then
n= totalnumber \ maxperpage
else
n= totalnumber \ maxperpage+1
end if
response.write "<form method=Post action="&filename&">"
response.write "<p align='center'><font color='#000080'>&gt;&gt;分页</font>&nbsp;"
if page<2 then
response.write "<font color='#000080'>首页 上一页</font>&nbsp;"
else
response.write "<a href="&filename&"?page=1&>首页</a>&nbsp;"
response.write "<a href="&filename&"?page="&page-1&">上一页</a>&nbsp;"
end if
if n-page<1 then
response.write "<font color='#000080'>下一页 尾页</font>"
else
response.write "<a href="&filename&"?page="&(page+1)
response.write ">下一页</a> <a href="&filename&"?page="&n&">尾页</a>"
end if
response.write "<font color='#000080'>&nbsp;页次：</font><strong><font color=red>"&page&"</font><font color='#000080'>/"&n&"</strong>页</font> "
response.write "<font color='#000080'>&nbsp;共<b>"&totalnumber&"</b>条记录 <b>"&maxperpage&"</b>条记录/页</font> "
response.write " <font color='#000080'>转到：</font><input type='text' name='page' size=4 value="&page&">"
response.write "<input type=submit name=Submit value=go> </span></p>"

end function


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
</head>

<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr bgcolor="#A4B6D7" class="title"> 
            <td width="35" height="25" align="center" bgcolor="#A4B6D7" class="tr_southidc">选中</td>
            <td width="54"  height="25" align="center" bgcolor="#A4B6D7" class="tr_southidc">ID</td>
            <td width="310" align="center" bgcolor="#A4B6D7" class="tr_southidc" >信息标题</td>
            <td width="102" align="center" bgcolor="#A4B6D7" class="tr_southidc" >一级栏目</td>
            <td width="92" align="center" bgcolor="#A4B6D7" class="tr_southidc" >二级栏目</td>
            <td width="70" align="center" bgcolor="#A4B6D7" class="tr_southidc" >加入时间</td>
            <td width="89" align="center" bgcolor="#A4B6D7" class="tr_southidc" >操作</td>
          </tr>
<%
sql="select * from news order by id desc"
Set rs= Server.CreateObject("ADODB.Recordset")
rs.open sql,conn,1,1

const MaxPerPage=5
dim page
if not request("page")="" then
 Page=cint(request("page"))
else
 Page=1
end if

dim i
i=0
rs.move (Page-1)*MaxPerPage
do while not rs.eof

%>
          <tr class="tdbg"> 
            <td width="35" height="22" align="center" bgcolor="#A4B6D7" class="tr_southidc"> 
              <input name='ID' type='checkbox' onClick="unselectall()" id="ID" value='<%=rs("ID")%>'>            </td>
            <td width="54" align="center" bgcolor="#ECF5FF"><%=rs("id")%></td>
            <td  bgcolor="#ECF5FF">
			<a href="../../ReadNews.asp?rid=<%=rs("id")%>" target="_blank"><%=left(rs("title"),18)%></a>
			<%If rs("Elite")=True Then Response.Write("<font color='red'>荐</font>")%>			</td>
            <td align="center"  bgcolor="#ECF5FF">
<%=rs("BigClassName")%></td>
            <td align="center"  bgcolor="#ECF5FF">
<%=rs("SmallClassName")%></td>
            <td align="center" bgcolor="#ECF5FF"><%= FormatDateTime(rs("PostTime"),2) %> </td>
            <td width="89" align="center" bgcolor="#ECF5FF"> <a href="News_modi.asp?ID=<%=rs("id")%>">修改</a> 
              <a href="News_Del.asp?ID=<%=rs("ID")%>&Action=Del" onClick="return ConfirmDel();">删除</a>            </td>
          </tr>
<%
i=i+1
 if i>=MaxPerPage then exit do
 rs.movenext
loop
%>
          <tr class="tdbg">
            <td height="22" colspan="7" align="center" bgcolor="#A4B6D7" class="tr_southidc"><% = showpage(Rs.recordcount,MaxPerPage, "NewsList.asp") %></td>
          </tr>
</table>
</body>
</html>
