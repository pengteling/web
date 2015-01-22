<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%
dim strFileName
const MaxPerPage=10
dim totalPut,CurrentPage,TotalPages
dim rs, sql
strFileName="ad_manage.asp"

if request("page")<>"" then
    currentPage=cint(request("page"))
else
	currentPage=1
end if

Set rs=Server.CreateObject("Adodb.RecordSet")
sql="select * from photos order by id desc"
if request("sortid")<>"" then
sql="select * from photos where rid="&cint( request("sortid"))&" order by id desc"
end if
rs.Open sql,conn,1,1
%>
<script language="JavaScript" type="text/JavaScript">
function ConfirmDel()
{
   if(confirm("确认删除？，并且不能恢复！确定要删除此信息吗？"))
     return true;
   else
     return false;	 
}
</script>
<%
  	if rs.eof and rs.bof then
		response.write "目前共有 0 条信息"
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
        	showpage strFileName,totalput,MaxPerPage,true,true,"个广告"
   	 	else
   	     	if (currentPage-1)*MaxPerPage<totalPut then
         	   	rs.move  (currentPage-1)*MaxPerPage
         		dim bookmark
           		bookmark=rs.bookmark        		
            	showContent
            	showpage strFileName,totalput,MaxPerPage,true,true,"个广告"
        	else
	        	currentPage=1        
           		showContent
           		showpage strFileName,totalput,MaxPerPage,true,true,"个广告"
	    	end if
		end if
	end if

sub showContent
   	dim i
    i=0
%>
<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="1" class="table_southidc">
  <tr>
    <td height="22" colspan="11" align="center"><span style="font-weight: bold">楼盘图片视频库管理</span></td>
  </tr>
  <tr bgcolor="#EEEEEE">
    <td width="4%" height="22" align="center" bgcolor="#ECF5FF">id</td>
    <td width="13%" align="center" bgcolor="#ECF5FF">名称</td>
    <td width="12%" align="center" bgcolor="#ECF5FF">类型</td>
    <td width="12%" align="center" bgcolor="#ECF5FF">文件类型</td>
    <td width="11%" align="center" bgcolor="#ECF5FF">图片</td>
    <td width="11%" align="center" bgcolor="#ECF5FF">视频地址</td>
    <td width="5%" align="center" bgcolor="#ECF5FF">修改</td>
  <td width="5%" align="center" bgcolor="#ECF5FF">删除</td>
  </tr>
<%do while not rs.EOF %>
  <tr>
    <td height="20" align="center" bgcolor="#ECF5FF"><%=rs("id")%></td>
    <td align="center" bgcolor="#ECF5FF"><%=rs("title")%></td>
    <td align="center" bgcolor="#ECF5FF">
    <%
	if(rs("modelType")=0) then
			response.Write("楼盘视界")
	elseif(rs("modelType")=1) then
			response.Write("户型图")		
	end if
	%></td>
    <td align="center" bgcolor="#ECF5FF">
    <%
		if(rs("Type")=0) then
			response.Write("图片")
		elseif(rs("Type")=1) then
			response.Write("视频")
		
		end if
	%></td>    
    <td align="center" bgcolor="#ECF5FF">
    <img src="<%=rs("imgurl")%>" width="150" height="150">
        </td>
    <td align="center" bgcolor="#ECF5FF">
    <%=rs("videourl")%>   </td>
    
    <td align="center" bgcolor="#ECF5FF"><a href="ad_mod.asp?id=<%=rs("id")%>&catalogid=<%=rs("rid")%>">修改</a></td>
    <td align="center" bgcolor="#ECF5FF"><a href="dele.asp?id=<%=rs("id")%>&table=photos" onClick="return ConfirmDel()">删除</a></td>
  </tr>
<%
	i=i+1
	if i>=MaxPerPage then exit do
	rs.movenext
loop
%>
  <tr>
    <td height="22" colspan="11" align="center" bgcolor="#ECF5FF"><form name="form1" method="post" action="" style="margin:0 0 0 0">
          <%
end sub 
%>
    </form></td>
  </tr>
  <!--按行循环结束------------------------>
</table>
<!-- #include file="../Inc/Foot.asp" -->
<%'CStr(FormatNumber((Timer-BeginTime)*1000,2))& "毫秒"%>