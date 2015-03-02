<%
'调用公司简介
'参数说明 ID -内容ID n-显示字数0为显示全部 g-对内容是否进行HTML代码过滤1为过滤0为不过滤
Sub ShowCompany(id,n,g)
	Msql = "Select Top 1 id,ComName,Content From [Company] Where ID="&id
	Set ComRs=Conn.execute(Msql)
	If Not ComRs.Eof Then
		If g=1 Then
			If n=0 Then
				Response.Write(RemoveHTML(ComRs("Content")))
			Else
				Response.Write(CutStr(RemoveHTML(ComRs("Content")),n))
			End If
		Else
			If n=0 Then
				Response.Write(ComRs("Content"))
			Else
				Response.Write(left(ComRs("Content"),n))
			End If
		End If
	End If
	ComRs.Close
	Set ComRs = Nothing
End Sub

Function ShowNewslist(classid,num)
	dim newstr:newstr="<ul>"
	set news_rs=conn.execute("select top "&num&" id,title,posttime,bigclass from news where bigclass="&classid&" order by posttime desc")
	if news_rs.eof then
		newstr=newstr&"<li>暂无信息</li></ul>"
		exit function
	end if
	do while not news_rs.eof
		newstr=newstr&"<li><a href='ReadNews.asp?rid="&news_rs(0)&"'>"&left(news_rs(1),20)&"</a></li>"
		news_rs.movenext
		loop
		newstr=newstr&"</ul>"
		set news_rs=nothing
	ShowNewslist=newstr	
End Function


Function caselist(classid,num)
	dim casestr:casestr="<ul>"
	set crs=conn.execute("select top "&num&" id,title,posttime,bigclass,defaultpicurl,IncludePic,content from news where  Elite=true and bigclass="&classid&" order by posttime desc")
	if crs.eof then
		caselist="<li>无信息</li></ul>"
		exit function
	end if
	do while not crs.eof
		casestr=casestr&"<li><img src='"&crs(4)&"'><h3><a href='ReadNews.asp?rid="&crs(0)&"&t=self'>"&crs(1)&"</a></h3>"&left(Replace(RemoveHTML(crs(6)),"&nbsp;",""),25)&"...</li>"
		crs.movenext
		loop
		casestr=casestr&"</ul>"
		set crs=nothing
	caselist=casestr	
End Function

'新闻列表调用
'调用方法：<ul>< % ShowNews() % ></ul>
Function ShowNews()
	TrNum=0
	cateid = strToNum(Request("id"))	
	Keyword = ChkFormStr(Request("so"))
	msql="Select id,title,posttime,color,defaultpicurl,content,hits,staticUrl,dynamicUrl from news_c where 1=1 "
	If cateid<>0 Then
		'msql=msql&" and cateid="&cateid&""
		msql=msql&" and cateid in ("&sonid&")"
	End If
	
	If Keyword<>"" Then
		msql=msql&" and (title like '%"&Keyword&"%' or content like '%"&Keyword&"%')"
	End If
	
	msql=msql&" Order By px desc,posttime Desc,ID Desc"
	Set mypage=new zh_Showpage
	PSize=15
	mypage.getconn=Conn	
	mypage.getsql=msql
	mypage.pagesize=PSize	
	set NewsListRs=mypage.getrs()
	
	If 	NewsListRs.Eof Then
		Response.Write "<br />&nbsp;&nbsp;&nbsp;没有找到信息!"
	Else
			Response.Write ("<ul>")&vbcrlf
		For TrNum=1 To mypage.pagesize
			If NewsListRs.Eof Then Exit For
			
			
			
	
%>
       <li class="newslist"><div class="con"><span class="time"><%=formatdate(NewsListRs("posttime"),2)%></span><a href="<%=infoURL(NewsListRs("staticUrl"),NewsListRs("dynamicUrl"),supportHtml)%>"><%=NewsListRs("title")%></a>
       </div>
       </li>
       
<%
		
		
			NewsListRs.MoveNext
		Next
			Response.Write("</ul>")&vbcrlf
		Set NewsListRs = Nothing
		If TrNum >=1 Then
			Response.Write(""&mypage.showpage()&"")
		End If
	End If

End Function



Function Showgoods()
	TrNum=0
	cateid = strToNum(Request("id"))	
	Keyword = ChkFormStr(Request("so"))
	msql="Select * from product where isdel=0 and passed=1 "
	If cateid<>0 Then
		'msql=msql&" and cateid="&cateid&""
		msql=msql&" and cateid in ("&sonid&")"
	End If
	
	If Keyword<>"" Then
		msql=msql&" and (title like '%"&Keyword&"%' or content like '%"&Keyword&"%')"
	End If
	
	msql=msql&" Order By px desc,posttime Desc,ID Desc"
	Set mypage=new zh_Showpage
	PSize=8
	mypage.getconn=Conn	
	mypage.getsql=msql
	mypage.pagesize=PSize	
	set NewsListRs=mypage.getrs()
	
	If 	NewsListRs.Eof Then
		Response.Write "<br />&nbsp;&nbsp;&nbsp;没有找到信息!"
	Else
			Response.Write ("<div class=""imgpic""><ul>")&vbcrlf
		For TrNum=1 To mypage.pagesize
			If NewsListRs.Eof Then Exit For
			
	
%>
       <li>
       <div class="pro-pic">
       <a href="goodshow.asp?id=<%=NewsListRs("id")%>"><img src="<%=NewsListRs("defaultpicurl")%>" /></a>
       </div>
              <p><a href1="goodshow.asp?id=<%=NewsListRs("id")%>"><%=NewsListRs("title")%></a></p>
            </li>
            
       
<%
		
		
			NewsListRs.MoveNext
		Next
			Response.Write("<div class=""clear""></div></div><div class=""dotline""></div>")&vbcrlf
		Set NewsListRs = Nothing
		If TrNum >=1 Then
			Response.Write(""&mypage.showpage()&"")
		End If
	End If

End Function



Function ShowPics()
	TrNum=0
	cateid = strToNum(Request("id"))	
	Keyword = ChkFormStr(Request("so"))
	msql="Select id,title,posttime,color,defaultpicurl,content,hits,staticUrl,dynamicUrl from news_c where isdel=0 and passed=1 "
	If cateid<>0 Then
		'msql=msql&" and cateid="&cateid&""
		msql=msql&" and cateid in ("&sonid&")"
	End If
	
	If Keyword<>"" Then
		msql=msql&" and (title like '%"&Keyword&"%' or content like '%"&Keyword&"%')"
	End If
	
	msql=msql&" Order By px desc,posttime Desc,ID Desc"
	Set mypage=new zh_Showpage
	PSize=8
	mypage.getconn=Conn	
	mypage.getsql=msql
	mypage.pagesize=PSize	
	set NewsListRs=mypage.getrs()
	
	If 	NewsListRs.Eof Then
		Response.Write "<br />&nbsp;&nbsp;&nbsp;没有找到信息!"
	Else
			Response.Write ("<div class=""imgpic""><ul>")&vbcrlf
		For TrNum=1 To mypage.pagesize
			If NewsListRs.Eof Then Exit For
			
	
%>
       <li>
       <div class="pro-pic">
       <a href="<%=infoURL(NewsListRs("staticUrl"),NewsListRs("dynamicUrl"),supportHtml)%>"><img src="<%=NewsListRs("defaultpicurl")%>" /></a>
       </div>
              <p><a href1="<%=infoURL(NewsListRs("staticUrl"),NewsListRs("dynamicUrl"),supportHtml)%>"><%=NewsListRs("title")%></a></p>
            </li>
            
       
<%
		
		
			NewsListRs.MoveNext
		Next
			Response.Write("<div class=""clear""></div></div><div class=""dotline""></div>")&vbcrlf
		Set NewsListRs = Nothing
		If TrNum >=1 Then
			Response.Write(""&mypage.showpage()&"")
		End If
	End If

End Function




Function ShowPicNews()
	TrNum=0
	cateid = strToNum(Request("id"))	
	Keyword = ChkFormStr(Request("so"))
	msql="Select id,title,posttime,color,defaultpicurl,content,hits,staticUrl,dynamicUrl from news_c where isdel=0 and passed=1 "
	If cateid<>0 Then
		'msql=msql&" and cateid="&cateid&""
		msql=msql&" and cateid in ("&sonid&")"
	End If
	
	If Keyword<>"" Then
		msql=msql&" and (title like '%"&Keyword&"%' or content like '%"&Keyword&"%')"
	End If
	
	msql=msql&" Order By px desc,posttime Desc,ID Desc"
	Set mypage=new zh_Showpage
	PSize=5
	mypage.getconn=Conn	
	mypage.getsql=msql
	mypage.pagesize=PSize	
	set NewsListRs=mypage.getrs()
	
	If 	NewsListRs.Eof Then
		Response.Write "<br />&nbsp;&nbsp;&nbsp;没有找到信息!"
	Else
			Response.Write ("<div class=""picnewslist""><ul>")&vbcrlf
		For TrNum=1 To mypage.pagesize
			If NewsListRs.Eof Then Exit For
			
	
%>
       <li>
       <div class="pic-l">
       <a href="<%=infoURL(NewsListRs("staticUrl"),NewsListRs("dynamicUrl"),supportHtml)%>"><img src="<%=NewsListRs("defaultpicurl")%>" /></a>
       </div>
       <div class="txt-r">
       <div class="txt-rt">
       	<div class="time"><%=formatdate(NewsListRs("posttime"),2)%></div>
       	<div class="tit"><a href="<%=infoURL(NewsListRs("staticUrl"),NewsListRs("dynamicUrl"),supportHtml)%>"><%=NewsListRs("title")%></a></div>
       </div>
              <div class="con"><%=leftstr( clearallhtml(NewsListRs("content")),300)%> <a href="<%=infoURL(NewsListRs("staticUrl"),NewsListRs("dynamicUrl"),supportHtml)%>">浏览全文</a></div>
              </div>
            </li>
            
       
<%
		
		
			NewsListRs.MoveNext
		Next
			Response.Write("<div class=""clear""></div></div><div class=""dotline""></div>")&vbcrlf
		Set NewsListRs = Nothing
		If TrNum >=1 Then
			Response.Write(""&mypage.showpage()&"")
		End If
	End If

End Function



'新闻列表调用
'调用方法：<ul>< % ShowNews() % ></ul>
Function ShowNews2()
	TrNum=0
	cateid = strToNum(Request("id"))	
	Keyword = ChkFormStr(Request("so"))
	msql="Select * from news_c where  isdel=0 and passed=True "
	If cateid<>0 Then
		msql=msql&" and cateid="&cateid&""
	End If
	
	If Keyword<>"" Then
		msql=msql&" and (title like '%"&Keyword&"%' or content like '%"&Keyword&"%')"
	End If
	
	msql=msql&" Order By px desc,posttime Desc,ID Desc"
	'response.write msql
	Set mypage=new zh_Showpage
	PSize=12
	mypage.getconn=Conn	
	mypage.getsql=msql
	mypage.pagesize=PSize	
	set NewsListRs=mypage.getrs()
	
	If 	NewsListRs.Eof Then
		Response.Write "<br />&nbsp;&nbsp;&nbsp;没有找到信息!"
	Else
			Response.Write ("<ul>")&vbcrlf
		For TrNum=1 To mypage.pagesize
			If NewsListRs.Eof Then Exit For
			
	
	Response.Write("<li><div class=""titno"">"&TrNum &"</div>")&vbcrlf
	Response.Write("<div  class=""fr""><a href="""&infoURL(NewsListRs("staticUrl"),NewsListRs("dynamicUrl"),supportHtml)&"""><img src=""/images/down.jpg""></a></div>")&vbcrlf
	Response.Write("<div class=""nlist_title"">")
	response.write("<a href="""&infoURL(NewsListRs("staticUrl"),NewsListRs("dynamicUrl"),supportHtml)&""" class=""newslist_t"">")
	response.write (leftstr(NewsListRs("title"),80)&"</a></div>")&vbcrlf
	
	Response.Write("</li>")&vbcrlf
		
		
			NewsListRs.MoveNext
		Next
			Response.Write("</ul>")&vbcrlf
		Set NewsListRs = Nothing
		If TrNum >=1 Then
			Response.Write(""&mypage.showpage()&"")
		End If
	End If

End Function

			Function ShowNews21(cateid)
			
			
			company_str="<div class=""pcontent greybg"">  <div class=""main"">  <div class=""h25""></div>  <h2>文档列表</h2>"
				TrNum=0
				
				Keyword = ChkFormStr(Request("so"))
				msql="Select * from news_c where  isdel=0 and passed=True "
				If cateid<>0 Then
					msql=msql&" and cateid="&cateid&""
				End If
				
				If Keyword<>"" Then
					msql=msql&" and (title like '%"&Keyword&"%' or content like '%"&Keyword&"%')"
				End If
				
				msql=msql&" Order By px desc,posttime Desc,ID Desc"
				'response.write msql
				Set mypage=new zh_Showpage
				PSize=12
				mypage.getconn=Conn	
				mypage.getsql=msql
				mypage.pagesize=PSize	
				set NewsListRs=mypage.getrs()
				
				If 	NewsListRs.Eof Then
					company_str =company_str & "<br />&nbsp;&nbsp;&nbsp;没有找到信息!"
				Else
						company_str =company_str & ("<ul>")&vbcrlf
					For TrNum=1 To mypage.pagesize
						If NewsListRs.Eof Then Exit For
						
				
				company_str =company_str &("<li><div class=""titno"">"&TrNum &"</div>")&vbcrlf
				company_str =company_str &("<div  class=""fr""><a href="""&infoURL(NewsListRs("staticUrl"),NewsListRs("dynamicUrl"),supportHtml)&"""><img src=""/images/down.jpg""></a></div>")&vbcrlf
				company_str =company_str &("<div class=""nlist_title"">")
				company_str =company_str &("<a href="""&infoURL(NewsListRs("staticUrl"),NewsListRs("dynamicUrl"),supportHtml)&""" class=""newslist_t"">")
				company_str =company_str & (leftstr(NewsListRs("title"),80)&"</a></div>")&vbcrlf
				
				company_str =company_str &("</li>")&vbcrlf
					
					
						NewsListRs.MoveNext
					Next
						company_str =company_str &("</ul>")&vbcrlf
					Set NewsListRs = Nothing
					If TrNum >=1 Then
						company_str =company_str &(""&mypage.showpage()&"")
					End If
				End If
				company_str=company_str&"</div></div>"
			ShowNews21 =company_str
			End Function


'新闻列表调用
'调用方法：<ul>< % ShowNews() % ></ul>
Function ShowSearch()
	TrNum=0
	cateid = strToNum(Request("id"))	
	stype=strToNum(Request("stype"))	
	Keyword = ChkFormStr(Request("so"))
	'msql="Select * from (SELECT cateid as id,catename as title,content,'2013/01/01' as posttime, 1 as ntype from category UNION (SELECT  id, title,content, posttime ,0 as ntype from news where isdel=0 and passed=True)) g where 1=1 "
	msql="Select * from  (SELECT  id, title,content, posttime ,0 as ntype from news where isdel=0 and passed=True) g where 1=1 "
	'msql="Select * from (SELECT cateid as id,catename as title,content,'2013/01/01' as posttime, 1 as ntype from category ) g where 1=1 "
	If cateid<>0 Then
		'msql=msql&" and cateid="&cateid&""
	End If
	
	If Keyword<>"" Then
		if stype=0 then
		msql=msql&" and (title like '%"&Keyword&"%' )"
		else
		msql=msql&" and (title like '%"&Keyword&"%' or  content like '%"&Keyword&"%')"
		end if
	End If
	
	msql=msql&" Order by posttime Desc,ID Desc"
	'response.write msql
	Set mypage=new zh_Showpage
	PSize=10
	mypage.getconn=Conn	
	mypage.getsql=msql
	mypage.pagesize=PSize	
	set NewsListRs=mypage.getrs()
	
	If 	NewsListRs.Eof Then
		Response.Write "<br />&nbsp;&nbsp;&nbsp;没有找到信息!"
	Else
		response.write 	"<div class=""seanum"">"
		response.write "共检索到相关结果"&NewsListRs.pagecount&"页，共计"&NewsListRs.recordcount&"条信息"
		response.write "</div><div class=""searesult"">"
		Response.Write ("<ul>")&vbcrlf
		For TrNum=1 To mypage.pagesize
	If NewsListRs.Eof Then Exit For
	if	NewsListRs("ntype")=1 then
		linkurl= "company.asp?id="&NewsListRs("id")
		posttime=""
	else
		linkurl="ReadNews.asp?id="&NewsListRs("id")	
		posttime=formatdate(NewsListRs("posttime"),2)
	end if	
	
	Response.Write("<li>")&vbcrlf
	response.write "<div class=""sr-tit""><a href="""&linkurl&""" >"&replace(NewsListRs("title"),Keyword,"<strong>"&Keyword&"</strong>")&"</a></div>"
	response.write "<div class=""sr-intro"">"&leftstr( clearallhtml(NewsListRs("content")),300)&"</div>"
	response.write "<div class=""sr-time"">发布时间："&formatdate(NewsListRs("posttime"),2)&"</div>"
	response.write "</li>"
	NewsListRs.MoveNext
	Next
	Response.Write("</ul></div>")&vbcrlf
		Set NewsListRs = Nothing
		If TrNum >=1 Then
			Response.Write(""&mypage.showpage()&"")
		End If
	End If

End Function


Function showPUBLISH()
	TrNum=0
	cateid = strToNum(Request("id"))	
	Keyword = ChkFormStr(Request("so"))
	msql="Select * from news_c where  isdel=0 and passed=True "
	If cateid<>0 Then
		msql=msql&" and cateid="&cateid&""
	End If
	
	If Keyword<>"" Then
		msql=msql&" and (title like '%"&Keyword&"%' or content like '%"&Keyword&"%')"
	End If
	
	msql=msql&" Order By px desc,posttime Desc,ID Desc"
	'response.write msql
	Set mypage=new zh_Showpage
	PSize=4
	mypage.getconn=Conn	
	mypage.getsql=msql
	mypage.pagesize=PSize	
	set NewsListRs=mypage.getrs()
	
	If 	NewsListRs.Eof Then
		Response.Write "<br />&nbsp;&nbsp;&nbsp;没有找到信息!"
	Else
			Response.Write ("<div class=""zzll-c2""><ul>")&vbcrlf
		For TrNum=1 To mypage.pagesize
			If NewsListRs.Eof Then Exit For
			
	
	%>
    <li> <div class="zzll-c2-zuo">
 <div class="zzll-c2-tu"><img src="<%=NewsListRs("defaultpicurl")%>" width="102" height="136" /></div>
 <div class="zzll-c2-tu-title"><%=NewsListRs("title")%></div></div>
 <div class="zzll-c2-c">
 <div class="zzll-c2-c-c"><%=leftstr( clearallhtml(NewsListRs("content")),300)%></div>
<div class="zzll-c2-ckxq"><a href="<%=infoURL(NewsListRs("staticUrl"),NewsListRs("dynamicUrl"),supportHtml)%>">查看详情》</a></div>
 </div>
 </li>
 <%
		
		
			NewsListRs.MoveNext
		Next
		response.Write("<div class=""clear""></div>")
			Response.Write("</div></ul>")&vbcrlf
		Set NewsListRs = Nothing
		If TrNum >=1 Then
			Response.Write(""&mypage.showpage()&"")
		End If
	End If

End Function


'=================================================
'过程名: ShowPath
'作  用: 显示当前位置
'参  数: t-类型(0-新闻列表 1-产品列表)
'=================================================
Sub ShowPath(t)
	dim sPath
	sPath="<a href=""index.asp"">首页</a>"
	Select Case t
		Case 0
			BigClassID = strToNum(Request("pid"))
			SmallClassID = strToNum(Request("id"))
			If BigClassID<>0 Then
				Set PathRs=Conn.Execute("Select BigClassName From BigClass_New Where BigClassID="&BigClassID&"")
				If Not PathRs.Eof Then
					sPath=sPath&"&nbsp;&gt;&nbsp;<a href=""News.asp?pid="&BigClassID&""">"&PathRs("BigClassName")&"</a>"
				End If
				PathRs.Close
			End If
			If SmallClassID<>0 Then
				Set PathRs=Conn.Execute("Select BigClassID,BigClassName,SmallClassName From SmallClass_New Where SmallClassID="&SmallClassID&"")
				If Not PathRs.Eof Then
					sPath=sPath&"&nbsp;&gt;&nbsp;<a href=""News.asp?pid="&PathRs("BigClassID")&"&id="&SmallClassID&""">"&PathRs("SmallClassName")&"</a>"
				End If
				PathRs.Close
			End If
			If BigClassID=0 And SmallClassID=0 Then
				sPath=sPath&"&nbsp;&gt;&nbsp;<a href=""News.asp"">蓝迪斯新闻</a>"
			End If
			
		Case 1
			sPath=sPath&"&nbsp;&gt;&nbsp;<a href=""product.asp"">产品</a>"
			BigClassID = strToNum(Request("pid"))
			SmallClassID = strToNum(Request("id"))
			SmallClassID3 = strToNum(Request("smllid"))
			If BigClassID<>0 Then
				Set PathRs=Conn.Execute("Select BigClassName From BigClass Where BigClassID="&BigClassID&"")
				If Not PathRs.Eof Then
					sPath=sPath&"&nbsp;&gt;&nbsp;<a href=""Product.asp?pid="&BigClassID&""">"&PathRs("BigClassName")&"</a>"
				End If
				PathRs.Close
			End If
			If SmallClassID<>0 Then
				Set PathRs=Conn.Execute("Select BigClassID,BigClassName,SmallClassName From SmallClass Where SmallClassID="&SmallClassID&"")
				If Not PathRs.Eof Then
					sPath=sPath&"&nbsp;&gt;&nbsp;<a href=""Product.asp?pid="&PathRs("BigClassID")&"&id="&SmallClassID&""">"&PathRs("SmallClassName")&"</a>"
				End If
				PathRs.Close
			End If
			If SmallClassID3<>0 Then
				Set PathRs=Conn.Execute("Select BigClassID,BigClassName,SmallClassName From SmallClass3 Where SmallClassID="&SmallClassID3&"")
				If Not PathRs.Eof Then
					sPath=sPath&"&nbsp;&gt;&nbsp;<a href=""Product.asp?pid="&BigClassID&"&id="&PathRs("BigClassID")&"&smllid="&SmallClassID3&""">"&PathRs("SmallClassName")&"</a>"
				End If
				PathRs.Close
			End If
			If BigClassID=0 And SmallClassID=0 and SmallClassID3=0 Then
				sPath=sPath&"&nbsp;&gt;&nbsp;<a href=""Product.asp"">产品系列</a>"
			End If
		
	End Select
	Response.Write(sPath)
End Sub



'网站广告调用
'参数说明 catalogId -广告类别
Sub Advertisement(catalogId)
	Set adRs=server.createobject("adodb.recordset")
	adsql="select top 1 * from [ad] where catalogId="&catalogId&" order by id desc"
	adRs.open adsql,conn,1,1
	if not adrs.eof then
	adType=adrs("adType")
	photo=adrs("photo")
	linkUrl=adrs("linkUrl")
	imgW=adrs("imgW")
	imgH=adrs("imgH")
	title=adrs("title")
	Select Case adType
		case 1	'图片
		response.Write "<a href="""&linkUrl&"""><img src=""../"&photo&""" width="""&imgW&""" height="""&imgH&""" border=0/></a>"
		case 2 'Flash
	%>
<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="<%=imgW%>" height="<%=imgH%>">
  <param name="movie" value="../<%=photo%>" />
  <param name="quality" value="high" />
  <embed src="../<%=photo%>" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="<%=imgW%>" height="<%=imgH%>"></embed>
</object>
<%
	End Select
	end if

	adrs.close
	set adrs=nothing
End Sub



Function ShowMessages()
	TrNum=0
	BigClass = strToNum(Request("pid"))
	'SmallClass = strToNum(Request("id"))
	Keyword = ChkFormStr(Request("so"))
	msql="Select * from liuyan where tgsh=True"
	If BigClass<>0 Then
		msql=msql&" and huifupeople="&BigClass&""
	End If
	If SmallClass<>0 Then
		msql=msql&" and SmallClass="&SmallClass&""
	End If
	If Keyword<>"" Then
		msql=msql&" and (B_title like '%"&Keyword&"%' or b_dom like '%"&Keyword&"%')"
	End If
	msql=msql&" Order By id desc"
	
	'response.write msql
	Set mypage=new zh_Showpage
	PSize=10
	mypage.getconn=Conn	
	mypage.getsql=msql
	mypage.pagesize=PSize	
	set NewsListRs=mypage.getrs()
	
	If 	NewsListRs.Eof Then
		Response.Write "<br />&nbsp;&nbsp;&nbsp;没有找到信息!"
	Else
			'Response.Write ("<table width=""793"" border=""0"" cellspacing=""0"" cellpadding=""0"" class=""mtop"">")&vbcrlf
			response.Write("<ul>")
		For TrNum=1 To mypage.pagesize
			If NewsListRs.Eof Then Exit For

	if NewsListRs("b_hui")<>"" then		
ask_r="<strong>管理员回复</strong>："&NewsListRs("b_hui")
if istj="1" then  ask_r=ask_r&"  <a href='javascript:reply("&NewsListRs("id")&")'>修改回复</a>" 
else
ask_r=""
	if istj="1" then 
		ask_r= "<a href='javascript:reply("&NewsListRs("id")&")'>我来回复</a>" 
		end if
		end if
if istj="1" then 		

end if
Response.Write("<li><div class='ask_r'><div class='ask_title'><strong>"&NewsListRs("B_name")&"</strong> 于<span class='times'>"&NewsListRs("b_date")&"</span>发表了留言：</div><div class='ask_content'>"&NewsListRs("b_dom")&"</div>")
response.write "<div class='ask_re'>"&ask_r&"</div>"
'response.write "<div class='ask_re'>"&ask_r&"</div><div class='ask_ps'>如果您还有其他疑问，可拨打重庆新桥医院眼科 咨询电话：<span>023－68755114</span><br/>医院地址：重庆市沙坪坝区新桥正街 乘871、219和201路车可以直接到达新桥医院。</div>"
Response.Write("</div><div class='clear'></div></li>")&vbcrlf
			
			NewsListRs.MoveNext
		Next
			Response.Write("<div class='clear'></div></ul>")&vbcrlf
		Set NewsListRs = Nothing
		If TrNum >=1 Then
			Response.Write(""&mypage.showpage()&"")
			'Call showpage("news.asp",8,PSize,true,true,"个")
		End If
	End If

End Function


'=================================================
'过程名：ShowUserLogin
'作  用：显示用户登录表单
'参  数：无
'=================================================
sub ShowUserLogin()
	dim strLogin
	If Request.Cookies("mx_UserName")="" Or Request.Cookies("mx_UserName")=Empty Or Request.Cookies("mx_UserName")=Null Then
    	strLogin= "<form id=""mx_UserLogin"" name=""mx_UserLogin"" method=""post"" action=""User_Login.asp""  onSubmit=""return CheckUserForm();"">"
		strLogin=strLogin & "<table width=""100%"" border=""0"" cellpadding=""0"" cellspacing=""0"">"
        strLogin=strLogin & "<tr>"
		strLogin=strLogin & "	<td width=""18%"" height=""25"" align=""center"">用户名:</td>"
		strLogin=strLogin & "	<td width=""82%"" align=""left""><input name=""mx_UserName"" type=""text"" id=""mx_UserName""  size=""12"" /></td>"
		strLogin=strLogin & "</tr>"
		strLogin=strLogin & "<tr>"
		strLogin=strLogin & "	<td height=""25"" align=""center"">密&nbsp; 码:</td>"
		strLogin=strLogin & "	<td align=""left""><input name=""mx_Password"" type=""text"" id=""mx_Password""  size=""12"" /></td>"
		strLogin=strLogin & "</tr>"
		strLogin=strLogin & "<tr>"
		strLogin=strLogin & "	<td height=""25"">&nbsp;</td>"
		strLogin=strLogin & "	<td align=""left""><input name=""登录"" type=""submit"" id=""登录"" value=""登录"" />&nbsp;<a href=""user_reg.asp"">用户注册</a></td>"
		strLogin=strLogin & "</tr>"    
        strLogin=strLogin & "</table>"
		response.write strLogin
	Else 
		response.write "<div align='left'><div>欢迎您！"&Request.Cookies("mx_UserName")&"</div>"
		Response.Write "<div><a href='User_Index.asp'><b>会员管理中心</b></a></div>"
		response.Write "<div align='right' style='padding-right:20px;'><a href='User_Out.asp'>退出</a></div></div>"
	end if
end sub
'投票
sub ShowVote()
	dim sqlVote,rsVote,i
	sqlVote="select top 1 * from Vote where IsSelected=True"
	Set rsVote= Server.CreateObject("ADODB.Recordset")
	rsVote.open sqlVote,conn,1,1
	if rsVote.bof and rsVote.eof then 
		response.Write "&nbsp;没有任何调查"
	else
		response.write "<form name='VoteForm' method='post' action='vote.asp' target='_blank'>"
		response.write "&nbsp;&nbsp;<font style='line-height:150%'>" & rsVote("Title") & "</font><br>"
		if rsVote("VoteType")="Single" then
			for i=1 to 8
				if trim(rsVote("Select" & i) & "")="" then exit for
				response.Write "&nbsp;&nbsp;<input type='radio' name='VoteOption' value='" & i & "'>" & rsVote("Select" & i) & "<br>"
			next
		else
			for i=1 to 8
				if trim(rsVote("Select" & i) & "")="" then exit for
				response.Write "&nbsp;&nbsp;<input type='checkbox' name='VoteOption' value='" & i & "'>" & rsVote("Select" & i) & "<br>"
			next
		end if
		response.write "<br><input name='VoteType' type='hidden'value='" & rsVote("VoteType") & "'>"
		response.write "<input name='Action' type='hidden' value='Vote'>"
		response.write "<input name='ID' type='hidden' value='" & rsVote("ID") & "'>"
		response.write "<div align='center'>"
		response.write "<a href='javascript:VoteForm.submit();'><img src='images/vote_submit.jpg' width='65' height='21' border='0'></a>&nbsp;&nbsp;"
        response.write "<a href='Vote.asp?Action=Show&ID="&rsVote("ID")&"' target='_blank'><img src='images/vote_look.jpg' width='65' height='21' border='0'></a>"
		response.write "</div></form>"
	end if
	rsVote.close
	set rsVote=nothing
end sub

Function IsObjInstalled(strClassString)
	On Error Resume Next
	IsObjInstalled = False
	Err = 0
	Dim xTestObj
	Set xTestObj = Server.CreateObject(strClassString)
	If 0 = Err Then IsObjInstalled = True
	Set xTestObj = Nothing
	Err = 0
End Function

'==================Jmail发送邮件=====================
Function Send_Email(smtpHost,smtpUser,smtpPass,mailTo,FromName,subject,content)
if not IsObjInstalled("JMAIL.Message") then
	exit function
end if
Set jmail = Server.CreateObject("JMAIL.Message")
jmail.silent = true
jmail.logging = true
jmail.Charset = "utf-8"
jmail.ContentType = "text/html"
jmail.AddRecipient mailTo
jmail.From = smtpUser
jmail.FromName = FromName
jmail.Subject = subject
jmail.Body = content
jmail.Priority = 1  '优先级 1为最快 
jmail.MailServerUserName = smtpUser
jmail.MailServerPassword = smtpPass
jmail.Send(smtpHost)
jmail.Close()
End Function

'smtp为邮件服务器名
'user为smtp邮件服务器上的邮件地址
'pwd为smtp邮件服务器上的邮件的密码
'sendto为要发送的邮件地址
'from发件人名
'subject为主题
'body为邮件内容
function sendmail(smtp,sendto,from,user,pwd,subject,body)
Set jmail = Server.CreateObject("JMAIL.Message") '建立发送邮件的对象 
jmail.silent = true '屏蔽例外错误，返回FALSE跟TRUE两值j 
jmail.logging = true '启用邮件日志 
'加上如下语句，否则还有可能出现乱码的可能性： 
jmail.Charset = "GB2312" '邮件的文字编码为国标 
jmail.ContentTransferEncoding = "base64"   
jmail.Encoding = "base64"   
jmail.ISOEncodeHeaders = false

jmail.ContentType = "text/html" '邮件的格式为HTML格式 -- 有此句则发送附件时为乱码
jmail.AddRecipient sendto '邮件收件人的地址 
jmail.From = from '发件人的E-MAIL地址 
jmail.MailServerUserName = user '登录邮件服务器所需的用户名 
jmail.MailServerPassword = pwd '登录邮件服务器所需的密码 
jmail.Subject = subject '邮件的标题 
jmail.Body = body '邮件的内容 
'jmail.AddAttachment Server.MapPath("login.gif")'附件--不能有此句:jmail.ContentType = "text/html"
'Jmail.AddAttachment Server.MapPath("b.rar")      '否则附件会变成乱码
jmail.Priority = 3 '邮件的紧急程序，1 为最快，5 为最慢， 3 为默认值 
if jmail.send(smtp)=false then'执行邮件发送（通过邮件服务器地址） 
    sendmail=0
else
    sendmail=1
end if
jmail.Close
end Function
%>
