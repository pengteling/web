<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp" -->
<%
sql_del = "delete from liuyan where id ="&request("id")
conn.execute(sql_del)
response.Redirect("Book_index3.asp?work=yz")
%>

 
