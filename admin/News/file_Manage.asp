<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%
dim strFileName
const MaxPerPage=10
dim totalPut,CurrentPage,TotalPages
dim rs, sql
strFileName="file_manage.asp"

if request("page")<>"" then
    currentPage=cint(request("page"))
else
	currentPage=1
end if

Set rs=Server.CreateObject("Adodb.RecordSet")
sql="select * from uploadfiles  where newsid=0 order by id desc"
if request("sortid")<>"" then
'sql="select * from uploadfiles where catalogid="&cint( request("sortid"))&" order by id desc"
end if
rs.Open sql,conn,1,1
%>
<SCRIPT language=javascript>
function unselectall()
{
    if(document.del.chkAll.checked){
	document.del.chkAll.checked = document.del.chkAll.checked&0;
    } 	
}

function CheckAll(form)
  {
  for (var i=0;i<form.elements.length;i++)
    {
    var e = form.elements[i];
	
    if (e.name != "chkAll" &&  e.name!="Action")
	//alert(e.name);
       e.checked = form.chkAll.checked;
    }
  }
function ConfirmDel()
{
   if(confirm("确定要执行操作吗？"))
     return true;
   else
     return false;
	 
}

</SCRIPT>
<%
  	if rs.eof and rs.bof then
		response.write "目前共有 0 个无关联附件"
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
        	showpage strFileName,totalput,MaxPerPage,true,true,"个无关联附件"
   	 	else
   	     	if (currentPage-1)*MaxPerPage<totalPut then
         	   	rs.move  (currentPage-1)*MaxPerPage
         		dim bookmark
           		bookmark=rs.bookmark        		
            	showContent
            	showpage strFileName,totalput,MaxPerPage,true,true,"个无关联附件"
        	else
	        	currentPage=1        
           		showContent
           		showpage strFileName,totalput,MaxPerPage,true,true,"个无关联附件"
	    	end if
		end if
	end if

sub showContent
   	dim i
    i=0
%>
<form name="del" method="Post" action="file_exec.asp" onSubmit="return ConfirmDel();">
<table width="100%"  border="0" align="center" cellpadding="0" cellspacing="1" class="table_southidc">
  <tr>
    <td height="22" colspan="7" align="center"><span style="font-weight: bold">无关联附件管理</span></td>
  </tr>
  <tr bgcolor="#EEEEEE">
   <td width="2%" height="25" align="center" bgcolor="#ECF5FF" class="tr_southidc">选中</td>
    <td width="4%" height="22" align="center" bgcolor="#ECF5FF">id</td>
    <td width="12%" align="center" bgcolor="#ECF5FF">无关联附件路径</td>
    <td width="4%" align="center" bgcolor="#ECF5FF">无关联附件类型</td>
    <td width="10%" align="center" bgcolor="#ECF5FF">缩略图片</td>    
  <td width="4%" align="center" bgcolor="#ECF5FF">上传时间</td>      
    <td width="4%" align="center" bgcolor="#ECF5FF">删除</td>
  </tr>
<%do while not rs.EOF %>
  <tr>
  
  <td align="center" bgcolor="#ECF5FF" class="tr_southidc"> 
              <input name='ID' type='checkbox' onClick="unselectall()" id="ID" value='<%=cstr(rs("ID"))%>'>            </td>
              
    <td height="20" align="center" bgcolor="#ECF5FF"><%=rs("id")%></td>
   
    <td align="center" bgcolor="#ECF5FF"><%=rs("path")%></td>
    <td align="center" bgcolor="#ECF5FF">
    <%=rs("filetype")%> </td>
    <td align="center" bgcolor="#ECF5FF"><%
	filetype=lcase(rs("filetype"))
		if(filetype="jpg" or filetype="png" or filetype="gif" or filetype="bmp") then
			response.Write "<img src="""&rs("path")&""" width=""200"" height=""120"">"
		else
			response.Write("非图片文件")
		end if
	%></td>
 
   
    <td align="center" bgcolor="#ECF5FF"><%=rs("addtime")%></td>
 
    <td align="center" bgcolor="#ECF5FF"><a href="file_exec.asp?id=<%=rs("id")%>&Action=Del" onClick="return ConfirmDel()">删除</a></td>
  </tr>
<%
	i=i+1
	if i>=MaxPerPage then exit do
	rs.movenext
loop
%>
</table>
 <table width="100%" border="0" cellpadding="0" cellspacing="1">
          <tr> 
            <td width="65" height="30"><input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox">
            全选</td>
            <td >
            <input type="hidden" name="Action" value="Del"  >
             <input type="submit" name="imageField" value="批量删除">
            </td>
            </tr>
           </table>
           </form>
<table>
  <tr>
    <td height="22" colspan="7" align="center" bgcolor="#ECF5FF"><form name="form1" method="post" action="" style="margin:0 0 0 0">
          <%
end sub 
%>
    </form></td>
  </tr>
  <!--按行循环结束------------------------>
</table>
<!-- #include file="../Inc/Foot.asp" -->
