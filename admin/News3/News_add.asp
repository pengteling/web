<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<!-- #include file="news_config.asp" -->
<%
dim rs
dim sql
dim count
followid=strToNum(request("cateid"))

Call p_cate(followid,2)
%>
<script language = "JavaScript">

function CheckForm()
{

	if (document.myform.title.value.length == 0) {
		alert("产品标题没有填写.");
		document.myform.title.focus();
		return false;
	}
	
	editor1.sync();
	//editor2.sync();
	if (document.myform.content.value.length == 0){
		alert("产品内容不能为空！");
		
		return false;
	}
    
 return true; 
	
}

function SetDropDownPic(url){
	document.myform.UploadFiles.value=document.myform.UploadFiles.value + url +"|";
	document.myform.IncludePic.value="1";
	document.getElementById("productimages").innerHTML+="<li><img src='" + url + "' width='120' height='120' alt='单击选择图片' style='cursor:hand;' onclick=\"myform.DefaultPicUrl.value='" + url + "';\"/><a href='javascript:DelArray("+(myform.UploadFiles.value.split("|").length -2).toString()+")'>删除</a></li>"
}
</script>
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
  <form name="myform" method="post" action="News_save.asp" onSubmit="return CheckForm();">
    <tr>
      <td height="30" colspan="3" align="center" class="blod">增加产品</td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="22" align="center" class="tr_southidc">产品标题：</td>
      <td colspan="2" width="80%"><input name="title" type="text" class="input" size="30">
        
       
        
      
            </td>
    </tr>
    <tr>
            <td height="22" align="center" class="tr_southidc">所属类别：</td>
            <td colspan="2" class="tr_southidc"><div align="left">
            
            	<select name="cateid">
          
          <%

set rs=server.CreateObject("adodb.recordset")
			rs.open "select cateid,catename,followid,depth,sonid,parentid,orderID from category where catetype<=3 "&sql_sonid&" order by depth,orderID",conn,1,1
			if not rs.eof then
				data= rs.getRows()
			end if
			rs.close
			
	class_list=""
	
	
sub classlist(byval t0)
		dim i
		for i=0 to ubound(data,2)
			if t0=data(2,i) then
				if followid = data(0,i) then
					isslected="selected"
				else
					isslected=""
				end if
				class_list=class_list&"<option value="""&data(0,i)&""" "&isslected&">"

For k=2 To data(3,i)
class_list=class_list&"&nbsp;&nbsp;&nbsp;&nbsp;"
next

If data(3,i)>1 then class_list=class_list& "├"
				class_list=class_list& data(1,i)&"</option>"
				
				classlist(data(0,i))
			end if
		next
	end sub
	if isarray(data) then	
		call classlist(cateid_parent_m )	
	end if	
		response.write class_list
		  %>
        </select>
            	</div></td>
          </tr>
   <input name="Author" type="hidden" id="auther" value="<%=session("AdminName")%>" >       
<!-- 
    <tr bgcolor="#ECF5FF">
      <td height="25" align="center">发 布 人：</td>
      <td colspan="2"><input name="Author" type="text" id="auther" value="<%=session("AdminName")%>" disabled="disabled">
       <span class="TableRow1">
        <select name=font2 onChange="Author.value=this.value;">
          <option selected value="">选择作者</option>
          <option value='佚名'>佚名</option>
          <option value='本站'>本站</option>
          <option value='不详'>不详</option>
          <option value='未知'>未知</option>
          <option value='admin'>admin</option>
        </select>
      </span></td>
    </tr>-->
   <!-- <tr bgcolor="#ECF5FF">
      <td height="25" align="center">产品类型：</td>
      <td colspan="2"><input name="hx_type" type="text" id="hx_type" value="">
        <span class="TableRow1">
        <select name=font1 onChange="hx_type.value=this.value;">
          <option selected value="">选择输入</option>
          <option value='一室一厅一卫'>一室一厅一卫</option>
          <option value='一室两厅一卫'>一室两厅一卫</option>
          <option value='两室两厅一卫'>两室两厅一卫</option>
          <option value='三室两厅两卫'>三室两厅两卫</option>
          <option value='四室两厅两卫'>四室两厅两卫</option>
        </select>
      </span></td>
    </tr>-->
<!--   <tr bgcolor="#ECF5FF">
      <td align="center" height="25" class="tr_southidc">产品价格：</td>
      <td colspan="2"><input name="price" type="text" class="input" value="" size="30">元 RMB
		  </td>
    </tr>-->  
    <tr bgcolor="#ECF5FF">
      <td height="25" align="center" valign="top">规格型号：</td>
      <td colspan="2" valign="top"><input id="ggxh" name="ggxh" size="50">限255字</td>
    </tr>
    
     <tr bgcolor="#ECF5FF">
      <td height="25" align="center" valign="top">适用范围：</td>
      <td colspan="2" valign="top"><textarea id="syfw" name="syfw" style="width:700px;height:60px;visibility:;"></textarea>限255字</td>
    </tr>
    
     <tr bgcolor="#ECF5FF">
      <td height="25" align="center" valign="top">产品特点：</td>
      <td colspan="2" valign="top"><textarea id="cptd" name="cptd" style="width:700px;height:60px;visibility:;"></textarea>限255字</td>
    </tr>
    
     <tr bgcolor="#ECF5FF">
      <td height="25" align="center" valign="top">适用机型：</td>
      <td colspan="2" valign="top"><textarea id="syjx" name="syjx" style="width:700px;height:60px;visibility:;"></textarea>限255字</td>
    </tr>
    
    <tr bgcolor="#ECF5FF">
      <td height="25" align="center" valign="top">关联产品：</td>
      <td colspan="2" valign="top"><input id="relgoods" name="relgoods" size="60">格式： 32六方未装配|89,23六方未装配|90,23六方已装配|99</td>
    </tr>
    
    <tr bgcolor="#ECF5FF">
      <td height="25" align="center" valign="top">产品介绍：</td>
      <td colspan="2" valign="top"> 
            <link rel="stylesheet" href="/kindeditor/themes/default/default.css" />
	 <link rel="stylesheet" href="/kindeditor/plugins/code/prettify.css" />
	<script charset="utf-8" src="/kindeditor/kindeditor.js"></script>
	<script charset="utf-8" src="/kindeditor/lang/zh_CN.js"></script>
	<script charset="utf-8" src="/kindeditor/plugins/code/prettify.js"></script>
	<script>
		var editor1;
		KindEditor.ready(function(K) {
			editor1 = K.create('#contentid', {
				cssPath : '/kindeditor/plugins/code/prettify.css',
				uploadJson : '/kindeditor/asp/upload_json.asp',
				fileManagerJson : '/kindeditor/asp/file_manager_json.asp',
				allowFileManager : true,
				filterMode : false, // true:开启过滤模式, false:关闭过滤模式
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						K('form[name=example]')[0].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						K('form[name=example]')[0].submit();
					});
				}
				
			});
			
			prettyPrint();
			
			
		});
		
		KindEditor.ready(function(K) {
				var editor = K.editor({
					allowFileManager : true,	
					cssPath : '/kindeditor/plugins/code/prettify.css',
					uploadJson : '/kindeditor/asp/upload_json.asp',
					fileManagerJson : '/kindeditor/asp/file_manager_json.asp'
				});
			
				K('#image3').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							showRemote : true,
							imageUrl : K('#DefaultPicUrl').val(),
							clickFn : function(url, title, width, height, border, align) {
								K('#DefaultPicUrl').val(url);
								editor.hideDialog();
							}
						});
					});
				});
				K('#J_selectImage').click(function() {
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							clickFn : function(urlList) {
								//var div = K('#productimages');
								//div.html('');								
								K.each(urlList, function(i, url) {
									//div.append('<li><img src="' + url.url + '"></li>');
									SetDropDownPic(url.url);
								});
								editor.hideDialog();
							}
						});
					});
				});
			});


			</script>
<textarea id="contentid" name="content"  style="width:700px;height:500px;visibility:hidden;"></textarea>
 <div>
       <input name="saveimg" type="checkbox" value="1">保存远程图片</div>
         </td>
    </tr>
     
    <tr>
      <td height="30" align="center" bgcolor="#ECF5FF"><span class="tr_southidc">产品小图：</span></td>
      <td width="301" height="30" bgcolor="#ECF5FF"><span class="tr_southidc">
        <input name="DefaultPicUrl" type="text" id="DefaultPicUrl" value="" size="30" maxlength="120" />
      </span></td>
      <td width="495" bgcolor="#ECF5FF"><span class="tr_southidc">
       
        <input name="UploadFiles" type="hidden" id="UploadFiles" value="" />
        <input name="Submit222" type="button" value="上传图片"   id="image3"><input type="button" id="J_selectImage" value="上传产品大图" />
      </span></td>
    </tr>
    
    <tr>
      <td height="22" align="center" bgcolor="#C0C0C0" class="tr_southidc">产品大图：</td>
	  <td colspan="2" bgcolor="#E3E3E3" class="tr_southidc"><ul id="productimages">
<script language="javascript">
var ImgUrl,ImgList;
ImgList="";
ImgUrl=myform.UploadFiles.value;
ImgUrlArray=ImgUrl.split("|");

if(ImgUrlArray.length<=1){
//document.write('您没有上传图片');

}
for(i=0;i<ImgUrlArray.length-1;i++){
ImgList=ImgList+"<li><img src='" + ImgUrlArray[i] + "' width='120' height='120' alt='单击选择图片' style='cursor:hand;' onclick=\"myform.DefaultPicUrl.value='" + ImgUrlArray[i] + "';\"/><a href='javascript:DelArray("+i+")'>删除</a></li>"
}
document.write(ImgList);

function DelArray(n)
{
	
	if(confirm("确定要删除该图片？删除后点击下面【确认修改】才会生效！")){
	ImgList="";
	var arraylist="";
	ImgUrl=myform.UploadFiles.value;
	ImgUrlArray=ImgUrl.split("|");
	for(i=0;i<ImgUrlArray.length-1;i++){
		if (i!=n){
ImgList=ImgList+"<li><img src='" + ImgUrlArray[i] + "' width='120' height='120' alt='单击选择图片' style='cursor:hand;' onclick=\"myform.DefaultPicUrl.value='" + ImgUrlArray[i] + "';\"/><a href='javascript:DelArray("+(i>n?i-1:i)+")'>删除</a></li>";
arraylist=arraylist+ImgUrlArray[i]+"|";
		}
}
myform.UploadFiles.value=arraylist;
document.getElementById("productimages").innerHTML=ImgList;
	}
	}
</script></ul>	
	</td>
    </tr>
    
    <tr>
      <td height="30" align="center" bgcolor="#ECF5FF"><span class="tr_southidc">是否推荐：</span></td>
      <td height="30" colspan="2" align="left" bgcolor="#ECF5FF"><input name="Elite" type="checkbox" id="Elite" value="yes">是<font color="#0000FF">（如果选中的话将在首页做为图片产品显示）</font></td>
    </tr>
	<tr>
      <td height="30" align="center" bgcolor="#ECF5FF">排序：</td>
      <td height="30" colspan="2" align="left" bgcolor="#ECF5FF"><span class="tr_southidc">
        <input name="px" type="text" id="px" value="0" size="10" maxlength="5" />
        数字越大越靠前
      </span></td>
    </tr>
    <tr>
      <td height="30" align="center" bgcolor="#ECF5FF">通过审核：</td>
      <td height="30" colspan="2" align="left" bgcolor="#ECF5FF"><span class="tr_southidc">
        
        <input name="Passed" type="checkbox" id="Passed" value="yes" checked>是<font color="#0000FF">（如果选中的话将直接发布）</font>
      </span></td>
    </tr>
    <tr>
      <td height="30" align="center" bgcolor="#ECF5FF"><span class="tr_southidc">发布时间：</span></td>
      <td height="30" colspan="2" align="left" bgcolor="#ECF5FF"><span class="tr_southidc">
        <input name="PostTime" type="text" id="PostTime" value="<%=Now()%>" size="30" maxlength="120" />
      </span><font color="#0000FF">（为了避免出错，尽量不要更改。格式：<%=Now()%>）</font></td>
    </tr>
    <tr>
      <td height="30" colspan="3" align="center" bgcolor="#ECF5FF"><input type="submit" name="Submit" value="确认添加" class="input">
        
        &nbsp;
        <input type="button" name="Submit2" value="返回上一页" class="input" onClick="history.go(-1);">
        <input name="Act" type="hidden" id="Act" value="Add">        
        <span class="tr_southidc">
        <input name="IncludePic" type="hidden" id="IncludePic" value="0" />
        </span></td>
    </tr>
  </form>
</table>
<!-- #include file="../Inc/Foot.asp" -->