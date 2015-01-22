<%
'// 参数：需生成文件、限定宽度、限定高度
 filename=request.QueryString("file")
 width=request.QueryString("width")
 height=request.QueryString("height")
 
 if filename="" or cint(width)<10 or cint(height)<10 then response.Redirect("/images/nopic.jpg") '//如果没有需要生成的图片或者祝宽度和高度小于10像素，则用默认图替代

' filepath="profile/"  '//大图保存文件夹
' savepath="profile/thumbs/" '//大图保存文件夹
' srcfile=filename  '//处理需要生成的图片文件
' f=split(filename,".") 
' destfile=width &"x" & height & "_" & f(0) &"." &f(1) '//缩略图文件名
' 
 'fname=destfile

	fname= ResizePath(filename, width &"x" & height )	



 srcfile=Server.MapPath(filename) '//大图路径
 destfile=Server.MapPath(fname) '//小图路径
 
 Set fs = Server.CreateObject("Scripting.FileSystemObject") '//FSO对象，对文件进行判断
 If fs.FileExists(destfile) Then '//这里注意了，如果缩略图已经存在，就不需要再生成一次了，直接显示小图
 response.Redirect( fname)
 else '//如果缩略图不存在，则先生成，然后显示
call makethumb(srcfile,destfile,width,height,4) '//调用图片处理函数
response.Redirect( fname)
end if
set fs=nothing

'// 图片处理函数
function MakeThumb(fileName,saveName,limitW,limitH,nType)
if not(limitW>0 or limitH>0) then exit function
Dim ojpg,oh,ow
Set ojpg = Server.CreateObject("Persits.Jpeg")
ojpg.open fileName
oh = ojpg.OriginalHeight
ow = ojpg.OriginalWidth
select case nType
case 0
    Rem 限定宽高
    if limitW>0 and limitH>0 then
      ojpg.width=limitW
      ojpg.height=limitH
    end if
case 1
    Rem 只限定宽度，高度按比例
    if limitW>0 then
      ojpg.width=limitW
      ojpg.height=oh/ow*limitW
    end if
case 2
    Rem 只限定高度，宽度按比例
    if limitH>0 then
      ojpg.height=limitH
      ojpg.width=ow/oh*limitH
    end if
case 3
    Rem 按限定的宽高比裁切
    if limitW>0 and limitH>0 then
      Dim lheight:lheight=oh*limitW/ow
      If lheight<limitH Then
        ojpg.Height = limitH
        ojpg.Width = ow*ojpg.Height/oh
      Else
        ojpg.width = limitW
        ojpg.Height = oh*ojpg.width/ow
      End if
      ojpg.Crop 0, 0,limitW,limitH
    End If
case 4
		ojpg.Quality = 100
		'If  ojpg.OriginalHeight/limitH *ojpg.OriginalWidth > limitW Then
				 ojpg.PreserveAspectRatio = True '等比缩放
				 if ojpg.OriginalWidth/ojpg.OriginalHeight > limitW/limitH then '太扁了，要剪掉左右部分
				  ojpg.Height = limitH
				  ojpg.crop CInt((ojpg.Width - limitW)/2),0,CInt((ojpg.Width-limitW)/2)+limitW,limitH
				 elseif  ojpg.OriginalWidth/ojpg.OriginalHeight < limitW/limitH then '太高了，要剪掉上下部分
				  ojpg.Width = limitW
				  ojpg.crop 0,CInt((ojpg.Height-limitH)/2),limitW,CInt((ojpg.Height-limitH)/2)+limitH
				  else
				  ojpg.Width = limitW
				  ojpg.Height = limitH
				 end if
		'end if
case else
    exit function
end select
ojpg.Quality = 100
ojpg.save saveName
Set ojpg = nothing
end function

Function ResizePath(DefaultPicUrl,s)
	te= InStrRev(DefaultPicUrl,".")	
	ImageType=Mid(DefaultPicUrl,te,len(DefaultPicUrl)-te+1)
	ResizePath= Replace(DefaultPicUrl,ImageType,"_"&s&ImageType)
End function
'Thumb 生成缩略图函数
'DefaultPicUrl 源图路径
'sname 缩略图名称加后缀，缩略图与源图 路径相同，名称后面加一后缀 _sname
'width height 生成缩略图的尺寸 不等比例则裁剪 
'函数返回缩略图的地址
function Thumb(DefaultPicUrl,sname,width,height)
	url2= ResizePath(DefaultPicUrl,sname)	
	Set ap=new AspJpeg	
	ap.MathPathFrom=server.mappath(DefaultPicUrl)	
	ap.MathPathTo=server.mappath(url2)
	ap.Width=width
	ap.Height=height
	t=ap.image_resize()	
	Thumb= url2	
end function

%>
