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
	$("#t0_0").click(function(){$(".no").css("display","block");$(".bank").css("display","none");$(".api").css("display","none");})
	$("#t0_1").click(function(){$(".no").css("display","none");$(".bank").css("display","block");$(".api").css("display","none");})
	$("#t0_2").click(function(){$(".no").css("display","none");$(".bank").css("display","none");$(".api").css("display","block");})
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
		case "1":
			if($.trim(the.t5.value)=="")
			{
				$.message({content:"无需发货的原因不能为空"});
				the.t5.focus();
				return false
			}
		break;
		case "2":
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
		break;
		case "3":
			if($.trim(the.t3.value)=="")
			{
				$.message({content:"物品信息不能为空"});
				the.t3.focus();
				return false
			}
		break;
	}
	if(confirm("确认提交发货信息都正确？\n\n不可恢复！"))
	{
		var url,data;
		url="?act=postdb&id="+id;
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
					$.message({type:"error",content:info});
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

  
    <div id="notice"><span>当前位置：</span>订单 > <a href="?act=list">订单管理</a> > <a href="?act=post&id=2&page=1&sta=0&keyword=">为订单发货</a></div>
    <div class="clear_fixed">
    <form onSubmit="return checkdata(this,2,'0','',1)">
      <dl class="addlist">
           
           <dt><em>订单信息：</em>
               <ul class="order_base">
                   <li><span>订单编号：</span>2015123150378881</li>
                   <li><span>订单总金额：</span>¥600.00 元</li>
               </ul>
           </dt>
           <dt><em>收货信息：</em>
               <ul class="order_base">
                   <li><span>收货人：</span>二恶烷</li>
                   <li><span>电话：</span>34432434</li>
                   <li><span>手机：</span></li>
                   <li><span>邮政编码：</span>400084</li>
                   <li><span>收货地址：</span>重庆市</li>
                   <li><span>订单附言：</span></li>
               </ul>
           </dt>
           <dt><em>发货信息：</em>
               <ul class="order_base">
                   <li><span>发货方式：</span>
                   <input type="radio" name="t0" id="t0_0" size="30" value="1" class="b0" checked /><label for="t0_0">无需发货</label>
                   <input type="radio" name="t0" id="t0_1" size="30" value="2" class="b0" /><label for="t0_1">快递公司</label>
                   <input type="radio" name="t0" id="t0_2" size="30" value="3" class="b0" /><label for="t0_2">虚拟物品</label>
                   </li>
                   <li class="no"><span>原因：</span><textarea name="t5" cols="50" rows="3" onKeyUp="strlen_verify(this,'no_len',255)"></textarea>
           还可输入<u id="no_len">255</u> 个字</li>
                   <li class="dis bank"><span>快递公司：</span><input type="text" name="t1" id="t1" size="50" maxlength="50" /> <select onChange="if(this.value!='')$('#t1').val(this.value)"><option value="">请选择</option><option value="EMS快递">EMS快递</option><option value="申通快递">申通快递</option><option value="圆通快递">圆通快递</option><option value="中通快递">中通快递</option><option value="韵达快递">韵达快递</option><option value="顺丰快递">顺丰快递</option><option value="天天快递">天天快递</option><option value="联邦快递">联邦快递</option></select></li>
                   <li class="dis bank"><span>快递单号：</span><input type="text" name="t2" size="50" maxlength="50" /></li>
                   <li class="dis api"><span>物品信息：</span><textarea name="t3" cols="50" rows="5"></textarea></li>
                   <li><span>发货备注：</span><textarea name="t4" cols="50" rows="3" onKeyUp="strlen_verify(this,'description_len',255)"></textarea>
           还可输入<u id="description_len">255</u> 个字符</li>
               </ul>
           </dt>
           
           <dd><input type="submit" name="send" value="保存" /><input type="button" value="返回" onClick="location.href='javascript:history.go(-1)'" /></dd>
           
       </dl>
   </form>
</div>




<!-- #include file="../Inc/Foot.asp" -->