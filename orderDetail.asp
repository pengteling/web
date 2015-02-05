<!--#include virtual="/fiveinc/conn.asp"-->
<!--#include virtual="/User_Config.asp"-->

<%
curpageTitle = "我的订单详情"
%>
<!--#include virtual="/top.asp"-->
<%
set rs=Easp.Db.Sel("select * from OrderList where OrderNum={id}")

if rs.eof then response.write "订单有误":response.End()
refund_status = trim(rs("refund_status"))
totalmoeny =rs("totalmoney")
%>



<script>
$(function(){
	$(".ico02").addClass("hover ico02_");
	
})
</script>





 <div class="width">
        <div class="user_bg">
            <div id="uleft">
    <!--#include virtual="/uleft.asp"-->
</div>
            <!--左侧结束-->
            <div id="uright">
                <div id="ordershow">
                    
                    
                    
                    
                    
                    <div class="titleinfo">订单信息</div>
                    <table class="table1">
                     <tr>
                        <td class="info">订单编号：</td>
                        <td><%=rs("orderNum")%></td>
                    </tr>
                    <tr>
                        <td class="info">订单总金额：</td>
                        <td><span>¥<%=rs("totalmoney") + rs("floatmoney")%></span> 元  （优惠<span><%=-rs("floatmoney")%></span>元）</td>
                    </tr>
                    <tr>
                        <td class="info">付款方式：</td>
                        <td>线下汇款</td>
                    </tr>
                    <tr>
                        <td class="info">订单附言：</td>
                        <td><%=rs("remark")%></td>
                    </tr>
                    <tr>
                        <td class="info">订单状态：</td>
                        <td><%=Easp.var(refund_status)%></a>
                        </td>
                    </tr>
                    
                    </table>
                    
                    <%if refund_status<>"WAIT_BUYER_PAY" and refund_status<>"WAIT_SELLER_SEND_GOODS" then%>
                    
                    <div class="titleinfo">发货信息</div>
                    
                    <%
					set rs2=Easp.Db.Sel("Select * from user_order_post where orderNum={id}")
					if not rs2.eof then
					%>
                    <table class="table1">
                        <tr>
                            <td class="info">快递公司：</td>
                            <td><%=rs2("postcompany")%></td>
                        </tr>
                        <tr>
                            <td class="info">快递单号：</td>
                            <td><%=rs2("postno")%></td>
                        </tr>
                        <tr>
                            <td class="info">发货备注：</td>
                            <td><%=rs2("remark")%></td>
                        </tr>
                    </table>
                    
                    <%
					end if
					rs2.close
					
					end if%>
                    
                    
                    <div class="titleinfo">收货信息</div>
                    <table class="table1">
                        <tr>
                            <td class="info">收货人：</td>
                            <td><%=rs("xm")%></td>
                        </tr>
                        <tr>
                            <td class="info">联系电话：</td>
                            <td><%=rs("tel")%></td>
                        </tr>
                        
                        <tr>
                            <td class="info">邮政编码：</td>
                            <td><%=rs("zipcode")%></td>
                        </tr>
                        <tr>
                            <td class="info">收货地址：</td>
                            <td><%=rs("addr")%></td>
                        </tr>
                    </table>
                    <div class="titleinfo">商品信息</div>
                    <table class="table2">
                        <tr>
                            <th>商品名称</th>
                            
                            <th width="80">会员价</th>
                            <th width="60">数量</th>
                            <th width="80">小计</th>
                        </tr>
                        
                          <%
				rs.close
				countNum = 0 
				
				set rs=Easp.Db.Sel( "Select * from orderDetail where orderNum= {id} order by id desc")
				while not rs.eof 
				countNum=countNum+rs("count")
				%>    
                    <tr>
                        <td><a href="../show.asp?id=<%=rs("goodsid")%>" target="_blank"><%=rs("goodsName")%></a></td>	
                       
                        <td>¥<%=rs("price")%></td>
                        <td><%=rs("count")%></td>
                        <td class="price">¥<%=rs("totalprice")%></td>
                    </tr>
                    
                  <%
				  rs.movenext
				  wend
				  rs.close
				  %>  
                    
                    <tr>
                        <td colspan="4" class="info">商品共计：<span><%=countNum%></span>件　商品总金额：<span>¥<%=totalmoeny%></span>元</td>
                    </tr>
                        
                        
                        
                        
                        
                        
                    </table>
                    
                    <div class="titleinfo">订单日志</div>
                    <table class="table1">
                    
                    
                    <%
		   '读取记录集
Set rs = Easp.Db.Sel("Select * From orderlist_c where ordernum = {id} ")
if not rs.eof then
	response.write "<tr><td>会员："&rs("username")&"于 "&rs("addtime")&" 创建订单  </td></tr>"
end if
rs.close


		   '读取记录集
Set rs = Easp.Db.Sel("Select * From user_order_pay where ordernum = {id} Order By ID Desc")
if not rs.eof then
	response.write "<tr><td>管理员："&rs("adminUser")&"于 "&rs("createdate")&" 确认付款</td></tr>"
end if
rs.close


 '读取记录集
Set rs = Easp.Db.Sel("Select * From user_order_post where ordernum = {id} Order By ID Desc")
if not rs.eof then
	response.write "<tr><td>管理员："&rs("adminUser")&"于 "&rs("createdate")&" 确认发货 </td></tr>"
end if
rs.close

		   '读取记录集
Set rs = Easp.Db.Sel("Select * From orderlist_c where ordernum = {id} ")
if not rs.eof then
	if rs("refund_status")="TRADE_FINISHED" then
		if rs("confirmISuser")=1 then 
			response.write "<tr><td>会员："&rs("username")&"于 "&rs("confirmTime")&" 确认收货  </td></tr>"
		else
			response.write "<tr><td>管理员："&rs("confirmAdminuser")&"于 "&rs("confirmTime")&" 确认收货  </td></tr>"
		end if
	
	elseif  rs("refund_status")="TRADE_CLOSED" then
			response.write "<tr><td>管理员："&rs("CloseAdminuser")&"于 "&rs("CloseTime")&" 关闭订单  </td></tr>"
	end if
end if
rs.close


%>

                        
                        
                    </table>
                
                </div>
            </div>
            <!--右侧结束-->
            <div class="clear"></div>
        </div>
    </div>
<!--#include virtual="/foot.asp"-->