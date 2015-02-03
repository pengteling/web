<!--#include virtual="/fiveinc/conn.asp"-->
<!--#include virtual="/User_Config.asp"-->
<%
curpageTitle = "会员中心"

%>
<!--#include virtual="/top.asp"-->
<script>
$(function(){
	$(".ico01").addClass("hover ico01_");
	$(".user_title_more li").eq(<%=clng(request("v"))%>).addClass("hover");
})
</script>

<body>
<div class="width">
  <div class="user_bg">
    <div id="uleft"> 
      <!--#include virtual="/uleft.asp"--> 
    </div>
    <!--左侧结束-->
    <div id="uright">
      <div class="page_content">
        <div class="user_index_head">
          <div class="fr"><a href="/"><img src="/images/gotocart.jpg" width="310" height="144" alt="" /></a></div>
          <div class="fl">
          <div class="username">欢迎您，pengteling</div>
          <div class="userproperty">
          您已登陆：34次<br />
我的积分：10909 <br />
会员等级：普通会员<br />
          </div>
          
          </div>
          <div class="clear"></div>
        </div>
        <div class="user_index_midline">
        
        快捷方式:  <a href="user.asp">修改个人资料</a>   <a href="user.asp?act=pwd&V=1">修改登陆密码</a>   <a href="address.asp">管理收货地址</a>
        </div>
        <div class="user_index_plist">
        <ul>
        	<li>
        		<div class="pic"><a href="">
        				<img src="/images/user_index_p_pic.jpg" alt="" />
        				<div class="txt"><a href="">单价：78</a></div>
        			</a></div>
        	</li>
        	<li>
        		<div class="pic"><a href="">
        				<img src="/images/user_index_p_pic.jpg" alt="" />
        				<div class="txt"><a href="">单价：78</a></div>
        			</a></div>
        	</li>
        	<li>
        		<div class="pic"><a href="">
        				<img src="/images/user_index_p_pic.jpg" alt="" />
        				<div class="txt"><a href="">单价：78</a></div>
        			</a></div>
        	</li>
        	<li>
        		<div class="pic"><a href="">
        				<img src="/images/user_index_p_pic.jpg" alt="" />
        				<div class="txt"><a href="">单价：78</a></div>
        			</a></div>
        	</li>
        </ul>
        </div>
      </div>
    </div>
    <!--右侧结束-->
    <div class="clear"></div>
  </div>
</div>
