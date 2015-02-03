<%
function wrongMsg(str)
	response.write str &"<a href=""javascript:history.back();"">返回</a>"
	response.End()
end function

Function GetLocationURL() 
Dim Url 
Dim ServerPort,ServerName,ScriptName,QueryString 
ServerName = Request.ServerVariables("SERVER_NAME") 
ServerPort = Request.ServerVariables("SERVER_PORT") 
ScriptName = Request.ServerVariables("SCRIPT_NAME") 
'QueryString = Request.ServerVariables("QUERY_STRING") 
Url="http://"&ServerName 
If ServerPort <> "80" Then Url = Url & ":" & ServerPort 
Url=Url&ScriptName 
If QueryString <>"" Then Url=Url&"?"& QueryString 
GetLocationURL=Url 
End Function 

Function LeftStr(StrValue,NumValue)
 Dim nStr,a,i
 for i=1 to Len(StrValue)
  a=Mid(StrValue,i,1)
  if Asc(a)<0 then
   nStr=nStr+2
  else
   nStr=nStr+1
  end if
  LeftStr=LeftStr&a

  if nStr>=CInt(NumValue) then
  if LeftStr<>StrValue then LeftStr=LeftStr&"…"
   Exit Function
   end if
 next
   
End Function

Function ResizePath(DefaultPicUrl,s)
	te= InStrRev(DefaultPicUrl,".")	
	ImageType=Mid(DefaultPicUrl,te,len(DefaultPicUrl)-te+1)
	ResizePath= Replace(DefaultPicUrl,ImageType,"_"&s&ImageType)
End function
'Thumb 生成缩略图函数
'DefaultPicUrl 源图路径
'sname 缩略图名称加后缀，缩略图与源图 路径相同，名称后面加一后缀 _sname
'width height 生成缩略图的尺寸 不等比例则裁剪 
'函数返回缩略图的地址
function Thumb(DefaultPicUrl,sname,width,height)
	url2= ResizePath(DefaultPicUrl,sname)	
	Set ap=new AspJpeg	
	ap.MathPathFrom=server.mappath(DefaultPicUrl)	
	ap.MathPathTo=server.mappath(url2)
	ap.Width=width
	ap.Height=height
	t=ap.image_resize()	
	Thumb= url2	
end function

'ThumbUrl 供前台引用缩略图的函数  首次调用缩略图会自动生成，以后则直接显示存在的缩略图 无关后台 数据库等操作
'width height 生成缩略图的尺寸 不等比例则裁剪 
'函数返回缩略图的地址
function ThumbUrl(DefaultPicUrl,width,height)
	
	if supportAspjpeg=1 then

	ThumbUrl = "/thumb.asp?file="&DefaultPicUrl& "&amp;width=" &width& "&amp;height=" & height	
	else
	ThumbUrl =DefaultPicUrl
	end if

end function

Function htmlspecialchars(str)
	str = Replace(str, "&", "&amp;")
	str = Replace(str, "<", "&lt;")
	str = Replace(str, ">", "&gt;")
	str = Replace(str, """", "&quot;")
	htmlspecialchars = str
End Function

Function alltrim(str)
	str = Replace(str, " ", "")
	str= replace(str,chr(9),"")
	str= replace(str,chr(13),"")	

	alltrim = str
End Function


Function strToNum(str)
         '将字符串转换为数字
		 str = sqlbad(str) 
		 if len(str)>0 and isnumeric(str) then
		    retStr = clng(str)
		 else
		    retStr = 0
		 end if
		 strToNum = retStr
End Function

Function CheckNum(ByVal CheckStr)
	CheckStr = sqlbad(Trim(CheckStr))
	If CheckNum = "" Or Not IsNumeric(CheckStr) Or Len(CheckStr) > 10 Then
		CheckNum = 0
		Exit Function
	Else
		If CLng(Left(CheckStr,9)) > 214748367 Then
			CheckNum = 0
			Exit Function
		ElseIf CLng(Left(CheckStr,9)) = 214748367 And CLng(Right(CheckStr,1)) > 7 Then
			CheckNum = 0
			Exit Function
		Else
			If CheckStr < 0 Then CheckStr = 0
			CheckNum = CLng(CheckStr)
		End If
	End If
End Function

'判断是否为空
Function CheckNull(str)
	str=trim(str)
	If len(str)=0 or isempty(str) or isnull(str) Then
		CheckNull=""
	Else
		CheckNull=str
	End If
End Function

'**************************************************
'函数名：strLength
'作  用：求字符串长度。汉字算两个字符，英文算一个字符。
'参  数：str  ----要求长度的字符串
'返回值：字符串长度
'**************************************************
Function strLength(str)
	'on error resume next
	dim WINNT_CHINESE
	WINNT_CHINESE    = (len("中国")=2)
	if WINNT_CHINESE then
        dim l,t,c
        dim i
        l=len(str)
        t=l
        for i=1 to l
        	c=asc(mid(str,i,1))
            if c<0 then c=c+65536
            if c>255 then
                t=t+1
            end if
        next
        strLength=t
    else 
        strLength=len(str)
    end if
    if err.number<>0 then err.clear
End Function

'*************************************************
'函数名：CutStr
'作  用：截字符串，汉字一个算两个字符，英文算一个字符
'参  数：str   ----原字符串
'       strlen ----截取长度
'返回值：截取后的字符串
'*************************************************
Function CutStr(str,strlen)
	if str="" then
		CutStr=""
		exit function
	end if
	dim l,t,c, i
	str=replace(replace(replace(replace(str,"&nbsp;"," "),"&quot;",chr(34)),"&gt;",">"),"&lt;","<")
	l=len(str)
	t=0
	for i=1 to l
		c=Abs(Asc(Mid(str,i,1)))
		if c>255 then
			t=t+2
		else
			t=t+1
		end if
		if t>=strlen then
			CutStr=left(str,i)
			exit for
		else
			CutStr=str
		end if
	next
	CutStr=replace(replace(replace(replace(CutStr," ","&nbsp;"),chr(34),"&quot;"),">","&gt;"),"<","&lt;")
End Function

'函数名 ：ShowDate
'作用：改变日期形式
'参数：sds_date	---要改变的日期
'		n		---形式	1 为X年X月X日	2 为X-X-X
'返回值：改变后的字符串
Function ShowDate(sds_date,n)
         '只返回日期形式
		 sds_rt = ""
		 If isdate(sds_date) then
		    sds_date = cdate(sds_date)
			Select Case n
				Case 1
		    		sds_rt = year(sds_date) & "年" & Right("0"&month(sds_date),2) & "月" & Right("0"&day(sds_date),2) & "日"
				Case 2
					sds_rt = year(sds_date) & "-" & Right("0"&month(sds_date),2) & "-" & Right("0"&day(sds_date),2)
			End Select
		 End If
		 ShowDate = sds_rt
End Function

'函数名称：RemoveHTML()
'类    型：方法
'功能描述：过滤字符串中的HTML代码标记，即清除<>间的代码。
'参数说明：strHTML：待过滤字符串。
'调用形式：RemoveHTML(strHTML)
'返 回 值：字符串型，过滤后的字符串。

Function RemoveHTML(strHTML) 
	Dim objRegExp, Match, Matches 
	Set objRegExp = New Regexp 
	objRegExp.IgnoreCase = True 
	objRegExp.Global = True 
	'取闭合的<> 
	objRegExp.Pattern = "<.+?>" 
	'进行匹配 
	Set Matches = objRegExp.Execute(strHTML) 
	' 遍历匹配集合，并替换掉匹配的项目 
	For Each Match in Matches 
		strHtml=Replace(strHTML,Match.Value,"") 
	Next 
	RemoveHTML=strHTML 
	Set objRegExp = Nothing 
End Function

function clearAllHtml(str)
	if isnull(str) then str=""
	rString = ""
	set re =  New RegExp
	re.Pattern = "<[\/\!]*?[^<>]*?>"
	re.Global = true
	re.IgnoreCase = True
	re.MultiLine = True
	rString = re.Replace(str,"")
	rString = replace(replace(replace(replace(replace(rString,chr(8),""),chr(9),""),chr(10),""),chr(13),""),"　","")
	rString=replace(rString,"&nbsp;","") '增加的
	rString = Replace(rString, ">", "&gt;")
	rString = Replace(rString, "<", "&lt;")
	clearAllHtml = rString 
end function

'=============================================================
'函数名：ChkFormStr
'作  用：过滤表单字符
'参  数：str   ----原字符串
'返回值：过滤后的字符串
'=============================================================
Public Function ChkFormStr(ByVal str)
	Dim fString
	fString = str
	If IsNull(fString) Then
		ChkFormStr = ""
		Exit Function
	End If
	fString = Replace(fString, "'", "&#39;")
	fString = Replace(fString, Chr(34), "&quot;")
	fString = Replace(fString, Chr(13), "")
	fString = Replace(fString, Chr(10), "")
	fString = Replace(fString, Chr(9), "")
	fString = Replace(fString, ">", "&gt;")
	fString = Replace(fString, "<", "&lt;")
	fString = Replace(fString, "%", "％")
	ChkFormStr = Trim(JAPEncode(fString))
End Function

'=============================================================
'过滤表单字符部分,过滤过程
'作用: 只用作检测,不作为写入数据的规范
'示例: If CheckRequest(Str) = "XXX" Then Response.Write "False"
'=============================================================
Public Function CheckRequest(ByVal CheckStr)
	CheckStr = Trim(CheckStr)
	If IsNull(CheckStr) Or CheckStr = "" Then CheckRequest = "" : Exit Function
	CheckStr = Replace(CheckStr, Chr(37), "")
	CheckStr = Replace(CheckStr, Chr(0), "")
	CheckStr = Replace(CheckStr, "&nbsp;", " ")
	CheckStr = Replace(CheckStr, "'", "")
	CheckStr = Replace(CheckStr, "!", "")
	CheckStr = Replace(CheckStr, "]", "")
	CheckStr = Replace(CheckStr, "[", "")
	CheckStr = Replace(CheckStr, ")", "")
	CheckStr = Replace(CheckStr, "(", "")
	CheckStr = Replace(CheckStr, "+", "")
	CheckStr = Replace(CheckStr, "=", "")
	CheckStr = Replace(CheckStr, "%", "")
	CheckStr = Replace(CheckStr, "#", "")
	CheckStr = Replace(CheckStr, "^", "")
	CheckStr = Replace(CheckStr, ";", "")
	CheckStr = Replace(CheckStr, "*", "")
	CheckStr = Replace(CheckStr, "<", "")
	CheckStr = Replace(CheckStr, ">", "")
	CheckStr = Replace(CheckStr, "《", "")
	CheckStr = Replace(CheckStr, "》", "")
	CheckStr = Replace(CheckStr, "|", "")
	CheckStr = Replace(CheckStr, "&", "")
	CheckStr = Replace(CheckStr, "and", "")
	CheckStr = Replace(CheckStr, "chr", "")
	CheckStr = Replace(CheckStr, "@", "")
	CheckStr = Replace(CheckStr, "$", "")
	CheckRequest = CheckStr
End Function

Function Sqlbad(str)
	 '删除信息中错误的字符
	 if len(str)=0 or isempty(str) or isnull(str) then
		sqlbad = ""
	 else
		sqlbad = replace(replace(replace(replace(trim(""&str&""),"'",""),"""","&quot;"),"<","&lt;"),">","&gt;")
	 end if
End Function

'=============================================================
'过滤SQL非法字符部分
'说明: 将字符串中的一些字符去掉后,输出剩余字符串
'作用: 作为写入数据的规范
'示例: XXX = CheckSQL(Str)
'=============================================================
Public Function CheckSQL(CheckStr)
	CheckStr = Trim(CheckStr)
	If IsNull(CheckStr) Or CheckStr = "" Then CheckSQL = "" : Exit Function
	CheckStr = Replace(CheckStr, "%",		vbNullString)
	CheckStr = Replace(CheckStr, "@",		vbNullString)
	CheckStr = Replace(CheckStr, "!",		vbNullString)
	CheckStr = Replace(CheckStr, "^",		vbNullString)
	CheckStr = Replace(CheckStr, "=",		vbNullString)
	CheckStr = Replace(CheckStr, "--",		vbNullString)
	CheckStr = Replace(CheckStr, "$",		vbNullString)
	CheckStr = Replace(CheckStr, "'",		vbNullString)
	CheckStr = Replace(CheckStr, ";",		vbNullString)
	CheckStr = Replace(CheckStr, Chr(0),	vbNullString)
	CheckStr = Replace(CheckStr, Chr(34),	vbNullString)
	CheckSQL = CheckStr
End Function

'********************************************
'函数名：IsValidEmail
'作  用：检查Email地址合法性
'参  数：email ----要检查的Email地址
'返回值：True  ----Email地址合法
'       False ----Email地址不合法
'********************************************

Function IsValidEmail(email)
	dim names, name, i, c
	IsValidEmail = true
	names = Split(email, "@")
	if UBound(names) <> 1 then
	   IsValidEmail = false
	   exit function
	end if
	for each name in names
		if Len(name) <= 0 then
			IsValidEmail = false
    		exit function
		end if
		for i = 1 to Len(name)
		    c = Lcase(Mid(name, i, 1))
			if InStr("abcdefghijklmnopqrstuvwxyz_-.", c) <= 0 and not IsNumeric(c) then
		       IsValidEmail = false
		       exit function
		     end if
	   next
	   if Left(name, 1) = "." or Right(name, 1) = "." then
    	  IsValidEmail = false
	      exit function
	   end if
	next
	if InStr(names(1), ".") <= 0 then
		IsValidEmail = false
	   exit function
	end if
	i = Len(names(1)) - InStrRev(names(1), ".")
	if i <> 2 and i <> 3 then
	   IsValidEmail = false
	   exit function
	end if
	if InStr(email, "..") > 0 then
	   IsValidEmail = false
	end if
End Function

'***************************************************
'函数名：IsObjInstalled
'作  用：检查组件是否已经安装
'参  数：strClassString ----组件名
'返回值：True  ----已经安装
'       False ----没有安装
'***************************************************
Function IsObjInstalled(strClassString)
	'on error resume next
	IsObjInstalled = False
	Err = 0
	Dim xTestObj
	Set xTestObj = Server.CreateObject(strClassString)
	If 0 = Err Then IsObjInstalled = True
	Set xTestObj = Nothing
	Err = 0
End Function

'****************************************************
'函数名：SendMail
'作  用：用Jmail组件发送邮件
'参  数：ServerAddress  ----服务器地址
'        AddRecipient  ----收信人地址
'        Subject       ----主题
'        Body          ----信件内容
'        Sender        ----发信人地址
'****************************************************
Function SendMail(MailServerAddress,AddRecipient,Subject,Body,Sender,MailFrom)
	'on error resume next
	Dim JMail
	Set JMail=Server.CreateObject("JMail.SMTPMail")
	if err then
		SendMail= "<br><li>没有安装JMail组件</li>"
		err.clear
		exit function
	end if
	JMail.Logging=True
	JMail.Charset="utf-8"
	JMail.ContentType = "text/html"
	JMail.ServerAddress=MailServerAddress
	JMail.AddRecipient=AddRecipient
	JMail.Subject=Subject
	JMail.Body=MailBody
	JMail.Sender=Sender
	JMail.From = MailFrom
	JMail.Priority=1
	JMail.Execute 
	Set JMail=nothing 
	if err then 
		SendMail=err.description
		err.clear
	else
		SendMail="OK"
	end if
End Function

'***********************************************
'函数名：JoinChar
'作  用：向地址中加入 ? 或 &
'参  数：strUrl  ----网址
'返回值：加了 ? 或 & 的网址
'pos=InStr(1,"abcdefg","cd") 
'则pos会返回3表示查找到并且位置为第三个字符开始。
'这就是“查找”的实现，而“查找下一个”功能的
'实现就是把当前位置作为起始位置继续查找。
'***********************************************
Function JoinChar(strUrl)
	if strUrl="" then
		JoinChar=""
		exit function
	end if
	if InStr(strUrl,"?")<len(strUrl) then 
		if InStr(strUrl,"?")>1 then
			if InStr(strUrl,"&")<len(strUrl) then 
				JoinChar=strUrl & "&"
			else
				JoinChar=strUrl
			end if
		else
			JoinChar=strUrl & "?"
		end if
	else
		JoinChar=strUrl
	end if
End function

Public Function CheckOuterUrl()
	'On Error Resume Next
	Dim server_v1, server_v2
	server_v1 = Replace(LCase(Trim(Request.ServerVariables("HTTP_REFERER"))), "http://", "")
	server_v2 = LCase(Trim(Request.ServerVariables("SERVER_NAME")))
	If server_v1 <> "" And Left(server_v1, Len(server_v2)) <> server_v2 Then
		CheckOuterUrl = False
	Else
		CheckOuterUrl = True
	End If
End Function
'函数名称：ChkPost
'功能描述：禁止外部提交
'调用方法：ChkPost()
Function ChkPost()
	Dim server_v1,server_v2
	chkpost=False
	server_v1=Cstr(Request.ServerVariables("HTTP_REFERER"))
	server_v2=Cstr(Request.ServerVariables("SERVER_NAME"))
	If mid(server_v1,8,len(server_v2))<>server_v2 Then
		'Call ShowErr("<li>本页面禁止由外部链接<li>请从本站首页进入！",0,"default.asp")
		'Response.Write("<li>本页面禁止由外部链接<li>请从本站首页进入！")
		response.write"<SCRIPT language=JavaScript>alert('本页面禁止由外部链接！');"
		response.write"location.href=""index.asp"";</SCRIPT>"
		response.End
	End If
End Function

'函数名：GetRndPassword
'作  用：获取系统随机密码
'返回值：GetRndPassword -----值
'================================================
Function GetRndPassword(PasswordLen)
	Dim Ran,i,strPassword
	strPassword=""
	For i=1 To PasswordLen
		Randomize
		Ran = CInt(Rnd * 2)
		Randomize
		If Ran = 0 Then
			Ran = CInt(Rnd * 25) + 97
			strPassword =strPassword & UCase(Chr(Ran))
		ElseIf Ran = 1 Then
			Ran = CInt(Rnd * 9)
			strPassword = strPassword & Ran
		ElseIf Ran = 2 Then
			Ran = CInt(Rnd * 25) + 97
			strPassword =strPassword & Chr(Ran)
		End If
	Next
	GetRndPassword=strPassword
End Function

	'================================================
	'函数名：JAPEncode
	'作  用：日文片假名编码
	'参  数：str ----原字符
	'================================================
	Public Function JAPEncode(ByVal str)
		Dim FobWords, i
		'on error resume next
		If IsNull(str) Or Trim(str) = "" Then
			JAPEncode = ""
			Exit Function
		End If
		FobWords = Array(92, 304, 305, 430, 431, 437, 438, 12460, 12461, 12462, 12463, 12464, 12465, 12466, 12467, 12468, 12469, 12470, 12471, 12472, 12473, 12474, 12475, 12476, 12477, 12478, 12479, 12480, 12481, 12482, 12483, 12485, 12486, 12487, 12488, 12489, 12490, 12496, 12497, 12498, 12499, 12500, 12501, 12502, 12503, 12504, 12505, 12506, 12507, 12508, 12509, 12510, 12521, 12532, 12533, 65340)
		For i = 1 To UBound(FobWords, 1)
			If InStr(str, ChrW(FobWords(i))) > 0 Then
				str = Replace(str, ChrW(FobWords(i)), "&#" & FobWords(i) & ";")
			End If
		Next
		JAPEncode = str
	End Function
	'================================================
	'函数名：JAPUncode
	'作  用：日文片假名解码
	'参  数：str ----原字符
	'================================================
	Public Function JAPUncode(ByVal str)
		Dim FobWords, i
		'on error resume next
		If IsNull(str) Or Trim(str) = "" Then
			JAPUncode = ""
			Exit Function
		End If
		FobWords = Array(92, 304, 305, 430, 431, 437, 438, 12460, 12461, 12462, 12463, 12464, 12465, 12466, 12467, 12468, 12469, 12470, 12471, 12472, 12473, 12474, 12475, 12476, 12477, 12478, 12479, 12480, 12481, 12482, 12483, 12485, 12486, 12487, 12488, 12489, 12490, 12496, 12497, 12498, 12499, 12500, 12501, 12502, 12503, 12504, 12505, 12506, 12507, 12508, 12509, 12510, 12521, 12532, 12533, 65340)
		For i = 1 To UBound(FobWords, 1)
			If InStr(str, "&#" & FobWords(i) & ";") > 0 Then
				str = Replace(str, "&#" & FobWords(i) & ";", ChrW(FobWords(i)))
			End If
		Next
		str = Replace(str, Chr(0), "")
		str = Replace(str, "'", "''")
		JAPUncode = str
	End Function

'***********************************************
'过程名：showpage
'作  用：显示“上一页 下一页”等信息
'参  数：sfilename  ----链接地址
'       totalnumber ----总数量
'       maxperpage  ----每页数量
'       ShowTotal   ----是否显示总数量
'       ShowAllPages ---是否用下拉列表显示所有页面以供跳转。有某些页面不能使用，否则会出现JS错误。
'       strUnit     ----计数单位
'***********************************************
sub showpage(sfilename,totalnumber,maxperpage,ShowTotal,ShowAllPages,strUnit)
	dim n, i,strTemp,strUrl
	if totalnumber mod maxperpage=0 then
    	n= totalnumber \ maxperpage
  	else
    	n= totalnumber \ maxperpage+1
  	end if
  	strTemp= "<table class='top_m_txt01' align='center'><form name='showpages' method='Post' action='" & sfilename & "'><tr><td>"
	if ShowTotal=true then 
		strTemp=strTemp & "共 <b>" & totalnumber & "</b> " & strUnit & "&nbsp;&nbsp;"
	end if
	strUrl=JoinChar(sfilename)
  	if CurrentPage<2 then
    		strTemp=strTemp & "首页 上一页&nbsp;"
  	else
    		strTemp=strTemp & "<a href='" & strUrl & "page=1'>首页</a>&nbsp;"
    		strTemp=strTemp & "<a href='" & strUrl & "page=" & (CurrentPage-1) & "'>上一页</a>&nbsp;"
  	end if

  	if n-currentpage<1 then
    		strTemp=strTemp & "下一页 尾页"
  	else
    		strTemp=strTemp & "<a href='" & strUrl & "page=" & (CurrentPage+1) & "'>下一页</a>&nbsp;"
    		strTemp=strTemp & "<a href='" & strUrl & "page=" & n & "'>尾页</a>"
  	end if
   	strTemp=strTemp & "&nbsp;页次：<strong><font color=red>" & CurrentPage & "</font>/" & n & "</strong>页 "
    strTemp=strTemp & "&nbsp;<b>" & maxperpage & "</b>" & strUnit & "/页"
	if ShowAllPages=True then
		strTemp=strTemp & "&nbsp;转到：<select name='page' size='1' onchange='javascript:submit()'>"   
    	for i = 1 to n   
    		strTemp=strTemp & "<option value='" & i & "'"
			if cint(CurrentPage)=cint(i) then strTemp=strTemp & " selected "
			strTemp=strTemp & ">第" & i & "页</option>"   
	    next
		strTemp=strTemp & "</select>"
	end if
	strTemp=strTemp & "</td></tr></form></table>"
	response.write strTemp
end sub


'****************************************************
'过程名：WriteErrMsg
'作  用：显示错误提示信息
'参  数：无
'****************************************************
sub WriteErrMsg()
	dim strErr
	strErr=strErr & "<html><head><title>错误信息</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'>" & vbcrlf
	strErr=strErr & "<link href='style.css' rel='stylesheet' type='text/css'></head><body>" & vbcrlf
	strErr=strErr & "<table cellpadding=2 cellspacing=2 border=0 width=400 class='border' align=center>" & vbcrlf
	strErr=strErr & "  <tr align='center'><td height='20' class='title'><strong>错误信息</strong></td></tr>" & vbcrlf
	strErr=strErr & "  <tr><td height='100' class='tdbg' valign='top'><b>产生错误的可能原因：</b><br>" & errmsg &"</td></tr>" & vbcrlf
	strErr=strErr & "  <tr align='center'><td class='title'><a href='javascript:history.go(-1)'>【返回】</a></td></tr>" & vbcrlf
	strErr=strErr & "</table>" & vbcrlf
	strErr=strErr & "</body></html>" & vbcrlf
	response.write strErr
end sub

'****************************************************
'过程名：WriteSuccessMsg
'作  用：显示成功提示信息
'参  数：无
'****************************************************
sub WriteSuccessMsg(SuccessMsg)
	dim strSuccess
	strSuccess=strSuccess & "<html><head><title>成功信息</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'>" & vbcrlf
	strSuccess=strSuccess & "<link href='style.css' rel='stylesheet' type='text/css'></head><body>" & vbcrlf
	strSuccess=strSuccess & "<table cellpadding=2 cellspacing=2 border=0 width=400 class='border' align=center>" & vbcrlf
	strSuccess=strSuccess & "  <tr align='center'><td height='20' class='title'><strong>恭喜你！</strong></td></tr>" & vbcrlf
	strSuccess=strSuccess & "  <tr><td height='100' class='tdbg' valign='top'><br>" & SuccessMsg &"</td></tr>" & vbcrlf
	strSuccess=strSuccess & "  <tr align='center'><td class='title'><a href='javascript:history.go(-1)'>【返回】</a></td></tr>" & vbcrlf
	strSuccess=strSuccess & "</table>" & vbcrlf
	strSuccess=strSuccess & "</body></html>" & vbcrlf
	response.write strSuccess
end sub

'------------------调用-----------------------
'p=request.QueryString("p")
'str=News_Content
'url="ReadNews.asp?id="&nid&"&"
'set newpage=new AutoPaging
'newpage.showpage str,p,url
Class AutoPaging
	Public Function Alert(message,gourl)
		message = replace(message,"'","\'")
		If gourl="-1" then
	 		Response.Write ("<script language=javascript>alert('" & message & "');history.go(-1)</script>")
	 	Else
	 		Response.Write ("<script language=javascript>alert('" & message & "');location='" & gourl &"'</script>")
	 	End If
	 	Response.End()
	End Function
	
	Public Sub showpage(str,page,url)
		If Not isnumeric(page) Then
	 		'alert "提示:错误的参数!","-1"
			page=1
		End If
		If page="" or page=0 or isnull(page) or isempty(page) Then
	 		page=1
		else
	 		page=cint(page)
		end If
		If IsNull(str) Then str="&nbsp;"
		str=split(str,"[nextpage]")
		pcount=ubound(str)+1
		If pcount>1 Then
			if  page<1 then
				'alert "提示:错误的参数!","-1"
				page=1
			elseIf page>cint(ubound(str)+1) Then
				page=pcount
			end if
			abspage=page
			response.write str(page-1)&"<br><br><center> 共分为"&pcount&"页 "
			for p=0 to ubound(str)
				If abspage=p+1 Then
					response.write "<font class=red>"&p+1&"</font> "
				Else
					response.write "<a href="&url&"p="&p+1&">["&p+1&"]</a> "
				End If
			next
			response.write "当前第"&abspage&"/"&pcount&"页</center>"
		Else
			response.write str(0)
		End If
	End Sub
End Class
Function GetIP()
Dim IP
IP=Request.ServerVariables("HTTP_X_FORWARDED_FOR")
If IP="" Then IP=Request.ServerVariables("REMOTE_ADDR")
GetIP=IP 
End Function

Function GetYYYYMMDDHHIISS(d,t)

YYYY=Year(d)
MM=Month(d)
DD=Day(d)
HH=Hour(t)
II=Minute(t)
SS=Second(t)
If Len(YYYY) =2 then
YYYY="20" & YYYY
End If
If Len(MM)=1 then
MM="0" & MM
End If
If Len(DD)=1 then
DD="0" & DD
End If
If Len(HH)=1 then
HH="0" & HH
End If
If Len(II)=1 then
II="0" & II
End If
If Len(SS)=1 then
SS="0" & SS
End If
GetYYYYMMDDHHIISS=YYYY & MM & DD & HH & II & SS
End Function

'该函数作用：按指定参数格式化显示时间。
'numformat=1:将时间转化为yyyy-mm-dd hh:nn格式。
'numformat=2:将时间转化为yyyy-mm-dd格式。
'numformat=3:将时间转化为hh:nn格式。
'numformat=4:将时间转化为yyyy年mm月dd日 hh时nn分格式。
'numformat=5:将时间转化为yyyy年mm月dd日格式。
'numformat=6:将时间转化为hh时nn分格式。
'numformat=7:将时间转化为yyyy年mm月dd日 星期×格式。
'numformat=8:将时间转化为yymmdd格式。
'numformat=9:将时间转化为mmdd格式。

function formatdate(shijian,numformat)
dim ystr,mstr,dstr,hstr,nstr '变量含义分别为年字符串，月字符串，日字符串，时字符串，分字符串

if isnull(shijian) then
numformat=0
else
ystr=DatePart("yyyy",shijian)

if DatePart("m",shijian)>9 then 
mstr=DatePart("m",shijian)
else
mstr="0"&DatePart("m",shijian) 
end if

if DatePart("d",shijian)>9 then 
dstr=DatePart("d",shijian)
else
dstr="0"&DatePart("d",shijian) 
end if

if DatePart("h",shijian)>9 then 
hstr=DatePart("h",shijian)
else
hstr="0"&DatePart("h",shijian) 
end if

if DatePart("n",shijian)>9 then 
nstr=DatePart("n",shijian)
else
nstr="0"&DatePart("n",shijian) 
end if
end if 

select case numformat
case 0
formatdate=""
case 1
formatdate=ystr&"-"&mstr&"-"&dstr&" "&hstr&":"&nstr 
case 2
formatdate=ystr&"-"&mstr&"-"&dstr 
case 3
formatdate=hstr&":"&nstr
case 4
formatdate=ystr&"年"&mstr&"月"&dstr&"日 "&hstr&"时"&nstr&"分"
case 5
formatdate=ystr&"年"&mstr&"月"&dstr&"日" 
case 6
formatdate=hstr&"时"&nstr&"分"
case 7
formatdate=ystr&"年"&mstr&"月"&dstr&"日 "&WeekdayName(Weekday(shijian))
case 8
formatdate=right(ystr,2)&mstr&dstr
case 9
formatdate=mstr&dstr
end select
end function
Public Function UMoney(ByVal money)
    Dim lnP 
    Dim Prc 
    Dim Tmp
    Dim NoB 
    Dim Dx 
    Dim Xx 
    Dim Zhen 
    Dim China : China = "分角元拾佰仟万拾佰仟亿"
    Dim str: str = Array("零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖")
    Zhen = True
    money = FormatNumber(money, 2)
    Prc = CStr(money)
    Prc = Replace(Prc, ",", "")
    
    lnP = Len(Prc)
    For i = lnP - 1 To 1 Step -1
        If Mid(Prc, i, 1) = "." Then
            Select Case lnP - i
                Case 1
                    Prc = Replace(Prc, ".", "") + "0"
                Case 2
                    Prc = Replace(Prc, ".", "")
            End Select
            Zhen = False
            Exit For
        End If
    Next
    If Zhen Then Prc = Prc + "00"
    lnP = Len(Prc)
    For i = 1 To lnP
        Tmp = str(Mid(Prc, i, 1)) & Tmp
    Next
    UMoney = ""
    fy = 1
    For i = 1 To lnP
        Xx = Mid(Tmp, i, 1)
        Dx = Mid(China, i, 1)
        
        If Xx <> "零" Then
            UMoney = Xx & Dx & UMoney
            f = 1
        Else
            If i = 3 Then
            UMoney = Dx & UMoney
            End If
        
            If i = 7 Then
                UMoney = Dx & UMoney
            End If
            If f Then
                UMoney = "零" & UMoney
            End If
            f = 0
        End If
    Next
    If Zhen Then UMoney = UMoney + "整"
    UMoney = Replace(UMoney, "零万", "万")
    UMoney = Replace(UMoney, "零元", "元")
End Function

function formatURL(m,a,id) 'm 模块（新闻、产品、下载 视频）  a 动作 (company , list, readnews)  id (id)
 formatURL="未定义的URL"
 if m=0 then
 	select case a
		case "company"
			formatURL="company.asp?id="&id
		case "readnews"
			formatURL="readnews.asp?id="&id
		
	end select
 end if
end function

function dirpath(cateid)

	set rs_dirpath= server.CreateObject("adodb.recordset")
	set rs_dirpath2 = server.CreateObject("adodb.recordset")
	'response.write "select parentid,dirpath from category where cateid="&cateid
	rs_dirpath.open "select parentid,dirpath from category where cateid="&cateid,conn,1,3
	if not rs_dirpath.eof then
		
		parentid_temp = rs_dirpath("parentid")
		tempdir =""
		
		'response.write "Select catedir from category where cateid in ("&parentid_temp&") order by depth"
		'response.end 
		rs_dirpath2.open "Select catedir from category where cateid in ("&parentid_temp&") order by depth",conn,1,1
		while not rs_dirpath2.eof

			tempdir=tempdir&""&rs_dirpath2(0)&"/"
			
		rs_dirpath2.movenext
		wend
		rs_dirpath2.close
		
		rs_dirpath("dirpath")=tempdir
		rs_dirpath.update
		
	rs_dirpath.movenext
	end if
	rs_dirpath.close
	
	set rs_dirpath= nothing
	set rs_dirpath2=  nothing

end function

function companyURL(cateid,catetype,outlinkurl,modeltype,catedir,isStatic)
	if catetype=3 then '外部链接
		companyURL =outlinkurl	
	else
	
		if isStatic="0" then
			select case modeltype
				case 0  '文字信息模型
					if catetype=1 then					
						companyURL="news.asp?id="&cateid					
					else 'catetype=0 or 2 单页或栏目首页
						companyURL="company.asp?id="&cateid
					end if			
				case 1 '图片信息模型
					'companyURL = "pic.asp?id="&cateid				
					companyURL = "pic.asp?id="&cateid	
				case 2 '杂志信息模型
					companyURL="zuji.asp?id="&cateid		
				case 3 '分析师列表模型'	
					companyURL="team.asp?id="&cateid
			end select
		else '静态			
			'companyURL =HtmlRoot&catedir&"-cat"&cateid&".html"					
			companyURL =HtmlRoot&catedir&"/index.html"					
		end if
		
	end if

end function


function companyUrl_db(cateid)
	set rs_cate=server.CreateObject("adodb.recordset")
	rs_cate.open "Select * from category where cateid="&cateid,conn,1,1
	if not rs_cate.eof then
		companyUrl_db =companyURL(cateid,rs_cate("catetype"),rs_cate("outlinkurl"),rs_cate("modeltype"),rs_cate("dirpath"),supporthtml)
	end if
	rs_cate.close


end function


function infoURL(sUrl,dUrl,isStatic)
	if isStatic="0" then
		infoURL= dUrl
	else
		infoURL= HtmlRoot&sUrl
	end if
end function

function infoURL2(infoID,dUrl,isStatic)
	
	if isStatic="0" then
		infoURL= dUrl
	else
		'infoURL= HtmlRoot&sUrl
		set rs_info =server.CreateObject("adodb.recoreset")
		rs_info.open "select * from news_c where id="&infoID,conn,1,1
			if not rs_info.eof then
		
		
			end if
		rs_info.close
		set rs_info=nothing
		
	end if
end function


function wystatus_IMG(wystatus)
select case wystatus

case "在售"
 wystatus_IMG = "images/status_1.png"
case "待售"
 wystatus_IMG = "images/status_0.png"
case "售馨"
 wystatus_IMG = "images/status_2.png"
end select

end function




Function GetFullUrl()
	Dim ScriptAddress, M_ItemUrl, M_item
	ScriptAddress = CStr(Request.ServerVariables("SCRIPT_NAME"))&"?"'取得当前地址
'	so=ChkFormStr(request.form("so"))
'	if so<>"" then
'	ScriptAddress=ScriptAddress&"so="&so&"&"
'	end if
	If (Request.QueryString <> "") Then
		M_ItemUrl = ""
		For Each M_item In Request.QueryString
			If InStr("page",M_Item)=0 Then
				M_ItemUrl = M_ItemUrl & M_Item &"="& Server.URLEncode(Request.QueryString(""&M_Item&"")) & "&"
			End If
		Next
		ScriptAddress = ScriptAddress & M_ItemUrl'取得带参数地址
	End If
	GetFullUrl = ScriptAddress 
End Function


function replaceUrl(url,cname,cvalue,nvalue)
dim strtemp
strtemp=cname&"="&server.URLEncode(cvalue)
strtemp_new=cname&"="&server.URLEncode(nvalue)


if instr(url,strtemp)>0 then
replaceUrl =replace(url,strtemp,strtemp_new)
else
replaceUrl=url&strtemp_new
end if

end function

function towan(num)
num = num/1000
num =int(num + 0.5) /10
towan= num
end function

'生成html
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


function C_htm(cjurls,path)
Dim Html

'response.write cjurls
Html = getHTTPPage(cjurls)
'response.write Html

set fso=CreateObject("scripting.FileSystemObject")
'set f=fso.CreateTextFile( server.mappath( "index_c.asp" ), true,true ) '当日净值排序

'f.WriteLine( Html )
'f.close
'set f = nothing
'set fso = Nothing

'response.write path
strpath = left(path, instrrev(path, "/", -1, 1)) '去掉文件名，得到路径
'response.write strpath
If Not fso.FolderExists(Server.mappath(strpath)) Then
	'fso.CreateFolder(Server.mappath(strpath))
	'response.write strpath
	t=CreateMultiFolder(strpath)
End If
set fso = Nothing

Set   objStream   =   Server.CreateObject("ADODB.Stream")   
          With   objStream   
          .Open   
          .Charset   =   "utf-8"   
          .Position   =   objStream.Size   
          .WriteText=Html   
          .SaveToFile   server.mappath(path),2     
          .Close   
          End   With   
  Set   objStream   =   Nothing 

'response.write "成功" & "<br>"
C_htm =true


end function

'生成html end



'创建多级目录，可以创建不存在的根目录 
'参数：要创建的目录名称，可以是多级 
'返回逻辑值，True成功，False失败 
'创建目录的根目录从当前目录开始 
'--------------------------------------------------- 

Function CreateMultiFolder(ByVal CFolder) 
    Dim objFSO, PhCreateFolder, CreateFolderArray, CreateFolder 
    Dim i, ii, CreateFolderSub, PhCreateFolderSub, BlInfo 
    BlInfo = False 
    CreateFolder = CFolder 
    On Error Resume Next 
    Set objFSO = Server.CreateObject("Scripting.FileSystemObject") 
    If Err Then 
        Err.Clear() 
        Exit Function 
    End If 
    CreateFolder = Replace(CreateFolder, "", "/") 
    If Left(CreateFolder, 1) = "/" Then 
        CreateFolder = Right(CreateFolder, Len(CreateFolder) -1) 
    End If 
    If Right(CreateFolder, 1) = "/" Then 
        CreateFolder = Left(CreateFolder, Len(CreateFolder) -1) 
    End If 
    CreateFolderArray = Split(CreateFolder, "/") 
    For i = 0 To UBound(CreateFolderArray) 
        CreateFolderSub = "/"   '这里由空改动成/， 是从根目录开始
        For ii = 0 To i 
            CreateFolderSub = CreateFolderSub & CreateFolderArray(ii) & "/" 
        Next 
        PhCreateFolderSub = Server.MapPath(CreateFolderSub) 
        If Not objFSO.FolderExists(PhCreateFolderSub) Then 
            objFSO.CreateFolder(PhCreateFolderSub) 
        End If 
    Next 
    If Err Then 
        Err.Clear() 
    Else 
        BlInfo = True 
    End If 
    CreateMultiFolder = BlInfo 
End Function 


function Thumb_getUrl(filename,width,height)
'// 参数：需生成文件、限定宽度、限定高度

 
if filename="" or cint(width)<10 or cint(height)<10 then 
 
 	'Thumb_getUrl ="/images/nopic.jpg" '//如果没有需要生成的图片或者祝宽度和高度小于10像素，则用默认图替代
	ThumbUrl=Thumb_getUrl(DefaultPicUrl,width,height)
else

	
	fname= ResizePath(filename, width &"x" & height )	



	 srcfile=Server.MapPath(filename) '//大图路径
	 destfile=Server.MapPath(fname) '//小图路径
	 
	 Set fs = Server.CreateObject("Scripting.FileSystemObject") '//FSO对象，对文件进行判断
	 If fs.FileExists(destfile) Then '//这里注意了，如果缩略图已经存在，就不需要再生成一次了，直接显示小图
	 Thumb_getUrl = fname
	 else '//如果缩略图不存在，则先生成，然后显示
	call makethumb(srcfile,destfile,width,height,4) '//调用图片处理函数
	Thumb_getUrl =fname
	end if
	set fs=nothing
end if
end function

' filepath="profile/"  '//大图保存文件夹
' savepath="profile/thumbs/" '//大图保存文件夹
' srcfile=filename  '//处理需要生成的图片文件
' f=split(filename,".") 
' destfile=width &"x" & height & "_" & f(0) &"." &f(1) '//缩略图文件名
' 
 'fname=destfile

	

'// 图片处理函数
function MakeThumb(fileName,saveName,limitW,limitH,nType)
if not(limitW>0 or limitH>0) then exit function
Dim ojpg,oh,ow
Set ojpg = Server.CreateObject("Persits.Jpeg")
ojpg.open fileName
oh = ojpg.OriginalHeight
ow = ojpg.OriginalWidth
select case nType
case 0
    Rem 限定宽高
    if limitW>0 and limitH>0 then
      ojpg.width=limitW
      ojpg.height=limitH
    end if
case 1
    Rem 只限定宽度，高度按比例
    if limitW>0 then
      ojpg.width=limitW
      ojpg.height=oh/ow*limitW
    end if
case 2
    Rem 只限定高度，宽度按比例
    if limitH>0 then
      ojpg.height=limitH
      ojpg.width=ow/oh*limitH
    end if
case 3
    Rem 按限定的宽高比裁切
    if limitW>0 and limitH>0 then
      Dim lheight:lheight=oh*limitW/ow
      If lheight<limitH Then
        ojpg.Height = limitH
        ojpg.Width = ow*ojpg.Height/oh
      Else
        ojpg.width = limitW
        ojpg.Height = oh*ojpg.width/ow
      End if
      ojpg.Crop 0, 0,limitW,limitH
    End If
case 4
		ojpg.Quality = 100
		'If  ojpg.OriginalHeight/limitH *ojpg.OriginalWidth > limitW Then
				 ojpg.PreserveAspectRatio = True '等比缩放
				 if ojpg.OriginalWidth/ojpg.OriginalHeight > limitW/limitH then '太扁了，要剪掉左右部分
				  ojpg.Height = limitH
				  ojpg.crop CInt((ojpg.Width - limitW)/2),0,CInt((ojpg.Width-limitW)/2)+limitW,limitH
				 else '太高了，要剪掉上下部分
				  ojpg.Width = limitW
				  ojpg.crop 0,CInt((ojpg.Height-limitH)/2),limitW,CInt((ojpg.Height-limitH)/2)+limitH
				 end if
		'end if
case else
    exit function
end select
ojpg.Quality = 100
ojpg.save saveName
Set ojpg = nothing
end function

Function ResizePath(DefaultPicUrl,s)
	te= InStrRev(DefaultPicUrl,".")	
	ImageType=Mid(DefaultPicUrl,te,len(DefaultPicUrl)-te+1)
	ResizePath= Replace(DefaultPicUrl,ImageType,"_"&s&ImageType)
End function
'Thumb 生成缩略图函数
'DefaultPicUrl 源图路径
'sname 缩略图名称加后缀，缩略图与源图 路径相同，名称后面加一后缀 _sname
'width height 生成缩略图的尺寸 不等比例则裁剪 
'函数返回缩略图的地址
function Thumb(DefaultPicUrl,sname,width,height)
	url2= ResizePath(DefaultPicUrl,sname)	
	Set ap=new AspJpeg	
	ap.MathPathFrom=server.mappath(DefaultPicUrl)	
	ap.MathPathTo=server.mappath(url2)
	ap.Width=width
	ap.Height=height
	t=ap.image_resize()	
	Thumb= url2	
end function
%>
