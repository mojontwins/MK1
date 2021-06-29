;
; Set Tile Array Entry
; Alvin Albrecht 06.2003
;

INCLUDE "SPconfig.def"

XLIB SPTileEntry
LIB SPTileArray

; Associate Address of Graphic with Character Code
;
; enter : de = address of graphic to associate with character code
;          a = character code
; exit  : de = old graphic address
; uses  : af, de, hl

.SPTileEntry
   add a,SPTileArray%256
   ld l,a
   ld h,SPTileArray/256
   jp nc, noinc
   inc h
.noinc
   ld a,(hl)
   ld (hl),e
   ld e,a
   inc h
   ld a,(hl)
   ld (hl),d
   ld d,a
   ret
