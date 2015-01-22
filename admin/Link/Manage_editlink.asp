<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%if Request.QueryString("mark")="southidc" then

id=request("id")
name=ChkFormStr(request("name"))
note=ChkFormStr(Request("note"))
link=ChkFormStr(Request("link"))
linktype=ChkFormStr(Request("linktype"))
sitepic=ChkFormStr(Request("sitepic"))

catalogid=request.Form("catalogid")

orderid=strTonum(request.Form("orderid"))


If name="" Then
Response.Write("<script language=""JavaScript"">alert(""错误：您没输入网站名称，请返回检查！！"");history.go(-1);</script>")
response.end
end if



If link="" or link="http://" Then
Response.Write("<script language=""JavaScript"">alert(""错误：您没有输入超连接，请返回检查！！"");history.go(-1);</script>")
response.end
end if

If linktype=0  and SitePic=""Then
Response.Write("<script language=""JavaScript"">alert(""错误：您没输入图标连接，请返回检查！！"");history.go(-1);</script>")
response.end
end if

If link<>"" and left(link,7)<>"http://" then link="http://"&link

Set rs = Server.CreateObject("ADODB.Recordset")
sql="select * from links where id="&id
rs.open sql,conn,1,3

rs("name")=name
rs("note")=note
rs("link")=link
rs("linktype")=linktype
rs("sitepic")=sitepic
rs("orderid")=orderid
rs("catalogid")=catalogid

rs.update
rs.close
response.redirect "Manage_link.asp"
end if
%>
<%
id=request.querystring("id")
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open "Select * From links where id="&id, conn,3,3
%>

<form name="form1" method="post" action="Manage_editlink.asp?mark=southidc">
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#ECF5FF" class="table_southidc">
    <tr>
      <td height="25" colspan="2" align="center"><span style="font-weight: bold">修改友情链接</span></td>
    </tr>
    <tr>
      <td width="8%" height="25" align="center" class="tr_southidc">网站名称</td>
      <td width="62%" class="tr_southidc"><input name="name" type="text" id="name" value="<%=rs("name")%>" size="35" maxlength="40">      </td>
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
		if cint(rs("catalogid")) = cint(rs2("id")) then
		response.Write("<option value="""&rs2("id")&""" selected>"&rs2("title")&"</option>")
		else
		response.Write("<option value="""&rs2("id")&""">"&rs2("title")&"</option>")
		end if
	rs2.movenext
	loop
else
	response.Write("暂时没有分类,请先添加分类!")
	response.End()
end if
rs2.close

%>
    </select></TD>
</TR>

    <tr>
      <td height="22" align="center" class="tr_southidc">网站说明</td>
      <td class="tr_southidc"><input name="note" type="text" id="note" value="<%=rs("note")%>" size="50" maxlength="120">      </td>
    </tr>
    <tr>
      <td height="22" align="center" class="tr_southidc">连接地址</td>
      <td class="tr_southidc"><input name="link" type="text" id="link" value="<%=rs("link")%>" size="35" maxlength="200">
      <input name="Id" type="hidden" id="Id" value="<%=Rs("ID")%>"></td>
    </tr>
	<tr>
          <td height="22" align="center" class="tr_southidc">链接类型</td>
      <td class="tr_southidc"><label>
	<input name="linktype" type="radio" value="1" <%If rs("linktype") = 1 Then Response.Write " checked"%>>
	文字链接&nbsp;
            <input type="radio" name="linktype" value="0" <%If rs("linktype") = 0 Then Response.Write " checked"%>>
            图片链接</label></td>
    </tr>
        <tr>
          <td height="22" align="center" class="tr_southidc">网站图片</td>
          <td class="tr_southidc">
		  <input name="SitePic" type="text" id="SitePic" value="<%=rs("sitepic")%>">
		  <input name="Submit22" type="button" value="上传图片"  onClick="window.open('../../fiveInc/mx_upload_flash.asp?formname=form1&editname=SitePic&uppath=UploadFiles/Link&filelx=jpg','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">		<%if rs("sitepic")<>"" then response.write "<img src="""&rs("sitepic")&""">"%>  </td>
    </tr>
    
    <tr>
      <td height="22" align="center" class="tr_southidc">序号</td>
      <td class="tr_southidc"><input name="orderid" type="text" id="link" value="<%=rs("orderid")%>" size="3" maxlength="40">
    </tr>
    
    <tr>
      <td height="25" colspan="2" align="center" bgcolor="#E3E3E3" class="tr_southidc">
        <input name="submit" type="submit" value="确认修改">
&nbsp;        <input name="reset" type="button" value="返回上一页" onClick="history.go(-1);">      </td>
    </tr>
  </table>
</form>
<!-- #include file="../Inc/Foot.asp" -->