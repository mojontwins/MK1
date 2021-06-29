;
; ScreenStr
; Alvin Albrecht 01.2003
;

XLIB SPScreenStr
LIB SPCompDListAddr

; Return background tile occupying a specific character coordinate
;
; enter:  A = row position (0..23)
;         C = col position (0..31/63)
; exit : HL = display list address for coordinate
;         D = pallette #
;         E = graphic #
; used : af, b, de, hl

.SPScreenStr
   call SPCompDListAddr         ; hl = display list address for coordinates
   ld d,(hl)
   inc hl
   ld e,(hl)                    ; store background tile
   dec hl
   ret
