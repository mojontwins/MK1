;
; Set Pallette Array Entry
; Alvin Albrecht 06.2003
;

INCLUDE "SPconfig.def"

XLIB SPPallette
LIB SPTileArray

; Associate Colour with Pallette Entry Code
;
; ONLY VALID FOR HI-COLOUR MODE
;
; enter : de = address of colour array to associate with pallette entry
;          a = pallette entry code
; exit  : de = old colour array
; uses  : af, de, hl

.SPPallette
IF DISP_HICOLOUR
   add a,SPTileArray%256
   ld l,a
   ld h,SPTileArray/256+2
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
ENDIF
   ret
