;
; WaitForKey
; Alvin Albrecht 2002
;
; Return when a key is pressed.
;
; uses: af

XLIB SPWaitForKey

.SPWaitForKey
   xor a
   in a,($fe)
   and 31
   cp 31
   jr z, SPWaitForKey
   ret
