' Simple command line parser
' Use this with your own command line apps.
' Copyleft 2015 by na_th_an

' Commands are in the form key=value. No spaces. Please.

' Keys are case insensitive!

' This seems plenty
Const MAX_ITEMS = 255

' Store away
Dim Shared As String keys (MAX_ITEMS), values (MAX_ITEMS)
Dim Shared As Integer maxItems

Sub sclpParseAttrs ()
	Dim As Integer equalPostn

	maxItems = 0
	While Len (Command (maxItems))
		equalPostn = Instr (Command (maxItems), "=")
		If equalPostn Then
			keys (maxItems) = Lcase (Trim (Left (Command (maxItems), equalPostn - 1)))
			values (maxItems) = Trim (Right (Command (maxItems), Len (Command (maxItems)) - equalPostn))
		Else
			keys (maxItems) = Lcase (Command (maxItems))
			values (maxItems) = "%%TRUE%%"
		End If		
		
		maxItems = maxItems + 1
	Wend
End Sub

Function sclpGetValue (key As String) As String
	Dim As String value 
	Dim As Integer i
	
	value = ""
	key = Lcase (Trim (key))
	For i = 0 To maxItems - 1
		If key = keys (i) Then
			value = values (i)
			Exit For
		End If
	Next i
	
	sclpGetValue = value
End Function

Function sclpGIsDef (key As String) As Integer
	sclpGIsDef = (sclpGetValue (key) <> "")
End Function
	
Function sclpCheck (mandatory () As String) As Integer
	Dim As Integer i
	
	For i = Lbound (mandatory) To Ubound (mandatory)
		If Not sclpGIsDef (mandatory (i)) Then
			Print "**ERROR** " & mandatory (i) & " is Missing!":?
			sclpCheck = 0
			Exit Function
		End If
	Next i
	
	sclpCheck = -1
	Exit Function
End Function
