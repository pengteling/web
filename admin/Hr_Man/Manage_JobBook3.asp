<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
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
   conn.execute("delete from jobbook where id=" & id)
end if
 
if not isempty(request("page")) then 
currentPage=cint(request("page")) 
else 
currentPage=1 
end if 
set rs=server.createobject("adodb.recordset") 
sql="select * from jobbook order by id desc" 
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
              <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
                <tr> 
                  <td width="17%" height="25" class="blod"> 
                   应聘岗位</td>
                  <td colspan="2">&nbsp;&nbsp;<b><%=rs("jobname")%></b> &nbsp; </td>
                  <td><a href="Manage_jobBook3.asp?id=<%=rs("ID")%>" onClick="return confirm('确实要删除吗')"><font color="#FF0000">删除应聘信息</font></a>&nbsp;&nbsp;&nbsp;                  </td>
                </tr>
                <%if rs("email")<>"" then%>
                <tr> 
                  <td height="10" bgcolor="#ECF5FF"> 
                   姓 名</td>
                  <td width="34%" bgcolor="#ECF5FF">&nbsp;&nbsp;<%=rs("mane")%></td>
                  <td width="13%" bgcolor="#ECF5FF"> 
                   性 别</td>
                  <td width="36%" bgcolor="#ECF5FF"><%=rs("sex")%></td>
                </tr>
                <tr> 
                  <td height="22" bgcolor="#ECF5FF"> 
                    出生日期</div></td>
                  <td bgcolor="#ECF5FF">&nbsp;&nbsp;<%=rs("birthday")%></td>
                  <td bgcolor="#ECF5FF"> 
                   婚姻状况</td>
                  <td bgcolor="#ECF5FF"><%=rs("marry")%></td>
                </tr>
                <tr> 
                  <td height="22" bgcolor="#ECF5FF"> 
                   毕业院校</td>
                  <td colspan="3" bgcolor="#ECF5FF">&nbsp;&nbsp;<%=rs("school")%></td>
                </tr>
                <tr> 
                  <td height="22" bgcolor="#ECF5FF"> 
                    学 历</td>
                  <td bgcolor="#ECF5FF">&nbsp;&nbsp;<%=rs("studydegree")%></td>
                  <td bgcolor="#ECF5FF">
专 业</td>
                  <td bgcolor="#ECF5FF"><%=rs("specialty")%></td>
                </tr>
                <tr> 
                  <td height="22" bgcolor="#ECF5FF"> 
                   毕业时间</td>
                  <td bgcolor="#ECF5FF">&nbsp;&nbsp;<%=rs("gradyear")%></td>
                  <td bgcolor="#ECF5FF"> 
                  <font color="#FF0000">应聘日期</font></td>
                  <td bgcolor="#ECF5FF"><font color="#FF0000"><%=rs("time")%></font></td>
                </tr>
                <tr> 
                  <td height="22" bgcolor="#ECF5FF"> 
                    电 话</td>
                  <td colspan="3" bgcolor="#ECF5FF">&nbsp;&nbsp;<%=rs("telephone")%></td>
                </tr>
                <tr> 
                  <td height="22" bgcolor="#ECF5FF"> 
                   E-mail</td>
                  <td colspan="3" bgcolor="#ECF5FF">&nbsp;&nbsp;<a href="Sendmail.asp?email=<%=rs("email")%>"><%=rs("email")%></a></td>
                </tr>
                <tr> 
                  <td height="22" bgcolor="#ECF5FF"> 
                    联系地址</td>
                  <td colspan="3" bgcolor="#ECF5FF">&nbsp;&nbsp;<%=rs("address")%></td>
                </tr>
                <%end if%>
               <!-- <tr> 
                  <td height="25" bgcolor="#ECF5FF">
水平与能力</td>
                  <td height="25" colspan="3" bgcolor="#ECF5FF">&nbsp;&nbsp;<%=rs("ability")%></td>
                </tr>-->
                <tr> 
                  <td height="25" bgcolor="#ECF5FF"> 
                   个人简历</td>
                  <td height="25" colspan="3" bgcolor="#ECF5FF">&nbsp;&nbsp;<a href="<%=rs("upfilepath")%>" target="_blank">点击查看上传简历</a></td>
                </tr>
</table>
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
response.write "[<b>"+"<a href='Manage_JobBook3.asp?page="+cstr(k)+"'>"+Cstr(k)+"</a></b>] " 
end if 
next 
end sub 
%>
          <!-- /td>
        </tr>
</table -->
<!-- #include file="../Inc/Foot.asp" -->