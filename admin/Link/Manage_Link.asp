<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../Admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%
catalogid = request.querystring("catalogid")
if catalogid<>"" then
catalogid=strtoNum(catalogid)
sql2 ="SELECT l.*,c.title from links l left join Catalogs_link c on l.catalogid=c.id where l.catalogid="&catalogid&" order by c.id, l.orderid"
else
sql2="SELECT l.*,c.title from links l left join Catalogs_link c on l.catalogid=c.id order by c.id, l.orderid"
end if
Set Rs = Server.CreateObject("ADODB.Recordset")
Rs.Open sql2,Conn,1,1

if Request.QueryString("no")="yes" then
id= Trim(Request("id"))
Set Rs = Server.CreateObject("ADODB.Recordset")
Rs.Open "DELETE FROM links Where id="&id,Conn,2,3,1

Set Rs= Nothing
Set Conn = Nothing
Response.Redirect "Manage_Link.asp"
end if

if Request.QueryString("mark")="southidc" then
note=request.form("note")
link=request.form("link")
name=request.form("name")
catalogid=request.Form("catalogid")
orderid=strTonum(request.Form("orderid"))
linktype=request.form("linktype")
sitepic=request.form("sitepic")

If name="" Then
Response.Write("<script language=""JavaScript"">alert(""错误：您没输入网站名称，请返回检查！！"");history.go(-1);</script>")
response.end
end if

If note="" Then
'Response.Write("<script language=""JavaScript"">alert(""错误：您没有输入网站说明，请返回检查！！"");history.go(-1);</script>")
'response.end
end if

If link="" or link=" " Then
Response.Write("<script language=""JavaScript"">alert(""错误：您没有输入超连接，请返回检查！！"");history.go(-1);</script>")
response.end
end if

If linktype=0  and SitePic=""Then
Response.Write("<script language=""JavaScript"">alert(""错误：您没输入图标连接，请返回检查！！"");history.go(-1);</script>")
response.end
end if

If link<>"" and left(link,7)<>"http://" then link="http://"&link

Set rs = Server.CreateObject("ADODB.Recordset")
sql="select * from links "
rs.open sql,conn,1,3
rs.addnew
rs("name")=name
rs("note")=note
rs("link")=link
rs("sitepic")=sitepic
rs("linktype")=linktype
rs("AddTime")=now()
rs("orderid")=orderid
rs("catalogid")=catalogid
rs.update
Response.Redirect "Manage_Link.asp"
end if
%>

<table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
  <tr>
    <td height="25" class="back_southidc"><strong>友情链接管理</strong></td>
  </tr>
  <tr>
    <form action="Manage_Link.asp?mark=southidc" method="post" name="form1" id="form1">
      <td class="tr_southidc"><table width="100%" border="0" align="center" cellpadding="1" cellspacing="0" bgcolor="#ECF5FF">
        <tr>
          <td width="21%" height="22" align="center" bgcolor="#A4B6D7" class="tr_southidc">网站名称</td>
          <td width="79%"><input type="text" name="name" size="35" maxlength="40">          </td>
        </tr>
        <TR>
  <TD  width="21%" height="22" align="center" bgcolor="#A4B6D7" class="tr_southidc">所属类别</TD>
  <TD width="79%" align="left" bgcolor="#ECF5FF"><select name="catalogid" >
  
<%
set rs2=server.CreateObject("adodb.recordset")
sql="select id,title from catalogs_link order by id asc"
rs2.open sql,conn,3,1
if not rs2.eof then
	do while not rs2.eof
		response.Write("<option value="""&rs2("id")&""">"&rs2("title")&"</option>")
		catalogids_link =catalogids_link& "[<a href=""?catalogid="&rs2("id")&""">"&rs2("title")&"</a>]  "
	rs2.movenext
	loop
else
	response.Write("暂时没有分类,请先添加分类!")
	response.End()
end if
'rs2.close

%>
    </select></TD>
</TR>
        <tr>
          <td height="22" align="center" bgcolor="#A4B6D7" class="tr_southidc">网站说明</td>
          <td><input type="text" name="note" size="50" maxlength="120">          </td>
        </tr>
		<tr>
          <td height="22" align="center" bgcolor="#A4B6D7" class="tr_southidc">连接地址</td>
          <td><input type="text" name="link" size="40" maxlength="50" value="http://">          </td>
        </tr>
        <tr>
          <td height="22" align="center" bgcolor="#A4B6D7" class="tr_southidc">链接类型</td>
          <td><label>
<input name="linktype" type="radio" value="1" checked>            
文字链接&nbsp;
            <input type="radio" name="linktype" value="0">
            图片链接</label></td>
        </tr>
        <tr>
          <td height="22" align="center" bgcolor="#A4B6D7" class="tr_southidc">网站图片</td>
          <td>
		  <input name="SitePic" type="text" id="SitePic">
		  <input name="Submit22" type="button" value="上传图片"  onClick="window.open('../../fiveInc/mx_upload_flash.asp?formname=form1&editname=SitePic&uppath=UploadFiles/Link&filelx=jpg','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">		  </td>
        </tr>
         <tr>
      <td height="22" align="center" class="tr_southidc">序号</td>
      <td class="tr_southidc"><input name="orderid" type="text" id="link" value="0" size="3" maxlength="40">
    </tr>
        <tr bgcolor="#A4B6D7">
          <td height="30" bgcolor="#A4B6D7" class="tr_southidc">&nbsp;</td>
          <td height="30" bgcolor="#A4B6D7" class="tr_southidc"><input type="submit" name="Submit" value="确认添加">
&nbsp;
<input type="reset" name="Submit2" value="全部重填"></td>
        </tr>
      </table>
          <br>      </td>
    </form>
  </tr>
</table>
<br>
点击分类查看：<%=catalogids_link%>
<br>
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
<tr bgcolor="#A4B6D7">
              <td width="22%" height="25" align="center" bgcolor="#A4B6D7" class="blod">网站名称</td>
    <td width="46%" align="center" bgcolor="#A4B6D7" class="blod">网站说明</td>
    <td width="14%" align="center" bgcolor="#A4B6D7" class="blod">加入时间</td>
    <td align="center" bgcolor="#A4B6D7" class="blod">操作操作</td>
  </tr>
            <% do while not Rs.eof %>
            <tr bgcolor="#ECF5FF">
              <td height="25" align="center" bgcolor="#ECF5FF"><a href="<%=Rs("link")%>" target="_blank"><%=rs("name")%></a>[<a href=?catalogid=<%=rs("catalogid")%>><%=rs("title")%></a>]</td>
              <td align="center" bgcolor="#ECF5FF"><%=Rs("note")%></td>
              <td align="center" bgcolor="#ECF5FF"><%= FormatDateTime(rs("AddTime"),2) %></td>
              <td align="center" bgcolor="#ECF5FF"><a href="Manage_editlink.asp?id=<%=Rs("id")%>">修改</a>&nbsp;&nbsp;<a href="Manage_Link.asp?id=<%=Rs("id")%>&amp;no=yes" onClick="return confirm('确定要删除友情链接吗？');">删除</a></td>
            </tr>
            <%Rs.MoveNext 
loop 
%>
</table>         
<%  
Set Rs = Nothing 
Set Conn = Nothing 
%>
<!-- #include file="../Inc/Foot.asp" -->