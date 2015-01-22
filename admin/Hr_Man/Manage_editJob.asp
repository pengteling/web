<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%if Request.QueryString("mark")="southidc" then

id=request("id")
Duix=chkformstr(request("Duix"))
Rens=request("Rens")
Did=request("Did")
Daiy=request("Daiy")
Yaoq=request("Yaoq")
Qix=request("Qix")
bumen=request("bumen")
isschool=request("isschool")
workyear=request("workyear")

If Duix="" Then
response.write "SORRY <br>"
response.write "请输入职位"
response.end
end if
If Rens="" Then
response.write "SORRY <br>"
response.write "招聘人数不能为空"
response.end
end if
If Did="" Then
response.write "SORRY <br>"
response.write "工作地点不能为空"
response.end
end if
If Daiy="" Then
response.write "SORRY <br>"
response.write "联系方式不能为空"
response.end
end if
If Qix="" Then
response.write "SORRY <br>"
response.write "有效期限不能为空"
response.end
end if
If Yaoq="" Then
response.write "SORRY <br>"
response.write "录用条件不能为空"
response.end
end if

Set rs = Server.CreateObject("ADODB.Recordset")
sql="select * from Job where id="&id
rs.open sql,conn,1,3

rs("Duix")=Duix
rs("Rens")=Rens
rs("Did")=Did
rs("Daiy")=Daiy
rs("Yaoq")=Yaoq
rs("Qix")=Qix
rs("bumen")=bumen
rs("isschool")=isschool
rs("workyear")=workyear
rs.update
rs.close
response.redirect "Manage_Job.asp"
end if
%>
<%
id=request.querystring("id")
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open "Select * From Job where id="&id, conn,3,3
%>

<form name="form1" method="post" action="Manage_editJob.asp?mark=southidc&id=<% = id %>">
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
    <tr>
      <td height="25" colspan="2" align="center"><span style="font-weight: bold">修改招聘信息</span></td>
    </tr>
    
       <tr bgcolor="#ECF5FF">
      <td width="19%" height="25" align="right" bgcolor="#ECF5FF"> 招聘类型</td>
      <td width="81%"><input name="isschool" type="radio" value="0" <%if not rs("isschool") then response.write "checked"%>>社会招聘 <input name="isschool" type="radio" value="1" <%if  rs("isschool") then response.write "checked"%>>校园招聘 </td>
    </tr>
    
    <tr bgcolor="#ECF5FF">
      <td width="19%" height="25" align="right" bgcolor="#ECF5FF">招聘职位</td>
      <td width="81%"><input name="Duix" type="text" class="inputtext" id="Duix" value="<%=rs("Duix")%>" size="25" maxlength="30">      </td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="22" align="right" bgcolor="#ECF5FF">招聘部门</td>
      <td><input name="bumen" type="text" class="inputtext" id="bumen" size="25" maxlength="50" value="<%=rs("bumen")%>"></td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="22" align="right" bgcolor="#ECF5FF"> 招聘人数</td>
      <td bgcolor="#ECF5FF"><input name="Rens" type="text" class="inputtext" id="Rens" value="<%=rs("Rens")%>" size="5" maxlength="30">
        人</td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="22" align="right" bgcolor="#ECF5FF"> 工作地点</td>
      <td height="-4" bgcolor="#ECF5FF"><input name="Did" type="text" class="inputtext" id="Did" value="<%=rs("Did")%>" size="30" maxlength="50">      </td>
    </tr>
     <tr bgcolor="#ECF5FF">
      <td height="22" align="right" bgcolor="#ECF5FF"> 学历要求</td>
      <td height="-4" bgcolor="#ECF5FF"><input name="workyear" type="text" class="inputtext" id="workyear" value="<%=rs("workyear")%>" size="30" maxlength="50"> 如：本科以上     </td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="22" align="right" bgcolor="#ECF5FF">联系方式</td>
      <td height="-1" bgcolor="#ECF5FF"><input name="Daiy" type="text" class="inputtext" id="Daiy" value="<%=rs("Daiy")%>" size="20" maxlength="50">      </td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="22" align="right" bgcolor="#ECF5FF"> 发布日期</td>
      <td height="-3"><%=Date()%></td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="22" align="right" bgcolor="#ECF5FF"> 有效期限</td>
      <td height="0" bgcolor="#ECF5FF"><input name="Qix" type="text" class="inputtext" id="Qix" value="<%=rs("Qix")%>" size="5" maxlength="30">
        天</td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="22" align="right" bgcolor="#ECF5FF">职位描述</td>
      <td height="10"><textarea name="Yaoq" cols="40" rows="5" class="inputtext" id="Yaoq"><%=rs("Yaoq")%></textarea></td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="25" colspan="2" align="center"><input name="submit" type="submit" value="确认修改">
        &nbsp;
        <input name="reset" type="button" value="返回上一页" onClick="history.go(-1);">      </td>
    </tr>
  </table>
</form>
<!-- #include file="../Inc/Foot.asp" -->