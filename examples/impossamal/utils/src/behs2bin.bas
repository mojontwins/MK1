' Enems to bin
#include "file.bi"
#include once "crt.bi"


Sub usage
	puts ("behs2bin 0.1")
	puts ("usage")
	puts ("")
	puts ("$ behs2bin behs.txt behs.bin")
	Puts ("")
	Puts ("where:")
	Puts ("   * behs.txt behaviours file")
	Puts ("   * behs.bin output binary file")
End Sub

Type EnemyIn
	t As uByte
	x As uByte
	y As uByte
	xx As uByte
	yy As uByte
	n As uByte
	s1 As uByte
	s2 As uByte
End Type

Dim As Byte flag, is_packed
Dim As integer i, j, x, y, xx, yy, f, fout, idx, byteswritten, totalsize
Dim As uByte d, life, numlocks
Dim As Byte sd
Dim As integer map_w, map_h, tile_lock, max
ReDim As uByte map_data (0, 0)
Dim As uByte whole_screen (149)
Dim As String levelBin
Dim As Any Ptr img
Dim As uByte tileset (2303)
Dim As String dummy
Dim As EnemyIn e


' DO

If Len (Command (1)) = 0 Or Len (Command (2)) = 0 Then
	usage
	End
End If


fout = FreeFile
Open Command (2) for Binary as #fout
Puts ("reading behaviours")
Puts ("    Behaviours file = " & Command (1))
f = Freefile
byteswritten = 0
Open Command (1) For Input as #f
	For i = 1 To 3	
		dummy = "    "
		For j = 1 To 16
			Input #f, d
			Put #fout, , d
			dummy = dummy & hex (d, 2) & " "
			byteswritten = byteswritten + 1
		Next j
		Puts (dummy)
	Next i
Close #f
Puts ("    " & byteswritten & " bytes written.")
Puts ("")
totalsize = totalsize + byteswritten
Close
