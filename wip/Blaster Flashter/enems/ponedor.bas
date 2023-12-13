' ponedor v0.1
' Copyleft 2016 by the Mojon Twins
' Simple GUI program to place enemies and hotspots
' I need to get rid of the crashy, allegro-needing old one.

' fbc.exe ponedor.bas cmdlineparser.bas mtparser.bas gui.bas bmp.bas
' Needs libpng.a, fbpng.bi, cmdlineparser.*, mtparser.*, gui.*, bmp.* to compile.
' Needs zlib1.dll to run.

#include "file.bi"
#include "fbpng.bi"
#include "fbgfx.bi"
#include once "crt.bi"

#include "cmdlineparser.bi"
#include "mtparser.bi"
#include "gui.bi"
#include "bmp.bi"

#define BORDER_TOP 		16
#define BORDER_BOTTOM 	24
#define BORDER_LEFT 	8
#define BORDER_RIGHT 	8

#define SC_LEFT 	&H4B
#define SC_RIGHT 	&H4D
#define SC_UP 		&H48
#define SC_DOWN 	&H50
#define SC_S        &H1F
#define SC_G 		&H22
#define SC_ENTER 	&H1C
#define SC_TAB		&H0F
#define SC_MINUS    &H0C
#define SC_PLUS 	&H4E

#define CS_LEFT 	&H01
#define CS_RIGHT 	&H02
#define CS_UP 		&H04
#define CS_DOWN 	&H08
#define CS_SAVE 	&H10
#define CS_GRID 	&H20
#define CS_PLUS		&H40
#define CS_MINUS 	&H80

#define STATE_INITIAL 0
#define STATE_LAYINGOUTENEMY 1

Type MapDescriptorType
	mapFile As String * 127
	adjust As uByte
	tilesFile As String * 128
	mapW As uByte
	mapH As uByte
	scrW As uByte
	scrH As uByte
	nenems As uByte
End Type

Type OptionsType
	drawGrid As uByte
	mapViewOffsetX As Integer
	mapViewOffsetY As Integer
	winW As Integer
	winH As Integer
	borderTop As Integer
	borderBottom As Integer
	borderLeft As Integer
	borderRight As Integer
End Type

Type EnemiesType
	t As uByte
	x As uByte
	y As uByte
	xx As uByte
	yy As uByte
	n As uByte
	s1 As uByte
	s2 As uByte
End Type

Type HotspotsType
	t As uByte
	x As uByte
	y As uByte
End Type

Dim Shared As OptionsType options
Dim Shared As MapDescriptorType mapDescriptor

Redim Shared As uByte mapData (0, 0, 0, 0)
Redim Shared As EnemiesType enems (0, 0, 0)
Redim Shared As HotspotsType hotspots (0, 0)

Dim Shared As EnemiesType currentEnem

Dim Shared As String enemsFn
Dim Shared As Any Ptr buffer
Redim Shared As Any Ptr tiles (0)
Dim Shared As Integer editingState

Dim Shared As Integer debug
Dim Shared As Integer doLoad
Dim Shared As Integer stretchX2

Dim Shared As Integer ratio
Dim Shared As Integer offsetr

Dim Shared As uByte thinNumbers (135) = { _
	0, 14, 10, 10, 10, 10, 14, 0, _
	0, 2, 2, 2, 2, 2, 2, 0, _
	0, 14, 2, 14, 8, 8, 14, 0, _
	0, 14, 2, 14, 2, 2, 14, 0, _
	0, 10, 10, 14, 2, 2, 2, 0, _
	0, 14, 8, 14, 2, 2, 14, 0, _
	0, 8, 8, 14, 10, 10, 14, 0, _
	0, 14, 2, 4, 4, 8, 8, 0, _
	0, 14, 10, 14, 10, 10, 14, 0, _
	0, 14, 10, 14, 2, 2, 2, 0, _
	0, 14, 10, 14, 10, 10, 10, 0, _
	0, 12, 10, 12, 10, 10, 12, 0, _
	0, 6, 8, 8, 8, 8, 6, 0, _
	0, 12, 10, 10, 10, 10, 12, 0, _
	0, 14, 8, 14, 8, 8, 14, 0, _
	0, 14, 8, 14, 8, 8, 8, 0, _
	0, 14, 14, 14, 14, 14, 14, 0 _
}

Function myFileExists (fn As String) As Integer
	Dim fH As Integer
	fH = FreeFile
	Open fn For Binary As #fH
	If Lof (fH) = 0 Then
		Close #fH
		Kill fn
		Return 0
	End If
	Close #fH
	Return -1
End Function

Sub drawThinDigit (x0 As Integer, y0 As Integer, c As uInteger, d As Integer)
	Dim As Integer x, y 

	d = d * 8
	For y = 0 To 7
		For x = 0 to 3
			If (thinNumbers (d) And (8 Shr x)) = (8 Shr x) Then
				Pset (x0 + x, y0 + y), c
			End If
		Next x
		d = d + 1
	Next y
End Sub

Sub drawThinHexNumber2 (x0 As Integer, y0 As Integer, c1 As uInteger, c2 As uInteger, n As Integer)
	If c2 <> -1 Then Line (x0, y0)-(x0 + 7, y0 + 7), c2, BF
	If n > 255 Then 
		drawThinDigit x0, y0, c1, 16
		drawThinDigit x0 + 4, y0, c1, 16
	Else
		drawThinDigit x0, y0, c1, n \ 16
		drawThinDigit x0 + 4, y0, c1, n Mod 16 
	End If
End Sub

Sub initOptions
	options.drawGrid = -1
	options.mapViewOffsetY = 16
	options.mapViewOffsetX = 8
	options.borderTop = BORDER_TOP
	options.borderBottom = BORDER_BOTTOM
	options.borderLeft = BORDER_LEFT
	options.borderRight = BORDER_RIGHT
	options.winH = options.borderTop + options.borderBottom + ratio * mapDescriptor.scrH
	options.winW = options.borderLeft + options.borderRight + ratio * mapDescriptor.scrW
End Sub

Sub writeSizedString (s As String, n As Integer, fH As Integer)
	Dim As Integer i
	Dim As uByte d

	For i = 1 To n
		If i <= Len (s) Then d = Asc (Mid (s, i, 1)) Else d = 0
		Put #fH, , d
	Next i
End Sub

Sub parseHeaders
	Dim As Integer fIn
	Dim As uByte d 

	If Not (myFileExists (enemsFn)) Then Puts ("ERROR: " & enemsFn & " does not exist. Can't continue."): System

	fIn = FreeFile
	Open enemsFn For Binary As #fIn

	' Read header. Safe
	mapDescriptor.mapFile = Trim (Input (127, fIn), Any Chr (0)+Chr (9)+Chr (32))
	Get #fIn, , d: mapDescriptor.adjust = d
	mapDescriptor.tilesFile = Trim (Input (128, fIn), Any Chr (0)+Chr (9)+Chr (32))
	Get #fIn, , d: mapDescriptor.mapW = d
	Get #fIn, , d: mapDescriptor.mapH = d
	Get #fIn, , d: mapDescriptor.scrW = d
	Get #fIn, , d: mapDescriptor.scrH = d
	Get #fIn, , d: mapDescriptor.nenems = d

	Close #fIn
End Sub

Sub saveProject
	Dim As Integer fOut
	Dim As uByte d
	Dim As Integer xP, yP, i

	fOut = FreeFile
	Open enemsFn For Binary As #fOut

	' Write header. Safe
	' mapfile String
	writeSizedString Trim (mapDescriptor.mapFile, Any Chr (0)+Chr (9)+Chr (32)), 127, fOut
	
	' adjust
	d = mapDescriptor.adjust: Put #fOut, , d
		
	' tilesfile String
	writeSizedString Trim (mapDescriptor.tilesFile, Any Chr (0)+Chr (9)+Chr (32)), 128, fOut

	' Values
	d = mapDescriptor.mapW: Put #fOut, , d
	d = mapDescriptor.mapH: Put #fOut, , d
	d = mapDescriptor.scrW: Put #fOut, , d
	d = mapDescriptor.scrH: Put #fOut, , d
	d = mapDescriptor.nenems: Put #fOut, , d

	' Write enems
	For yP = 0 To mapDescriptor.mapH - 1
		For xP = 0 To mapDescriptor.mapW - 1
			For i = 0 To mapDescriptor.nenems - 1
				d = enems (xP, yP, i).t: Put #fOut, , d
				d = enems (xP, yP, i).x: Put #fOut, , d
				d = enems (xP, yP, i).y: Put #fOut, , d
				d = enems (xP, yP, i).xx: Put #fOut, , d
				d = enems (xP, yP, i).yy: Put #fOut, , d
				d = enems (xP, yP, i).n: Put #fOut, , d
				d = enems (xP, yP, i).s1: Put #fOut, , d
				d = enems (xP, yP, i).s2: Put #fOut, , d
	Next i, xP, yP

	' Write hotspots
	For yP = 0 To mapDescriptor.mapH - 1
		For xP = 0 To mapDescriptor.mapW - 1
			' Safe
			If hotspots (xP,yP).t = 0 Then
				hotspots (xP,yP).x = 0
				hotspots (xP,yP).y = 0 
			End if
			d = hotspots (xP, yP).x: Put #fOut, , d
			d = hotspots (xP, yP).y: Put #fOut, , d
			d = hotspots (xP, yP).t: Put #fOut, , d
	Next xP, yP

	Close #fOut
End Sub

Function parseInput As Integer
	Dim As String mandatory (3) = { "out", "map", "tiles", "size" }
	Dim As Integer coords (10)

	' Parse the command line
	sclpParseAttrs

	debug = (sclpGetValue ("debug") <> "")
	stretchX2 = (sclpGetValue ("x2") <> "")

	If stretchX2 Then ratio = 32: offsetr = 8 Else ratio = 16: offsetr = 0

	' Are we editing or creating new?
	If sclpGetValue ("new") <> "" Then
		' Creating new.
		If Not sclpCheck (mandatory ()) Then Return 0

		' out:
		enemsFn = sclpGetValue ("out")

		' map:
		mapDescriptor.mapFile = sclpGetValue ("map")

		' tiles:
		mapDescriptor.tilesFile = sclpGetValue ("tiles")

		' adjust (substract from # read from file when loading .map)
		mapDescriptor.adjust = Val (sclpGetValue ("adjust"))

		' Map size
		parseCoordinatesString (sclpGetValue ("size"), coords ())
		mapDescriptor.mapW = coords (0)
		mapDescriptor.mapH = coords (1)
		If mapDescriptor.mapW = 0 Or mapDescriptor.mapH = 0 Then Return 0

		' Screen size
		If sclpGetValue ("scrsize") <> "" Then
			parseCoordinatesString (sclpGetValue ("scrsize"), coords ())
			mapDescriptor.scrW = coords (0)
			mapDescriptor.scrH = coords (1)
			If mapDescriptor.scrW = 0 Or mapDescriptor.scrH = 0 Then Return 0
		Else
			mapDescriptor.scrW = 16
			mapDescriptor.scrH = 12
		End If

		' # of enemies
		If sclpGetValue ("nenems") <> "" Then
			mapDescriptor.nenems = Val (sclpGetValue ("nenems"))
		Else
			mapDescriptor.nenems = 3
		End If

		doLoad = 0
	Else
		' Editing.
		If Command (1) = "" Then Return 0
		enemsFn = Command (1)

		parseHeaders
		doLoad = -1
	End If

	Return -1
End Function

Sub usage
	Print "Edit an existing set:"
	Print "$ ponedor.exe file.ene"
	Print
	Print "Create new set:"
	Print "$ ponedor.exe new out=file.ene map=file.map tiles=file.png|bmp [adjust=n] size=w,h"
	Print "                  [scrsize=w,h] [nenems=n] [x2]"
	Print
	Print "out           output filename"
	Print "map           map file (raw, headerless, 1 byte per tile, row order)"
	Print "tiles         tileset in png or bmp format."
	Print "adjust        substract this number from every byte read from the map file. Def=0"
	Print "size          map size in screens"
	Print "scrsize       screen size in tiles. Def=16,12"
	Print "nenems        number of enemies per screen. Def=3"
	Print "x2            zoom x2 (hacky)"
End Sub

Sub cutTileSet
	Dim As Any ptr img
	Dim As Any ptr work
	Dim As Integer w, h, x, y, i, xx, yy, c

	If Not (myFileExists (Trim (mapDescriptor.tilesFile, Any Chr (0)+Chr (9)+Chr (32)))) Then Puts ("ERROR: " & Trim (mapDescriptor.tilesFile, Any Chr (0)+Chr (9)+Chr (32)) & " does not exist. Can't continue."): System

	If Right (Trim (mapDescriptor.tilesFile, Any Chr (0)+Chr (9)+Chr (32)), 4) = ".png" Then
		If debug Then puts ("Reading PNG file " & Trim (mapDescriptor.tilesFile, Any Chr (0)+Chr (9)+Chr (32)))
		img = png_load (mapDescriptor.tilesFile)
	Else
		If debug Then puts ("Reading BMP file " & Trim (mapDescriptor.tilesFile, Any Chr (0)+Chr (9)+Chr (32)))
		img = bmp_load (mapDescriptor.tilesFile)
	End If
	If ImageInfo (img, w, h, , , , ) Then
		' Error!
		If debug Then puts ("Error reading image!")
	End If

	If debug Then puts ("Image read size is " & w & "x" & h)

	Redim tiles ((w \ 16) * (h \ 16) - 1)
	' Normalize:
	h = (h \ 16) * 16
	w = (w \ 16) * 16

	If stretchX2 Then
		i = 0
		For y = 0 To h - 1 Step 16
			For x = 0 To w - 1 Step 16
				tiles (i) = ImageCreate (32, 32, 0)
				For yy = 0 To 15
					For xx = 0 To 15
						c = Point (x + xx, y + yy, img)
						Line tiles (i), (xx + xx, yy + yy) - (xx + xx + 1, yy + yy + 1), c, BF
					Next xx
				Next yy
				i = i + 1
			Next x 
		Next y
	Else
		' Cut
		i = 0
		For y = 0 To h - 1 Step 16
			For x = 0 To w - 1 Step 16
				tiles (i) = ImageCreate (16, 16, 0)
				Get img, (x, y) - (x + 15, y + 15), tiles (i)
				i = i + 1
			Next x 
		Next y
	End If

	ImageDestroy img

	If debug Then puts ("Cut " & i & " tiles.")
End Sub

Sub prepareAssets
	Dim As Integer x, y, i

	' Init map data
	Redim mapData (mapDescriptor.mapW, mapDescriptor.mapH, mapDescriptor.scrW, mapDescriptor.scrH)

	' Init enems data
	Redim enems (mapDescriptor.mapW, mapDescriptor.mapH, mapDescriptor.nenems)
	For y = 0 To mapDescriptor.mapH - 1
		For x = 0 To mapDescriptor.mapW - 1
			For i = 0 To mapDescriptor.nenems - 1
				enems (x, y, i).t = 0
	Next i, x, y

	' Init hotspots data
	Redim hotspots (mapDescriptor.mapW, mapDescriptor.mapH)
	For y = 0 To mapDescriptor.mapH - 1
		For x = 0 To mapDescriptor.mapW - 1
			hotspots (x, y).t = 0
	Next x, y
End Sub

Sub loadMap
	Dim As Integer fIn, x, y, xMap, yMap, xScr, yScr
	Dim As uByte d

	If Not (myFileExists (Trim (mapDescriptor.mapFile, Any Chr (0)+Chr (9)+Chr (32)))) Then Puts ("ERROR: " & Trim (mapDescriptor.mapFile, Any Chr (0)+Chr (9)+Chr (32)) & " does not exist. Can't continue."): System

	If debug Then 
		Puts ("loading Map")
		Puts ("map file: [" & Trim (mapDescriptor.mapFile, Any Chr (0)+Chr (9)+Chr (32)) & "]")
		Puts ("map dimmensions: [" & mapDescriptor.mapW & "x" & mapDescriptor.mapH)
	End If

	fIn = FreeFile
	Open Trim (mapDescriptor.mapFile, Any Chr (0)+Chr (9)+Chr (32)) For Binary As #fIn
	For y = 0 To mapDescriptor.mapH * mapDescriptor.scrH - 1
		yScr = y Mod mapDescriptor.scrH
		yMap = y \ mapDescriptor.scrH
		For x = 0 To mapDescriptor.mapW * mapDescriptor.scrW - 1
			xScr = x Mod mapDescriptor.scrW
			xMap = x \ mapDescriptor.scrW

			Get #fIn, , d
			mapData (xMap, yMap, xScr, yScr) = d
	Next x, y
	Close #fIn
End Sub

Sub loadProjectAssets
	Dim As Integer fIn
	Dim As uByte d 
	Dim As Integer xP, yP, i
	Dim As String dummy

	fIn = FreeFile
	Open enemsFn For Binary As #fIn

	dummy = Input (261, fIn)

	' Read enems
	For yP = 0 To mapDescriptor.mapH - 1
		For xP = 0 To mapDescriptor.mapW - 1
			For i = 0 To mapDescriptor.nenems - 1
				Get #fIn, , d: enems (xP, yP, i).t = d
				Get #fIn, , d
				If d >= mapDescriptor.scrW Then d = 0 
				enems (xP, yP, i).x = d
				Get #fIn, , d
				If d >= mapDescriptor.scrH Then d = 0 
				enems (xP, yP, i).y = d
				Get #fIn, , d
				If d >= mapDescriptor.scrW Then d = 0 
				enems (xP, yP, i).xx = d
				Get #fIn, , d
				If d >= mapDescriptor.scrH Then d = 0 
				enems (xP, yP, i).yy = d
				Get #fIn, , d: enems (xP, yP, i).n = d
				Get #fIn, , d: enems (xP, yP, i).s1 = d
				Get #fIn, , d: enems (xP, yP, i).s2 = d
	Next i, xP, yP

	' Read hotspots
	For yP = 0 To mapDescriptor.mapH - 1
		For xP = 0 To mapDescriptor.mapW - 1
			Get #fIn, , d
			If d > mapDescriptor.scrW Then d = 0
			hotspots (xP, yP).x = d
			Get #fIn, , d
			If d > mapDescriptor.scrH Then d = 0
			hotspots (xP, yP).y = d
			Get #fIn, , d: hotspots (xP, yP).t = d

			' Safe
			If hotspots (xP, yP).t = 0 Then 
				hotspots (xP, yP).x = 0
				hotspots (xP, yP).y = 0
			End If
	Next xP, yP

	Close #fIn
End Sub

Sub renderMap (xP As Integer, yP As Integer)
	Dim As Integer x, y, xr, yr
	Dim As Integer d
	yr = options.mapViewOffsetY
	For y = 0 To mapDescriptor.scrH - 1
		xr = options.mapViewOffsetX
		For x = 0 To mapDescriptor.scrW - 1
			d = mapData (xP, yP, x, y) - mapDescriptor.adjust
			If d >= 0 Then Put (xr, yr), tiles (d), PSET Else Line (xr, yr) - (xr + 15, yr + 15), RGB (255,100,0), BF
			If options.drawGrid Then
				Line (xr + ratio - 1, yr)-(xr + ratio - 1, yr + ratio - 1), RGBA (127, 127, 127, 64)
				Line (xr, yr + ratio - 1)-(xr + ratio - 1, yr + ratio - 1), RGBA (127, 127, 127, 64)
			End If
			xr = xr + ratio
		Next x
		yr = yr + ratio
	Next y
End Sub

Sub coverme (x0 As Integer, y0 As Integer)
	Line (x0 + 1, y0 + 1) - (x0 + 14, y0 + 14), RGB (0, 0, 0), BF
End Sub

Sub drawFirstBox (xC As Integer, yC As Integer, n As Integer)
	Dim As Integer x0, y0
	x0 = options.mapViewOffsetX + xC * ratio + offsetr
	y0 = options.mapViewOffsetY + yC * ratio + offsetr
	coverme x0, y0
	Line (x0 + 2, y0 + 2) - (x0 + 13, y0 + 13), RGB (255,220,120), BF
	Line (x0 + 2, y0 + 2) - (x0 + 13, y0 + 13), RGB (255,200,100), B

	drawThinHexNumber2 x0 + 4, y0 + 4, RGB (40, 40, 40), RGB (255,200,100), n
End Sub

Sub drawLastBox (xC As Integer, yC As Integer, n As Integer)
	Dim As Integer x0, y0
	x0 = options.mapViewOffsetX + xC * ratio + offsetr
	y0 = options.mapViewOffsetY + yC * ratio + offsetr
	'coverme x0, y0
	Circle (x0 + 8, y0 + 8), 6, RGB (0, 0, 0), , , , F
	Circle (x0 + 8, y0 + 8), 5, RGB (255,220,120), , , , F

	drawThinHexNumber2 x0 + 5, y0 + 4, RGB (127, 127, 127), -1, n
End Sub

Sub drawHotspot (xC As Integer, yC as Integer, n as Integer)
	Dim As Integer x0, y0
	x0 = options.mapViewOffsetX + xC * ratio + offsetr
	y0 = options.mapViewOffsetY + yC * ratio + offsetr
	coverme x0, y0
	Line (x0 + 2, y0 + 2) - (x0 + 13, y0 + 13), RGB (255, 100, 10), BF
	Line (x0 + 2, y0 + 2) - (x0 + 13, y0 + 13), RGB (255, 100, 10), B

	Line (x0 + 2, y0) - (x0 + 13, y0), RGB (255, 100, 10)
	Line (x0 + 13, y0) - (x0 + 15, y0 + 2), RGB (255, 100, 10)
	Line (x0 + 15, y0 + 2) - (x0 + 15, y0 + 13), RGB (255, 100, 10)
	line (x0 + 15, y0 + 13) - (x0 + 13, y0 + 15), RGB (255, 100, 10)
	Line (x0 + 13, y0 + 15) - (x0 + 2, y0 + 15), RGB (255, 100, 10)
	Line (x0 + 2, y0 + 15) - (x0, y0 + 13), RGB (255, 100, 10)
	Line (x0, y0 + 13) - (x0, y0 + 2), RGB (255, 100, 10)
	Line (x0, y0 + 2) - (x0 + 2, y0), RGB (255, 100, 10)

	drawThinHexNumber2 x0 + 4, y0 + 4, RGB (40, 40, 40), RGB (255, 100, 10), n
End Sub

Sub drawLine (x0 As Integer, y0 As Integer, x1 As Integer, y1 As Integer)
	Dim as Integer x, y
	' Gordaca	
	For y = -1 To 1
		For x = -1 To 1
			If x <> 0 Or y <> 0 Then
				Line (options.mapViewOffsetX + x0 * ratio + 8 + x + offsetr, options.mapViewOffsetY + y0 * ratio + 8 + y + offsetr) - (options.mapViewOffsetX + x1 * ratio + 8 + x + offsetr, options.mapViewOffsetY + y1 * ratio + 8 + y + offsetr), RGB (0, 0, 0)
			End if
	Next x, y
	Line (options.mapViewOffsetX + x0 * ratio + 8 + offsetr, options.mapViewOffsetY + y0 * ratio + 8 + offsetr) - (options.mapViewOffsetX + x1 * ratio + 8 + offsetr, options.mapViewOffsetY + y1 * ratio + 8 + offsetr), RGB (255, 230, 200)	
End Sub

Sub renderEnems (xP As Integer, yP As Integer)
	Dim i As Integer

	For i = 0 To mapDescriptor.nenems - 1
		If enems (xP, yP, i).t <> 0 Then
			drawLine enems (xP, yP, i).x, enems (xP, yP, i).y, enems (xP, yP, i).xx, enems (xP, yP, i).yy
			drawFirstBox enems (xP, yP, i).x, enems (xP, yP, i).y, enems (xP, yP, i).t
			drawLastBox enems (xP, yP, i).xx, enems (xP, yP, i).yy, enems (xP, yP, i).n
		End If
	Next i
End Sub

Sub renderScreen (xP As Integer, yP As Integer)
	renderMap (xP, yP)
	renderEnems (xP, yP)
	If hotspots (xP, yP).t Then drawHotspot hotspots (xP, yP).x, hotspots (xP, yP).y, hotspots (xP, yP).t
End Sub

Function countEnemsThisScreen (xP As Integer, yP As Integer) As Integer
	Dim As Integer i, res

	res = 0: For i = 0 To mapDescriptor.nenems - 1
		If enems (xP, yP, i).t <> 0 Then res = res + 1
	Next i

	Return res
End Function

Sub sve
	Get (0, 0)-(options.winW - 1, options.winH - 1), buffer
End Sub

Sub rec 
	Put (0,0), buffer, PSET
End Sub

Sub waitNoMouse
	Dim As Integer x, y, mbtn
	Do
		Getmouse x, y, , mbtn
	Loop While mbtn
End Sub

Sub removeMainButtons
	Line (options.borderLeft, options.winH - 22)-(options.borderLeft + 52 + 52 + 52, options.winH), RGB (127,127,127), BF
End Sub

Function confirmarSalida As Integer
	Dim As Integer res 
	Dim As Integer x0, y0
	Dim As Button buttonYes
	Dim As Button buttonNo

	While (MultiKey (1) Or Window_Event_close): Wend

	res = 0
	sve
	removeMainButtons

	x0 = options.winW \ 2 - 90
	y0 = options.winH \ 2 - 28

	Line (x0, y0)-(x0 + 179, y0 + 55), RGBA (127,127,127,127), BF 
	Line (x0, y0)-(x0 + 179, y0 + 55), 0, B

	Var Label_a =	Label_New	(x0 + 8, y0 + 8, 18*8, 20, "Seguro de verdad?", black, RGB (127,127,127))
	buttonYes = 	Button_New	(x0 + 8, y0 + 8 + 20, 112, 20, "Seguro, Paco")
	buttonNo = 		Button_New 	(x0 + 8 + 112 + 4, y0 + 8 + 20, 48, 20, "Huy!")

	Do
		If Button_Event (buttonYes) Then	res = -1: Exit Do
		If Button_Event (buttonNo) Then 	res = 0: Exit Do
		If Window_Event_Close Then 			res = -1: Exit Do
		If MultiKey (1) Then 				res = 0: Exit Do
		If MultiKey (SC_ENTER) Then			res = -1: Exit Do
	Loop

	rec
	While (MultiKey (1) Or Window_Event_close): Wend

	Return res
End Function

Sub noPuedesPonerMas
	Dim As Integer x0, y0
	Dim As Button buttonFuck

	sve
	removeMainButtons

	x0 = options.winW \ 2 - 64
	y0 = options.winH \ 2 - 28

	Line (x0, y0)-(x0 + 127, y0 + 55), RGBA (127,127,127,127), BF 
	Line (x0, y0)-(x0 + 127, y0 + 55), 0, B

	Var Label_a = 	Label_New 	(x0 + 8, y0 + 8, 15 * 8, 20, "Ya estan los " & mapDescriptor.nenems, black, RGB (127,127,127))
	buttonFuck = 	Button_New	(x0 + 64 - 28, y0 + 8 + 20, 56, 20, "Fuck!")

	Do
	Loop Until MultiKey (1) Or MultiKey (SC_ENTER) Or Button_Event (buttonFuck)

	rec
End Sub

Sub grabadoPerfe
	Dim As Integer x0, y0
	Dim As Button buttonOk

	sve
	removeMainButtons

	x0 = options.winW \ 2 - 64
	y0 = options.winH \ 2 - 28

	Line (x0, y0)-(x0 + 127, y0 + 55), RGBA (127,127,127,127), BF 
	Line (x0, y0)-(x0 + 127, y0 + 55), 0, B

	Var Label_a = 	Label_New 	(x0 + 8, y0 + 8, 15 * 8, 20, "Grabado perfe", black, RGB (127,127,127))
	buttonOk = 	Button_New	(x0 + 64 - 28, y0 + 8 + 20, 56, 20, "OK!")

	Do
	Loop Until MultiKey (1) Or MultiKey (SC_ENTER) Or Button_Event (buttonOk)

	rec
End Sub

Function hotspotsCreateDialog (t As Integer) As Integer
	Dim As Integer res
	Dim As Integer x0, y0
	Dim As Button buttonOk
	Dim As Button buttonCancel
	Dim As TextBox textT

	res = 0
	sve
	removeMainButtons

	x0 = options.winW \ 2 - 64
	y0 = options.winH \ 2 - 28

	Line (x0, y0)-(x0 + 127, y0 + 55), RGBA (127,127,127,127), BF 
	Line (x0, y0)-(x0 + 127, y0 + 55), 0, B

	Var Label_a = 	Label_New 	(x0 + 8, y0 + 8, 10*8, 20, "Hotspot:", black, RGB (127,127,127))
	If t <> 0 Then
		textT = 		TextBox_New (x0 + 8 + 10*8, y0 + 8, 32, 20, Hex (t))
	Else 
		textT = 		TextBox_New (x0 + 8 + 10*8, y0 + 8, 32, 20, "")
	End If
	buttonOk = 		Button_New	(x0 + 8, y0 + 8 + 20, 32, 20, "OK")
	buttonCancel = 	Button_New 	(x0 + 8 + 32 + 4, y0 + 8 + 20, 40, 20, "Mal")

	Do
		TextBox_Edit (textT)

		If MultiKey (1) 		Or Button_Event (buttonCancel) 	Then res = 0: Exit Do
		If MultiKey (SC_ENTER) 	Or Button_Event (buttonOk) 		Then res = Val ("&H" & TextBox_GetText (textT)): Exit Do

		If TextBox_Event (textT) Then TextBox_Edit (textT)
	Loop

	While (MultiKey (1)): Wend

	rec
	Return res
End Function

Function enemsCreateDialogStep1 As Integer
	Dim As Integer res
	Dim As Integer x0, y0
	Dim As Button buttonOk
	Dim As Button buttonCancel
	Dim As TextBox textT

	res = 0
	sve
	removeMainButtons

	x0 = options.winW \ 2 - 64
	y0 = options.winH \ 2 - 28

	Line (x0, y0)-(x0 + 127, y0 + 55), RGBA (127,127,127,127), BF 
	Line (x0, y0)-(x0 + 127, y0 + 55), 0, B

	Var Label_a = 	Label_New 	(x0 + 8, y0 + 8, 10*8, 20, "Type H:", black, RGB (127,127,127))
	textT = 		TextBox_New (x0 + 8 + 10*8, y0 + 8, 32, 20, "")
	buttonOk = 		Button_New	(x0 + 8, y0 + 8 + 20, 32, 20, "OK")
	buttonCancel = 	Button_New 	(x0 + 8 + 32 + 4, y0 + 8 + 20, 40, 20, "Mal")

	Do
		TextBox_Edit (textT)

		If MultiKey (1) 		Or Button_Event (buttonCancel) 	Then res = 0: Exit Do
		If MultiKey (SC_ENTER) 	Or Button_Event (buttonOk) 		Then res = Val ("&H" & TextBox_GetText (textT)): Exit Do

		If TextBox_Event (textT) Then TextBox_Edit (textT)
	Loop

	While (MultiKey (1)): Wend

	rec
	Return res
End Function

Function enemsCreateDialogStep2 (ByRef a As Integer, ByRef s1 As Integer, ByRef s2 As Integer) As Integer
	Dim As Integer res
	Dim As Integer x0, y0
	Dim As Button buttonOk
	Dim As Button buttonCancel
	Dim As TextBox textA
	Dim As TextBox textS1
	Dim As TextBox textS2
	Dim As Integer which

	res = 0
	sve
	removeMainButtons

	x0 = options.winW \ 2 - 64
	y0 = options.winH \ 2 - 48

	Line (x0, y0)-(x0 + 127, y0 + 95), RGBA (127,127,127,127), BF 
	Line (x0, y0)-(x0 + 127, y0 + 95), 0, B

	Var Label_a = 	Label_New 	(x0 + 8, y0 + 8, 10*8, 20, "Attr:", black, RGB (127,127,127))
	textA = 		TextBox_New (x0 + 8 + 10*8, y0 + 8, 32, 20, "")
	
	Var Label_b = 	Label_New 	(x0 + 8, y0 + 8 + 20, 10*8, 20, "s1:", black, RGB (127,127,127))
	textS1 = 		TextBox_New (x0 + 8 + 10*8, y0 + 8 + 20, 32, 20, "")

	Var Label_c = 	Label_New 	(x0 + 8, y0 + 8 + 20 + 20, 10*8, 20, "s2:", black, RGB (127,127,127))
	textS2 = 		TextBox_New (x0 + 8 + 10*8, y0 + 8 + 20 + 20, 32, 20, "")

	buttonOk = 		Button_New	(x0 + 8, y0 + 8 + 20 + 20 + 20, 32, 20, "OK")
	buttonCancel = 	Button_New 	(x0 + 8 + 32 + 4, y0 + 8 + 20 + 20 + 20, 40, 20, "Mal")

	which = 0

	Do
		Select Case which
			Case 0: TextBox_Edit (textA)
			Case 1: TextBox_Edit (textS1)
			Case 2: TextBox_Edit (textS2)
		End Select

		If MultiKey (1) 		Or Button_Event (buttonCancel) 	Then res = 0: Exit Do
		If MultiKey (SC_ENTER) 	Or Button_Event (buttonOk) 		Then 
			a = Val ("&H" & TextBox_GetText (textA))
			s1 = Val ("&H" & TextBox_GetText (textS1))
			s2 = Val ("&H" & TextBox_GetText (textS2))
			res = -1
			Exit Do
		End If
		If MultiKey (SC_TAB) Then which = which + 1: If which = 3 Then which = 0

		If TextBox_Event (textA) Then which = 0
		If TextBox_Event (textS1) Then which = 1
		If TextBox_Event (textS2) Then which = 2
	Loop

	While (MultiKey (1)): Wend

	rec
	Return res
End Function

Function enemsEditDialog (xP As Integer, yP As Integer, _
	ByRef t As Integer, _
	ByRef x As Integer, ByRef y As Integer, _
	ByRef xx As Integer, ByRef yy As Integer, _
	ByRef a As Integer, _
	ByRef s1 As Integer, ByRef s2 As Integer) As Integer

	Dim As Integer res
	Dim As Integer x0, y0
	Dim As Button buttonOk
	Dim As Button buttonCancel
	Dim As Button buttonDelete
	Dim As TextBox textT
	Dim As TextBox textA
	Dim As TextBox textS1
	Dim As TextBox textS2
	Dim As Integer which

	res = 0
	sve
	removeMainButtons

	x0 = options.winW \ 2 - 64
	y0 = options.winH \ 2 - 58

	Line (x0, y0)-(x0 + 127, y0 + 115), RGBA (127,127,127,127), BF 
	Line (x0, y0)-(x0 + 127, y0 + 115), 0, B

	Var Label_t = 	Label_New 	(x0 + 8, y0 + 8, 10*8, 20, "Type:", black, RGB (127,127,127))
	textT = 		TextBox_New (x0 + 8 + 10*8, y0 + 8, 32, 20, Hex (t, 2))

	Var Label_a = 	Label_New 	(x0 + 8, y0 + 8 + 20, 10*8, 20, "Attr:", black, RGB (127,127,127))
	textA = 		TextBox_New (x0 + 8 + 10*8, y0 + 8 + 20, 32, 20, Hex (a, 2))
	
	Var Label_b = 	Label_New 	(x0 + 8, y0 + 8 + 20 + 20, 10*8, 20, "s1:", black, RGB (127,127,127))
	textS1 = 		TextBox_New (x0 + 8 + 10*8, y0 + 8 + 20 + 20, 32, 20, Hex (s1, 2))

	Var Label_c = 	Label_New 	(x0 + 8, y0 + 8 + 20 + 20 + 20, 10*8, 20, "s2:", black, RGB (127,127,127))
	textS2 = 		TextBox_New (x0 + 8 + 10*8, y0 + 8 + 20 + 20 + 20, 32, 20, Hex (s2, 2))

	buttonOk = 		Button_New	(x0 + 8, y0 + 8 + 20 + 20 + 20 + 20, 32, 20, "OK")
	buttonCancel = 	Button_New 	(x0 + 8 + 32 + 4, y0 + 8 + 20 + 20 + 20 + 20, 32, 20, "No")
	buttonDelete = 	Button_New 	(x0 + 8 + 32 + 4 + 32 + 4, y0 + 8 + 20 + 20 + 20 + 20, 24, 20, "X")

	which = 0

	Do
		Select Case which
			Case 0: TextBox_Edit (textT)
			Case 1: TextBox_Edit (textA)
			Case 2: TextBox_Edit (textS1)
			Case 3: TextBox_Edit (textS2)
		End Select

		If 							Button_Event (buttonDelete) Then res = 0: Exit Do
		If MultiKey (1) 		Or 	Button_Event (buttonCancel)	Then res = -1: Exit Do
		If MultiKey (SC_ENTER)	Or 	Button_Event (buttonOk) 	Then 
			t = Val ("&H" & TextBox_GetText (textT))
			a = Val ("&H" & TextBox_GetText (textA))
			s1 = Val ("&H" & TextBox_GetText (textS1))
			s2 = Val ("&H" & TextBox_GetText (textS2))
			res = -1
			Exit Do
		End If
		If MultiKey (SC_TAB) Then which = which + 1: If which = 4 Then which = 0

		If TextBox_Event (textT) Then which = 0		
		If TextBox_Event (textA) Then which = 1
		If TextBox_Event (textS1) Then which = 2
		If TextBox_Event (textS2) Then which = 3
	Loop

	While (MultiKey (1)): Wend

	rec
	Return res
End Function

Function readCursors As uByte
	Dim As uByte res 
	res = 0
	If MultiKey (SC_LEFT) Then 	res = res Or CS_LEFT
	If MultiKey (SC_RIGHT) Then res = res Or CS_RIGHT
	If MultiKey (SC_UP) Then 	res = res Or CS_UP
	If MultiKey (SC_DOWN) Then 	res = res Or CS_DOWN
	If MultiKey (SC_S) Then 	res = res Or CS_SAVE
	If MultiKey (SC_G) Then 	res = res Or CS_GRID
	If MultiKey (SC_MINUS) Then res = res Or CS_MINUS
	If MultiKey (SC_PLUS) Then 	res = res Or CS_PLUS

	Return res
End Function

Sub storeCurrentEnem (xP As Integer, yP As Integer)
	Dim i As Integer

	'' guaranteed to find a slot.
	For i = 0 To mapDescriptor.nenems - 1
		If enems (xP, yP, i).t = 0 Then
			enems (xP, yP, i).t = currentEnem.t 
			enems (xP, yP, i).x = currentEnem.x
			enems (xP, yP, i).xx = currentEnem.xx
			enems (xP, yP, i).y = currentEnem.y
			enems (xP, yP, i).yy = currentEnem.yy
			enems (xP, yP, i).n = currentEnem.n
			enems (xP, yP, i).s1 = currentEnem.s1
			enems (xP, yP, i).s2 = currentEnem.s2
			Exit For
		End If
	Next i
End Sub

Sub processLeftClick (xP As Integer, yP As Integer, xC As Integer, yC As Integer)
	Dim As Integer t, x, y, xx, yy
	Dim As Integer a, s1, s2
	Dim As Integer enemsThisScreen
	Dim As Integer i, newOne, which

	Select Case editingState
		case STATE_INITIAL:
			newOne = -1

			' Detect an edit
			For i = 0 To mapDescriptor.nenems - 1
				If enems (xP, yP, i).t <> 0 and enems (xP, yP, i).x = xC And enems (xP, yP, i).y = yC Then
					newOne = 0: which = i
					Exit For
				End If
			Next i

			If newOne Then
				currentEnem.xx = 0
				currentEnem.yy = 0
				currentEnem.n = 0
				enemsThisScreen = countEnemsThisScreen (xP, yP)
				If enemsThisScreen < mapDescriptor.nenems Then
					t = enemsCreateDialogStep1 ()
					If t Then
						' Draw Enemy box
						currentEnem.t = t
						currentEnem.x = xC
						currentEnem.y = yC
						drawFirstBox currentEnem.x, currentEnem.y, currentEnem.t
						editingState = STATE_LAYINGOUTENEMY
					End If
				Else 
					noPuedesPonerMas
				End If
			Else
				t = enems (xP, yP, which).t 
				x = enems (xP, yP, which).x
				y = enems (xP, yP, which).y
				xx = enems (xP, yP, which).xx
				yy = enems (xP, yP, which).yy
				a = enems (xP, yP, which).n
				s1 = enems (xP, yP, which).s1
				s2 = enems (xP, yP, which).s2
				If enemsEditDialog (xP, yP, t, x, y, xx, yy, a, s1, s2) Then
					enems (xP, yP, which).t = t
					enems (xP, yP, which).x = x 
					enems (xP, yP, which).y = y 
					enems (xP, yP, which).xx = xx
					enems (xP, yP, which).yy = yy
					enems (xP, yP, which).n = a
					enems (xP, yP, which).s1 = s1
					enems (xP, yP, which).s2 = s2
				Else 
					enems (xP, yP, which).t = 0
				End If
				renderScreen xP, yP
			End If
		case STATE_LAYINGOUTENEMY:
			If enemsCreateDialogStep2 (a, s1, s2) Then
				currentEnem.xx = xC
				currentEnem.yy = yC
				currentEnem.n = a
				currentEnem.s1 = s1
				currentEnem.s2 = s2
				drawLine currentEnem.x, currentEnem.y, currentEnem.xx, currentEnem.yy
				drawFirstBox currentEnem.x, currentEnem.y, currentEnem.t
				drawLastBox currentEnem.xx, currentEnem.yy, currentEnem.n

				storeCurrentEnem xP, yP
			Else 
				renderScreen xP, yP
			End If
			editingState = STATE_INITIAL
	End Select
End Sub

Sub processRightClick (xP As Integer, yP As Integer, xC As Integer, yC As Integer)
	Dim as integer t 

	If xC = hotspots (xP, yP).x And yC = hotspots (xP, yP).y Then 
		t = hotspotsCreateDialog (hotspots (xP, yP).t)
	Else
		t = hotspotsCreateDialog (0)
	End If

	If t Or (xC = hotspots (xP, yP).x And yC = hotspots (xP, yP).y) Then 
		hotspots (xP, yP).t = t 
		hotspots (xP, yP).x = xC
		hotspots (xP, yP).y = yC
		'If t Then drawHotspot hotspots (xP, yP).x, hotspots (xP, yP).y, hotspots (xP, yP).t
		renderScreen xP, yP
	End If
End Sub

' Controls
Dim As Button buttonSave
Dim As Button buttonExit
Dim As Button buttonGrid
Dim As Button buttonReload

' Variables
Dim As Integer xP, yP, xPO, yPO, xC, yC, xCO, yCO, mx, my, mbtn
Dim As uByte keys, keysTF

'' Main
If Not parseInput () Then
	usage
	End
End If

'' Project info is already loaded, so
initOptions

'' Create window
OpenWindow options.winW, options.winH, "Mojon Twins' Ponedowr"

buffer = ImageCreate (options.winW, options.winH, 0)

'' Load stuff
prepareAssets
loadMap
cutTileSet
If doLoad Then loadProjectAssets

'' Create buttons 
buttonSave = Button_New (options.borderLeft, options.winH - 22, 48, 20, "Save")
buttonExit = Button_New (options.borderLeft + 52, options.winH - 22, 48, 20, "Exit")
buttonGrid = Button_New (options.borderLeft + 52 + 52, options.winH - 22, 48, 20, "Grid")
buttonReload = Button_New (options.borderLeft + 52 + 52 + 52, options.winH - 22, 56, 20, "Reload")

'' Last things
editingState = 0
xP = 0: yP = 0: xPO = &HFF: yPO = &HFF
xCO = &HFF: yCO = &HFF

'' And the loop
Do 
	'' Keys status
	keysTF = keys
	keys = readCursors						' Keys pressed
	keysTF = (keysTF Xor keys) And keys 	' Keys pressed THIS frame

	If xP <> xPO Or yP <> yPO Then
		editingState = STATE_INITIAL
		renderScreen xP, yP
		xPO = xP: yPO = yP
		SetText _
			options.borderLeft, 0, _
			18*8, 16, _
			"XP:" & Hex (xP, 2) & " YP:" & Hex (yP, 2) & " NP:" & Hex ((yP * mapDescriptor.mapW + xP), 2), _
			0, RGB (127, 127, 127)
		Sve
	End If

	'' Get mouse
	Getmouse mx, my, , mbtn

	'' Inside area?
	If 	mx >= options.mapViewOffsetX And mx < options.mapViewOffsetX + ratio * mapDescriptor.scrW And _
		my >= options.mapViewOffsetY And my < options.mapViewOffsetY + ratio * mapDescriptor.scrH Then

		xC = (mx - options.mapViewOffsetX) \ ratio
		yC = (my - options.mapViewOffsetY) \ ratio

		If xC <> xCO Or yC <> yCO Then
			SetText options.winW - options.borderRight - 60, 0, 8*8, 16, "X:" & Hex (xC, 1) & " Y:" & Hex (yC, 1), 0, RGB (127, 127, 127)
			xCO = xC: yCO = yC
		End If

		If editingState = STATE_LAYINGOUTENEMY Then
			If xC <> currentEnem.x Or yC <> currentEnem.y Then
				If xC <> currentEnem.xx Or yC <> currentEnem.yy Then
					currentEnem.xx = xC: currentEnem.yy = yC
					Rec
					drawLine currentEnem.x, currentEnem.y, currentEnem.xx, currentEnem.yy
					drawFirstBox currentEnem.x, currentEnem.y, currentEnem.t 
					drawLastBox currentEnem.xx, currentEnem.yy, currentEnem.n
				End If
			End If
		End If

		If mbtn And 1 Then waitNoMouse: processLeftClick xP, yP, xC, yC
		If mbtn And 2 Then waitNoMouse: processRightClick xP, yP, xC, yC
	Else 
		SetText options.winW - options.borderRight - 60, 0, 8*8, 16, "       ", 0, RGB (127, 127, 127)
		xCO = &HFF: yCO = &HFF
	End If

	'' Adjust
	If (keysTF And CS_PLUS) Then
		If mapDescriptor.adjust < 255 Then mapDescriptor.adjust = mapDescriptor.adjust + 1
		renderScreen xP, yP
	End If
	If (keysTF And CS_MINUS) Then
		If mapDescriptor.adjust > 0 Then mapDescriptor.adjust = mapDescriptor.adjust - 1
		renderScreen xP, yP
	End If

	'' Cursors move around the map
	If (keysTF And CS_LEFT) 	And xP > 0 Then 						xP = xP - 1
	If (keysTF And CS_RIGHT)	And xP < mapDescriptor.mapW - 1 Then	xP = xP + 1
	If (keysTF And CS_UP) 		And yP > 0 Then							yP = yP - 1
	If (keysTF And CS_DOWN) 	And yP < mapDescriptor.mapH - 1 Then 	yP = yP + 1

	'' Grid
	If (keysTF And CS_GRID) Or Button_Event (buttonGrid) Then
		options.drawGrid = Not options.drawGrid
		renderScreen xP, yP
		If editingState = STATE_LAYINGOUTENEMY Then drawFirstBox currentEnem.x, currentEnem.y, currentEnem.t
	End If

	'' Save
	If (keysTF And CS_SAVE) Or Button_Event (buttonSave) Then
		saveProject
		grabadoPerfe
	End If

	'' Reload
	If Button_Event (buttonReload) Then
		cutTileSet
		loadMap
		renderScreen xP, yP
	End If

	'' Exit
	If MultiKey (1) Or Button_Event (buttonExit) Or Window_Event_Close Then 
		If editingState = STATE_LAYINGOUTENEMY Then rec
		If confirmarSalida Then Exit Do 
	End If
Loop 

Color white, black
