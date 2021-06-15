' Imanol v0.3.20200604
' Copyleft 2015,2020 by The Mojon Twins

' Compile with fbc imanol.bas cmdlineparser.bas

#include "file.bi"
#include "cmdlineparser.bi"

Sub usage
	Print "usage:"
	Print 
	Print "$ imanol.exe in=infile.txt out=outfile.txt key=value ... "
	Print
	Print "Parameters to imanol.exe are specified as key=value, where keys are "
	Print "as follow:"
	Print ""
	Print "in             Input filename with %%%find%%% parameters."
	Print "out            Output filename."
	Print "key            %%%find%%% parameter to search for and be replaced by value"
	Print ""
	Print "If the value starts with '?', the actual text which is written is the result"
	Print "of a simple summatory expresion as in ?V1+V2+V3+... where Vn can be either a"
	Print "number or a filename. If Vn is a filename, the value summed is the file size."
	Print 
	Print "If you don't know what's this for, you don't need it."
End Sub

Function myFileLen (fileName As String) As Integer
	Dim As uInteger fTemp, length
	fTemp = FreeFile
	Open fileName For Binary As fTemp
	length = Lof (fTemp)
	Close fTemp
	myFileLen = length
End Function

Function getParmVal (parm As String) As Integer
	Dim As uInteger result
	result = Val (parm)
	If result = 0 Then 
		If FileExists (parm) Then result = myFileLen (parm)
	End If
	getParmVal = result
End Function

' Variables

Dim As Integer fIn, fOut, cpos, from, cto, offset, filel, result, ccpos, i, lastOp, quotes
Dim As String linea
Dim As String leftTrim, rightTrim, find, replace, portn, m

' GO!

Print "imanol v0.3.20200604"
Print "Pattern Find And Replace Preprocessor"
Print ""

' Get command line parameters parsed.
sclpParseAttrs

If sclpGetValue ("in") = "" Or sclpGetValue ("out") = "" Then
	usage
	End
End If

Print "Reading " & sclpGetValue ("in")
Print "Writing " & sclpGetValue ("out")

fIn = FreeFile
Open sclpGetValue ("in") For Input As #fIn
fOut = FreeFile
Open sclpGetValue ("out") For Output As #fOut

While Not Eof (fIn)
	Line Input #fIn, linea

	' Find pattern
	cpos = 1
	
	While cpos > 0
		from = Instr (cpos, linea, "%%%")
		If from = 0 Then Exit While
		
		cto = Instr (from + 3, linea, "%%%")
		If cto = 0 Then Exit While
		
		If from > 1 Then
			leftTrim = left (linea, from - 1)
		Else
			leftTrim = ""
		End If
		
		If Len (linea) >= cto + 3 Then
			rightTrim = right (linea, len (linea) - cto - 2)
		Else
			rightTrim = ""
		End If
		
		find = Mid (Linea, from + 3, cto - from - 3)
		
		Print "    Found %%% pattern " & find
		
		replace = sclpGetValue (find)
		If replace = "" Then
			Print "    Replacing for nothing, undefined!"
		Else
			If Left (replace, 1) = "?" Then
				replace = Right (replace, Len (replace) - 1)
				lastOp = 0
				
				' Parse (simple, tokenize by +, -)
				' New: Understands QUOTES
				result = 0
				quotes = 0
				replace = replace & "+"
				portn = ""
				For i = 1 To Len (replace)
					m = Mid (replace, i, 1)
					If m = Chr(34) Or m = "'" Then
						If quotes Then quotes = 0 Else quotes = -1
					ElseIf Not quotes And (m = "+" Or m = "-") Then
						If lastOp = 0 Then 
							result = result + getParmVal (portn)
						Else
							result = result - getParmVal (portn)
						End If
						If m = "+" Then lastOp = 0 Else lastOp = 1
						portn = ""
					Else
						portn = portn + m
					End If
				Next i
				
				Print "    Replacing with expression; result = " & result
				replace = Str (result)
			Else
				Print "    Replacing with  " & replace
			End If
		End If
		
		linea = leftTrim + replace + rightTrim
		
		cpos = from
	Wend
	
	Print #fOut, linea
Wend

Close fIn, fOut
