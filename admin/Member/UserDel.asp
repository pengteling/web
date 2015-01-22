<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<%
dim UserID,sql,rs
UserID=trim(Request("UserID"))
if UserID<>"" then
	sql="delete from [User] where UserID=" & Clng(UserID)
	conn.Execute sql
end if
call CloseConn()      
response.redirect "UserManage.asp"
%>