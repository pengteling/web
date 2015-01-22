<%
option explicit
response.buffer=true	
'强制浏览器重新访问服务器下载页面，而不是从缓存读取页面
Response.Buffer = True 
Response.Expires = -1
Response.ExpiresAbsolute = Now() - 1 
Response.Expires = 0 
Response.CacheControl = "no-cache" 
%>
<!--#include file="../FiveInc/config.asp" -->
<!--#include file="../FiveInc/webconfig.asp" -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=SiteName%>--后台管理系统</title>
<script language="JavaScript" src="Inc/keyboard.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {
	margin-top: 100px;
	font-size: 12px;
}
td {
	font-size: 12px;
	line-height:20px;
	color: #666666;
}
.style1 {color: #FFFFFF}
.style2 {font-size: 12px; line-height: 1.4; color: #FFFFFF; }
a:link{font-size:12px; text-decoration:none;}
 #checkcode{color:#FFF;border:0px;background:url(images/login_06.jpg) repeat-x}
    #username{margin-top:0px;color:#FFF;border:0px;background:url(images/login_06.jpg) repeat-x}
    #password{color:#FFF;border:0px;background:url(images/login_06.jpg) repeat-x}
-->
</style>
<script language=javascript>
<!--
function SetFocus()
{
if (document.Login.UserName.value=="")
	document.Login.UserName.focus();
else
	document.Login.UserName.select();
}
function CheckForm()
{
	if(document.Login.UserName.value=="")
	{
		alert("请输入用户名！");
		document.Login.UserName.focus();
		return false;
	}
	if(document.Login.Password.value == "")
	{
		alert("请输入密码！");
		document.Login.Password.focus();
		return false;
	}
	if (document.Login.CheckCode.value==""){
       alert ("请输入您的验证码！");
       document.Login.CheckCode.focus();
       return(false);
    }
}

function CheckBrowser() 
{
  var app=navigator.appName;
  var verStr=navigator.appVersion;
  if (app.indexOf('Netscape') != -1) {
    alert("<%=SiteName%>友情提示：\n    你使用的是Netscape浏览器，可能会导致无法使用后台的部分功能。建议您使用 IE6.0 或以上版本。");
  } 
  else if (app.indexOf('Microsoft') != -1) {
    if (verStr.indexOf("MSIE 3.0")!=-1 || verStr.indexOf("MSIE 4.0") != -1 || verStr.indexOf("MSIE 5.0") != -1 || verStr.indexOf("MSIE 5.1") != -1)
      alert("<%=SiteName%>友情提示：\n    您的浏览器版本太低，可能会导致无法使用后台的部分功能。建议您使用 IE6.0 或以上版本。");
  }
}
//-->
</script>
</head>
<body oncontextmenu="javascript:return false;">
<div align="center"></div>
<table width="678" height="293" border="0" align="center" cellpadding="0" cellspacing="0" background="images/login_03.jpg">
      <tr>
        <td width="204" height="77">&nbsp;</td>
        <td width="439">&nbsp;</td>
        <td width="35">&nbsp;</td>
      </tr>
      <tr>
        <td align="left" height="216">&nbsp;</td>
		<form name="login" id="login" method="post" action="Admin_ChkLogin.asp">
        <td align="left" valign="top"><!---->
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td height="40" colspan="2" valign="bottom">
                <input name="username" type="text"  id="username" maxlength="16" />              </td>
              <td width="51%">&nbsp;</td>
            </tr>
            <tr>
              <td height="46" colspan="2" valign="center">
                <input name="password" type="password"  id="password" maxlength="16" />
              </td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td width="20%" valign="middle">
              <input type="text"  id="checkcode" name="checkCode" maxlength="5" size="6" /></td>
              <td width="17%"><img src="../FiveInc/getcode_zh.asp" alt="验证码,看不清楚?请点击刷新验证码" height="10" style="cursor : pointer;" onClick="this.src='../FiveInc/getcode_zh.asp?t='+(new Date().getTime());" /></td>
              <td></td>
            </tr>
            <tr>
              <td height="47" valign="middle" colspan="2"><input name="imageField" type="image" tabindex="4" src="images/login_10-10.jpg" width="73" height="30" border="0">&nbsp;&nbsp;<a href="javascript:window.close()"><img src="images/login_16.jpg" width="73" height="30" border="0" style="cursor:pointer" /></a></td>
              <td>&nbsp;</td>
            </tr>
          </table>
        <!----></td></form>
        <td align="left">&nbsp;</td>
      </tr>
</table>


</body>
</html> 
