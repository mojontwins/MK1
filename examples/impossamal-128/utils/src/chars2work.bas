#include "fbpng.bi"
#include "fbgfx.bi"
#include once "crt.bi"

Sub Usage () 
	Print "~ Restores a 256x64 charset to a 256x48 tileset ~ usage"
	Print "$ chars2work in.png out.png"
	Print
End Sub

Dim As Any Ptr img, img2
Dim As Integer x, y, xx, yy, i

Print "chars2work.exe v0.1.20200212a"
If Command (2) = "" Then Usage: End

screenres 640, 480, 32, , -1

img = png_load (Command (1))
img2 = ImageCreate (256, 48)

x = 0: y = 16: xx = 0: yy = 0

For i = 0 To 47
	Put img2, (xx, yy), img, (x, y) - Step (7, 7), Pset
	Put img2, (xx + 8, yy), img, (x + 8, y) - Step (7, 7), Pset
	Put img2, (xx, yy + 8), img, (x + 16, y) - Step (7, 7), Pset
	Put img2, (xx + 8, yy + 8), img, (x + 24, y) - Step (7, 7), Pset

	x = x + 32: If x = 256 Then x = 0: y = y + 8
	xx = xx + 16: If xx = 256 Then xx = 0: yy = yy + 16
Next i

png_save (Command (2), img2)
puts "COOL!"
