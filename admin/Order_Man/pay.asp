<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%


'response.write Easp.var("WAIT_BUYER_PAY")
id=chkformstr(request("id"))
if request.Form("send")<>"" then


	Easp.Db.Begin '开始事务
		
	'response.write Easp.Var("t1")
	result = Easp.Db.Ins("user_order_pay", "ordernum:{id},payway:'线下支付',totalmoney:{totalmoney},bankname:{t1},bankno:{t2},remark:{t5},adminUser:'"&session("AdminName")&"'")
	 
	 result2 = Easp.Db.Upd("orderList", "refund_status='WAIT_SELLER_SEND_GOODS'", "ordernum={id}")
	 
	 Easp.Db.Commit '提交事务
	 
	 
	  If result > 0 and result2>0 Then
	 	Easp.str.JsAlertUrl "确认付款成功！","Manage_Eshop_detail.asp?id={=id}"	  
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
	
			if($.trim(the.t1.value)=="")
			{
				$.message({content:"收款的银行不能为空"});
				the.t1.focus();
				return false
			}
			if($.trim(the.t2.value)=="")
			{
				$.message({content:"收款的银行卡号不能为空"});
				the.t2.focus();
				return false
			}
	

	if(confirm("确认提交付款信息都正确？\n\n不可恢复！"))
	{
		return true;
	}
	return false
}
</script>

    <div class="clear_fixed">
    <form onSubmit="return checkdata(this,3,'0','',1)" method="post">
      <dl class="addlist">
           
           <dt><em>订单信息：</em>
               <ul class="order_base">
                   <li><span>订单编号：</span><%=rs("orderNum")%><input type="hidden" name="id" value="<%=id%>"></li>
                   <li><span>商品总金额：</span>¥ <strong style="color:red; font-size:14px; font-family:Arial, Helvetica, sans-serif;"><%=totalmoeny%> </strong>元</li>
                   <li><span>实际需付款金额：</span>¥ <strong style="color:red; font-size:14px; font-family:Arial, Helvetica, sans-serif;"><%=rs("totalmoney") + rs("floatmoney")%> </strong>元<input type="hidden" value="<%=rs("totalmoney") + rs("floatmoney")%>" name="totalmoney"></li>
                   <li><span>订单状态：</span><%=Easp.var(refund_status)%></li>
               </ul>
           </dt>
<%
if refund_status="WAIT_BUYER_PAY" then
%>

           <dt><em>付款信息：</em>
               <ul class="order_base">
                   <li><span>支付方式：</span>
                   <!--<input type="radio" name="t0" id="t0_0" size="30" value="-1" class="b0" checked /><label for="t0_0">账户余款支付</label>-->
                   <input type="radio" name="t0" id="t0_1" size="30" value="-2" class="b0"  checked /><label for="t0_1">线下支付</label>
                 <!--  <input type="radio" name="t0" id="t0_2" size="30" value="-3" class="b0" /><label for="t0_2">第三方接口支付</label>-->
                   </li>
                   <li class="dis bank"><span>收款的银行：</span><input type="text" name="t1" id="t1" size="50" maxlength="50" /> <select onChange="if(this.value!='')$('#t1').val(this.value)"><option value="">请选择</option><option value="工行">工行</option><option value="建行">建行</option><option value="农行">农行</option><option value="邮政汇款">邮政汇款</option></select></li>
                   <li class="dis bank"><span>收款的银行卡号：</span><input type="text" name="t2" size="50" maxlength="50" /></li>
                  <!-- <li class="dis api"><span>服务商：</span><input type="text" name="t3" id="t3" size="50" maxlength="50" /> <select onChange="if(this.value!='')$('#t3').val(this.value)"><option value="">请选择</option><option value="支付宝">支付宝</option><option value="财付通">财付通</option><option value="银联在线">银联在线</option><option value="云网支付">云网支付</option></select></li>
                   <li class="dis api"><span>收款账户：</span><input type="text" name="t4" size="50" maxlength="50" /></li>-->
                   <li><span>付款备注：</span><textarea name="t5" cols="50" rows="3" onKeyUp="strlen_verify(this,'description_len',255)"></textarea>
           还可输入<u id="description_len">255</u> 个字符</li>
               </ul>
           </dt>
           
           <dd><input type="submit" name="send" value="保存" /><input type="button" value="返回" onClick="location.href='javascript:history.go(-1)'" /></dd>
           <%else%>
           <dt><em>付款信息：</em>
               <ul class="order_base">
               <%
			    rs.close
			   rs.open "Select * from user_order_pay where orderNum='"& id&"'",conn,1,1
			   if not rs.eof then
			   %>
                   <li><span>收款的银行：</span><%=rs("bankname")%></li>
                   <li><span>收款的银行卡号：</span><%=rs("bankno")%></li>
                   <li><span>订单金额：</span><%=rs("totalmoney")%></li>
                   <li><span>付款备注：</span><%=rs("remark")%></li>
                   <%
				end if 
				   rs.close
				   %>
               </ul>
           </dt>
           
           <dd><input type="button" value="返回" onClick="location.href='javascript:history.go(-1)'" /></dd>
           
           <%end if%>
           
           
       </dl>
   </form>
</div>



<!-- #include file="../Inc/Foot.asp" -->