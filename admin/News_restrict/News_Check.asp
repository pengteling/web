<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../Admin.asp"-->

<%
ID=trim(request("ID"))


Action=Trim(Request("Action"))


if ID="" or Action<>"check" then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>参数不足！</li>"
end if
if FoundErr=False then
	if instr(ID,",")>0 then
		dim idarr,i
		idArr=split(ID)
		for i = 0 to ubound(idArr)
			call CheckNews(clng(idarr(i)))
		next
	else
		call CheckNews(clng(ID))
	end if
end if
if FoundErr=False then
	call CloseConn()
	Response.Redirect Request.ServerVariables("HTTP_REFERER")
else
	call CloseConn()
	call WriteErrMsg()
end if

set rs=server.CreateObject("adodb.recordset")


sub CheckNews(ID)
	rs.open "select passed from news where id="&id,conn,1,3
	if not rs.eof then
		if rs("passed") then
			rs("passed")=false
		else
			rs("passed")=True
		end if
		rs.update
	
	end if
	rs.close
	

end sub

%>