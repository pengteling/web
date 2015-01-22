<!doctype html><!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<style>

#productimages li{
	list-style-image: none;
	list-style-type: none;
	text-align:center;
	width:126px;
	height:146px;
	float:left;
}
</style>
<%
if Request.Cookies("xd_urljilunew")="" then
Response.Cookies("xd_urljilunew")=request.ServerVariables("HTTP_REFERER")
end if
dim rs,sql,count,ID,bclass,sclass,DefaultPic
ID=strToNum(Request("ID"))
Set NewsRs=Conn.execute("select * from product2 Where ID="&ID)
If NewsRs.Eof then
	Response.Write "信息不存在"
    Response.End
End If
DefaultPic=Trim(NewsRs("DefaultPicUrl"))
If DefaultPic="" then
	DefaultPic="images/Nopic.jpg"
End If

fx =  NewsRs("fx")
hx =NewsRs("hx")
hx_no1 =mid(hx,1,1)
hx_no2 =mid(hx,3,1)
hx_no3 =mid(hx,5,1)
hx_no4 =mid(hx,7,1)

set rs=server.createobject("adodb.recordset")

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
	if (document.myform.content.value.length == 0){
		alert("信息内容不能为空！");
		
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
<style type="text/css">
<!--
.tr_southidc {BACKGROUND-COLOR: ECF5FF;}
-->
</style>

<table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
  <form name="myform" method="post" action="News_save.asp" onSubmit="return CheckForm();">
    <tr>
      <td height="30" colspan="3" align="center" class="blod">修改信息</td>
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
        <option value="一居" <%if fx="一居" then response.write "selected"%>>一居</option>
        <option value="二居" <%if fx="二居" then response.write "selected"%>>二居</option>
        <option value="三居" <%if fx="三居" then response.write "selected"%>>三居</option>
        <option value="四居" <%if fx="四居" then response.write "selected"%>>四居</option>
        <option value="五居" <%if fx="五居" then response.write "selected"%>>五居</option>
        </select>
        
        <select name="hx_no1" id="hx_no1" >
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
        <select name="hx_no2" id="hx_no2">
        <option value="1">1</option>
         <option value="2">2</option>
          <option value="3">3</option>
           <option value="4">4</option>
            <option value="5">5</option>
             <option value="6">6</option>       
        </select>厅
        
         <select name="hx_no3" id="hx_no3">
        <option value="1">1</option>
         <option value="2">2</option>
          <option value="3">3</option>
           <option value="4">4</option>
            <option value="5">5</option>
             <option value="6">6</option>       
        </select>厨
        
        
         <select name="hx_no4" id="hx_no4">
        <option value="1">1</option>
         <option value="2">2</option>
          <option value="3">3</option>
           <option value="4">4</option>
            <option value="5">5</option>
             <option value="6">6</option>       
        </select>卫
         价格： <input name="price" id="price" class="input" size="10" value="<%=NewsRs("price")%>"/> 元 
        
        </td>
    </tr>
   <script>
   $(function(){
   $('#hx_no1')[0].options[<%=hx_no1 -1%>].selected=true;
   $('#hx_no2')[0].options[<%=hx_no2 -1%>].selected=true;
   $('#hx_no3')[0].options[<%=hx_no3 -1%>].selected=true;
   $('#hx_no4')[0].options[<%=hx_no4 -1%>].selected=true;
   $("#yt").val("<%=NewsRs("yt")%>"); 
$("#zx").val("<%=NewsRs("zx")%>"); 
$("#title").val("<%=NewsRs("title")%>"); 
   });
   </script> 
    <tr bgcolor="#ECF5FF">
      <td height="22" align="center" class="tr_southidc">装修业态：</td>
      <td colspan="2" width="80%">项目业态：<select name="yt" id="yt">
     <option value="高层住宅">高层住宅</option>
      <option value="别墅">别墅</option>
      <option value="洋房">洋房</option>      
      <option value="SOHO公寓">SOHO公寓</option>
      <option value="商铺">商铺</option>
      <option value="车位">车位</option>
      <option value="写字楼">写字楼</option>
      
      </select>
       装修情况：
     <select name="zx" id="zx">
       <option value="毛坯">毛坯</option>
      <option value="简装修">简装修</option>
      <option value="普通装修">普通装修</option>
      <option value="精装修">精装修</option>      
      </select>
     
     建筑面积：<input name="area" size="3" value="<%=NewsRs("area")%>">㎡
       
            </td>
    </tr>
        
    
    
     <tr>
      <td  height="22" align="center" bgcolor="#C0C0C0" class="tr_southidc">所属栏目：</td>
      <td colspan="2" bgcolor="#E3E3E3" class="tr_southidc"><select name="cateid">
	  <%
followid=NewsRs("cateid")
rs.open "select cateid,catename,followid,depth,sonid,parentid,orderID from category where modeltype=4 and catetype<=1 order by depth,orderID",conn,1,1
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
%>    </select>   
        </td>
    </tr>
 <input name="Author" type="hidden" id="auther" value="<%=session("AdminName")%>" >       
 
 

    
    <tr bgcolor="#ECF5FF">
      <td height="25" align="center" valign="top">楼盘详情：</td>
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
				 filterMode : false,
				allowFileManager : true,
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
				 filterMode : false,
				allowFileManager : true,
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
<textarea name="content" id="contentid" style="width:700px;height:500px;visibility:hidden;"><%if not isnull(NewsRs("content")) then response.write htmlspecialchars(NewsRs("content"))%></textarea>
      <div>
       <input name="saveimg" type="checkbox" value="1">保存远程图片</div>
           </td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="25" align="center" valign="top">租售信息：</td>
      <td colspan="2" valign="top"><textarea id="content_zy" name="content_zy" style="width:700px;height:200px;visibility:hidden;"><%if not isnull(NewsRs("content_zy")) then response.write  htmlspecialchars(NewsRs("content_zy"))%></textarea></td>
    </tr>
    <tr>
      <td height="30" align="center" bgcolor="#ECF5FF"><span class="tr_southidc">首页图片：</span></td>
      <td width="314" height="30" bgcolor="#ECF5FF"><span class="tr_southidc">
        <input name="DefaultPicUrl" type="text" id="DefaultPicUrl" value="<%=DefaultPic%>" size="30" maxlength="120" /> <input name="UploadFiles" type="hidden" id="UploadFiles" value="<%=NewsRs("UploadFiles")%>" />
      </span></td>
      <td width="499" bgcolor="#ECF5FF"><span class="tr_southidc">
        <input type="button" name="Submit22" value="直接从上传图片中选择" onClick="window.open('../SelectPic.asp','','status=no,scrollbars=yes,top=300,left=200,width=396,height=254');" />
        <input name="Submit222" type="button" value="上传图片"   id="image3"><input type="button" id="J_selectImage" value="批量上传" />
      </span></td>
    </tr>
	<tr>
      <td height="22" align="center" bgcolor="#C0C0C0" class="tr_southidc">已有图片：</td>
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
    
    <tr bgcolor="#ECF5FF">
      <td height="25" align="center" valign="top">LOGO图片：</td>
      <td colspan="2" valign="top"><input name="xmlogo" type="text" id="xmlogo" value="<%=NewsRs("xmlogo")%>" size="30" maxlength="120" /><input  type="button" value="上传图片"   id="image4" value=""></td>
    </tr>
    
    <tr>
      <td height="30" align="center" bgcolor="#ECF5FF"><span class="tr_southidc">是否推荐：</span></td>
      <td height="30" colspan="2" align="left" bgcolor="#ECF5FF"><input name="Elite" type="checkbox" id="Elite" value="yes" <%if NewsRs("Elite")=true then%>checked<%end if%>>
      是<font color="#0000FF">（如果选中的话将在首页做为图片信息显示）</font></td>
    </tr>
	<tr>
      <td height="30" align="center" bgcolor="#ECF5FF">排序：</td>
      <td height="30" colspan="2" align="left" bgcolor="#ECF5FF"><span class="tr_southidc">
        <input name="px" type="text" id="px" value="<%=NewsRs("px")%>" size="10" maxlength="5" />
        数字越大越靠前
      </span></td>
    </tr>
      <tr>
      <td height="30" align="center" bgcolor="#C0C0C0" class="tr_southidc">是否审核：</td>
      <td colspan="2" bgcolor="#E3E3E3" class="tr_southidc"><input name="Passed" type="checkbox" id="Passed" value="yes" <% if NewsRs("Passed")=true then response.Write("checked") end if%>>
        是<font color="#0000FF">（如果选中的话将直接发布）</font></td>
    </tr>
    <tr>
      <td height="30" align="center" bgcolor="#ECF5FF"><span class="tr_southidc">发布时间：</span></td>
      <td height="30" colspan="2" align="left" bgcolor="#ECF5FF"><span class="tr_southidc">
        <input name="PostTime" type="text" id="PostTime" value="<%=NewsRs("PostTime")%>" size="30" maxlength="120" />
      </span><font color="#0000FF">（为了避免出错，尽量不要更改。格式：<%=NewsRs("PostTime")%>）</font></td>
    </tr>
    <tr>
      <td height="30" colspan="3" align="center" bgcolor="#ECF5FF"><input type="submit" name="Submit" value="确认修改" class="input">
        &nbsp;
        <input type="button" name="Submit2" value="返回上一页" class="input" onClick="history.go(-1);">
        <input name="Act" type="hidden" id="Act" value="Edit">        <input name="ID" type="hidden" id="ID" value="<%=ID%>">
       
        <span class="tr_southidc">
		<%
		If NewsRs("IncludePic") Then
		    ii=1
		Else
		    ii=0
		End If	
		'Response.Write ii
		%>
        <input name="IncludePic" type="hidden" id="IncludePic" value="<%=ii%>" />
        </span></td>
    </tr>
  </form>
</table>
<!-- #include file="../Inc/Foot.asp" -->