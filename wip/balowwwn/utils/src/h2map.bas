' Fix your own shit again!

Const MAX_NUMBERS = 150

Sub usage
	Print "$ h2map.exe map_w map_h scr_w scr_h mapa.h mapa.map"
	Print
	Print "Where:"
	Print	
	Print "* map_w, map_h, scr_w, scr_h are map dimmensions."
	Print "* mapa.h is the input filename."
	Print "* mapa.map is the output filename."
End Sub

Sub skipToStringPattern (fIn as Integer, pattern As String)
	Dim As String lineIn
	Do While Not Eof (fIn)
		Line Input #fIn, lineIn
		If Instr (lineIn, pattern) Then Exit Do
	Loop
End Sub

Sub extractListOfNumbers (fullLine As String, numbers () As Integer, ByRef n As Integer)
	Dim As Integer i
	Dim As String partial, m
	n = 0
	fullLine = fullLine  & " " 	' Safe
	partial = ""
	For i = 1 To Len (fullLine) 
		m = Mid (fullLine, i, 1)
		If m >= "0" And m <= "9" Then
			partial = partial & m
		Else
			If partial <> "" Then
				numbers (n) = Val (partial)
				If n < MAX_NUMBERS Then n = n + 1
				partial = ""
			End if
		End If
	Next i
End Sub

Function procrust (s As String, n As Integer) As String
	If Len (s) >= n Then 
		procrust = Left (s, n)
	ElseIf Len (s) < n Then
		procrust = s & Space (n - Len (s))
	End If
End Function

Sub safeWriteStringToFile (fOut As Integer, s As String)
	Dim As Integer i
	Dim As uByte d
	For i = 1 To Len (s)
		d = Asc (Mid (s, i, 1)): Put #fOut, , d
	Next i
End Sub

Dim As Integer mapW, mapH, scrW, scrH, nEnems, nPant, maxPants, maxEnems, i, j, x, y, xP, yP, fIn, fOut, parsed
Dim As Integer numbers (MAX_NUMBERS)
Dim As uByte d
Dim As String auxStr
Redim As uByte bigMap (0,0)

Print "h2map.exe - get an old churrera UNPACKED! mapa.h and creates suitable mapa.map"
Print
	
If Command (6) = "" Then usage: End

mapW = Val (Command (1))
mapH = Val (Command (2))
scrW = Val (Command (3))
scrH = Val (Command (4))
maxPants = mapW * mapH

Redim bigMap (mapW*scrW-1, mapH*scrH-1)

fOut = FreeFile
Open Command (6) For Binary As #fOut

Print "Opening input file"

fIn = FreeFile
Open Command (5) For Input As #fIn

Print "Fetching start of map array"

skipToStringPattern fIn, "unsigned char mapa [] = {"

Print "Parsing data for " & maxPants & " rooms."

For yP = 0 To mapH - 1
	For xP = 0 To mapW - 1
		Print "Reading & parsing screen " & (yP*mapW+xP)
		Do
			Line Input #fIn, auxStr
			extractListOfNumbers auxStr, numbers (), parsed
		Loop Until parsed = 150 Or Eof (fIn)
		If Eof (fIn) Then Print "something went incredibly wrong! (packed map?)": End
		x = 0: y = 0: For i = 0 To 149
			bigMap (xP*15+x,yP*10+y) = numbers (i)
			x = x + 1: If x = 15 Then x = 0: y = y + 1
		Next i
	Next xP
Next yP

Print "Writing map"
For y = 0 To mapH*scrH-1
	For x = 0 To mapW*scrW-1
		Put #fOut, , bigMap (x,y)
	Next x
Next y
Print "DONE!"

Close
