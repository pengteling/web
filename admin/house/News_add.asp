<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%
dim rs
dim sql
dim count
followid=strToNum(request("cateid"))

'Call p_cate(followid,2)
%>
<script language = "JavaScript">

function CheckForm()
{
	if (document.myform.title.value.length == 0) {
		alert("信息标题没有填写.");
		document.myform.title.focus();
		return false;
	}	
	editor1.sync();
	editor2.sync();
	//alert(document.myform.content.value);
	//return false;
	if (document.myform.content.value.length == 0){
		alert("信息内容不能为空！");		
		return false;
	}    
return true; 	
}

function SetDropDownPic(url){
	document.myform.UploadFiles.value=document.myform.UploadFiles.value + url +"|";
	document.myform.IncludePic.value="1";
}
</script>
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
  <form name="myform" method="post" action="News_save.asp" onSubmit="return CheckForm();">
    <tr>
      <td height="30" colspan="3" align="center" class="blod">增加信息</td>
    </tr>
    
    
    <tr bgcolor="#ECF5FF">
      <td height="22" align="center" class="tr_southidc">房源信息：</td>
      <td colspan="2" width="80%">楼盘项目名称：  
      <select name="title" id="title">
      
      <%rs.open "Select title from product where isdel=false and passed=true order by px desc,id desc",conn,1,1

while not rs.eof
response.write "<option value="""&rs(0)&""">"&rs(0)&"</option>"
rs.movenext
wend
rs.close
%>
</select>
        
        房型：<select name="fx" id="fx">
        <option value="一居">一居</option>
        <option value="二居">二居</option>
        <option value="三居">三居</option>
        <option value="四居">四居</option>
        <option value="五居">五居</option>
        </select>
        
        <select name="hx_no1">
        <option value="1">1</option>
         <option value="2">2</option>
          <option value="3">3</option>
           <option value="4">4</option>
            <option value="5">5</option>
             <option value="6">6</option>
              <option value="7">7</option>
               <option value="8">8</option>
                <option value="9">9</option>
        </select>室
        <select name="hx_no2">
        <option value="1">1</option>
         <option value="2">2</option>
          <option value="3">3</option>
           <option value="4">4</option>
            <option value="5">5</option>
             <option value="6">6</option>       
        </select>厅
        
         <select name="hx_no3">
        <option value="1">1</option>
         <option value="2">2</option>
          <option value="3">3</option>
           <option value="4">4</option>
            <option value="5">5</option>
             <option value="6">6</option>       
        </select>厨
        
        
         <select name="hx_no4">
        <option value="1">1</option>
         <option value="2">2</option>
          <option value="3">3</option>
           <option value="4">4</option>
            <option value="5">5</option>
             <option value="6">6</option>       
        </select>卫
         价格： <input name="price" id="price" class="input" size="10"/> 元 
        
        </td>
    </tr>
    
    <tr bgcolor="#ECF5FF">
      <td height="22" align="center" class="tr_southidc">装修业态：</td>
      <td colspan="2" width="80%">项目业态：<select name="yt" >
     <option value="高层住宅">高层住宅</option>
      <option value="别墅">别墅</option>
      <option value="洋房">洋房</option>      
      <option value="SOHO公寓">SOHO公寓</option>
      <option value="商铺">商铺</option>
      <option value="车位">车位</option>
      <option value="写字楼">写字楼</option>
      
      </select>
       装修情况：
     <select name="zx">
       <option value="毛坯">毛坯</option>
      <option value="简装修">简装修</option>
      <option value="普通装修">普通装修</option>
      <option value="精装修">精装修</option>      
      </select>
     
     建筑面积：<input name="area" size="3">㎡
       
            </td>
    </tr>
    
    <tr>
            <td height="22" align="center" class="tr_southidc">信息类别：</td>
            <td colspan="2" class="tr_southidc"><div align="left">
            	<select name="cateid">
          
          <%

set rs=server.CreateObject("adodb.recordset")
			rs.open "select cateid,catename,followid,depth,sonid,parentid,orderID from category where modeltype=4 and catetype<=1 "&sql_sonid&" order by depth,orderID",conn,1,1
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
		call classlist(204)	
	end if	
		response.write class_list
		  %>
        </select> 
        
            	</div></td>
          </tr>
   <input name="Author" type="hidden" id="auther" value="<%=session("AdminName")%>" >       


    
     
    
    <tr bgcolor="#ECF5FF">
      <td height="25" align="center" valign="top">项目详情：</td>
      <td colspan="2" valign="top"> 
            <link rel="stylesheet" href="/kindeditor/themes/default/default.css" />
	 <link rel="stylesheet" href="/kindeditor/plugins/code/prettify.css" />
	<script charset="utf-8" src="/kindeditor/kindeditor.js"></script>
	<script charset="utf-8" src="/kindeditor/lang/zh_CN.js"></script>
	<script charset="utf-8" src="/kindeditor/plugins/code/prettify.js"></script>
	<script>
		var editor1;
		var editor2;
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
			editor2 = K.create('#content_zy', {
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
				K('#image4').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							showRemote : true,
							imageUrl : K('#xmlogo').val(),
							clickFn : function(url, title, width, height, border, align) {
								K('#xmlogo').val(url);
								editor.hideDialog();
							}
						});
					});
				});
			});


			</script>
<textarea id="contentid" name="content"  style="width:700px;height:300px;visibility:hidden;"></textarea>
 <div>
       <input name="saveimg" type="checkbox" value="1">保存远程图片</div>
         </td>
    </tr>
     <tr bgcolor="#ECF5FF">
      <td height="25" align="center" valign="top">租售信息：</td>
      <td colspan="2" valign="top"><textarea id="content_zy" name="content_zy" style="width:700px;height:300px;visibility:hidden;"></textarea></td>
    </tr>
    <tr>
      <td height="30" align="center" bgcolor="#ECF5FF"><span class="tr_southidc">首页图片：</span></td>
      <td width="301" height="30" bgcolor="#ECF5FF"><span class="tr_southidc">
        <input name="DefaultPicUrl" type="text" id="DefaultPicUrl" value="images/Nopic.jpg" size="30" maxlength="120" />
      </span></td>
      <td width="495" bgcolor="#ECF5FF"><span class="tr_southidc">
        <input type="button" name="Submit22" value="直接从上传图片中选择" onClick="window.open('../SelectPic.asp','','status=no,scrollbars=yes,top=300,left=200,width=396,height=254');" />
        <input name="Submit222" type="button" value="上传图片"   id="image3">
      </span></td>
    </tr>
    
      <tr bgcolor="#ECF5FF">
      <td height="25" align="center" valign="top">LOGO图片：</td>
      <td colspan="2" valign="top"><input name="xmlogo" type="text" id="xmlogo" value="images/Nopic.jpg" size="30" maxlength="120" /><input  type="button" value="上传图片"   id="image4"></td>
    </tr>
    
    <tr>
      <td height="30" align="center" bgcolor="#ECF5FF"><span class="tr_southidc">是否推荐：</span></td>
      <td height="30" colspan="2" align="left" bgcolor="#ECF5FF"><input name="Elite" type="checkbox" id="Elite" value="yes">是<font color="#0000FF">（如果选中的话将在首页做为图片信息显示）</font></td>
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
        <input name="Act" type="hidden" id="Act" value="Add">        <input name="UploadFiles" type="hidden" id="UploadFiles" />
        <span class="tr_southidc">
        <input name="IncludePic" type="hidden" id="IncludePic" value="0" />
        </span></td>
    </tr>
  </form>
</table>
<!-- #include file="../Inc/Foot.asp" -->