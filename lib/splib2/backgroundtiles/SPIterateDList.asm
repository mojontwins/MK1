;
; IterateDList
; Alvin Albrecht 06.2003
;

INCLUDE "SPconfig.def"

XLIB SPIterateDList
LIB SPCompDListAddr

; IterateDList 
;
; Iterates over display list entries one character at a time for
; characters within a bounding rectangle in row major order, calling
; the hook function for each character.  The hook function is handed
; a pointer to the display list entry on the stack.
;
; Hook function can safely use af,bc,de,hl (the iterator uses
; the exchange set).
;
; enter: IY = user supplied hook address
;         A = row top left corner
;         C = col top left corner
;         D = width
;         E = height
; uses : all except IX, AF'

.SPIterateDList
   push de
   call SPCompDListAddr        ; hl = DList Address
   pop de                      ; d = width, e = height
IF DISP_HIRES
   ld c,4*64
ELSE
   ld c,4*32
ENDIF

.rowloop
   ld b,d                      ; b = width
   push hl                     ; save DList Address at start of row
.colloop
   push hl
   push hl
   exx
   pop hl
   call JPIY                   ; call hook with hl = DList address
   exx
   pop hl
   inc hl
   inc hl
   inc hl
   inc hl                      ; hl = next column's DList address
   djnz colloop
   pop hl                      ; hl = DList at start of row
   add hl,bc                   ; add row displacement
   dec e                       ; finished full height?
   jp nz, rowloop
   ret

.JPIY
   jp (iy)
