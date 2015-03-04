<!--#include virtual="/fiveinc/conn.asp"-->
<!--#include virtual="/User_Config.asp"-->
<%
curpageTitle = "完成订单"
%>
<!--#include virtual="/top.asp"-->
<%
set rs=Easp.Db.Sel("Select * from orderList_c where orderNum={newid}  ")
if rs.eof then response.Write "订单有误":response.End() 

 orderMoney =rs("totalmoney") + rs("floatmoney")



%>

<script>
function checkdb(the,payway,total,id)
{
	if(confirm("确定要支付"+total+"元？"))
	{
		the.send.disabled=true;
		switch(payway)
		{
			case "-1":
				
				break;
			case "0":
				alert("请线下汇款后联系客服为您处理！");
				the.send.disabled=false;
				break;
			default:
				window.open("user/order.asp?act=pay&id="+id+"");
				the.send.disabled=false;
				break;
		}
	}
	return false
}

</script>



 <div class="width">
      <div id="cart_div" class="mt10">
          <div class="cart_quick">
              <div class="cart_ico">我的购物车</div>
              <div class="cart_step">
                  <ul>
                      <li class="step1"><span class="active"><span><span>1.查看购物车</span></span></span></li>
                      <li class="step2"><span class="active"><span><span>2.填写购物信息</span></span></span></li>
                      <li class="step3"><span class="active"><span><span>3.完成订单</span></span></span></li>
                  </ul>
              </div>
          </div>
          <!--a-->
            <div id="cart_order">
            
            
            
            
            <div id="cartshow">
                <div class="tips"><img src="/images/ok.gif" align="absmiddle" />　您的订单已经成功提交！</div>
                <form onsubmit="return checkdb(this,'0',<%=orderMoney%>,'<%=rs("orderNum")%>')">
                <table>
                    <tr>
                        <th colspan="2">订单信息</th>
                    </tr>
                    <tr>
                        <td class="info">订单编号：</td>
                        <td><%=rs("orderNum")%>　<a href="orderDetail.asp?act=show&id=<%=rs("orderNum")%>">[查看订单详情]</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="info">订单总金额：</td>
                        <td><span>¥<%=orderMoney%> 元</span></td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <th colspan="2">支付信息</th>
                    </tr>
                    <tr>
                        <td class="info">支付方式：</td>
                        <td>线下汇款　</td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" name="send" value="立即支付" class="bnt" />　<input type="button" value="我的订单" class="bnt" onclick="location.href='orderlist.asp'" /></td>
                    </tr>
                </table>
                </form>
            </div>
            
            </div>
          <!---->
      </div>  
    </div>


<!--#include virtual="/foot.asp"-->