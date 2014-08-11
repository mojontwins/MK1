' Parser y compilador para los scripts de la churrera 3.
' Copyleft 2010, 2011, 2012, 2013 The Mojon Twins, los masters del código guarro.
' Compilar con freeBasic (http://www.freebasic.net).

Const LIST_WORDS_SIZE = 200
Const LIST_CLAUSULES_SIZE = 100
Dim Shared listaPalabras (LIST_WORDS_SIZE) As String
Dim Shared listaClausulasEnter (LIST_CLAUSULES_SIZE) As Integer
Dim Shared listaClausulasFire (LIST_CLAUSULES_SIZE) As Integer
Dim Shared clausulasUsed (255) As Integer
Dim Shared actionsUsed (255) As Integer
Dim Shared maxItem As Integer
Dim Shared maxFlag As Integer
Dim Shared maxNPant As Integer
Dim Shared clausulasEnterIdx As Integer
Dim Shared clausulasFireIdx As Integer
Dim Shared clausulasEnter (LIST_CLAUSULES_SIZE) As String
Dim Shared clausulasFire (LIST_CLAUSULES_SIZE) As String
Dim AddTo (LIST_WORDS_SIZE) As Integer
Dim AddToIdx As Integer
Dim Shared itemTiles (100) As Integer
Dim Shared As Integer itemSetx, itemSety, itemSetStep, itemSetOr, itemFlag, slotFlag
Dim Shared As Integer itemSelectClr, itemSelectC1, itemSelectC2

Sub dump ()
	Dim i As Integer
	For i = 0 to LIST_WORDS_SIZE
		Print "["+listaPalabras (i) + "]";
	next i
	print
end sub

Sub stringToArray (in As String)
	Dim m as Integer
	Dim index as Integer
	Dim character as String * 1
	
	for m = 1 to LIST_WORDS_SIZE: listaPalabras (m) = "": Next m
	
	index = 0
	listaPalabras (index) = ""
	in = in + " "
	
	For m = 1 To Len (in)
		character = Ucase (Mid (in, m, 1))
		If (character >= "A" and character <= "Z") or (character >= "0" and character <="9") or character = "#" or character = "_" or character = "'" or character="<" or character=">" or character="!" or character="?" or character = "." or character = "-" or character=":" Then
			listaPalabras (index) = listaPalabras (index) + character
		Else
			listaPalabras (index) = Ltrim (Rtrim (listaPalabras (index)))
			If listaPalabras (index) <> "" Then
				index = index + 1
			End If
			If character <> " " Then 
				listaPalabras (index) = character
				index = index + 1
			End If
			listaPalabras (index) = ""
		End If
	Next m
End Sub

Sub ProcesaItems (f As Integer)
	Dim terminado As Integer
	Dim linea As String
	terminado = 0
	While Not terminado
		Line input #f, linea
		linea = Trim (linea, Any chr (32) + chr (9))		
		stringToArray (linea)
		Select Case Ucase (listaPalabras (0))
			Case "SLOT_FLAG":
				slotFlag = val (listaPalabras (1))
			Case "ITEM_FLAG":
				itemFlag = val (listaPalabras (1))
			Case "LOCATION":
				itemSetX = val (listaPalabras (1))
				itemSetY = val (listaPalabras (3))	
			Case "DISPOSITION":				
				itemSetStep = val (listaPalabras (3))
				If listaPalabras (1) = "HORZ" then itemSetOr = 0 Else ItemSetOr = 1
			Case "SELECTOR":
				itemSelectClr = val (listaPalabras (1))
				itemSelectC1 = val (listaPalabras (3))
				itemSelectC2 = val (listaPalabras (5))
			Case "SIZE":
				maxItem = val (listaPalabras (1))			
			Case "END": 
				terminado = Not 0
		End Select
		If eof (f) Then terminado = Not 0
	Wend
End Sub

Sub displayMe (clausula As String) 
	Dim i As Integer
	Dim p As String
	
	For i = 1 To Len (clausula)
		p = Str (asc (mid (clausula, i, 1)))
		if Len (p) = 1 Then p = "00" + p
		If Len (p) = 2 Then p = "0" + p
		? p; 
		If i < Len (clausula) Then ? ", ";
	Next i
	Print
End Sub

Function writeMe (clausula As String) As String
	Dim res As String
	Dim i As Integer
	
	For i = 1 To Len (clausula)
		res = res + "0x" + hex (asc (mid (clausula, i, 1)), 2)
		
		If i < Len (clausula) Then res = res + ", "
	Next i
	writeMe = res
End Function

Sub writeMeNice (f As Integer, clausula As String)
	Dim ct As integer
	Dim i As integer
	ct = 0
	
	For i = 1 To Len (clausula)
		if ct Mod 16 = 0 Then
			print #f, ""
			print #f, "    defb ";
		end if
		print #f, "0x" + hex (asc (mid (clausula, i, 1)), 2);
		If i < Len (clausula) and (ct Mod 16) < 15 then  print #f, ", ";
		ct = ct + 1
	Next i
	print #f, ""
	print #f, ""
End Sub

Function pval (s as string) as integer
	Dim res as integer
	' Patch
	if s = "SLOT_SELECTED" then 
		pval = 128 + slotFlag
	elseif s = "ITEM_SELECTED" then
		pval = 128 + itemFlag
	else
		if (left(s, 1) = "#") Then
			res = 128 + val (right (s, len(s) - 1))
		Else
			res = val (s)
		End If
		pval = res
	end if
end function

Function procesaClausulas (f As integer, nPant As Integer) As String
	' Lee cláusulas de la pantalla nPant del archivo abierto f
	Dim linea As String
	Dim terminado As Integer
	Dim estado As integer
	Dim clausulas As String
	Dim clausula As String
	Dim numclausulas As Integer
	Dim longitud As Integer
	Dim ai As Integer
	
	terminado = 0
	estado = 0
	numclausulas = 0
	longitud = 0
	clausulas = ""
	clausula = ""
	
	While not terminado And Not eof (f)
		Line input #f, linea
		linea = Trim (linea, Any chr (32) + chr (9))
		'?estado & " " & linea
		'?linea ;"-";:displayMe clausula
		stringToArray (linea)
		
		if estado <> 1 then
			' Leyendo cláusulas
			Select Case listaPalabras (0)
				case "IF":
					Select Case listaPalabras (1)
						Case "PLAYER_HAS_ITEM":
							clausula = clausula + chr (&H1) + chr (pval (listaPalabras (2)))
							numClausulas = numClausulas + 1
							clausulasUsed (&H1) = -1
						Case "PLAYER_HASN'T_ITEM":
							clausula = clausula + chr (&H2) + chr (pval (listaPalabras (2)))
							numClausulas = numClausulas + 1
							clausulasUsed (&H2) = -1
						Case "SEL_ITEM":
							Select case listaPalabras (2)
								Case "=":
									clausula = clausula + chr (&H10) + chr (itemFlag) + chr (pval (listaPalabras (3)))
									numClausulas = numClausulas + 1
									clausulasUsed (&H10) = -1
								Case "<>", "!=":
									clausula = clausula + chr (&H14) + chr (itemFlag) + chr (pval (listaPalabras (3)))
									numClausulas = numClausulas + 1
									clausulasUsed (&H13) = -1
							End Select
						Case "ITEM":
							Select case listaPalabras (3)
								Case "=":
									clausula = clausula + chr (&H3) + chr (pval (listaPalabras (2))) + chr (pval(listaPalabras (4)))
									numClausulas = numClausulas + 1
									clausulasUsed (&H3) = -1
								Case "<>", "!=":
									clausula = clausula + chr (&H4) + chr (pval (listaPalabras (2))) + chr (pval(listaPalabras (4)))
									numClausulas = numClausulas + 1
									clausulasUsed (&H4) = -1
							End Select
						Case "FLAG":
							Select Case listaPalabras (3)
								Case "=":
									if listaPalabras (4) = "FLAG" Then
										clausula = clausula + chr (&H14) + chr (pval (listaPalabras (2))) + chr (pval(listaPalabras (5)))
										clausulasUsed (&H14) = -1
									Else
										clausula = clausula + chr (&H10) + chr (pval (listaPalabras (2))) + chr (pval(listaPalabras (4)))
										clausulasUsed (&H10) = -1
									End If
								Case "<":
									If listaPalabras (4) = "FLAG" Then
										clausula = clausula + chr (&H15) + chr (pval (listaPalabras (2))) + chr (pval(listaPalabras (5)))
										clausulasUsed (&H15) = -1
									Else
										clausula = clausula + chr (&H11) + chr (pval (listaPalabras (2))) + chr (pval(listaPalabras (4)))
										clausulasUsed (&H11) = -1
									End If
								Case ">":
									If listaPalabras (4) = "FLAG" Then
										clausula = clausula + chr (&H16) + chr (pval (listaPalabras (2))) + chr (pval(listaPalabras (5)))
										clausulasUsed (&H16) = -1
									Else
										clausula = clausula + chr (&H12) + chr (pval (listaPalabras (2))) + chr (pval(listaPalabras (4)))
										clausulasUsed (&H12) = -1
									End If
								Case "<>", "!=":
									If listaPalabras (4) = "FLAG" Then
										clausula = clausula + chr (&H17) + chr (pval (listaPalabras (2))) + chr (pval(listaPalabras (5)))
										clausulasUsed (&H17) = -1
									Else
										clausula = clausula + chr (&H13) + chr (pval (listaPalabras (2))) + chr (pval(listaPalabras (4)))
										clausulasUsed (&H13) = -1
									End If
							End Select
							numClausulas = numClausulas + 1
						Case "PLAYER_TOUCHES":
							clausula = clausula + chr (&H20) + chr (pval (listaPalabras (2))) + chr (pval (listaPalabras (4)))
							clausulasUsed (&H20) = -1
							numClausulas = numClausulas + 1
						Case "PLAYER_IN_X":
							clausula = clausula + chr (&H21) + chr (val (listaPalabras (2))) + chr (val (listaPalabras (4)))
							clausulasUsed (&H21) = -1
							numClausulas = numClausulas + 1
						Case "PLAYER_IN_Y":
							clausula = clausula + chr (&H22) + chr (val (listaPalabras (2))) + chr (val (listaPalabras (4)))
							clausulasUsed (&H22) = -1
							numClausulas = numClausulas + 1
						Case "ALL_ENEMIES_DEAD"
							clausula = clausula + chr (&H30)
							clausulasUsed (&H30) = -1
							numClausulas = numClausulas + 1
						Case "ENEMIES_KILLED_EQUALS"
							clausula = clausula + chr (&H31) + chr (pval (listaPalabras (2)))
							clausulasUsed (&H31) = -1
							numClausulas = numClausulas + 1
						Case "PLAYER_HAS_OBJECTS"
							clausula = clausula + chr (&H40)
							clausulasUsed (&H40) = -1
							numClausulas = numClausulas + 1
						Case "OBJECT_COUNT"
							clausula = clausula + chr (&H41) + chr (pval (listaPalabras (3)))
							clausulasUsed (&H41) = -1
							numClausulas = numClausulas + 1
						Case "NPANT"
							clausula = clausula + chr (&H50) + chr (pval (listaPalabras (2)))
							clausulasUsed (&H50) = -1
							numClausulas = numClausulas + 1
						Case "NPANT_NOT"
							clausula = clausula + chr (&H51) + chr (pval (listaPalabras (2)))
							clausulasUsed (&H51) = -1
							numClausulas = numClausulas + 1
						Case "JUST_PUSHED"
							clausula = clausula + chr (&H60)
							clausulasUsed (&H60) = -1
							numClausulas = numClausulas + 1
						Case "TIMER"
							If listaPalabras (2) = ">=" Then
								clausula = clausula + chr (&H70) + chr (pval (listaPalabras (3)))
								clausulasUsed (&H70) = -1
								numClausulas = numClausulas + 1
							ElseIf listaPalabras (2) = "<=" Then
								clausula = clausula + chr (&H71) + chr (pval (listaPalabras (3)))
								clausulasUsed (&H71) = -1
								numClausulas = numClausulas + 1
							End If
						Case "LEVEL"
							If listaPalabras (2) = "=" Then
								clausula = clausula + Chr (&H80) + chr (pval (listaPalabras (3)))
								clausulasUsed (&H80) = -1
								numClausulas = numClausulas + 1
							End If
						Case "TRUE"
							clausula = clausula + chr (&HF0)
							clausulasUsed (&HF0) = -1
							numClausulas = numClausulas + 1
					End Select
				case "THEN":
					clausula = clausula + Chr (255)
					if numclausulas = 0 Then Print "ERROR: empty clausule": terminado = -1
					estado = 1
				case "END":
					if estado = 0 then
					terminado = -1
					end if	
			end select
		else
			' Leyendo acciones
			Select Case listaPalabras (0)
				Case "SET":
					Select Case listaPalabras (1)
						Case "ITEM":
							clausula = clausula + Chr (&H0) + Chr (pval (listaPalabras (2))) + chr (pval (listaPalabras (4)))
							actionsUsed (&H0) = -1
						Case "FLAG":
							clausula = clausula + Chr (&H1) + Chr (pval (listaPalabras (2))) + chr (pval (listaPalabras (4)))	
							actionsUsed (&H1) = -1
						Case "TILE":
							clausula = clausula + Chr (&H20) + Chr (pval (listaPalabras (3))) + Chr (pval (listaPalabras (5))) + Chr (pval (listaPalabras (8)))
							actionsUsed (&H20) = -1
					End Select
				Case "INC":
					Select Case listaPalabras (1)
						Case "FLAG":
							clausula = clausula + Chr (&H10) + Chr (pval (listaPalabras (2))) + chr (pval (listaPalabras (4)))	
							actionsUsed (&H10) = -1
						Case "LIFE":
							clausula = clausula + Chr (&H30) + Chr (pval (listaPalabras (2)))
							actionsUsed (&H30) = -1
						Case "OBJECTS":
							clausula = clausula + Chr (&H40) + Chr (pval (listaPalabras (2)))
							actionsUsed (&H40) = -1
					End Select
				Case "DEC":
					Select Case listaPalabras (1)
						Case "FLAG":
							clausula = clausula + Chr (&H11) + Chr (pval (listaPalabras (2))) + chr (pval (listaPalabras (4)))						
							actionsUsed (&H11) = -1
						Case "LIFE":
							clausula = clausula + Chr (&H31) + Chr (pval (listaPalabras (2)))
							actionsUsed (&H31) = -1
						Case "OBJECTS":
							clausula = clausula + Chr (&H41) + Chr (pval (listaPalabras (2)))
							actionsUsed (&H41) = -1
					End Select
				Case "ADD":
					clausula = clausula + Chr (&H12) + Chr (pval (listaPalabras (2))) + chr (pval (listaPalabras (4)))						
					actionsUsed (&H12) = -1
				Case "SUB":
					clausula = clausula + Chr (&H13) + Chr (pval (listaPalabras (2))) + chr (pval (listaPalabras (4)))						
					actionsUsed (&H13) = -1
				Case "SWAP":
					clausula = clausula + Chr (&H14) + Chr (pval (listaPalabras (1))) + chr (pval (listaPalabras (3)))
					actionsUsed (&H14) = -1
				Case "FLIPFLOP":
					clausula = clausula + Chr (&H15) + Chr (pval (listaPalabras (1)))
					actionsUsed (&H15) = -1					
				Case "FLICKER":
					clausula = clausula + Chr (&H32)
					actionsUsed (&H32) = -1
				Case "DIZZY":
					clausula = clausula + Chr (&H33)
					actionsUsed (&H33) = -1
				Case "PRINT_TILE_AT":
					clausula = clausula + Chr (&H50) + Chr (pval (listaPalabras (2))) + Chr (pval (listaPalabras (4))) + Chr (pval (listaPalabras (7)))
					actionsUsed (&H50) = -1
				Case "SET_FIRE_ZONE":
					clausula = clausula + Chr (&H51) + Chr (pval (listaPalabras (1))) + Chr (pval (listaPalabras (3))) + Chr (pval (listaPalabras (5))) + Chr (pval (listaPalabras (7)))
					actionsUsed (&H51) = -1
				Case "SHOW_COINS":
					clausula = clausula + Chr (&H60)
					actionsUsed (&H60) = -1
				Case "HIDE_COINS":
					clausula = clausula + Chr (&H61)
					actionsUsed (&H61) = -1
				Case "ENABLE_KILL_SLOWLY"
					clausula = clausula + Chr (&H62)
					actionsUsed (&H62) = -1
				Case "DISABLE_KILL_SLOWLY"
					clausula = clausula + Chr (&H63)
					actionsUsed (&H63) = -1
				Case "ENABLE_TYPE_6"
					clausula = clausula + Chr (&H64)
					actionsUsed (&H64) = -1
				Case "DISABLE_TYPE_6"
					clausula = clausula + Chr (&H65)
					actionsUsed (&H65) = -1
				Case "ENABLE_MAKE_TYPE_6"
					clausula = clausula + Chr (&H66)
					actionsUsed (&H66) = -1
				Case "DISABLE_MAKE_TYPE_6"
					clausula = clausula + Chr (&H67)
					actionsUsed (&H67) = -1
				Case "REDRAW"
					clausula = clausula + Chr (&H6E)
					actionsUsed (&H6E) = -1
				Case "REENTER"
					clausula = clausula + Chr (&H6F)
					actionsUsed (&H6F) = -1
				Case "WARP_TO"
					clausula = clausula + Chr (&H6D) + Chr (pval (listaPalabras (1))) + Chr (pval (listaPalabras (3))) + Chr (pval (listaPalabras (5)))
					actionsUsed (&H6D) = -1
				Case "REPOSTN"
					clausula = clausula + Chr (&H6C) + Chr (pval (listaPalabras (1))) + Chr (pval (listaPalabras (3)))
					actionsUsed (&H6C) = -1
				Case "SETX"
					clausula = clausula + Chr (&H6B) + Chr (pval (listaPalabras (1)))
					actionsUsed (&H6B) = -1
				Case "SETY"
					clausula = clausula + Chr (&H6A) + Chr (pval (listaPalabras (1)))
					actionsUsed (&H6A) = -1						
				Case "SET_TIMER"
					clausula = clausula + Chr (&H70) + Chr (pval (listaPalabras (1))) + Chr (pval (listaPalabras (3)))
					actionsUsed (&H70) = -1
				Case "TIMER_START"
					clausula = clausula + Chr (&H71)
					actionsUsed (&H71) = -1
				Case "TIMER_STOP"
					clausula = clausula + Chr (&H72)
					actionsUsed (&H72) = -1
				Case "NEXT_LEVEL":
					clausula = clausula + Chr (&HD0)
					actionsUsed (&HD0) = -1
				Case "SOUND":
					clausula = clausula + Chr (&HE0) + Chr (pval (listaPalabras (1)))
					actionsUsed (&HE0) = -1
				Case "SHOW":
					clausula = clausula + Chr (&HE1)
					actionsUsed (&HE1) = -1
				Case "RECHARGE":
					clausula = clausula + Chr (&HE2)
					actionsUsed (&HE2) = -1
				Case "TEXT":
					clausula = clausula + Chr (&HE3)
					for ai = 1 To Len (listaPalabras (1))
						if ai = 31 Then Exit For
						If Mid (listaPalabras (1), ai, 1) = "_" Then
							clausula = clausula + Chr (0)
						Else
							clausula = clausula + Chr (Asc(Mid (listaPalabras (1), ai, 1)) - 32)
						End If
					Next ai
					clausula = clausula + Chr (&HEE)
					actionsUsed (&HE3) = -1
				Case "EXTERN":
					clausula = clausula + Chr (&HE4) + Chr (Pval (listaPalabras (1)))
					actionsUsed (&HE4) = -1
				Case "PAUSE":
					clausula = clausula + Chr (&HE5) + Chr (Pval (listaPalabras (1)))
					actionsUsed (&HE5) = -1
				Case "MUSIC"
					clausula = clausula + Chr (&HE6) + Chr (Pval (listaPalabras (1)))
					actionsUsed (&HE6) = -1
				Case "REDRAW_ITEMS"
					clausula = clausula + Chr (&HE7)
					actionsUsed (&HE7) = -1
				Case "GAME":
					clausula = clausula + Chr (240)
					actionsUsed (240) = -1
				Case "WIN":
					clausula = clausula + Chr (241)
					actionsUsed (241) = -1
				Case "END":
					clausula = clausula + Chr (255)
					clausula = Chr (len (clausula)) + clausula
					clausulas = clausulas + clausula
					numclausulas = 0
					estado = 0
					clausula = ""
			End Select
		End if
	wend
	procesaClausulas = Clausulas + Chr (255)
End Function

Dim f As Integer
Dim i As Integer
Dim nPant As Integer
Dim linea As String
Dim clausulas As String
dim o as String

Dim inFileName As String
Dim outFileName As String
Dim maxpants As Integer

' TODO: Comprobación de la entrada
'inFileName = "test.spt"
'outFileName = "msc.h"
inFileName = command (1)
outFileName = command (2)
maxpants = pval (command (3))

if command (1) = "" or command (2) = "" or maxpants = 0 then
	print "msc 4.7 / 3.99.3c"
	print "uso: msc input output maxpants"
	system
end if

maxItem = 0
maxFlag = 0
maxNPant = 0

For i = 0 to LIST_CLAUSULES_SIZE
	listaClausulasEnter (i) = -1
	listaClausulasFire (i) = -1
Next i

' Abrimos el archivo de entrada
f = Freefile
Open inFileName for input as #f

' Esto es una máquina de estados.

While not eof (f)

	Line input #f, linea
	linea = Trim (linea, Any chr (32) + chr (9))
	stringToArray (linea)
	
	' ESTADO 1: Buscando ENTERING SCREEN x ó PRESS_FIRE AT SCREEN x
	Select Case listaPalabras (0)
		Case "ITEMSET":
			procesaItems f
		Case "ENTERING":
			If listaPalabras (1) = "GAME" Then
				AddToIdx = 1
				AddTo (0) = maxpants
			ElseIf listaPalabras (1) = "ANY" Then
				AddToIdx = 1
				AddTo (0) = maxpants + 1
			Else
				AddToIdx = 0
				For i = 2 to LIST_WORDS_SIZE
					If listaPalabras (i) <> "" And listaPalabras (i) <> "," Then
						AddTo (AddToIdx) = val (listaPalabras (i))
						AddToIdx = AddToIdx + 1
					End If
				Next i
			End If
			clausulas = procesaClausulas (f, 0)
			
			clausulasEnter (clausulasEnterIdx) = clausulas	
			For i = 0 To AddToIdx - 1
				'?AddTo(i) ;"->";clausulasEnterIdx
				listaClausulasEnter (AddTo(i)) = clausulasEnterIdx
			Next i
					
			clausulasEnterIdx = clausulasEnterIdx + 1
		Case "ON_TIMER_OFF":
			clausulas = procesaClausulas (f, 0)
			clausulasEnter (clausulasEnterIdx) = clausulas
			listaClausulasEnter (maxpants + 2) = clausulasEnterIdx
			clausulasEnterIdx = clausulasEnterIdx + 1
			
		Case "PRESS_FIRE":
			If listaPalabras (2) = "ANY" Then
				AddToIdx = 1
				AddTo (0) = maxpants
			Else
				AddToIdx = 0
				For i = 3 to LIST_WORDS_SIZE
					If listaPalabras (i) <> "" And listaPalabras (i) <> "," Then
						AddTo (AddToIdx) = val (listaPalabras (i))
						AddToIdx = AddToIdx + 1
					End If
				Next i
			End If
			clausulas = procesaClausulas (f, 0)
			clausulasFire (clausulasFireIdx) = clausulas
			
			For i = 0 To AddToIdx - 1
				listaClausulasFire (AddTo(i)) = clausulasFireIdx
			Next i
			
			clausulasFireIdx = clausulasFireIdx + 1
		Case "PLAYER_GETS_COIN":
			clausulas = procesaClausulas (f, 0)
			clausulasFire (clausulasFireIdx) = clausulas
			listaClausulasFire (maxpants + 1) = clausulasFireIdx
			clausulasFireIdx = clausulasFireIdx + 1
		
		Case "PLAYER_KILLS_ENEMY":
			clausulas = procesaClausulas (f, 0)
			clausulasFire (clausulasFireIdx) = clausulas
			listaClausulasFire (maxpants + 2) = clausulasFireIdx
			clausulasFireIdx = clausulasFireIdx + 1
		
	End Select
	

'For i = 0 to maxpants + 2
'	? listaClausulasEnter (i);",";
'next i
'?	
	
Wend

' Fin
Close #f

' Y cuando tenemos todo esto lleno, tenemos que sacar 
' el código que interpreta los scripts y los scripts
' en sí en #asm con etiquetas y luego un array de etiquetas.

' Esta es, en realidad, la parte complicada y eso. Pero
' tampoco es demasiado moco de pavo.

f = FreeFile
open "msc-config.h" for output as #f

print #f, "// msc-config.h"
print #f, "// Generado por Mojon Script Compiler de la Churrera 4.7 / 3.99.3c"
print #f, "// Copyleft 2013 The Mojon Twins"
print #f, " "
If maxItem > 0 then
	print #f, "#define MSC_MAXITEMS " & str (maxitem)
	print #f, "#define FLAG_SLOT_SELECTED " & slotFlag 
	print #f, "#define ITEM_SLOT_SELECTED " & itemFlag
	print #f, " "
	print #f, "unsigned char items [MSC_MAXITEMS];"
	print #f, "unsigned char its_it, its_p;"
	print #f, " "
	
	' Generate display_items
	If itemSetOr = 0 Then
		' Horizontal
		print #f, "void display_items (void) {"
		print #f, "    its_p = " & itemSetX & ";"
		print #f, "    for (its_it = 0; its_it < MSC_MAXITEMS; its_it ++) {"
		print #f, "        draw_coloured_tile (its_p, " & itemSetY & ", items [its_it]);"
		print #f, "        if (its_it != flags [FLAG_SLOT_SELECTED]) {"
		print #f, "            sp_PrintAtInv (" & (itemSetY + 2) & ", its_p, 0, 0);"
		print #f, "            sp_PrintAtInv (" & (itemSetY + 2) & ", its_p + 1, 0, 0);"
		print #f, "        } else {"
		print #f, "            sp_PrintAtInv (" & (itemSetY + 2) & ", its_p, " & itemSelectClr & ", " & itemSelectC1 & ");"
		print #f, "            sp_PrintAtInv (" & (itemSetY + 2) & ", its_p + 1, " & itemSelectClr & ", " & itemSelectC2 & ");"
		print #f, "        }"
		print #f, "        its_p += " & itemSetStep & ";"
		print #f, "    }"
		print #f, "}"
	Else
		' Vertical
		print #f, "void display_items (void) {"
		print #f, "    its_p = " & itemSetY & ";"
		print #f, "    for (its_it = 0; its_it < MSC_MAXITEMS; its_it ++) {"
		print #f, "        draw_coloured_tile (" & itemSetY & ", its_p, items [its_it]);"
		print #f, "        if (its_it != flags [FLAG_SLOT_SELECTED]) {"
		print #f, "            sp_PrintAtInv (its_p + 2, " & itemSetX & ", 0, 0);"
		print #f, "            sp_PrintAtInv (its_p + 2, " & (itemSetX + 1) & ", 0, 0);"
		print #f, "        } else {"
		print #f, "            sp_PrintAtInv (its_p + 2, " & itemSetX & ", " & itemSelectClr & ", " & itemSelectC1 & ");"
		print #f, "            sp_PrintAtInv (its_p + 2, " & (itemSetX + 1) & ", " & itemSelectClr & ", " & itemSelectC2 & ");"
		print #f, "        }"
		print #f, "        its_p += " & itemSetStep & ";"
		print #f, "    }"
		print #f, "}"
	End If
	
	' Search item
	print #f, "unsigned char search_item (unsigned char t) {"
	print #f, "    for (its_it = 0; its_it < MSC_MAXITEMS; its_it ++) {"
	print #f, "        if (items [its_it] == t) return 1;"
	print #f, "    }"
	print #f, "    return 0;"
	print #f, "}"
	
end if
print #f, " "
print #f, "unsigned char script_result = 0;"
print #f, "unsigned char script_something_done = 0;"
print #f, " "
close #f

open outFileName for output as #f
print #f, "// msc.h"
print #f, "// Generado por Mojon Script Compiler de la Churrera"
print #f, "// Copyleft 2011 The Mojon Twins"
print #f, " "
print #f, "// Script data & pointers"

for i = 0 to clausulasEnterIdx - 1
	print #f, "extern unsigned char mscce_"+trim(str(i))+" [];"
Next i
	
For i = 0 To clausulasFireIdx - 1
	print #f, "extern unsigned char msccf_"+trim(str(i))+" [];"
next i

print #f, " "
print #f, "unsigned char *e_scripts [] = {"
o = ""
for i = 0 to maxpants + 2
	if listaClausulasEnter (i) <> -1 Then
		o = o + "mscce_"+trim(str(listaClausulasEnter (i)))
	else
		o = o + "0"
	end if
	if i < maxpants + 2 then o = o +", "
next i
print #f, "    " + o
print #f, "};"

print #f, " "
print #f, "unsigned char *f_scripts [] = {"
o = ""
for i = 0 to maxpants + 2
	if listaClausulasFire (i) <> -1 Then
		o = o + "msccf_"+trim(str(listaClausulasFire (i)))
	else
		o = o + "0"
	end if
	if i < maxpants + 2 then o = o +", "
next i
print #f, "    " + o
print #f, "};"

print #f, " "
print #f, "#asm"
For i = 0 to clausulasEnterIdx - 1
	print #f, "._mscce_" + Trim (Str (i))
	'print #f, "    defb " + writeMe (clausulasEnter (i))
	writeMeNice f, clausulasEnter (i)
Next i
For i = 0 To clausulasFireIdx - 1
	print #f, "._msccf_" + Trim (Str (i))
	'print #f, "    defb " + writeMe (clausulasFire (i))
	writeMeNice f, clausulasFire (i)
Next i

print #f, "#endasm"

print #f, " "
print #f, "unsigned char *script;"
print #f, " "
print #f, "void msc_init_all (void) {"
print #f, "    unsigned char i;"
If maxItem > 0 then
print #f, "    for (i = 0; i < MSC_MAXITEMS; i ++)"
print #f, "        items [i] = 0;"
End If
print #f, "    for (i = 0; i < MAX_FLAGS; i ++)"
print #f, "        flags [i] = 0;"
print #f, "}"
print #f, " "
print #f, "unsigned char read_byte (void) {"
print #f, "    unsigned char c;"
print #f, "    c = script [0];"
print #f, "    script ++;"
print #f, "    return c;"
print #f, "}"
print #f, " "
print #f, "unsigned char read_vbyte (void) {"
print #f, "    unsigned char c;"
print #f, "    c = read_byte ();"
print #f, "    if (c & 128) return flags [c & 127];"
print #f, "    return c;"
print #f, "}"
print #f, " "
print #f, "// Ejecutamos el script apuntado por *script:"
print #f, "void run_script (void) {"
print #f, "    unsigned char terminado = 0;"
print #f, "    unsigned char continuar = 0;"
print #f, "    unsigned char x, y, n, m, c;"
print #f, "    unsigned char *next_script;"
print #f, " "
print #f, "    if (script == 0)"
print #f, "        return; "
print #f, " "
print #f, "    script_something_done = 0;"
print #f, " "
print #f, "    while (1) {"
print #f, "        c = read_byte ();"
print #f, "        if (c == 0xFF) break;"
print #f, "        next_script = script + c;"
print #f, "        terminado = continuar = 0;"
If maxItem > 0 then
	print #f, "        flags [" & itemFlag & "] = items [flags [" & slotFlag & "]];"
End If
print #f, "        while (!terminado) {"
print #f, "            c = read_byte ();"
print #f, "            switch (c) {"

if clausulasUsed (&H1) Then
	print #f, "                case 0x01:"
	print #f, "                    // IF PLAYER_HAS_ITEM x"
	print #f, "                    // Opcode: 01 x"
	print #f, "                    terminado = (!search_item (read_vbyte ()));"
	print #f, "                    break;"
end if

if clausulasUsed (&H2) Then
	print #f, "                case 0x02:"
	print #f, "                    // IF PLAYER_HASN'T_ITEM x"
	print #f, "                    // Opcode: 02 x"
	print #f, "                    terminado = (search_item (read_vbyte ()));"
	print #f, "                    break;"
end if

If clausulasUsed (&H3) Then
	print #f, "                case 0x03:"
	print #f, "                    // IF ITEM x = n"
	print #f, "                    // Opcode: 03 x n"
	print #f, "                    terminado = items [read_vbyte ()] != read_vbyte ();"
	print #f, "                    break;"
End If

If clausulasUsed (&H4) Then
	print #f, "                case 0x04:"
	print #f, "                    // IF ITEM x <> n"
	print #f, "                    // Opcode: 04 x n"
	print #f, "                    terminado = items [read_vbyte ()] == read_vbyte ();"
	print #f, "                    break;"
End If

if clausulasUsed (&H10) Then
	print #f, "                case 0x10:"
	print #f, "                    // IF FLAG x = n"
	print #f, "                    // Opcode: 10 x n"
	print #f, "                    x = read_vbyte ();"
	print #f, "                    n = read_vbyte ();"	
	print #f, "                    terminado = (flags [x] != n);"
	print #f, "                    break;"
end if

if clausulasUsed (&H11) Then
	print #f, "                case 0x11:"
	print #f, "                    // IF FLAG x < n"
	print #f, "                    // Opcode: 11 x n"
	print #f, "                    x = read_vbyte ();"
	print #f, "                    n = read_vbyte ();"	
	print #f, "                    terminado = (flags [x] >= n);"
	print #f, "                    break;"
end if

if clausulasUsed (&H12) Then
	print #f, "                case 0x12:"
	print #f, "                    // IF FLAG x > n"
	print #f, "                    // Opcode: 12 x n"
	print #f, "                    x = read_vbyte ();"
	print #f, "                    n = read_vbyte ();"	
	print #f, "                    terminado = (flags [x] <= n);"
	print #f, "                    break;"
end if

if clausulasUsed (&H13) Then
	print #f, "                case 0x13:"
	print #f, "                    // IF FLAG x <> n"
	print #f, "                    // Opcode: 13 x n"
	print #f, "                    x = read_vbyte ();"
	print #f, "                    n = read_vbyte ();"	
	print #f, "                    terminado = (flags [x] == n);"
	print #f, "                    break;"
end if

if clausulasUsed (&H14) Then
	print #f, "                case 0x14:"
	print #f, "                    // IF FLAG x = FLAG y"
	print #f, "                    // Opcode: 14 x n"
	print #f, "                    x = read_vbyte ();"
	print #f, "                    y = read_vbyte ();"	
	print #f, "                    terminado = (flags [x] != flags [y]);"
	print #f, "                    break;"
end if

if clausulasUsed (&H15) Then
	print #f, "                case 0x15:"
	print #f, "                    // IF FLAG x < FLAG y"
	print #f, "                    // Opcode: 15 x n"
	print #f, "                    x = read_vbyte ();"
	print #f, "                    y = read_vbyte ();"	
	print #f, "                    terminado = (flags [x] >= flags [y]);"
	print #f, "                    break;"
end if

if clausulasUsed (&H16) Then
	print #f, "                case 0x16:"
	print #f, "                    // IF FLAG x > FLAG y"
	print #f, "                    // Opcode: 16 x n"
	print #f, "                    x = read_vbyte ();"
	print #f, "                    y = read_vbyte ();"	
	print #f, "                    terminado = (flags [x] <= flags [y]);"
	print #f, "                    break;"
end if

if clausulasUsed (&H17) Then
	print #f, "                case 0x17:"
	print #f, "                    // IF FLAG x <> FLAG y"
	print #f, "                    // Opcode: 17 x n"
	print #f, "                    x = read_vbyte ();"
	print #f, "                    y = read_vbyte ();"	
	print #f, "                    terminado = (flags [x] == flags [y]);"
	print #f, "                    break;"
end if

if clausulasUsed (&H20) Then
	print #f, "                case 0x20:"
	print #f, "                    // IF PLAYER_TOUCHES x, y"
	print #f, "                    // Opcode: 20 x y"
	print #f, "                    x = read_vbyte ();"
	print #f, "                    y = read_vbyte ();"	
	print #f, "                    terminado = (!((player.x >> 6) >= (x << 4) - 15 && (player.x >> 6) <= (x << 4) + 15 && (player.y >> 6) >= (y << 4) - 15 && (player.y >> 6) <= (y << 4) + 15));"
	print #f, "                    break;"
end if

if clausulasUsed (&H21) Then
	print #f, "                case 0x21:"
	print #f, "                    // IF PLAYER_IN_X x1, x2"
	print #f, "                    // Opcode: 21 x1 x2"
	print #f, "                    x = read_byte ();"
	print #f, "                    y = read_byte ();"	
	print #f, "                    terminado = (!((player.x >> 6) >= x && (player.x >> 6) <= y));"
	print #f, "                    break;"
end if
	
if clausulasUsed (&H22) Then
	print #f, "                case 0x22:"
	print #f, "                    // IF PLAYER_IN_Y y1, y2"
	print #f, "                    // Opcode: 22 y1 y2"
	print #f, "                    x = read_byte ();"
	print #f, "                    y = read_byte ();"	
	print #f, "                    terminado = (!((player.y >> 6) >= x && (player.y >> 6) <= y));"
	print #f, "                    break;"
end if

if clausulasUsed (&H30) Then
	print #f, "                case 0x30:"
	print #f, "                    // IF ALL_ENEMIES_DEAD"
	print #f, "                    // Opcode: 30"
	print #f, "                    terminado = (player.killed != BADDIES_COUNT);"
	print #f, "                    break;"
end if

if clausulasUsed (&H31) Then
	print #f, "                case 0x31:"
	print #f, "                    // IF ENEMIES_KILLED_EQUALS n"
	print #f, "                    // Opcode: 31 n"
	print #f, "                    n = read_vbyte ();"
	print #f, "                    terminado = (player.killed != n);"
	print #f, "                    break;"
End If

if clausulasUsed (&H40) Then
	print #f, "                case 0x40:"
	print #f, "                     // IF PLAYER_HAS_OBJECTS"
	print #f, "                     // Opcode: 40"
	print #f, "                     terminado = (player.objs == 0);"
	print #f, "                     break;"
End If

If clausulasUsed (&H41) Then
	print #f, "                case 0x41:"
	print #f, "                     // IF OBJECT_COUNT = n"
	print #f, "                     // Opcode: 41 n"
	print #f, "                     n = read_vbyte ();"
	print #f, "                     terminado = (player.objs != n);"
	print #f, "                     break;"
End If

If clausulasUsed (&H50) Then
	print #f, "                case 0x50:"
	print #f, "                     // IF NPANT n"
	print #f, "                     // Opcode: 50 n"
	print #f, "                     n = read_vbyte ();"
	print #f, "                     terminado = (n_pant != n);"
	print #f, "                     break;"
End If

If clausulasUsed (&H51) Then
	print #f, "                case 0x51:"
	print #f, "                     // IF NPANT_NOT n"
	print #f, "                     // Opcode: 51 n"
	print #f, "                     n = read_vbyte ();"
	print #f, "                     terminado = (n_pant == n);"
	print #f, "                     break;"
End If

If clausulasUsed (&H60) Then
	print #f, "                case 0x60:"
	print #f, "                     // IF JUST_PUSHED"
	print #f, "                     // Opcode: 60"
	print #f, "                     terminado = (!just_pushed);"
	print #f, "                     break;"
End If

If clausulasUsed (&H70) Then
	print #f, "                case 0x70:"
	print #f, "                     // IF TIMER >= x"
	print #f, "                     n = read_vbyte ();"
	print #f, "                     terminado = (ctimer.t < n);"
	print #f, "                     break;"
End If

If clausulasUsed (&H71) Then
	print #f, "                case 0x71:"
	print #f, "                     // IF TIMER <= x"
	print #f, "                     n = read_vbyte ();"
	print #f, "                     terminado = (ctimer.t > n);"
	print #f, "                     break;"
End If

If clausulasUsed (&H80) Then
	print #f, "                case 0x80:"
	print #f, "                     // IF LEVEL = n"
	print #f, "                     // Opcode: 80 n"
	print #f, "                     n = read_vbyte ();"
	print #f, "                     terminado = (n != level);"
	print #f, "                     break;"
End If

if clausulasUsed (&HF0) Then
	print #f, "                case 0xF0:"
	print #f, "                     // IF TRUE"
	print #f, "                     // Opcode: F0"
	print #f, "                     break;"
End If

print #f, "                case 0xFF:"
print #f, "                    // THEN"
print #f, "                    // Opcode: FF"
print #f, "                    terminado = 1;"
print #f, "                    continuar = 1;"
print #f, "                    script_something_done = 1;"
print #f, "                    break;"

print #f, "            }"
print #f, "        }"

print #f, "        if (continuar) {"
print #f, "            terminado = 0;"
print #f, "            while (!terminado) {"
print #f, "                c = read_byte ();"
print #f, "                switch (c) {"

if actionsUsed (&H0) Then
	print #f, "                    case 0x00:"
	print #f, "                        // SET ITEM x n"
	print #f, "                        // Opcode: 00 x n"
	print #f, "                        x = read_vbyte ();"
	print #f, "                        n = read_vbyte ();"
	print #f, "                        items [x] = n;"
	print #f, "                        break;"
End If

if actionsUsed (&H1) Then
	print #f, "                    case 0x01:"
	print #f, "                        // SET FLAG x = n"
	print #f, "                        // Opcode: 01 x n"
	print #f, "                        x = read_vbyte ();"
	print #f, "                        n = read_vbyte ();"
	print #f, "                        flags [x] = n;"
	print #f, "                        break;"
End If

if actionsUsed (&H10) Then
	print #f, "                    case 0x10:"
	print #f, "                        // INC FLAG x, n"
	print #f, "                        // Opcode: 10 x n"
	print #f, "                        x = read_vbyte ();"
	print #f, "                        n = read_vbyte ();"
	print #f, "                        flags [x] += n;"
	print #f, "                        break;"
End If

if actionsUsed (&H11) Then
	print #f, "                    case 0x11:"
	print #f, "                        // DEC FLAG x, n"
	print #f, "                        // Opcode: 11 x n"
	print #f, "                        x = read_vbyte ();"
	print #f, "                        n = read_vbyte ();"
	print #f, "                        flags [x] -= n;"
	print #f, "                        break;"
End If

if actionsUsed (&H12) Then
	print #f, "                    case 0x12:"
	print #f, "                        // ADD FLAGS x, y"
	print #f, "                        // Opcode: 12 x y"
	print #f, "                        x = read_vbyte ();"
	print #f, "                        y = read_vbyte ();"
	print #f, "                        flags [x] = flags [x] + flags [y];"
	print #f, "                        break;"
End If

if actionsUsed (&H13) Then
	print #f, "                    case 0x13:"
	print #f, "                        // SUB FLAGS x, y"
	print #f, "                        // Opcode: 13 x y"
	print #f, "                        x = read_vbyte ();"
	print #f, "                        y = read_vbyte ();"
	print #f, "                        flags [x] = flags [x] - flags [y];"
	print #f, "                        break;"
End If

if actionsUsed (&H14) Then
	print #f, "                    case 0x14:"
	print #f, "                        // SWAP FLAGS x, y"
	print #f, "                        // Opcode: 14 x y"
	print #f, "                        x = read_vbyte ();"
	print #f, "                        y = read_vbyte ();"
	print #f, "                        n = flags [x];"
	print #f, "                        flags [x] = flags [y];"
	print #f, "                        flags [y] = n;"
	print #f, "                        break;"
End If

If actionsUsed (&H15) Then
	print #f, "                    case 0x15:"
	print #f, "                        // FLIPFLOP x"
	print #f, "                        // Opcode: 15 sc_x"
	print #f, "                        x = read_vbyte ();"
	print #f, "                        flags [x] = 1 - flags [x];"
	print #f, "                        break;"
End If

if actionsUsed (&H20) Then
	print #f, "                    case 0x20:"
	print #f, "                        // SET TILE (x, y) = n"
	print #f, "                        // Opcode: 20 x y n"
	print #f, "                        x = read_vbyte ();"
	print #f, "                        y = read_vbyte ();"
	print #f, "                        n = read_vbyte ();"
	print #f, "                        map_buff [x + (y << 4) - y] = n;"
	print #f, "                        map_attr [x + (y << 4) - y] = comportamiento_tiles [n];"
	print #f, "                        draw_coloured_tile (VIEWPORT_X + x + x, VIEWPORT_Y + y + y, n);"
	print #f, "                        break;"
End If

if actionsUsed (&H30) Then
	print #f, "                    case 0x30:"
	print #f, "                        // INC LIFE n"
	print #f, "                        // Opcode: 30 n"
	print #f, "                        n = read_vbyte ();"
	print #f, "                        player.life += n;"
	print #f, "                        break;"
End If

if actionsUsed (&H31) Then
	print #f, "                    case 0x31:"
	print #f, "                        // DEC LIFE n"
	print #f, "                        // Opcode: 31 n"
	print #f, "                        n = read_vbyte ();"
	print #f, "                        player.life -= n;"
	print #f, "                        break;"
End If

if actionsUsed (&H32) Then
	print #f, "                    case 0x32:"
	print #f, "                        // FLICKER"
	print #f, "                        // Opcode: 32"
	print #f, "                        player.estado |= EST_PARP;"
	print #f, "                        player.ct_estado = 32;"
	print #f, "                        break;"
End If

if actionsUsed (&H33) Then
	print #f, "                    case 0x33:"
	print #f, "                        // DIZZY"
	print #f, "                        // Opcode: 33"
	print #f, "                        player.estado |= EST_DIZZY;"
	print #f, "                        player.ct_estado = 32;"
	print #f, "                        break;"
End If

if actionsUsed (&H40) Then
	print #f, "                    case 0x40:"
	print #f, "                        // INC OBJECTS n"
	print #f, "                        // Opcode: 40 n"
	print #f, "                        n = read_vbyte ();"
	print #f, "                        player.objs += n;"
	print #f, "                        draw_objs ();"
	print #f, "                        break;"
End If

if actionsUsed (&H41) Then
	print #f, "                    case 0x41:"
	print #f, "                        // DEC OBJECTS n"
	print #f, "                        // Opcode: 41 n"
	print #f, "                        n = read_vbyte ();"
	print #f, "                        player.objs -= n;"
	print #f, "                        draw_objs ();"
	print #f, "                        break;"
End If

if actionsUsed (&H50) then
	print #f, "                    case 0x50:"
	print #f, "                        // PRINT_TILE_AT (X, Y) = N"
	print #f, "                        // Opcode: 50 x y n"
	print #f, "                        x = read_vbyte ();"
	print #f, "                        y = read_vbyte ();"
	print #f, "                        n = read_vbyte ();"
	print #f, "                        draw_coloured_tile (x, y, n);"
	print #f, "                        break;"
end if

if actionsUsed (&H51) Then
	print #f, "                    case 0x51:"
	print #f, "                        // SET_FIRE_ZONE x1, y1, x2, y2"
	print #f, "                        // Opcode: 51 x1 y1 x2 y2"
	print #f, "                        fzx1 = read_byte ();"
	print #f, "                        fzy1 = read_byte ();"
	print #f, "                        fzx2 = read_byte ();"
	print #f, "                        fzy2 = read_byte ();"
	print #f, "                        f_zone_ac = 1;"
	print #f, "                        break;"
End If

if actionsUsed (&H60) Then
	print #f, "                    case 0x60:"
	print #f, "                        // SHOW_COINS"
	print #f, "                        // Opciode: 60"
	print #f, "                        scenery_info.show_coins = 1;"
	print #f, "                        break;"
End If

if actionsUsed (&H61) Then
	print #f, "                    case 0x61:"
	print #f, "                        // HIDE_COINS"
	print #f, "                        // Opcode: 61"
	print #f, "                        scenery_info.show_coins = 0;"
	print #f, "                        break;"
End If

If actionsUsed (&H62) Then
	print #f, "                    case 0x62:"
	print #f, "                        // ENABLE_KILL_SLOWLY"
	print #f, "                        // Opcode: 62"
	print #f, "                        scenery_info.evil_kills_slowly = 1;"
	print #f, "                        break;"
End If

If actionsUsed (&H63) Then
	print #f, "                    case 0x63:"
	print #f, "                        // DISABLE_KILL_SLOWLY"
	print #f, "                        // Opcode: 63"
	print #f, "                        scenery_info.evil_kills_slowly = 0;"
	print #f, "                        break;"
End If

If actionsUsed (&H64) Then
	print #f, "                    case 0x64:"
	print #f, "                        // ENABLE_TYPE_6"
	print #f, "                        // Opcode: 64"
	print #f, "                        scenery_info.allow_type_6 = 1;"
	print #f, "                        break;"
End If

If actionsUsed (&H65) Then
	print #f, "                    case 0x65:"
	print #f, "                        // DISABLE_TYPE_6"
	print #f, "                        // Opcode: 65"
	print #f, "                        scenery_info.allow_type_6 = 0;"
	print #f, "                        break;"
End If

If actionsUsed (&H66) THen 
	print #f, "                    case 0x66:"
	print #f, "                        // ENABLE_MAKE_TYPE_6"
	print #f, "                        // Opcode: 66"
	print #f, "                        scenery_info.make_type_6 = 1;"
	print #f, "                        break;"
End If

If actionsUsed (&H67) THen 
	print #f, "                    case 0x67:"
	print #f, "                        // DISABLE_MAKE_TYPE_6"
	print #f, "                        // Opcode: 67"
	print #f, "                        scenery_info.make_type_6 = 0;"
	print #f, "                        break;"
End If

If actionsUsed (&H6A) Then
	print #f, "                    case 0x6A:"
	print #f, "                        // SETY y"
	print #f, "                        // Opcode: 6B y"
	print #f, "						player.y = read_vbyte () << 10;"
	Print #f, "                        stop_player ();"
	print #f, "                        break;"
End If

If actionsUsed (&H6B) Then
	print #f, "                    case 0x6B:"
	print #f, "                        // SETX x"
	print #f, "                        // Opcode: 6B sc_x"
	print #f, "						player.x = read_vbyte () << 10;"
	Print #f, "                        stop_player ();"
	print #f, "                        break;"
End If

If actionsUsed (&H6C) Then
	print #f, "                    case 0x6C:"
	print #f, "                        // REPOSTN x y"
	print #f, "                        // Opcode: 6C x y"
	print #f, "                        player.x = read_vbyte () << 10;"
	print #f, "                        player.y = read_vbyte () << 10;"
	print #f, "                        player.vx = player.vy = 0;"
	print #f, "                        script_result = 3; terminado = 1;"
	print #f, "                        break;"
End If

If actionsUsed (&H6D) Then
	print #f, "                    case 0x6D:"
	print #f, "                        // WARP_TO n"
	print #f, "                        // Opcode: 6D n"
	print #f, "                        n_pant = read_vbyte ();"
	print #f, "                        player.x = read_vbyte () << 10;"
	print #f, "                        player.y = read_vbyte () << 10;"
	print #f, "                        script_result = 3; terminado = 1;"
	print #f, "                        break;"
End If

if actionsUsed (&H6E) Then
	print #f, "                    case 0x6E:"
	print #f, "                        // REDRAW"
	print #f, "                        // Opcode: 6E"
	print #f, "                        draw_scr_background ();"
	print #f, "                        break;"
End If

if actionsUsed (&H6F) Then
	print #f, "                    case 0x6F:"
	print #f, "                        // REENTER"
	print #f, "                        // Opcode: 6F"
	print #f, "                        script_result = 3; terminado = 1;"
	print #f, "                        break;"
End If

if actionsUsed (&H70) Then
	print #f, "                    case 0x70:"
	print #f, "                        // SET_TIMER a, b"
	print #f, "                        // Opcode: 0x70 a b"
	print #f, "                        ctimer.t = read_vbyte ();"
	print #f, "                        ctimer.frames = read_vbyte ();"
	print #f, "                        ctimer.count = ctimer.zero = 0;"
	print #f, "                        break;"
End If

If actionsUsed (&H71) Then
	print #f, "                    case 0x71:"
	print #f, "                        // TIMER_START"
	print #f, "                        // Opcode: 0x71"
	print #f, "                        ctimer.on = 1;"
	print #f, "                        break;"
End If

If actionsUsed (&H72) Then
	print #f, "                    case 0x72:"
	print #f, "                        // TIMER_START"
	print #f, "                        // Opcode: 0x72"
	print #f, "                        ctimer.on = 0;"
	print #f, "                        break;"
End If

if actionsUsed (&HD0)  Then
	print #f, "                    case 0xD0:"
	print #f, "                        // NEXT_LEVEL"
	print #f, "                        // Opcode: D0"
	print #f, "                        n_pant ++;"
	print #f, "                        init_player_values ();"
	print #f, "                        draw_scr ();"
	print #f, "                        break;"
End If

if actionsUsed (&HE0) Then
	print #f, "                    case 0xE0:"
	print #f, "                        // SOUND n"
	print #f, "                        // Opcode: E0 n"
	print #f, "                        n = read_vbyte ();"
	print #f, "#ifdef MODE_128K"
	print #f, "                        wyz_play_sound (n);"
	print #f, "#else"
	print #f, "                        peta_el_beeper (n);"
	print #f, "#endif"
	print #f, "                        break;"
End If

If actionsUsed (&HE1) Then
	print #f, "                    case 0xE1:"
	print #f, "                        // SHOW"
	print #f, "                        // Opcode: E1"
	print #f, "                        sp_UpdateNow ();"
	print #f, "                        break;"
End If

if actionsUsed (&HE2) Then
	print #f, "                    case 0xE2:"
	print #f, "                        // RECHARGE"
	print #f, "                        player.life = PLAYER_LIFE;"
	print #f, "                        break;"
End If

if actionsUsed (&HE3) Then
	print #f, "                    case 0xE3:"
	print #f, "                        x = 0;"
	print #f, "                        while (1) {"
	print #f, "                           n = read_byte ();"
	print #f, "                           if (n == 0xEE) break;"
	print #f, "                           sp_PrintAtInv (LINE_OF_TEXT, LINE_OF_TEXT_X + x, LINE_OF_TEXT_ATTR, n);"
	print #f, "                           x ++;"
	print #f, "                        }"
	print #f, "                        break;"
End If

if actionsUsed (&HE4) Then
	print #f, "                    case 0xE4:"
	print #f, "                        // EXTERN n"
	print #f, "                        // Opcode: 0xE4 n"
	print #f, "                        n = read_vbyte ();"
	print #f, "                        do_extern_action (n);"
	print #f, "                        break;"
End IF

if actionsUsed (&HE5) Then
	print #f, "                    case 0xE5:"
	print #f, "                        // PAUSE n"
	print #f, "                        n = read_vbyte ();"
	print #f, "                        for (m = 0; m < n; m ++) {"
	print #f, "                            #asm"
	print #f, "                                halt"
	print #f, "                            #endasm"
	print #f, "                        }"
	print #f, "                        break;"
End If

If actionsUsed (&HE6) Then
	print #f, "                    case 0xE6:"
	print #f, "                        // MUSIC n"
	print #f, "#ifdef COMPRESSED_LEVELS"
	print #f, "                        level_data->music_id = read_vbyte ();"
	print #f, "                        wyz_play_music (level_data->music_id);"
	print #f, "#else"
	print #f, "                        wyz_play_music (read_vbyte ());"
	print #f, "#endif"
	print #f, "                        break;"
End If

If actionsUsed (&HE7) Then
	print #f, "                    case 0xE7:"
	print #f, "                        // REDRAW_ITEMS"
	print #f, "                        // Opcode: 0xE7"
	print #f, "                        display_items ();"
	print #f, "                        break;"	
End If

if actionsUsed (&HF0) Then
	print #f, "                    case 0xF0:"
	print #f, "                        script_result = 2;"
	print #f, "                        terminado = 1;"
	print #f, "                        break;"
End If

if actionsUsed (&HF1) Then
	print #f, "                    case 0xF1:"
	print #f, "                        script_result = 1;"
	print #f, "                        terminado = 1;"
	print #f, "                        break;"
End If

print #f, "                    case 0xFF:"
print #f, "                        terminado = 1;"
print #f, "                        break;"
print #f, "                }"
print #f, "            }"
print #f, "        }"
print #f, "        script = next_script;"
print #f, "    }"
print #f, "    if (script_result == 3) {"
print #f, "        script_result = 0;"
print #f, "        draw_scr ();"
print #f, "    }"
print #f, "}"

' Fin
Close #f

' Joer, qué guarrada, pero no veas cómo funciona... Incredibly evil.
' Po eso. 
