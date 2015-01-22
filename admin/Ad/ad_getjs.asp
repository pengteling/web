<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<TABLE width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table_southidc">
<tr class="tr_southidc">
<td style="padding:10px;">
<%
dim id
id=cint(request("id"))
if(id<1) then
	response.Write("没有找到id="&id&"的记录！")
	response.End()
end if
	Set rs = Server.CreateObject("Adodb.RecordSet")
	sql="select adType,photo,linkUrl,imgW,imgH,catalogId,content,title,moditime from ad where id="&id&" order by id desc " 
	rs.Open sql,conn,3,1
	if not rs.eof then
		tempArr=rs.GetRows()
	else
		response.Write("没有找到记录")
		response.End()
	end if
	rs.close
	set rs=nothing
''''''''''''''''''''''''''''''''''初使化''''''''''''''''''''''''''''
dim tempJsStr
tempJsStr=""
if(tempArr(0,0)=0) then
	tempJsStr="document.write('"&tempArr(6,0)&"');"&Chr(10)
elseif(tempArr(0,0)=1) then
if(tempArr(2,0)="") then
tempJsStr="document.write('<img src="""&tempArr(1,0)&""" border=""0"" width="""&tempArr(3,0)&""" height="""&tempArr(4,0)&""">');"&Chr(10)
else
	tempJsStr="document.write('<a href="""&tempArr(2,0)&""" target=""_blank""><img src="""&tempArr(1,0)&""" border=""0"" width="""&tempArr(3,0)&""" height="""&tempArr(4,0)&"""></a>');"&Chr(10)
	end if
elseif(tempArr(0,0)=2) then
	tempJsStr=tempArr(6,0)
tempJsStr=tempJsStr&"document.write('<div style=""z-index:1; position:absolute;  width:"&tempArr(3,0)&"px; height:"&tempArr(4,0)&"px; "">');"&Chr(10)
tempJsStr=tempJsStr&"document.write('<a href="""&tempArr(2,0)&""" target=""_blank"" style=""padding:"&tempArr(4,0)/2&"px "&tempArr(3,0)/2&"px; display:block;"">');"&Chr(10)
tempJsStr=tempJsStr&"document.write('</a>');"&Chr(10)
tempJsStr=tempJsStr&"document.write('</div>');"&Chr(10)

tempJsStr=tempJsStr&"document.write('<div style=""z-index:-1; width:"&tempArr(3,0)&"px; height:"&tempArr(4,0)&"px; "">');"&Chr(10)

	tempJsStr=tempJsStr&"document.write('<object classid=""clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"" codebase=""http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0"" width="""&tempArr(3,0)&""" height="""&tempArr(4,0)&""">');"&Chr(10)
  	tempJsStr=tempJsStr&"document.write('<param name=""movie"" value="""&tempArr(1,0)&""">');"&Chr(10)
  	tempJsStr=tempJsStr&"document.write('<param name=""quality"" value=""high"">');"&Chr(10)
	tempJsStr=tempJsStr&"document.write('<param name=""wmode"" value=""transparent"" />');"&Chr(10)
  	tempJsStr=tempJsStr&"document.write('<embed src="""&tempArr(1,0)&""" quality=""high"" pluginspage=""http://www.macromedia.com/go/getflashplayer"" type=""application/x-shockwave-flash"" width="""&tempArr(3,0)&""" height="""&tempArr(4,0)&"""></embed>');"&Chr(10)
	tempJsStr=tempJsStr&"document.write('</object>');"&Chr(10)
	tempJsStr=tempJsStr&"document.write('</div>');"&Chr(10)
end if

Set fs=Server.CreateObject(xiaodaofso)
Set file_w = fs.CreateTextFile(server.mappath("../../ad/js_"&id&".js"),true)	
file_w.WriteLine(tempJsStr)
file_w.close
set file_w=nothing
response.write("<p>广告"&id&"的调用代码为：<br><br><textarea cols=""40"" rows=""5"">&lt;script src=""ad/js_"&id&".js""&gt;&lt;/script&gt;</textarea></p>")
response.write("<p>请将以上代码复制到您要插入投票的地方。</p>") 
response.write("<p><a href=""#"" onClick=""javascript:history.back()""><==返 回</a></p>") 
call closeconn()
%></td>
</tr>
</TABLE>
<!-- #include file="../Inc/Foot.asp" -->