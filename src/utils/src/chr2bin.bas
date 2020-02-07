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
	Print "$ chr2bin charset.png charset.bin n [defaultink|noattrs]"
	Print
	Print "where:"
	Print "   * charset.png is a 256x64 file with max. 256 chars."
	Print "   * charset.bin is the output, 2304/2048 bytes bin file."
	Print "   * n how many chars, 1-256"
	Print "   * defaultink: a number 0-7. Use this colour as 2nd colour if there's only"
	Print "     one colour in a 8x8 cell"
	Print "   * noattrs: just outputs the bitmaps. Omit and you get 256 chars nonetheless"
End Sub

' VARS.

Dim As Byte flag, is_packed
Dim As integer i, j, x, y, xx, yy, f, fout, idx, byteswritten, totalsize, iniByte, finByte, noattrs, charCount
Dim As uByte d
Dim As String levelBin
Dim As Any Ptr img
Dim As uByte tileset (2303)

' DO

Print "chr2bin v0.4 20200119 ~ ";

If Len (Command (3)) = 0 Then usage: End

charCount = Val (Command (3)): If charCount = 0 Then usage: End

If Command (4) = "" Then defaultInk = -1 Else defaultInk = Val (Command (4))
noattrs = (Command (4) = "noattrs") 

levelBin = Command (2)

screenres 640, 480, 32, , -1

Kill levelBin
fout = FreeFile
Open levelBin for Binary as #fout

'' *************
'' ** TILESET **
'' *************

' Puts ("building tileset")


printf ("Reading charset ~ ")
img = png_load (Command (1))	
idx = 0 
For y = 0 To 7
	For x = 0 To 31
		if (idx < charCount) Then
			getUDGIntoCharset img, x * 8, y * 8, tileset (), idx
			idx = idx + 1
		End If
	Next x
Next y
iniByte = 0

If noattrs Then finByte = idx*8-1 Else finByte = 2303

For i = iniByte To finByte
	d = tileset (i)
	put #fout, , d
Next i
Puts (" " & (finByte - iniByte + 1) & " bytes written")

Close
