<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%
id=chkformstr(request("id"))
if request.Form("send")<>"" then


	Easp.Db.Begin '开始事务
		
	'response.write Easp.Var("t1")
	result = Easp.Db.Ins("user_order_post", "ordernum:{id},postway:'快递物流',postcompany:{t1},postno:{t2},remark:{t4},adminUser:'"&session("AdminName")&"'")
	 
	 result2 = Easp.Db.Upd("orderList", "refund_status='WAIT_BUYER_CONFIRM_GOODS'", "ordernum={id}")
	 
	 Easp.Db.Commit '提交事务
	 
	 
	  If result > 0 and result2>0 Then
	 	Easp.str.JsAlertUrl "确认发货成功！","Manage_Eshop_detail.asp?id={=id}"	  
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
				$.message({content:"快递公司不能为空"});
				the.t1.focus();
				return false
			}
			if($.trim(the.t2.value)=="")
			{
				$.message({content:"快递单号不能为空"});
				the.t2.focus();
				return false
			}
		
	
	if(confirm("确认提交发货信息都正确？\n\n不可恢复！"))
	{
		return true;
	}
	return false
}
</script>

  
  
    <div class="clear_fixed">
    <form onSubmit="return checkdata(this,2,'0','',1)" method="post">
      <dl class="addlist">
           
          
           <dt><em>订单信息：</em>
               <ul class="order_base">
                   <li><span>订单编号：</span><%=rs("orderNum")%><input type="hidden" name="id" value="<%=id%>"></li>
                   <li><span>商品总金额：</span>¥ <strong style="color:red; font-size:14px; font-family:Arial, Helvetica, sans-serif;"><%=totalmoeny%> </strong>元</li>
                   <li><span>实际需付款金额：</span>¥ <strong style="color:red; font-size:14px; font-family:Arial, Helvetica, sans-serif;"><%=rs("totalmoney") + rs("floatmoney")%> </strong>元<input type="hidden" value="<%=rs("totalmoney") + rs("floatmoney")%>" name="totalmoney"></li>
                   <li><span>订单状态：</span><%=Easp.var(refund_status)%></li>
               </ul>
           </dt>
           <dt><em>收货信息：</em>
               <ul class="order_base">
                   <li><span>收货人：</span><%=rs("xm")%></li>
                   <li><span>电话：</span><%=rs("tel")%></li>
             
                   <li><span>邮政编码：</span><%=rs("zipcode")%></li>
                   <li><span>收货地址：</span><%=rs("addr")%></li>
                   <li><span>订单附言：</span><%=rs("remark")%></li>
               </ul>
           </dt>
           
           
          <%
if refund_status="WAIT_SELLER_SEND_GOODS" then
%>

           <dt><em>发货信息：</em>
               <ul class="order_base">
                   <li><span>发货方式：</span>
                   <!--<input type="radio" name="t0" id="t0_0" size="30" value="1" class="b0" checked /><label for="t0_0">无需发货</label>-->
                   <input type="radio" name="t0" id="t0_1" size="30" value="2" class="b0" checked/><label for="t0_1">快递物流</label>
                  <!-- <input type="radio" name="t0" id="t0_2" size="30" value="3" class="b0" /><label for="t0_2">虚拟物品</label>-->
                   </li>
                  <!-- <li class="no"><span>原因：</span><textarea name="t5" cols="50" rows="3" onKeyUp="strlen_verify(this,'no_len',255)"></textarea>
           还可输入<u id="no_len">255</u> 个字</li>-->
                   <li class="dis bank"><span>快递公司：</span><input type="text" name="t1" id="t1" size="50" maxlength="50" /> <select onChange="if(this.value!='')$('#t1').val(this.value)"><option value="">请选择</option><option value="EMS快递">EMS快递</option><option value="申通快递">申通快递</option><option value="圆通快递">圆通快递</option><option value="中通快递">中通快递</option><option value="韵达快递">韵达快递</option><option value="顺丰快递">顺丰快递</option><option value="天天快递">天天快递</option><option value="联邦快递">联邦快递</option></select></li>
                   <li class="dis bank"><span>快递单号：</span><input type="text" name="t2" size="50" maxlength="50" /></li>
                 <!--  <li class="dis api"><span>物品信息：</span><textarea name="t3" cols="50" rows="5"></textarea></li>-->
                   <li><span>发货备注：</span><textarea name="t4" cols="50" rows="3" onKeyUp="strlen_verify(this,'description_len',255)"></textarea>
           还可输入<u id="description_len">255</u> 个字符</li>
               </ul>
           </dt>
           
           <dd><input type="submit" name="send" value="保存" /><input type="button" value="返回" onClick="location.href='javascript:history.go(-1)'" /></dd>
           
           
            <%else%>
           <dt><em>发货信息：</em>
               <ul class="order_base">
               <%
			    rs.close
			   rs.open "Select * from user_order_post where orderNum='"& id&"'",conn,1,1
			   if not rs.eof then
			   %>
                   <li><span>快递公司：</span><%=rs("postcompany")%></li>
                   <li><span>快递单号：</span><%=rs("postno")%></li>                   
                   <li><span>发货备注：</span><%=rs("remark")%></li>
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