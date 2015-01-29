<!--#include virtual="/fiveinc/conn.asp"-->

<%
response.Cookies("userid")=20
response.cookies("username")="user01"
if request.Cookies("userid")="" or request.Cookies("username")="" then

	Easp.str.JsAlertUrl "订购产品请先登陆！","/user_login.asp"	  
else
	userid = clng(request.Cookies("userid"))
	username=request.Cookies("username")
end if
Easp.var("userid")=userid

  

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/css/base.css" rel="stylesheet" type="text/css">
<link href="/css/cart.css" rel="stylesheet" type="text/css">
<script src="/js/jquery.min.js" type="text/javascript"></script>
<script src="/js/base.js" type="text/javascript"></script>
<script src="/js/cart.js" type="text/javascript"></script>
<title>完成订单</title>
</head>
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
<body>


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
                <form onsubmit="return checkdb(this,'-2',800,7)">
                <table>
                    <tr>
                        <th colspan="2">订单信息</th>
                    </tr>
                    <tr>
                        <td class="info">订单编号：</td>
                        <td>20151291749482201　<a href="user/order.asp?act=show&id=7">[查看订单详情]</a>
                        </td>
                    </tr>
                    <tr>
                        <td class="info">订单总金额：</td>
                        <td><span>¥800.00 元</span></td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <th colspan="2">支付信息</th>
                    </tr>
                    <tr>
                        <td class="info">支付方式：</td>
                        <td>线下汇款　<a href="javascript:;" class="chanagepay" payway="-2">[更换支付方式]</a></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" name="send" value="立即支付" class="bnt" />　<input type="button" value="我的订单" class="bnt" onclick="location.href='user/order.asp'" /></td>
                    </tr>
                </table>
                </form>
            </div>
            
            </div>
          <!---->
      </div>  
    </div>


</body>
</html>
