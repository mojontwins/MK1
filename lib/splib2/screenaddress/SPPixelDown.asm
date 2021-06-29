;
; PixelDown
; Alvin Albrecht 2002
;

INCLUDE "SPconfig.def"
XLIB SPPixelDown

; Pixel Down
;
; Adjusts screen address HL to move one pixel down in the display.
; (0,0) is located at the top left corner of the screen.
;
; enter: HL = valid screen address
; exit : Carry = moved off screen
;        HL = moves one pixel down
; used : AF, HL

.SPPixelDown
   inc h
   ld a,h
   and $07
   ret nz
   ld a,h
   sub $08
   ld h,a
   ld a,l
   add a,$20
   ld l,a
   ret nc
   ld a,h
   add a,$08
   ld h,a
IF DISP_HIRES
   and $18
   cp $18
ELSE
   cp $58
ENDIF
   ccf
   ret
