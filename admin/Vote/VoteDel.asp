<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../Admin.asp"-->
<%
dim VoteID,sql
VoteID=trim(Request("ID"))
if VoteID<>"" then
	sql="delete from Vote where ID="&Clng(VoteID)&""
	conn.Execute sql
    call CloseConn()      
end if
response.redirect "VoteManage.asp"
%>