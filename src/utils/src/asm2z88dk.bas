' asm2z88dk v0.1 20200120
' prepares a standard .asm file to be included in a z88dk C project
' Copyleft 2020 by The Mojon Twins

Sub usage
	Print "$ asm2z88dk.exe in.asm out.h [mk1]"
	Print
	Print "in.asm - standard assembly (pasmo)"
	Print "out.h - output filename"
	Print
	Print "This program:"
	Print " 1. Changes labels: to .labels"
	Print " 2. Adds #asm / #endasm"
	Print " 3. If mk1, removes DI/EI and stuff"
End Sub

Function getIndentation (s As String) As String
	Dim As String res, m
	Dim As Integer i

	res = ""
	For i = 1 To Len (s)
		m = Mid (s, i, 1)
		If m = " " Or m = Chr (9) Then 
			res = res & m
		Else
			Exit For
		End If
	Next i

	Return res
End Function

Dim As Integer noints
Dim As Integer fIn, fOut
Dim As String linea, whiteSpace, trimmed

If Command (2) = "" Then usage: End
noints = Command (3) = "mk1"

fIn = FreeFile
Open Command (1) For Input As #fIn
fOut = FreeFile
Open Command (2) For Output As #fOut

If noints Then
	Print #fOut, "// MTE MK1 (la Churrera) v5.0"
	Print #fOut, "// Copyleft 2010-2014, 2020 by the Mojon Twins"
	Print #fOut, ""
End If

Print #fOut, "#asm"

While Not Eof (fIn)
	Line Input #fIn, linea
	whiteSpace = getIndentation (linea)
	trimmed = Trim (linea, Any Chr (32) + Chr (9))
	
	If Right (trimmed, 1) = ":" And Instr (trimmed, Chr (32)) = 0 Then
		linea = whiteSpace & "." & Left (trimmed, Len (trimmed) - 1)
	ElseIf noints Then
		If Lcase (trimmed) = "ei" Or Lcase (trimmed) = "di" Then 
			linea = whiteSpace & ";" & trimmed
		End If		
	End If

	Print #fOut, linea
Wend

Print #fOut, "#endasm"
Print #fOut, ""

Close
