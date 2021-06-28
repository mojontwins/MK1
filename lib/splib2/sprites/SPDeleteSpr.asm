;
; DeleteSpr
; Alvin Albrecht 2002
;

INCLUDE "SPconfig.def"

XLIB SPDeleteSpr
XREF _u_free
XDEF SPdsloop

; DeleteSpr 
;
; Deletes a sprite by returning the memory it uses to the queues.  "RemoveDList" 
; must be called first to ensure that the sprite has been removed from the 
; display list. 
;
; enter: DE = sprite structure address 
; exit : no carry 
;
; Warning: remove sprite from display list before deletion

.SPDeleteSpr
   ld hl,6              ; de = address of struct to delete
   add hl,de            ; hl = address of next char struct in sprite

.loop
   ld b,(hl)
   inc hl
   ld c,(hl)            ; bc = next char struct in sprite
   push bc
   push de
   ld hl,(_u_free)
   call JPHL
   pop de
   pop hl               ; hl = next char struct in sprite

.SPdsloop
   ld e,l
   ld d,h
   ld a,h
   or a
   jp nz, loop
   ret

.JPHL
   jp (hl)
