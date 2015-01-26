<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%


'response.write Easp.var("WAIT_BUYER_PAY")
id=chkformstr(request("id"))
if request.Form("send")<>"" then

	
	result = Easp.Db.Upd("orderList", "floatmoney={t0},xm={t1},tel={t2},zipcode={t4},addr={t5},remark={t6},beizu={t7}", "ordernum={id}")


	 If result > 0 Then
	 	Easp.str.JsAlertUrl "修改成功！","?id={=id}"	  
	 end if
	 
end if


set rs=server.createobject("adodb.recordset")
sqltext="select * from OrderList where OrderNum='"&id&"'"
rs.open sqltext,conn,1,1
if rs.eof then response.write "订单有误":response.End()
refund_status = trim(rs("refund_status"))
totalmoeny =rs("totalmoney")
%>


<script>
function checkdata(the,id,sta,keyword,page)
{
	if(isNaN(the.t0.value))
	{
		$.message({content:"浮动金额必须是数字"});
		the.t0.focus();
		return false
	}
	
	if($.trim(the.t1.value)=="")
	{
		$.message({content:"\u6536\u8d27\u4eba\u4e0d\u80fd\u4e3a\u7a7a"});
		the.t1.focus();
		return false
	}
	if($.trim(the.t2.value)=="")
	{
		$.message({content:"电话不能为空"});
		the.t2.focus();
		return false
	}
	if($.trim(the.t4.value)=="")
	{
		$.message({content:"\u90ae\u653f\u7f16\u7801\u4e0d\u80fd\u4e3a\u7a7a"});
		the.t4.focus();
		return false
	}
	if($.trim(the.t5.value)=="")
	{
		$.message({content:"\u6536\u8d27\u5730\u5740\u4e0d\u80fd\u4e3a\u7a7a"});
		the.t5.focus();
		return false
	}
	return true;
}

</script>


    <div class="clear_fixed">
    <form onSubmit="return checkdata(this,3,'0','',1)" method="post">
      <dl class="addlist">
           
           <dt><em>订单信息：</em>
               <ul class="order_base">
                   <li><span>订单编号：</span><%=rs("orderNum")%><input type="hidden" name="id" value="<%=id%>"></li>
                   <li><span>商品总金额：</span>¥ <strong style="color:red; font-size:14px; font-family:Arial, Helvetica, sans-serif;"><%=totalmoeny%> </strong>元</li>
                   <li><span>实际需付款金额：</span>¥ <strong style="color:red; font-size:14px; font-family:Arial, Helvetica, sans-serif;"><%=rs("totalmoney") + rs("floatmoney")%> </strong>元</li>
                   <li><span>订单状态：</span><%=Easp.var(refund_status)%></li>
                   <li><span>管理员操作：</span>
                   
                   <%if refund_status="WAIT_BUYER_PAY" then
				   		response.write "<a href=""pay.asp?act=pay&id="&rs("orderNum")&""">[为订单付款]</a>　"
				   elseif  refund_status="WAIT_SELLER_SEND_GOODS" then
				   		response.write "<a href=""?act=sendgoods&id="&rs("orderNum")&""">[为订单发货]</a>　"
				   elseif  refund_status="WAIT_BUYER_CONFIRM_GOODS" then
				   		response.write "<a href=""?act=sendgoods&id="&rs("orderNum")&""">[确认买家已收货]</a>"
				   end if
				   %>
                   
                   
                   </li>
               </ul>
           </dt>
           <dt><em>金额操作：</em>
               <ul class="order_base">
                   <li><span>浮动金额：</span><input type="text" name="t0" size="10" maxlength="10" value="<%=rs("floatmoney")%>" />　<u>可以对订单总金额进行加减，可输入负数</u></li>
               </ul>
           </dt>
           <dt><em>收货信息：</em>
               <ul class="order_base">
                   <li><span>收货人：</span><input type="text" name="t1" size="30" maxlength="50" value="<%=rs("xm")%>" /></li>
                   <li><span>电话：</span><input type="text" name="t2" size="30" maxlength="50" value="<%=rs("tel")%>" /></li>
                 <!--  <li><span>手机：</span><input type="text" name="t3" size="30" maxlength="50" value="" /></li>-->
                   <li><span>邮政编码：</span><input type="text" name="t4" size="30" maxlength="6" value="<%=rs("zipcode")%>" /></li>
                   <li><span>收货地址：</span><input type="text" name="t5" size="66" maxlength="255" value="<%=rs("addr")%>" /></li>
               </ul>
           </dt>
           <dt><em>订单附言：</em>
           <ul class="order_base">
                   <li><span>客户附言：</span><textarea name="t6" cols="50" rows="3" onKeyUp="strlen_verify(this,'description_len',255)"><%=rs("remark")%></textarea>
           还可输入<u id="description_len">255</u> 个字符</li>
           </ul>
           </dt>
           <dt><em>订单备注：</em>
           <ul class="order_base">
                   <li><span>订单备注：</span><textarea name="t7" cols="50" rows="3" onKeyUp="strlen_verify(this,'remark_len',255)"><%=rs("beizu")%></textarea>
           还可输入<u id="remark_len">255</u> 个字符</li>
           </ul>
           </dt>
           <dt><em>商品信息：</em>
               <table class="order_pro">
                    <tr>
                        <th>商品名称</th>
                        <th width="80">市场价</th>
                      
                        <th width="60">数量</th>
                        <th width="80">小计</th>
                    </tr>
                    
                    
                <%
				rs.close
				countNum = 0 
				
				rs.open "Select * from orderDetail where orderNum ='"& id &"' order by id desc",conn,1,1
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
                        <td colspan="5" class="info">商品共计：<span><%=countNum%></span>件　商品总金额：<span>¥<%=totalmoeny%></span>元</td>
                    </tr>
                </table>
           </dt>
           <dd><input type="submit" name="send" value="保存" /><input type="button" value="返回" onClick="location.href='javascript:history.go(-1)'" /></dd>
           
       </dl>
   </form>
</div>

<!-- #include file="../Inc/Foot.asp" -->