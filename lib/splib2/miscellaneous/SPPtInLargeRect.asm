;
; PtInLargeRect
; Alvin Albrecht 03.2003
;

XLIB SPPtInLargeRect
LIB SPPtInIval

; Point In Large Rectangle?
;
; enter:  Rectangle #1:
;
;         ix+0/1   xtop
;         ix+2/3   xbot
;         ix+4/5   xleft
;         ix+6/7   xright
;
;         hl = y coordinate
;         de = x coordinate
;
; exit :  carry = not in rectangle
;
; used :  f, bc, de, hl
;

.SPPtInLargeRect
   push de                ; save x coordinate
   ld c,(ix+0)
   ld b,(ix+1)
   ld e,(ix+2)
   ld d,(ix+3)
   call SPPtInIval        ; is y in [xtop,xbot]?
   pop hl
   ret c                  ; return if fail
   ld c,(ix+4)
   ld b,(ix+5)
   ld e,(ix+6)
   ld d,(ix+7)
   call SPPtInIval        ; is x in [xleft,xright]?
   ret
