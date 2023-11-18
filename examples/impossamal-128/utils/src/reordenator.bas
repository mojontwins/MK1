#include "fbpng.bi"
#include "fbgfx.bi"
#include once "crt.bi"


#define RGBA_R( c ) ( CUInt( c ) Shr 16 And 255 )
#define RGBA_G( c ) ( CUInt( c ) Shr  8 And 255 )
#define RGBA_B( c ) ( CUInt( c )        And 255 )
#define RGBA_A( c ) ( CUInt( c ) Shr 24         )

Sub Usage () 
	Print "** USO **"
	Print "   sprcnv in.png out.png"
	Print
End Sub

dim as any ptr img 			' will contain the image loaded from the PNG
dim as FB.Image ptr img2
dim as FB.Image ptr trasiego
dim as String filename1
dim as String filename2
dim as integer i, j, x, y, xx, yy, xxx, yyy

If Len (Command (1)) = 0 Or Len (Command (2)) = 0 Then 
	Usage
	End
End If

' Primero cargo el archivo de imagen
screenres 640, 480, 32, , -1

filename1 = Command (1)
img = png_load ( filename1 )
filename2 = Command (2)

if img then
'
else
	print "Failed to load"
end if

img2 = ImageCreate (256, 64)
trasiego = ImageCreate (16, 8)

x = 0
y = 0
xx = 0
yy = 0
for i = 0 To 63
	' Top Row
	for xxx = 0 To 15
		for yyy = 0 To 7
			pset img2, (xx + xxx, yy + yyy), point (x + xxx, y + yyy, img)
		next yyy
	next xxx
	xx = xx + 16
	
	' Bottom Row
	for xxx = 0 To 15
		for yyy = 0 To 7
			pset img2, (xx + xxx, yy + yyy), point (x + xxx, y + 8 + yyy, img)
		next yyy
	next xxx
	xx = xx + 16: if xx = 256 Then xx = 0: yy = yy + 8
	
	x = x + 16: if x = 256 Then x = 0: y = y + 16
next i

png_save( filename2, img2 )

puts "¡Todo correcto!"
