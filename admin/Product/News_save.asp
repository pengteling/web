<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<!-- #include file="../Inc/ReplaceSaveRemoteFile.asp" -->
<%

'lumns= Array("city","wystatus","gzarea","roomsize","tel","address","xmtype","xmurl","xmintro","xmlogo")



'新加的
city=ChkFormStr(Request("city"))
wystatus=ChkFormStr(Request("wystatus"))
gzarea=alltrim(ChkFormStr(Request("gzarea")))
roomsize=alltrim(ChkFormStr(Request("roomsize")))
tel=ChkFormStr(Request("tel"))
address=ChkFormStr(Request("address"))
xmtype=ChkFormStr(Request("xmtype"))
xmurl=ChkFormStr(Request("xmurl"))
xmintro=ChkFormStr(Request("xmintro"))
xmlogo=ChkFormStr(Request("xmlogo"))

'新加的end

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
'response.write Content
Content_zy=Trim(Request("Content_zy"))
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
	Call p_cate(cateid,2)
		set rs=server.createobject("adodb.recordset")
		sql="select * from product where (id is null)"
		rs.open sql,conn,1,3
		rs.addnew
	
	
	rs("wystatus")=wystatus
	rs("gzarea")=gzarea
	rs("roomsize")=roomsize
	rs("tel")=tel
	rs("address")=address
	rs("xmtype")=xmtype
	rs("xmurl")=xmurl
	rs("xmintro")=xmintro
	rs("xmlogo")=xmlogo
	rs("city")=city
	
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
		
	thumb1 = Thumb(DefaultPicUrl,"s1",742,231)
	thumb2 = Thumb(DefaultPicUrl,"s2",182,95)
	
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
		rs.update
		rs.close
		set rs=nothing
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
		sql="select * from product where Id="&ID
		rs.open sql,conn,1,3
	rs("wystatus")=wystatus
	rs("gzarea")=gzarea
	rs("roomsize")=roomsize
	rs("tel")=tel
	rs("address")=address
	rs("xmtype")=xmtype
	rs("xmurl")=xmurl
	rs("xmintro")=xmintro
	rs("xmlogo")=xmlogo
	rs("city")=city
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
	thumb1 = Thumb(DefaultPicUrl,"s1",742,231)
	thumb2 = Thumb(DefaultPicUrl,"s2",182,95)
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
