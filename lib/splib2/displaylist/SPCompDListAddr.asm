;
; CompDListAddr
; Alvin Albrecht 01.2003
;

INCLUDE "SPconfig.def"

XLIB SPCompDListAddr
LIB SPDisplayList

; Compute display list address corresponding to a specific
; character coordinate.
;
; enter:  A = row position (0..23)
;         C = col position (0..31/63)
; exit : HL = display list address
; used : f, b, de, hl

.SPCompDListAddr
IF DISP_HIRES
   ld h,SProtatetbl/256 + 4
ELSE
   ld h,SProtatetbl/256 + 6
ENDIF
   ld l,a
   ld e,(hl)
   inc h
   ld l,(hl)
   ld h,e                        ; hl = row*32 or row*64
   ld b,0
   add hl,bc                     ; hl = row*32 + col
   add hl,hl
   add hl,hl                     ; hl = 4*(row*32 + col)
   ld de,SPDisplayList
   add hl,de
   ret
