Sub Usage
	Print "flipenems in.h out.h width height [horz] [vert]"
	?
	Print "in.h           Input"
	Print "out.h          Output"
	Print "width, height  Map size in screens"
	Print "horz           Flip horizontally"
	Print "vert           Flip vertically"
	Print
End Sub

Function fixHotSpots (flipHorz as Integer, flipVert as Integer, enemsLine as String) As String
	' Tokenize
	' 0  1  2
	' xy t  a
	Dim As String words (10), m, outputLine
	Dim As Integer idx, i, values (10), x, y
	idx = 0
	For i = 1 To Len (enemsLine)
		m = Mid (enemsLine, i, 1)
		if m = "," Or m="}" then
			if words(idx) <> "" Then
				values (idx) = Val (words (idx))
				idx = idx + 1
			end if
		elseif (m >= "0" And m <= "9") Or m ="-" then
			words (idx) = words (idx) & m
		end if
	Next i
	
	x = values (0) ShR 4
	y = values (0) And 15
	
	' Flip x
	If flipHorz Then
		x = 14 - x
	End If
	
	' Flip y
	If flipVert Then
		y = 9 - y
	End If
	
	values (0) = (x ShL 4) + y
	
	' Build line
	outputLine = "    {"
	For i = 0 To 2
		outputLine = outputLine & Str (values (i))
		If i < 2 Then outputLine = outputLine & ","
	Next i
	outputLine = outputLine & "},"
	
	Return outputLine
End Function

Function fixEnems (flipHorz As Integer , flipVert As Integer, enemsLine As String) As String
	' Tokenize
	' 0 1 2  3  4  5  6  7  8
	' x y x1 y1 x2 y2 mx my t
	Dim As String words (10), m, outputLine
	Dim As Integer idx, i, values (10)
	idx = 0
	For i = 1 To Len (enemsLine)
		m = Mid (enemsLine, i, 1)
		if m = "," Or m="}" then
			if words(idx) <> "" Then
				values (idx) = Val (words (idx))
				idx = idx + 1
			end if
		elseif (m >= "0" And m <= "9") Or m ="-" then
			words (idx) = words (idx) & m
		end if
	Next i
	
	if values(8) <> 0 Then
	
		' Flip x
		If flipHorz Then
			values (0) = 224 - values (0)
			values (2) = 224 - values (2)
			values (4) = 224 - values (4)
			values (6) = -values (6)
		End If
		
		' Flip y
		If flipVert Then
			values (1) = 144 - values (1)
			values (3) = 144 - values (3)
			values (5) = 144 - values (5)
			values (7) = -values (7)
		End If
		
	End If
	
	' Build line
	outputLine = "    {"
	For i = 0 To 8
		outputLine = outputLine & Str (values (i))
		If i < 8 Then outputLine = outputLine & ","
	Next i
	outputLine = outputLine & "},"
	
	Return outputLine
End Function

Const CRLF = Chr(13,10)

Dim As String mapInFn, mapOutFn
Dim As Byte d
Redim As String map (0, 0), mapOut (0, 0)
Redim As String hs (0, 0), hsOut (0, 0)
Dim As String progPrefix, progInfix, progSufix, readLine, curScrEnems
Dim As Integer mapWidth, mapHeight, flipHorz, flipVert
Dim As Integer x, y, f1

mapInFn = Command (1)
mapOutFn = Command (2)
mapWidth = Val (Command (3))
mapHeight = Val (Command (4))

If Command (5) = "horz" Or Command (6) = "horz" then flipHorz = -1 Else flipHorz = 0
If Command (6) = "vert" Or Command (5) = "vert" then flipVert = -1 Else flipVert = 0

If mapInFn = "" Or mapOutFn = "" Or mapWidth = 0 Or mapHeight = 0 Or (flipHorz = 0 And flipVert = 0) Then
	Usage
	End
End If

' Wtf
Redim map (mapHeight - 1, mapWidth - 1)
Redim mapOut (mapHeight - 1, mapWidth - 1)
Redim hs (mapHeight - 1, mapWidth - 1)
Redim hsOut (mapHeight - 1, mapWidth - 1)

' Read in
f1 = FreeFile
Open mapInFn For Input as #f1

' Read prefix
progPrefix = ""
Do
	Line Input #f1, readLine
	progPrefix = progPrefix & readLine & CRLF
Loop Until trim (readLine) = "MALOTE malotes [] = {"

' Read malote data
For y = 0 To mapHeight - 1
	For x = 0 To mapWidth - 1
		Line Input #f1, readLine
		curScrEnems = fixEnems(flipHorz, flipVert, readLine) + CRLF
		Line Input #f1, readLine
		curScrEnems = curScrEnems + fixEnems(flipHorz, flipVert, readLine) + CRLF
		Line Input #f1, readLine
		curScrEnems = curScrEnems + fixEnems(flipHorz, flipVert, readLine)
		map (y, x) = curScrEnems
	Next x
Next y

' Read infix
progInfix = ""
Do
	Line Input #f1, readLine
	progInfix = progInfix & readLine & CRLF
Loop Until trim (readLine) = "HOTSPOT hotspots [] = {"

' Read hotspot data
For y = 0 To mapHeight - 1
	For x = 0 To mapWidth - 1
		Line Input #f1, readLine
		hs (y, x) = fixHotSpots(flipHorz, flipVert, readLine)
	Next x
Next y

' Read sufix
progSufix = ""
Do
	Line Input #f1, readLine
	progSufix = progSufix & readLine & CRLF
Loop While Not Eof (f1)

Close f1

' Flip horz
If flipHorz Then
	For y = 0 To mapHeight - 1
		For x = 0 To mapWidth - 1
			mapOut (y, x) = map (y, mapWidth - 1 - x)
			hsOut (y, x) = hs (y, mapWidth - 1 - x)
		Next x
	Next y
	For y = 0 To mapHeight - 1
		For x = 0 To mapWidth - 1
			map (y, x) = mapOut (y, x)
			hs (y, x) = hsOut (y, x)
		Next x
	Next y
End If

' Flip vert
If flipVert Then
	For y = 0 To mapHeight - 1
		For x = 0 To mapWidth - 1
			mapOut (y, x) = map (mapHeight - 1 - y, x)
			hsOut (y, x) = hs (mapHeight - 1 - y, x)
		Next x
	Next y
End If

' Write out
f1 = Freefile
Open mapOutFn For Output as #f1
Print #f1, progPrefix
For y = 0 To mapHeight - 1
	For x = 0 To mapWidth - 1
		Print #f1, mapOut (y, x)
	Next x
Next y
Print #f1, progInfix
For y = 0 To mapHeight - 1
	For x = 0 To mapWidth - 1
		Print #f1, hsOut (y, x)
	Next x
Next y
Print #f1, progSufix
Close #f1 
