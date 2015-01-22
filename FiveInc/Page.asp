<%
'=====================================================================
'zh_Showpage 	ASP版本
'版本			1.00
'Code by		Kevin
'Email:			wuchenghua828@163.com
'本程序可以免费使用、修改，希望我的程序能为您的工作带来方便
'但请保留以上请息
'
'程序特点
'本程序主要是对数据分页的部分进行了封装，而数据显示部份完全由用户自定义，
'支持URL多个参数
'
'使用说明
'程序参数说明
'PapgeSize						定义分页每一页的记录数
'GetRS							返回经过分页的Recordset此属性只读
'GetConn						得到数据库连接
'GetSQL							得到查询语句
'程序方法说明
'ShowPage						显示分页导航条,唯一的公用方法
'
'例:
'	Set mypage=new zh_Showpage			'创建对象
'	mypage.getconn=conn				'得到数据库连接
'	mypage.getsql="select * from productinfo order by id asc"
'	mypage.pagesize=5				'设置每一页的记录条数据为5条
'	set rs=mypage.getrs()				'返回Recordset
'	mypage.TotalRecord()				'得到总记录数
'	mypage.showpage()				'显示分页信息，这个方法可以，在set rs=mypage.getrs()以后
'							 任意位置调用，可以调用多次
'	for i=1 to mypage.pagesize 			'接下来的操作就和操作一个普通Recordset对象一样操作
'		if not rs.eof then			'这个标记是为了防止最后一页的溢出
'			response.write rs(0) & "<br>"	'这里就可以自定义显示方式了
'			rs.movenext
'		else
'			exit for
'		end if
'	next 
'
'=====================================================================

'Const Btn_First="<font face=webdings>9</font>"		'定义第一页按钮显示样式
'Const Btn_Prev="<font face=webdings>3</font>"		'定义前一页按钮显示样式
'Const Btn_Next="<font face=webdings>4</font>"		'定义下一页按钮显示样式
'Const Btn_Last="<font face=webdings>:</font>"		'定义最后一页按钮显示样式
Const Btn_First="首页"		'定义第一页按钮显示样式
Const Btn_Prev="上页"		'定义前一页按钮显示样式
Const Btn_Next="下页"		'定义下一页按钮显示样式
Const Btn_Last="末页"		'定义最后一页按钮显示样式
Const XD_Align="center"					'定义分页信息对齐方式
Const XD_Width="100%"					'定义分页信息框大小
Const XD_Height="30"
Class zh_Showpage
Private XD_PageCount,XD_Conn,XD_Rs,XD_SQL,XD_PageSize,Str_errors,int_curpage,str_URL,int_totalPage,int_totalRecord


'=================================================================
'PageSize	属性
'设置每一页的分页大小
'=================================================================
Public Property Let PageSize(int_PageSize)
	If IsNumeric(Int_Pagesize) Then
		XD_PageSize=CLng(int_PageSize)
	Else
		str_error=str_error & "PageSize的参数不正确"
		ShowError()
	End If
End Property
Public Property Get PageSize
	If XD_PageSize="" or (not(IsNumeric(XD_PageSize))) Then
		PageSize=10					
	Else
		PageSize=XD_PageSize
	End If
End Property

'=================================================================
'GetRS	属性
'返回分页后的记录集
'=================================================================
Public Property Get GetRs()
	Set XD_Rs=Server.createobject("adodb.recordset")
	XD_Rs.PageSize=PageSize
	XD_Rs.Open XD_SQL,XD_Conn,1,1
	If not(XD_Rs.eof and XD_RS.BOF) Then
		If int_curpage>XD_RS.PageCount Then
			int_curpage=XD_RS.PageCount
		End If
		XD_Rs.AbsolutePage=int_curpage
	End If
	Set GetRs=XD_RS
End Property

'================================================================
'GetConn		得到数据库连接
'
'================================================================	
Public Property Let GetConn(obj_Conn)
	Set XD_Conn=obj_Conn
End Property

'================================================================
'GetSQL			得到查询语句
'
'================================================================
Public Property Let GetSQL(str_sql)
	XD_SQL=str_sql
End Property



'==================================================================
'Class_Initialize	类的初始化
'初始化当前页的值
'
'==================================================================	
Private Sub Class_Initialize
	'========================
	'设定一些参数的黙认值
	'========================
	XD_PageSize=10		'设定分页的默认值为10
	'========================
	'获取当前面的值
	'========================
	If request("page")="" Then
		int_curpage=1
	ElseIf not(IsNumeric(request("page"))) Then
		int_curpage=1
	ElseIf CInt(Trim(request("page")))<1 Then
		int_curpage=1
	Else
		Int_curpage=CInt(Trim(request("page")))
	End If
		
End Sub

'====================================================================
'ShowPage		创建分页导航条
'有首页、前一页、下一页、末页、还有数字导航
'
'====================================================================
Public Sub ShowPage()
	Dim str_tmp
	
	int_totalRecord=XD_RS.RecordCount
	If int_totalRecord<=0 Then 
		str_error=str_error & "总记录数为零，请输入数据"
		Call ShowError()
	End If
	If int_totalRecord<pagesize Then
		int_TotalPage=1
	Else
		If int_totalRecord mod PageSize =0 Then
			int_TotalPage = Int(int_TotalRecord / XD_PageSize * -1)*-1
		Else
			int_TotalPage = Int((int_TotalRecord / XD_PageSize * -1)*-1)+1
		End If
	End If
	
	If Int_curpage>int_Totalpage Then
		int_curpage=int_TotalPage
	End If
	
	'===============================================================================
	'显示分页信息，各个模块根据自己要求更改显求位置
	'===============================================================================
	
	if int_TotalPage>1 then
	response.write "<!--分页代码 --><div class=""pagediv""><form name='TurnPage' action='"&CStr(Request.ServerVariables("SCRIPT_NAME"))&"'><div class=""pagebar""><div class=""pages"">"
	
	
	str_tmp=ShowFirstPrv
	response.write str_tmp
	
	str_tmp=showNumBtn(int_totalpage,int_curpage,2,1,geturl)
	response.write str_tmp
	
	str_tmp=ShowNextLast
	response.write str_tmp
	
	
	
	str_tmp=ShowAllCounts	
	response.write str_tmp
	
	
	
	Response.Write ShowGoto()
	response.write "</div></div></form></div><!--分页代码end --> "
	end if
	
End Sub

'===============================================================================
	'显示分页信息，供查询页调用
	'===============================================================================



'====================================================================
Public Function PageInfo()
	Dim str_tmp,strHtml
	
	int_totalRecord=XD_RS.RecordCount
	If int_totalRecord<=0 Then 
		str_error=str_error & "总记录数为零，请输入数据"
		Call ShowError()
	End If
	If int_totalRecord<pagesize Then
		int_TotalPage=1
	Else
		If int_totalRecord mod PageSize =0 Then
			int_TotalPage = Int(int_TotalRecord / XD_PageSize * -1)*-1
		Else
			int_TotalPage = Int((int_TotalRecord / XD_PageSize * -1)*-1)+1
		End If
	End If
	
	If Int_curpage>int_Totalpage Then
		int_curpage=int_TotalPage
	End If
	
	'===============================================================================
	'显示分页信息，各个模块根据自己要求更改显求位置
	'===============================================================================
	strHtml = "<table border='0' cellpadding='0' cellspacing='0' width='"&XD_Width&"'><tr><form name='TurnPage'><td align='"&XD_Align&"'>"

	strHtml = strHtml & "</td></FORM></tr></table>"

	PageInfo = strHtml	
End Function

'====================================================================
'ShowFirstPrv		显示首页、前一页
'
'
'====================================================================
Private Function ShowFirstPrv()
	Dim Str_tmp,int_prvpage	
	'str_tmp="<a href="""&geturl  &"1"">首页</a>&nbsp;"
	If int_curpage=1 Then
		str_tmp=str_tmp&"<a class=""prepage""></a>"
	Else
		int_prvpage=int_curpage-1
		str_tmp=str_tmp&"<a href="""&geturl & int_prvpage &"""  class=""prepage color""></a>"
	End If
	ShowFirstPrv=str_tmp
End Function



'====================================================================
'ShowNextLast		下一页、末页
'
'
'====================================================================
Private Function ShowNextLast()
	Dim str_tmp,int_Nextpage
	
	If Int_curpage>=int_totalpage Then
		str_tmp= "<a class=""nextpage""></a>"
	Else
		Int_NextPage=int_curpage+1
		str_tmp="<a class=""nextpage  color"" href="""& geturl & int_NextPage &"""></a>"
	End If
	
	
	ShowNextLast=str_tmp
End Function



'====================================================================
'ShowNumBtn		数字导航
'
'
'====================================================================
Private Function showNumBtn(pagecount,pagenow,ON_EACH_SIDE,ON_ENDS,geturl)
	Dim i,str_tmp
	

	
	
If pagecount>=1 then
		
		For i=1 To pagenow-1


		If i <=ON_ENDS  Or i>=pagenow-ON_EACH_SIDE then'从1开始ON_ENDS 左侧最开始ON_ENDS页 或者 小于挨着pagenow的ON_EACH_SIDE
		str_tmp = str_tmp& "<a href="""&geturl&i&"""> "&i&"</a>"		
		
		ElseIf i=ON_ENDS+1 And pagenow-ON_EACH_SIDE>ON_ENDS Then ' pagenow-ON_EACH_SIDE 最小的挨着当前页〉 on_Ends则要加省略号
		str_tmp = str_tmp& "<a class=""page_dian"">...</a>"		
			
		End If
		Next
		
	str_tmp = str_tmp& "<a class=""curpage"">"&pagenow&"</a>"	'当前页

	For i=pagenow+1 To pagecount

			If i<=pagenow+ON_EACH_SIDE or i>=pagecount-ON_ENDS Then '右挨着pagenow的ON_EACH_SIDE页
			str_tmp = str_tmp& "<a href="""&geturl&i&"""> "&i&"</a>"		
			
			ElseIf i=pagecount-ON_ENDS-1 and pagenow+ON_EACH_SIDE<pagecount-ON_ENDS Then '有倒数第三页
			str_tmp = str_tmp& "<a class=""page_dian"">...</a>"
			
			End if		
	Next
		
end if		
showNumBtn=str_tmp
	
End Function
'====================================================================
'ShowNumBtn	修改后的数字导航
'
'====================================================================


'====================================================================
'ShowGoto	页面跳转
'
'
'====================================================================
Private Function ShowGoto()
	Dim M_item,strTmp
	strTmp = ""
	'========================================================
	'将返回的Url参数逐个的写入隐藏域中，以便与参数继续传递
	'========================================================
	For Each M_item In Request.QueryString
		If InStr("page",M_Item)=0 Then '从参数中除去 "page" 的值
			strTmp = strTmp & "<input type=hidden name = '"&M_Item&"' value = '"&Request.QueryString(""&M_Item&"")&"'>"
		End If
	Next
	'========================================================
	strTmp = strTmp & "<span class=""txt"">到</span><input type='text' name='page'  maxlength='10' value='"&int_curpage&"' onchange=""document.TurnPage.GoPage.disabled=false"" class=""ipt_page"">"
	strTmp = strTmp & "<span class=""txt"">页</span><input type='submit' id='GoPage'  value='确定'>"
	ShowGoto = strTmp
End Function 


'====================================================================
'ShowPageInfo		分页信息
'更据要求自行修改
'
'====================================================================
Private Function ShowPageInfo()
	Dim str_tmp
	str_tmp="&nbsp;页 <span class=""red b"">"&int_curpage&"</span>/<span class=""b"">"&int_totalpage&"</span>"
	ShowPageInfo=str_tmp
End Function


Private Function ShowAllCounts()
	Dim str_tmp
	str_tmp="<span class=""txt"">共"&int_totalpage&"页</span>"
	ShowAllCounts=str_tmp
End Function

Private Function ShowAllCounts2()
	Dim str_tmp	
	str_tmp=str_tmp&"&nbsp;页次： <span class=""red b"">"&int_curpage&"</span>/<span class=""b"">"&int_totalpage&"</span>页"	
	str_tmp=str_tmp&"&nbsp;&nbsp;共<span class=""b"">"&int_totalrecord&"</span>"
	ShowAllCounts2=str_tmp
End Function

'====================================================================
'修改后的获取当前Url参数的函数
'Codeing by Redsun
'====================================================================
Private Function GetUrl()
	Dim ScriptAddress, M_ItemUrl, M_item
	ScriptAddress = CStr(Request.ServerVariables("SCRIPT_NAME"))&"?"'取得当前地址
	so=ChkFormStr(request.form("so"))
	if so<>"" then
	ScriptAddress=ScriptAddress&"so="&so&"&"
	end if
	If (Request.QueryString <> "") Then
		M_ItemUrl = ""
		For Each M_item In Request.QueryString
			If InStr("page",M_Item)=0 Then
				M_ItemUrl = M_ItemUrl & M_Item &"="& Server.URLEncode(Request.QueryString(""&M_Item&"")) & "&"
			End If
		Next
		ScriptAddress = ScriptAddress & M_ItemUrl'取得带参数地址
	End If
	GetUrl = ScriptAddress & "page="
End Function

'返回记录总数
Public Property Get TotalRecord()
	TotalRecord = XD_Rs.RecordCount
End Property

'====================================================================
' 设置 Terminate 事件。
'====================================================================
Private Sub Class_Terminate   
	If Not IsObject(XD_RS) Then Exit Sub
	'XD_RS.close()
	Set XD_RS = Nothing
End Sub
'====================================================================
'ShowError		错误提示
'====================================================================
Private Sub ShowError()
	If str_Error <> "" Then
		Response.Write("<font color=""#FF0000""><br><b>" & SW_Error & "</font>")
		Response.End
	End If
End Sub

End class
%>