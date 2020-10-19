'' sprcnv3.bas v0.1.20201019 for MTE MK1 ZX v6

#define RGBA_R( c ) ( CUInt( c ) Shr 16 And 255 )
#define RGBA_G( c ) ( CUInt( c ) Shr  8 And 255 )
#define RGBA_B( c ) ( CUInt( c )        And 255 )
#define RGBA_A( c ) ( CUInt( c ) Shr 24         )

#include "cmdlineparser.bi"
#include "mtparser.bi"

Dim Shared As uByte mainBin (16383)
Dim Shared As uInteger mainBinIndex
Dim Shared As Any Ptr img
Dim Shared As Integer imgW, imgH

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

Sub usage ()
	Print "usage: "
	Print "$ sprncv3 sprites.png [bin_prefix=./] [def_prefix=assets/] [player_size=16x16]"
	Print "          [enems_size=16x16] [player_frames=8] [enems_frames=8] [player_pos=0,0]"
	Print "			 [enems_pos=0,16]"
	Print
	Print "Where"
	Print "          sprites.png   - input file with the graphics."
	Print "          bin_prefix    - where to store sprites_enems.bin & sprites_player.bin"
	Print "          def_prefix    - where to store spritedef_enems.h & spritedef_player.h"
	Print "          player_size   - player sprite size, 16x16|16x24|16x32"
	Print "          enems_size    - enemies sprite size, 16x16|16x24|16x32"
	Print "          player_frames - # of player frames"
	Print "          enems_frames  - # of enemy frames"
	Print "          player_pos    - Offset x,y in png where player sprites are found"
	Print "          enems_pos     - Offset x,y in png where enemy sprites are found"
	Print
End Sub

Sub writeToBin (d As uByte)
	mainBin (mainBinIndex) = d
	mainBinIndex = mainBinIndex + 1
End Sub

Function getBitmap (x0 As Integer, y0 As Integer) As uByte
	Dim As uByte res
	Dim As Integer x, c

	res = 0
	For x = 0 To 7
		c = Point (x0 + 7 - x, y0, img) 
		If RGBA_R (c) + RGBA_G (c) + RGBA_B (c) <> 0 Then 
			res = res + 2 ^ x
		End If
	Next x

	Return res
End Function

Sub cutSpriteSet (x0 As Integer, y0 As Integer, nFrames As Integer, spriteSize As String, defsFilename As String, isEnems As Integer)
	Dim As Integer sprW, sprH, sprCols, sprRows
	Dim As Integer spriteColumnByteSize
	Dim As Integer spriteCellByteSize
	Dim As Integer x, y, xx, yy, sprI, fOut, i

	mainBinIndex = 0

	Select Case spriteSize
		Case "16x16": sprW = 16: sprH = 16
		Case "16x24": sprW = 16: sprH = 24
		Case "16x32": sprW = 16: sprH = 32
		Case Else
			Puts "Wrong sprite size " & spriteSize ".": End
	End Select

	sprCols = 1 + sprW\8
	sprRows = 1 + sprH\8

	spriteColumnByteSize = sprRows * 2 * 8
	spriteCellByteSize = spriteColumnByteSize * sprCols

	x = x0: y = y0
	For sprI = 1 To nFrames
		' For each sprite face

		' Do image columns
		For xx = 0 To sprW - 1 Step 8
			' Do image rows
			For yy = 0 To sprH - 1
				writeToBin getBitmap (x + xx, y + yy) 			' face
				writeToBin getBitmap (x + xx + sprW, y + yy) 	' mask
			Next yy

			' Do extra blank row
			For yy = 0 To 7
				writeToBin 0
				writeToBin 255
			Next yy
		Next xx

		' Do extra blank column
		For yy = 0 To sprH + 7
			writeToBin 0
			writeToBin 255
		Next yy

		' Next sprite face
		x = x + sprW*2: If x > imgW Then x = x0: y = y + imgH
	Next sprI

	' Write definitions
	fOut = FreeFile
	Open defsFilename For Output As fOut

	Print #fOut, "// MTE MK1 (la Churrera) v6"
	Print #fOut, "// Copyleft 2010-2014, 2020 by the Mojon Twins"
	Print #fOut, ""

	If isEnems Then 
		Print #fOut, "for (gpit = 0; gpit < MAX_ENEMS; gpit ++) {"
		varName = "sp_moviles [gpit]"
		ptrName = "sprites_enems"		
	Else
		varName = "sp_player"
		ptrName = "sprites_player"
	End If

	Print #fOut, "	" & varName & " = sp_CreateSpr (sp_MASK_SPRITE, 3, " & ptrName & ");"
	
	curOffs = 0
	For i = 2 To sprCols
		Print #fOut, "	sp_AddColSpr (" & varName & ",  " & ptrName & " + " & curOffs & ");"
		curOffs = curOffs + spriteColumnByteSize
	Next i 

	If isEnems Then 
		Print #fOut, "	en_an_current_frame [gpit] = en_an_next_frame [gpit] = " & ptrName & ";"
		Print #fOut, "}"
	Else
		Print #fOut, "	p_current_frame = p_next_frame = " & ptrName & ";"
	End If

	Close fOut

	' Write binary
	
End Sub

Dim As String inFilename, outFilename, defPrefix, binPrefix
Dim As String playerSize, enemsSize
Dim As Integer playerFrames, enemsFrames
Dim As Integer pX0, pY0, eX0, eY0
Dim As Integer coords (7)

'' Parse the command line 

Print "sprcnv3 v0.1.20201019 for MTE MK1 ZX v6";
If Command (1) = "" Then usage: End

inFilename = Command (1)

sclpParseAttrs

defPrefix = sclpGetValue ("def_prefix")
If Len (defPrefix > 0) Then
	If Right (defPrefix, 1) <> "/" And Right (defPrefix, 1) <> Chr(92) Then defPrefix = defPrefix & "/"
End If
If defPrefix = "" Then defPrefix = "assets/"

binPrefix = sclpGetValue ("bin_prefix")
If Len (binPrefix > 0) Then
	If Right (binPrefix, 1) <> "/" And Right (binPrefix, 1) <> Chr(92) Then binPrefix = binPrefix & "/"
End If

playerSize = sclpGetValue ("player_size"): If playerSize = "" Then playerSize = "16x16"
enemsSize = sclpGetValue ("enems_size"): If enemsSize = "" Then enemsSize = "16x16"
playerFrames = sclpGetValue ("player_frames"): If playerFrames = 0 Then playerFrames = 8
enemsFrames = sclpGetValue ("enems_frames"): If enemsFrames = 0 Then enemsFrames = 8

If sclpGetValue ("player_pos") <> "" Then
	parseCoordinatesString sclpGetValue ("player_pos"), coords ()
	pX0 = coords (0): pY0 = coords (1)
Else
	pX0 = 0: pY0 = 0
End If

If sclpGetValue ("enems_pos") <> "" Then
	parseCoordinatesString sclpGetValue ("enems_pos"), coords ()
	eX0 = coords (0): eY0 = coords (1)
Else
	eX0 = 0: eY0 = 0
End If

screenres 640, 480, 32, , -1

'' Open input
img = png_load (inFilename)

If img Then
	If ImageInfo (img, imgW, imgH, , , , ) Then
		Puts ("Something wrong happened"): End
	End If
Else 
	Puts "Failed to load": System
End If

'' Cut player spriteset
cutSpriteSet pX0, pY0, playerFrames, playerSize, defPrefix & "spritedef_player.h", binPrefix & "sprites_player.bin", 0

'' Cut enemies spriteset
cutSpriteSet eX0, eY0, enemsFrames, enemsSize, defPrefix & "spritedef_enems.h", binPrefix & "sprites_enems.bin", -1

Puts ("DONE")
