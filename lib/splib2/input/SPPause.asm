;
; Pause
; Alvin Albrecht 06.2003
;

XLIB SPPause

; Simulates the Basic Pause command.
;
; Measures passed time in interrupts.  Causes death if ints disabled.
;
; enter : bc = ticks
; exit  : carry = exited early because of key press, bc=remaining time
; used  : af, bc

.SPPause
   halt
   dec bc
   ld a,b
   or c
   ret z
   xor a
   in a,($fe)
   and 31
   cp 31
   jr z, SPPause
   scf
   ret
