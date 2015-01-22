<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../Admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
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




sub CheckNews(ID)
	set rs_check=server.CreateObject("adodb.recordset")
	rs_check.open "select passed,cateid from news where id="&id,conn,1,3
	if not rs_check.eof then
	cateid=rs_check("cateid")
	Call p_cate(cateid,16)
		if rs_check("passed") then
			rs_check("passed")=false
		else
			rs_check("passed")=True
		end if
		rs_check.update
	
	end if
	rs_check.close
	

end sub

%>