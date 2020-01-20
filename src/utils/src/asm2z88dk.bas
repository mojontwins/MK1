' asm2z88dk v0.1 20200120
' prepares a standard .asm file to be included in a z88dk C project
' Copyleft 2020 by The Mojon Twins

#include "mtparser.bi"

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
	Dim As Integer i, l

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

Type EquType
	Dim As String ident 
	Dim As String subst
End Type

Dim As Integer noints
Dim As Integer fIn, fOut
Dim As String linea, whiteSpace, trimmed, m, prefix, sufix, number
Dim As Integer i, j, l, hasLabel, p, state
Dim As EquType equs(255)
Dim As Integer equIndex
Dim As String tokens (63)

If Command (2) = "" Then usage: End
noints = Command (3) = "mk1"

' Preprocess
fIn = FreeFile
Open Command (1) For Input As #fIn
While Not Eof (fIn)
	Line Input #fIn, linea
	parseTokenizeString linea, tokens (), "", ";"
	For i = 1 To 63
		If Lcase (tokens (i)) = "equ" Then
			If tokens (i - 1) <> "" Then
				If Right (tokens (i - 1), 1) = ":" Then tokens (i - 1) = Left (tokens (i - 1), Len (tokens (i - 1)) - 1)
				equs (equIndex).ident = tokens (i - 1)
				equs (equIndex).subst = tokens (i + 1)
				'print "EQU " & equIndex & " " & tokens (i - 1) & "->" & tokens (i + 1)
				equIndex = equIndex + 1
			End If
		End If
	Next i
Wend
Close fIn

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

	If lcase (trimmed) = "start:" Then
		trimmed = ".musicstart"
		linea = whiteSpace & trimmed
	End If

	If lCase (trimmed) = "play:" Then
		trimmed = ".sound_play"
		linea = whiteSpace & trimmed
	End If

	If Instr (lCase (trimmed), "equ") Then
		trimmed = ";" & trimmed 
		linea = whiteSpace & trimmed
	Endif

	' Find equs
	parseTokenizeString linea, tokens (), "", ";"
			
	linea = linea & " "
	For i = 0 To equIndex - 1
		p = Instr (lCase (linea), lCase (equs (i).ident))
		If p Then
			For j = p To Len (linea)
				m = Mid (linea, j, 1)
				If m = " " Or m = Chr (9) Then Exit For
			Next j
			Linea = Left (Linea, p-1) & equs (i).subst & Right (Linea, len (Linea) - j)
		End If
	Next i 
	linea = Rtrim (linea)

	' Identify labels
	hasLabel = 0
	For i = 1 To Len (trimmed) 
		m = Mid (trimmed, i, 1)
		If m = ":" Then hasLabel = -1: Exit For
		If Not ( _
			(m >= "A" And m <= "Z") Or _
			(m >= "a" And m <= "z") Or _
			(m = "_") Or _
			(m >= "0" And m <= "9") _
		) Then Exit For		
	Next i

	If (hasLabel) Then
		linea = whiteSpace & "." & Left (trimmed, i - 1) & Right (trimmed, Len (trimmed) - i)
	End If

	p = Instr (linea, "'")
	If p Then Mid (linea, p, 1) = " "

	If noints Then
		p = Instr (lcase (linea), "di")
		If p Then 
			If (Len (linea) = p + 1 Or _
			Instr (" " & Chr (9) & ";", Mid (linea, p + 2, 1))) _
			And (p = 1 Or _
			Instr (" " & Chr (9), Mid (linea, p - 1, 1))) _
			Then
				If p > 1 Then prefix = Left (linea, p - 1) Else prefix = ""
				If p < Len (linea) - 1 Then sufix = Right (linea, Len (linea) - p - 1) Else sufix = ""

				linea = prefix & ";di" & sufix
			End If
		End If

		p = Instr (lcase (linea), "ei")
		If p Then 
			If (Len (linea) = p + 1 Or _
			Instr (" " & Chr (9) & ";", Mid (linea, p + 2, 1))) _
			And (p = 1 Or _
			Instr (" " & Chr (9), Mid (linea, p - 1, 1))) _
			Then
				If p > 1 Then prefix = Left (linea, p - 1) Else prefix = ""
				If p < Len (linea) - 1 Then sufix = Right (linea, Len (linea) - p - 1) Else sufix = ""

				linea = prefix & ";ei" & sufix
			End If
		End If

		p = Instr (lcase (linea), "org")
		If p Then 
			If (Len (linea) = p + 2 Or _
			Instr (" " & Chr (9) & ";", Mid (linea, p + 3, 1)) > 0) _
			And (p = 1 Or _
			Instr (" " & Chr (9), Mid (linea, p - 1, 1)) > 0) _
			Then
				If p > 1 Then prefix = Left (linea, p - 1) Else prefix = ""
				If p < Len (linea) - 2 Then sufix = Right (linea, Len (linea) - p - 2) Else sufix = ""

				linea = prefix & ";org" & sufix
			End If
		End If
	End If

	' Fix $XX numbers, z88dk doesn't like them
	state = 0
	linea = linea & " "
	i = 1: l = Len (linea)
	While i <= l
		m = Mid (linea, i, 1)
		If state = 0 Then
			If m = "$" Then 
				state = 1: p = i: number = ""
			End If
		Else
			If (m >= "0" And m <= "9") Or (m >= "A" And m <= "F") Or (m >= "a" And m <= "f") Then
				number = number & m
			Else
				state = 0
				linea = Left (linea, p-1) & "0x" & number & Right (linea, Len (linea) - i + 1) 
				i = i + 1: l = l + 1
			End If
		End If
		i = i + 1
	Wend
	linea = Rtrim (linea)

	Print #fOut, linea
Wend

Print #fOut, "#endasm"
Print #fOut, ""

Close
