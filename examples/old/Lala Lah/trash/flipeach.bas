' Solo para este juego

Dim As Integer mapW, mapH, scrW, scrH, f, yy, xx, y, x
ReDim As Byte map (0, 0), mapOut (0, 0)
Dim As String inFn, outFn

mapW = 6: mapH = 3
scrW = 15: scrH = 10

inFn = "temp.map"
outFn = "mapa.map"

Redim map ((scrH * mapH) - 1, (scrW * mapW) - 1)
Redim mapOut ((scrH * mapH) - 1, (scrW * mapW) - 1)

f = FreeFile
Open inFn For Binary as #f
For y = 0 To (mapH * scrH) - 1
	For x = 0 To (mapW * scrW) - 1
		Get #f, , map (y, x)
	Next x
Next y
Close #f

? "Read " & inFn

For yy = 0 To mapH - 1
	For xx = 0 To mapW - 1
		For y = 0 to scrH - 1
			For x = 0 to scrW - 1
				mapOut (yy * scrH + y, xx * scrW + x) = map (yy * scrH + scrH - 1 - y, xx * scrW + x)
				locate y+1,x+1:?Chr(65+map (yy * scrH + y, xx * scrW + x))
				locate y+1,x+41:?Chr(65+mapOut (yy * scrH + y, xx * scrW + x))
			Next x
		Next y
		'?:?"KEY":while inkey="":Wend:While Inkey<>"":Wend
	Next xx
Next yy

f = FreeFile
Open outFn For Binary as #f
For y = 0 To (mapH * scrH) - 1
	For x = 0 To (mapW * scrW) - 1
		Put #f, , mapOut (y, x)
	Next x
Next y
Close #f

? "writing OutFn"
