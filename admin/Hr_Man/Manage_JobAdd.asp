<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->

<%if Request.QueryString("mark")="southidc" then%>
<%
Duix=(Trim(Request("Duix")))
Rens=(Trim(Request("Rens")))
Did=(Trim(Request("Did")))
Daiy=(Trim(Request("Daiy")))
Yaoq=(Trim(Request("Yaoq")))
Qix=(Trim(Request("Qix")))
bumen=(Trim(Request("bumen")))
isschool=Request("isschool")
workyear=Request("workyear")
%>
<%
If Duix="" Then
response.write "SORRY <br>"
response.write "内容不能为空!!<a href=""javascript:history.go(-1)"">返回重输</a>"
response.end
end if
If Rens="" Then
response.write "SORRY <br>"
response.write "内容不能为空!!<a href=""javascript:history.go(-1)"">返回重输</a>"
response.end
end if
If Did="" Then
response.write "SORRY <br>"
response.write "内容不能为空!!<a href=""javascript:history.go(-1)"">返回重输</a>"
response.end
end if
If Daiy="" Then
response.write "SORRY <br>"
response.write "内容不能为空!!<a href=""javascript:history.go(-1)"">返回重输</a>"
response.end
end if
If Yaoq="" Then
response.write "SORRY <br>"
response.write "内容不能为空!!<a href=""javascript:history.go(-1)"">返回重输</a>"
response.end
end if
If Qix="" Then
response.write "SORRY <br>"
response.write "内容不能为空!!<a href=""javascript:history.go(-1)"">返回重输</a>"
response.end
end if

Set rs = Server.CreateObject("ADODB.Recordset")
sql="select * from Job "
rs.open sql,conn,1,3
rs.addnew
rs("Duix")=left(Duix,50)
rs("Rens")=Rens
rs("Did")=Did
rs("Daiy")=Daiy
rs("Yaoq")=Yaoq
rs("Qix")=Qix
rs("bumen")=left(bumen,20)
rs("isschool")=isschool
rs("workyear")=workyear
rs.update
rs.close
response.redirect "Manage_Job.asp"
end if
%>
<!-- #include file="../Inc/Head.asp" -->
<form name="form1" method="post" action="Manage_JobAdd.asp?mark=southidc">
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
    <tr>
      <td height="25" colspan="2" align="center">发布招聘信息</td>
    </tr>
      <tr bgcolor="#ECF5FF">
      <td width="19%" height="25" align="center" bgcolor="#ECF5FF"> 招聘类型</td>
      <td width="81%"><input name="isschool" type="radio" value="0" checked>社会招聘 <input name="isschool" type="radio" value="1">校园招聘 </td>
    </tr>
    
    <tr bgcolor="#ECF5FF">
      <td width="19%" height="25" align="center" bgcolor="#ECF5FF"> 招聘职位</td>
      <td width="81%"><input name="Duix" type="text" class="inputtext" id="Duix" size="25" maxlength="30"></td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="22" align="center" bgcolor="#ECF5FF">招聘部门</td>
      <td><input name="bumen" type="text" class="inputtext" id="bumen" size="25" maxlength="50"></td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="22" align="center" bgcolor="#ECF5FF"> 招聘人数</td>
      <td><input name="Rens" type="text" class="inputtext" id="Rens" size="5" maxlength="30">
        人</td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="22" align="center" bgcolor="#ECF5FF"> 工作地点</td>
      <td height="-4"><input name="Did" type="text" class="inputtext" id="Did" value="" size="30" maxlength="50">     </td>
    </tr>
     <tr bgcolor="#ECF5FF">
      <td height="22" align="center" bgcolor="#ECF5FF"> 学历要求</td>
      <td height="-4"><input name="workyear" type="text" class="inputtext" id="workyear"  size="30" maxlength="50"> 如：本科以上 </td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="22" align="center" bgcolor="#ECF5FF"> 联系方式</td>
      <td height="-1" bgcolor="#ECF5FF"><input name="Daiy" type="text" class="inputtext" id="Daiy" size="20" maxlength="50">      </td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="22" align="center" bgcolor="#ECF5FF"> 发布日期</td>
      <td height="-3"><%=Date()%></td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="22" align="center" bgcolor="#ECF5FF"> 有效期限</td>
      <td height="0"><input name="Qix" type="text" class="inputtext" id="Qix" size="5" maxlength="30">
        天</td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="22" align="center" bgcolor="#ECF5FF">职位描述</td>
      <td height="10"><textarea name="Yaoq" cols="40" rows="5" class="inputtext" id="Yaoq"></textarea></td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="25" colspan="2" align="center" bgcolor="#ECF5FF"><input name="submit" type="submit" value="确认发布">
        &nbsp;
        <input name="reset" type="button" value="返回上一页" onClick="history.go(-1);"></td>
    </tr>
  </table>
</form>
<!-- #include file="../Inc/Foot.asp" -->