<!--#include file="fiveinc/inc.asp"-->
<!--#include file="FiveInc/Check_Sql.asp"-->
<!--#include file="FiveInc/page.asp"-->
<%
nid=strToNum(Request.QueryString("id"))
nid=78
rs.open "select * from category where cateid="&nid,conn,1,1
if not rs.eof then
	cateid=rs("cateid")
	parentid=rs("parentid")
	sonid=rs("sonid")
	followid=rs("followid")	
	catetype=rs("catetype")
	modeltype=rs("modeltype")
	catename= rs("catename")		
	com_title=rs("title")
	Com_Content=rs("content")
	depth =rs("depth")
	catedir=rs("catedir")
	
	xmname= replace(catename,"培训","")
	if com_title="" or isnull(com_title) then com_title=catename
else
	response.write "网址传递参数有误"
	response.End()

end if
rs.close
if Easp.Var("prov")="" then
	Easp.Var("prov")="重庆"
	Easp.Var("city")="江津区"
end if

%>
<!--#include virtual="/lmenu.asp"-->
<!--#include virtual="/top.asp"-->
<div class="greybg">
  <div class="main">
    <div class="cleft fl">
     
      <!--#include virtual="/cleft.asp"--> 
    </div>
    <div class="cright fr">
      
    <div class="curlocation">
      <div class="fr"><%=menustr%></div>
     <!-- <div class="fl"><%=catename%></div>-->
     
    </div>
     
      <div class="maincontent" > 
    
        <div class="mcontent xh">
     <style>
	 table{
		 margin-top:40px;
     border-collapse: collapse;/* 边框合并属性  */
	 width:718px;
}

th,td{
	height:40px;
     border: 1px solid #666666;
	 text-align:center;
}
	 </style>
         
		  <script type="text/javascript" src="/js/jquery.cityselect.js"></script>
    <script>
	$(function(){
		$("#city_4").citySelect({
    	prov:"<%=Easp.Var("prov")%>", 
    	city:"<%=Easp.Var("city")%>",
		dist:"<%=Easp.Var("dist")%>",
		nodata:"none"
	}); 

	});
	</script>
    <form method="get">
    <div id="city_4">
  		<select class="prov" name="prov"></select> 
    	<select class="city" name="city" disabled="disabled"></select>
        <select class="dist" name="dist" disabled="disabled"></select>
        <input type="image" src="images/cxbtn.jpg" />
        <input type="hidden" name="act" value="cx" />
    </div>
    
         </form>
         
     
     <table >
     <tr>
     <th width="180">网点名称</th>
     <th width="540">网点地址</th>
     <th width="150">联系电话</th>
     </tr>
     
     <%
	 if Easp.Var("act")<>"cx" then
	 set rs=Easp.Db.sel("select * from dealers where prov='重庆' order by id desc")
	 else
	 set rs=Easp.Db.sel("select * from dealers where prov={prov} and city={city} and dist={dist} order by id desc")
	 end if
	 while not rs.eof
	 	response.write "<tr>"
		response.write "<td><a href=""dealershow.asp?id="&rs("id")&""">"&rs("title")&"</a></td>"
		response.write "<td>"&rs("address")&"</td>"
		response.write "<td>"&rs("tel")&"</td>"
		response.write "</tr>"
	 rs.movenext
	 wend
	 rs.close
	 %>
     
     
     
     </table>
         
         </div>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>

<!--#include virtual="/foot.asp"-->