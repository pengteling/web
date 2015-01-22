<!--#include file="../FiveInc/conn.asp"-->
<!--#include file="Admin.asp"-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SystemCompany%>后台管理系统</title>
<style type="text/css">
<!--
body {
	background-image: url();
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
body,td,th {
	font-size: 12px;
}
-->
</style></head>

<body>
<table width="100%" height="34" border="0" cellpadding="0" cellspacing="0" background="images/top_bg.gif">
  <tr>
    <td width="21%"><img src="images/top_logo.gif" width="210" height="32" /></td>
    <td><font color="#FFFFFF"><b>欢迎 <%=session("AdminName")%> 进入后台管理面板</b></font>&nbsp;&nbsp;&nbsp;&nbsp;</font></a><a href="http://www.webl.cn" target="_blank"></a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="clear.asp" target="mainFrame"><font color="#FFFFFF"><b>清除缓存</b></font></a>&nbsp;&nbsp;&nbsp;&nbsp;<font color="#FFFFFF"><b>快捷方式:</b></font>&nbsp;<a href="../index.asp" target="_blank"><font color="#FFFFFF"><b>前台首页</b></font></a>&nbsp;&nbsp;<font color="#FFFFFF"><b>|</b></font>&nbsp;&nbsp;<a href="Loginout.asp" target="_top"><font color="#FFFFFF"><b>退出管理</b></font></a></td>
  </tr>
</table>
</body>
</html>
