Function sizeOfFile (fileName As String) As Integer
	Dim res As Integer
	Dim fDum As Integer
	fDum = FreeFile
	Open fileName For Binary As fDum
	res = Lof (fDum)
	Close fDum
	sizeOfFile = res
End Function

If Command (1) = "" Then
	Print " Build Music Binary"
	Print " =================="
	Print
	Print " This simple program is used to automaticly build the music/sfx system binary"
	Print " Arkos needs too much manual work which I hate, so that's why this program has"
	Print " been created."
	Print
	Print " This program needs song_list.txt with a list of .aks files to be included."
	Print " Place a < symbol next to one of the songs so it will be used as the 'sfx' song"
	Print 
	Print " This program also generates arkos_addresses.h which should be copied to /dev"
	Print " arkos_player_zx.asm must exist."
	Print
	Print " ../utils/pasmo.exe must exist."
	Print " ../utils/akstobin.exe must exist."
	Print
	Print "To run use ""build_mus_bin output.bin"""
	System
End If

Dim As Integer baseAddress
Dim As Integer fIn, fOut, i
Dim As Integer songPoolBaseAddress, curSongAddress
Dim As Integer size, order, sfxSong, equPost
Dim As String songFile
Dim As String curLine
Dim As String songList
Dim As String label, address
Dim As String labelsToFind (0 To 9) => {"atInit", "atplay", "atStop", "atSfxInit", "atSfxPlay", "atSfxStop", "atSfxStopAll", "SONG_LIST", "SFXS_SONG"}

baseAddress = &HC000
fOut = FreeFile
Open "temp.asm" for Output as #fOut

Print #fOut, "; temp.asm"
Print #fOut, "; Automaticly generated using build_mus_bin.exe by The Mojon Twins"
print #fOut, " "
print #fOut, "org #C000"
Print "Calculating player size"
Print "    Assembling arkos_player_zx.asm"
Shell "..\utils\pasmo.exe arkos_player_zx.asm arkos_player_zx.bin"
Print "    Calculating size..."
size = sizeOfFile ("arkos_player_zx.bin")
Print "    Player is " & Hex(size) & " bytes"
songPoolBaseAddress = baseAddress + size
Print "Song pool to be loaded @ " & Hex(songPoolBaseAddress)

Print #fOut, ""
Print #fOut, "arkos:"
Print #fOut, "    include ""arkos_player_zx.asm"""
Print #fOut, ""
Print #fOut, "song_pool:"
Print #fOut, ""

Print "Processing song list @ song_list.txt"

curSongAddress = songPoolBaseAddress
order = 0
songList = "    defw "

fIn = freeFile
Open "song_list.txt" for Input as #fIn
While Not Eof(fIn)
	Line Input #fIn, songFile
	songFile = Trim (songFile, Any chr (32) + chr (9))
	
	If len (songFile) > 0 Then
		Print "Procesing song #" & order & ": " & songFile
		If Right (songFile, 1) = "<" Then
			sfxSong = -1
			songFile = Left (songFile, Len (songFile) - 1)
			Print "    Compiling " & songFile & " @ " & Hex (curSongAddress) & " [ SFX SONG ]"
			Shell "..\utils\akstobin.exe -s -a " & curSongAddress & " " & songFile & " " & songFile & ".bin"		
		Else
			Print "    Compiling " & songFile & " @ " & Hex (curSongAddress)
			sfxSong = 0
			Shell "..\utils\akstobin.exe -a " & curSongAddress & " " & songFile & " " & songFile & ".bin"
		End If
		size = sizeOfFile (songFile & ".bin")
		Print "    File is " & hex (size) & " bytes"
		Print "    Adding include to output..."
		If sfxSong Then Print #fOut, "SFXS_SONG:"
		Print #fOut, "SONG_" & order & ":"
		Print #fOut, "    ; Address is " & "0x" & Hex(curSongAddress)
		Print #fOut, "    incbin " & songFile & ".bin"
		Print #fOut, ""
		
		If order > 0 Then songList = songList & ", "
		songList = songList & "SONG_" & order
		
		curSongAddress = curSongAddress + size	
		order = order + 1
	End If
Wend
Close (fIn)

Print "Adding song list to output."
Print #fOut, "song_list:"
Print #fOut, songList
Print #fOut, ""

Print "Pasting sfx.asm"

Close fOut

Print "Assembling..."
Shell "..\utils\pasmo.exe temp.asm " & Command (1) & " list.txt"
Print "    lst file is list.txt."

Print "Generating arkos-addresses.h"
fIn = FreeFile
Open "list.txt" For Input as #fIn
fOut = FreeFile
Open "arkos-addresses.h" For Output as #fOut

While Not Eof (fIn)
	Line Input #fIn, curLine
	curLine = Trim (curLine)
	equPost = Instr (curLine, "EQU")
	
	If equPost > 0 Then
		' cut label and address
		label = trim (left (curLine, equPost - 1), Any chr (32) + chr (9))
		address = trim (right (curLine, len (curLine) - (equPost - 1) - 3), Any chr (32) + chr (9))
		address = "0x" + lcase (ltrim (left (address, len (address) - 1), "0"))

		
		' find
		For i = 0 To uBound (labelsToFind)
			If ucase (label) = ucase (labelsToFind (i)) Then
				print #fOut, "#define " + ucase (label) + " " + address
				print "#define " + ucase (label) + " " + address
				Exit For
			End If
		Next i
	End If
Wend

Close fIn
Close fOut

Print "DONE COJONE!"


