<!--#include file="fiveinc/inc.asp"-->
<!--#include file="FiveInc/Check_Sql.asp"-->
<!--#include file="FiveInc/page.asp"-->

<%curpageTitle="资料搜索 - "&SiteTitle 
sokey = chkformstr(request.QueryString("so"))
if sokey="" then
sokey="非去不可"
end if
 
 stype=strToNum(Request("stype"))	
	

%>
<!--#include file="top.asp"-->


<div class="main">
  <div class="box-line-b seabox">
  <div class="tit yahei green">
  	<div class="zh">搜索结果 </div>
  	<div class="en">Search Results</div>
  </div>
  
  
<div class="pad19">
  <div class="searchbox">
            <form action="search.asp">
              <input type="text" name="so" class="txt_search"  value="<%=sokey%>"/>
              <input type="submit" class="btn_search"  value=""/>
             <p>
   				 <input name="stype" type="radio" value="0" <%if stype=0 then response.write "checked"%> >信息标题
               <input name="stype" type="radio" value="1" <%if stype=1 then response.write "checked"%>>信息全文
              </p>
            </form>

            
  </div>
  <%if request.QueryString("so")<>"" then
  showSearch()
  end if
  %>
 
  

          
</div>

  
  </div>
  </div>
  
<!--#include file="foot.asp"-->