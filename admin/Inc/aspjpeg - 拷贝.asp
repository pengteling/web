<%
'url="http://ewrwer/werwer/er/werwerwer.gif"
'te= InStrRev(url,".")
'Response.write Mid(url,te,len(url)-te+1)
'Set ap=new AspJpeg
'ap.MathPathFrom=server.mappath("../../uploadfiles/20120927104032863286.gif")
'ap.MathPathTo=server.mappath("../../uploadfiles/20120927104032863286_s.gif")
'ap.Width=100
'ap.Height=100
't=ap.image_resize()

'response.write t

Class AspJpeg 

Dim AspJpeg_Obj


Private Sub Class_Initialize() 
Set Jpeg=createObject("Persits.Jpeg") 
End sub

private sub class_terminate() 
Set Jpeg=nothing
end sub 
			
			Private OriginalPath,BuildBasePath,MaxWidth,MaxHeight,ImageType  
			
			'--------------取原文件路径 
			Public Property Let MathPathFrom(StrType) 
			OriginalPath=StrType 
			te= InStrRev(OriginalPath,".")
			ImageType=UCase(Mid(OriginalPath,te+1,len(OriginalPath)-te))
			End Property 

			'--------------取文件保存路径 
			Public Property Let MathPathTo(strType) 
			BuildBasePath=strType 
			End Property 

			
			'---------------取缩略图/放大图 缩略值 
			Public Property Let Width(LngSize) 
			If isNumeric(LngSize) then 
				MaxWidth=LngSize 
			End If 
			End Property

			'---------------取缩略图/放大图 缩略值 
			Public Property Let Height(LngSize) 
			If isNumeric(LngSize) then 
				MaxHeight=LngSize 
			End If 
			End Property


Function image_resize()
	image_resize=0
							'---------------缩略图与水印效果－－－－－－－－－－－
	Set Jpeg = Server.CreateObject("Persits.Jpeg")
	If ImageType="GIF" then
				Set Jpeg = Jpeg.Gif

				' 创建组件
				Jpeg.Open OriginalPath
				Jpeg.Quality = 100

				If Jpeg.Height>MaxHeight or Jpeg.Width>MaxWidth Then '宽或高 大过缩略图尺寸 则要处理
					If Jpeg.Height/MaxHeight *Jpeg.Width < MaxWidth Then '按高缩放后 宽小于宽度
						Jpeg.Resize (MaxHeight/Jpeg.Height)*Jpeg.Width ,MaxHeight
					Else
						Jpeg.Resize MaxWidth,(MaxWidth/Jpeg.Width)*Jpeg.Height
					End If
				Jpeg.Save BuildBasePath
				image_resize=1
				End if

				
				 
				'Jpeg.close
	ElseIf ImageType="JPG" Or ImageType = "PNG"  Or ImageType = "BMP" then

				' 创建组件
				Jpeg.Open OriginalPath
				Jpeg.Quality = 100

				If  Jpeg.OriginalHeight/MaxHeight *Jpeg.OriginalWidth > MaxWidth Then 
					'If Jpeg.OriginalHeight/Jpeg.OriginalWidth > 1 Then
					If Jpeg.OriginalHeight/MaxHeight *Jpeg.OriginalWidth < MaxWidth Then '按高缩放后 宽小于宽度
					Jpeg.Width=(MaxHeight/Jpeg.OriginalHeight)*Jpeg.OriginalWidth
					Jpeg.Height=MaxHeight
					Else
					Jpeg.Width= MaxWidth
					Jpeg.Height=(MaxWidth/Jpeg.OriginalWidth)*Jpeg.OriginalHeight
					End If

				'response.write BuildBasePath
				Jpeg.Save BuildBasePath
				image_resize=1
					'Jpeg.open ((PhotoPath)) & "\" &   filename1		
					'Jpeg.Interpolation=1   
					' Jpeg.Quality=100   
					' iWidth=Jpeg.OriginalWidth
					' iHeight=Jpeg.OriginalHeight   
					' iiwidth=210 '水印图片的宽度
					' iiheight=111 '水印图片的高度
					' Jpeg.Canvas.DrawPNG iWidth-iiWidth-5, iHeight-iiHeight-5,Server.MapPath("../static/images/Water.png")  'Water.png即为水印图片
					'Jpeg.Save ((PhotoPath)) & "\" &   filename1
				End If

End if
				

				

End Function
End Class
%>