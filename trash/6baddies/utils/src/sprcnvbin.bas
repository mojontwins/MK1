#include "fbpng.bi"
#include "fbgfx.bi"
#include once "crt.bi"


#define RGBA_R( c ) ( CUInt( c ) Shr 16 And 255 )
#define RGBA_G( c ) ( CUInt( c ) Shr  8 And 255 )
#define RGBA_B( c ) ( CUInt( c )        And 255 )
#define RGBA_A( c ) ( CUInt( c ) Shr 24         )

Sub Usage () 
	Print "** USO **"
	Print "   sprcnvbin archivo.png archivo.bin n [nomask]"
	Print
	Print "Convierte un Spriteset (256 px. ancho) de n sprites de 16x16"
End Sub

'
'
'

dim as any ptr img 			' will contain the image loaded from the PNG
dim as String filename, o
dim as integer i, j, f, sprite, x, y, xx, yy, ac, nomask, n
dim as unsigned long p1, p2
dim as uByte d

If Len (Command (1)) = 0 Or Len (Command (2)) = 0 Or len (Command (3)) = 0 Then 
	Usage
	End
End If

If lcase(Command (4)) = "nomask" Then nomask = -1 else nomask = 0

' Primero cargo el archivo de imagen
screenres 640, 480, 32, , -1

filename = Command (1)
img = png_load ( filename )

if img then
'	put( 0, 0 ), img
else
	print "Failed to load"
end if

f = FreeFile

Open Command (2) for Binary As f

If nomask then
	n = val (Command (3)) / 2
else
	n = val (Command (3))
end if

for sprite = 1 to n

	' Primera columna 
	
	' Ahora tengo que calcular los dos valores de la primera columna
	for yy = 0 to 15
		ac = 0
		for xx = 0 to 7
			p1 = point (x + xx, y + yy, img)
			if RGBA_R (p1) <> 0 Or RGBA_G (p1) <> 0 Or RGBA_B (p1) <> 0 Then
				ac = ac + 2 ^ (7 - xx)
			end if
		next xx
		d = ac: Put #f, , d

		ac = 0
		for xx = 0 to 7
			p1 = point (x + xx + 16, y + yy, img)
			if RGBA_R (p1) <> 0 Or RGBA_G (p1) <> 0 Or RGBA_B (p1) <> 0 Then
				ac = ac + 2 ^ (7 - xx)
			end if
		next xx
		d = ac: Put #f, , d
	next yy

	for yy = 0 to 7
		d = 0: Put #f, , d
		if nomask then 
			Put #f, , d
		else
			d = 255: Put #f, , d
		end if
	next yy
	
	' Segunda columna 
	
	for yy = 0 to 15
		ac = 0
		for xx = 0 to 7
			p1 = point (x + xx + 8, y + yy, img)
			if RGBA_R (p1) <> 0 Or RGBA_G (p1) <> 0 Or RGBA_B (p1) <> 0 Then
				ac = ac + 2 ^ (7 - xx)
			end if
		next xx
		d = ac: Put #f, , d

		ac = 0
		for xx = 0 to 7
			p1 = point (x + xx + 24, y + yy, img)
			if RGBA_R (p1) <> 0 Or RGBA_G (p1) <> 0 Or RGBA_B (p1) <> 0 Then
				ac = ac + 2 ^ (7 - xx)
			end if
		next xx
		d = ac: Put #f, , d
	next yy

	for yy = 0 to 7
		d = 0: Put #f, , d
		if nomask then 
			Put #f, , d
		else
			d = 255: Put #f, , d
		end if
	next yy
	
	' Tercera columna
	
	for yy = 0 to 23
		d = 0: Put #f, , d
		if nomask then 
			Put #f, , d
		else
			d = 255: Put #f, , d
		end if
	next yy
	
	x = x + 32
	if x = 256 then
		y = y + 16
		x = 0
	end if
	
next sprite

Close f

puts "¡Todo correcto!"
