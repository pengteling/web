<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>出错啦!</title>
<link href="Inc/Admin.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Refresh" content="5;URL=Login.asp" />
</head>

<body>
<table style="margin-top:50px;" width="200" border="0" align="center" cellpadding="5" cellspacing="0">
  <tr>
    <td align="center" class="blod">错误信息</td>
  </tr>
  <tr>
    <td align="left"><br />
      <span class="blue"><strong>错误的原因可能是:</strong></span><br />
    <%=Trim(Request.QueryString("Err"))%></td>
  </tr>
  <tr>
    <td align="right"><a href="Login.asp"><br />
    &lt;&lt; 返回登录页面</a></td>
  </tr>
</table>
</body>
</html>