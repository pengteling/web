<!--#include file="fiveinc/inc.asp"-->
<!--#include file="FiveInc/Check_Sql.asp"-->
<!--#include file="FiveInc/page.asp"-->
<!--#include virtual="/User_Config.asp"-->
<%
ispshow=1
newsid=strToNum(Request.QueryString("id"))

rs.open "select * from product where id="&newsid&" ",conn,1,3
if not rs.eof then
rs("hits")=rs("hits")+1
rs.update
nid =rs("cateid")
cateid=nid
newstitle=rs("title")
News_Content=rs("content")
content_zy =rs("content_zy")
posttime=formatdate(rs("posttime"),5)
author=rs("ComeFrom")
price=rs("price")

ggxh=rs("ggxh")
		syfw=rs("syfw")
		cptd=rs("cptd")
		syjx=rs("syjx")
		relgoods=trim(rs("relgoods"))
		
		
defaultpicurl=rs("defaultpicurl")
hits=rs("hits")
uploadfiles=rs("uploadfiles")
uploadfiles=split(uploadfiles,"|")
if ubound(uploadfiles)<1 then
redim uploadfiles(0)
uploadfiles(0)="/images/nopic.jpg"
end if

a=instr(1,News_Content,"<a href=",1)+9
	if a>9 then
	b=instr(a+1,news_content,"""")
	
	downfileurl =mid(news_content,a,b-a)
	
	'response.write "http://"&Request.ServerVariables("Http_Host")&downfileurl
	if instr(lcase(downfileurl),"uploadfile")>0 then
	response.Redirect(downfileurl)
	end if
	end if
else
response.write "该文章不存在或未通过审核！"
response.end
end if
rs.close




rs.open "select * from category where cateid="&nid,conn,1,1
if not rs.eof then
	parentid=rs("parentid")
	sonid=rs("sonid")
	followid=rs("followid")	
	catetype=rs("catetype")
	modeltype=rs("modeltype")
	catename= rs("catename")		
	title=rs("title")
	Com_Content=rs("content")

else
	response.write "网址传递参数有误"
	response.End()

end if
rs.close



%>

<!--#include virtual="/lmenu.asp"-->
<%
curpagetitle = newstitle &"-"&curpagetitle
%>
<!--#include virtual="/top.asp"-->

<style>
.jqzoom{
	text-decoration:none;
	float:left;
	z-index:999;
}
</style>
<script>
$(document).ready(function() {
	$('.jqzoom').jqzoom({
            zoomType: 'standard',
            lens:true,
            preloadImages: false,
            alwaysOn:false,
			position:'right'
        });
	
});
</script>
<div class="width" id="position">您所在的位置：<%=menustr%> > <%=newstitle%></div>
<div class="width">
  <div id="goodsshow" class="mt10">
    <div class="left">
      <div class="shop_big"><a href="<%=uploadfiles(0)%>" class="jqzoom" rel='gal1' title="<%=newstitle%>" ><img src="<%=uploadfiles(0)%>" width="360" height="360" id="shop_big" alt="<%=newstitle%>" title="<%=newstitle%>" /></a>
        <div class="clear"></div>
      </div>
      <div class="shop_plist"> <a href="javascript:;" class="prev"></a>
        <div id="prolist">
          <ul>
            <%
						for i = 0 to ubound(uploadfiles)-1
						%>
            <li <%if i=0 then response.write "class=""hover"""%>><a href="javascript:void(0);" rel="{gallery: 'gal1', smallimage: '<%=uploadfiles(i)%>',largeimage: '<%=uploadfiles(i)%>'}"><img src="<%=uploadfiles(i)%>" border="0" /></a></li>
            <%
							 next
							 %>
          </ul>
        </div>
        <a href="javascript:;" class="next"></a> </div>
    </div>
    <div class="right">
      <h1 style="margin-bottom:30px;"><%=newstitle%></h1>
      <div class="gline">
        <div class="fl">产品单价：</div>
        <div class="fr price"><span style="font-size:18px;">￥</span><%=price%></div>
        <div class="clear"></div>
      </div>
      
      <div class="gline">
        <div class="fl">规格型号：</div>
        <div class="fr"><%=ggxh%></div>
        <div class="clear"></div>
      </div>
      
      <div class="gline">
        <div class="fl">适用范围：</div>
        <div class="fr"><%=syfw%></div>
        <div class="clear"></div>
      </div>
      
      <div class="gline">
        <div class="fl">产品特点：</div>
        <div class="fr"><%=cptd%></div>
        <div class="clear"></div>
      </div>
      <div class="gline">
        <div class="fl">适用机型：</div>
        <div class="fr"><%=syjx%></div>
        <div class="clear"></div>
      </div>
     <%
	 if relgoods<>"" then
	 relgoods_arr=split(relgoods,",")
	 %>
     <div class="relgoods">
     <div class="tit">相关产品：</div>
     <div class="relgoodslist">
     <ul>
     <%
	 
	 for i= 0 to ubound(relgoods_arr)
	 	temp =relgoods_arr(i)
		temp_arr= split(relgoods_arr(i),"|")
	 	response.write "<li><a href=""show.asp?id="& temp_arr(1) &""">"&temp_arr(0)&"</a></li>"
	 next
	 %>
    
     </ul>
      <div class="clear"></div>
     </div>
     </div>
     
     <%end if%>
     
      <div class="cart">
        <div class="cart_num">
          <div class="amount"><span>数量：</span>
            <input type="text" value="1" name="shopnum" id="shopnum" class="shopnum" />
            <span class="uamount shopadd"></span><span class="damount shopminus"></span><span class="clear"></span></div>
          <div class="soldnum">已售出<u><%
		  set rs=Easp.Db.Sel("select sum([count]) from orderDetail where goodsid={=id}")
		  if not isnull(rs(0)) then
		   response.write rs(0)
		   else
		   response.write "0"
		   end if
		  rs.close
		  %></u>件</div>
        </div>
        <div class="cart_bnt">
          <input type="button" value="加入购物车" class="addcart" id="addcart" config="<%=newsid%>" />
          <input type="button" value="进入结算中心" class="addfav" onClick="location.href='cart.asp'" />
        </div>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>
<div class="width" id="cpxj">
<div class="tit">产品介绍</div>
<div class="con"><%=News_Content%></div>
</div>

<!--#include virtual="/foot.asp"-->