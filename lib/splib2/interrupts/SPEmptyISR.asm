;
; Empty ISR routine
; Alvin Albrecht 01.2003
;

XLIB SPEmptyISR

; An empty, do-nothing interrupt service routine for catching
; unknown vectors or for use as a default handler while
; initializing the IM 2 mode.

.SPEmptyISR
   ei
   reti
