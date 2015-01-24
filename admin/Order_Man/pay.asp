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
$(function(){
	$("#t0_0").click(function(){$(".bank").css("display","none");$(".api").css("display","none");})
	$("#t0_1").click(function(){$(".bank").css("display","block");$(".api").css("display","none");})
	$("#t0_2").click(function(){$(".bank").css("display","none");$(".api").css("display","block");})
})
function checkdata(the,id,sta,keyword,page)
{
	var t0="0";
	for(i=0;i<the.t0.length;i++)
	{
		if(the.t0[i].checked)
		{
			t0=the.t0[i].value;
		}
	}
	switch (t0)
	{
		case "-1":
		break;
		case "-2":
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
		break;
		case "-3":
			if($.trim(the.t3.value)=="")
			{
				$.message({content:"服务商不能为空"});
				the.t3.focus();
				return false
			}
			if($.trim(the.t4.value)=="")
			{
				$.message({content:"收款账户不能为空"});
				the.t4.focus();
				return false
			}
		break;
	}
	if(confirm("确认提交付款信息都正确？\n\n不可恢复！"))
	{
		var url,data;
		url="?act=paydb&id="+id;
		data="t0="+encodeURIComponent(t0);
		data+="&t1="+encodeURIComponent($.trim(the.t1.value));
		data+="&t2="+encodeURIComponent($.trim(the.t2.value));
		data+="&t3="+encodeURIComponent($.trim(the.t3.value));
		data+="&t4="+encodeURIComponent($.trim(the.t4.value));
		data+="&t5="+encodeURIComponent($.trim(the.t5.value));
		$.ajax({
		type:"post",
		cache:false,
		url:url,
		data:data,
		error:function(){$.message({type:"error",content:"\u670d\u52a1\u5668\u9519\u8bef\uff0c\u64cd\u4f5c\u5931\u8d25\uff01"});},
		success:function(_)
		{
			var act=_.substring(0,1);
			var info=_.substring(1);
			switch(act)
			{
				case "0":
					$.message({type:"error",content:info,time:5000});
					break;
				case "1":
					the.send.disabled=true;
					$.message({type:"ok",content:info});
					setTimeout('location.href="?act=list&sta='+sta+'&keyword='+keyword+'&page='+page+'"',1000);
					break;
				default:
					alert(_);
					break;
			}
		}
		});
	}
	return false
}
</script>

    <div id="notice"><span>当前位置：</span>订单 > <a href="?act=list">订单管理</a> > <a href="?act=pay&id=3&page=1&sta=0&keyword=">为订单付款</a></div>
    <div class="clear_fixed">
    <form onSubmit="return checkdata(this,3,'0','',1)">
      <dl class="addlist">
           
           <dt><em>订单信息：</em>
               <ul class="order_base">
                   <li><span>订单编号：</span>2015124123194691</li>
                   <li><span>订单总金额：</span>¥200.00 元</li>
                   <li><span>订单状态：</span>未付款</li>
               </ul>
           </dt>

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
           
       </dl>
   </form>
</div>



<!-- #include file="../Inc/Foot.asp" -->