;
; Key Pressed?
; Alvin Albrecht 01.2003
;

XLIB SPKeyPressed

; Determines if a key is pressed using the scan code
; returned by "LookupKey".
;
; enter : c = scan row
;         b = key mask
; exit  : carry = key is pressed
; used  : af, b

.SPKeyPressed
   bit 7,b
   jp z, nocaps

   ld a,$fe             ; check on CAPS key
   in a,($fe)
   and $01
   ret nz               ; CAPS not pressed, return no carry = fail

.nocaps
   bit 6,b
   jp z, nosym

   ld a,$7f             ; check on SYM SHIFT
   in a,($fe)
   and $02
   ret nz               ; SYM not pressed, return no carry = fail

.nosym
   ld a,b
   and $1f
   ld b,c
   ld c,$fe
   in b,(c)
   and b
   ret nz               ; key not pressed, return no carry = fail
   scf
   ret
