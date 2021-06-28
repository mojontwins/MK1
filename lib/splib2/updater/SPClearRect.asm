;
; Clear Rectangle
; Alvin Albrecht 01.2003
;

INCLUDE "SPconfig.def"

XLIB SPClearRect
XDEF SPClearRectP
LIB SPCompDListAddr

; Clear Rectangle
;
; Clears a rectangular area on screen.  Background tiles are set to
; DE and any sprites in the area are removed from the display list.
; Does not invalidate the area.
;
; enter:  H = row coord top left corner
;         L = col coord top left corner
;         B = row coord bottom right corner
;         C = col coord bottom right corner
;         D = background tile pallette # (colour)
;         E = background tile graphic #
;        A' = bit 0 is 1 to affect background tile
;             bit 1 is 1 to affect sprites
; uses  : af, bc, de, hl, af'

.SPClearRect
   ld a,b
   sub h
   inc a
   ld b,a               ; b = number of rows
   ld a,c
   sub l
   inc a
   ld c,a               ; c = number of cols

.SPClearRectP
   push bc
   push de
   ld a,h
   ld c,l
   call SPCompDListAddr ; hl = DLIST for top left char
   pop de
   pop bc

.crrowloop
   push bc              ; save row and column count
   push hl              ; save DLIST pointer, first column in row
   ld b,c               ; b = column counter

.crcolloop
   ex af,af'
   bit 0,a
   jp nz, dotile
   inc hl
   jp sprite
.dotile
   ld (hl),d
   inc hl
   ld (hl),e            ; write new background tile into DLIST
.sprite
   inc hl
   bit 1,a
   jp nz, dosprite
   ex af,af'
   jp nosprite
.dosprite
   ex af,af'
   push hl              ; save DLIST pointer
   ld a,(hl)
   or a                 ; is there a sprite here?
   jr z, crnomorespr
   ld (hl),0            ; mark no sprite here
   inc hl

.crrmvsprlp
   ld l,(hl)
   ld h,a               ; hl = char struct + 4
   dec hl
   dec hl               ; hl = char struct + 2
   ld (hl),0            ; mark no previous sprite (not part of linked list)
   ld a,9
   add a,l
   ld l,a
   jp nc, noinc1
   inc h                ; hl = char struct + 11

.noinc1
   ld a,(hl)
   ld (hl),0            ; mark no next sprite in linked list
   inc hl
   or a
   jr nz, crrmvsprlp    ; remove next sprite in linked list too

.crnomorespr
   pop hl               ; restore DLIST pointer
.nosprite
   inc hl
   inc hl               ; hl = DLIST pointer for next column
   djnz crcolloop       ; for all horizontal columns

   pop hl               ; hl = DLIST pointer for start of this row
IF DISP_HIRES
   ld bc,4*64
ELSE
   ld bc,4*32
ENDIF
   add hl,bc            ; hl = DLIST pointer for start of next row
   pop bc               ; recover current row count, column count
   djnz crrowloop       ; for all rows
   ret
