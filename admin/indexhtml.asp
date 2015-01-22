<%
dim Html_Temp,FileName,FilePath,strUrl,objXmlHttp,binFileData,objAdoStream
set objXmlHttp = Server.CreateObject("Microsoft.XMLHTTP")
set objAdoStream = Server.CreateObject("ADODB.Stream")

'生成首页
FileName = "index.htm"
FilePath = Server.MapPath("/")&"\"&FileName
Html_Temp = Html_Temp&FilePath&"</LI>"
strUrl = "http://"
strUrl = strUrl&Request.ServerVariables("SERVER_NAME")&"/index.asp"
objXmlHttp.open "GET",strUrl,false
objXmlHttp.send()
if objXmlHttp.status <> 200 then
	Response.Write("生成失败!")
	Response.End()
end if
binFileData = objXmlHttp.responseBody
objAdoStream.Type = 1
objAdoStream.Open()
objAdoStream.Write(binFileData)
objAdoStream.SaveToFile FilePath,2
objAdoStream.Close()
'首页生成完成

set objAdoStream=nothing
set objXmlHttp=nothing
Response.Write"成功生成首页<br />"
Response.Write("<a href='http://"&Request.ServerVariables("SERVER_NAME")&"/index.htm' target='_blank'>http://"&Request.ServerVariables("SERVER_NAME")&"/index.htm</a>")
Response.Write("<meta http-equiv=""refresh"" content=""10;URL=admin_main.asp"" />")
Response.End()
%>