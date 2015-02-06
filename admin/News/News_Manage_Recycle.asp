<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<%
dim strFileName
const MaxPerPage=18
dim totalPut,CurrentPage,TotalPages
dim i,j
dim ArticleID
dim Title
dim sql,rs
dim BigClassName
dim PurviewChecked
dim strAdmin,arrAdmin
PurviewChecked=false
Response.Cookies("xd_urljilunew")=""

cateid=strToNum(request("cateid"))
keywords=ChkFormStr(Request("keywords"))
strFileName="News_Manage_recycle.asp?cateid=" & cateid	

if keywords<>"" then
strFileName=strFileName&"&keywords="&server.URLEncode(keywords)
end if
Set rs= Server.CreateObject("ADODB.Recordset")


			rs.open "select cateid,catename,followid,depth,sonid,parentid,orderID from category where catetype<=1 order by depth,orderID",conn,1,1
			if not rs.eof then
				data= rs.getRows()
			end if
			rs.close
			
	class_list=""
	sub classlist(byval t0)
		dim i
		for i=0 to ubound(data,2)
			if t0=data(2,i) then
				if followid = data(0,i) then
					isslected="selected"
				else
					isslected=""
				end if
				class_list=class_list&"<option value="""&data(0,i)&""" "&isslected&">"

For k=2 To data(3,i)
class_list=class_list&"&nbsp;&nbsp;&nbsp;&nbsp;"
next

If data(3,i)>1 then class_list=class_list& "├"
				class_list=class_list& data(1,i)&"</option>"
				
				classlist(data(0,i))
			end if
		next
end sub

if cateid<>0 then
	
	
	rs.open "select Followid,sonid,parentid from category where cateid="&cateid&"",conn,1,1
	if not rs.eof then
		followid=rs("followid")
		sonid=rs("sonid")
		parentid= rs("parentid")
	end if
	rs.close
end if

if cateid<>0 then
	
	
	sqlBigclass= "select cateid,catename from category where cateid in ("&parentid&") order by depth"
	sqlSmallclass="select cateid,catename from category where followid="&cateid&" and catetype<=1  order by orderID"
else
	
	sqlBigclass= "select  cateid,catename from category where 1=2 order by orderID"
	sqlSmallclass="select  cateid,catename from category where followid=0 and catetype<=1 order by orderID"
end if


if request("page")<>"" then
    currentPage=cint(request("page"))
else
	currentPage=1
end if


sql="select news.*,c.catename from news left join category c on news.cateid=c.cateid where isdel=1"
if cateid<>0 then
	sql=sql & " and news.cateid in (" & sonid & ")"	
end if
if keywords<>"" then
	sql=sql &" and (title like '%"&keywords&"%' or news.content like '%"&keywords&"%')"
end if
sql=sql & " order by px desc,posttime desc,id desc"


'response.write sql

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
    if (e.Name != "chkAll")
       e.checked = form.chkAll.checked;
    }
  }
function ConfirmDel()
{
   if(confirm("确定要执行操作吗？如果选择了真正删除，一旦点击确定将不能恢复！"))
     return true;
   else
     return false;
	 
}

</SCRIPT>
<!-- #include file="../Inc/Head.asp" -->
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="862" align="center" valign="top">
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="table_southidc">
        <tr> 
          <td height="25">&nbsp;当前栏目路径： <a href=News_Manage_recycle.asp>根栏目</a>  
          <%
		  rs.open sql,conn,1,1
Set rsBigClass= Server.CreateObject("ADODB.Recordset")
rsBigClass.open sqlBigclass,conn,1,1
if rsBigClass.eof then 
	'response.Write("还没有任何栏目，请首先添加栏目。")
end if
do while not rsBigClass.eof
	if rsBigClass("cateid")=cateid then
		response.Write(" > <a href='News_Manage_recycle.asp?cateid=" & rsBigClass("cateid") & "'><font color='red'>" & rsBigClass("catename") & "</font></a>  ")		
	else
		response.Write(" > <a href='News_Manage_recycle.asp?cateid=" & rsBigClass("cateid") & "'>" & rsBigClass("catename") & "</a>")
	end if
	rsBigClass.movenext
loop
rsBigClass.close
set rsBigClass=nothing
%></td>

        </tr>
        <%
if cateid<>"" then
	
	Set rsSmallClass= Server.CreateObject("ADODB.Recordset")
	rsSmallClass.open sqlSmallclass,conn,1,1
	if not (rsSmallClass.bof and rsSmallClass.eof) then
		response.write "<tr class='tdbg'><td bgcolor='#ECF5FF' height='20'>子栏目："
		do while not rsSmallClass.eof
			if rsSmallClass("cateid")=cateid then
				response.Write("&nbsp;<a href='News_Manage_recycle.asp?cateid=" & rsSmallClass("cateid") & "'><font color='red'>" & rsSmallClass("catename") & "</font></a>&nbsp;&nbsp;")
				
			else
				response.Write("&nbsp;<a href='News_Manage_recycle.asp?cateid=" & rsSmallClass("cateid") & " '>" & rsSmallClass("catename") & "</a>&nbsp;&nbsp;")
			end if
			rsSmallClass.movenext
		loop
		response.write "</td></tr>"
	end if
	rsSmallClass.close
	set rsSmallClass=nothing
end if
%>
      </table>
      
        <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table_southidc">
        <tr bgcolor="#ffffff" height="40">
        <td colspan="2" alingn="left" style="padding-left:10px;">
        <form action="News_Manage_recycle.asp" method="get">请输入文章标题或内容关键词进行查询：
        <input name="keywords" value=""><input name="cateid" value="<%=cateid%>" type="hidden"><input type="submit" value="搜索">
        </form>
        </td>
        </tr>
<form name="del" method="Post" action="News_del.asp" onSubmit="return ConfirmDel();">
          <tr> 
            <td height="25"><a href="News_Manage_recycle.asp">&nbsp;回收站管理</a> &gt;&gt; 
              <%
if request.querystring="" then
	response.write "所有信息"
else
	if request("keywords")<>"" then
		
			response.write "名称中含有“<font color=blue>" & keywords & "</font>”的产品"
		else
			response.Write("所有信息")
	
 	
			
	end if
end if
%> </td>
            <td width="150">&nbsp; 
              <%
  	if rs.eof and rs.bof then
		response.write "共找到 0 条信息<br> <a href=""News_add.asp?cateid=" & cateid & """><img src=""../images/addnew.jpg"" width=""78"" height=""22"" border=""0""></a></td></tr></table>"
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
		response.Write "共找到 " & totalPut & " 条信息"
%> </td>
          </tr>
        </table>
        <%		
	    if currentPage=1 then
        	showContent
        	showpage strFileName,totalput,MaxPerPage,true,false,"条信息"
   	 	else
   	     	if (currentPage-1)*MaxPerPage<totalPut then
         	   	rs.move  (currentPage-1)*MaxPerPage
         		dim bookmark
           		bookmark=rs.bookmark
            	showContent
            	showpage strFileName,totalput,MaxPerPage,true,false,"条信息"
        	else
	        	currentPage=1
           		showContent
           		showpage strFileName,totalput,MaxPerPage,true,false,"条信息"
	    	end if
		end if
	end if
%>
        <%  
sub showContent
   	dim i
    i=0
%>
        <table class="table_southidc" border="0" cellspacing="1" width="100%" cellpadding="0" style="word-break:break-all">
          <tr bgcolor="#A4B6D7" class="title"> 
            <td width="35" height="25" align="center" bgcolor="#A4B6D7" class="tr_southidc">选中</td>
            <td width="54"  height="25" align="center" bgcolor="#A4B6D7" class="tr_southidc">ID</td>
            <td width="310" align="center" bgcolor="#A4B6D7" class="tr_southidc" >信息标题</td>
            <td width="102" align="center" bgcolor="#A4B6D7" class="tr_southidc" >栏目名称</td>
            
            <td width="70" align="center" bgcolor="#A4B6D7" class="tr_southidc" >加入时间</td>
            <td width="89" align="center" bgcolor="#A4B6D7" class="tr_southidc" >操作</td>
          </tr>
          <%do while not rs.eof%>
          <tr class="tdbg"> 
            <td width="35" height="22" align="center" bgcolor="#A4B6D7" class="tr_southidc"> 
              <input name='ID' type='checkbox' onClick="unselectall()" id="ID" value='<%=cstr(rs("ID"))%>'>            </td>
            <td width="54" align="center" bgcolor="#ECF5FF"><%=rs("id")%></td>
            <td  bgcolor="#ECF5FF">
			<a href="../../ReadNews.asp?rid=<%=rs("id")%>" target="_blank"><%=leftstr(rs("title"),68)%></a>
			<%If rs("Elite")=True Then Response.Write("<font color='red'>荐</font>")%>
			</td>
            
            <td align="center"  bgcolor="#ECF5FF">
<a href=News_Manage_recycle.asp?cateid=<%=rs("cateid")%>><%=rs("catename")%></a></td>
            <td align="center" bgcolor="#ECF5FF"><%= FormatDateTime(rs("PostTime"),2) %> </td>
            <td width="89" align="center" bgcolor="#ECF5FF"> <a href="News_modi.asp?ID=<%=rs("id")%>">修改</a> <a href="News_Del.asp?ID=<%=rs("ID")%>&Action=recovery" onClick="return ConfirmDel();">还原</a> <a href="News_Del.asp?ID=<%=rs("ID")%>&Action=Del" onClick="return ConfirmDel();">删除</a></td>
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
            <td width="655">
            
             <input type="radio" name="Action" value="recovery" checked>批量还原   <input type="radio" name="Action" value="Del"  >真正删除 
              <input type="submit" name="imageField" value="执行操作">
           
            </td>
          </tr>
        </table>
        <%
   end sub 
%>
      </form>
    </td>
  </tr>
</table>
<!-- #include file="../Inc/Foot.asp" -->
<%
rs.close
set rs=nothing  
call CloseConn()
%>