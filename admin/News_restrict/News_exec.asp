<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->

<%
dim ID,Action,sqlDel,rsDel,FoundErr,ErrMsg,ObjInstalled
ID=trim(request("ID"))
Action=Trim(Request("Action"))
cateid=strToNum(Request("cateid"))
FoundErr=False


if ID<>"" and (Action="Del" or action="move") then

else
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>请选择至少一条信息！</li><li>参数不足！</li>"
end if
if FoundErr=False then
	if instr(ID,",")>0 then
		dim idarr,i
		idArr=split(ID)
		for i = 0 to ubound(idArr)
			if Action="Del" then
				call DelNews(clng(idarr(i)))
			elseif action="move" then
				call MoveNews(clng(idarr(i)))
			end if
		next
	else
		if Action="Del" then
			call DelNews(clng(ID))
		elseif action="move" then
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
	
	sqlDel="select * from News where ID=" & CLng(ID)
	Set rsDel= Server.CreateObject("ADODB.Recordset")
	rsDel.open sqlDel,conn,1,3
	
	if not rsDel.eof then
	rsDel("isdel")=1
		rsDel.update
		set rsDel=nothing		
	end if
end sub


sub MoveNews(ID)
	
	sqlDel="select * from News where ID=" & CLng(ID)
	Set rsDel= Server.CreateObject("ADODB.Recordset")
	rsDel.open sqlDel,conn,1,3
	
	if not rsDel.eof then
	rsDel("cateid")=cateid
		rsDel.update
		set rsDel=nothing		
	end if
end sub
%>