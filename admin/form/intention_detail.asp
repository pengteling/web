<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%
id=clng(request("id"))
page=request("page")

if request.Form("act")="do" then
 conn.execute "update intention set flag ='已经处理' where id="&id
end if
set rs=server.createobject("adodb.recordset")
sqltext="select * from intention where id="&id&""
rs.open sqltext,conn,1,1
%>
<style>
.ny-gfyx-bt{width:700px;}
ul{list-style:none; width:700px; padding:0; margin:0;}
ul li{float:left;list-style:none; padding:0; margin:0;}
li.short{width:100px; text-align:right;}
li{width:600px; text-align:left; display:block; height:30px; line-height:30px;}
</style>
<div class="mcontent">
        
        <div class=" ny-gfyx-mtitle">网上预订表单详情</div>
        
       <div class="ny-gfyx-bt">
       <ul>
       
       <li class="short">姓名：</li>
       <li><%=rs("xm")%></li>
     
          <li class="short">联系电话：</li>
       <li><%=rs("lxdh")%></li>
       
        <li class="short">预定校区：</li>
       <li><%=rs("ad")%></li>
        <li class="short">预定科目：</li>
       <li><%=rs("room_class")%></li>
        
       
         <li class="short">预定日期：</li>
          <li><%=rs("addtime")%></li>
         
          <!--<li class="short">验证码：</li>
       <li class="yzm"><input type="text" name="yzm" id="yzm" class=" ny-gfyx-bt-yzm"><span>A8C3</span></li>-->
        <li class="short">状态：</li><li><%=rs("Flag")%></li>
        <li>
        <form method="post" action="intention_detail.asp?id=<%=rs("id")%>">
        <%If cstr(rs("Flag"))="尚未处理" Then %>
        <input type="hidden" name="act" value="do">
        <input type="hidden" name="id" value="<%=id%>">
                      <input type="submit" value="处理订单" name="B1">
                      
<%
end if
rs.close%>
         <input type="button" value="返回上一页" name="B4" onClick="javascript:window.location.href='intention.asp'">
          </form>
         </li>
        
       </ul>
       
       </div>

        </div>
<!-- #include file="../Inc/Foot.asp" -->