<!--#include virtual="fiveinc/inc.asp"-->
<%curpageTitle=""&SiteTitle 
isindex=1
cateid_d1=0
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=curpageTitle%></title>
<meta name="keywords" content="<%=SiteKey%>" />
<meta name="description" content="<%=SiteDescription%>" />
<meta name="author" content="http://www.westsg.com.cn" />
<link rel="stylesheet" href="css/index.css" type="text/css">
<link rel="stylesheet" href="css/index-scroll.css" type="text/css">

<!--[if lt IE 9]>  
      <script src="/js/html5shiv.js"></script>  
      <script src="/js/respond.js"></script>  
<![endif]-->
<script src="js/require.js" defer async  data-main="js/comm"></script>
</head>

<body class="loading">
<div class="main">
  <div class="header">
    <div class="headmain">
      <div class="logo"><a href="/"></a></div>
      <div class="nav">
        <ul>
          <li class="first"><a href="" class="select">首页</a></li>
          <%
		 
	  rs.open "select top 10 * from category where followid=0 and ishome=true order by orderid",conn,1,1
	  while not rs.eof
	  response.write "<li>"
	  if cateid_d1=rs("Cateid") then
	  		response.write "<a class=""select"""
	  else
	  		response.write "<a"
	  end if
			response.write " href="""&companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("dirpath"),supporthtml)&""">"&rs("catename")&"</a></li>"
		
		rs.movenext
		wend
		rs.close
		  %>
          
        </ul>
      </div>
    </div>
  </div>
  <div class="section section1"> 
    <!-- <div class="bg bg1-1"></div> --> 
    <!-- <div class="bg bg1-2"></div> -->
    <div class="imain">
      <div class="ip1-f1"></div>
      <!--<div class="ip1-f2"></div>-->
      <div class="ip1-f3"></div>
    </div>
    <a class="godown" href="#page2"><span></span></a> </div>
  <div class="section section2">
    <div class="videohead"><a href="<%=companyurl_db(2)%>"></a></div>
    <div class="videoimg"><img src="images/ip2-f2.jpg" width="720" height="480"></div>
    <div class="videobox"> 
      <!--<embed src="http://player.youku.com/player.php/sid/XODUyMDUzODk2/v.swf" allowFullScreen="true" quality="high" width="720" height="480" align="middle" allowScriptAccess="always" type="application/x-shockwave-flash"></embed>--> 
      
      <!-- 我爱播放器(52player.com)/代码开始 --> 
      <script type="text/javascript" src="video/swfobject.js"></script>
      <div class="video" id="CuPlayer"> <strong> 提示：您的Flash Player版本过低，请<a href="http://get.adobe.com/cn/flashplayer/">点此进行网页播放器升级</a>！</strong></div>
      <script type="text/javascript">
var so = new SWFObject("video/CuPlayerMiniV4.swf","CuPlayerV4","720","480","9","#000000");
so.addParam("allowfullscreen","true");
so.addParam("allowscriptaccess","always");
so.addParam("wmode","opaque");
so.addParam("quality","high");
so.addParam("salign","lt");
so.addVariable("CuPlayerSetFile","video/CuPlayerSetFile.asp"); //播放器配置文件地址,例SetFile.xml、SetFile.asp、SetFile.php、SetFile.aspx
so.addVariable("CuPlayerFile","/video/tidg.mp4"); //视频文件地址
so.addVariable("CuPlayerImage","video/video.jpg");//视频略缩图,本图片文件必须正确
so.addVariable("CuPlayerWidth","720"); //视频宽度
so.addVariable("CuPlayerHeight","480"); //视频高度
so.addVariable("CuPlayerAutoPlay","no"); //是否自动播放
so.addVariable("CuPlayerLogo","video/logo2.png"); //Logo文件地址
so.addVariable("CuPlayerPosition","bottom-right"); //Logo显示的位置
so.write("CuPlayer");
</script> 
      <!-- 我爱播放器(52player.com)/代码结束 --> 
      
    </div>
    <a class="godown" href="#page3"><span></span></a> </div>
  <div class="section section3"> 
    <!-- <div class="bg bg3-1"></div> --> 
    <!-- <div class="bg bg3-2"></div> --> 
    
    <!-- 代码 开始 -->
    <div id="wrapper"> <a href="<%=companyurl_db(5)%>"><img src="images/ip3-f1.png" alt="moving boxes" /></a>
      <div id="slider"> <img class="scrollButtons left" src="images/leftarrow.png">
        <div style="overflow: hidden;" class="scroll">
          <div class="scrollContainer">
          
          <%k=0
		  rs.open "select top 5 * from news_c where cateid in ( select cateid from category where instr(','+parentid+',',',5,')>0 )",conn,1,1
		  while not rs.eof
		  k=k+1
		  %>
            <div class="panel" id="panel_<%=k%>">
              <div class="inside"> <img src="<%=rs("defaultpicurl")%>" alt="picture" />
                <p><%=leftstr(RemoveHTML(rs("content")),200)%>... <a href="<%=infoURL(rs("staticUrl"),rs("dynamicUrl"),supportHtml)%>" target="_blank">[详细]</a></p>
              </div>
            </div>
            
            <%
			rs.movenext
			wend
			rs.close
			%>
            
          </div>
          <div id="left-shadow"></div>
          <div id="right-shadow"></div>
        </div>
        <img class="scrollButtons right" src="images/rightarrow.png"> </div>
    </div>
    <!-- 代码 结束 --> 
    
    <a class="godown" href="#page4"><span></span></a> </div>
  <div class="section section4">
 <!-- <div class="ip4-bg1"></div>-->
  
  <div class="ip4-fix">
  <div class="ip4-main">
  <div class="ip4-tab1 select1">
  <div id="ip4-btn1"></div>
  <div class="ip4-t1-con">
  <div class="tit"><a href="company.asp?id=9">旅游金融服务</a></div>
  <div class="con">2011年9月由旅发集团发起，武隆喀斯特公司、大足旅游集团、涪陵旅游集团共同出资设立重庆旅游融资担保有限公司，资本金1亿元...<a href="company.asp?id=9">更多></a></div>
  </div>
  </div>
  <div class="ip4-tab2 select">
  <div id="ip4-btn2"></div>
  <div class="ip4-t1-con">
  <div class="tit"><a href="company.asp?id=8">旅游产业发展</a></div>
  <div class="con">主要以建设营运自驾旅游示范营地为切入点，力争率先在全国或西南创造自驾旅游营地的建设标准和服务标准，引领健康休闲旅游发展...<a href="company.asp?id=8">更多></a></div>
  </div>
  </div>
  </div>
  </div>
  
    <!--<div class="ip4-f1"><img src="images/ip4-f1.png"></div>-->
    <!--<div class="ip4-box">
      <div class="ip4-f2-box">
        <div class="ip4-box1-tit"> </div>
        <div class="ip4-box1-img"><img src="images/ip4-f2.jpg" width="540" height="400"></div>
        <div class="con">2011年9月由旅发集团发起，武隆喀斯特公司、大足旅游集团、涪陵旅游集团共同出资设立重庆旅游融资担保有限公司，资本金1亿元；2013年3月由旅发集团发起成立的重庆市江北区旅游小额贷款股份有限公司，资本金2亿元；2013年3月发起设立的重庆观天下股权投资基金管理有限公司，资本金1000万元。</div>
      </div>
      <div class="ip4-f3-box">
        <div class="ip4-box2-tit"> </div>
        <div class="ip4-box2-img"><img src="images/ip4-f3.jpg" width="540" height="400"></div>
        <div class="con">主要以建设营运自驾旅游示范营地为切入点，力争率先在全国或西南创造自驾旅游营地的建设标准和服务标准，引领健康休闲旅游发展。该业务板块目前主要由集团的两个全资子公司负责：重庆龙水湖有限公司（资本金2000万元），负责龙水湖营地开发建设；重庆观天下国际旅游发展有限公司（资本金1000万元），已牵头组建重庆市自驾旅游协会，负责自驾游营地的营运管理。</div>
      </div>
    </div>-->
    <!--
    <div class="ip4-f2">
      <div class="ip4-f2-img"><img src="images/ip4-f2.jpg" height="320"></div>
      <div class="ip4-f2-txt">
        <div class="tit">旅游金融服务</div>
        <div class="con">2011年9月由旅发集团发起，武隆喀斯特公司、大足旅游集团、涪陵旅游集团共同出资设立重庆旅游融资担保有限公司，资本金1亿元；2013年3月由旅发集团发起成立的重庆市江北区旅游小额贷款股份有限公司，资本金2亿元；2013年3月发起设立的重庆观天下股权投资基金管理有限公司，资本金1000万元。</div>
      </div>
    </div>
    <div class="ip4-f3">
      <div class="ip4-f3-img"><img src="images/ip4-f3.jpg" height="320"></div>
      <div class="ip4-f3-txt">
        <div class="tit">旅游产业开发</div>
        <div class="con">主要以建设营运自驾旅游示范营地为切入点，力争率先在全国或西南创造自驾旅游营地的建设标准和服务标准，引领健康休闲旅游发展。该业务板块目前主要由集团的两个全资子公司负责：重庆龙水湖有限公司（资本金2000万元），负责龙水湖营地开发建设；重庆观天下国际旅游发展有限公司（资本金1000万元），已牵头组建重庆市自驾旅游协会，负责自驾游营地的营运管理。</div>
      </div>
    </div>
    --> 
  </div>
  <div class="section section5">
    <!--<div class="ip5box">
      <div class="ip5-f1">
        <div class="line1">志存高远 · 引领未来</div>
        <div class="line2">重庆市江北区江北城西大街25号B座平安财富中心6-1</div>
        <div class="line3">
          <div class="email">cqlykf@163.com</div>
          <div class="tel">023-67072772</div>
        </div>
      </div>
      <div class="ip5-f2"> </div>
    </div>-->
    <div class="ip5box2">
    <a href=""><img src="images/ip5-txt.png" width="593" height="219" alt=""></a>
    </div>
    <div class="copy">Copyright 2011-<%=year(date())%> © TIDG Co.,Ltd. All rights reserved . Design by <a href="http://www.westsg.com.cn" target="_blank">JadeBox</a> . <%=siteBeian%> </div>
    <div class="wbwx">
     <div class="wb"><a href="<%=wburl%>" target="_blank"></a></div>
              <div class="wx"><a href="javascript:;"></a></div>
    <div class="erwcode">
    <div class="img"><img src="<%=wxurl%>"></div>
    <div class="con">
    扫一扫<br>
关注旅发集团
    </div>
    </div>
    </div>
  </div>
</div>
</body>
</html>