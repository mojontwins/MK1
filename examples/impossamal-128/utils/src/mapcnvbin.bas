' Map converter
' Cutrecode by na_th_an

' Estos programas son tela de optimizables, pero me da igual porque tengo un dual core.
' ¡OLE!

Sub WarningMessage ()
End Sub

sub usage () 
	Print "** USO **"
	Print "   MapCnvBin archivo.map archivo.bin ancho_mapa alto_mapa ancho_pantalla alto_pantalla tile_cerrojo [packed] [fixmappy]"
	Print
	Print "   - archivo.map : Archivo de entrada exportado con mappy en formato raw."
	Print "   - archivo.bin : Archivo de salida"
	Print "   - ancho_mapa : Ancho del mapa en pantallas."
	Print "   - alto_mapa : Alto del mapa en pantallas."
	Print "   - ancho_pantalla : Ancho de la pantalla en tiles."
	Print "   - alto_pantalla : Alto de la pantalla en tiles."
	Print "   - tile_cerrojo : N§ del tile que representa el cerrojo."
	Print "   - packed : Escribe esta opci¢n para mapas de la churrera de 16 tiles."
	Print "   - fixmappy : Escribe esta opci¢n para arreglar lo del tile 0 no negro"
	Print
	Print "Por ejemplo, para un mapa de 6x5 pantallas para MTE MK1:"
	Print
	Print "   MapCnvBin mapa.map mapa.bin 6 5 15 10 15 packed"
	Print
	Print "Output will contain the map, and then the bolts"
end sub

Function inCommand (spec As String) As Integer
	Dim As Integer res, i

	i = 0: res = 0

	Do
		If Command (i) = "" Then Exit Do
		If Command (i) = spec Then res = -1: Exit Do
		i = i + 1
	Loop

	Return res
End Function

Dim As Integer map_w, map_h, scr_w, scr_h, bolt
Dim As Integer x, y, xx, yy, i, j, f, packed, ct, b, fixmappy, totalBytes
Dim As uByte d, ac
Dim As String o

Type MyBolt
	np As Integer
	x As Integer
	y As Integer
End Type

Dim As MyBolt Bolts (100)

WarningMessage ()

if 	Command (1) = "" Or _
	Command (2) = "" Or _
	Val (Command (3)) <= 0 Or _
	Val (Command (4)) <= 0 Or _
	Val (Command (5)) <= 0 Or _
	Val (Command (6)) <= 0 Or _
	Val (Command (7)) <= 0 Then
	
	usage ()
	end
End If

map_w = Val (Command (3))
map_h = Val (Command (4))
scr_w = Val (Command (5))
scr_h = Val (Command (6))
bolt = Val (Command (7))

If InCommand ("packed") then
	packed = 1
else
	packed = 0
end if

If InCommand ("fixmappy") Then
	fixmappy = -1
Else
	fixmappy = 0
End If

Dim As Integer BigOrigMap (map_h * scr_h - 1, map_w * scr_w - 1)

' Leemos el mapa original

f = FreeFile
Open Command (1) for binary as #f

For y = 0 To (map_h * scr_h - 1)
	For x = 0 To (map_w * scr_w - 1)
		get #f , , d
		If fixmappy Then d = d - 1
		BigOrigMap (y, x) = d
	Next x
Next y

close f

' Construimos el nuevo mapa mientras rellenamos el array de cerrojos

open Command (2) for output as #f

i = 0:b = 0: totalBytes = 0

for yy = 0 To map_h - 1
	for xx = 0 To map_w - 1
		o = "    "
		ac = 0
		ct = 0
		for y = 0 to scr_h - 1
			for x = 0 to scr_w - 1
				
				if BigOrigMap (yy * scr_h + y, xx * scr_w + x) = bolt then
					Bolts (i).x = x
					Bolts (i).y = y
					Bolts (i).np = yy * map_w + xx
					i = i + 1
				end if
				
				if packed = 0 then
					d = BigOrigMap (yy * scr_h + y, xx * scr_w + x)
					Put #f, , d
					totalBytes = totalBytes + 1
				else
					if ct = 0 then
						ac = BigOrigMap (yy * scr_h + y, xx * scr_w + x) * 16
					else
						ac = ac + BigOrigMap (yy * scr_h + y, xx * scr_w + x) 
						Put #f, , ac
						b = b + 1
						totalBytes = totalBytes + 1
					end if
					ct = 1 - ct
				end if
				
			next x
		next y		
		
	next xx
next yy

if i > 0 Then	

	for j = 0 to i - 1
		d = bolts(j).np
		put #f, , d
		d = bolts(j).x
		put #f, , d
		d = bolts(j).y
		put #f, , d
		d = 1
		put #f, , d
		totalBytes = totalBytes + 4
	next j
end if

if packed = 0 then 
	Print "Se escribió mapa.bin con " + trim(str(map_h*map_w)) + " pantallas (" + trim(str(map_h*map_w*scr_h*scr_w)) + " bytes)."
else
	Print "Se escribió mapa.bin con " + trim(str(map_h*map_w)) + " pantallas empaquetadas (" + trim(str(map_h*map_w*scr_h*scr_w / 2)) + " bytes)."
end if
if i > 0 then Print "Se encontraron " + trim(str(i)) + " cerrojos."
Print "total bytes " & totalBytes
print " "
end
