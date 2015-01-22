<!--#include file="../FiveInc/conn.asp"-->
<!--#include file="admin.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台管理系统</title>
<meta http-equiv="Window-target" content="_top">
</head>

<frameset id="topmain" rows="33,*" cols="777*" frameborder="no" border="0" framespacing="0">
  
  <frame src="admin_top.asp" title="undefined" scrolling="no" />
  
  <frameset rows="*" cols="200,10,*" id="index" framespacing="0" frameborder="yes" border="0">
		<frame src="LeftTree.asp" name="leftFrame" scrolling="auto" frameborder="0" noresize="noresize" id="leftFrame" title="leftFrame" />
		<frame src="control.htm" name="control" scrolling="No" noresize="noresize" id="middleFrame" title="control" />
		<frame src="admin_main.asp" name="mainFrame" id="mainFrame" title="mainFrame" />
  </frameset>
</frameset>
<noframes><body>
</body>
</noframes></html>
