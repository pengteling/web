<!--#include virtual="/fiveinc/conn.asp"-->

<%
curpageTitle = "首页"
'cateid_d1=36
isindex=1
%>
<!--#include virtual="/top.asp"-->


<div class="banner" style="width:1440px; margin:0 auto;">
  <div class="hd">
    <ul>
    <%
	rs.open "Select top 3 * from [ad] order by id ",conn,1,1
	while not rs.eof
	%>
      <li><img src="<%=Thumb_getUrl(rs("photo"),121,48)%>" /></li>
      <%
	  rs.movenext
	  wend
	  rs.movefirst
	  %>
    </ul>
  </div>
  <div class="bd">
    <ul>
    <%while not rs.eof
	%>
      
      <li style="background:url(<%=rs("photo")%>)"></li>
      <%
	  rs.movenext
	  wend
	rs.close%>  
    
    </ul>
  </div>
</div>
<script>
$(function(){
jQuery(".banner").slide({mainCell:".bd ul",titCell:".hd ul li",effect:"left",autoPlay:true});
});
</script>
<div class="imain">
  <div class="main">
    <div class="im1 fl">
      <div class="im1-head">
        <div class="tit fl"><a href="<%=companyUrl_DB(68)%>">关于我们</a> ></div>
        <div class="more fr"><a href="<%=companyUrl_DB(68)%>">MORE +</a></div>
        <div class="clear"></div>
      </div>
      <div class="im1-body">
        <p> 重庆市恒昌农具制造有限公司（创立于
          1992年）我们的专业：中国专业研发、设
          计、生产微型农用耕作机耕作刀具、耕作
          刀具总成、耕播种收功能拓展机具的创新
          型优秀企业。 </p>
        <p> 我们的能力 （创新 专业）：长期研究
          和实践农机、农具与各种农艺的完美结合... </p>
      </div>
    </div>
    <div class="im2 fl">
      <div class="im1-head">
        <div class="tit fl"><a href="<%=companyUrl_DB(42)%>">我们的产品</a> ></div>
        <div class="more fr"><a href="<%=companyUrl_DB(42)%>">MORE +</a></div>
        <div class="clear"></div>
      </div>
      <div class="im2-body">
        <ul>
          <li>
            <div class="pic"><a href="<%=companyUrl_DB(61)%>"><img src="images/chanpin01.png" alt="" /></a></div>
            <div class="txt"><a href="">刀具总成</a></div>
          </li>
          <li>
            <div class="pic"><a href="<%=companyUrl_DB(62)%>"><img src="images/chanpin1_07.png" alt="" /></a></div>
            <div class="txt"><a href="">刀　片</a></div>
          </li>
          <li class="last">
            <div class="pic"><a href="<%=companyUrl_DB(63)%>"><img src="images/chanpin03.png" alt="" /></a></div>
            <div class="txt"><a href="">附　件</a></div>
          </li>
          <div class="clear"></div>
          
          <!--<li>
            <div class="pro-tit1"> 刀具总成
              <div class="clear"></div>
            </div>
            <img src="images/qietu/product1.png" alt=""/> </li>
          <li>
            <div class="pro-tit2"> 刀 片
              <div class="clear"></div>
            </div>
            <img src="images/qietu/product2.png" alt=""/> </li>
          <li>
            <div class="pro-tit2"> 附 件
              <div class="clear"></div>
            </div>
            <img src="images/qietu/product3.png" alt=""/> </li>-->
        </ul>
      </div>
    </div>
    <div class="im3 fl">
      <div class="im3-head">
        <div class="news on"><a href="<%=companyUrl_DB(64)%>">最新资讯</a></div>
        <div class="news"><a href="<%=companyUrl_DB(65)%>">行业新闻</a></div>
        <div class="more fr"></div>
        <div class="clear"></div>
      </div>
      <div class="im3-body">
        <ul class="newslist">
        <%
		rs.open "Select top 5 * from news_c where cateid=64  Order By px desc,posttime Desc,ID Desc",conn,1,1
		while not rs.eof
		%>
          <li> <a href="<%=infoURL(rs("staticUrl"),rs("dynamicUrl"),supportHtml)%>"> · <%=leftstr(rs("title"),30)%> </a> </li>
          <%rs.movenext
		  wend
		  rs.close
		  %>
         
          <div class="more fr"><a href="<%=companyUrl_DB(64)%>">MORE +</a></div>
        </ul>
        <ul class="newslist">
         <%
		rs.open "Select top 5 * from news_c where cateid=65  Order By px desc,posttime Desc,ID Desc",conn,1,1
		while not rs.eof
		%>
          <li> <a href="<%=infoURL(rs("staticUrl"),rs("dynamicUrl"),supportHtml)%>"> · <%=leftstr(rs("title"),30)%> </a> </li>
          <%rs.movenext
		  wend
		  rs.close
		  %>
          <div class="more fr"><a href="<%=companyUrl_DB(65)%>">MORE +</a></div>
        </ul>
      </div>
    </div>
    <script>
	$(function(){
jQuery(".im3").slide({mainCell:".im3-body",titCell:".im3-head div.news",effect:"fade",autoPlay:true,interTime:5000});
	});
</script>
    <div class="clear"></div>
    <!-- <div class="imainback"> <img src="images/qietu/imainback2.png" alt=""/> </div>--> 
  </div>
  
  <!--  <div class="imainback">
    <div> <img src="images/qietu/imainback.png" alt=""/> </div>
    <div class="imainnr">
      <ul>
        <li> <img src="images/qietu/guanyuwomen.png" alt=""/> </li>
      </ul>
    </div>
  </div>--> 
</div>
<!--#include virtual="/foot.asp"-->