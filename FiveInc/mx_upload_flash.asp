
<%
uppath=request("uppath")&"/"		'文件上传路径
filelx=request("filelx")				'文件上传类型
formName=request("formName")			'回传到上页面编辑框所在Form的Name
EditName=request("EditName")			'回传到上页面编辑框的Name
%>
<html>
<head>
<title>图片上传</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script language="javascript">
<!--
function mysub()
{
		esave.style.visibility="visible";
}
-->
</script>
<link href="style1.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
body,td,th {
	font-size: 12px;
}
body {
	margin-left: 0px;
	margin-top: 0px;
}
form{

margin:0px;
}
-->
</style></head>

<body text="#000000">
<form name="form1" method="post" action="mx_upfile_flash.asp" enctype="multipart/form-data" >
  <div id="esave" style="position:absolute; top:18px; left:40px; z-index:10; visibility:hidden"> 
    <TABLE WIDTH=340 BORDER=0 CELLSPACING=0 CELLPADDING=0>
      <TR><td width=20%></td>
	<TD bgcolor=#104A7B width="60%"> 
	<TABLE WIDTH=100% height=120 BORDER=0 CELLSPACING=1 CELLPADDING=0>
	<TR> 
	          <td bgcolor=#eeeeee align=center><font color=red>正在上传文件，请稍候...</font></td>
	</tr>
	</table>
	</td><td width=20%></td>
	</tr></table></div>
  <table width="400" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="#CCCCCC" class="TableBorder">
    <tr> 
      <td width="400" height="22" align="center" valign="middle" bgcolor="#f1f1f1" class="TableTitle1">&nbsp;文件上传 
        <input type="hidden" name="filepath" value="<%=uppath%>">
        <input type="hidden" name="filelx" value="<%=filelx%>">
        <input type="hidden" name="EditName" value="<%=EditName%>">
        <input type="hidden" name="FormName" value="<%=formName%>">
        <input type="hidden" name="act" value="uploadfile"></td>
    </tr>
    <tr align="center" valign="middle"> 
      <td width="400" height="80" align="left" bgcolor="#FFFFFF" class="TableBody1" id="upid"> 选择文件: 
        <input type="file" name="file1" style="width:300'"  class="wenbenkuang" value="">
      </td>
    </tr>
    <tr align="center" valign="middle"> 
      <td width="400" height="24" bgcolor="#f1f1f1" class="TableBody1"> 
        <input type="submit" name="Submit" value="开始上传" class="go-wenbenkuang" onClick="javascript:mysub()">
      </td>
    </tr>
  </table></form>

</body>
</html>
