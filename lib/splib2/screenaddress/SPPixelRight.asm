;
; PixelRight
; Alvin Albrecht 06.2003
;

INCLUDE "SPconfig.def"
XLIB SPPixelRight

; Pixel Right
;
; Adjusts screen address HL and pixel mask B to move right
; one pixel on screen.
;
; enter: HL = valid screen address
;         B = pixel mask for screen byte
; exit : Carry = moved off screen
;        HL, B moved right one pixel
; used : AF, HL

.SPPixelRight
IF !DISP_HIRES
   rrc b
   ret nc
   inc l
   ld a,l
   and $1f
   ret nz
   scf 
   ret
ELSE
   rrc b
   ret nc
   ld a,h
   xor $20
   ld h,a
   and $20
   ret nz
   inc l
   ld a,l
   and $1f
   ret nz
   scf
   ret
ENDIF
