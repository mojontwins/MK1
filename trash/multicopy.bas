' multicopy 

#include once "file.bi"
#include once "dir.bi"

Sub usage
	Print "$ multicopy origin dest1 dest2 ..."
End Sub

Dim As Integer cmdIt
Dim As String fileName
Dim As String fileDest
Dim As String dirSpec
Dim As Integer outAttrib
Dim As Integer i

If Len (Command (2)) = 0 Then usage: End

If Instr (Command (1), "\") Then
	fileName = ""
	i = Len (Command (1))
	While Mid (Command (1), i, 1) <> "\"
		fileName = Mid (Command (1), i, 1) & fileName
		i = i - 1
	Wend
Else
	fileName = Command (1)
End If

cmdIt = 2
Do
	If Len (Command (cmdIt)) = 0 Then Exit Do 
	fileDest = Command (cmdIt)

	' is directory?
	If Right (fileDest, 1) = "\" Then 
		fileDest = fileDest & fileName
	Else
		dirSpec = Dir (fileDest, &H77, outAttrib)
		If outAttrib And fbDirectory Then
			If Right (fileDest, 1) <> "\" Then fileDest = fileDest & "\"
			fileDest = fileDest & fileName
		End If
	End If
	
	If FileCopy (Command (1), fileDest) Then
		Print "Couldn't copy " & Command (1) & " -> " & fileDest
	Else 
		Print Command (1) & " -> " & fileDest
	End If 
	cmdIt = cmdIt + 1
Loop
