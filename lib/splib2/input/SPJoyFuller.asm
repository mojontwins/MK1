;
; JoyFuller
; Alvin Albrecht 2002
;
; Reads Fuller Box joystick.
;

XLIB SPJoyFuller

; JoyFuller
;
; Reads Fuller Box joystick.
; You must make sure the relevant hardware is present 
; or you may get false readings. 
;
; exit:   a = F111RLDU active low 
; uses:   af

.SPJoyFuller
   in a,($7f)        ; FXXXRLDU active low
   or $70
   ret
