;
; PrintAt
; Alvin Albrecht 01.2003
;

XLIB SPPrintAt
LIB SPCompDListAddr

; Print Background Bitmap at Character Position, no invalidation
;
; enter:  A = row position (0..23)
;         C = col position (0..31/63)
;         D = pallette #
;         E = graphic #
; exit : HL = display list address for coordinate
; used : af, b, hl

.SPPrintAt
   push de
   call SPCompDListAddr         ; hl = display list address for coordinates
   pop de
   ld (hl),d
   inc hl
   ld (hl),e                    ; store background tile
   dec hl
   ret
