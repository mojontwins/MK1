;
; Wait
; Alvin Albrecht 06.2003
;

XLIB SPWait

; Waits a Fixed Period of Time
;
; Measures passed time in interrupts.  Causes death if ints disabled.
;
; enter : bc = ticks
; used  : af, bc

.SPWait
   halt
   dec bc
   ld a,b
   or c
   ret z
   jp SPWait
