<!--#include virtual="/fiveinc/conn.asp"-->
<!--#include virtual="/User_Config.asp"-->
<%
curpageTitle = "我的收货地址"
 if Easp.var("act") ="del" then
 
 result =Easp.Db.Del("user_address","id={id}")
 if result>0 then
 response.write "1删除成功！"
 else
 response.write "0删除失败！"
 
 end if
 


 response.end()
 end if
 
 
 
  if Easp.var("act") ="adddb" and Easp.var("id")="0" then  '增加新地址
  
  if Easp.var("t5")=1 then '如果添加为默认 则需取消其他的默认
  
  
	  Easp.Db.Begin '开始事务
	 
	 result = Easp.Db.Upd("user_address","isdefault=0","")
	 result =Easp.Db.Ins("user_address","userid:{userid},username:{t0},tel:{t1},zipcode:{t3},address:{t4},isdefault:{t5}")
	 
	 Easp.Db.Commit '提交事务	  
	 if result>0 then
	 response.write "1添加成功！"
	 else
	 response.write "0添加失败！"
	 
	 end if
	 
else

	result =Easp.Db.Ins("user_address","userid:{userid},username:{t0},tel:{t1},zipcode:{t3},address:{t4},isdefault:{t5}")
	 
	  if result>0 then
	 response.write "1添加成功！"
	 else
	 response.write "0添加失败！"
	 
	 end if
 end if


 response.end()
 end if
 
 
 
 
 if Easp.var("act") ="adddb" and Easp.var("id")<>"0" then  '修改地址
  
  if Easp.var("t5")=1 then '如果为默认 则需取消其他的默认
  
  
	  Easp.Db.Begin '开始事务
	 
	 result = Easp.Db.Upd("user_address","isdefault=0","id<>{id}")
	 'result = Easp.Db.Upd("user_address","isdefault=0","id<>{id}")
	 result =Easp.Db.Upd("user_address","userid={userid},username={t0},tel={t1},zipcode={t3},address={t4},isdefault={t5},lastupdate='"&now()&"'","id={id}")
	 
	 Easp.Db.Commit '提交事务	  
	 if result>0 then
	 response.write "1修改成功！"
	 else
	 response.write "0修改失败！"
	 
	 end if
	 
else

	result =Easp.Db.Upd("user_address","userid={userid},username={t0},tel={t1},zipcode={t3},address={t4},isdefault={t5},lastupdate='"&now()&"'","id={id}")
	 
	  if result>0 then
	 response.write "1修改成功！"
	 else
	 response.write "0修改失败！"
	 
	 end if
 end if


 response.end()
 end if
%>

<!--#include virtual="/top.asp"-->
<script>
$(function(){
	$(".ico03").addClass("hover ico03_");
	$(".user_title_more li").eq(<%=clng(request("v"))%>).addClass("hover");
})
</script>
<script>
$(function(){
	$(".delete").click(function(){
		var id;
		id=this.getAttribute('rel');
			$.dialog({
				icon:'question',
				content:'\u786e\u5b9a\u8981\u5220\u9664\uff1f\u0028\u4e0d\u53ef\u6062\u590d\uff01\u0029',
				lock:true,
				opacity:'0.5',
				ok:function(){
					var url,data;
					url='?act=del&id='+id;
					$.ajax({
					type:"get",
					cache:false,
					url:url,
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
								$.message({type:"ok",content:info,time:5000});
								$("#address_"+id).fadeOut('slow');
								break;
							default:
								alert(_);
								break;
						}
					}
					});
									
					},
				cancelVal:'\u53d6\u6d88',
				cancel:true 
			})
		
		});
})


function checkdb(the)
{
	the.bnt.disabled=true;
	if(strlen(the.t0.value)==0)
	{
		$.message({content:"\u6536\u8d27\u4eba\u59d3\u540d\u4e0d\u80fd\u4e3a\u7a7a"});
		the.t0.focus();
		the.bnt.disabled=false;
		return false
	}
	
	if(!valid_tel(the.t1.value)){
			the.bnt.disabled=false;
			$.message({content:"电话格式不对，请输入座机或手机号码！"});
			the.t1.focus();
			return false
		}
	if(strlen(the.t3.value)==0)
	{
		$.message({content:"\u90ae\u653f\u7f16\u7801\u4e0d\u80fd\u4e3a\u7a7a"});
		the.t3.focus();
		the.bnt.disabled=false;
		return false
	}
	if(strlen(the.t4.value)==0)
	{
		$.message({content:"\u6536\u8d27\u5730\u5740\u4e0d\u80fd\u4e3a\u7a7a"});
		the.t4.focus();
		the.bnt.disabled=false;
		return false
	}
	var t5=0;
	if(the.t5.checked){t5=1;}
	var url,data;
	url="?act=adddb&id=<%=clng(request("id"))%>";
	data="t0="+encodeURIComponent($.trim(the.t0.value));
	data+="&t1="+encodeURIComponent($.trim(the.t1.value));
	//data+="&t2="+encodeURIComponent($.trim(the.t2.value));
	data+="&t3="+encodeURIComponent($.trim(the.t3.value));
	data+="&t4="+encodeURIComponent($.trim(the.t4.value));
	data+="&t5="+encodeURIComponent(t5);
	$.ajax({
	type:"post",
	cache:false,
	url:url,
	data:data,
	error:function(){alert("\u670d\u52a1\u5668\u9519\u8bef\uff0c\u64cd\u4f5c\u5931\u8d25");},
	success:function(_)
	{
		var act=_.substring(0,1);
		var info=_.substring(1);
		switch(act)
		{
			case "0":
				$.message({content:info});
				the.bnt.disabled=false;
				break;
			case "1":
				$.message({type:"ok",content:info,time:1000});
				setTimeout(function(){location.href="?"},1500);
				break;
			default:
				alert(_)
				break;
		}
	}});
	return false
}


</script>







<div class="width">
        <div class="user_bg">
            <div id="uleft">
<!--#include virtual="/uleft.asp"-->
</div>
          
          
          
          
           

         
             <!--左侧结束-->
            <div id="uright">
                 <div class="user_title_more">
                    <ul>
                        <li><a href="?">收货地址</a></li>
                        <li><a href="?act=add&V=1">新增地址</a></li>
                    </ul>
                </div>
                
                <%if Easp.var("act")="add" then%>
                
                <div class="page_content">
                <form onSubmit="return checkdb(this)">
                <ul id="reg">
                    <li><span>收货人姓名：</span><input type="text" name="t0" class="ip w01" maxlength="10" value="" /></li>
                    <li><span>联系电话：</span><input type="text" name="t1" class="ip w01" maxlength="20" value="" /></li>
                    
                    <li><span>邮政编码：</span><input type="text" name="t3" class="ip w01" maxlength="6" value="" /></li>
                    <li><span style="font-size:12px;">汽车货运到站地址：</span><input type="text" name="t4" class="ip w05" maxlength="255" value="" /></li>
                    <li><span>设为默认：</span><input type="checkbox" name="t5" id="t5"  checked="checked" /><label for="t5">是</label></li>
                    <dd><input type="submit" value="保存" class="bnt" name="bnt" /> <input type="button" value="取消" onClick="location.href='javascript:history.go(-1)'" class="bnt" /></dd>
                </ul>
                </form>
                </div>
                
                <%elseif Easp.var("act")="edit" and Easp.var("id")<>"" then
				
				set rs=Easp.Db.Sel("select * from user_address where id={id} and userid={userid}")
				if rs.eof then response.write "编辑地址出错":response.End()
				
				
				%>
                
                  <div class="page_content">
                <form onSubmit="return checkdb(this)">
                <ul id="reg">
                    <li><span>收货人姓名：</span><input type="text" name="t0" class="ip w01" maxlength="10" value="<%=rs("username")%>" /></li>
                    <li><span>联系电话：</span><input type="text" name="t1" class="ip w01" maxlength="20" value="<%=rs("tel")%>" /></li>
                   
                    <li><span>邮政编码：</span><input type="text" name="t3" class="ip w01" maxlength="6" value="<%=rs("zipcode")%>" /></li>
                    <li><span style="font-size:12px;">汽车货运到站地址：</span><input type="text" name="t4" class="ip w05" maxlength="255" value="<%=rs("address")%>" /></li>
                    <li><span>设为默认：</span><input type="checkbox" name="t5" id="t5"  <%if rs("isdefault")=1 then %>checked="checked" <%end if%> /><label for="t5">是</label></li>
                    <dd><input type="submit" value="保存" class="bnt" name="bnt" /> <input type="button" value="取消" onClick="location.href='javascript:history.go(-1)'" class="bnt" /></dd>
                </ul>
                </form>
                </div>

                 <%else%>
                
                <div class="page_content">
                
                <div class="mt10"></div>
                
                <table id="tablelist">
                    <tr>
                        <th width="80">收货人姓名</th>
                        <th width="120">联系电话</th>
                        <th width="80">邮政编码</th>
                        <th>汽车货运到站地址</th>
                        <th width="60">是否默认</th>
                        <th width="100">管理</th>
                    </tr>
    <%
	
	Easp.Db.PageSize = 10
	set rs=Easp.Db.getrs("select * from user_address where userid={userid} order by id desc")
	while not rs.eof 
	%>                
                    
                    <tr id="address_<%=rs("id")%>">
                        <td class="item"><%=rs("username")%></td>
                        <td align="center"><%=rs("tel")%></td>
                      
                        <td align="center"><%=rs("zipcode")%></td>
                        <td class="item"><%=rs("address")%></td>
                        <td align="center"><%if rs("isdefault")=1 then response.write "是" else response.write "否" end if	%></td>
                        <td align="center"><a href="?act=edit&id=<%=rs("id")%>">编辑</a>　<a href="javascript:;" class="delete" rel="<%=rs("id")%>">删除</a></td>
                    </tr>
        <%
		rs.movenext
		wend
		rs.close
		
		Easp.Db.SetPager "default2", "{first}{prev}{liststart}{list}{listend}{next}{last} ", Array()


		%>            
                    
                   
                    
                </table>
               <div class="list_page"><%
					  if Easp.Db.PageRecordCount>0 then
					  Easp.Print Easp.Db.GetPager("default2")
					  end if
					  
					  %></div>
                </div>
                  <%end if%>
            </div>
            <!--右侧结束-->
            
          

            <div class="clear"></div>
        </div>
    </div>
<!--#include virtual="/foot.asp"-->