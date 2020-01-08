Sub Usage
	Print "flipmap in.map out.map width height [horz] [vert]"
	?
	Print "in.map         Input"
	Print "out.map        Output"
	Print "width, height  Map size in tiles"
	Print "horz           Flip horizontally"
	Print "vert           Flip vertically"
	Print
End Sub

Dim As String mapInFn, mapOutFn
Dim As Byte d
Redim As Byte map (0, 0), mapOut (0, 0)
Dim As Integer mapWidth, mapHeight, flipHorz, flipVert
Dim As Integer x, y, f1

mapInFn = Command (1)
mapOutFn = Command (2)
mapWidth = Val (Command (3))
mapHeight = Val (Command (4))

If Command (5) = "horz" Or Command (6) = "horz" then flipHorz = -1 Else flipHorz = 0
If Command (6) = "vert" Or Command (5) = "vert" then flipVert = -1 Else flipVert = 0

If mapInFn = "" Or mapOutFn = "" Or mapWidth = 0 Or mapHeight = 0 Or (flipHorz = 0 And flipVert = 0) Then
	Usage
	End
End If

' Wtf
Redim map (mapHeight - 1, mapWidth - 1)
Redim mapOut (mapHeight - 1, mapWidth - 1)

' Read in
f1 = FreeFile
Open mapInFn For Binary as #f1

For y = 0 To mapHeight - 1
	For x = 0 To mapWidth - 1
		get #f1, , map (y, x)
	Next x
Next y

Close #f1

' Flip horz
If flipHorz Then
	For y = 0 To mapHeight - 1
		For x = 0 To mapWidth - 1
			mapOut (y, x) = map (y, mapWidth - 1 - x)
		Next x
	Next y
	For y = 0 To mapHeight - 1
		For x = 0 To mapWidth - 1
			map (y, x) = mapOut (y, x)
		Next x
	Next y
End If

' Flip vert
If flipVert Then
	For y = 0 To mapHeight - 1
		For x = 0 To mapWidth - 1
			mapOut (y, x) = map (mapHeight - 1 - y, x)
		Next x
	Next y
End If

' Write out
f1 = FreeFile
Open mapOutFn For Binary as #f1
For y = 0 To mapHeight - 1
	For x = 0 To mapWidth - 1
		put #f1, , mapOut (y, x)
	Next x
Next y
Close #f1

? "Done!"
