;
; PrintAtInv
; Alvin Albrecht 01.2003
;

XLIB SPPrintAtInv
LIB SPCompDListAddr, SPCompDirtyAddr, SPbit2mask, SPtbllookup

; Print Background Bitmap at Character Position, with invalidation
;
; enter:  A = row position (0..23)
;         C = col position (0..31/63)
;         D = pallette #
;         E = graphic #
; exit : DE = display list address for coordinate
;        HL = dirty array chars address
;         C = dirty char mask
; used : af, bc, de, hl

.SPPrintAtInv
   push de
   call SPCompDListAddr         ; hl = display list address for coordinates
   pop de
   ld (hl),d
   inc hl
   ld (hl),e                    ; store background tile
   dec hl
   push hl
   call SPCompDirtyAddr         ; hl = dirty chars array address, a = bit position
   ld de,SPbit2mask
   call SPtbllookup
   ld c,a
   or (hl)
   ld (hl),a                    ; mark char as dirty
   pop de
   ret
