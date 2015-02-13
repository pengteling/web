<!--#include file="../FiveInc/conn.asp"-->
<!--#include file="admin.asp"-->
<!-- #include file="Inc/Head.asp" -->
<%
dim ObjInstalled,Action,ErrMsg
ObjInstalled=IsObjInstalled(xiaodaofso)
Action=trim(request("Action"))
if Action="" then
	Action="ShowInfo"
end if
%>
<%
if Action="SaveConfig" then
	call SaveConfig()
	if FoundErr=True then
		call WriteErrMsg()
		response.End()
		
	else
	
	Response.Redirect "SiteConfig.asp?Ok" 
	end if
	
	'call ShowConfig()
else
	call ShowConfig()
end if

call CloseConn()
sub ShowConfig()
%>
<form method="POST" action="SiteConfig.asp" id="myform" name="myform">
  <table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#ECF5FF" class="table_southidc">
    <tr> 
      <td height="30" colspan="2" align="center" class="back_southidc"><strong>网 站 配 置</strong></td>
    </tr>
    <tr> 
      <td colspan="2" class="tr_southidc">
      	<%
			If Request.QueryString<>"" Then
				if ErrMsg="" then
				Response.Write("<span class='red'>网站配置成功!</span>")
				else
				response.Write("<span class='red'>"&ErrMsg&"</span>")
				end if
			End If
		%>      </td>
    </tr>
    <tr> 
      <td width="23%" class="tr_southidc"><strong>网站名称：</strong></td>
      <td width="77%" class="tr_southidc"> <input name="SiteName" type="text" id="SiteName" value="<%=SiteName%>" size="40" maxlength="50"></td>
    </tr>
    <tr> 
      <td class="tr_southidc"><strong>网站标题：</strong></td>
      <td class="tr_southidc"> <input name="SiteTitle" type="text" id="SiteTitle" value="<%=SiteTitle%>" size="40" maxlength="255">      </td>
    </tr>
    <tr>
      <td class="tr_southidc"><strong>关键字：</strong><br>
	  请填写网站的关键字,以便搜索引擎搜索</td>
      <td class="tr_southidc"><textarea name="Sitekey" cols="40" rows="5" id="Sitekey"><%=Sitekey%></textarea>
        多个关键字用英文逗号 <font color="#FF0000">,</font> 隔开</td>
    </tr>
    <tr>
      <td class="tr_southidc"><strong>网站说明：</strong><br>
请填写网站说明,以便搜索引擎搜索</td>
      <td class="tr_southidc"><textarea name="SiteDescription" cols="40" rows="5" id="SiteDescription"><%=SiteDescription%></textarea></td>
    </tr>
    <tr> 
      <td class="tr_southidc"><strong>网站地址：</strong><br>
      请添写完整URL地址</td>
      <td class="tr_southidc"> <input name="SiteUrl" type="text" id="SiteUrl" value="<%=SiteUrl%>" size="40" maxlength="255">      </td>
    </tr>
<tr>
      <td class="tr_southidc"><span style="font-weight: bold">支持缩微图</span><strong>：</strong><br>服务器是否支持aspjpeg控件</td>
      <td class="tr_southidc"><label>
        <input name="supportAspjpeg" type="radio" value="1" <%if supportAspjpeg=1 then response.Write("checked") end if%>>
      支持
      <input type="radio" name="supportAspjpeg" value="0" <%if supportAspjpeg=0 then response.Write("checked") end if%>>
不支持</label></td>
    </tr>


<!--<tr>
      <td class="tr_southidc"><span style="font-weight: bold">是否生成静态</span><strong>：</strong><br>（首页和信息页生成静态html）</td>
      <td class="tr_southidc"><label>
        <input name="supportHtml" type="radio" value="1" <%if supportHtml=1 then response.Write("checked") end if%>>
      是
      <input type="radio" name="supportHtml" value="0" <%if supportHtml=0 then response.Write("checked") end if%>>
否</label></td>
    </tr>
    -->
    
    <tr>
      <td class="tr_southidc"><span style="font-weight: bold">网站状态</span><strong>：</strong></td>
      <td class="tr_southidc"><label>
        <input name="sitestatus" type="radio" value="1" <%if SiteStatus=1 then response.Write("checked") end if%>>
      开启
      <input type="radio" name="sitestatus" value="0" <%if SiteStatus=0 then response.Write("checked") end if%>>
关闭</label></td>
    </tr>
    <tr>
      <td class="tr_southidc"><span style="font-weight: bold">关闭原因</span><strong>：<br>
      </strong>网站处于关闭状态时显示</td>
      <td class="tr_southidc"><label>
        <input name="siteinfo" type="text" value="<%=SiteInfo%>" size="40">
      </label></td>
    </tr>
    <tr>
      <td class="tr_southidc"><span style="font-weight: bold">网站备案号</span><strong>：</strong></td>
      <td class="tr_southidc"><label>
        <input name="SiteBeian" type="text" value="<%=SiteBeian%>" size="40">
      </label></td>
    </tr>
    <tr> 
      <td class="tr_southidc"><strong>联系电话：</strong></td>
      <td class="tr_southidc"> <input name="CompanyTel" type="text" id="CompanyTel" value="<%=CompanyTel%>" size="40" maxlength="255"></td>
    </tr>
    
    <tr> 
      <td class="tr_southidc"><strong>传真：</strong></td>
      <td class="tr_southidc"> <input name="CompanyFax" type="text" id="CompanyFax" value="<%=CompanyFax%>" size="40" maxlength="255"></td>
    </tr>
   
   
    <tr> 
      <td width="23%" class="tr_southidc"><strong>电子邮箱：</strong></td>
      <td class="tr_southidc"> <input name="CompanyEmail" type="text" id="CompanyEmail" value="<%=CompanyEmail%>" size="40" maxlength="255">      </td>
    </tr>
	<tr> 
      <td width="23%" class="tr_southidc"><strong>地址：</strong></td>
      <td class="tr_southidc"> <input name="CompanyAddress" type="text" id="CompanyAddress" value="<%=CompanyAddress%>" size="40" maxlength="255">      </td>
    </tr>
    <tr> 
      <td class="tr_southidc"><strong>邮编：</strong></td>
      <td class="tr_southidc"> <input name="CompanyTel400" type="text" id="CompanyTel400" value="<%=CompanyTel400%>" size="40" maxlength="255"></td>
    </tr>
     <tr> 
      <td class="tr_southidc"><strong>官方微博：</strong></td>
      <td class="tr_southidc"> <input name="wburl" type="text" id="wburl" value="<%=wburl%>" size="40" maxlength="255"></td>
    </tr>
    <tr> 
      <td class="tr_southidc"><strong>微信二维码：</strong></td>
      <td class="tr_southidc"> <input name="wxurl" type="text" id="wxurl" value="<%=wxurl%>" size="40" maxlength="255">
      <input name="Submit222" type="button" value="上传图片"  onClick="window.open('../../FiveInc/mx_upload_flash.asp?formname=myform&editname=wxurl&uppath=image&filelx=jpg','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">
      </td>
    </tr>
  <tr> 
      <td class="tr_southidc"><strong>客服QQ：</strong></td>
      <td class="tr_southidc"> <input name="companyQQ" type="text" id="companyQQ" value="<%=companyQQ%>" size="40" maxlength="255"></td>
    </tr>
    
    <tr> 
      <td colspan="2" align="center" class="tr_southidc"> <input name="Action" type="hidden" id="Action" value="SaveConfig"> 
      <input name="cmdSave" type="submit" id="cmdSave" value=" 保存设置 " <% If ObjInstalled=false Then response.write "disabled" %>>      </td>
    </tr>
    <%
If ObjInstalled=false Then
	Response.Write "<tr class='tdbg'><td height='40' colspan='3'><b><font color=red>你的服务器不支持 FSO(Scripting.FileSystemObject)! 不能使用本功能。<br>请直接修改“Inc/config.asp”文件中的内容。</font></b></td></tr>"
End If
%>
  </table>
<%
end sub
%>
</form>
</body>
</html>
<%
Function WriteToUTF(content,sFilen)'content为替换后的字符串,filename为生成的文件名 
 dim objStream  
   Set objStream = Server.CreateObject("ADODB.Stream")   
     With objStream   
     .Open   
     .Charset   = "utf-8"' //编码，这里你可以改成任何编码   
     .Position   = objStream.Size   
     .WriteText = content' //模版+数据 写入内容   
     .SaveToFile server.mappath("../"&sFilen),2' //生成文件路径   
     .Close   
     End With   
   Set objStream = Nothing    
End Function  

sub SaveConfig()
	If ObjInstalled=false Then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>你的服务器不支持 FSO(Scripting.FileSystemObject)! </li>"
		exit sub
	end if
	'response.write Sqlbad(trim(request("supportAspjpeg")))
	if Sqlbad(trim(request("supportAspjpeg")))=1 then
		if not IsObjInstalled("persits.jpeg") then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>你的服务器不支持自动生成缩略图功能(persits.jpeg)! </li>"
		exit sub
		end if
	end if
	
	
	content=content& "<" & "%" & vbcrlf
	content=content& "Const SiteName=" & chr(34) & Sqlbad(trim(request("SiteName"))) & chr(34) & "        '网站名称" & vbcrlf
	content=content& "Const SiteTitle=" & chr(34) & Sqlbad(trim(request("SiteTitle"))) & chr(34) & "        '网站标题" & vbcrlf
	content=content& "Const SiteKey=" & chr(34) & Sqlbad(trim(ChkFormStr(request("SiteKey")))) & chr(34) & "        '网站关键字" & vbcrlf
	content=content& "Const SiteDescription=" & chr(34) & Sqlbad(trim(ChkFormStr(request("SiteDescription")))) & chr(34) & "        '网站说明" & vbcrlf
	content=content& "Const SiteUrl=" & chr(34) & Sqlbad(trim(request("SiteUrl"))) & chr(34) & "        '网站地址" & vbcrlf
	content=content& "Const supportAspjpeg=" & chr(34) & Sqlbad(trim(request("supportAspjpeg"))) & chr(34) & "        '支持AspJepg" & vbcrlf
	
	'content=content& "Const supportHtml=" & chr(34) & Sqlbad(trim(request("supportHtml"))) & chr(34) & "        '支持AspJepg" & vbcrlf
	
	content=content& "Const SiteStatus=" & chr(34) & Sqlbad(trim(request("SiteStatus"))) & chr(34) & "        '网站状态" & vbcrlf
	content=content& "Const SiteInfo=" & chr(34) & Sqlbad(trim(request("SiteInfo"))) & chr(34) & "        '关闭原因" & vbcrlf
	content=content& "Const SiteBeian=" & chr(34) & Sqlbad(trim(request("SiteBeian"))) & chr(34) & "        '网站备案号" & vbcrlf
	content=content& "Const CompanyTel=" & chr(34) & Sqlbad(trim(request("CompanyTel"))) & chr(34) & "        '联系人电话" & vbcrlf
	content=content& "Const CompanyTel400=" & chr(34) & Sqlbad(trim(request("CompanyTel400"))) & chr(34) & "        '联系人电话" & vbcrlf
	content=content& "Const CompanyFax=" & chr(34) & Sqlbad(trim(request("CompanyFax"))) & chr(34) & "        '联系人传真" & vbcrlf
	
	
	content=content& "Const CompanyEmail=" & chr(34) & Sqlbad(trim(request("CompanyEmail"))) & chr(34) & "        '联系人邮箱" & vbcrlf
	content=content& "Const Companyqq=" & chr(34) & Sqlbad(trim(request("Companyqq"))) & chr(34) & "        '联系人邮箱" & vbcrlf
		content=content& "Const wxurl=" & chr(34) & Sqlbad(trim(request("wxurl"))) & chr(34) & "        '联系人邮箱" & vbcrlf
	content=content& "Const CompanyAddress=" & chr(34) & Sqlbad(trim(request("CompanyAddress"))) & chr(34) & "        '联系地址" & vbcrlf
	

content=content& "Const wburl=" & chr(34) & Sqlbad(trim(request("wburl"))) & chr(34) & "        '联系地址" & vbcrlf
'content=content& "Const companyQQ=" & chr(34) & Sqlbad(trim(request("companyQQ"))) & chr(34) & "        '联系地址" & vbcrlf
	content=content& "%" & ">"

	
	
dim objStream  
   Set objStream = Server.CreateObject("ADODB.Stream")   
     With objStream   
     .Open   
     .Charset   = "utf-8"' //编码，这里你可以改成任何编码   
     .Position   = objStream.Size   
     .WriteText = content' //模版+数据 写入内容   
     .SaveToFile Server.mappath("../FiveInc/config.asp"),2' //生成文件路径   
     .Close   
     End With   
   Set objStream = Nothing  
   
end sub
%>