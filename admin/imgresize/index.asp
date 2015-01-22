<!--#include file="gps.asp"-->
<!--#include file="showimg.asp"-->
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
<img src=<%=curfilename%> border="0" width=<%=PXWidth%> 
height=<%=PXHeight%>>


銆€銆€镊充簬锲剧墖镙煎纺鍙互鐢?%=PicSuffixName%>寰楀埌锛屽浘鐗囧昂瀵稿彲浠ュ啓鎴?
<%
response.write PXWidth&"X"&PXHeight
%>