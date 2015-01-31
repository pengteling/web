<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%


'response.write Easp.var("WAIT_BUYER_PAY")
id=chkformstr(request("id"))
if request.Form("send")<>"" then

	
	result = Easp.Db.Upd("orderList", "floatmoney={t0},xm={t1},tel={t2},zipcode={t4},addr={t5},remark={t6},beizu={t7},lastModifyTime='"&now()&"'", "ordernum={id}")


	 If result > 0 Then
	 	Easp.str.JsAlertUrl "修改成功！","?id={=id}"	  
	 end if
	 
end if

if ucase(request("act"))="CONFIRMGOODS" then

	Easp.Db.Begin '开始事务
	result = Easp.Db.Upd("orderList", "refund_status='TRADE_FINISHED',confirmISuser=0,confirmAdminUser='"&session("AdminName")&"',confirmTime='"&now()&"'", "ordernum={id}")
	
	set rs=Easp.Db.Sel("select floatmoney , totalmoney  from orderList where ordernum={id}")
	if not rs.eof then
		totalpoints = cint(rs(0)+rs(1))
	end if
	
	result2= Easp.Db.Upd("User","points=points+"&totalpoints&"","userId={userid}") '积分策略
	

	 If result > 0 and result2>0 Then
	 	Easp.Db.Commit '提交事务	 
	 	Easp.str.JsAlertUrl "确认收货成功！","?id={=id}"	  
	 end if
end if


if ucase(request("act"))="OVER" then
	result = Easp.Db.Upd("orderList", "refund_status='TRADE_CLOSED',closeAdminUser='"&session("AdminName")&"',closeTime='"&now()&"'", "ordernum={id}")

	 If result > 0 Then
	 	Easp.str.JsAlertUrl "已关闭订单！","?id={=id}"	  
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


$(function(){
	$(".over").click(function(){
		if(confirm("确定要关闭订单？\n\n不可恢复！")){
			return true;
		};
		return false;
	});
});

$(function(){
	$(".finish").click(function(){
		if(confirm("确定要确认收货？\n\n不可恢复！")){
			return true;
		};
		return false;
	});
});
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
				   		response.write "<a href=""send.asp?act=sendgoods&id="&rs("orderNum")&""">[为订单发货]</a>　"
				   elseif  refund_status="WAIT_BUYER_CONFIRM_GOODS" then
				   		response.write "<a href=""?act=confirmGoods&id="&rs("orderNum")&""" class=""finish"">[确认买家已收货]</a>"
				   end if
				   
				   if refund_status="WAIT_BUYER_PAY" and datediff("d",rs("addtime"),date())>30 then
				   		response.write "<a href=""?act=over&id="&rs("orderNum")&""" class=""over"" title=""超过30天未付款"">[关闭订单]</a>"
					end if
					
					
				   
				   %>
                   
                   
                   </li>
               </ul>
           </dt>
           
           
           <dt><em>金额操作：</em>
               <ul class="order_base">
                   <li><span>浮动金额：</span><input type="text" name="t0" size="10" maxlength="10" value="<%=rs("floatmoney")%>" <%if refund_status<>"WAIT_BUYER_PAY" then response.write "disabled readonly"%>/>　<u>付款前可以对订单总金额进行加减，可输入负数，默认为会员折扣金额</u></li>
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
   
   <div class="clear_fixed">
   
    <dl class="addlist">
           
           <dt><em>订单日志：</em>
           <ul>


<%
		   '读取记录集
Set rs = Easp.Db.Sel("Select * From orderlist_c where ordernum = {id} ")
if not rs.eof then
	response.write "<li>会员："&rs("username")&"于 "&rs("addtime")&" 创建订单  </li>"
end if
rs.close


		   '读取记录集
Set rs = Easp.Db.Sel("Select * From user_order_pay where ordernum = {id} Order By ID Desc")
if not rs.eof then
	response.write "<li>管理员："&rs("adminUser")&"于 "&rs("createdate")&" 确认付款  <a href=""pay.asp?id="&id&""">详情</a></li>"
end if
rs.close


 '读取记录集
Set rs = Easp.Db.Sel("Select * From user_order_post where ordernum = {id} Order By ID Desc")
if not rs.eof then
	response.write "<li>管理员："&rs("adminUser")&"于 "&rs("createdate")&" 确认发货  <a href=""send.asp?id="&id&""">详情</a></li>"
end if
rs.close

		   '读取记录集
Set rs = Easp.Db.Sel("Select * From orderlist_c where ordernum = {id} ")
if not rs.eof then
	if rs("refund_status")="TRADE_FINISHED" then
		if rs("confirmISuser")=1 then 
			response.write "<li>会员："&rs("username")&"于 "&rs("confirmTime")&" 确认收货  </li>"
		else
			response.write "<li>管理员："&rs("confirmAdminuser")&"于 "&rs("confirmTime")&" 确认收货  </li>"
		end if
	
	elseif  rs("refund_status")="TRADE_CLOSED" then
			response.write "<li>管理员："&rs("CloseAdminuser")&"于 "&rs("CloseTime")&" 关闭订单  </li>"
	end if
end if
rs.close


%>
         
           
           </ul>
           </dt>
           </dl>
   
</div>

<!-- #include file="../Inc/Foot.asp" -->