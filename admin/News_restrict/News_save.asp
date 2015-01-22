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
If supportAspjpeg="1" And DefaultPicUrl<>"images/nopic.jpg" Then
	Set ap=new AspJpeg
	ap.MathPathFrom=server.mappath(DefaultPicUrl)
	ap.MathPathTo=server.mappath(ResizePath(DefaultPicUrl))
	ap.Width=149
	ap.Height=104
	t=ap.image_resize()
End if

UploadFiles=ChkFormStr(Request("UploadFiles"))
IncludePic=strToNum(Request("IncludePic"))
px=strToNum(Request("px"))
Content=Trim(Request("Content"))
if clng(request("saveimg"))=1 then
Content=ReplaceSaveRemoteFile(Content,FilesStartStr,FilesOverStr,False,True,True,FilesPath,NewsUrl) 
end if
'if UploadFiles<>"" and right(UploadFiles,1)<>"|" then
'	UploadFiles=UploadFiles&"|"
'end if
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
		
		rs("UploadFiles")=UploadFiles
		rs("DefaultPicUrl")=DefaultPicUrl
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
		rs.update
		rs.close
		set rs=nothing
		conn.close  
		set conn=nothing
		response.write "<script language='javascript'>" & chr(13)
				response.write "alert('信息发布成功！');" & Chr(13)
				response.write "window.document.location.href='News_Manage.asp';"&Chr(13)
				response.write "</script>" & Chr(13)
		Response.End
Else
		set rs=server.createobject("adodb.recordset")
		sql="select * from NEWS where Id="&ID
		rs.open sql,conn,1,3
		rs("px")=px
		
		rs("title")=title
		rs("Color")=Color
		rs("author")=author
		rs("ComeFrom")=ComeFrom
		rs("Content")=Content
		rs("cateid")=cateid
	
		rs("UploadFiles")=UploadFiles
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
		conn.close  
		set conn=nothing
	if Request.Cookies("xd_urljilunew")="" then
		  xiaodaourl="News_Manage.asp"
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
