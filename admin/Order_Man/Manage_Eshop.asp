<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<script language="javascript">
function confirmdel(id,oid,page){
if (confirm("真的要删除这个订单?"))
window.location.href="Manage_Eshop.asp?id="+id+"&ordernum="+oid+"&page="+page
}
</script>
<table>
<tr>
  <td>
  <form action="manage_Eshop.asp" method="get">请输入关键词进行查询：
        <input name="keywords" value=""><input type="submit" value="搜索">
        </form></td>
  </tr>
 </table>
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="table_southidc">
  <tr>
    <td height="25" align="center" class="back_southidc"><strong>订单管理</strong></td>
  </tr>
  
</table>

<%
strFileName="Manage_Eshop.asp?1=1"
keywords=ChkFormStr(Request("keywords"))


id = strToNum(request("id"))
if id > 0 then
   conn.execute("update OrderList set isdel=1 where id=" & id)
   Easp.Db.exec("update orderDetail set isdel=1 where orderNum={orderNum}")
end if

flag="尚未处理"
set rs=server.createobject("adodb.recordset")
sqltext="select * from OrderList_c  order by addtime desc"

if keywords<>"" then
strFileName=strFileName&"&keywords="&server.URLEncode(keywords)
sqltext="select * from OrderList_c where  (ordernum like '%"&keywords&"%' or username like '%"&keywords&"%' or tel like '%"&keywords&"%' or xm like '%"&keywords&"%') order by addtime desc"
end if

if Easp.var("Cuserid")<>"" then

sqltext="select * from OrderList_c where userid="&Clng(Easp.var("cuserid"))&" order by addtime desc"
end if

'response.write sqltext
rs.open sqltext,conn,1,1

dim MaxPerPage
MaxPerPage=20

'取得页数,并判断用户输入的是否数字类型的数据，如不是将以第一页显示
dim text,checkpage
text="0123456789"
Rs.PageSize=MaxPerPage
totalput=rs.recordcount
for i=1 to len(request("page"))
checkpage=instr(1,text,mid(request("page"),i,1))
if checkpage=0 then
exit for
end if
next

If checkpage<>0 then
If NOT IsEmpty(request("page")) Then
CurrentPage=Cint(request("page"))
If CurrentPage < 1 Then CurrentPage = 1
If CurrentPage > Rs.PageCount Then CurrentPage = Rs.PageCount
Else
CurrentPage= 1
End If
If not Rs.eof Then Rs.AbsolutePage = CurrentPage end if
Else
CurrentPage=1
End if



'显示帖子的子程序
Sub list()
%> 
            <table width="100%" border="0" align="center" cellpadding="4" cellspacing="1" class="table_southidc">
              <tr bgcolor="#A4B6D7" class="tr_southidc">
                <td width="12%" align="center">订单编号</td> 
                <td height="25" align="center">用户名</td>
                 <td align="center">商品金额</td>
                 <td align="center">浮动金额</td>
                 <td align="center">实际付款</td>
                 <td align="center">订单状态</td>
                 <td align="center">下单时间</td>
                <td width="10%" align="center"> 
                  收货人</td>
                <td width="13%" align="center"> 
                  联系电话</td>
                
                <td width="11%" align="center"> 
                  操作</td>
              </tr>
              <%
if not rs.eof then
i=0
do while not rs.eof
%>
              <tr bgcolor="#ECF5FF">
                <td align="center" bgcolor="#ECF5FF"><%=rs("OrderNum")%></td> 
                <td align="center" bgcolor="#ECF5FF"> 
                <%=rs("username")%></td>
                <td align="center" bgcolor="#ECF5FF"> 
                <%=rs("totalmoney")%></td>
                <td align="center" bgcolor="#ECF5FF"> 
                <%=rs("floatmoney")%></td>
                <td align="center" bgcolor="#ECF5FF"><span style="color:red" >
                <%=rs("totalmoney")+rs("floatmoney")%></span></td>
                <td align="center" bgcolor="#ECF5FF"> 
                  <%=Easp.var(trim(rs("refund_status")))%>
                </td>
                <td align="center" bgcolor="#ECF5FF"> 
                  <%=rs("addtime")%>
                </td>
               
                <td align="center" bgcolor="#ECF5FF"> 
                  <%=rs("xm")%>
                </td>
                
                 <td align="center" bgcolor="#ECF5FF"> 
                  <%=rs("tel")%>
                </td>
                
                <td align="center" bgcolor="#ECF5FF"> 
            <%response.write "<a href='Manage_Eshop_detail.asp?ID="&rs("OrderNum")&"&page="&CurrentPage&"'  >查看/编辑</a>"
                    response.write "&nbsp;&nbsp;<a href='javascript:confirmdel(" & rs("id") & ",""" & rs("orderNum") & ""","& CurrentPage&")'>删除</a>"
%>                </td>
              </tr>
              <%
i=i+1
if i >= MaxPerpage then exit do
rs.movenext
loop
end if
%>
              <tr class="tr_southidc"> 
                <td height="25" colspan="10">&nbsp;&nbsp; 
                  <%
Response.write "<strong><font color='#000000'>-> 全部-</font>"
Response.write "共</font>" & "<font color=#FF0000>" & Cstr(Rs.RecordCount) & "</font>" & "<font color='#000000'>个订单</font></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
Response.write "<strong><font color='#000000'>第</font>" & "<font color=#FF0000>" & Cstr(CurrentPage) &  "</font>" & "<font color='#000000'>/" & Cstr(rs.pagecount) & "</font></strong>&nbsp;"
If currentpage > 1 Then
response.write "<strong><a href='Manage_Eshop.asp?&page="+cstr(1)+"'><font color='#000000'>首页</font></a><font color='#ffffff'> </font></strong>"
Response.write "<strong><a href='Manage_Eshop.asp?page="+Cstr(currentpage-1)+"'><font color='#000000'>上一页</font></a><font color='#ffffff'> </font></strong>"
Else
Response.write "<strong><font color='#000000'>上一页 </font></strong>"
End if
If currentpage < Rs.PageCount Then
Response.write "<strong><a href='Manage_Eshop.asp?page="+Cstr(currentPage+1)+"'><font color='#000000'>下一页</font></a><font color='#ffffff'> </font>"
Response.write "<a href='Manage_Eshop.asp?page="+Cstr(Rs.PageCount)+"'><font color='#000000'>尾页</font></a></strong>&nbsp;&nbsp;"
Else
Response.write ""
Response.write "<strong><font color='#000000'>下一页</font></strong>&nbsp;&nbsp;"
End if
'response.write "</td><td align='right'>"
'response.write "<font color='#000000' >转到：</font><input type='text' name='page' size=4 maxlength=4 class=smallInput value="&Currentpage&">&nbsp;"
'response.write "<input class=buttonface type='submit'  value='Go'  name='cndok'>&nbsp;&nbsp;"
%>                </td>
              </tr>
</table>


<%showpage strFileName,totalput,MaxPerPage,true,false,"条信息"
End sub
call list
rs.close
conn.close
%>
<!-- #include file="../Inc/Foot.asp" -->