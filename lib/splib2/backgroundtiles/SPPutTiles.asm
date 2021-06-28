;
; Put Background Tiles
; Alvin Albrecht 07.2003
;

INCLUDE "SPconfig.def"

XLIB SPPutTiles
LIB SPCompDListAddr

; Get Background Tiles
;
; Copy background tiles from a buffer to a rectangle on
; screen.  Inverse of "GetTiles"
;
; enter : hl = source address (buffer)
;          A = row coord of top left corner of rectangle
;          C = col coord of top left corner of rectangle
;          D = width of rectangle
;          E = height of rectangle
; uses  : af, bc, de, hl

.SPPutTiles
   push hl                     ; save source
   push de                     ; save rectangle size
   call SPCompDListAddr        ; hl = DList Address
   pop bc                      ; bc = rectangle size
   pop de                      ; de = source
   ex de,hl                    ; de = DListAddr, hl = source buffer

   ld a,c                      ; a = height
   ld c,$ff
.rowloop
   push bc                     ; save b = width
   push de                     ; save DList address at start of row
.colloop
   ldi                         ; copy tile colour
   ldi                         ; copy tile character
   inc de
   inc de                      ; de = next column's DList address
   djnz colloop
   pop de                      ; de = DList at start of row
IF DISP_HIRES
   inc d
ELSE
   ex de,hl
   ld c,4*32
   add hl,bc                   ; add row displacement
   ex de,hl
ENDIF
   pop bc                      ; restore b = width
   dec a                       ; finished full height?
   jp nz, rowloop
   ret
