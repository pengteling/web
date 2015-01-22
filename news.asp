<!--#include file="fiveinc/inc.asp"-->
<!--#include file="FiveInc/Check_Sql.asp"-->
<!--#include file="FiveInc/page.asp"-->
<%
nid=strToNum(Request.QueryString("id"))
rs.open "select * from category where cateid="&nid,conn,1,1
if not rs.eof then
	cateid=nid
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
        <%shownews()%>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>

<!--#include virtual="/foot.asp"-->

