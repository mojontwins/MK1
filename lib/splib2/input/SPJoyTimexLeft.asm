;
; JoyTimexLeft
; Alvin Albrecht 2002
;
; Reads TS2068 left joystick.
;

XLIB SPJoyTimexLeft
LIB SPtmxsetup

; JoyTimexLeft
;
; Reads right side joystick on TS2068. 
; You must make sure the relevant hardware is present 
; or you may get false readings. 
;
; exit:   a = F111RLDU active low 
; uses:   af

.SPJoyTimexLeft
   di                   ; can't allow writes to AY during an isr
   call SPtmxsetup
   ld a,2               ; left joystick
   in a,($f6)           ; FXXXRLDU active low
   or $70
   ei
   ret
