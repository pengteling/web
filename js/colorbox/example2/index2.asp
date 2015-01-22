<!--#include file="FiveInc/Inc.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title><%=SiteTitle%>-首页</title>
<!--#include file="head.asp"-->
<style type="text/css">
.halfalpha { background-color: #ffffff; filter: Alpha(Opacity=60);}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-image: url(../images/body_bg.jpg);
	background-position:top;
	background-repeat:repeat-x;
}
</style>
<script src="css/ScrollPic.js" type="text/javascript"></script>
</head>

<body>
<!--#include file="top.asp"-->
<table width="1003" border="0" align="center" cellpadding="0" cellspacing="0" style=" margin-top:-3px;">
  <tr>
    <td><table width="1003" height="301"  border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td height="160"><table width=1003 border=0 cellpadding=0 cellspacing=0>
  <tr valign=top>
    <td colspan=3><a onClick="gotoshow()" onMouseOver="tu_ove()" onMouseOut="ou()" style="cursor:hand"><img src="<%=hdp1%>" width=1003 height=301 name="slide" border=0></a></td>
 </tr></table><div style="position:relative"><div  style="position:absolute;top:-24px"><table width=1003 border=0 cellpadding=0 cellspacing=0>
  <tr>
    <td width=808 height="19" align=center class="white middle"><div class="halfalpha" id=textslide style="padding-top:0px; height:22px; width:808px; line-height:22px; font-weight:bold; font-size:14px; display:none;">焦点图标题层</div></td>
    <td width=95 height="19"><table width=120 border=0 cellpadding=0 cellspacing=0>
      <tr valign=top>
        <td width="24" height="24"><a style="cursor:hand" onMouseOver="ove(0)" onMouseOut="ou()"><img src="images/png/1.png" width="20" height="24" id="xttxd1" border=0></a></td>
        <td width="24" height="24"><a style="cursor:hand" onMouseOver="ove(1)" onMouseOut="ou()"><img src="images/png/2.png" width="20" height="24" id="xttxd2" border=0></a></td>
        <td width="24" height="24"><a style="cursor:hand" onMouseOver="ove(2)" onMouseOut="ou()"><img src="images/png/3.png" width="20" height="24" id="xttxd3" border=0></a></td>
        <td width="24" height="24"><a style="cursor:hand" onMouseOver="ove(3)" onMouseOut="ou()"><img src="images/png/4.png" width="20" height="24" id="xttxd4" border=0></a></td>
        <td width="24" height="24"><a style="cursor:hand" onMouseOver="ove(4)" onMouseOut="ou()"><img src="images/png/5.png" width="20" height="24" id="xttxd5" border=0></a></td>
      </tr>
    </table></td>
  </tr>
</table></div></div>
<script type="text/javascript">
//slideimages数组为变换的图
var slideimages=new Array();

slideimages[0]="<%=hdp1%>";
slideimages[1]="<%=hdp2%>";
slideimages[2]="<%=hdp3%>";
slideimages[3]="<%=hdp4%>";
slideimages[4]="<%=hdp5%>";

//slidetext数组为变换的文字
var slidetext=new Array();
slidetext[0]="<%=titlebt1%>";
slidetext[1]="<%=titlebt2%>";
slidetext[2]="<%=titlebt3%>";
slidetext[3]="<%=titlebt4%>";
slidetext[4]="<%=titlebt5%>";

//slidetext数组为点击大图后跳到的地址
var slidelinks=new Array();
slidelinks[0]="<%=dizhi1%>";
slidelinks[1]="<%=dizhi2%>";
slidelinks[2]="<%=dizhi3%>";
slidelinks[3]="<%=dizhi4%>";
slidelinks[4]="<%=dizhi5%>";
</script>
<script language=JavaScript src="css/5adpics.js"></script></td>    </tr>
		</table></td>
  </tr>
</table>
<table width="1003" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="156"><table width="100%" height="259" border="0" cellpadding="0" cellspacing="0" style="border:1px #E6E6E6 solid; border-top:0px;">
      <tr>
        <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
          <tr>
            <td height="25" class="dhon" onclick="dhshow(1)" id="d1"><img src="images/r/dhon_01.jpg" width="48" height="18" /></td>
          </tr>
          
        </table>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" id="x1">
            <%Msql = "Select top 6 *  From Company Where IsHome=1 And ParentID=33 Order By OrderID,ID"
                    Set ComRs=server.CreateObject("ADODB.Recordset")
                    ComRs.open Msql,conn,3,2
                    If Not ComRs.Eof Then
						do While not ComRs.Eof
					%>
					
<tr>
              <td height="28" class="dhsb_out" onmouseover="this.className='dhsb_on'" onmouseout="this.className='dhsb_out'">
<%If ComRs("IsOutLink")=1 Then%>
<a href="<%=ComRs("OutLinkUrl")%>"><%=CutStr(ComRs("ComName"),18)%></a>
<%Else%>
<a href="Company.asp?id=<%=ComRs("id")%>"><%=CutStr(ComRs("ComName"),18)%></a>
<% End If%></td>
            </tr>

                    <%
					ComRs.moveNext
					Loop
					End If
					ComRs.Close
					Set ComRs = Nothing%>
            
          </table>
          
		  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:5px;">
            <tr>
              <td height="25"  class="dhout" onclick="dhshow(3)" id="d3"><a href="Company.asp?id=14"><img src="images/r/dhon_03.jpg" width="48" height="18" border="0" /></a></td>
            </tr>
          </table>
		  <table width="100%" border="0" cellspacing="0" id="x3" cellpadding="0" style="display:none;">
<%
	Set PicLinkRs = conn.execute("Select top 6 * from Links where linktype=1 Order By pxu Desc")
	Do while Not PicLinkRs.Eof
	%>
<tr>
 <td height="28" class="dhsb_out" onmouseover="this.className='dhsb_on'" onmouseout="this.className='dhsb_out'"><a href="<%=PicLinkRs("Link")%>" target="_blank" title="<%=PicLinkRs("Note")%>"><%=CutStr(PicLinkRs("name"),18)%> </a></td>
</tr>
<%
	PicLinkRs.MoveNext
	Loop
	PicLinkRs.Close
	%>

          </table>
		  <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:5px;">
            <tr>
              <td height="25" class="dhout" onclick="dhshow(2)" id="d2"><a href="Company.asp?id=58"><img src="images/r/dhon_02.jpg" width="48" height="18" border="0" /></a></td>
            </tr>
          </table>
		  <table width="100%" border="0" cellspacing="0" cellpadding="0" id="x2" style="display:none;">
            
			<%Msql = "Select top 6 *  From Company Where IsHome=1 And ParentID=58 Order By OrderID,ID"
                    Set ComRs=server.CreateObject("ADODB.Recordset")
                    ComRs.open Msql,conn,3,2
                    If Not ComRs.Eof Then
						do While not ComRs.Eof
					%>
					
<tr>
              <td height="28" class="dhsb_out" onmouseover="this.className='dhsb_on'" onmouseout="this.className='dhsb_out'">
<%If ComRs("IsOutLink")=1 Then%>
<a href="<%=ComRs("OutLinkUrl")%>"><%=CutStr(ComRs("ComName"),18)%></a>
<%Else%>
<a href="Company.asp?id=<%=ComRs("id")%>"><%=CutStr(ComRs("ComName"),18)%></a>
<% End If%></td>
            </tr>

                    <%
					ComRs.moveNext
					Loop
					End If
					ComRs.Close
					Set ComRs = Nothing%>
			
          </table>
		  </td>
      </tr>
	  <script type="text/javascript">
	  function dhshow(objt){ 
for( var ycaos=1;ycaos<=3;ycaos++)
				 {
				 if(ycaos!=objt)
				 {
				 document.getElementById("x"+ycaos).style.display = 'none'; 
				 document.getElementById("d"+ycaos).className = 'dhout'; 
				 }
				 else
				 {
				 document.getElementById("x"+ycaos).style.display = 'block';
				 document.getElementById("d"+ycaos).className = 'dhon';}
				 }
            } 
	  </script>
    </table></td>
    <td width="653" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-bottom:1px #E6E6E6 solid;">
      <tr>
        <td><table width="626" border="0" cellspacing="0" cellpadding="0" style="margin-left:19px;">
          <tr>
            <td height="35"><img src="images/r/jianjie.jpg" width="83" height="20" /></td>
            <td align="right" valign="top" style="font-weight:bold;"><a href="Company.asp?id=1"><img src="images/xiangxi.jpg" width="39" height="14" border="0" /></a></td>
          </tr>
          <tr>
            <td height="83" colspan="2" valign="top" style="line-height:24px; background:url(images/i_jjbg.jpg); background-repeat:no-repeat; padding:2px 10px 0px 10px;;"><%Call ShowCompany(1,280,1)%>...</td>
            </tr>
        </table></td>
      </tr>
      
    </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-bottom:1px #E6E6E6 solid;">
        <tr>
          <td height="137" valign="top"><table width="633" border="0" cellspacing="0" cellpadding="0" style="margin-left:10px;">
            <tr>
              <td height="34">&nbsp;<img src="images/r/fuwu.jpg" width="83" height="20" /></td>
              <td align="right" valign="top" style="font-weight:bold;"><a href="news.asp?pid=4"><img src="images/more.jpg" width="39" height="13" border="0" /></a></td>
            </tr>
            <tr>
              <td colspan="2" valign="top">
			  <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="27" height="100"><a href="javascript:;" id="qian"></a></td>
          <td>
		  
		  <div id=demo style="overflow:hidden;height:100px;width:591px;"><table border=0 align=left 
cellpadding=0 cellspacing="0" cellspace=0>
		    <tr><td id=demo1 valign=top>
<table cellSpacing=0 cellPadding=0 border=0><tr>

<%
 Set zxdtRs  = conn.execute("select top 10 * from SmallClass_New Where IsShow =true And BigClassID=4 order by OrderID asc,SmallClassID asc")
		  do While not zxdtRs.Eof
%>
<td>
<table cellSpacing=0 cellPadding=0 align=center border=0 style="margin:0px 4px; float:left;">
<tr>
<td><a href="news.asp?pid=4&id=<%=zxdtRs("SmallClassID")%>" target="_blank"><img src="<%=zxdtRs("DefaultPicUrl")%>" width="141" height="78" border="0" /></a></td>
</tr>
<tr>
<td height="25" align="left">&nbsp;<img src="images/titletb.jpg" width="4" height="10" /> <a href="news.asp?pid=4&id=<%=zxdtRs("SmallClassID")%>" target="_blank" ><%=CutStr(zxdtRs("SmallClassName"),19)%></a></td>
</tr>
</table>
</td>
<%
		  zxdtRs.moveNext
		  Loop
		  zxdtRs.Close
		  Set zxdtRs = nothing
		%>
</tr></table>
</td>
<td id=demo2 valign=top></td></tr></table></div>
		  
		  </td>
          <td width="21" align="right"><a href="javascript:;" id="hou"></a></td>
        </tr>
		<script> 
var speed=30 
demo2.innerHTML=demo1.innerHTML

function xleft(){
MyMar=""
a=1
qian.innerHTML="<img src='images/lefts.jpg' width='21' height='27' border='0' />"
hou.innerHTML="<img src='images/rights.jpg' width='18' height='27' border='0' onmouseover='xright();' />"
Marquee();
}

function xright(){
MyMar=""
a=2
qian.innerHTML="<img src='images/lefts.jpg' width='21' height='27' border='0' onmouseover='xleft();' />"
hou.innerHTML="<img src='images/rights.jpg' width='18' height='27' border='0' />"
Marquee();

}

function Marquee(){ 

if(a==1){
if(demo2.offsetWidth-demo.scrollLeft<=0) 
demo.scrollLeft-=demo1.offsetWidth 
else{ 
demo.scrollLeft++ 
}
}
else
{
if(demo.scrollLeft<=0) 
demo.scrollLeft+=demo2.offsetWidth 
else{ 
demo.scrollLeft-- 
}
}
} 

xleft();
var MyMar=setInterval(Marquee,speed) 

</script>
      </table>
			  </td>
            </tr>
          </table></td>
        </tr>
      </table></td>
    <td valign="top" style="border:1px #E6E6E6 solid; border-top:0px; "><table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-bottom:1px #E6E6E6 solid;">
      <tr>
        <td height="96" background="images/bba.jpg"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="28"><a href="ftp://ftp.cmtdi.com/" target="_blank"><img src="images/1.jpg" width="191" height="28" border="0" onmouseover="this.src='images/01.jpg'" onmouseout="this.src='images/1.jpg'" style="border-bottom:1px #d0d0d1 solid;" /></a></td>
          </tr>
          <tr>
            <td height="28"><a href="http://mail.cmtdi.com/" target="_blank"><img src="images/2.jpg" width="191" height="28" border="0" onmouseover="this.src='images/02.jpg'" onmouseout="this.src='images/2.jpg'" style="border-top:1px #ffffff solid; border-bottom:1px #d0d0d1 solid;" /></a></td>
          </tr>
          <tr>
            <td height="28"><a href="https://vpn.ctdi.biz/" target="_blank"><img src="images/3.jpg" width="191" height="28" border="0" onmouseover="this.src='images/03.jpg'" onmouseout="this.src='images/3.jpg'" style="border-top:1px #ffffff solid; border-bottom:1px #E6E6E6 solid;" /></a></td>
          </tr>
        </table></td>
      </tr>
    </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" style="background:url(images/bbbbbbb.jpg);">
	  <%
	Set PicLinkRs = conn.execute("Select top 3 * from Links where linktype=0 Order By pxu Desc")
	Do while Not PicLinkRs.Eof
	%>
        <tr>
          <td height="50" align="center" valign="bottom"><a href="<%=PicLinkRs("Link")%>" target="_blank" title="<%=PicLinkRs("Note")%>"><img src="<%=PicLinkRs("SitePic")%>" width="173" height="40" border="0" /></a></td>
        </tr>
		<%
	PicLinkRs.MoveNext
	Loop
	PicLinkRs.Close
	%>
      </table></td>
  </tr>
</table>
<!--#include file="bottom.asp"-->
<style>
.fixediv{position:fixed;top:287px;z-index:9999;width:248px;height:205px;background:url(notice.png);}
.fixediv a.close{ display:block; margin-left:230px; margin-top:6px; width:16px ;height:16px;}
.leftadv{left:0px;}
.rightadv{right:0px;}
</style>
<div class="fixediv rightadv">	
	<a href="javascript:void(0);" class="close" tilte="关闭"></a>   
    
</div>

<script src="/scripts/jquery.min.js"></script>

<script>
$(function()
{
	$(".fixediv").floatadv();
	$(".fixediv a.close").click(function(){
		
		$(".fixediv").fadeOut(400);
		
	});
	

});




jQuery.fn.floatadv = function(loaded) {
	var obj = this;
	body_height = parseInt($(window).height());
	block_height = parseInt(obj.height());
	
	top_position = parseInt((body_height) - (block_height) + $(window).scrollTop());
	if (body_height<block_height) { top_position = 0 + $(window).scrollTop(); };
	
	if(!loaded) {
		obj.css({'position': 'absolute'});
		obj.css({ 'top': top_position });
		$(window).bind('resize', function() { 
			obj.floatadv(!loaded);
		});
		$(window).bind('scroll', function() { 
			obj.floatadv(!loaded);
		});
	} else {
		obj.stop();
		obj.css({'position': 'absolute'});
		obj.animate({ 'top': top_position }, 500, 'linear');
	}
}

</script>

</body>
</html>
