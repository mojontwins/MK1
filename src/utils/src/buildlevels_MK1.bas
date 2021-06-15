' Buildlevel v0.5 20200125 [MTE MK1 5.0+]
' Copyleft 2015 by The Mojon Twins

' Compile with fbc buildlevel.bas cmdlineparser.bas

#include "file.bi"
#include "fbpng.bi"
#include "fbgfx.bi"
#include once "crt.bi"

' Needs cmdlineparser.bas

#include "cmdlineparser.bi"

#define RGBA_R( c ) ( CUInt( c ) Shr 16 And 255 )
#define RGBA_G( c ) ( CUInt( c ) Shr  8 And 255 )
#define RGBA_B( c ) ( CUInt( c )        And 255 )
#define RGBA_A( c ) ( CUInt( c ) Shr 24         )

Dim Shared as Integer defaultInk

Sub usage
	Print "usage"
	Print ""
	Print "$ buildlevel.exe output.bin key1=value1 key2=value2 ... "
	Print ""
	Print "output.bin     Output file name."
	Print ""
	Print "Parameters to buildlevel.exe are specified as key=value, where keys are as "
	Print "follows:"
	Print ""
	Print "MAP DATA"
	Print ""
	Print "mapsize        Needed if game contains differently sized levels: MAP_W*MAP:H"
	Print "mapfile        Especifies the .map file. packed/unpacked autodetected."
	Print "map_w          Map width in screens."
	Print "map_h          Map height in screens."
	Print "decorations    Output filename for decorations. This makes your map packed."
	Print "lock           Tile # for locks. (optional)"
	'Print "attrsfile      map_w*map_h comma separated attrs. for screens (optional)"
	Print "fixmappy       Fixes mappy's 'no first black tile' behaviour"
	Print ""
	Print "TILESET/CHARSET DATA"
	Print ""
	Print "tilesfile      work.png (256x48) containing 48 16x16 tiles."
	Print "behsfile       behs.txt containing 48 comma-separated values."
	Print "defaultink     Value to use when PAPER=INK."
	Print ""
	Print "SPRITESET"
	Print ""
	Print "spritesfile    sprites.png (256x?) containing N 16x16 sprites + masks."
	Print "nsprites       # of sprites in sprites.png. If omitted, defaults to 16."
	Print ""
	Print "ENEMIES"
	Print ""
	Print "enemsfile      enems.ene file"
	'Print "nohotspots     (without value) If MTE MK1 is configured without hotspots."	
	Print ""
	Print "HEADER STUFF"
	Print ""
	Print "scr_ini        Initial screen #"
	Print "ini_x          Initial x position (tiles)"
	Print "ini_y          Initial y position (tiles)"
	Print "max_objs       Max objects (can be omitted If not appliable)"
	Print "enems_life     Enems life"
	Print ""
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
		If defaultInk = -1 Then
			If c2 < 4 Then
				c1 = 7
			Else 
				c1 = 0
			End If
		Else
			c1 = defaultInk
		End If
	End If
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

'' My types

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

'' My vars

Dim As String neededParamsArray (1 To 11) => { _
	"mapfile", "map_w", "map_h", "tilesfile", "behsfile", _
	"spritesfile", "enemsfile", "scr_ini", "ini_x", "ini_y", "enems_life" _
}
Dim As Integer errors
Dim As Byte flag, is_packed
Dim As integer i, j, x, y, xx, yy, f, fout, idx, byteswritten, totalsize, nEnems
Dim As uByte d, life, numlocks
Dim As Byte sd
Dim As integer map_w, map_h, tile_lock, max
ReDim As uByte map_data (0, 0)
Dim As uByte whole_screen (149)
Dim As String levelBin, amalgamer(255), wholeme
Dim As Any Ptr img
Dim As uByte tileset (2303)
Dim As String dummy
Dim As EnemyIn e
Dim As LockType l (32)
Dim as uByte x_pant, y_pant
Dim As Integer somethingOn (255)	
Dim As Integer doForce, fExtra, forceDone, n_pant,  doYawn, decoCtr
Dim As Integer nSprites
Dim As Integer mapSize, fillScreens, fixMappy
Dim As String padStr

'' DO 

Print "buildlevel v0.5 20200125"
Print "Builds a level bundle for MTE MK1 5.0+"
Print ""

' Get command line parameters parsed.
sclpParseAttrs

' Check If all we need is in.
If Len (Command (1)) = 0 Then 
	usage
	End
End If

errors = 0

' This is lame, but better than nothing:
If Instr (Command (1), "=") Then 
	Print "1st Parameter must be output file name!"
	errors = -1
End If

For i = LBound (neededParamsArray) To UBound (neededParamsArray)  ' So I can add more.
	If sclpGetValue (neededParamsArray (i)) = "" Then
		Print "Param """ & neededParamsArray (i) & """ is missing..."
		errors = -1
	End If
Next i

' Prepare some stuff...

If sclpGetValue ("defaultink") <> "" Then
	defaultInk = Val (sclpGetValue ("defaultink"))
Else
	defaultInk = -1
End If

levelBin = Command (1)

map_w = Val (sclpGetValue ("map_w"))
map_h = Val (sclpGetValue ("map_h"))
If map_w = 0 Or map_h = 0 Then 
	Print "map_w or map_h values are incorrect or out of range."
	errors = -1
End If

If sclpGetValue ("lock") <> "" Then 
	tile_lock = Val (sclpGetValue ("lock"))
Else
	tile_lock = 99
End If	
If tile_lock = 0 Then 
	Print "Invalid lock tile #, use 1-47"
	errors = -1
End If

life = Val (sclpGetValue ("enems_life"))
If life = 0 Then 
	Print "Enems life must be >= 1"
	errors = -1
End If

If Not FileExists (sclpGetValue ("mapfile")) Then Puts ("map file specified does not exist"): errors = -1
If sclpGetValue ("attrsfile") <> "" Then 
	If Not FileExists (sclpGetValue ("mapfile")) Then Puts ("map attributes file specified does not exist"): errors = -1
End If
'If Not FileExists (sclpGetValue ("fontfile")) Then Puts ("font file specified does not exist"): errors = -1
If Not FileExists (sclpGetValue ("tilesfile")) Then Puts ("tileset file specified does not exist"): errors = -1
If Not FileExists (sclpGetValue ("spritesfile")) Then Puts ("spriteset file specified does not exist"): errors = -1
If Not FileExists (sclpGetValue ("enemsfile")) Then Puts ("enems file specified does not exist"): errors = -1
If Not FileExists (sclpGetValue ("behsfile")) Then Puts ("behaviours file specified does not exist"): errors = -1

If sclpGetValue ("nsprites") <> "" Then
	nSprites = Val (sclpGetValue ("nsprites"))
	If nSprites < 16 Then
		Puts ("If especified, nsprites must be >= 16")
		errors = -1
	End If
Else
	nSprites = 16
End If

If sclpGetValue ("mapsize") <> "" Then
	mapSize = Val (sclpGetValue ("mapsize"))
	If mapSize < map_w * map_h Then Puts ("Mapsize must be bigger or equal to map_w * map_h"): errors = -1
	fillScreens = mapSize - (map_w * map_h)	
Else
	mapSize = map_w * map_h
	fillScreens = 0
End If

fixMappy = (sclpGetValue ("fixmappy") <> "")

If errors Then
	Print
	Print "Failed. Run buildlevel.exe with no params to get help."
	End
End If

If sclpGetValue ("decorations") <> "" Then
	Puts ("Output decorations to " & sclpGetValue ("decorations"))
	doForce = -1
End If

'' Ok. Start conversion. 

screenres 640, 480, 32, , -1
Kill levelBin
Puts ("Output filename = " & levelbin)
Puts ("")

fout = FreeFile
Open levelBin for Binary as #fout

totalsize = 0

'' ************
'' ** HEADER **
'' ************

Puts ("writing header...")
Puts ("    map_w = " & map_w & ", map_h = " & map_h)
Puts ("    ini @ " & val (sclpGetValue ("scr_ini")) & " (" & val (sclpGetValue ("ini_x")) & "," & val (sclpGetValue ("ini_y")) & ")")
If sclpGetValue ("max_objs") <> "" Then
	Puts ("    max_objs = " & val (sclpGetValue ("max_objs")))
Else
	Puts ("    No max_objs especified, defaulting to 99 (unreachable?)")
End If
Puts ("    enems life gauge = " & life)
' 16 bytes. ff padded.
d = map_w: Put #fout, , d
d = map_h: Put #fout, , d
d = Val (sclpGetValue ("scr_ini")): Put #fout, , d
d = Val (sclpGetValue ("ini_x")): Put #fout, , d
d = Val (sclpGetValue ("ini_y")): Put #fout, , d
If sclpGetValue ("max_objs") <> "" Then
	d = Val (sclpGetValue ("max_objs"))
Else
	d = 99
End If
Put #fout, , d
d = life: Put #fout, , d
d = &Hff: For i = 1 TO 9: Put #fout, , d: Next i
Puts ("    16 bytes writen")
Puts ("")

totalsize = totalsize + 16

'' *********
'' ** MAP **
'' *********

Puts ("reading map...")
Puts ("    map filename = " & sclpGetValue ("mapfile"))
Puts ("    width in tiles = " & (map_w * 15))
Puts ("    height in tiles = " & (map_h * 10))
is_packed = -1
ReDim As uByte map_data (map_h * 10, map_w * 15)
numlocks = 0: forceDone = 0
f = FreeFile
Open sclpGetValue ("mapfile") For Binary as #f
decoCtr = 0
For y = 0 To (10 * map_h) - 1
	For x = 0 To (15 * map_w) - 1
		Get #f, , d
		If fixmappy Then d = d - 1
		map_data (y, x) = d
		' Autodetect unpacked:
		If d > 15 Then
			If Not doForce Then 
				is_packed = 0 
			Else
				If Not forceDone Then 
					Puts ("    Tile(s) > 15 found, but you said 'force'")
					forceDone = -1
				End If
			End If
		End If
		' Autodetect lock
		If d = tile_lock Then
			If numlocks = 32 Then Puts ("ERROR! No more than 32 locks allowed!!"): End
			x_pant = x \ 15: y_pant = y \ 10			
			l (numlocks).np = x_pant + y_pant * map_w
			l (numlocks).x = x Mod 15
			l (numlocks).y = y Mod 10
			l (numlocks).st = 1
			Puts "    lock @ " & l (numlocks).np & " (" & l (numlocks).x & ", " & l (numlocks).y & ")"
			numlocks = numlocks + 1
		End If
	Next x
Next y
Close #f
Puts ("    total bytes read = " & ((map_w * 15) * (map_h * 10)))

If doForce Then
	Puts ("    packed map (16 tiles) + decorations mode.")
Else
	If is_packed Then Puts ("    packed map detected (16 tiles).") Else puts ("    unpacked map detected (48 tiles)")
End If
If tile_lock <> 99 Then Puts ("    " & numlocks & " bolts found.")

Puts ("writing map...")
byteswritten = 0
Puts ("    bin offset = " & Hex (totalsize, 4))
If doForce Then 
	fExtra = freefile
	Open sclpGetValue ("decorations") For Output as #fExtra
End If
For y = 0 To map_h - 1
	For x = 0 To map_w - 1
		If is_packed Then
			idx = 0
			n_pant = map_w * y + x
			
			doYawn = 0
			If doForce Then
				' Is this needed? YES. Only useful code should be output so msc3 behaves.
				For yy = 0 To 9
					For xx = 0 To 14
						If map_data (10 * y + yy, 15 * x + xx) Then doYawn = -1: Exit For
					Next xx
					If doYawn Then Exit For
				Next yy
					
			End If
			
			If doYawn Then 
				Print #fExtra, "ENTERING SCREEN " & Trim (Str (n_pant))
				Print #fExtra, "	IF TRUE"
				Print #fExtra, "	THEN"
				Print #fExtra, "		DECORATIONS"
				
				somethingOn (n_pant) = 0
				amalgamer (n_pant) = "const unsigned char ep_scr_" + hex (n_pant, 2) + " [] = { "
			End If
	
			For yy = 0 To 9
				For xx = 0 To 14
					d = map_data (10 * y + yy, 15 * x + xx)
					If doYawn And d > 15 Then
						decoCtr = decoCtr + 1
						Print #fExtra, "			" & Trim (Str (xx)) & ", " & Trim (Str (yy)) & ", " & Trim (Str (d))
						If somethingOn (n_pant) Then
							amalgamer (n_pant) = amalgamer (n_pant) & ", "
						Else
							somethingOn (n_pant) = -1
						End If
						amalgamer (n_pant) = amalgamer (n_pant) & "0x" & hex (xx * 16 + yy) & ", " & trim (Str (d))
						d = 0
					End If
					whole_screen (idx) = d
					idx = idx + 1
				Next xx
			Next yy
			If doYawn Then 
				amalgamer (n_pant) = amalgamer (n_pant) & " };"
				Print #fExtra, "		END"
				Print #fExtra, "	END"
				Print #fExtra, "END"
				Print #fExtra, " "
			End If
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
If doForce Then
	Print #fExtra, " "
	Print #fExtra, "// If you use extraprints.h, trim this bit and use it!"
	wholeme = "const unsigned char *prints [] = { "
	For i = 0 To (map_w * map_h) - 1
		If i > 0 Then wholeme = wholeme & ", "
		If somethingOn (i) Then
			Print #fExtra, amalgamer (i)
			wholeme = wholeme & "ep_scr_" + hex (i, 2)
		Else
			wholeme = wholeme & "0"
		End If
	Next i
	wholeme = wholeme & " };"
	Print #fExtra, wholeme
End If

If fillScreens Then
	Puts ("    Filling with " & fillScreens & " empty screens")
	If is_packed Then j = 75 Else j = 150
	padStr = String (j, 0)
	For i = 1 to fillScreens
		Put #fOut, , padStr
		byteswritten = byteswritten + j
	Next i
End If

Puts ("    " & byteswritten & " bytes written.")

If doForce Then
	Puts ("    Out of range tiles written to " & sclpGetValue ("decorations"))
	Puts ("    " & decoCtr & " decorations written.")
End If

totalsize = totalsize + byteswritten

' Map attributes

If sclpGetValue ("attrsfile") <> "" Then 
	Puts ("Writting map attributes")
	byteswritten = 0
	f = Freefile
	Open sclpGetValue ("attrsfile") For Input as #f
	For i = 1 To map_h
		dummy = "    "
		For j = 1 To map_w
			If Eof (f) Then
				Puts ("Not enough attributes in attr file... Aborting.")
				End
			End If
			Input #f, d
			Put #fout, , d
			dummy = dummy & hex (d, 2) & " "
			byteswritten = byteswritten + 1
		Next j
		Puts (dummy)
	Next i
	Close #f
	Puts ("    " & byteswritten & " bytes written.")
	totalsize = totalsize + byteswritten
End If

' Bolts

If tile_lock = 99 Then
	Puts ("No bolts will be output.")
Else
	Puts ("writing bolts...")
	Puts ("    bin offset = " & Hex (totalsize, 4))
	byteswritten = 0
	For i = 0 To 31
		d = l (i).np: Put #fout, , d
		d = l (i).x: Put #fout, , d
		d = l (i).y: Put #fout, , d
		d = l (i).st: Put #fout, , d
		byteswritten = byteswritten + 4
	Next i
	Puts ("    " & byteswritten & " bytes written.")
	totalsize = totalsize + byteswritten
End If

Puts ("")

'' *************
'' ** TILESET **
'' *************

idx = 0

'Puts ("reading font")
'img = png_load (sclpGetValue ("fontfile"))
'Puts ("    font filename = " & sclpGetValue ("fontfile"))
'byteswritten = 0
'idx = 0
'For y = 0 To 1
'	For x = 0 To 31
'		getUDGIntoCharset img, x * 8, y * 8, tileset (), idx
'		idx = idx + 1	
'		byteswritten = byteswritten + 9
'	Next x
'Next y
'Puts ("    converted 64 chars")
byteswritten = 512 + 64
for idx = 0 To 2303: tileset (idx) = 0: Next idx

Puts ("reading 16x16 tiles")
img = png_load (sclpGetValue ("tilesfile"))
If ImageInfo (img, xx, yy, , , , ) Then
	Puts ("Something wrong happened"): End
End If
Puts ("    tileset filename = " & sclpGetValue ("tilesfile"))
x = 0
y = 0
For idx = 0 to 47 '(((xx\16)*(yy\16)) - 1)
	getUDGIntoCharset img, x, y, tileset (), idx * 4 + 64
	getUDGIntoCharset img, x + 8, y, tileset (), idx * 4 + 65
	getUDGIntoCharset img, x, y + 8, tileset (), idx * 4 + 66
	getUDGIntoCharset img, x + 8, y + 8, tileset (), idx * 4 + 67
	x = x + 16: If x = xx Then x = 0: y = y + 16
	byteswritten = byteswritten + 36
Next idx
'Puts ("    converted " & (((xx\16)*(yy\16))*4) & " chars")
Puts ("    converted " & (48*4) & " chars")
Puts ("writing tileset")

Puts ("    bin offset = " & Hex (totalsize, 4))
For idx = 512 To byteswritten - 1
	d = tileset (idx)
	put #fout, , d
Next idx
Puts ("    " & (byteswritten - 512) & " bytes written")
Puts ("")

totalsize = totalsize + (byteswritten - 512)

'' ********************
'' ** ENEMS/HOTSPOTS **
'' ********************

byteswritten = 0
Puts ("reading enems file")
Puts ("    enems filename = " & sclpGetValue ("enemsfile"))
f = freefile
Open sclpGetValue ("enemsfile") For Binary as #f
' Skip header
dummy = Input (256, f)
Get #f, , d
Get #f, , d
Get #f, , d
Get #f, , d
Get #f, , d: nEnems = d

' Read enems
max = map_w * map_h * nEnems
Puts ("    reading " & max & " enemies")
Puts ("    bin offset = " & Hex (totalsize, 4))
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
	' ubyte x, y;
	d = e.x * 16: Put #fout, , d
	d = e.y * 16: Put #fout, , d
	
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
	byteswritten = byteswritten + 10
Next idx
Puts ("    written " & max & " enemies")

If fillScreens Then
	Puts ("    Filling with " & fillScreens & " empty screens")
	j = 30
	padStr = String (j, 0)
	For i = 1 to fillScreens
		Put #fOut, , padStr
		byteswritten = byteswritten + j
	Next i
End If

Puts ("    " & byteswritten & " bytes written.")
totalsize = totalsize + byteswritten
byteswritten = 0

If sclpGetValue ("nohotspots") <> "" Then
	Puts ("    no hotspots will be processed / included")
Else
	
	max = map_w * map_h
	Puts ("    reading " & max & " hotspots")
	Puts ("    bin offset = " & Hex (totalsize, 4))
	For idx = 1 To max
		' Read
		get #f, , e.x
		get #f, , e.y
		get #f, , e.t
		
		' Write
		' unsigned char xy
		d = e.x*16 + e.y: put #fout, , d
		' unsigned char t
		d = e.t: put #fout, , d
		' unsigned char act
		d = 1: put #fout, , d
		
		byteswritten = byteswritten + 3
	Next idx
	Close #f

	If fillScreens Then
		Puts ("    Filling with " & fillScreens & " empty screens")
		j = 3
		padStr = String (j, 0)
		For i = 1 to fillScreens
			Put #fOut, , padStr
			byteswritten = byteswritten + j
		Next i
	End If

	Puts ("    " & byteswritten & " bytes written.")
	Puts ("")
	
	totalsize = totalsize + byteswritten
End If

'' ****************
'' ** BEHAVIOURS **
'' ****************

Puts ("reading behaviours")
Puts ("    Behaviours file = " & sclpGetValue ("behsfile"))
f = Freefile
Puts ("    bin offset = " & Hex (totalsize, 4))
byteswritten = 0
Open sclpGetValue ("behsfile") For Input as #f
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

'' ***************
'' ** SPRITESET **
'' ***************

Puts ("reading spriteset")
img = png_load (sclpGetValue ("spritesfile"))
Puts ("    spriteset filename = " & sclpGetValue ("spritesfile"))

Puts ("converting & writing spriteset")
Puts ("    bin offset = " & Hex (totalsize, 4))
Puts ("    sprite count = " & nSprites)

x = 0
y = 0
byteswritten = 0
For idx = 0 To 7
	d = 0: Put #fout, , d
	d = 255: Put #fout, , d
	byteswritten = byteswritten + 2
Next idx
For idx = 0 To nSprites - 1
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
Puts ("    " & byteswritten & " bytes written in " & nSprites & " frames")
Puts ("")

totalsize = totalsize + byteswritten

Close #fout

Puts ("Level is " & totalsize & " bytes.")

Puts ("PODEWWWR!!!")
