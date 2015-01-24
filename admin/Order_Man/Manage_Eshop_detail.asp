<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%


'response.write Easp.var("WAIT_BUYER_PAY")
id=request("id")
page=request("page")
set rs=server.createobject("adodb.recordset")
sqltext="select * from OrderList where OrderNum='"&id&"'"
rs.open sqltext,conn,1,1

refund_status = trim(rs("refund_status"))
%>


<script>
function checkdata(the,id,sta,keyword,page)
{
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
    <form onSubmit="return checkdata(this,3,'0','',1)">
      <dl class="addlist">
           
           <dt><em>订单信息：</em>
               <ul class="order_base">
                   <li><span>订单编号：</span><%=rs("orderNum")%></li>
                   <li><span>商品总金额：</span>¥ <strong style="color:red; font-size:14px; font-family:Arial, Helvetica, sans-serif;"><%=rs("totalmoney")%> </strong>元</li>
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
                   <li><span>浮动金额：</span><input type="text" name="t0" size="10" maxlength="10" value="0" />　<u>可以对订单总金额进行加减，可输入负数</u></li>
               </ul>
           </dt>
           <dt><em>收货信息：</em>
               <ul class="order_base">
                   <li><span>收货人：</span><input type="text" name="t1" size="30" maxlength="50" value="二恶烷" /></li>
                   <li><span>电话：</span><input type="text" name="t2" size="30" maxlength="50" value="34432434" /></li>
                 <!--  <li><span>手机：</span><input type="text" name="t3" size="30" maxlength="50" value="" /></li>-->
                   <li><span>邮政编码：</span><input type="text" name="t4" size="30" maxlength="6" value="400084" /></li>
                   <li><span>收货地址：</span><input type="text" name="t5" size="66" maxlength="255" value="重庆市" /></li>
               </ul>
           </dt>
           <dt><em>订单附言：</em>
           <ul class="order_base">
                   <li><span>客户附言：</span><textarea name="t6" cols="50" rows="3" onKeyUp="strlen_verify(this,'description_len',255)"></textarea>
           还可输入<u id="description_len">255</u> 个字符</li>
           </ul>
           </dt>
           <dt><em>订单备注：</em>
           <ul class="order_base">
                   <li><span>订单备注：</span><textarea name="t7" cols="50" rows="3" onKeyUp="strlen_verify(this,'remark_len',255)"></textarea>
           还可输入<u id="remark_len">255</u> 个字符</li>
           </ul>
           </dt>
           <dt><em>商品信息：</em>
               <table class="order_pro">
                    <tr>
                        <th>商品名称</th>
                        <th width="80">市场价</th>
                        <th width="80">会员价</th>
                        <th width="60">数量</th>
                        <th width="80">小计</th>
                    </tr>
                    
                    
                    
                    <tr>
                        <td><a href="../show.asp?id=2" target="_blank">农具二</a></td>	
                        <td><del>¥200.00</del></td>
                        <td>¥200.00</td>
                        <td>1</td>
                        <td class="price">¥200.00</td>
                    </tr>
                    
                    
                    
                    <tr>
                        <td colspan="5" class="info">商品共计：<span>1</span>件　商品总金额：<span>¥200.00</span>元</td>
                    </tr>
                </table>
           </dt>
           <dd><input type="submit" name="send" value="保存" /><input type="button" value="返回" onClick="location.href='javascript:history.go(-1)'" /></dd>
           
       </dl>
   </form>
</div>

<!-- #include file="../Inc/Foot.asp" -->