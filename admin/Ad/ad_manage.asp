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
sql="select * from [ad] order by id desc"
if request("sortid")<>"" then
sql="select * from [ad] where catalogid="&cint( request("sortid"))&" order by id desc"
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
		response.write "目前共有 0 个广告"
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
    <td height="22" colspan="11" align="center"><span style="font-weight: bold">广告管理</span></td>
  </tr>
  <tr bgcolor="#EEEEEE">
    <td width="4%" height="22" align="center" bgcolor="#ECF5FF">id</td>
    <td width="13%" align="center" bgcolor="#ECF5FF">广告名称</td>
    <td width="12%" align="center" bgcolor="#ECF5FF">广告类型</td>
    <td width="21%" align="center" bgcolor="#ECF5FF">图片</td>
    <td width="21%" align="center" bgcolor="#ECF5FF">链接地址</td>
    
  
    <td width="7%" align="center" bgcolor="#ECF5FF">时间</td>
    <td width="5%" align="center" bgcolor="#ECF5FF">修改</td>
    <td width="6%" align="center" bgcolor="#ECF5FF">删除</td>
  </tr>
<%do while not rs.EOF %>
  <tr>
    <td height="20" align="center" bgcolor="#ECF5FF"><%=rs("id")%></td>
    <td align="center" bgcolor="#ECF5FF"><%=rs("title")%></td>
    <td align="center" bgcolor="#ECF5FF">
    <%
		if(rs("adType")=0) then
			response.Write("文字")
		elseif(rs("adType")=1) then
			response.Write("图片")
		elseif(rs("adType")=2) then
			response.Write("Flash")
		end if
	%></td>
    <td align="center" bgcolor="#ECF5FF">
    <%
		if(rs("adType")<>0) then
			response.Write("<input type=""text"" size=""30"" value="""&rs("photo")&""">")
		else
			response.Write("文字广告，没有图片！")
		end if
	%>    </td>
    <td align="center" bgcolor="#ECF5FF">
    <%
		if(rs("adType")<>1) then
			response.Write("非图片广告，没有链接")
		else
			response.Write("<input type=""text"" size=""30"" value="""&rs("linkUrl")&""">")
		end if
	%>    </td>
 
   
    <td align="center" bgcolor="#ECF5FF"><%=rs("moditime")%></td>
    <td align="center" bgcolor="#ECF5FF"><a href="ad_mod.asp?id=<%=rs("id")%>&catalogid=<%=rs("catalogId")%>">修改</a></td>
    <td align="center" bgcolor="#ECF5FF"><a href="dele.asp?id=<%=rs("id")%>&table=ad" onClick="return ConfirmDel()">删除</a></td>
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
<%=CStr(FormatNumber((Timer-BeginTime)*1000,2))& "毫秒"%>