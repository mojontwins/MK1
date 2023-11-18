#include "file.bi"
#include "fbpng.bi"
#include "fbgfx.bi"
#include once "crt.bi"

#define RGBA_R( c ) ( CUInt( c ) Shr 16 And 255 )
#define RGBA_G( c ) ( CUInt( c ) Shr  8 And 255 )
#define RGBA_B( c ) ( CUInt( c )        And 255 )
#define RGBA_A( c ) ( CUInt( c ) Shr 24         )

Function speccyColour (colour As Unsigned Long) As uByte
	Dim res as uByte
	If RGBA_R (colour) >= 128 Then 
		res = res Or 2
		If RGBA_R (colour) >= 220 Then
			res = res Or 64
		End If
	End If
	If RGBA_G (colour) >= 128 Then 
		res = res Or 4
		If RGBA_G (colour) >= 220 Then
			res = res Or 64
		End If
	End If
	If RGBA_B (colour) >= 128 Then 
		res = res Or 1
		If RGBA_B (colour) >= 220 Then
			res = res Or 64
		End If
	End If
	speccyColour = res
End Function

Type colourPair
	c1 as integer
	c2 as integer
End Type

Dim as uByte scrOut (6911)
Dim As Any Ptr img
Dim As Integer x, y, i, j, third, lineInChar, charLine, column, idx, c1, c2, b, thirds, tc, numbytes, pc1, pc2
Dim As uByte c
Dim cpBuff (23, 31) as colourPair

Sub usage	
	Print "usage:"
	Print ""
	Print "$ png2scr.exe img.png img.scr [thirds]"
	Print "   * img.png is a 256x192 image, speccy formatted"
	Print "   * img.scr is the converted, output file"
	Print "   * [thirds] = 1, 2, 3; don't include for full image+attrs"
End Sub

Print "png2scr v0.2.20191119 ~ ";

If Len (Command (1)) = 0 Or Len (Command (2)) = 0 Then
	usage
	End
End If

If Len (Command (3)) = 0 then 
	thirds = 0: tc = 3
else
	thirds = val(Command (3))
	if thirds > 3 then 
		usage
		end
	end if
	tc = thirds
end if

Print "Reading ~ ";

screenres 640, 480, 32, , -1
img = png_load (Command (1))

Printf ("Converting ~ ")

pc1 = 99: pc2 = 99
For y = 0 to 23
	For x = 0 to 31
		c1 = speccyColour (Point (x * 8, y * 8, img))
		For i = 0 to 7
			For j = 0 to 7
				c2 = speccyColour (Point (x * 8 + i, y * 8 + j, img))
				If c2 <> c1 Then Exit For
			Next j
			If c2 <> c1 Then Exit For
		Next i
		
		If c1 = c2 then
			if pc2 = c2 then
				c1 = pc1
			else 
				if (c1 and 63) < 4 then
					c1 = 7
					if (c2 and 64) then c1 = c1 + 64
				else
					c1 = 0
					if (c2 and 64) then c1 = c1 + 64
				end if
			end if
		End If

		If (c1 and 63) < (c2 and 63) Then Swap c1, c2
		
		cpBuff (y, x).c1 = c1
		cpBuff (y, x).c2 = c2
		
		pc1 = c1: pc2 = c2
	Next x
Next y

numbytes = 0

printf ("Writing bitmap ~ ")

idx = 0
For third = 0 To 2
	For lineInChar = 0 To 7
		For charLine = 0 To 7
			For column = 0 To 31
				c = 0
				x = 8 * column
				y = third * 64 + lineInChar + charLine * 8
				c1 = cpBuff (y \ 8, x \ 8).c1
				c2 = cpBuff (y \ 8, x \ 8).c2
				For i = 0 To 7
					If speccyColour (Point (x + i, y, img)) = c1 Then c = c + (1 Shl (7 - i))
				Next i
				scrOut (idx) = c
				idx = idx + 1
			Next column
		Next charLine
	Next lineInChar
Next third

if thirds = 0 then
	printf ("Writing attributes ~ ")
	For y = 0 To 23
		For x = 0 To 31
			c1 = cpBuff (y, x).c1
			c2 = cpBuff (y, x).c2
			if (c1 And 64) Or (c2 And 64) then b = 1 else b = 0
			c1 = c1 And 63
			c2 = c2 And 63
			scrOut (idx) = c1 + 8 * c2 + 64 * b
			idx = idx + 1
		Next x
	Next y
end if

Open Command (2) For Binary As #1
if thirds = 0 then 
	numbytes = 6912
else
	numbytes = 2048 * thirds
end if

For i = 0 To numbytes - 1
	Put #1, , scrOut (i)
Next i
Close #1
Puts ("DONE")
