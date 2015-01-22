<!--#include file="gps.asp"-->
<% 
'/////銮峰彇ShowImg.asp镄勭粷瀵硅矾寰?////
Dim curFile
curFile=Server.mappath(Request.servervariables("PATH_INFO"))
Dim cufilename,filename

'/////锲剧墖鐩稿璺缎锛埚瓨浜庢暟鎹簱涓级
'cufilename=rs("ImgURL")
cufilename="s.jpg"

'/////锲犱负ShowImg.asp涓巌mages鍦ㄥ悓涓€鐩綍锛屾墍浠ユ垜浠敤instrrev銮峰彇images镄勮矾寰?////
filename=left(curFile,instrrev(curFile,"\"))&cufilename

'/////寤虹珛GPS绫诲疄浣?////
Dim GetPicSize
Set GetPicSize=new GPS
Set fs=Server.CreateObject("Scripting.FileSystemObject")

'/////銮峰彇锲剧墖绫诲瀷/////
Dim PicSuffixName
PicSuffixName=fs.GetExtensionName(filename)
Dim PD '//Picture Dimension
Dim PWidth,PHeight
Select Case PicSuffixName
Case "gif","bmp","jpg","png":

'/////璋幂敤GPS阃氱敤绫讳腑镄凣etImageSize鍑芥暟銮峰彇锲剧墖灏哄/////
PD=GetPicSize.GetImageSize(filename)
PWidth=PD(1) '//銮峰彇锲剧墖瀹藉害
PHeight=PD(2) '//銮峰彇锲剧墖楂桦害
Case "swf"
PD=GetPicSize.GetImageSize(filename)
PWidth=PD(1) '//銮峰彇Flash瀹藉害
PHeight=PD(2) '//銮峰彇Flash楂桦害
Case Else
End Select
Set fs=Nothing
Set GetPicSize=Nothing
%>



<%
Dim PXWidth,PXHeight
Dim Pp '//Proportion
If PWidth=0 Or PWidth="" Then
PXWidth=0
PXHeight=0
Else
Pp=FormatNumber(PWidth/PHeight,2) '//闀垮姣?
End If
If PWidth>=PHeight Then
If PWidth>=300 Then
PXWidth=300
PXHeight=FormatNumber(300/Pp,0)
Else
PXWidth=PWidth
PXHeight=PHeight
End If
Else
If PHeight>=260 Then
PXHeight=260
PXWidth=FormatNumber(260*Pp,0)
Else
PXWidth=PWidth
PXHeight=PHeight
End If
End If
%>


銆€銆€灏嗕笂闱㈢殑浠ｇ爜绱ф帴绗簩姝ュ啓涓嫔嵆鍙€傝皟鐢ㄦ椂浠ｇ爜濡备笅锛?
<img src=<%=cufilename%> border="0" width=<%=PXWidth%> 
height=<%=PXHeight%>>


銆€銆€镊充簬锲剧墖镙煎纺鍙互鐢?%=PicSuffixName%>寰楀埌锛屽浘鐗囧昂瀵稿彲浠ュ啓鎴?
<%
response.write PXWidth&"X"&PXHeight
%>