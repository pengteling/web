<%
'================================================== 
'函数名：CheckDir2 
'作 用：检查文件夹是否存在 
'参 数：FolderPath ------文件夹地址 
'================================================== 
Function CheckDir2(byval FolderPath) 
dim fso 
folderpath=Server.MapPath(folderpath)
Set fso = Server.CreateObject("Scripting.FileSystemObject") 
If fso.FolderExists(FolderPath) then 
'存在 
CheckDir2 = True 
Else 
'不存在 
CheckDir2 = False 
End if 
Set fso = nothing 
End Function 
'================================================== 
'函数名：MakeNewsDir2 
'作 用：创建新的文件夹 
'参 数：foldername ------文件夹名称 
'================================================== 
Function MakeNewsDir2(byval foldername) 
dim fso 
Set fso = Server.CreateObject("Scripting.FileSystemObject") 
fso.CreateFolder(Server.MapPath(foldername))
If fso.FolderExists(Server.MapPath(foldername) ) Then 
MakeNewsDir2 = True 
Else 
MakeNewsDir2 = False 
End If 
Set fso = nothing 
End Function 

'================================================== 
'函数名：ReplaceSaveRemoteFile 
'作 用：替换、保存远程文件 
'参 数：ConStr ------ 要替换的字符串 
'参 数：StarStr ----- 前导 
'参 数：OverStr ----- 
'参 数：IncluL ------ 
'参 数：IncluR ------ 
'参 数：SaveTf ------ 是否保存文件，False不保存，True保存 
'参 数：SaveFilePath- 保存文件夹 
'参 数: TistUrl------ 当前网页地址 
'================================================== 
Function ReplaceSaveRemoteFile(ConStr,StartStr,OverStr,IncluL,IncluR,SaveTf,SaveFilePath,TistUrl) 
	If ConStr="$False$" or ConStr="" Then 
		ReplaceSaveRemoteFile="$False$" 
		Exit Function 
	End If 
Dim TempStr,TempStr2,ReF,Matches,Match,Tempi,TempArray,TempArray2,OverTypeArray 
Set ReF = New Regexp 
ReF.IgnoreCase = True 
ReF.Global = True 
ReF.Pattern = "("&StartStr&").+?("&OverStr&").+?(\s|\'|\""|>)"   '后网址中可能有两个或多个.jpg 一定是后面跟引号或空格或>

Set Matches =ReF.Execute(ConStr) 
	For Each Match in Matches 
	
		If Instr(TempStr,Match.Value)=0 Then 
		If TempStr<>"" then 
		TempStr=TempStr & "$Array$" & Match.Value 
		Else 
		TempStr=Match.Value 
		End if 
		End If 
	Next 
Set Matches=nothing 
Set ReF=nothing 
If TempStr="" or IsNull(TempStr)=True Then 
	ReplaceSaveRemoteFile=ConStr 
	Exit function 
End if 

If IncluL=False then 
TempStr=Replace(TempStr,StartStr,"") 
End if 


If IncluR=False then 
	If Instr(OverStr,"|")>0 Then 
	OverTypeArray=Split(OverStr,"|") 
		For Tempi=0 To Ubound(OverTypeArray) 
		TempStr=Replace(TempStr,OverTypeArray(Tempi),"") 
		Next 
	Else 
	TempStr=Replace(TempStr,OverStr,"") 
	End If 
End if 
TempStr=Replace(TempStr,"""","") 
empStr=Replace(TempStr,">","") 
TempStr=Replace(TempStr,"'","") 

'response.write TempStr

Dim RemoteFile,RemoteFileurl,SaveFileName,SaveFileType,ArrSaveFileName,RanNum 
If Right(SaveFilePath,1)="/" then 
	SaveFilePath=Left(SaveFilePath,Len(SaveFilePath)-1) 
End If 
If SaveTf=True then 
	If CheckDir2(SaveFilePath)=False Then 
		If MakeNewsDir2(SaveFilePath)=False Then 
		SaveTf=False 
		End If 
	End If 
End If 
SaveFilePath=SaveFilePath & "/" 
'图片转换/保存 

TempArray=Split(TempStr,"$Array$") 
For Tempi=0 To Ubound(TempArray) 

'RemoteFileurl=DefiniteUrl(TempArray(Tempi),TistUrl) 
RemoteFileurl=TempArray(Tempi)
if lcase(left(RemoteFileurl,4))<>"http" then
	RemoteFileurl="$False$"
end if
'response.write RemoteFileurl
'response.end
If RemoteFileurl<>"$False$" And SaveTf=True Then'保存图片 
	
	ArrSaveFileName = Split(RemoteFileurl,".") 
	SaveFileType=ArrSaveFileName(Ubound(ArrSaveFileName))'文件类型 
	RanNum=Int(900*Rnd)+100 
	SaveFileName = SaveFilePath&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&ranNum&"."&SaveFileType 
	Call SaveRemoteFile(SaveFileName,RemoteFileurl) 
	'response.write RemoteFileurl
	ConStr=Replace(ConStr,TempArray(Tempi),SaveFileName) 
ElseIf RemoteFileurl<>"$False$" and SaveTf=False Then'不保存图片 
SaveFileName=RemoteFileUrl 
ConStr=Replace(ConStr,TempArray(Tempi),SaveFileName) 
End If 
If RemoteFileUrl<>"$False$" Then 
If UploadFiles="" then 
UploadFiles=SaveFileName &"|"
Else 
UploadFiles=SaveFileName & "|" &  UploadFiles
End if 
End If 
Next 
ReplaceSaveRemoteFile=ConStr 
End function 
'================================================== 
'过程名：SaveRemoteFile 
'作 用：保存远程的文件到本地 
'参 数：LocalFileName ------ 本地文件名 
'参 数：RemoteFileUrl ------ 远程文件URL 
'================================================== 
sub SaveRemoteFile(LocalFileName,RemoteFileUrl) 
dim Ads,Retrieval,GetRemoteData 
Set Retrieval = Server.CreateObject("Microsoft.XMLHTTP") 
With Retrieval 
.Open "Get", RemoteFileUrl, False, "", "" 
.Send 
GetRemoteData = .ResponseBody 
End With 
Set Retrieval = Nothing 
Set Ads = Server.CreateObject("Adodb.Stream") 
With Ads 
.Type = 1 
.Open 
.Write GetRemoteData 
.SaveToFile server.MapPath(LocalFileName),2 
.Cancel() 
.Close() 
End With 
Set Ads=nothing 
end sub 
'================================================== 
'过程名：GetImg 
'作 用：取得文章中第一张图片 
'参 数：str ------ 文章内容 
'参 数：strpath ------ 保存图片的路径 
'================================================== 
Function GetImg(str,strpath) 
set objregEx = new RegExp 
objregEx.IgnoreCase = true 
objregEx.Global = true 
zzstr=""&strpath&"(.+?)\.(jpg|gif|png|bmp)" 
objregEx.Pattern = zzstr 
set matches = objregEx.execute(str) 
for each match in matches 
retstr = retstr &"|"& Match.Value 
next 
if retstr<>"" then 
Imglist=split(retstr,"|") 
Imgone=replace(Imglist(1),strpath,"") 

GetImg=Imgone 
else 
GetImg="" 
end if 
end function 

 
'================================================== 
'================================================== 
'================================================== 
'================================================== 
'================================================== 
'================================================== 
'================================================== 
'================================================== 
'================================================== 
'================================================== 

'调用

'图片开始的字符串 
FilesStartStr="src=" 
'图片结束的字符串 
FilesOverStr="gif|jpg|bmp|png|jpeg" 
'保存图片的文件夹 
FilesPath="/uploadfiles/remoteimg" 
'取得保存图片的网站URL 自动判断是绝对 还是相对路径 该例子中图片是绝对地址 所以NEWURL等于没用 如果是../images/123.gif这样的 就需要指定NEWURL了 



'开始保存图片 
'Content=ReplaceSaveRemoteFile(Content,FilesStartStr,FilesOverStr,False,True,True,FilesPath,NewsUrl) 



function relativeUploadfiles(ConStr,StartStr,OverStr)

	TempStr=""
	Set ReF = New Regexp 
	ReF.IgnoreCase = True 
	ReF.Global = True 
	'ReF.Pattern = "("&StartStr&").+?("&OverStr&").+?(\s|\'|\""|/|>)"   '后网址中可能有两个或多个.jpg 一定是后面跟引号或空格或>
	
	ReF.Pattern = "("&StartStr&").+?("&OverStr&")"   '后网址中可能有两个或多个.jpg 一定是后面跟引号或空格或>
	
	Set Matches =ReF.Execute(ConStr) 
	For Each Match in Matches 
	
		If Instr(TempStr,Match.Value)=0 Then 
		If TempStr<>"" then 
		TempStr=TempStr & "|" & Match.Value 
		Else 
		TempStr=Match.Value 
		End if 
		End If 
	Next 
	Set Matches=nothing 
	Set ReF=nothing 
	
	relativeUploadfiles = TempStr
	
end function
%>