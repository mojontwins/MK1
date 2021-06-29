;
; PixelLeft
; Alvin Albrecht 06.2003
;

INCLUDE "SPconfig.def"
XLIB SPPixelLeft

; Pixel Left
;
; Adjusts screen address HL and pixel mask B to move left
; one pixel on screen.
;
; enter: HL = valid screen address
;         B = pixel mask for screen byte
; exit : Carry = moved off screen
;        HL, B moved left one pixel
; used : AF, HL

.SPPixelLeft
IF !DISP_HIRES
   rlc b
   ret nc
   ld a,l
   dec l
   and $1f
   ret nz
   scf 
   ret
ELSE
   rlc b
   ret nc
   ld a,h
   xor $20
   ld h,a
   and $20
   ret z
   ld a,l
   dec l
   and $1f
   ret nz
   scf
   ret
ENDIF
