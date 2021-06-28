;
; JoyTimexEither
; Alvin Albrecht 9.2003
;

XLIB SPJoyTimexEither
LIB SPtmxsetup

; JoyTimexEither
;
; Reads both joysticks on TS2068, effectively ORing result 
; You must make sure the relevant hardware is present 
; or you may get false readings. 
;
; exit:   a = F111RLDU active low 
; uses:   af

.SPJoyTimexEither
   di                   ; can't allow writes to AY during an isr
   call SPtmxsetup
   ld a,3               ; both joysticks
   in a,($f6)           ; FXXXRLDU active low
   or $70
   ei
   ret
