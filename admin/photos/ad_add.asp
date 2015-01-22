<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%
id=cint(request("id"))
tid=cint(request("t"))
m_id=cint(request("mid"))


if request("act")="add" then
	title=trim(request.Form("title"))
	if(isnull(title) or len(title)<1) then
		response.Write("<script>alert('标题不能为空！');history.back();</script>")
		response.End()
	end if
	
	rs.open "select * from photos where 1=2 ",conn,1,3
	rs.addnew
		rs("rid")=request("catalogid")
		rs("title")=title
		rs("type")=request("type")
		rs("modeltype")=request("modeltype")
		rs("imgurl")=request("photo")
		rs("videourl")=request("video")
	rs.update
	rs.close

end if

%>
<FORM method="POST" name="form1" action="ad_add.asp?act=add" style="margin:0 0 0 0;">
  <TABLE width="100%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#A4B6D7">
<TR>
  <TD height="22" colspan="2" align="center"><span style="font-weight: bold">添加图片或视频</span></TD>
  </TR>
<TR bgcolor="#F5F5F5">
  <TD width="18%" align="right" bgcolor="#ECF5FF">所 属 楼 盘：</TD>
  <TD width="82%" align="left" bgcolor="#ECF5FF"><select name="catalogid" >

<%
set rs=server.CreateObject("adodb.recordset")
sql="select id,title from product_c order by id asc"
rs.open sql,conn,3,1
if not rs.eof then
	do while not rs.eof
		if clng(rs("id"))=id then
		response.Write("<option value="""&rs("id")&""" selected>"&rs("title")&"</option>")
		else
		response.Write("<option value="""&rs("id")&""">"&rs("title")&"</option>")
		end if
	rs.movenext
	loop
else
	response.Write("暂时没有分类,请先添加分类!")
	response.End()
end if
rs.close
set rs=nothing
%>
    </select></TD>
</TR>
<TR bgcolor="#F5F5F5">
  <TD align="right" bgcolor="#ECF5FF">标题名称：</TD>
  <TD align="left" bgcolor="#ECF5FF"><input name="title" type="text" id="title" size="60">
    <span class="red">*</span></TD>
</TR>
<TR bgcolor="#F5F5F5">
  <TD align="right" bgcolor="#ECF5FF">类型：</TD>
  <TD align="left" bgcolor="#ECF5FF"><input name="modelType" type="radio" value="0" <%if m_id=0 then response.write "checked"%>>
    楼盘视界
      <input name="modelType" type="radio" value="1" <%if m_id=1 then response.write "checked"%>>
户型图
</TD>
</TR>
<TR bgcolor="#F5F5F5">
  <TD align="right" bgcolor="#ECF5FF">文件类型：</TD>
  <TD align="left" bgcolor="#ECF5FF"><input name="type" type="radio" onClick="videoUrl.style.display='none'" value="0" <%if tid=0 then response.write "checked"%>>
    图片
      <input name="type" type="radio" value="1" onClick="videoUrl.style.display=''" <%if tid=1 then response.write "checked"%>>
视频FLV
</TD>
</TR>
<TR bgcolor="#F5F5F5" id="photoUrl">
  <TD align="right" bgcolor="#ECF5FF">图片地址：</TD>
  <TD align="left" bgcolor="#ECF5FF">
    <input name="photo" type="text" id="photo" size="50">
    <span class="tr_southidc">
    <input name="Submit222" type="button" value="上传->"  onClick="window.open('../../FiveInc/mx_upload_flash.asp?formname=form1&editname=photo&uppath=UploadFiles/Ad&filelx=jpgswf','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">
    <span class="red">*</span></span></TR>

<TR bgcolor="#F5F5F5" id="videoUrl" <%if tid=0 then%>style="display:none;"<%end if%>>
  <TD align="right" bgcolor="#ECF5FF">视频地址：</TD>
  <TD align="left" bgcolor="#ECF5FF">
    <input name="video" type="text" id="video" size="50">
    <span class="tr_southidc">
    <input name="Submit222" type="button" value="上传->"  onClick="window.open('../../FiveInc/mx_upload_flash.asp?formname=form1&editname=video&uppath=UploadFiles/Ad&filelx=jpgswf','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">
    </span></TR>
<TR bgcolor="#F5F5F5">
	<TD align=right bgcolor="#ECF5FF">&nbsp;	  </TD>
    <TD align=left bgcolor="#ECF5FF">
        <input type=submit name=b1 value="提 交">&nbsp;&nbsp;
        <input type=reset name=b2 value="重 填">       
    </TD>
</TR>
</TABLE>
</FORM>

<!-- #include file="../Inc/Foot.asp" -->