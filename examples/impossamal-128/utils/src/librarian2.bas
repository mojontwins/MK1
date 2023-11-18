' librarian v2.1 20200823
' Copyleft 2020 by The Mojon Twins

' fbc librarian2.bas cmdlineparser.bas'

' New librarian tries a simple approach to best fit.
' We have four drawers, RAM3, RAM4, RAM6 and RAM7.
' First those are preloaded with PRELOAD?.BIN files.
' Then the whole list of files is read and their sizes is stored.
' Then such list is ordered, bigger files first.
' Then the list is run through and for every item it is placed
' In the drawer were it fits and the remaining space after being placed
' is minimal.

#include "cmdlineparser.bi"

Dim Shared As uByte drawerOrder (3) = { 3, 4, 6, 7 }
Dim Shared As uByte drawers (3, 16383)
Dim Shared As Integer drawerPtr (3)

Sub usage
	Print "usage:"
	Print
	Print "$ librarian2 list=list.txt index=output.h [bins_prefix=bins_prefix]" 
	Print "             [rams_prefix=rams_prefix] [manual]"
	Print
	Print "    * list.txt contains the list of binaries to store"
	Print "    * output.h is the output file with the index"
	Print "    * bins_prefix will be prepended to input preload?.bin & bin files"
	Print "    * rams_prefix will be prepended to output RAMn.bin files"
	Print "    * use manual for manual order."
End Sub

Sub copyToDrawer (fileNameIn As String, drawer As Integer)
	Dim As Integer fIn
	Dim As String trasiego
	Dim As uByte d

	fIn = FreeFile
	Open fileNameIn For Binary As #fIn
	If Lof (fIn) = 0 Then Close #fIn: Kill fileNameIn: Exit Sub

	Print " * Reading " & fileNameIn & " to RAM" & drawerOrder (drawer) & " (" & (Lof (fIn)) & " bytes)"

	While Not Eof (fIn)
		Get #fIn, , d
		drawers (drawer, drawerPtr (drawer)) = d
		drawerPtr (drawer) = drawerPtr (drawer) + 1
	Wend
	Close fIn
End Sub

Function MyReplace (subject As String, find As String, replace As String) As String
	Dim As Integer it
	For it = 1 To Len (subject)
		If Mid (subject, it, 1) = find Then Mid (subject, it, 1) = replace
	Next it
	Return subject
End Function

Function procruste (subject As String, n As Integer) As String
	If Len (subject) < n Then
		subject = subject + Space (n - Len (subject))
	End If
	Return subject
End Function

Type ItemType
	name As String
	size As Integer
End Type

Type IndexType
	name As String
	ram As Integer
	address As Integer
End Type

Const maxItems = 255

Dim As ItemType items (maxItems), itemTemp
Dim As IndexType index (maxItems)
Dim As String mandatoryParams (1 To 2) => { "list", "index" } 
Dim As Integer i, j, fIn, fOut, fAux
Dim As Integer itemsIdx, indexIdx
Dim As Integer selected, spaceLeft, spaceTaken, currentDrawer
Dim As String outputFilename

Print "librarian v2.1 20200823 ~ ";

sclpParseAttrs
If not sclpCheck ( mandatoryParams () ) Then usage: End

Print "GO:"

' Step one is prefit drawers with 'preload?.bin' files
Print "Reading preload?.bin files"
For i = 0 To 3
	drawerPtr (i) = 0
	copyToDrawer sclpGetValue ("bins_prefix") & "preload" & drawerOrder (i) & ".bin", i
Next i
Print

' Load list and sort by size
Print "Reading " & sclpGetValue ("list")
itemsIdx = 0
fIn = FreeFile
Open sclpGetValue ("list") For Input As #fIn
While Not Eof (fIn)
	Line Input #fIn, items (itemsIdx).name
	fAux = FreeFile
	Open sclpGetValue ("bins_prefix") & items (itemsIdx).name For Binary As #fAux
	items (itemsIdx).size = Lof (fAux)
	Close fAux
	itemsIdx = itemsIdx + 1
Wend
Close #fIn

If sclpGetValue ("manual") <> "" Then
	Print "Stuffing binaries in manual order"
	' Manual ordern: read files in order, try to fit in current drawer
	' and move to the next if it does't fit.

	currentDrawer = 0
	For i = 0 To itemsIdx - 1
		' Does it fit?
		If items (i).size + drawerPtr (currentDrawer) > 16384 Then
			currentDrawer = currentDrawer + 1
			If currentDrawer = 4 Then Print "Ooops, can't fit all bins. Try reordering."
		End If

		' Add to index
		index (indexIdx).ram = drawerOrder (currentDrawer)
		index (indexIdx).address = drawerPtr (currentDrawer)
		index (indexIdx).name = MyReplace (MyReplace (Ucase (items (i).name), ".", "_"), "-", "_")
		indexIdx = indexIdx + 1

		' Copy to drawer
		copyToDrawer sclpGetValue ("bins_prefix") & items (i).name, currentDrawer
	Next i
Else
	Print "Sorting binaries"
	For i = 0 To itemsIdx - 1
		For j = i + 1 To itemsIdx - 1
			If items (i).size < items (j).size Then
				itemTemp.name = items (i).name
				itemTemp.size = items (i).size
				items (i).name = items (j).name
				items (i).size = items (j).size
				items (j).name = itemTemp.name
				items (j).size = itemTemp.size
			End If
		Next j
	Next i

	Print "Applying best fit algorithm"
	For i = 0 To itemsIdx - 1
		selected = -1
		spaceLeft = 16384
		For j = 0 To 3
			' Does it fit?
			spaceTaken = drawerPtr (j) + items (i).size
			If spaceTaken < 16384 Then
				' Minimize space left
				If 16384 - spaceTaken < spaceLeft Then
					selected = j 
					spaceLeft = 16384 - spaceTaken
				End If
			End If
		Next j
		If selected = -1 Then Print "Ooops, can't fit all bins. Try manual sort.": End

		' Add to index
		index (indexIdx).ram = drawerOrder (selected)
		index (indexIdx).address = drawerPtr (selected)
		index (indexIdx).name = MyReplace (MyReplace (Ucase (items (i).name), ".", "_"), "-", "_")
		indexIdx = indexIdx + 1

		' Copy to drawer
		copyToDrawer sclpGetValue ("bins_prefix") & items (i).name, selected
	Next i
End If

Print "Writing RAMs"
For i = 0 To 3
	outputFilename = sclpGetValue ("rams_prefix") & "ram" & drawerOrder (i) & ".bin"
	Kill outputFilename
	If drawerPtr (i) Then
		Print " * Writing " & outputFilename & " (" & drawerPtr (i) & " bytes)"
		fOut = FreeFile
		Open outputFilename For Binary As #fOut
		For j = 0 To drawerPtr (i) - 1
			Put #fOut, , drawers (i, j)
		Next j
		Close #fOut
	End If
Next i

Print "Writing Index & imports to " & sclpGetValue ("index")
fOut = FreeFile
Open sclpGetValue ("index") For Output As #fOut

Print #fOut, "// MTE MK1 (la Churrera) v5.0"
Print #fOut, "// Copyleft 2010-2014, 2020 by the Mojon Twins"
Print #fOut, ""

Print #fOut, "// Generated by The Librarian v2.1 20200823"
Print #fOut, "// Copyleft 2020 by The Mojon Twins"
Print #fOut, ""

Print #fOut, "typedef struct {"
Print #fOut, "    unsigned char ramPage;"
Print #fOut, "    unsigned int ramOffset;"
Print #fOut, "} RESOURCE;"
Print #fOut, ""
Print #fOut, "RESOURCE resources [] = {"

For i = 0 To indexIdx - 1
	Print #fOut, "    { " & index (i).ram & ", 0x" & Hex (&HC000 + index (i).address, 4) & " }";
	If i < indexIdx - 1 then Print #fOut, "," Else Print #fOut, ""
Next i

Print #fOut, "};"
Print #fOut, ""

For i = 0 To indexIdx - 1
	Print #fOut, "#define " & procruste (index (i).name, 32) & i
Next i
Print #fOut, ""

Close #fOut

Print "Done."
