<%
'// �������������ļ����޶���ȡ��޶��߶�
 filename=request.QueryString("file")
 width=request.QueryString("width")
 height=request.QueryString("height")
 
 if filename="" or cint(width)<10 or cint(height)<10 then response.Redirect("/images/nopic.jpg") '//���û����Ҫ���ɵ�ͼƬ����ף��Ⱥ͸߶�С��10���أ�����Ĭ��ͼ���

' filepath="profile/"  '//��ͼ�����ļ���
' savepath="profile/thumbs/" '//��ͼ�����ļ���
' srcfile=filename  '//������Ҫ���ɵ�ͼƬ�ļ�
' f=split(filename,".") 
' destfile=width &"x" & height & "_" & f(0) &"." &f(1) '//����ͼ�ļ���
' 
 'fname=destfile

	fname= ResizePath(filename, width &"x" & height )	



 srcfile=Server.MapPath(filename) '//��ͼ·��
 destfile=Server.MapPath(fname) '//Сͼ·��
 
 Set fs = Server.CreateObject("Scripting.FileSystemObject") '//FSO���󣬶��ļ������ж�
 If fs.FileExists(destfile) Then '//����ע���ˣ��������ͼ�Ѿ����ڣ��Ͳ���Ҫ������һ���ˣ�ֱ����ʾСͼ
 response.Redirect( fname)
 else '//�������ͼ�����ڣ��������ɣ�Ȼ����ʾ
call makethumb(srcfile,destfile,width,height,4) '//����ͼƬ������
response.Redirect( fname)
end if
set fs=nothing

'// ͼƬ������
function MakeThumb(fileName,saveName,limitW,limitH,nType)
if not(limitW>0 or limitH>0) then exit function
Dim ojpg,oh,ow
Set ojpg = Server.CreateObject("Persits.Jpeg")
ojpg.open fileName
oh = ojpg.OriginalHeight
ow = ojpg.OriginalWidth
select case nType
case 0
    Rem �޶����
    if limitW>0 and limitH>0 then
      ojpg.width=limitW
      ojpg.height=limitH
    end if
case 1
    Rem ֻ�޶���ȣ��߶Ȱ�����
    if limitW>0 then
      ojpg.width=limitW
      ojpg.height=oh/ow*limitW
    end if
case 2
    Rem ֻ�޶��߶ȣ���Ȱ�����
    if limitH>0 then
      ojpg.height=limitH
      ojpg.width=ow/oh*limitH
    end if
case 3
    Rem ���޶��Ŀ�߱Ȳ���
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
				 ojpg.PreserveAspectRatio = True '�ȱ�����
				 if ojpg.OriginalWidth/ojpg.OriginalHeight > limitW/limitH then '̫���ˣ�Ҫ�������Ҳ���
				  ojpg.Height = limitH
				  ojpg.crop CInt((ojpg.Width - limitW)/2),0,CInt((ojpg.Width-limitW)/2)+limitW,limitH
				 elseif  ojpg.OriginalWidth/ojpg.OriginalHeight < limitW/limitH then '̫���ˣ�Ҫ�������²���
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
'Thumb ��������ͼ����
'DefaultPicUrl Դͼ·��
'sname ����ͼ���ƼӺ�׺������ͼ��Դͼ ·����ͬ�����ƺ����һ��׺ _sname
'width height ��������ͼ�ĳߴ� ���ȱ�����ü� 
'������������ͼ�ĵ�ַ
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
