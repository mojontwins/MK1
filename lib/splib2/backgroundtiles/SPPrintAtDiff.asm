;
; PrintAtDiff
; Alvin Albrecht 01.2003
;

XLIB SPPrintAtDiff
LIB SPCompDListAddr, SPCompDirtyAddr, SPbit2mask, SPtbllookup

; Print Background Bitmap at Character Position, only invalidating
; if the background tile is actually changed.
;
; enter:  A = row position (0..23)
;         C = col position (0..31/63)
;         D = pallette #
;         E = graphic #
; exit : DE = display list address for coordinate
;        HL = dirty chars array address
;         C = mask for dirty char
; used : af, bc, de, hl

.SPPrintAtDiff
   ld b,a
   push bc
   push de
   call SPCompDListAddr         ; hl = display list address for coordinates
   pop de
   pop bc
   ld a,(hl)
   cp d
   jr nz, change1
   inc hl
   ld a,(hl)
   dec hl
   cp e
   jr z, nochange

.back
   inc hl
   ld (hl),e
   dec hl

.nochange
   ld a,b                        ; row, col position
   push hl                       ; save display list addr
   call SPCompDirtyAddr          ; hl = dirty chars array address, a = bit position
   ld de,SPbit2mask
   call SPtbllookup
   ld c,a
   or (hl)
   ld (hl),a                     ; mark char as dirty
   pop de
   ret

.change1
   ld (hl),d
   jp back
