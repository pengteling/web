<%@codepage=65001%>
<% Response.Charset="UTF-8" 
'on error resume next


'urls=request("urls")


'常用函数
'1、输入url目标网页地址，返回值getHTTPPage是目标网页的html代码
function getHTTPPage(url)
dim Http
set Http=server.createobject("MSXML2.serverXMLHTTP")
Http.open "GET",url,false
Http.send()
if Http.readystate<>4 then 
exit function
end if
getHTTPPage=bytesToBSTR(Http.responseBody,"utf-8")
set http=nothing
if err.number<>0 then err.Clear 
end function
Function BytesToBstr(body,Cset)
dim objstream
set objstream = Server.CreateObject("adodb.stream")
objstream.Type = 1
objstream.Mode =3
objstream.Open
objstream.Write body
objstream.Position = 0
objstream.Type = 2
objstream.Charset = Cset
BytesToBstr = objstream.ReadText 
objstream.Close
set objstream = nothing
End Function

'下面试着调用http://www.3doing.com/earticle/的html内容
Dim Html


cjurls="http://jz.u8see.com/index_b.asp?t="&Now()
'response.write cjurls
Html = getHTTPPage(cjurls)
'response.write Html

'set fso=CreateObject("scripting.FileSystemObject")
'set f=fso.CreateTextFile( server.mappath( "index_c.asp" ), true,true ) '当日净值排序

'f.WriteLine( Html )
'f.close
'set f = nothing
'set fso = Nothing

Set   objStream   =   Server.CreateObject("ADODB.Stream")   
          With   objStream   
          .Open   
          .Charset   =   "utf-8"   
          .Position   =   objStream.Size   
          .WriteText=Html   
          .SaveToFile   server.mappath("/index_c.asp"),2     
          .Close   
          End   With   
  Set   objStream   =   Nothing 

response.write "成功" & "<br>"



%>
<!--#include file="invite/email.asp"-->