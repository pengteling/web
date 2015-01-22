<!--#include file="../FiveInc/conn.asp"-->
<!--#include file="Admin.asp"-->
<HTML>
<HEAD>
<TITLE><%=SiteName%></TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<style type="text/css">
<!--
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
body,html {
	background-color: #FFFFFF;
	overflow:auto;
	overflow-x:hidden;
	SCROLLBAR-FACE-COLOR: #6a84ae;
	SCROLLBAR-HIGHLIGHT-COLOR: #aaaaff;
	SCROLLBAR-SHADOW-COLOR: #335997;
	SCROLLBAR-3DLIGHT-COLOR: #335997;
	SCROLLBAR-ARROW-COLOR: #ffffff;
	SCROLLBAR-TRACK-COLOR: #335997;
	SCROLLBAR-DARKSHADOW-COLOR: black;
}
-->
</style>
</HEAD>
<style>
a{text-decoration: none;} /* ,underline */ 
a:link {color: #000000;} /*  */
a:visited {color: #000000;} /*  */
a:hover{color: #FF0000;} /*  */ 
a:active {color: #FF0000;} /*  */
/*BodyCSS*/
td	{font-size: 12px; color: #000000; text-decoration:none ; text-decoration:none ; }
</style>
<BODY LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0 scroll=yes oncontextmenu="javascript:return false;">
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0" style="padding:4px 0 10px 0;">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="1"></td>
      </tr>
    </table>
        <table width="699" height="45" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CDCDCD">
          <tr bgcolor="#FAFAFA">
            <td width="56%" height="43"><table width="100%" border="0" align="center" cellpadding="5" cellspacing="0">
                <tr>
                  <td width="69%">欢迎使用<%=SystemCompany%>管理系统<span class="style1">)</span>当前版本:<font color="#FF0000"><%=systemVersion%></font></td>
                </tr>
            </table></td>
            <td width="44%" height="43" bgcolor="#FAFAFA"><marquee   onMouseOut=start() onMouseOver=stop()  scrolldelay=20 scrollamount=1 direction="up" height="45">
              程序开发：<%=SystemWeb%>
              </marquee>            </td>
          </tr>
        </table>
      <table width="699" height="30" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CDCDCD" style="margin:2px 0 0 0;">
          <tr>
            <td height="30" bgcolor="#FFFFFF"><font color="#006699">　<font color="#006699"><strong>系统管理说明：</strong></font></font></td>
          </tr>
          <tr>
            <td style="line-height:20px;" bgcolor="#FFFFFF">
			　·修改系统配置 (网站名称,关键字,联系电话等)<br>
			　·修改公司简介 (选择一个项目进行内容修改)<br>
            　·添加文章信息 (选择文章属于哪一个栏目)<br>
			　·添加/修改管理员帐号 (本系统同一帐号同一时间只能一人使用)<br>			</td>
          </tr>
        </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="1"></td>
          </tr>
        </table>
      <table width="699" height="270" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CDCDCD">
          <tr bgcolor="#FAFAFA">
            <td height="30" colspan="2">　<font color="#006699"><strong>服务器信息</strong><font color="#006699"><strong>：</strong></font></font></td>
          </tr>
          <tr bgcolor="#FAFAFA">
            <td height="32">　服务器类型：<font face="Verdana, Arial, Helvetica, sans-serif"><%=Request.ServerVariables("OS")%>(IP:<%=Request.ServerVariables("LOCAL_ADDR")%>)</font></td>
            <td height="32">　站点物理路径<font face="Verdana, Arial, Helvetica, sans-serif">：<%=request.ServerVariables("APPL_PHYSICAL_PATH")%></font></td>
          </tr>
          <tr bgcolor="#FAFAFA">
            <td width="48%" height="32">　返回服务器的主机名，<font face="Verdana, Arial, Helvetica, sans-serif">IP</font>地址<font face="Verdana, Arial, Helvetica, sans-serif">：<font color=#0076AE><%=Request.ServerVariables("SERVER_NAME")%></font></font></td>
            <td width="52%" height="32">　服务器操作系统<font face="Verdana, Arial, Helvetica, sans-serif">：<font color=#0076AE><%=Request.ServerVariables("OS")%></font></font></td>
          </tr>
          <tr bgcolor="#FAFAFA">
            <td width="48%" height="32">　脚本解释引擎<span class="small2">：</span><font face="Verdana, Arial, Helvetica, sans-serif"><%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %>　</font></td>
            <td width="52%" height="37">　<span class="small2"><font face="Verdana, Arial, Helvetica, sans-serif">WEB</font></span>服务器的名称和版本<font face="Verdana, Arial, Helvetica, sans-serif">：<font color=#0076AE><%=Request.ServerVariables("SERVER_SOFTWARE")%></font></font></td>
          </tr>
          <tr bgcolor="#FAFAFA">
            <td width="48%" height="32">　脚本超时时间<span class="small2">：</span><font color=#0076AE><%=Server.ScriptTimeout%></font> 秒</td>
            <td width="52%" height="32">　<font face="Verdana, Arial, Helvetica, sans-serif">CDONTS</font>组件支持<span class="small2">：</span>
         <%
	    on error resume next
	    Server.CreateObject("CDONTS.NewMail")
		if err=0 then 
		  response.write("<font color=#0076AE>√</font>")
		else
          response.write("<font color=red>×</font>")
		end if	 
		err=0
	  	%>            </td>
          </tr>
          <tr bgcolor="#FAFAFA">
            <td width="48%" height="32">　虚拟路径<font face="Verdana, Arial, Helvetica, sans-serif">：<%=Request.ServerVariables("SCRIPT_NAME")%></font></td>
            <td width="52%" height="32">　<font face="Verdana, Arial, Helvetica, sans-serif"><span class="small2">Jmail</span></font>邮箱组件支持<span class="small2"><font face="Verdana, Arial, Helvetica, sans-serif">：</font></span>
                <%If Not IsObjInstalled("JMail.Message") Then%>
                <font color="red">×</font>
                <%else%>
                <font color="0076AE"> √</font>
                <%end if%>            </td>
          </tr>
          <tr bgcolor="#FAFAFA">
            <td height="32">　返回服务器处理请求的端口<font face="Verdana, Arial, Helvetica, sans-serif">：<%=Request.ServerVariables("SERVER_PORT")%></font></td>
            <td height="32">　协议的名称和版本<font face="Verdana, Arial, Helvetica, sans-serif">：<%=Request.ServerVariables("SERVER_PROTOCOL")%></font></td>
          </tr>
          <tr bgcolor="#FAFAFA">
            <td height="32">　服务器 <font face="Verdana, Arial, Helvetica, sans-serif">CPU</font> 数量<font face="Verdana, Arial, Helvetica, sans-serif">：<%=Request.ServerVariables("NUMBER_OF_PROCESSORS")%></font> 个　</td>
            <td height="32">　客户端操作系统：
              <%
dim thesoft,vOS
thesoft=Request.ServerVariables("HTTP_USER_AGENT")
if instr(thesoft,"Windows NT 5.0") then
	vOS="Windows 2000"
elseif instr(thesoft,"Windows NT 5.2") then
	vOs="Windows 2003"
elseif instr(thesoft,"Windows NT 5.1") then
	vOs="Windows XP"
elseif instr(thesoft,"Windows NT") then
	vOs="Windows NT"
elseif instr(thesoft,"Windows 9") then
	vOs="Windows 9x"
elseif instr(thesoft,"unix") or instr(thesoft,"linux") or instr(thesoft,"SunOS") or instr(thesoft,"BSD") then
	vOs="类Unix"
elseif instr(thesoft,"Mac") then
	vOs="Mac"
else
	vOs="Other"
end if
response.Write(vOs)
%>            </td>
          </tr>
        </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="1"></td>
          </tr>
        </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="1"></td>
          </tr>
        </table>
      <table width="699" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CDCDCD">
          <tr bgcolor="#FAFAFA">
            <td height="30" colspan="2">　<font color="#006699"><strong>本系统需要的软件环境：</strong></font></td>
          </tr>
          <tr bgcolor="#FAFAFA">
            <td width="48%" height="25">　<font face="Verdana, Arial, Helvetica, sans-serif">JRO.JetEngine(ACCESS</font><font face="Verdana, Arial, Helvetica, sans-serif">&nbsp; </font> 数据库<span class="small2"><font face="Verdana, Arial, Helvetica, sans-serif">)</font>：</span>
                <%
	    'on error resume next
	    Server.CreateObject("JRO.JetEngine")
		if err=0 then 
		  response.write("<font color=#0076AE>√</font>")
		else
          response.write("<font color=red>×</font>")
		end if	 
		err=0
	  %>            </td>
            <td width="52%" height="25">　数据库使用<span class="small2">：</span>
                <%
	    'on error resume next
	    Server.CreateObject("adodb.connection")
		if err=0 then 
		  response.write("<font color=#0076AE>√,可以使用本系统</font>")
		else
          response.write("<font color=red>×,不能使用本系统</font>")
		end if	 
		err=0
	  %>            </td>
          </tr>
          <tr bgcolor="#FAFAFA">
            <td height="25">　<span class="small2"><font face="Verdana, Arial, Helvetica, sans-serif">FSO</font></span>文本文件读写<span class="small2">：</span>
                <%
	    'on error resume next
	    Server.CreateObject(xiaodaofso)
		if err=0 then 
		  response.write("<font color=#0076AE>√,可以使用本系统</font>")
		else
          response.write("<font color=red>×，不能使用此系统</font>")
		end if	 
		err=0
	  %>            </td>
            <td height="25">　Microsoft.XMLHTTP
              <%If Not IsObjInstalled("Microsoft.XMLHTTP") Then%>
                <font color="red">×，不能使用此系统</font>
                <%else%>
                <font color="0076AE"> √,可以使用本系统</font>
                <%end if%>
              Adodb.Stream
              <%If Not IsObjInstalled("Adodb.Stream") Then%>
              <font color="red">×</font>
              <%else%>
              <font color="0076AE"> √</font>
              <%end if%>            </td>
          </tr>
        </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="1"></td>
          </tr>
        </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="1"></td>
          </tr>
        </table>
      <table width="699" height="79" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CDCDCD">
          <tr bgcolor="#FAFAFA">
            <td height="30" colspan="2"><font color="#006699">　<font color="#006699"><strong>联系信息：</strong></font></font></td>
          </tr>
          <tr bgcolor="#FAFAFA">
            <td width="48%" height="25">　<font face="Verdana, Arial, Helvetica, sans-serif">官方站点：<a href="<%=SystemWeb%>" target="_blank"><%=SystemWeb%></a></font> </td>
            <td width="52%" height="25">　技术支持<span class="small2">：</span> <span class="small2"><%=SystemQQ%></span> <span class="small2"><a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=<%=SystemQQ%>&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:<%=SystemQQ%>:41" alt="点击这里给我发消息" title="点击这里给我发消息"></a></span> </td>
          </tr>
          <tr bgcolor="#FAFAFA">
            <td height="25">　<font face="Verdana, Arial, Helvetica, sans-serif">电子邮件： <%=SystemEmail%> </font> </td>
            <td height="25">　<font face="Verdana, Arial, Helvetica, sans-serif">联系电话：<%=SystemTel%></font></td>
          </tr>
      </table></td>
  </tr>
</table>
</BODY>
</HTML>
<%'Request.ServerVariables("Http_Host")&Request.ServerVariables("path_info")%>
<%call connclose()%>