' Fix your own shit!

Const MAX_NUMBERS = 32

Sub usage
	Print "$ h2ene.exe mapa.map mappy.bmp map_w map_h scr_w scr_h nenems enems.h "
	Print "  enems.ene"
	Print
	Print "Where:"
	Print
	Print "* mapa.map mappy.bmp are the filenames of external media to be included in"
	Print "  the header of the generated enems.ene"
	Print "* map_w, map_h, scr_w, scr_h are map dimmensions."
	Print "* nenems are # of enems per screen"
	Print "* enems.h is the input filename."
	Print "* enems.ene is the output filename."
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

Dim As Integer mapW, mapH, scrW, scrH, nEnems, nPant, maxPants, maxEnems, i, j, x, y, fIn, fOut, parsed
Dim As Integer numbers (MAX_NUMBERS)
Dim As uByte d
Dim As String auxStr

Print "h2ene.exe - get an old churrera enems.h and creates suitable enems.ene"
Print
	
If Command (9) = "" Then usage: End

mapW = Val (Command (3))
mapH = Val (Command (4))
scrW = Val (Command (5))
scrH = Val (Command (6))
nEnems = Val (Command (7))
maxPants = mapW * mapH
maxEnems = maxPants * nEnems

fOut = FreeFile
Open Command (9) For Binary As #fOut

Print "Writing header..."

safeWriteStringToFile fOut, procrust (Command (1), 128)
safeWriteStringToFile fOut, procrust (Command (2), 128)
d = mapW: Put #fOut, , d
d = mapH: Put #fOut, , d
d = scrW: Put #fOut, , d
d = scrH: Put #fOut, , d
d = nEnems: Put #fOut, , d

Print "Opening input file"

fIn = FreeFile
Open Command (8) For Input As #fIn

Print "Fetching start of enems array"

skipToStringPattern fIn, "MALOTE malotes"

Print "Parsing data for " & maxEnems & " enems..."

j = 1
do
	Print "Reading . . ."
	Line Input #fIn, auxStr
	Print "Parsing: ";
	extractListOfNumbers auxStr, numbers (), parsed
	If parsed <> 9 Then 
		Print " not a data line."
	Else
		For i = 0 To parsed - 1: Print Lcase (Hex (numbers (i), 2)) & " ";: Next i
		' In:
		'  0   1   2   3   4   5   6   7   8
		'  x,  y, x1, y1, x2, y2, mx, my,  t
		' Out:
		' t, x, y, xx, yy, n, s1, s2
		Print "> S" & ((j-1)\maxPants) & "." & ((j-1) Mod 3) & ".";
		d = numbers (8): Print Lcase (Hex (d, 2)) & " ";: Put #fOut, , d
		d = numbers (2) \ 16: Print Lcase (Hex (d, 2)) & " ";: Put #fOut, , d
		d = numbers (3) \ 16: Print Lcase (Hex (d, 2)) & " ";: Put #fOut, , d
		d = numbers (4) \ 16: Print Lcase (Hex (d, 2)) & " ";: Put #fOut, , d
		d = numbers (5) \ 16: Print Lcase (Hex (d, 2)) & " ";: Put #fOut, , d
		i = Abs (numbers (6)): If i = 0 Then i = Abs (numbers (7))
		d = i: Print Lcase (Hex (d, 2)) & " ";: Put #fOut, , d
		Print "00 00"
		d = 0: Put #fOut, , d: Put #fOut, , d
		j = j + 1
	End If
Loop While j <= maxEnems

'Print

Print "Fetching start of hotspots array"

skipToStringPattern fIn, "HOTSPOT hotspots"

Print "Parsing data for " & maxPants & " hotspots..."

j = 1
do 
	Print "Reading . . ."
	Line Input #fIn, auxStr
	Print "Parsing: ";
	extractListOfNumbers auxStr, numbers (), parsed
	If parsed <> 3 Then 
		Print " not a data line."
	Else
		For i = 0 To parsed - 1: Print Lcase (Hex (numbers (i), 2)) & " ";: Next i
		' In:
		' 0  1  2
		' xy t act
		' Out: 	
		' x y tipo
		Print "> S" & (j-1) & ": ";
		d = numbers (0) Shr 4: Print Lcase (Hex (d, 2)) & " ";: Put #fOut, , d
		d = numbers (0) And 15: Print Lcase (Hex (d, 2)) & " ";: Put #fOut, , d
		d = numbers (1): Print Lcase (Hex (d, 2)) & " ": Put #fOut, , d
		j = j + 1
	End If	
	'Print Chr (13)
Loop While j <= maxPants Or Eof (fIn)

' Print
Print "DONE!"

Close #fIn, fOut
