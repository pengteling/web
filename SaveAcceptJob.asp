<!--#include file="FiveInc/Inc.asp"-->
<%
ChkPost
If Session("RandomNumber")="" Or IsEmpty(Session("RandomNumber")) Or IsNull(Session("RandomNumber")) Then
	'response.write"<SCRIPT language=JavaScript>alert('禁止重复提交！');"
	'response.write"location.href=""acceptJob.asp"";</SCRIPT>"
	'response.End()
End If
upfilepath		=Trim(Sqlbad(Request("upfilepath")))
jobname		=Trim(Sqlbad(Request("jobname")))
mane		=Trim(Sqlbad(Request("mane")))
sex			=Trim(Sqlbad(Request("sex")))
birthday	=Trim(Sqlbad(Request("birthday")))
marry		=Trim(Sqlbad(Request("marry")))
school		=Trim(Sqlbad(Request("school")))
studydegree	=Trim(Sqlbad(Request("studydegree")))
specialty	=Trim(Sqlbad(Request("specialty")))
gradyear	=Trim(Sqlbad(Request("gradyear")))
telephone	=Trim(Sqlbad(Request("telephone")))
email		=Trim(Sqlbad(Request("email")))
address		=Trim(Sqlbad(Request("address")))
ability		=Trim(ChkFormStr(Request("ability")))
resumes		=Trim(ChkFormStr(Request("resumes")))

If jobname="" Then
Response.Write("<script language=""JavaScript"">alert(""错误：您没输入应聘岗位，请返回检查！！"");history.go(-1);</script>")
response.end
end if
If mane="" Then
Response.Write("<script language=""JavaScript"">alert(""错误：您没输入姓名，请返回检查！！"");history.go(-1);</script>")
response.end
end if
If sex="" Then
Response.Write("<script language=""JavaScript"">alert(""错误：您没输入性别，请返回检查！！"");history.go(-1);</script>")
response.end
end if
If birthday="" Then
Response.Write("<script language=""JavaScript"">alert(""错误：您没输入出生日期，请返回检查！！"");history.go(-1);</script>")
response.end
end if
If marry="" Then
Response.Write("<script language=""JavaScript"">alert(""错误：您没输入婚姻状况，请返回检查！！"");history.go(-1);</script>")
response.end
end if
'If school="" Then
'Response.Write("<script language=""JavaScript"">alert(""错误：您没输入毕业院校，请返回检查！！"");history.go(-1);</script>")
'response.end
'end if
'If studydegree="" Then
'Response.Write("<script language=""JavaScript"">alert(""错误：您没输入学 历，请返回检查！！"");history.go(-1);</script>")
'response.end
'end if
'If specialty="" Then
'Response.Write("<script language=""JavaScript"">alert(""错误：您没输入专 业，请返回检查！！"");history.go(-1);</script>")
'response.end
'end if
'If gradyear="" Then
'Response.Write("<script language=""JavaScript"">alert(""错误：您没输入毕业时间，请返回检查！！"");history.go(-1);</script>")
'response.end
'end if
If telephone="" Then
Response.Write("<script language=""JavaScript"">alert(""错误：您没输入电 话，请返回检查！！"");history.go(-1);</script>")
response.end
end if
If email="" Then
Response.Write("<script language=""JavaScript"">alert(""错误：您没输入E-mail，请返回检查！！"");history.go(-1);</script>")
response.end
end if
'If address="" Then
'Response.Write("<script language=""JavaScript"">alert(""错误：您没输入联系地址，请返回检查！！"");history.go(-1);</script>")
'response.end
'end if
'If ability="" Then
'Response.Write("<script language=""JavaScript"">alert(""错误：您没输入水平与能力，请返回检查！！"");history.go(-1);</script>")
'response.end
'end if
'If resumes="" Then
'Response.Write("<script language=""JavaScript"">alert(""错误：您没输入个人简历，请返回检查！！"");history.go(-1);</script>")
'response.end
'end if

Set rs = Server.CreateObject("ADODB.Recordset")
sql="select * from jobbook"
rs.open sql,conn,1,3
rs.addnew
	rs("upfilepath")=upfilepath
	rs("jobname")=jobname
	rs("mane")=mane
	rs("sex")=sex
	rs("birthday")=birthday
	rs("marry")=marry
	rs("school")=school
	rs("studydegree")=studydegree
	rs("specialty")=specialty
	rs("gradyear")=gradyear
	rs("telephone")=telephone
	rs("email")=email
	rs("address")=address
	rs("ability")=ability
	rs("resumes")=resumes
	rs("time")=now()
rs.update
rs.close
set rs=Nothing
Call CloseConn
  Session("RandomNumber")=""
  response.write"<SCRIPT language=JavaScript>alert('应聘申请已提交成功！');"
  response.write"location.href=""Job.asp"";</SCRIPT>"
  response.End()
%>