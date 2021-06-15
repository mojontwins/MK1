' Tileset to bin

#include "file.bi"
#include "fbpng.bi"
#include "fbgfx.bi"
#include once "crt.bi"

#define RGBA_R( c ) ( CUInt( c ) Shr 16 And 255 )
#define RGBA_G( c ) ( CUInt( c ) Shr  8 And 255 )
#define RGBA_B( c ) ( CUInt( c )        And 255 )
#define RGBA_A( c ) ( CUInt( c ) Shr 24         )

Dim Shared As Integer defaultInk

Function speccyColour (colour As Unsigned Long) As uByte
	Dim res as uByte
	If RGBA_R (colour) >= 128 Then 
		res = res Or 2
		If RGBA_R (colour) >= 240 Then
			res = res Or 128
		End If
	End If
	If RGBA_G (colour) >= 128 Then 
		res = res Or 4
		If RGBA_G (colour) >= 240 Then
			res = res Or 128
		End If
	End If
	If RGBA_B (colour) >= 128 Then 
		res = res Or 1
		If RGBA_B (colour) >= 240 Then
			res = res Or 128
		End If
	End If
	speccyColour = res
End Function

Sub getUDGIntoCharset (img As Any Ptr, x0 As integer, y0 As Integer, tileset () As uByte, idx As Integer)
	Dim As Integer x, y
	Dim As uByte c1, c2, b, c, attr
	Dim As String o
	
	' First: detect colours
	c1 = speccyColour (Point (x0, y0, img))
	c2 = c1
	For y = 0 To 7
		For x = 0 To 7
			c = speccyColour (Point (x0 + x, y0 + y, img))
			If c <> c1 Then c2 = c
		Next x
	Next y
	' Detect bright:
	b = 0
	If c1 And 128 Then b = 64: c1 = c1 And 127
	If c2 And 128 Then b = 64: c2 = c2 And 127
	If c1 = c2 Then 
		If defaultInk <> -1 Then
			c1 = defaultInk
		Else 
			If c2 < 4 Then
				c1 = 7
			Else 
				c1 = 0
			End If
		End If
	end if
	' Darker colour = PAPER (c2)
	If c2 > c1 Then Swap c1, c2
	' Build attribute
	attr = b + 8 * c2 + c1
	' Write to array
	tileset (2048 + idx) = attr

	o = Hex (idx, 2) & " [" & Hex(attr, 2) & "] -->"
	
	' Now build	& write bitmap
	For y = 0 To 7
		b = 0
		For x = 0 To 7
			c = speccyColour (Point (x0 + x, y0 + y, img)) And 127
			If c = c1 Then b = b + 2 ^ (7- x)
		Next x
		tileset (8 * idx + y) = b
		o = o & Hex (b, 2) & " "
	Next y
	' Puts (o)
End Sub

Function getBitPattern (img As Any Ptr, x0 As Integer, y0 As Integer) as uByte
	Dim as uByte x, c, res
	res = 0
	For x = 0 To 7
		If speccyColour(Point (x0 + x, y0, img)) <> 0 Then res = res + 2 ^ (7 - x)
	Next x
	getBitPattern = res
End Function

Sub usage
	Print "Usage: "
	Print 
	Print "$ ts2bin font.png/nofont work.png|notiles|blank ts.bin defaultink"
	Print
	Print "where:"
	Print "   * font.png is a 256x16 file with 64 chars ascii 32-95"
	Print "     (use 'nofont' if you don't want to include a font & gen. 192 tiles)"
	Print "   * work.png is a 256x48 file with your 16x16 tiles"
	Print "     (use 'notiles' if you don't want to include a tileset & gen. 64 tiles)"
	Print "     (use 'blank' if you want to generate a 100% blank placeholder tileset)"
	Print "   * ts.bin is the output, 2304 bytes bin file."
	Print "   * defaultink: a number 0-7. Use this colour as 2nd colour if there's only"
	Print "     one colour in a 8x8 cell"
End Sub

' VARS.

Dim As Byte flag, is_packed
Dim As integer i, j, x, y, xx, yy, f, fout, idx, byteswritten, totalsize, iniByte, finByte
Dim As uByte d
Dim As String levelBin
Dim As Any Ptr img
Dim As uByte tileset (2303)

' DO

Print "ts2bin v0.4 20200119 ~ ";

If Len (Command (3)) = 0 Then
	usage
	End
End If

If Len (Command (4)) = 0 Then defaultInk = -1 Else defaultInk = Val (Command (4))

levelBin = Command (3)

screenres 640, 480, 32, , -1
Kill levelBin

fout = FreeFile
Open levelBin for Binary as #fout

'' *************
'' ** TILESET **
'' *************

' Puts ("building tileset")


If command (1) <> "nofont" then
	printf ("Reading font ~ ")
	img = png_load (Command (1))	
	idx = 0 
	For y = 0 To 1
		For x = 0 To 31
			getUDGIntoCharset img, x * 8, y * 8, tileset (), idx
			idx = idx + 1
		Next x
	Next y
	iniByte = 0
Else
	iniByte = 64*8
End If

If command (2) <> "notiles" then
	If command (2) = "blank" then
		img = ImageCreate (256, 48, 0, 32)
	Else
		printf ("reading metatiles ~ ")
		img = png_load (Command (2))	
	End If
	x = 0: y = 0: idx = 64
	For i = 0 to 47
		getUDGIntoCharset img, x, y, tileset (), idx: idx = idx + 1
		getUDGIntoCharset img, x + 8, y, tileset (), idx: idx = idx + 1
		getUDGIntoCharset img, x, y + 8, tileset (), idx: idx = idx + 1
		getUDGIntoCharset img, x + 8, y + 8, tileset (), idx: idx = idx + 1
		x = x + 16: If x = 256 Then x = 0: y = y + 16		
	Next i	
	finByte = 2303
Else 
	finByte = 64*8-1
End If

For i = iniByte To finByte
	d = tileset (i)
	put #fout, , d
Next i
Puts (" " & (finByte - iniByte + 1) & " bytes written")

Close
