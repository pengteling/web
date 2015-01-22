<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
 <tr>
    <td height="25" colspan="7" align="center"><span style="font-weight: bold">应聘信息管理</span></td>
  </tr>
 <tr>
             <td height="25" bgcolor="#ECF5FF">姓名</td>
             <td height="25" bgcolor="#ECF5FF">性别</td>
             <td height="25" bgcolor="#ECF5FF">应聘职位</td>
             <td height="25" bgcolor="#ECF5FF">最高学历</td>
             <td height="25" bgcolor="#ECF5FF">手机</td>
             <td height="25" bgcolor="#ECF5FF">操作</td>
             </tr>
<% 
const MaxPerPage=5 '分页显示的纪录个数 
dim sql 
dim rs 
dim totalPut 
dim CurrentPage 
dim TotalPages 
dim i,j 
 
id = strToNum(request("id")) 
if id> 0 then
   conn.execute("delete from zp where id=" & id)
end if
 
if not isempty(request("page")) then 
currentPage=cint(request("page")) 
else 
currentPage=1 
end if 
set rs=server.createobject("adodb.recordset") 
sql="select * from zp order by id desc" 
rs.open sql,conn,1,1 
 
if rs.eof and rs.bof then 
response.write "<p align='center'>没有会员应聘信息!</p>" 
else 
totalPut=rs.recordcount 
totalPut=rs.recordcount 
if currentpage<1 then 
currentpage=1 
end if 
if (currentpage-1)*MaxPerPage>totalput then 
if (totalPut mod MaxPerPage)=0 then 
currentpage= totalPut \ MaxPerPage 
else 
currentpage= totalPut \ MaxPerPage + 1 
end if 
end if 
if currentPage=1 then 
showpages 
showContent 
showpages 
else 
if (currentPage-1)*MaxPerPage<totalPut then 
rs.move (currentPage-1)*MaxPerPage 
dim bookmark 
bookmark=rs.bookmark 
showpages 
showContent 
showpages 
else 
currentPage=1 
showContent 
end if 
end if 
rs.close 
end if 
set rs=nothing 
conn.close 
set conn=nothing 
sub showContent 
dim i 
i=0 
do while not (rs.eof or err) %>
         
             <tr>
             <td height="25" bgcolor="#ECF5FF"><%=rs("field11")%></td>
             <td height="25" bgcolor="#ECF5FF"><%=rs("field13")%></td>
             <td height="25" bgcolor="#ECF5FF"><%=rs("field2")%></td>
             <td height="25" bgcolor="#ECF5FF"><%=rs("field12")%></td>
             <td height="25" bgcolor="#ECF5FF"><%=rs("field6")%></td>
             <td bgcolor="#ECF5FF"><a href="job_view.asp?id=<%=rs("ID")%>">查看简历</a><a href="Manage_jobBook.asp?id=<%=rs("ID")%>" onClick="return confirm('确实要删除吗')"><font color="#FF0000">删除应聘信息</font></a></td>
             </tr>
<!-- /td>
        </tr>
      </table>
     <table width="96%" border="0" align="center" cellpadding="0" cellspacing="0" class="table_southidc">
        <tr> 
          <td width="388" -->
              <% i=i+1 
if i>=MaxPerPage then exit do 
rs.movenext 
loop 
end sub 
sub showpages() 
dim n 
if (totalPut mod MaxPerPage)=0 then 
n= totalPut \ MaxPerPage 
else 
n= totalPut \ MaxPerPage + 1 
end if 
if n=1 then  
exit sub 
end if 
dim k 
response.write "<p align='left'>&gt;&gt; 招聘分页 " 
for k=1 to n 
if k=currentPage then 
response.write "[<b>"+Cstr(k)+"</b>] " 
else 
response.write "[<b>"+"<a href='Manage_zp.asp?page="+cstr(k)+"'>"+Cstr(k)+"</a></b>] " 
end if 
next 
end sub 
%>
    
</table>
<!-- #include file="../Inc/Foot.asp" -->