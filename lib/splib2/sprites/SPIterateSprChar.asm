;
; IterateSprChar
; Alvin Albrecht 2002
;

XLIB SPIterateSprChar

; IterateSprChar 
;
; Iterates all chars in the sprite in column major order.  The user subroutine 
; is handed a pointer to each char structure in the sprite.  The format of a 
; char struct is defined in the INTERNAL DETAILS section linked from the main page. 
;
; enter: IX = sprite structure address 
;        IY = user supplied subroutine address 
;             user hook can use all registers safely 
;               (af & hl change between calls) 
;             hook routine entered with hl = char struct + 0 
; time : 53 + (108 + hook)*rows*cols 
; used : af, hl, whatever hook uses 
;
; Can be useful for individually colouring the chars of a spectrum mode sprite. 

.SPIterateSprChar
   ld a,6
   defb $dd
   add a,l
   ld l,a
   defb $dd
   ld a,h
   ld h,a
   jp nc, noinc1
   inc h

.noinc1
.iterlp
   ld a,(hl)
   or a
   ret z
   inc hl
   ld l,(hl)
   ld h,a
   push hl
   push hl         ; extra push to simplify C interface
   call JPIY
   pop hl
   pop hl
   jp iterlp

.JPIY
   defb $fd

.JPHL
   jp (hl)
