<!--#include file="../FiveInc/conn.asp"-->
<!--#include file="admin.asp"-->
<!-- #include file="Inc/Head.asp" -->
<%
dim ObjInstalled,Action
ObjInstalled=IsObjInstalled(xiaodaofso)
Action=trim(request("Action"))
if Action="" then
	Action="ShowInfo"
end if
%>
<%
if Action="SaveConfig" then
	call SaveConfig()
	Response.Redirect "Sitehdp.asp?Ok" 
else
	call ShowConfig()
end if
if FoundErr=True then
	call WriteErrMsg()
end if
call CloseConn()
sub ShowConfig()
%>
<form method="POST" action="Sitehdp.asp" id="form" name="form">
  <table width="100%" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#ECF5FF" class="table_southidc">
    <tr> 
      <td height="30" colspan="4" align="center" class="back_southidc"><strong>幻灯片管理</strong></td>
    </tr>
    <tr> 
      <td colspan="4" class="tr_southidc">
      	<%
			If Request.QueryString<>"" Then
				Response.Write("<span class='red'>幻灯片配置成功!</span>")
			End If
		%>      </td>
    </tr>
    
    <tr> 
     <td width="10%" class="tr_southidc"><strong>banner一：</strong></td>
      <td width="50%" class="tr_southidc"> <input name="hdp1" type="text" id="hdp1" value="<%=hdp1%>" size="30" maxlength="255">
      <input name="Submit222" type="button" value="上传图片" onClick="window.open('../fiveinc/mx_upload_flash.asp?formname=form&editname=hdp1&uppath=UploadFiles&filelx=jpg','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">
      963*350</td>
      <td width="8%" class="tr_southidc">链接地址</td>
      <td width="0" class="tr_southidc"><input name="dizhi1" type="text" id="dizhi1" value="<%=dizhi1%>" maxlength="255"></td>
    </tr>
	<tr> 
     <td class="tr_southidc"><strong>banner二：</strong></td>
      <td class="tr_southidc"> <input name="hdp2" type="text" id="hdp2" value="<%=hdp2%>" size="30" maxlength="255">
      <input name="Submit222" type="button" value="上传图片" onClick="window.open('../fiveinc/mx_upload_flash.asp?formname=form&editname=hdp2&uppath=UploadFiles&filelx=jpg','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">
963*350</td>
      <td class="tr_southidc">链接地址</td>
      <td class="tr_southidc"><input name="dizhi2" type="text" id="dizhi2" value="<%=dizhi2%>" maxlength="255"></td>
	</tr>
	<tr> 
     <td class="tr_southidc"><strong>banner三：</strong></td>
      <td class="tr_southidc"> <input name="hdp3" type="text" id="hdp3" value="<%=hdp3%>" size="30" maxlength="255">
      <input name="Submit222" type="button" value="上传图片" onClick="window.open('../fiveinc/mx_upload_flash.asp?formname=form&editname=hdp3&uppath=UploadFiles&filelx=jpg','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">
963*350</td>
      <td class="tr_southidc">链接地址</td>
      <td class="tr_southidc"><input name="dizhi3" type="text" id="dizhi3" value="<%=dizhi3%>" maxlength="255"></td>
	</tr>
	<tr> 
     <td class="tr_southidc"><strong>banner四：</strong></td>
      <td class="tr_southidc"> <input name="hdp4" type="text" id="hdp4" value="<%=hdp4%>" size="30" maxlength="255">
      <input name="Submit222" type="button" value="上传图片" onClick="window.open('../fiveinc/mx_upload_flash.asp?formname=form&editname=hdp4&uppath=UploadFiles&filelx=jpg','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">
963*350</td>
      <td class="tr_southidc">链接地址</td>
      <td class="tr_southidc"><input name="dizhi4" type="text" id="dizhi4" value="<%=dizhi4%>" maxlength="255"></td>
	</tr>
	<tr>
	<td width="10%" class="tr_southidc"><strong>登陆框下一：</strong></td>
      <td width="50%" class="tr_southidc"> <input name="hdp5" type="text" id="hdp5" value="<%=hdp5%>" size="30" maxlength="255">
      <input name="Submit222" type="button" value="上传图片" onClick="window.open('../fiveinc/mx_upload_flash.asp?formname=form&editname=hdp5&uppath=UploadFiles&filelx=jpg','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">
      963*350</td>
      <td width="8%" class="tr_southidc">链接地址</td>
      <td width="0" class="tr_southidc"><input name="dizhi5" type="text" id="dizhi5" value="<%=dizhi5%>" maxlength="255"></td>
    </tr>
	<tr> 
     <td class="tr_southidc"><strong>登陆框下二：</strong></td>
      <td class="tr_southidc"> <input name="hdp6" type="text" id="hdp6" value="<%=hdp6%>" size="30" maxlength="255">
      <input name="Submit222" type="button" value="上传图片" onClick="window.open('../fiveinc/mx_upload_flash.asp?formname=form&editname=hdp6&uppath=UploadFiles&filelx=jpg','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">
963*350</td>
      <td class="tr_southidc">链接地址</td>
      <td class="tr_southidc"><input name="dizhi6" type="text" id="dizhi6" value="<%=dizhi6%>" maxlength="255"></td>
	</tr>
	<tr> 
     <td class="tr_southidc"><strong>登陆框下三：</strong></td>
      <td class="tr_southidc"> <input name="hdp7" type="text" id="hdp7" value="<%=hdp7%>" size="30" maxlength="255">
      <input name="Submit222" type="button" value="上传图片" onClick="window.open('../fiveinc/mx_upload_flash.asp?formname=form&editname=hdp7&uppath=UploadFiles&filelx=jpg','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">
963*350</td>
      <td class="tr_southidc">链接地址</td>
      <td class="tr_southidc"><input name="dizhi7" type="text" id="dizhi7" value="<%=dizhi7%>" maxlength="255"></td>
	</tr>
	<tr> 
     <td class="tr_southidc"><strong>登陆框下四：</strong></td>
      <td class="tr_southidc"> <input name="hdp8" type="text" id="hdp8" value="<%=hdp8%>" size="30" maxlength="255">
      <input name="Submit222" type="button" value="上传图片" onClick="window.open('../fiveinc/mx_upload_flash.asp?formname=form&editname=hdp8&uppath=UploadFiles&filelx=jpg','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">
963*350</td>
      <td class="tr_southidc">链接地址</td>
      <td class="tr_southidc"><input name="dizhi8" type="text" id="dizhi8" value="<%=dizhi8%>" maxlength="255"></td>
	</tr>
	<tr>
	<td width="10%" class="tr_southidc"><strong>右下一：</strong></td>
      <td width="50%" class="tr_southidc"> <input name="hdp9" type="text" id="hdp9" value="<%=hdp9%>" size="30" maxlength="255">
      <input name="Submit222" type="button" value="上传图片" onClick="window.open('../fiveinc/mx_upload_flash.asp?formname=form&editname=hdp9&uppath=UploadFiles&filelx=jpg','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">
      963*350</td>
      <td width="8%" class="tr_southidc">链接地址</td>
      <td width="0" class="tr_southidc"><input name="dizhi9" type="text" id="dizhi9" value="<%=dizhi9%>" maxlength="255"></td>
    </tr>
	<tr> 
     <td class="tr_southidc"><strong>右下二：</strong></td>
      <td class="tr_southidc"> <input name="hdp10" type="text" id="hdp10" value="<%=hdp10%>" size="30" maxlength="255">
      <input name="Submit222" type="button" value="上传图片" onClick="window.open('../fiveinc/mx_upload_flash.asp?formname=form&editname=hdp10&uppath=UploadFiles&filelx=jpg','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">
963*350</td>
      <td class="tr_southidc">链接地址</td>
      <td class="tr_southidc"><input name="dizhi10" type="text" id="dizhi10" value="<%=dizhi10%>" maxlength="255"></td>
	</tr>
	<tr> 
     <td class="tr_southidc"><strong>右下三：</strong></td>
      <td class="tr_southidc"> <input name="hdp11" type="text" id="hdp11" value="<%=hdp11%>" size="30" maxlength="255">
      <input name="Submit222" type="button" value="上传图片" onClick="window.open('../fiveinc/mx_upload_flash.asp?formname=form&editname=hdp11&uppath=UploadFiles&filelx=jpg','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">
963*350</td>
      <td class="tr_southidc">链接地址</td>
      <td class="tr_southidc"><input name="dizhi11" type="text" id="dizhi11" value="<%=dizhi11%>" maxlength="255"></td>
	</tr>
	<tr> 
     <td class="tr_southidc"><strong>右下四：</strong></td>
      <td class="tr_southidc"> <input name="hdp12" type="text" id="hdp12" value="<%=hdp12%>" size="30" maxlength="255">
      <input name="Submit222" type="button" value="上传图片" onClick="window.open('../fiveinc/mx_upload_flash.asp?formname=form&editname=hdp12&uppath=UploadFiles&filelx=jpg','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">
963*350</td>
      <td class="tr_southidc">链接地址</td>
      <td class="tr_southidc"><input name="dizhi12" type="text" id="dizhi12" value="<%=dizhi12%>" maxlength="255"></td>
	</tr>
    <tr> 
      <td colspan="4" align="center" class="tr_southidc"> <input name="Action" type="hidden" id="Action" value="SaveConfig"> 
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
sub SaveConfig()
	If ObjInstalled=false Then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>你的服务器不支持 FSO(Scripting.FileSystemObject)! </li>"
		exit sub
	end if
	dim fso,hf
	set fso=Server.CreateObject(xiaodaofso)
	set hf=fso.CreateTextFile(Server.mappath("../fiveinc/hdp.asp"),true)
	hf.write "<" & "%" & vbcrlf
	hf.write "Const hdp1=" & chr(34) & trim(request("hdp1")) & chr(34) & "        '1" & vbcrlf
	hf.write "Const dizhi1=" & chr(34) & trim(request("dizhi1")) & chr(34) & "        '1" & vbcrlf
	hf.write "Const hdp2=" & chr(34) & trim(request("hdp2")) & chr(34) & "        '2" & vbcrlf
	hf.write "Const dizhi2=" & chr(34) & trim(request("dizhi2")) & chr(34) & "        '2" & vbcrlf
	hf.write "Const hdp3=" & chr(34) & trim(request("hdp3")) & chr(34) & "        '3" & vbcrlf
	hf.write "Const dizhi3=" & chr(34) & trim(request("dizhi3")) & chr(34) & "        '3" & vbcrlf
	hf.write "Const hdp4=" & chr(34) & trim(request("hdp4")) & chr(34) & "        '4" & vbcrlf
	hf.write "Const dizhi4=" & chr(34) & trim(request("dizhi4")) & chr(34) & "        '4" & vbcrlf
	
	hf.write "Const hdp5=" & chr(34) & trim(request("hdp5")) & chr(34) & "        '5" & vbcrlf
	hf.write "Const dizhi5=" & chr(34) & trim(request("dizhi5")) & chr(34) & "        '5" & vbcrlf
	hf.write "Const hdp6=" & chr(34) & trim(request("hdp6")) & chr(34) & "        '6" & vbcrlf
	hf.write "Const dizhi6=" & chr(34) & trim(request("dizhi6")) & chr(34) & "        '6" & vbcrlf
	hf.write "Const hdp7=" & chr(34) & trim(request("hdp7")) & chr(34) & "        '7" & vbcrlf
	hf.write "Const dizhi7=" & chr(34) & trim(request("dizhi7")) & chr(34) & "        '7" & vbcrlf
	hf.write "Const hdp8=" & chr(34) & trim(request("hdp8")) & chr(34) & "        '8" & vbcrlf
	hf.write "Const dizhi8=" & chr(34) & trim(request("dizhi8")) & chr(34) & "        '8" & vbcrlf
	
	hf.write "Const hdp9=" & chr(34) & trim(request("hdp9")) & chr(34) & "        '9" & vbcrlf
	hf.write "Const dizhi9=" & chr(34) & trim(request("dizhi9")) & chr(34) & "        '9" & vbcrlf
	hf.write "Const hdp10=" & chr(34) & trim(request("hdp10")) & chr(34) & "        '10" & vbcrlf
	hf.write "Const dizhi10=" & chr(34) & trim(request("dizhi10")) & chr(34) & "        '10" & vbcrlf
	hf.write "Const hdp11=" & chr(34) & trim(request("hdp11")) & chr(34) & "        '11" & vbcrlf
	hf.write "Const dizhi11=" & chr(34) & trim(request("dizhi11")) & chr(34) & "        '11" & vbcrlf
	hf.write "Const hdp12=" & chr(34) & trim(request("hdp12")) & chr(34) & "        '12" & vbcrlf
	hf.write "Const dizhi12=" & chr(34) & trim(request("dizhi12")) & chr(34) & "        '12" & vbcrlf
	hf.write "%" & ">"
	hf.close
	set hf=nothing
	set fso=nothing
	ConfigSaves=True
end sub
%>