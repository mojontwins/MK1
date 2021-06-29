;
; GetCharAddr
; Alvin Albrecht 2002
;

INCLUDE "SPconfig.def"
XLIB SPGetCharAddr

; Get Character Address
;
; Computes the screen address of the top of a character square.
; (0,0) is located at the top left corner of the screen.
;
; enter: h = y coord 0..23, l = x coord 0..31 (0..63 for hi-res mode)
; exit : hl = screen address
; uses : af,c,hl

IF !DISP_HIRES

.SPGetCharAddr
   ld a,h
   rrca
   rrca
   rrca
   and $e0
   or l
   ld l,a
   ld a,h
   and $18
   or $40
   ld h,a
   ret

ELSE

.SPGetCharAddr
   ld a,h
   and $18
   or $40
   srl l
   jr nc, notodd
   or $20

.notodd
   ld c,a
   ld a,h
   rrca
   rrca
   rrca
   and $e0
   or l
   ld l,a
   ld h,c
   ret

ENDIF
