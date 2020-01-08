#include "fbpng.bi"
#include "fbgfx.bi"
#include once "crt.bi"


#define RGBA_R( c ) ( CUInt( c ) Shr 16 And 255 )
#define RGBA_G( c ) ( CUInt( c ) Shr  8 And 255 )
#define RGBA_B( c ) ( CUInt( c )        And 255 )
#define RGBA_A( c ) ( CUInt( c ) Shr 24         )

Sub WarningMessage ()
	Print "** WARNING **"
	Print "   SprCnv convierte los sprites en un PNG en formato churrera"
	Print "   código C usable directamente en el juego."
	Print "   CutreCode Disclaimer: este programa es cutrecode, esto significa"
	Print "   que si el PNG de entrada no tiene el formato churrera especificado"
	Print "   en la documentación, cosas divertidas pueden ocurrir."
	Print
End Sub

Sub Usage () 
	Print "** USO **"
	Print "   sprcnv2 archivo.png archivo.h n [nomask]"
	Print
End Sub

'
'
'

dim as any ptr img 			' will contain the image loaded from the PNG
dim as String filename, o
dim as integer i, j, f, sprite, x, y, xx, yy, ac, nomask, n
dim as unsigned long p1, p2

WarningMessage () 			' Esto lo quito algún día, cuando deje de ser cutrón

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
'	deallocate( img )
else
	print "Failed to load"
end if

' Ahora lo recorro y voy generando el código con sus etiquetas y
' sus mascaritas y toda la pesca

f = FreeFile

Open Command (2) for Output as f

print #f, "// Sprites.h"
print #f, "// Generado por SprCnv de la Churrera"
print #f, "// Copyleft 2010, 2013 The Mojon Twins"
if nomask then print #f, "// No masks"
print #f, " "

print #f, "extern unsigned char sprites [];"

print #f, " "

print #f, "#asm"

x = 0
y = 0

if nomask then
	for i = 0 to 7: print #f, "        defb 0": next i: print #f, " "
else
	for i = 0 to 7: print #f, "        defb 0, 255":next i: print #f, " "
endif

print #f, "._sprites"

If nomask then
	n = val (Command (3)) / 2
else
	n = val (Command (3))
end if

for sprite = 1 to n

	' Primera columna 
	
	'print #f, "    ._sprite_" + Trim (Str(Sprite)) + "_a"
	if nomask then
		print #f,"; Sprites #" & str ((sprite-1) * 2) & " y " & str ((sprite-1) * 2 + 1)
	else
		print #f,"; Sprite #" & str (sprite-1) &" y máscara"
	end if
	print #f,"; Primera columna"
	
	' Ahora tengo que calcular los dos valores de la primera columna
	for yy = 0 to 15
		o = "        defb "
		ac = 0
		for xx = 0 to 7
			p1 = point (x + xx, y + yy, img)
			if RGBA_R (p1) <> 0 Or RGBA_G (p1) <> 0 Or RGBA_B (p1) <> 0 Then
				ac = ac + 2 ^ (7 - xx)
			end if
		next xx
		o = o + Trim (Str(ac)) + ", "
		ac = 0
		for xx = 0 to 7
			p1 = point (x + xx + 16, y + yy, img)
			if RGBA_R (p1) <> 0 Or RGBA_G (p1) <> 0 Or RGBA_B (p1) <> 0 Then
				ac = ac + 2 ^ (7 - xx)
			end if
		next xx
		o = o + Trim (Str(ac))
		print #f, o
	next yy
	for yy = 0 to 7
		if nomask then 
			print #f, "        defb 0, 0"
		else
			print #f, "        defb 0, 255"
		end if
	next yy
	print #f, " "
	
	' Segunda columna 
	
	'print #f, "    ._sprite_" + Trim (Str(Sprite)) + "_b"
	print #f,"; Segunda columna"
	
	' Ahora tengo que calcular los dos valores de la primera columna
	for yy = 0 to 15
		o = "        defb "
		ac = 0
		for xx = 0 to 7
			p1 = point (x + xx + 8, y + yy, img)
			if RGBA_R (p1) <> 0 Or RGBA_G (p1) <> 0 Or RGBA_B (p1) <> 0 Then
				ac = ac + 2 ^ (7 - xx)
			end if
		next xx
		o = o + Trim (Str(ac)) + ", "
		ac = 0
		for xx = 0 to 7
			p1 = point (x + xx + 24, y + yy, img)
			if RGBA_R (p1) <> 0 Or RGBA_G (p1) <> 0 Or RGBA_B (p1) <> 0 Then
				ac = ac + 2 ^ (7 - xx)
			end if
		next xx
		o = o + Trim (Str(ac))
		print #f, o
	next yy
	for yy = 0 to 7
		if nomask then 
			print #f, "        defb 0, 0"
		else
			print #f, "        defb 0, 255"
		end if
	next yy
	print #f, " "
	
	' Tercera columna
	
	'print #f, "    ._sprite_" + Trim (Str(Sprite)) + "_c"
	print #f, "; tercera columna"
	for yy = 0 to 23
		if nomask then 
			print #f, "        defb 0, 0"
		else
			print #f, "        defb 0, 255"
		end if
	next yy
	print #f, " "
	
	x = x + 32
	if x = 256 then
		y = y + 16
		x = 0
	end if
	
next sprite

print #f, "#endasm"
print #f, " "

Close f

puts "¡Todo correcto!"