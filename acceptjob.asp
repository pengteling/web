<!--#include file="fiveinc/inc.asp"-->
<!--#include file="FiveInc/Check_Sql.asp"-->
<!--#include file="FiveInc/page.asp"-->




<%



if request.Form("field1")<>"" then
'response.write "werwer"
rs.open "select * from zp where 1=2",conn,1,3
rs.addnew
for each key in request.Form()
	'response.Write key &"--" & request.Form(key) &"<Br>"
	
	
	rs(key)=ChkFormStr(request.Form(key))
	
	
	
next
rs.update
rs.close

response.write "<script>alert('你的信息已经成功提交，待有合适您的职位时，我们将在第一时间与您取得联系，期待您的加入');window.location.href='applyjob.asp'</script>"
response.end()
end if


nid=strToNum(Request.QueryString("id"))
nid=32
rs.open "select * from category where cateid="&nid,conn,1,1
if not rs.eof then
	parentid=rs("parentid")
	sonid_news2=rs("sonid")
	followid=rs("followid")	
	catetype=rs("catetype")
	modeltype=rs("modeltype")
	catename= rs("catename")		
	title=rs("title")
	Com_Content=rs("content")	

else
	response.write "网址传递参数有误"
	response.End()

end if
rs.close



%>

<!--#include file="lmenu.asp"-->
<!--#include file="top.asp"-->


<!--首页中部 -->
<div class="greybg">
<div class="main">
  <div class="cleft fl"> 
    <!--#include virtual="/cleft.asp"--> 
  </div>
  <div class="cright fr">
  
    <div class="curlocation">
      <div class="fr"><%=menustr%></div>
      <div class="fl"><%=catename%></div>
    </div>
      <div class="maincontent" id="maincontent">
        <div class="mcontent" >

   <style>
/*==========以下部分是Validform必须的===========*/
.Validform_checktip{
	margin-left:8px;
	line-height:20px;
	height:20px;
	overflow:hidden;
	color:#999;
	font-size:12px;
}
.Validform_right{
	color:#71b83d;
	padding-left:20px;
	background:url(images/right.png) no-repeat left center;
}
.Validform_wrong{
	color:red;
	padding-left:20px;
	white-space:nowrap;
	background:url(images/error.png) no-repeat left center;
}
.Validform_loading{
	padding-left:20px;
	background:url(images/onLoad.gif) no-repeat left center;
}
.Validform_error{
	background-color:#ffe7e7;
}
#Validform_msg{color:#7d8289; font: 12px/1.5 tahoma, arial, \5b8b\4f53, sans-serif; width:280px; -webkit-box-shadow:2px 2px 3px #aaa; -moz-box-shadow:2px 2px 3px #aaa; background:#fff; position:absolute; top:0px; right:50px; z-index:99999; display:none;filter: progid:DXImageTransform.Microsoft.Shadow(Strength=3, Direction=135, Color='#999999'); box-shadow: 2px 2px 0 rgba(0, 0, 0, 0.1);}
#Validform_msg .iframe{position:absolute; left:0px; top:-1px; z-index:-1;}
#Validform_msg .Validform_title{line-height:25px; height:25px; text-align:left; font-weight:bold; padding:0 8px; color:#fff; position:relative; background-color:#999;
background: -moz-linear-gradient(top, #999, #666 100%); background: -webkit-gradient(linear, 0 0, 0 100%, from(#999), to(#666)); filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#999999', endColorstr='#666666');}
#Validform_msg a.Validform_close:link,#Validform_msg a.Validform_close:visited{line-height:22px; position:absolute; right:8px; top:0px; color:#fff; text-decoration:none;}
#Validform_msg a.Validform_close:hover{color:#ccc;}
#Validform_msg .Validform_info{padding:8px;border:1px solid #bbb; border-top:none; text-align:left;}

table,td{border:0;}

</style>

<script src="js/Validform_v5.3.2_min.js"></script>
<script src="js/Validform_Datatype.js"></script>

  	  <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="20"></td>
                </tr>
              </table>
      
       <link rel="stylesheet" href="/kindeditor/themes/default/default.css" />
	 <link rel="stylesheet" href="/kindeditor/plugins/code/prettify.css" />
	<script charset="utf-8" src="/kindeditor/kindeditor.js"></script>
	<script charset="utf-8" src="/kindeditor/lang/zh_CN.js"></script>
	<script charset="utf-8" src="/kindeditor/plugins/code/prettify.js"></script>
     <script>
    KindEditor.ready(function(K) {
				var editor = K.editor({
					allowFileManager : true,	
					cssPath : '/kindeditor/plugins/code/prettify.css',
					uploadJson : '/kindeditor/asp/upload_json.asp',
					fileManagerJson : '/kindeditor/asp/file_manager_json.asp'
				});
				

			
				K('#upbtn').click(function() {
					editor.loadPlugin('insertfileuser', function() {
						editor.plugin.fileDialog({
							fileUrl : K('#upfilepath').val(),
							clickFn : function(url, title) {
								K('#upfilepath').val(url);
								editor.hideDialog();
							}
						});
					});
				});
			
			});
           </script>
	<!--====  招聘栏目开始  ====-->
    <span style="color:#f00; font-size:14px; padding-left:100px;"><a href="job.docx" target="_blank" style="color:#f00; font-size:14px;">点击下载简历模板</a>，完整填写后上传或者发到邮箱<a href="mailto:<%=companyEmail%>" target="_blank" style="color:#f00; font-size:14px;"><%=companyEmail%></a></span><Br />
	<form method="post" action="SaveAcceptJob.asp" id="form1">
	  <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
                                      <tr>
                                        <td width="100%">
										
                                            <table width="100%" height="479"
border="0" align="center" cellpadding="0" cellspacing="1">

<tr class="top_m_txt01">
                                                <td width="23%" height="22" align="right">上传简历：</td>
                                                <td width="77%" height="22">
                                                  <input name="upfilepath" id="upfilepath" type="text" class="ny-gfyx-bt-text require" id="mane" readonly><span class="red">*</span><input type="button" value="点击上传" id="upbtn"/>支持word、excel、pdf文件格式
                                                </td>
                                              </tr>
                                              
                                              <tr class="top_m_txt01">
                                                
                                                <td width="23%" height="22" align="right">应聘岗位： </td>
                                                <td width="77%" height="22">
                                                <input name="jobname" type="text" value="<%=request("job")%>" class="ny-gfyx-bt-text require"><span class="red">*</span></td>
                                              </tr>
                                              <tr class="top_m_txt01">
                                                <td width="23%" height="22" align="right">姓 名：</td>
                                                <td width="77%" height="22">
                                                  <input name="mane" type="text" class="ny-gfyx-bt-text require" id="mane" style="font-size: 14px" size="16" maxlength="16"><span class="red">*</span>
                                                </td>
                                              </tr>
                                              <tr class="top_m_txt01">
                                                <td height="22" align="right">性 别：</td>
                                                <td width="77%" height="22"><label>
                                                  <input name="sex" type="radio" value="男" checked="checked" />
                                                男&nbsp;
                                                <input type="radio" name="sex" value="女" />
                                                女</label></td>
                                              </tr>
                                               <tr class="top_m_txt01">
                                                <td height="22" align="right">手 机：</td>
                                                <td width="77%" height="22">
                                                  <input name="telephone" type="text" class="ny-gfyx-bt-text require" id="telephone" style="font-size: 14px" size="20" maxlength="30"><span class="red">*</span>
                                                </td>
                                              </tr>
                                              <tr class="top_m_txt01">
                                                <td height="22" align="right">E-mail：</td>
                                                <td width="77%" height="22">
                                                  <input name="email" type="text" class="ny-gfyx-bt-text require" id="email" style="font-size: 14px" size="20" maxlength="30"><span class="red">*</span>
                                                </td>
                                              </tr>
                                              <tr class="top_m_txt01">
                                                <td height="22" align="right">出生日期：</td>
                                                <td width="77%" height="22"><input name="birthday" id="birthday" type="text" class="ny-gfyx-bt-text" id="birthday" style="font-size: 14px" size="16" maxlength="30"><span class="red">*</span>
                      格式：1976-02-02 </td>
                                              </tr>
                                              <tr class="top_m_txt01">
                                                <td height="22" align="right">婚姻状况：</td>
                                                <td width="77%" height="22"><label>
                                                  <input name="marry" type="radio" value="未婚" checked="checked" />
                                                未婚&nbsp;
                                                <input type="radio" name="marry" value="已婚" />
                                                已婚</label></td>
                                              </tr>
                                              <tr class="top_m_txt01">
                                                <td height="22" align="right">毕业院校：</td>
                                                <td width="77%" height="22">
                                                  <input name="school" type="text" class="ny-gfyx-bt-text" id="school" style="font-size: 14px" size="30" maxlength="50">
                                                </td>
                                              </tr>
                                              <tr class="top_m_txt01">
                                                <td width="23%" height="22" align="right">学 历： </td>
                                                <td width="77%" height="22"><input name="studydegree" type="text" class="ny-gfyx-bt-text" id="studydegree" style="font-size: 14px" size="20" maxlength="16"></td>
                                              </tr>
                                              <tr class="top_m_txt01">
                                                <td height="22" align="right">专 业：</td>
                                                <td width="77%" height="22">
                                                  <input name="specialty" type="text" class="ny-gfyx-bt-text" id="specialty" style="font-size: 14px" size="20" maxlength="30">
                                                </td>
                                              </tr>
                                              <tr class="top_m_txt01">
                                                <td height="22" align="right">毕业时间：</td>
                                                <td width="77%" height="22"><input name="gradyear" type="text" class="ny-gfyx-bt-text" id="gradyear" style="font-size: 14px" size="20" maxlength="30">                      
                                                格式：1998-7月</td>
                                              </tr>
                                             
                                              <tr class="top_m_txt01">
                                                <td height="22" align="right">联系地址：</td>
                                                <td width="77%" height="22">
                                                  <input name="address" type="text" class="ny-gfyx-bt-text" id="address" style="font-size: 14px" size="30" maxlength="50">
                                                </td>
                                              </tr>
                                              <!--<tr class="top_m_txt01">
                                                <td height="22" align="right">水平与能力：</td>
                                                <td width="77%" height="22">
                                                  <textarea name="ability" cols="35" rows="3" class="ny-gfyx-bt-text" id="ability" style="font-size: 14px"></textarea>
                                                </td>
                                              </tr>
                                              <tr class="top_m_txt01">
                                                <td height="22" align="right">个人简历：</td>
                                                <td width="77%" height="22">
                                                  <textarea name="resumes" cols="35" rows="3" class="ny-gfyx-bt-text" id="resumes" style="font-size: 14px"></textarea>
                                                </td>
                                              </tr>-->
                                              <tr class="top_m_txt01">
                                                <td width="23%" height="22" valign="top"></td>
                                                <td width="77%" height="22"><input type="submit" value="提交应聘"
name="cmdOk" class="ny-gfyx-bt-sub">
                                                <input type="reset" value="重新填写" name="cmdReset" class="ny-gfyx-bt-sub">
                                                </td>
                                              </tr>
                                          </table>
                                        </td>
                                      </tr>
                    </table>
                                    
	</form>
	<!--====  招聘栏目结束  ====-->
     
   

<script>
$(function(){
		   
		 
var fv=$("#form1").Validform({
	showAllError:true,


							 tiptype:3
							 
							 });
fv.tipmsg.r="正确！";
fv.addRule([
	
	
	{
        ele:"#upfilepath",
        datatype:"*",
		nullmsg:"请点击上传按钮上传简历！",
        errormsg:"请上传简历！"     
       
    },
		{
        ele:"#birthday",
        datatype:"date",
		nullmsg:"请填写生日！",
        errormsg:"日期格式不对哦！"     
       
    },
	{
        ele:".require",
        datatype:"*"     
       
    }
	
	
	]);

  });

</script>
</div>
      </div>
    </div>
  <div class="clear"></div>
</div>
</div>
      
 
  <!--<div class="maincontent">
    
    </div>--> 
</div>
<!--首页中部end --> 

<!--#include file="foot.asp"-->
