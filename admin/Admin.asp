<%
dim ComeUrl,cUrl,AdminName
FoundErr=false
ComeUrl=lcase(trim(request.ServerVariables("HTTP_REFERER")))
If ComeUrl="" then
	'response.write "<script>top.location.href="""&systemroot&SiteManage&"/login.asp"";</script>"
	'response.End()
End If
AdminID=strToNum(CheckSQL(Trim(session("AdminID"))))
AdminName=CheckSQL(Trim(session("AdminName")))
AdminPassword=CheckSQL(Trim(session("AdminPassword")))
AdminRndPassword=CheckSQL(Trim(session("RndPassword")))
If AdminID="" or Isnull(AdminID) or IsEmpty(AdminID) or AdminName="" or Isnull(AdminName) or IsEmpty(AdminName) or AdminPassword="" or Isnull(AdminPassword) or IsEmpty(AdminPassword) or AdminRndPassword="" or Isnull(AdminRndPassword) or IsEmpty(AdminRndPassword) then
	Call CloseConn()
	FoundErr=True
	ErrMsg=ErrMsg & "<li>您未登录或登录超时！</li><br>"
    Response.Write "<script>top.location.href="""&systemroot&SiteManage&"/login.asp"";</script>"
Else
	ChkSql="select UserName,sonid from zh_Admin where ID="&AdminID&" And UserName='" & session("AdminName") & "' and Password='" & session("AdminPassword") & "' And RndPassword='"&AdminRndPassword&"'"
	set CheckRs=conn.execute(ChkSql)
	If CheckRs.eof and CheckRs.bof then
  		CheckRs.close:Set CheckRs=Nothing
		Call CloseConn()
	 	FoundErr=True
  		ErrMsg=ErrMsg & "<li>您未登录或登录超时！</li><br>"
  		ErrMsg=ErrMsg & "<li>此帐号在其它地方登录！</li><br>"
	else
		sonid_restrict =CheckRs("sonid")
	End If
	
End If

If FoundErr=True Then
	Response.Write "<script>top.location.href="""&systemroot&SiteManage&"/Error.asp?Err="&Server.URLEncode(ErrMsg)&""";</script>"
	Response.End()
End If
%>