;
; CompDirtyAddr
; Alvin Albrecht 01.2003
;

INCLUDE "SPconfig.def"

XLIB SPCompDirtyAddr
LIB SPDirtyChars

; Compute dirty chars address corresponding to a specific
; character coordinate.
;
; enter:  A = row position (0..23)
;         C = col position (0..31/63)
; exit : HL = dirty char address
;         A = 7 - bit position of char within dirty byte
; used : af, bc, de, hl

.SPCompDirtyAddr
   add a,a
   add a,a
IF DISP_HIRES
   add a,a
ENDIF
   ld l,a
   ld h,0                       ; hl = row*cols/8
   ld a,c
   and $07                      ;  a = bit position of char within dirty byte
   srl c
   srl c
   srl c
   ld b,h
   add hl,bc
   ld de,SPDirtyChars
   add hl,de
   ret
