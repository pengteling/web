<!--#include file="fiveinc/inc.asp"-->
<!--#include file="FiveInc/Check_Sql.asp"-->
<!--#include file="FiveInc/page.asp"-->
<%
'nid=strToNum(Request.QueryString("id"))
nid=18
rs.open "select * from category where cateid="&nid,conn,1,1
if not rs.eof then
	cateid=nid
	parentid=rs("parentid")
	sonid=rs("sonid")
	followid=rs("followid")	
	catetype=rs("catetype")
	modeltype=rs("modeltype")
	catename= rs("catename")		
	com_title=rs("title")
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
        <div class="mtit"><%=com_title%></div>
        <div class="zuji">
        
        <%
		rs.open "Select top 1 * from news_c where cateid=18  order by posttime desc"
		if not rs.eof then
		
		  c_year =year( rs("posttime"))
		 end if
		 rs.close
		  if request("year")<>"" then
			  c_year=clng(request("year"))
		  end if
		   s_date =C_year & "-1-1"
		  e_date =C_year &"-12-31"
		  
		  
		%>
          <div class="timeline">
            
            
            
            <%rs.open "Select top 1 * from news_c where cateid=18 and posttime<#"&s_date&"# order by posttime desc"
		  if not rs.eof then
		  year1 = year(rs("posttime"))
		  %>
		  

            <div class="time1"><a href="zuji.asp?id=18&year=<%=year1%>"><%=year1%></a></div>
            <div class="leftarr"><a href="zuji.asp?id=18&year=<%=year1%>"></a></div>
            <%else%>
             <div class="leftarr"></div>
            		  <%end if
					  rs.close
					  %>
            <div class="time2"><a href="zuji.asp?id=18&year=<%=c_year%>"><%=c_year%></a></div>
            
             <%
			' response.write "Select top 1 * from news_c where cateid=18 and posttime>#"&e_date&"# order by posttime"
			 rs.open "Select top 1 * from news_c where cateid=18 and posttime>#"&e_date&"# order by posttime"
		  if not rs.eof then
		  year3 = year(rs("posttime"))
		  %>
		  

            <div class="time3"><a href="zuji.asp?id=18&year=<%=year3%>"><%=year3%></a></div>
            <div class="rightarr"><a href="zuji.asp?id=18&year=<%=year3%>"></a></div>
            <%else%>
            <div class="rightarr"></div>
            		  <%end if
					  rs.close
					  %>
                      
          
          </div>
          
          <div class="zujilist">
          
          <ul>
          <%	
		 k=0
		  rs.open "select * from news_c where cateid=18 and posttime>#"&s_date&"# and posttime<#"&e_date&"# order by posttime ",conn,1,1
		  while not rs.eof
		  k=k+1
		  %>
          
          	<li class="<%if k mod 2=1 then response.write "odd" else response.write "even" end if%>">
            <div class="pic"><a ><img src="<%=rs("defaultpicurl")%>" width="258" height="178"/></a></div>
            <div class="tit"><span class="time"><%=formatdate(rs("posttime"),2)%></span><br />
            <%=rs("title")%></div>
            </li>
            
            <%
			rs.movenext
			wend
			rs.close%>
            
            
          </ul>
          </div>
        </div>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>

<!--#include virtual="/foot.asp"-->