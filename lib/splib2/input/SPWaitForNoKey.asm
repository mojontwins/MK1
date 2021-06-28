;
; WaitForNoKey
; Alvin Albrecht 2002
;
; Return when no keys are pressed.
;
; uses: af

XLIB SPWaitForNoKey

.SPWaitForNoKey
   xor a
   in a,($fe)
   and $1f
   cp 31
   jr nz, SPWaitForNoKey
   ret
