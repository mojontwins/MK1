' ene2bin_mk1.bas v0.1.20171003

Sub usage
	Print "$ ene2bin_mk1.exe enems.ene enems+hotspots.bin life_gauge [2bytes]"
	Print
	Print "The 2bytes parameter is for really old .ene files which"
	Print "stored the hotspots 2 bytes each instead of 3 bytes."
	Print "As a rule of thumb:"
	Print ".ene file created with ponedor.exe -> 3 bytes."
	Print ".ene file created with colocador.exe for MK1 -> 2 bytes."
End Sub

Dim As Integer use2bytes
Dim As Integer fIn, fOut, i, j, mapPants
Dim As uByte d, mapW, mapH, nEnems
Dim As uByte t, a, b, xx, yy, mn, x, y, s1, s2, xy, life
Dim As Integer typeCounters (255)
Dim As Integer enTypeCounters (255)
Dim As String Dummy

If Command (3) = "" Then usage: End

For i = 0 To 255
	enTypeCounters (i) = 0
	typecounters (i) = 0
Next i

use2bytes = (Command (4) = "2bytes")

life = val (Command (3)): If life = 0 Then life = 1

fIn = FreeFile
Open Command (1) For Binary As #fIn
fOut = FreeFile
Open Command (2) For Binary As #fOut

' Header
dummy = Input (256, fIn)
Get #fIn, , d: mapW = d
Get #fIn, , d: mapH = d
Get #fIn, , d: Get #fIn, , d
Get #fIn, , d: nEnems = d

mapPants = mapW * mapH

For i = 1 To mapPants
	For j = 1 To nEnems
		Get #fIn, , t
		Get #fIn, , x
		Get #fIn, , y
		Get #fIn, , xx
		Get #fIn, , yy 
		Get #fIn, , mn
		Get #fIn, , s1
		Get #fIn, , s2

		enTypeCounters (t) = enTypeCounters (t) + 1

		d = 16*x: Put #fOut, , d
		d = 16*y: Put #fOut, , d
		d = 16*x: Put #fOut, , d
		d = 16*y: Put #fOut, , d
		d = 16*xx: Put #fOut, , d
		d = 16*yy: Put #fOut, , d
		d = mn * Sgn (xx - x): Put #fOut, , d
		d = mn * Sgn (yy - y): Put #fOut, , d
		d = t: Put #fOut, , d
		d = life: Put #fOut, , d

	Next j
Next i

For i = 0 To 255
	If (enTypeCounters (i) > 0 Or i <= 7) And i <> 4 Then
		'Print #fOut, "#define N_ENEMS_TYPE_" & i & " " & enTypeCounters (i)
	End If
Next i

For i = 1 To mapPants
	If use2bytes Then
		Get #fIn, , xy
		Get #fIn, , t
	Else
		Get #fIn, , x
		Get #fIn, , y
		Get #fIn, , t
		xy = (x Shl 4) Or (y And 15)
	End If

	typeCounters (t) = typeCounters (t) + 1

	d = xy: Put #fOut, , d
	d = t: Put #fOut, , d
	d = 1: Put #fOut, , d
Next i

For i = 0 To 255
	If typeCounters (i) <> 0 Or i < 8 Then
		'Print #fOut, "#define N_HOTSPOTS_TYPE_" & i & " " & typeCounters (i)
	End If
Next i

Close
