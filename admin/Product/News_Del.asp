<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->

<%
dim ID,Action,sqlDel,rsDel,FoundErr,ErrMsg,ObjInstalled
ID=trim(request("ID"))
Action=Trim(Request("Action"))
FoundErr=False
ObjInstalled=IsObjInstalled(xiaodaofso) 'Const xiaodaofso="Scripting.FileSystemObject" 'FSO设置

if ID<>"" and (Action="Del" or action="recovery") then

else
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>参数不足！</li>"
end if
if FoundErr=False then
	if instr(ID,",")>0 then
		dim idarr,i
		idArr=split(ID)
		for i = 0 to ubound(idArr)
			if Action="Del" then
				call DelNews(clng(idarr(i)))
			elseif action="recovery" then
				call MoveNews(clng(idarr(i)))
			end if
		next
	else
		if Action="Del" then
			call DelNews(clng(ID))
		elseif action="recovery" then
			call MoveNews(clng(ID))
		end if
	end if
end if
if FoundErr=False then
	call CloseConn()
	Response.Redirect Request.ServerVariables("HTTP_REFERER")
else
	call CloseConn()
	call WriteErrMsg()
end if

sub DelNews(ID)
	PurviewChecked=False
	sqlDel="select * from product where ID=" & CLng(ID)
	Set rsDel= Server.CreateObject("ADODB.Recordset")
	rsDel.open sqlDel,conn,1,3
	if FoundErr=False then
		if DelUpFiles="Yes" and ObjInstalled=True then
			dim fso,strUploadFiles,arrUploadFiles
			strUploadFiles=rsDel("UploadFiles") & ""
			if strUploadFiles<>"" then
				Set fso = CreateObject(xiaodaofso)
				if instr(strUploadFiles,"|")>1 then
					arrUploadFiles=split(strUploadFiles,"|")
					for i=0 to ubound(arrUploadFiles)
						if arrUploadfiles(i)<>"" then
							if fso.FileExists(server.MapPath(arrUploadfiles(i))) then
								fso.DeleteFile(server.MapPath(arrUploadfiles(i)))
							end if
						end if
					next
				else
					if fso.FileExists(server.MapPath(strUploadfiles)) then
						fso.DeleteFile(server.MapPath(strUploadfiles))
					end if
				end if
				Set fso = nothing
			end if
			'if rsDel("DefaultPicUrl")<>"" and rsDel("DefaultPicUrl")<>"images/Nopic.jpg" then
				'Set fso = CreateObject("Scripting.FileSystemObject")
				'if fso.FileExists(server.MapPath("../../"&rsDel("DefaultPicUrl"))) then
					'fso.DeleteFile(server.MapPath("../../"&rsDel("DefaultPicUrl")))
				'end if
				'Set fso = nothing
			'end if
		end if
		rsDel.delete
		rsDel.update
		set rsDel=nothing		
	end if
end sub

sub MoveNews(ID)
	
	sqlDel="select * from product where ID=" & CLng(ID)
	Set rsDel= Server.CreateObject("ADODB.Recordset")
	rsDel.open sqlDel,conn,1,3
	
	if not rsDel.eof then
	rsDel("isdel")=0
		rsDel.update
		set rsDel=nothing		
	end if
end sub
%>