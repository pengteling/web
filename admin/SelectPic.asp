<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>选择首页图片</title>
<style type="text/css">
<!--
body,td,th {
	font-size: 12px;
}
body {
	margin-top: 3px;
	margin-left:0px;
	margin-right:0px;
}
li {
	list-style-image: none;
	list-style-type: none;
	text-align:center;
	width:126px;
	height:126px;
	float:left;
}
-->
</style>
<script language="javascript">
var ImgUrl,ImgList;
ImgList="";
ImgUrl=opener.myform.UploadFiles.value;
ImgUrlArray=ImgUrl.split("|");
if(ImgUrlArray.length<=1){
alert('您没有上传图片');
window.close();
}
for(i=0;i<ImgUrlArray.length-1;i++){
ImgList=ImgList+"<li><img src='" + ImgUrlArray[i] + "' width='120' height='120' alt='单击选择图片' style='cursor:hand;' onclick=\"opener.myform.DefaultPicUrl.value='" + ImgUrlArray[i] + "';window.close();\"/></li>"
}
document.write(ImgList);

</script>
</head>

<body>
</body>

</html>
