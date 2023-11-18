If Command (1) = "" Then Print "No file especified": System
Open Command (1) For Binary As #1
? Command (1) & ": " & lof (1) & " bytes"
Close
