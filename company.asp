<!--#include file="fiveinc/inc.asp"-->
<!--#include file="FiveInc/Check_Sql.asp"-->
<!--#include file="FiveInc/page.asp"-->
<%
nid=strToNum(Request.QueryString("id"))
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


%>
<!--#include virtual="/lmenu.asp"-->
<!--#include virtual="/top.asp"-->
<div class="greybg">
  <div class="main">
    <div class="cleft fl">
      <div class="nlogo"><a href="/"><img src="/images/logo-nei.png" alt="" /></a></div>
      <!--#include virtual="/cleft.asp"--> 
    </div>
    <div class="cright fr">
      <div class="subtit"><img src="images/subtitle-<%=cateid_d1%>.png" height="36" /></div>
      <div class="subanner"><img src="<%=defaultpic_d1%>" height="140" width="680" /></div>
     <%	
	 if instr(sonid_d1,",")>0 then%>
	 <!--#include virtual="/subnav.asp"-->
     <%end if%>
     
      <div class="maincontent" > 
      <%if cateid<>11 then%>
       <div class="mtit"><%=com_title%></div>
       <%end if%>
        <div class="mcontent xh">
        <%if cateid=11 then%>
        
        <ul class="spline">
		<div class="spline">
			<img src="images/arthurlan/xuxianfenge.png" alt="" />
		</div>
	</ul>
	<ul class="logolist">
    
    
    <%
	rs.open "select * from links order by orderid",conn,1,1
	while not rs.eof
	%>
		<li class="logo">
			<div>
				<a href="<%=rs("link")%>" target="_blank"><img src="<%=rs("sitepic")%>" alt="<%=rs("name")%>" /></a>
			</div>
			<div class="icon">
				<a href="<%=rs("link")%>" target="_blank"><img src="images/arthurlan/anniu.png" alt="点击进入" /></a>
			</div>
			<div class="clear">
			</div>
		</li>
		<%
		rs.movenext
		wend
		rs.close
		
		%>
	</ul>

        
        <%else%>
         <%=Com_Content%> 
         <%end if%>
         
         
         </div>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>

<!--#include virtual="/foot.asp"-->