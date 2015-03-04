<!--#include virtual="/fiveinc/conn.asp"-->

<%
curpageTitle = "首页"
'cateid_d1=36
isindex=1
%>
<!--#include virtual="/top.asp"-->


<div class="banner">
  <div class="hd">
    <ul>
      <li><img src="<%=Thumb_getUrl("images/banner2_02.jpg",121,48)%>" /></li>
      <li><img src="<%=Thumb_getUrl("images/banner2_02.jpg",121,48)%>" /></li>
      <li><img src="<%=Thumb_getUrl("images/banner2_02.jpg",121,48)%>" /></li>
    </ul>
  </div>
  <div class="bd">
    <ul>
      <li style="background:url(images/banner2_02.jpg)"></li>
      <li style="background:url(images/banner2_02.jpg)"></li>
      <li style="background:url(images/banner2_02.jpg)"></li>
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
        <div class="tit fl"><a href="">关于我们</a> ></div>
        <div class="more fr"><a href="">MORE +</a></div>
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
        <div class="tit fl"><a href="">我们的产品</a> ></div>
        <div class="more fr"><a href="">MORE +</a></div>
        <div class="clear"></div>
      </div>
      <div class="im2-body">
        <ul>
          <li>
            <div class="pic"><a href=""><img src="images/chanpin1_07.png" alt="" /></a></div>
            <div class="txt"><a href="">刀具总成</a></div>
          </li>
          <li>
            <div class="pic"><a href=""><img src="images/chanpin1_07.png" alt="" /></a></div>
            <div class="txt"><a href="">刀　片</a></div>
          </li>
          <li class="last">
            <div class="pic"><a href=""><img src="images/chanpin1_07.png" alt="" /></a></div>
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
        <div class="news on"><a href="">最新资讯</a></div>
        <div class="news"><a href="">行业新闻</a></div>
        <div class="more fr"></div>
        <div class="clear"></div>
      </div>
      <div class="im3-body">
        <ul class="newslist">
          <li> <a href="readnews.asp?id=5"> · 大理州政府领导莅临俊发地产考察 </a> </li>
          <li> <a href="readnews.asp?id=5"> · 大理州政府领导莅临俊发地产考察 </a> </li>
          <li> <a href="readnews.asp?id=5"> · 大理州政府领导莅临俊发地产考察 </a> </li>
          <li> <a href="readnews.asp?id=5"> · 大理州政府领导莅临俊发地产考察 </a> </li>
          <li> <a href="readnews.asp?id=5"> · 大理州政府领导莅临俊发地产考察 </a> </li>
          <div class="more fr"><a href="">MORE +</a></div>
        </ul>
        <ul class="newslist">
          <li> <a href="readnews.asp?id=5"> · 2大理州政府领导莅临俊发地产考察 </a> </li>
          <li> <a href="readnews.asp?id=5"> · 大理州政府领导莅临俊发地产考察 </a> </li>
          <li> <a href="readnews.asp?id=5"> · 大理州政府领导莅临俊发地产考察 </a> </li>
          <li> <a href="readnews.asp?id=5"> · 大理州政府领导莅临俊发地产考察 </a> </li>
          <li> <a href="readnews.asp?id=5"> · 大理州政府领导莅临俊发地产考察 </a> </li>
          <div class="more fr"><a href="">MORE +</a></div>
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