#include "file.bi"
#include "fbpng.bi"
#include "fbgfx.bi"
#include once "crt.bi"

#define RGBA_R( c ) ( CUInt( c ) Shr 16 And 255 )
#define RGBA_G( c ) ( CUInt( c ) Shr  8 And 255 )
#define RGBA_B( c ) ( CUInt( c )        And 255 )
#define RGBA_A( c ) ( CUInt( c ) Shr 24         )

Sub usage
	Puts ("buildlevel v 0.1")
	Puts ("usage:")
	Puts ("")
	Puts ("$ buildlevel mapa.map map_w map_h lock font.png work.png spriteset.png extrasprites.bin enems.ene scr_ini x_ini y_ini max_objs enems_life behs.txt level.bin")
	Puts ("")
	Puts ("where:")
	Puts ("   * mapa.map is your map from mappy .map")
	Puts ("   * map_w, map_h are map dimmensions in screens")
	Puts ("   * lock is 15 to autodetect lock, 99 otherwise")
	Puts ("   * font.png is a 256x16 file with 64 chars ascii 32-95")
	Puts ("   * work.png is a 256x48 file with your 16x16 tiles")
	Puts ("   * spriteset.png is a 256x32 file with your spriteset")
	Puts ("   * extrasprites.bin as provided.")
	Puts ("   * enems.ene enems/hotspots directly from colocador.exe")
	Puts ("   * scr_ini, scr_x, scr_y, max_objs, enems_life general level data header")
	Puts ("   * behs.txt is a tile behaviours file")
	Puts ("   * level.bin is the output filename.")
	Puts ("")
End Sub

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
		if c2 < 4 then
			c1 = 7
		else 
			c1 = 0
		end if
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

Const C_MAPNAME = 1
Const C_MAPW = 2
Const C_MAPH = 3
Const C_LOCK = 4
Const C_FONTNAME = 5
Const C_WORKNAME = 6
Const C_SPRITESETNAME = 7
Const C_EXTRASPRITESNAME = 8
Const C_ENEMSNAME = 9
Const C_SCRINI = 10
Const C_SCRX = 11
Const C_SCRY = 12
Const C_MAXOBJS = 13
Const C_ENEMSLIFE = 14
Const C_BEHSNAME = 15
Const C_OUTPUTFILE = 16

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

Type LockType
	np as uByte
	x as uByte
	y as uByte
	st as uByte
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
Dim As LockType l (32)
Dim as uByte x_pant, y_pant

'' Command line syntax check
'' Not very comprehensive, y'know...

flag = 0
For i = 1 To 15
	If Len (Command (i)) = 0 Then flag = -1: Exit For
Next i

If Len (Command (C_OUTPUTFILE)) = 0 Then levelBin = "level.bin" Else levelBin = Command (C_OUTPUTFILE)

If flag Then usage: End

map_w = Val (Command (C_MAPW))
map_h = Val (Command (C_MAPH))
If map_w = 0 Or map_h = 0 Then usage: End
tile_lock = Val (Command (C_LOCK))
If tile_lock = 0 Then usage: End
life = Val (Command (C_ENEMSLIFE))
If life = 0 Then Puts ("Enemies can't have life = 0!") : End

If Not FileExists (Command (C_MAPNAME)) Then Puts ("map file specified does not exist"): End
If Not FileExists (Command (C_FONTNAME)) Then Puts ("font file specified does not exist"): End
If Not FileExists (Command (C_WORKNAME)) Then Puts ("tileset file specified does not exist"): End
If Not FileExists (Command (C_SPRITESETNAME)) Then Puts ("spriteset file specified does not exist"): End
If Not FileExists (Command (C_EXTRASPRITESNAME)) Then Puts ("'extra sprites' file specified does not exist"): End
If Not FileExists (Command (C_ENEMSNAME)) Then Puts ("enems file specified does not exist"): End
If Not FileExists (Command (C_BEHSNAME)) Then Puts ("behaviours file specified does not exist"): End

'' Ok. Start conversion. 

screenres 640, 480, 32, , -1
Kill levelBin
Puts ("")
Puts ("output filename = " & levelbin)
Puts ("")

fout = FreeFile
Open levelBin for Binary as #fout

totalsize = 0

'' ************
'' ** HEADER **
'' ************

Puts ("writing header...")
Puts ("    map_w = " & map_w & ", map_h = " & map_h)
Puts ("    ini @ " & val (command (c_scrini)) & " (" & val (command (c_scrx)) & "," & val (command (c_scry)) & ")")
Puts ("    max_objs = " & val (command (c_maxobjs)))
Puts ("    enems life gauge = " & life)
' 16 bytes. ff padded.
d = map_w: Put #fout, , d
d = map_h: Put #fout, , d
d = Val (Command (C_SCRINI)): Put #fout, , d
d = Val (Command (C_SCRX)): Put #fout, , d
d = Val (Command (C_SCRY)): Put #fout, , d
d = Val (Command (C_MAXOBJS)): Put #fout, , d
d = life: Put #fout, , d
d = &Hff: For i = 1 TO 9: Put #fout, , d: Next i
Puts ("")

totalsize = totalsize + 16

'' *********
'' ** MAP **
'' *********

Puts ("reading map...")
Puts ("    map filename = " & Command (C_MAPNAME))
Puts ("    width in tiles = " & (map_w * 15))
Puts ("    height in tiles = " & (map_h * 10))
is_packed = -1
ReDim As uByte map_data (map_h * 10, map_w * 15)
numlocks = 0
f = FreeFile
Open Command(C_MAPNAME) For Binary as #f
For y = 0 To (10 * map_h) - 1
	For x = 0 To (15 * map_w) - 1
		Get #f, , d
		map_data (y, x) = d
		' Autodetect unpacked:
		If d > 15 Then is_packed = 0
		' Autodetect lock
		If d = tile_lock Then
			If numlocks = 32 Then Puts ("ERROR! No more than 32 locks allowed!!"): End
			x_pant = x / 15: y_pant = y / 10
			l (numlocks).np = x_pant + y_pant * map_w
			l (numlocks).x = x Mod 15
			l (numlocks).y = y Mod 15
			l (numlocks).st = 1
			numlocks = numlocks + 1
		End If
	Next x
Next y
Close #f
Puts ("    total bytes read = " & ((map_w * 15) * (map_h * 10)))

If is_packed Then Puts ("    packed map detected (16 tiles).") else puts ("    unpacked map detected (48 tiles)")
Puts ("    " & numlocks & " bolts found.")

Puts ("writing map...")
byteswritten = 0
For y = 0 To map_h - 1
	For x = 0 To map_w - 1
		If is_packed Then
			idx = 0
			For yy = 0 To 9
				For xx = 0 To 14
					whole_screen (idx) = map_data (10 * y + yy, 15 * x + xx)
					idx = idx + 1
				Next xx				
			Next yy
			For i = 0 To 74
				d = (whole_screen (i + i) Shl 4) + (whole_screen (1 + i + i) And 15)
				Put #fout, , d
				byteswritten = byteswritten + 1
			Next i
		Else
			For yy = 0 To 9
				For xx = 0 To 14
					d = map_data (10 * y + yy, 15 * x + xx)
					Put #fout, , d
					byteswritten = byteswritten + 1
				Next xx
			Next yy
		End If
	Next x
Next y
Puts ("    " & byteswritten & " bytes written.")
totalsize = totalsize + byteswritten
byteswritten = 0

Puts ("writing bolts...")
For i = 0 To 31
	d = l (i).np: Put #fout, , d
	d = l (i).x: Put #fout, , d
	d = l (i).y: Put #fout, , d
	d = l (i).st: Put #fout, , d
	byteswritten = byteswritten + 4
Next i

Puts ("    " & byteswritten & " bytes written.")
totalsize = totalsize + byteswritten
Puts ("")



'' *************
'' ** TILESET **
'' *************

' Puts ("building tileset")
idx = 0

Puts ("reading font")
img = png_load (Command (C_FONTNAME))
Puts ("    font filename = " & Command (C_FONTNAME))
idx = 0
For y = 0 To 1
	For x = 0 To 31
		getUDGIntoCharset img, x * 8, y * 8, tileset (), idx
		idx = idx + 1	
	Next x
Next y
Puts ("    converted 64 chars")
Puts ("reading 16x16 tiles")
img = png_load (Command (C_WORKNAME))
Puts ("    tileset filename = " & Command (C_WORKNAME))
x = 0
y = 0
For idx = 0 to 47
	getUDGIntoCharset img, x, y, tileset (), idx * 4 + 64
	getUDGIntoCharset img, x + 8, y, tileset (), idx * 4 + 65
	getUDGIntoCharset img, x, y + 8, tileset (), idx * 4 + 66
	getUDGIntoCharset img, x + 8, y + 8, tileset (), idx * 4 + 67
	x = x + 16: If x = 256 Then x = 0: y = y + 16
Next idx
Puts ("    converted 192 chars")
Puts ("writing tileset")

For idx = 0 To 2303
	d = tileset (idx)
	put #fout, , d
Next idx
Puts ("    2304 bytes written")
Puts ("")

totalsize = totalsize + 2304


'' ***************
'' ** SPRITESET **
'' ***************

' Puts ("converting spriteset")

Puts ("reading spriteset")
img = png_load (Command (C_SPRITESETNAME))
Puts ("    spriteset filename = " & Command (C_SPRITESETNAME))

Puts ("converting & writing spriteset")

x = 0
y = 0
byteswritten = 0
For idx = 0 To 7
	d = 0: Put #fout, , d
	d = 255: Put #fout, , d
	byteswritten = byteswritten + 2
Next idx
For idx = 0 To 15
	' First & second columns
	For xx = 0 To 8 Step 8
		For yy = 0 To 15
			d = getBitPattern (img, x + xx, y + yy)
			Put #fout, , d
			d = getBitPattern (img, x + xx + 16, y + yy)
			Put #fout, , d
			byteswritten = byteswritten + 2
		Next yy
		For yy = 0 To 7
			d = 0
			Put #fout, , d
			d = 255
			Put #fout, , d
			byteswritten = byteswritten + 2
		Next yy
	Next xx	
	' Third column
	For yy = 0 to 23
		d = 0
		Put #fout, , d
		d = 255
		Put #fout, , d
		byteswritten = byteswritten + 2
	Next yy
	x = x + 32: If x = 256 Then x = 0: y = y + 16
Next idx
Puts ("    " & byteswritten & " bytes written in 16 frames")
Puts ("")

totalsize = totalsize + byteswritten

'' ******************
'' ** EXTRASPRITES **
'' ******************

Puts ("pasting extra sprites binary")
Puts ("    extra sprites binary filename = " & Command (C_EXTRASPRITESNAME))
Puts ("    reading & writing file")
f = freefile
Open Command (C_EXTRASPRITESNAME) For Binary as #f
byteswritten = 0
While Not Eof (f)
	Get #f, , d
	Put #fout, , d
	byteswritten = byteswritten + 1
Wend
Close #f
Puts ("    " & byteswritten & " bytes written")
Puts ("")

totalsize = totalsize + byteswritten

'' ********************
'' ** ENEMS/HOTSPOTS **
'' ********************

byteswritten = 0
Puts ("reading enems file")
Puts ("    enems filename = " & Command (C_ENEMSNAME))
f = freefile
Open Command (C_ENEMSNAME) For Binary as #f
' Skip header
dummy = Input (261, f)
' Read enems
max = map_w * map_h * 3 
Puts ("    reading " & max & " enemies")
For idx = 1 To max
	' Read
	Get #f, , e.t
	Get #f, , e.x
	Get #f, , e.y
	Get #f, , e.xx
	Get #f, , e.yy
	Get #f, , e.n
	Get #f, , e.s1
	Get #f, , e.s2
	
	' Write		
	' int16 x, y; lsb msb
	x = e.x * 16
	d = x And &hff: Put #fout, , d
	d = (x Shr 8) And &hff: Put #fout, , d
	
	y = e.y * 16
	d = y And &hff: Put #fout, , d
	d = (y Shr 8) And &hff: Put #fout, , d
	
	' ubyte x1, y1, x2, y2
	d = 16 * e.x: Put #fout, , d
	d = 16 * e.y: Put #fout, , d
	d = 16 * e.xx: Put #fout, , d
	d = 16 * e.yy: Put #fout, , d
	
	' ubyte mx, my
	sd = e.n * sgn (e.xx - e.x): Put #fout, , sd
	sd = e.n * sgn (e.yy - e.y): Put #fout, , sd
	
	' ubyte t
	d = e.t: Put #fout, , d
	
	' ubyte life
	d = life: Put #fout, , d
	
	'puts ("->" & x & ", " & y & ", " & e.x & ", " & e.y & ", " & e.xx & ", " & e.yy & ", " & 
	byteswritten = byteswritten + 12	
Next idx
Puts ("    written " & max & " enemies")
Puts ("    " & byteswritten & " bytes written.")
totalsize = totalsize + byteswritten
byteswritten = 0
max = map_w * map_h
Puts ("    reading " & max & " hotspots")
For idx = 1 To max
	' Read
	get #f, , e.x
	get #f, , e.t
	
	' Write
	' unsigned char xy
	d = e.x: put #fout, , d
	' unsigned char t
	d = e.t: put #fout, , d
	' unsigned char act
	d = 1: put #fout, , d
	
	byteswritten = byteswritten + 3
Next idx
Close #f
Puts ("    " & byteswritten & " bytes written.")
Puts ("")

totalsize = totalsize + byteswritten

Puts ("reading behaviours")
Puts ("    Behaviours file = " & Command (C_BEHSNAME))
f = Freefile
byteswritten = 0
Open Command (C_BEHSNAME) For Input as #f
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

Close #fout

Puts ("Level is " & totalsize & " bytes.")

Puts ("PODEWWWR!!!")
