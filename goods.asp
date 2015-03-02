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
     
      <!--#include virtual="/cleft.asp"--> 
    </div>
    <div class="cright fr">
      
    <div class="curlocation">
      <div class="fr"><%=menustr%></div>
     <!-- <div class="fl"><%=catename%></div>-->
     
    </div>
     
      <div class="maincontent" > 
    
         <%showgoods()%>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>



<!--#include virtual="/foot.asp"-->

