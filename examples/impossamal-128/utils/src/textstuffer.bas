' Textstuffer 

Sub usage
	Print "usage:"
	Print "$ textstuffer in.txt out.bin wordwrap [offset]"
	Print
	Print "wordwrap = # of chars before a special % character"
	Print "will be inserted as line break."
	Print
	Print "Outputs 5-bit compressed strigns w/scapes."
End Sub

Dim as Integer fin, fout
Dim as Integer addresses (1024)
Dim as Integer address
Dim as uByte textBin (16384)
Dim as uByte textBinTemp (1024)
Dim as Integer index, memIndex, memIndexTemp, tlength, memIndexStart
Dim as String textLine, o, m, binaryString
Dim as integer i, j
Dim as Integer offset
Dim as uByte lsb, msb, nlines
Dim as uByte wordWrap
Dim as uByte x

If Len(Command(3)) = 0 Then usage: System
wordWrap = Val(Command(3))

kill (Command (2))

memIndex = 0
index = 0
address = 0

fin = freefile
Open Command (1) For Input as #fin

While Not Eof (fin)
	Line Input #fin, textLine
	textLine = Ucase (Trim (textLine))
	
	addresses (index) = address
	
	x = 0: o = "": textLine = textLine + " "
	nlines = 1
	tlength = 0
	
	memIndexTemp = 1
	For i = 1 To Len (textLine)
		m = mid (textLine, i , 1)
		if m = " " then
			if x + len (o) >= wordwrap then
				textBinTemp (memIndexTemp - 1) = Asc ("%")
				x = 0
				nlines = nlines + 1	
			end if
			For j = 1 to len (o)
				textBinTemp (memIndexTemp) = asc (Mid (o, j, 1))
				memIndexTemp = memIndexTemp + 1
				
			Next j
			x = x + len (o)
			if x = wordWrap then
				x = 0
				nlines = nlines + 1	
			else
				if i <> len(textLine) then
					textBinTemp (memIndexTemp) = 32
					memIndexTemp = memIndexTemp + 1 
					
					x = x + 1
				end if
			end if
			o = ""
		else
			o = o + m
		end if
	next i
	textBinTemp (memIndexTemp) = 0
	textBinTemp (0) = nlines
	
	' pack bits
	binaryString = Bin (textBinTemp (0), 5)
	'? binaryString
	For i = 1 to memIndexTemp
		j = textBinTemp (i)
		if j <> 0 And (j < 32 Or j > 95) Then j = Asc ("[")
		
		If j = 0 Then
			binaryString = binaryString + "00000"
		ElseIf j = 32 Then
			binaryString = binaryString + Bin (Asc ("["), 5)
		ElseIf j < 64 Then
			' add 31 & j - 32
			binaryString = binaryString + "11111" + Bin (j - 32, 5)
		Else
			' add j - 64
			binaryString = binaryString + Bin (j - 64, 5)
		End If
	Next i
	
	If len (binaryString) Mod 8 <> 0 Then
		binaryString = binaryString + String (8 - (len (binaryString) Mod 8), "0")
	End If
	
	For i = 1 to len (binaryString) Step 8
		textBin (memIndex) = Val ("&B" & mid (binaryString, i, 8))
		'? mid (binaryString, i, 8) & "=" & Hex (textBin (memIndex), 2);" ";
		memIndex = memIndex + 1
		address = address + 1
		
	Next i
'?:?	
	index = index + 1
	
Wend

Close #fin

' Fix addresses
''offset = 49152 + index * 2
if Command (4) <> "" Then offset = Val (Command (4)) + index * 2 else offset = index * 2
For i = 0 to index - 1
	addresses (i) = addresses (i) + offset
next i

fout = freefile
Open Command (2) For Binary as #fout

' Write addresses
For i = 0 to index - 1
	lsb = addresses (i) Mod 256
	msb = addresses (i) Shr 8
	put #fout,,lsb
	put #fout,,msb
next i

' Write binary
For i = 0 To memIndex - 1
	put #fout,,textBin(i)
Next i

Close fout
