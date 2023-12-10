Sub usage
	Print "USO"
	Print "downgrademap mapa.map t0 t1 t4 t8 t9"
	Print "donde tN es el tile por el que remplazar los de tipo N"
End Sub

Dim As Integer behaviours (47)
Dim As String behaviourString
Dim As Integer f1, f2, i
Dim As uByte changeTile (9)
Dim As uByte d, dout

f1 = Freefile
Open "behaviours.txt" For Input as #f1
Line Input #f1, behaviourString
Close #f1

For i = 1 To Len (behaviourString)
	behaviours (i - 1) = Val (Mid (behaviourString, i, 1))
Next i

If Command (1) = "" Or Command (2) = "" Or Command (3) = "" Or _
	Command (4) = "" Or Command (5) = "" Or Command (6) = "" Then
	usage ()
	End
End If

changeTile (0) = Val (Command (2))
changeTile (1) = Val (Command (3))
changeTile (2) = Val (Command (3))
changeTile (4) = Val (Command (4))
changeTile (8) = Val (Command (5))
changeTile (9) = Val (Command (6))

Open Command (1) For binary as #f1
f2 = Freefile
Open "out.map" For binary as #f2

While Not Eof (f1)
	Get #f1, , d
	dout = changeTile (behaviours (d))
	Put #f2, , dout
Wend

Close #f2
Close #f1
