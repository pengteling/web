<!--#include file="../FiveInc/conn.asp"-->
<!--#include file="Admin.asp"-->
<html>
<head>
<meta http-equiv=Content-Type content=text/html;charset=utf-8>
<style type="text/css">
<!--
html,body {
	SCROLLBAR-FACE-COLOR: #6a84ae;
	SCROLLBAR-HIGHLIGHT-COLOR: #aaaaff;
	SCROLLBAR-SHADOW-COLOR: #335997;
	SCROLLBAR-3DLIGHT-COLOR: #335997;
	SCROLLBAR-ARROW-COLOR: #ffffff;
	SCROLLBAR-TRACK-COLOR: #335997;
	SCROLLBAR-DARKSHADOW-COLOR: black;
	background-color:#336699;
	margin-right: 2px;
	overflow-x:hidden;
	margin-top: 0;
	margin-bottom: 0;
	margin-left: 5px;
}

.ETCHED {
	BORDER-RIGHT: #6699cc 1px solid;
	BORDER-TOP: #003366 1px solid;
	BORDER-LEFT: #003366 1px solid;
	WIDTH: 100%;
	BORDER-BOTTOM: #6699cc 1px solid;
	height:auto;
	BACKGROUND-COLOR: #336699;
	margin:0;
	padding:0;
}
.NORMALMain {
	BORDER-RIGHT: #336699 1px solid;
	BORDER-TOP: #336699 1px solid;
	BORDER-LEFT: #336699 0px solid;
	WIDTH: 100%;
	height:24px;
	CURSOR: default;
	BORDER-BOTTOM: #336699 1px solid;
	BACKGROUND-COLOR: #336699;
	margin:0;
	padding:0;
	cursor:hand;
}
.NORMALLeft {
	BORDER-RIGHT: #336699 1px solid;
	BORDER-TOP: #336699 1px solid;
	BORDER-LEFT: #336699 1px solid;
	WIDTH: 100%;
	height:24px;
	CURSOR: default;
	BORDER-BOTTOM: #336699 1px solid;
	BACKGROUND-COLOR: #336699;
	margin:0;
	padding-top: 0;
	padding-right: 0;
	padding-bottom: 0;
	padding-left: 20px;
}
A.w:active {
	COLOR: #ffffff; TEXT-DECORATION: underline;font-size:12px;
}
A.w:visited {
	COLOR: #ffffff; TEXT-DECORATION: none; font-size:12px;
}
A.w:hover {
	COLOR: #ffffff; TEXT-DECORATION: underline; font-size:12px;
}
A.w:link {
	COLOR: #ffffff;	TEXT-DECORATION: none; font-size:12px;
}
-->
</style>
<style type="text/css">
<!--
.style10 {color: #FFFFFF}
td{
	font-size:12px;
	padding-top: 0;
	padding-right: 7px;
	padding-bottom: 0;
	padding-left: 0;
}
.style20 {color: #FF0000}
.style21 {
	color: #006697;
	font-weight: bold;
	font-size: 14px;
}
.pad{padding:0 0 0 50px;}
-->
</style>
<title><%=SystemCompany%>后台管理系统</title>
<SCRIPT>
var MSIE=0;
var lastitemid='undefined';
if(navigator.appName == 'Microsoft Internet Explorer')MSIE=1;

function MouseOver(item, type) {

	item.style.border='1px solid';
	if(type==0) {

		item.style.backgroundColor='#6699CC';
		item.style.borderLeftColor='#99CCFF';
		item.style.borderTopColor='#99CCFF';
		item.style.borderRightColor='#003366';
		item.style.borderBottomColor='#003366';

	} else if(type==1) {

		item.style.backgroundColor='#6699CC';
		item.style.borderLeftColor='#99CCFF';
		item.style.borderTopColor='#99CCFF';
		item.style.borderRightColor='#003366';
		item.style.borderBottomColor='#003366';
	}
}

function MouseOut(item, type) {

	item.style.border='1px solid';
	if(type==0) {
		item.style.backgroundColor='#336699';
		item.style.borderColor='#336699';

	} else if(type==1) {
	
		item.style.backgroundColor='#336699';
		item.style.borderColor='#336699';
	}
}
</SCRIPT>
</head>

<body >
<table width="98%"  border="0" align="center" cellpadding="0" cellspacing="1">
  <tr>
    <td height="29"><div align="left">
      <div align="center"><strong><span class="style10">后台管理<%=SystemVersion%></span></strong></div>
    </div></td>
  </tr>
  <tr>
    <td height="21"><div class="ETCHED">
      <div class="NORMALMain" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)">
        <div align="center"><img src="images/icon/home.gif" width="22" height="22" border="0" align="absmiddle"> <a href="default.asp" target="_parent" class="w"> 管理首页</a> <img src="images/icon/logoff.gif" width="22" height="22" border="0" align="absmiddle"> <a href="LoginOut.asp" target="_parent" class="w">退出</a></div>
      </div>
    </div></td>
  </tr>
  
   <tr>
    <td><div class="NORMALMain" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)" onClick="showHide('d99')"> <img src="images/icon/folder.gif" width="22" height="22" align="absmiddle"> <span class="style10">网站页面</span></div></td>
  </tr>
  <tr>
    <td><div class="ETCHED" id="d99" style="display:block;">
      <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="18" height="18" border="0" align="absmiddle"> <a href="catepage/CompanyAdd.asp" target="mainFrame" class="w">| 添加页面 |</a></div>
      <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="18" height="18" border="0" align="absmiddle"> <a href="catepage/CompanyAll.asp" target="mainFrame" class="w">| 页面管理 |</a></div>
    </div></td>
  </tr>
  
  <tr>
    <td><div class="NORMALMain" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)" onClick="showHide('d01')"> <img src="images/icon/folder.gif" width="22" height="22" align="absmiddle"> <span class="style10">网站架构</span></div></td>
  </tr>
  <tr>
    <td><div class="ETCHED" id="d01" style="display:block;">
      <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="18" height="18" border="0" align="absmiddle"> <a href="category/CompanyAdd.asp" target="mainFrame" class="w">| 添加栏目 |</a></div>
      <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="18" height="18" border="0" align="absmiddle"> <a href="category/CompanyAll.asp" target="mainFrame" class="w">| 栏目管理 |</a></div>
    </div></td>
  </tr>
  <tr>
    <td><div class="NORMALMain" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)" onClick="showHide('d02')"> <img src="images/icon/addnews.gif" width="22" height="22" border="0" align="absmiddle"> <span class="style10">信息管理</span></div></td>
  </tr>
  <tr>
    <td><div class="ETCHED" id="d02" style="display:block;">
      
      <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="18" height="18" border="0" align="absmiddle"> <a href="News/CompanyAll.asp" target="mainFrame" class="w">| 内容管理 | </a></div>
     <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="18" height="18" border="0" align="absmiddle"> <a href="news/news_manage_recycle.asp" target="mainFrame" class="w">| 回收站 |</a></div>
  </div>  </tr> 
  
   <tr>
    <td><div class="NORMALMain" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)" onClick="showHide('d08')"><img src="images/icon/addnews.gif" width="22" height="22" border="0" align="absmiddle"> <span class="style10">会员管理</span></div></td>
  </tr>
  <tr>
    <td><div class="ETCHED" id="d08" style="display:block;">
      <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="18" height="18" border="0" align="absmiddle"> <a href="Member/UserManage.asp" target="mainFrame" class="w">| 会员管理 |</a></div>
	   <!--<div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="18" height="18" border="0" align="absmiddle"> <a href="Member/Useradd.asp" target="mainFrame" class="w">| 添加会员 |</a></div>-->
    </div></td>
  </tr>
  <tr>
    <td><div class="NORMALMain" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)" onClick="showHide('d07')"><img src="images/icon/folder.gif" width="22" height="22" align="absmiddle"> <span class="style10">留言/反馈管理</span></div></td>
  </tr>
  <tr>
    <td><div class="ETCHED" id="d07" style="display:block;">
      <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="18" height="18" border="0" align="absmiddle"> <a href="GuestBook/Book_index.asp" target="mainFrame" class="w">| 留言/反馈管理 |</a></div>
	<!--   <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="18" height="18" border="0" align="absmiddle"> <a href="GuestBook/Book_index2.asp" target="mainFrame" class="w">| 投诉/建议管理 |</a></div>-->
    </div></td>
  </tr>
  
      <tr>
    <td><div class="NORMALMain" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)" onClick="showHide('d04')"><img src="images/icon/addnews.gif" width="22" height="22" border="0" align="absmiddle"> <span class="style10">人才招聘</span></div></td>
  </tr>
  <tr>
    <td><div class="ETCHED" id="d04" style="display:block;">
      <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="18" height="18" border="0" align="absmiddle"> <a href="Hr_Man/Manage_Job.asp" target="mainFrame" class="w">| 招聘管理 |</a></div>
      <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="18" height="18" border="0" align="absmiddle"> <a href="Hr_Man/Manage_JobAdd.asp" target="mainFrame" class="w">| 发布招聘 |</a></div>
      <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="18" height="18" border="0" align="absmiddle"> <a href="Hr_Man/Manage_JobBook.asp" target="mainFrame" class="w">| 应聘管理 |</a></div>
    </div></td>
  </tr>
  
  <tr>
    <td><div class="NORMALMain" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)" onClick="showHide('d22')"><img src="images/icon/addnews.gif" width="22" height="22" border="0" align="absmiddle"> <span class="style10">友情链接</span></div></td>
  </tr>
    <tr>
    <td><div class="ETCHED" id="d22" style="display:block;">
	  
     <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/listlink.gif" width="22" height="22" align="absmiddle"> <a href="link/manage_link.asp" target="mainFrame" class="w">| 链接管理 |</a></div>
    </div></td>
  </tr>
  
  <tr>
    <td><div class="NORMALMain" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)" onClick="showHide('d23')"><img src="images/icon/addnews.gif" width="22" height="22" border="0" align="absmiddle"> <span class="style10">广告系统</span></div></td>
  </tr>
    <tr>
    <td><div class="ETCHED" id="d23" style="display:block;">
    <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="22" height="22" align="absmiddle"> <a href="ad/ad_sort.asp" target="mainFrame" class="w">| 广告分类 |</a></div> 
	 <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="22" height="22" align="absmiddle"> <a href="ad/ad_add.asp" target="mainFrame" class="w">| 发布广告 |</a></div> 
     <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="22" height="22" align="absmiddle"> <a href="ad/ad_manage.asp" target="mainFrame" class="w">| 广告管理 |</a></div>
    </div></td>
  </tr>
    
      <tr>
    <td><div class="NORMALMain" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)" onClick="showHide('d24')"><img src="images/icon/addnews.gif" width="22" height="22" border="0" align="absmiddle"> <span class="style10">投票管理</span></div></td>
  </tr>
    <tr>
    <td><div class="ETCHED" id="d24" style="display:block;">
	   <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="22" height="22" align="absmiddle"> <a href="vote/VoteAdd.asp" target="mainFrame" class="w">| 添加投票 |</a></div>
     <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="22" height="22" align="absmiddle"> <a href="vote/VoteManage.asp" target="mainFrame" class="w">| 投票管理 |</a></div>
    </div></td>
  </tr>
  
   <tr>
    <td><div class="NORMALMain" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)" onClick="showHide('d82')"><img src="images/icon/addnews.gif" width="22" height="22" border="0" align="absmiddle"> <span class="style10">管理员管理</span></div></td>
  </tr>
  <tr>
    <td><div class="ETCHED" id="d82" style="display:block;">

	  <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/users.gif" width="23" height="22" align="absmiddle"> <a href="manager/Manage_Admin.asp" target="mainFrame" class="w">| 管理员管理 |</a></div>
      <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="22" height="22" align="absmiddle"> <a href="manager/ad_sort.asp" target="mainFrame" class="w">| 管理员分组 |</a></div>
      <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="22" height="22" align="absmiddle"> <a href="admin_db_ys.asp" target="mainFrame" class="w">| 分组权限设置 |</a></div>
     
    </div></td>
  </tr>
  
  <tr>
    <td><div class="NORMALMain" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)" onClick="showHide('d12')"><img src="images/icon/addnews.gif" width="22" height="22" border="0" align="absmiddle"> <span class="style10">系统管理</span></div></td>
  </tr>
  <tr>
    <td><div class="ETCHED" id="d12" style="display:block;">

	  
      <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="22" height="22" align="absmiddle"> <a href="admin_db_bak.asp" target="mainFrame" class="w">| 备分数据库 |</a></div>
      <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="22" height="22" align="absmiddle"> <a href="admin_db_ys.asp" target="mainFrame" class="w">| 数据库压缩 |</a></div>
     
    </div></td>
  </tr>
  
  
  <tr>
    <td><div class="NORMALMain" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)" onClick="showHide('d13')"> <img src="images/icon/stat.gif" width="22" height="22" align="absmiddle"> <span class="style10">系统配置</span></div></td>
  </tr>
  <tr>
    <td><div class="ETCHED" id="d13" style="display:block;">
      <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="18" height="18" border="0" align="absmiddle"> <a href="admin_main.asp" target="mainFrame" class="w">| 查看 |</a></div>

	   <div class="NORMALLeft" onMouseOver="javascript:MouseOver(this,1)" onMouseOut="javascript:MouseOut(this,1)"><img src="images/icon/folder1.gif" width="18" height="18" border="0" align="absmiddle"> <a href="SiteConfig.asp" target="mainFrame" class="w">| 网站配置 |</a></div>

    </div></td>
  </tr>
</table>
<script language="javascript">
function showHide(obj){	
	if(document.getElementById(obj).style.display=="none"){
		document.getElementById(obj).style.display="block";
	}
	else{
		document.getElementById(obj).style.display="none";
	}
}
</script>
</body></html>