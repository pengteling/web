<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<%
djfc="已经处理"
set rs=server.createobject("adodb.recordset")
sqltext="select Flag from OrderList where OrderNum='"&request("OrderNum")&"'"
rs.open sqltext,conn,1,1
if rs("Flag")="已经处理" then
rs.close
Response.Redirect "OrderList_Save.asp?msg=此订单您已经做过处理！"
Else
set rs=server.createobject("adodb.recordset")
sqltext="update OrderList set Flag='"&djfc&"' where OrderNum='"&request("OrderNum")&"'"
rs.open sqltext,conn,3,3
response.redirect "OrderMessageBox.asp?msg=订单处理处理完毕，请按客户详细地址发货！"
end if
%>