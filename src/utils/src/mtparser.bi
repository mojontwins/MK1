' General text parsing routines
' Copyleft 2016 The Mojon Twins

Declare Sub parseCoordinatesString (coordsString as String, coords () As Integer)
Declare Sub parseCoordinatesStringCustom (coordsString as String, separator As String, coords () As Integer)
Declare Sub parseTokenizeString (inString As String, tokens () As String, ignore As String, break As String)
Declare Function parserFindTokenInTokens (token As String, tokens () As String, modifier As String) As Integer
Declare Sub parseCleanTokens (tokens () As String)
Declare Function parseGlueTokens (tokens () As String) As String
Declare Function initialWhiteSpace (line As String) As String

