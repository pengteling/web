<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%
dim strFileName
const MaxPerPage=20
dim totalPut,CurrentPage,TotalPages
dim rs, sql
strFileName="UserManage.asp"

if request("page")<>"" then
    currentPage=cint(request("page"))
else
	currentPage=1
end if

Set rs=Server.CreateObject("Adodb.RecordSet")
sql="select * from [User] order by UserID desc"
rs.Open sql,conn,1,1
%>
<script language=javascript>
function ConfirmDel()
{
   if(confirm("确定要删除此用户吗？"))
     return true;
   else
     return false;
}
</script>

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="862" align="center" valign="top"><%
  	if rs.eof and rs.bof then
		response.write "目前共有 0 个注册用户"
	else
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
        	showContent
        	showpage strFileName,totalput,MaxPerPage,true,true,"个用户"
   	 	else
   	     	if (currentPage-1)*MaxPerPage<totalPut then
         	   	rs.move  (currentPage-1)*MaxPerPage
         		dim bookmark
           		bookmark=rs.bookmark        		
            	showContent
            	showpage strFileName,totalput,MaxPerPage,true,true,"个用户"
        	else
	        	currentPage=1        
           		showContent
           		showpage strFileName,totalput,MaxPerPage,true,true,"个用户"
	    	end if
		end if
	end if

sub showContent
   	dim i
    i=0
%> 
      <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table_southidc">
        <tr>
          <td height="25" align="center" class="blod">注册会员管理</td>
        </tr>
        <tr> 
          <td height="25"><div align="center">
              <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1">
                <tr bgcolor="#ECF5FF"> 
                  <td height="25" align="center"><strong> 序号</strong></td>
                  <td height="25" align="center"><strong> 用户名</strong></td>
                    <td height="25" align="center"><strong> 会员积分</strong></td>
                  <td height="25" align="center"><strong> 性别</strong></td>
                  <td height="25" align="center"><strong>联系方式</strong></td>
                  <td height="25" align="center"><strong> 状态</strong></td>
                  <td height="25" align="center"><strong> 操作</strong></td>
                </tr>
                <%do while not rs.EOF %>
                <tr class="tdbg"> 
                  <td height="22" align="center" bgcolor="#ECF5FF"><%=rs("UserID")%></td>
                  <td align="center" bgcolor="#ECF5FF"><%=rs("username")%>&nbsp;&nbsp;<%if rs("IsTJ")=1 then response.Write "<font class=red>VIP</font>"%></td>   <td height="22" align="center" bgcolor="#ECF5FF"><%=rs("Points")%></td>
                  <td align="center" bgcolor="#ECF5FF"> 
                    <%if rs("Sex")=1 then
						response.write "男"
					  else
						response.write "女"
					  end if%>
                  </td>
                  <td align="center" bgcolor="#ECF5FF">手机号码：<%=rs("phone")%><br/>E-mail：<%=rs("email")%></td>
                  <td align="center" bgcolor="#ECF5FF"> 
                    <%
	  if rs("LockUser")=true then
	  	response.write "已锁定"
	  else
	  	response.write "正常"
	  end if
	  %>                  </td>
                  <td align="center" bgcolor="#ECF5FF"><a href="UserModify.asp?UserID=<%=rs("UserID")%>">修改</a>&nbsp; 
                    <%if rs("LockUser")=False then %>
                    <a href="UserLock.asp?Action=Lock&UserID=<%=rs("UserID")%>">锁定</a> 
                    <%else%>
                    <a href="UserLock.asp?Action=CancelLock&UserID=<%=rs("UserID")%>">解锁</a> 
                    <%end if%>
                    &nbsp;<a href="UserDel.asp?UserID=<%=rs("UserID")%>" onClick="return ConfirmDel();">删除</a></td>
                </tr>
                <%
	i=i+1
	if i>=MaxPerPage then exit do
	rs.movenext
loop
%>
              </table>
          </div></td>
        </tr>
      </table>
    <%
end sub 
%> </td>
  </tr>
</table>
<!-- #include file="../Inc/Foot.asp" -->
<%
rs.Close
set rs=Nothing
call CloseConn()  
%>