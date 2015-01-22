<!--#include file="../../FiveInc/conn.asp"-->

<%


'set rs=conn.execute ("insert into news(title,content) output inserted.id values('ewrwer','ewrwerwe')  ")
'response.write rs(0)

'rs.close
'rs.open "insert into news(title,content) output inserted.id values('ewrwer','ewrwerwe')  ",conn,1,1
'response.write rs(0)


set cmd = Server.CreateObject("ADODB.Command")
cmd.ActiveConnection = conn
cmd.CommandType = 1
cmd.CommandText = "insert into news(title,content) output inserted.id values(?,?)"
'cmd.Parameters.Append cmd.CreateParameter("@id", 200, 3, 2 )
cmd.Parameters.Append cmd.CreateParameter("@title", 200, 1, 20, "user01")
cmd.Parameters.Append cmd.CreateParameter("@content", 200, 1, 20, "123456")

set rs = cmd.Execute()
Response.Write(rs(0).value)

rs.close

response.write cmd("@content")

conn.Close()



%>
<!-- #include file="../Inc/Foot.asp" -->