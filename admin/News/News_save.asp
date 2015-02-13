<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<!-- #include file="../Inc/ReplaceSaveRemoteFile.asp" -->
<%
ID=strToNum(Request("ID"))
title=ChkFormStr(Request("Title"))
Color=ChkFormStr(Request("Color"))
author=ChkFormStr(Request("author"))
ComeFrom=ChkFormStr(Request("ComeFrom"))

Passed=ChkFormStr(request.form("Passed"))
cateid=strToNum(Request("cateid"))

DefaultPicUrl=LCase(ChkFormStr(request.form("DefaultPicUrl")))


UploadFiles=ChkFormStr(Request("UploadFiles"))
IncludePic=strToNum(Request("IncludePic"))
px=strToNum(Request("px"))
Content=Trim(Request("Content"))
Content_zy=Trim(Request("Content_zy"))
if clng(request("saveimg"))=1 then
Content=ReplaceSaveRemoteFile(Content,FilesStartStr,FilesOverStr,False,True,True,FilesPath,NewsUrl) 
end if
'if UploadFiles<>"" and right(UploadFiles,1)<>"|" then
'	UploadFiles=UploadFiles&"|"
'end if

rfiles= relativeUploadfiles(Content,"/uploadfiles","gif|jpg|bmp|png|jpeg|zip|rar|doc|xls|docx|xlsx|pdf|mp4|flv|wmv" )
'response.write rfiles
rfiles=split(rfiles,"|")

if DefaultPicUrl="" and ubound(rfiles)>0 then
DefaultPicUrl=rfiles(0)
end if
'response.End()
Elite=ChkFormStr(request.form("Elite"))
cateid=strToNum(request("cateid"))
PostTime=Request("PostTime")
If IsDate(PostTime)=False Then PostTime=now()
If cateid=0 Then
		response.write "<script language='javascript'>" & chr(13)
				response.write "alert('请选择类别！');" & Chr(13)
				response.write "history.back(-1);;"&Chr(13)
				response.write "</script>" & Chr(13)
		Response.End

End If


If Content="" Then
		response.write "<script language='javascript'>" & chr(13)
				response.write "alert('请输入内容！');" & Chr(13)
				response.write "history.back(-1);;"&Chr(13)
				response.write "</script>" & Chr(13)
		Response.End
end if


If lcase(Request("Act"))="add" Then
	Call p_cate(cateid,2)
		set rs=server.createobject("adodb.recordset")
		sql="select * from NEWS where (id is null)"
		rs.open sql,conn,1,3
		rs.addnew
	
		rs("px")=px
		rs("title")=title
		rs("Color")=Color
		rs("author")=author
		rs("ComeFrom")=ComeFrom
		rs("Content")=Content
		rs("Content_zy")=Content_zy
		rs("UploadFiles")=UploadFiles
		rs("DefaultPicUrl")=DefaultPicUrl
		
If supportAspjpeg="1" And DefaultPicUrl<>"images/nopic.jpg" Then
		
	'thumb1 = Thumb(DefaultPicUrl,"s1",742,231)
	'thumb2 = Thumb(DefaultPicUrl,"s2",182,95)
	
End if

		if instr(DefaultPicUrl,"Nopic")>0 then		
			rs("IncludePic")=0
		else
			rs("IncludePic")=1
			end if
		
		rs("cateid")=cateid
		if Elite="yes" then
			rs("Elite")=True
		else
			rs("Elite")=False
		end if
		if Passed="yes" then
		rs("Passed")=True
	else
		rs("Passed")=False
	end if
		rs("PostTime")=PostTime
		
		temppath = formatdate(PostTime,2)
		
		rs.update
		
		'rs("dynamicUrl") = "readnews.asp?id="&rs("id")
		'rs("staticUrl")=temppath&"/"&rs("id")&".html"
		'rs.update
		
		rs.close
		set rs=nothing
		
set rs=Easp.Db.Sel("	select IDENT_CURRENT('news')")
id =rs(0)

for i = 0 to ubound(rfiles)		
		
		result = Easp.Db.upd("uploadfiles","newsid="&ID&"","path='"&rfiles(i)&"'" )		'关联附件ID哦
next
		result = Easp.Db.upd("uploadfiles","newsid="&ID&"","path='"&DefaultPicUrl&"'" )		'关联首页图片

set rs=server.CreateObject("adodb.recordset")
rs.open "select * from news where id="&Id,conn,1,3
if not rs.eof then

rs("dynamicUrl") = "readnews.asp?id="&rs("id")
		rs("staticUrl")=temppath&"/"&rs("id")&".html"
		rs.update
end if
rs.close

		
		conn.close  
		set conn=nothing
		response.write "<script language='javascript'>" & chr(13)
				response.write "alert('信息发布成功！');" & Chr(13)
				response.write "window.document.location.href='News_Manage.asp?cateid="&cateid&"';"&Chr(13)
				response.write "</script>" & Chr(13)
		Response.End
Else
	Call p_cate(cateid,4)
		set rs=server.createobject("adodb.recordset")
		sql="select * from NEWS where Id="&ID
		rs.open sql,conn,1,3
		rs("px")=px
		
		rs("title")=title
		rs("Color")=Color
		rs("author")=author
		rs("ComeFrom")=ComeFrom
		rs("Content")=Content
		rs("Content_zy")=Content_zy
		rs("cateid")=cateid
	
		rs("UploadFiles")=UploadFiles
If supportAspjpeg="1" And DefaultPicUrl<>"images/nopic.jpg" and rs("DefaultPicUrl")<>DefaultPicUrl Then
	'thumb1 = Thumb(DefaultPicUrl,"s1",742,231)
	'thumb2 = Thumb(DefaultPicUrl,"s2",182,95)
End if
		
		
		
		
		rs("DefaultPicUrl")=DefaultPicUrl
		


		if instr(DefaultPicUrl,"Nopic")>0 then
		
			rs("IncludePic")=0
		else
			rs("IncludePic")=1
			end if
		
		if Elite="yes" then
			rs("Elite")=True
		else
			rs("Elite")=False
		end if
		if Passed="yes" then
		rs("Passed")=True
	else
		rs("Passed")=False
	end if
		rs("PostTime")=PostTime
		rs.update
		rs.close
		set rs=nothing
		
		for i = 0 to ubound(rfiles)		
		
			result = Easp.Db.upd("uploadfiles","newsid="&ID&"","path='"&rfiles(i)&"'" )		'关联附件ID哦
		next
		result = Easp.Db.upd("uploadfiles","newsid="&ID&"","path='"&DefaultPicUrl&"'" )		'关联首页图片
		
		if UploadFiles<>"" then 
		rfiles=split(UploadFiles,"|")
		for i = 0 to ubound(rfiles)		
		
			result = Easp.Db.upd("uploadfiles","newsid="&ID&"","path='"&rfiles(i)&"'" )		'关联附件ID哦
		next
		result = Easp.Db.upd("uploadfiles","newsid="&ID&"","path='"&DefaultPicUrl&"'" )		'关联首页图片
		
		end if
		conn.close  
		set conn=nothing
	if Request.Cookies("xd_urljilunew")="" then
		  xiaodaourl="News_Manage.asp?cateid="&cateid
		  else
		  xiaodaourl=Request.Cookies("xd_urljilunew")
		  end if
		response.write "<script language='javascript'>" & chr(13)
				response.write "alert('信息修改成功！');" & Chr(13)
				response.write "window.document.location.href='"&xiaodaourl&"';"&Chr(13)
				response.write "</script>" & Chr(13)
		Response.End
End If
%>
